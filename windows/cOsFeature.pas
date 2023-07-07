unit cOsFeature;

interface

uses Windows,StdCtrls,Forms;

type ARRAYBYTE = array[0..2] of BYTE;
type PARRAYBYTE = ^ARRAYBYTE;

var
        ApplicationLoaded : THandle;

type
 TOptions = set of (optSymbolicLink,optOverwrite,optRecursive,optDirectory);
 int64rec = packed record
  lo: LongWord;
  hi: LongInt;
end;

const FILE_DOES_NOT_EXIST = DWORD(-1);

procedure CreateHardlink( AFileName, ALinkName: String; options: TOptions );
function ServiceStart(aMachine, aServiceName: string ): boolean;
function ServiceStop(aMachine,aServiceName: string ): boolean;
function ServiceGetStatus(sMachine, sService: string ): DWord;
function GetDosOutput(const CommandLine:string): string;
procedure SetEng();
procedure SetRus();
function  GetComputerName2() : string;
procedure CreateListCOM(cbComPort: TComboBox);
function CreateShared(name : string; size : DWORD) : Pointer;
//procedure SelfKill(form : TForm);
procedure SelfKill();
procedure RunProgramShow(str : string);
procedure RunProgramHide(str : string);
function CreateMapFile(filename : string; size : DWORD) : pointer;
function OpenMap(filename : string; _size : DWORD) : pointer;
function SetControllerTime(dt : TDateTime) : string;
function GetVolumeSerial() : string;

{$Ifdef ISDELPHI}
function ServiceGetStatusStr(sMachine, sService: string ): string;
function KillTasks(ExeFileName: string): integer;
function KillTask(ExeFileName: string): integer;
function GetPidTask(ExeFileName: string): integer;
function MyWinExec(FileName :String; wname : string) : Thandle;
function GetMACAddress: string;
function _GetExcelPath() : string;
{$EndIf}

implementation

uses
{$Ifdef ISDELPHI}
 Tlhelp32,WinSvc,
{$EndIf}
 Dialogs,Messages,SysUtils,Classes, Registry,NB30;

const EXCEPTION_EXECUTE_HANDLER=       1;
const EXCEPTION_CONTINUE_SEARCH=       0;
const EXCEPTION_CONTINUE_EXECUTION=   -1;

const SEM_FAILCRITICALERRORS      =$0001;
const SEM_NOGPFAULTERRORBOX       =$0002;
const SEM_NOALIGNMENTFAULTEXCEPT  =$0004;
const SEM_NOOPENFILEERRORBOX      =$8000;


//----------------------------------------------------------------------------

function WriteProtectedMemory(BaseAddress, Buffer: Pointer; Size: Cardinal; out WrittenBytes: Cardinal): Boolean;
var
  OldProtect, Dummy: Cardinal;
begin
  WrittenBytes := 0;
  if Size > 0 then
  begin
    Result := VirtualProtect(BaseAddress, Size, PAGE_EXECUTE_READWRITE, OldProtect);
    if Result then
    try
      Move(Buffer^, BaseAddress^, Size);
      WrittenBytes := Size;
      if OldProtect in [PAGE_EXECUTE, PAGE_EXECUTE_READ, PAGE_EXECUTE_READWRITE, PAGE_EXECUTE_WRITECOPY] then
        FlushInstructionCache(GetCurrentProcess, BaseAddress, Size);
    finally
      VirtualProtect(BaseAddress, Size, OldProtect, Dummy);
    end;
  end;
  Result := (WrittenBytes = Size);
end;

//-----------------------------------------------------------------------------

function _GetExcelPath() : string;
var
        regData :  TRegistry;
begin
 Result:='EXCEL.EXE';
 regData := TRegistry.Create;
 
 try
  regData.RootKey := HKEY_CLASSES_ROOT;

  if regData.OpenKey('\Applications\EXCEL.EXE\shell\edit\command', False) then
  begin
   Result:=regData.ReadString('');
   regData.CloseKey;
  end;

 finally
  regData.Free;
 end;
end;

//-----------------------------------------------------------------------------

function GetDosOutput(const CommandLine:string): string;
var
  SA: TSecurityAttributes;
  SI: TStartupInfo;
  PI: TProcessInformation;
  StdOutPipeRead, StdOutPipeWrite: THandle;
  WasOK: Boolean;
  Buffer: array[0..255] of Char;
  BytesRead: Cardinal;
  WorkDir, Line: String;
begin
  Result:='';
  Application.ProcessMessages;
  with SA do
  begin
    nLength := SizeOf(SA);
    bInheritHandle := True;
    lpSecurityDescriptor := nil;
  end;
  // создаём пайп для перенаправления стандартного вывода
  CreatePipe(StdOutPipeRead,  // дескриптор чтения
             StdOutPipeWrite, // дескриптор записи
             @SA,              // аттрибуты безопасности
             0                // количество байт принятых для пайпа - 0 по умолчанию
             );
  try
    // Создаём дочерний процесс, используя StdOutPipeWrite в качестве стандартного вывода,
    // а так же проверяем, чтобы он не показывался на экране.
    with SI do
    begin
      FillChar(SI, SizeOf(SI), 0);
      cb := SizeOf(SI);
      dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      wShowWindow := SW_HIDE;
      hStdInput := GetStdHandle(STD_INPUT_HANDLE); // стандартный ввод не перенаправляем
      hStdOutput := StdOutPipeWrite;
      hStdError := StdOutPipeWrite;
    end;

    // Запускаем компилятор из командной строки
    WorkDir := ExtractFilePath(CommandLine);
//    WasOK := CreateProcess(nil, PChar(CommandLine), nil, nil, True, 0, nil, PChar(WorkDir), SI, PI);

    WasOK := CreateProcess(nil, PChar(CommandLine), nil, nil, True, 0, nil, nil, SI, PI);

    // Теперь, когда дескриптор получен, для безопасности закрываем запись.
    // Нам не нужно, чтобы произошло случайное чтение или запись.
    CloseHandle(StdOutPipeWrite);
    // если процесс может быть создан, то дескриптор, это его вывод
    if not WasOK then
    begin
     Line:='Could not execute '+CommandLine;
     exit;
 //      raise Exception.Create('Could not execute command line!')
    end
    else

      try
        // получаем весь вывод до тех пор, пока DOS-приложение не будет завершено
        Line := '';
        repeat
          // читаем блок символов (могут содержать возвраты каретки и переводы строки)
          WasOK := ReadFile(StdOutPipeRead, Buffer, 255, BytesRead, nil);

          // есть ли что-нибудь ещё для чтения?
          if BytesRead > 0 then
          begin
            // завершаем буфер PChar-ом
            Buffer[BytesRead] := #0;
            // добавляем буфер в общий вывод
            OemToChar(Buffer,Buffer);
            Line := Line + Buffer;
          end;
        until not WasOK or (BytesRead = 0);
        // ждём, пока завершится консольное приложение
        WaitForSingleObject(PI.hProcess, INFINITE);
      finally
        // Закрываем все оставшиеся дескрипторы
        CloseHandle(PI.hThread);
        CloseHandle(PI.hProcess);
      end;
  finally
      result:=Line;
      CloseHandle(StdOutPipeRead);
  end;
end;



procedure RunProgramShow(str : string);
begin
{$Ifdef ISDELPHI}
 WinExec(PChar(str),SW_SHOW);
{$else}
 ExecuteProcess(str,[]);
{$EndIf}
end;

procedure RunProgramHide(str : string);                                    
begin
{$Ifdef ISDELPHI}
 WinExec(PChar(str),SW_HIDE);
{$else}
 ExecuteProcess(str,[]);
{$EndIf}
end;


procedure SetRus();
var
 Layout: array[0.. KL_NAMELENGTH] of char;
begin
 LoadKeyboardLayout( StrCopy(Layout,'00000419'),KLF_ACTIVATE);
end;



procedure SetEng();
var
 Layout: array[0.. KL_NAMELENGTH] of char;
begin
 LoadKeyboardLayout( StrCopy(Layout,'00000409'),KLF_ACTIVATE);
end;



function GetComputerName2() : string;
var
   NameComp : string;
   len : DWORD;
begin
 SetLength(NameComp,128);
 len:=Length(NameComp);
 Windows.GetComputerName(PChar(@NameComp[1]),len);
 SetLength(NameComp,len);
 Result:=AnsiUpperCase(NameComp);
end;



procedure CreateListCOM(cbComPort: TComboBox);
var
  reg : TRegistry;
  ts : TStrings;
  i : integer;
begin
  reg := TRegistry.Create;
  reg.RootKey := HKEY_LOCAL_MACHINE;
  reg.OpenKey('hardware\devicemap\serialcomm',false);
  ts := TStringList.Create;
  reg.GetValueNames(ts);
  for i := 0 to ts.Count -1 do begin
    cbComPort.Items.Add(reg.ReadString(ts.Strings[i]));
  end;
  ts.Free;
  reg.CloseKey;
  reg.free;
  if(cbComPort.Items.Count>0) then cbComPort.ItemIndex:=0
   else
   begin
    cbComPort.Enabled:=false;
   end;
end;

function CreateShared(name : string; size : DWORD) : Pointer;
var
        hMapObject : THANDLE;
        p : Pointer;
        i : DWORD;
        test : PARRAYBYTE;
        fInit : Boolean;
        LastError : DWORD;

begin

 name:=AnsiUpperCase(name);
 hMapObject:= CreateFileMapping(
               QWord(-1), // use paging file
               nil,                // no security attributes
               PAGE_READWRITE,      // read/write access
               0,                   // size: high 32-bits
               size,           // size: low 32-bits
               PChar(name));    // name of map object

            if (hMapObject = 0) then
            begin
             Result :=nil;
             exit;
            end;

            // The first process to attach initializes memory.
            LastError:=GetLastError();
            fInit:= (LastError <> ERROR_ALREADY_EXISTS);

            // Get a pointer to the file-mapped shared memory.
            p := MapViewOfFile(
                hMapObject,     // object to map view of
                FILE_MAP_WRITE, // read/write access
                0,              // high offset:  map from
                0,              // low offset:   beginning
                0);             // default: map entire file
            if (p = nil) then
            begin
             Result :=nil;
             exit;
            end;

            if(fInit=true) then
            begin
             i:=0;
             test:=p;
             while(i<size) do
             begin
//              test[i]:=0;
              pchar(p)[i]:=#0;
              Inc(i);
             end;
            end;

 Result := p;
end;



//procedure SelfKill(form : TForm);
procedure SelfKill();
var
        Pid : DWORD;
        ps : THANDLE;
begin
//  if(form=nil) then Halt;
  while true do
  begin
   try
//    GetWindowThreadProcessId(form.Handle,@Pid);
    Pid:=GetCurrentProcessId();
    ps := OpenProcess(PROCESS_ALL_ACCESS,false,Pid);
    TerminateProcess(ps,DWORD(-1));
    Halt;
   except
    Halt;
   end;
  end;
end;



function CreateMapFile(filename : string; size : DWORD) : pointer;
var
        HandleFile : DWORD;
        HandleMap : DWORD;
        p : pointer;
begin
 Result:=nil;
{$IFDEF UNIX}
 HandleFile:=fpopen (filename, O_RDWR, 0);
 if(HandleFile=-1) then exit;
 p:=Fpmmap(nil,MEMORY_SIZE,PROT_READ + PROT_WRITE, MAP_SHARED,HandleFile,0);
{$ELSE}
 HandleFile:=CreateFile(PChar(FileName),GENERIC_READ or GENERIC_WRITE,FILE_SHARE_WRITE+FILE_SHARE_READ,nil,OPEN_EXISTING,0,0);
 if(HandleFile=INVALID_HANDLE_VALUE) then exit;
 HandleMap:=CreateFileMapping(HandleFile,nil,PAGE_READWRITE,0,0,nil);
 if(HandleMap=0) then  exit;
 p:=MapViewOfFile(HandleMap,FILE_MAP_ALL_ACCESS, 0, 0, 0);
{$ENDIF}
 Result:=p;
end;



function OpenMap(filename : string; _size : DWORD) : pointer;
var
        p : pointer;
begin
 if(not FileExists(filename)) then
 begin
  with TFileStream.Create(filename,fmCreate) do
  begin
   Size:=_size;
   Free;
  end;
 end;

 p:=CreateMapFile(filename,_size);
 if(p=nil) then
 begin
   ShowMessage('OpenMap return nil');
   halt;
 end;
 Result:=p;
end;



//procedure FlushAll();
//begin
// FlushViewOfFile(Map,MEMORY_SIZE);
//end;



{$Ifdef ISDELPHI}

function KillTask(ExeFileName: string): integer;
const
  PROCESS_TERMINATE=$0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
  ps : THANDLE;
begin 

  result := 0;

  FSnapshotHandle := CreateToolhelp32Snapshot 
                     (TH32CS_SNAPPROCESS, 0); 
  FProcessEntry32.dwSize := Sizeof(FProcessEntry32); 
  ContinueLoop := Process32First(FSnapshotHandle, 
                                 FProcessEntry32); 

  while integer(ContinueLoop) <> 0 do 
  begin 
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = 
         UpperCase(ExeFileName)) 
     or (UpperCase(FProcessEntry32.szExeFile) = 
         UpperCase(ExeFileName))) then
         begin
     ps := OpenProcess(PROCESS_ALL_ACCESS	,false,FProcessEntry32.th32ProcessID);
     TerminateProcess(ps,DWORD(-1));

//     Result := Integer(TerminateProcess(OpenProcess(
//                        PROCESS_TERMINATE, BOOL(0),
//                        FProcessEntry32.th32ProcessID), DWORD(-1)));

      end;
    ContinueLoop := Process32Next(FSnapshotHandle,
                                  FProcessEntry32);
  end;

  CloseHandle(FSnapshotHandle);
end;



function GetPidTask(ExeFileName: string): integer;
const
  PROCESS_TERMINATE=$0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin 
  result := 0; 

  FSnapshotHandle := CreateToolhelp32Snapshot 
                     (TH32CS_SNAPPROCESS, 0); 
  FProcessEntry32.dwSize := Sizeof(FProcessEntry32); 
  ContinueLoop := Process32First(FSnapshotHandle, 
                                 FProcessEntry32); 

  while integer(ContinueLoop) <> 0 do 
  begin 
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = 
         UpperCase(ExeFileName)) 
     or (UpperCase(FProcessEntry32.szExeFile) = 
         UpperCase(ExeFileName))) then
         begin
          Result:=FProcessEntry32.th32ProcessID;
          break;
      end;
    ContinueLoop := Process32Next(FSnapshotHandle,
                                  FProcessEntry32);
  end;

  CloseHandle(FSnapshotHandle);
end;



{$EndIf}

function SetControllerTime(dt : TDateTime) : string;
var
        st : SYSTEMTIME;
begin
  DateTimeToSystemTime(dt,st);
  SetLocalTime(st);
  Result:=DateTimeToStr(dt);
end;






function UnhandledExceptionFilter(pExceptionInfo : pointer) : DWORD;
begin
  Result:=EXCEPTION_EXECUTE_HANDLER;
  Halt;
end;



function ServiceStart(aMachine, aServiceName: string ): boolean;
var
  h_manager,h_svc: SC_Handle;
  svc_status: TServiceStatus;
  Temp: PChar;
  dwCheckPoint: DWord;
begin
  svc_status.dwCurrentState := 1;
  h_manager := OpenSCManager(PChar(aMachine), nil, SC_MANAGER_CONNECT);
  if h_manager > 0 then
  begin
    h_svc := OpenService(h_manager, PChar(aServiceName),
    SERVICE_START or SERVICE_QUERY_STATUS);
    if h_svc > 0 then
    begin
      temp := nil;
      if (StartService(h_svc,0,LPPCSTR(temp))) then
        if (QueryServiceStatus(h_svc,svc_status)) then
        begin
          while (SERVICE_RUNNING <> svc_status.dwCurrentState) do
          begin
            dwCheckPoint := svc_status.dwCheckPoint;
            Sleep(svc_status.dwWaitHint);
            if (not QueryServiceStatus(h_svc,svc_status)) then
              break;
            if (svc_status.dwCheckPoint < dwCheckPoint) then
            begin
              // QueryServiceStatus ?? ??????????? dwCheckPoint
              break;
            end;
          end;
        end;
      CloseServiceHandle(h_svc);
    end;
    CloseServiceHandle(h_manager);
  end;
  Result := SERVICE_RUNNING = svc_status.dwCurrentState;
end;



function ServiceStop(aMachine,aServiceName: string ): boolean;
var
  h_manager, h_svc: SC_Handle;
  svc_status: TServiceStatus;
  dwCheckPoint: DWord;
begin
  h_manager:=OpenSCManager(PChar(aMachine),nil, SC_MANAGER_CONNECT);
  if h_manager > 0 then
  begin
    h_svc := OpenService(h_manager,PChar(aServiceName),
    SERVICE_STOP or SERVICE_QUERY_STATUS);
    if h_svc > 0 then
    begin
      if(ControlService(h_svc,SERVICE_CONTROL_STOP, svc_status))then
      begin
        if(QueryServiceStatus(h_svc,svc_status))then
        begin
          while(SERVICE_STOPPED <> svc_status.dwCurrentState)do
          begin
            dwCheckPoint := svc_status.dwCheckPoint;
            Sleep(svc_status.dwWaitHint);
            if(not QueryServiceStatus(h_svc,svc_status))then
            begin
              // couldn't check status
              break;
            end;
            if(svc_status.dwCheckPoint < dwCheckPoint)then
              break;
          end;
        end;
      end;
      CloseServiceHandle(h_svc);
    end;
    CloseServiceHandle(h_manager);
  end;
  Result := SERVICE_STOPPED = svc_status.dwCurrentState;
end;



function ServiceGetStatus(sMachine, sService: string ): DWord;
var
  h_manager, h_svc: SC_Handle;
  service_status: TServiceStatus;
  hStat: DWord;
begin
  hStat := 1;
  h_manager := OpenSCManager(PChar(sMachine) ,nil, SC_MANAGER_CONNECT);
  if h_manager > 0 then
  begin
    h_svc := OpenService(h_manager,PChar(sService), SERVICE_QUERY_STATUS);
    if h_svc > 0 then
    begin
      if(QueryServiceStatus(h_svc, service_status)) then
        hStat := service_status.dwCurrentState;
      CloseServiceHandle(h_svc);
    end;
    CloseServiceHandle(h_manager);
  end;
  Result := hStat;
end;

{$Ifdef ISDELPHI}

function ServiceGetStatusStr(sMachine, sService: string ): string; overload;
var
        status : DWORD;
begin
 Result:='';
 status:=ServiceGetStatus(sMachine,sService);
 case status of
 SERVICE_STOPPED:
  Result:='SERVICE_STOPPED';
 SERVICE_RUNNING:
  Result:='SERVICE_RUNNING';
 SERVICE_PAUSED:
  Result:='SERVICE_PAUSED';
 SERVICE_START_PENDING:
  Result:='SERVICE_START_PENDING';
 SERVICE_STOP_PENDING:
  Result:='SERVICE_STOP_PENDING';
 SERVICE_CONTINUE_PENDING:
  Result:='SERVICE_CONTINUE_PENDING';
 SERVICE_PAUSE_PENDING:
  Result:='SERVICE_PAUSE_PENDING';
 end;
end;



function KillTasks(ExeFileName: string): integer;
const
  PROCESS_TERMINATE=$0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
  pid : DWORD;  
begin
  result := 0;

  FSnapshotHandle := CreateToolhelp32Snapshot
                     (TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle,
                                 FProcessEntry32);

  while integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
         UpperCase(ExeFileName))
     or (UpperCase(FProcessEntry32.szExeFile) =
         UpperCase(ExeFileName))) then
         begin
          Inc(Result);
          pid:=FProcessEntry32.th32ProcessID;
          WinExec(PChar(Format('pskill %d',[pid])),SW_HIDE);
      end;
    ContinueLoop := Process32Next(FSnapshotHandle,
                                  FProcessEntry32);
  end;

  CloseHandle(FSnapshotHandle);
end;



function MyWinExec(FileName :String; wname : string) : Thandle;
var
 zAppName:array[0..512] of char;
 zCurDir:array[0..255] of char;
 WorkDir:String;
 StartupInfo:TStartupInfo;
 ProcessInfo:TProcessInformation;
begin
 StrPCopy(zAppName,FileName);
 GetDir(0,WorkDir);
 StrPCopy(zCurDir,WorkDir);
 FillChar(StartupInfo,Sizeof(StartupInfo),#0);
 StartupInfo.cb := Sizeof(StartupInfo);
 StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
 StartupInfo.wShowWindow := SW_HIDE;//SW_SHOW;
 StartupInfo.lpTitle:=PWideString(WideString(@wname[1]));
 CreateProcess(nil, zAppName, nil, nil, false, CREATE_NEW_CONSOLE or
   NORMAL_PRIORITY_CLASS, nil, zCurDir, StartupInfo, ProcessInfo);
 result := ProcessInfo.hProcess;
end;


function GetAdapterInfo(Lana: Char): string;
var
  Adapter: TAdapterStatus;
  NCB: TNCB;
begin
  FillChar(NCB, SizeOf(NCB), 0);
  NCB.ncb_command := Char(NCBRESET);
  NCB.ncb_lana_num := Lana;
  if Netbios(@NCB) <> Char(NRC_GOODRET) then
  begin
    Result := 'mac not found';
    Exit;
  end;

  FillChar(NCB, SizeOf(NCB), 0);
  NCB.ncb_command := Char(NCBASTAT);
  NCB.ncb_lana_num := Lana;
  NCB.ncb_callname := '*';

  FillChar(Adapter, SizeOf(Adapter), 0);
  NCB.ncb_buffer := @Adapter;
  NCB.ncb_length := SizeOf(Adapter);
  if Netbios(@NCB) <> Char(NRC_GOODRET) then
  begin
    Result := 'mac not found';
    Exit;
  end;
  Result :=
  IntToHex(Byte(Adapter.adapter_address[0]), 2) + '-' +
  IntToHex(Byte(Adapter.adapter_address[1]), 2) + '-' +
  IntToHex(Byte(Adapter.adapter_address[2]), 2) + '-' +
  IntToHex(Byte(Adapter.adapter_address[3]), 2) + '-' +
  IntToHex(Byte(Adapter.adapter_address[4]), 2) + '-' +
  IntToHex(Byte(Adapter.adapter_address[5]), 2);
end;

function GetMACAddress: string;
var
  AdapterList: TLanaEnum;
  NCB: TNCB;
begin
  FillChar(NCB, SizeOf(NCB), 0);
  NCB.ncb_command := Char(NCBENUM);
  NCB.ncb_buffer := @AdapterList;
  NCB.ncb_length := SizeOf(AdapterList);
  Netbios(@NCB);
  if Byte(AdapterList.length) > 0 then
    Result := GetAdapterInfo(AdapterList.lana[0])
  else
    Result := 'mac not found';
end;

function GetVolumeInfo() : string;
var
        VolumeName,
        FileSystemName : array [0..MAX_PATH-1] of Char;
        VolumeSerialNo : DWord;
        MaxComponentLength,
        FileSystemFlags : DWORD;
begin
 GetVolumeInformation('C:\',VolumeName,MAX_PATH,@VolumeSerialNo, MaxComponentLength, FileSystemFlags, FileSystemName,MAX_PATH);
 Result:=VolumeName;
end;

//-----------------------------------------------------------------------------
{$endif}

function GetVolumeSerial() : string;
var
        Buffer  : array [0..255] of char;
        SerialNum : dword;
        a, b : dword;
begin
 Result:='0';
 if GetVolumeInformation('c:\', Buffer, SizeOf(Buffer), @SerialNum, a, b, nil, 0) then
 begin
      try
       Result:=IntToStr(SerialNum);
      except
      end;
 end;
end;

//-----------------------------------------------------------------------------

procedure _CreateHardlink( AFileName : String; AFileWCName : PWideChar; ALinkName: String; overwrite: Boolean );
var
 aLinkWCFileName, aLinkFullName: Array[0..MAX_PATH] of WChar;
 pwFilePart: LPWSTR;
 hFileSource: THandle;
 rStreamId: WIN32_STREAM_ID;
 cbPathLen, dwStreamHeaderSize, dwBytesWritten: DWORD;
 lpContext: Pointer;
begin
 StringToWidechar( ALinkName, aLinkWCFileName, MAX_PATH );
 hFileSource :=
  Windows.CreateFile(
  PChar(AFileName),
  GENERIC_READ or GENERIC_WRITE,
  FILE_SHARE_READ or FILE_SHARE_WRITE or FILE_SHARE_DELETE,
  nil,
  OPEN_EXISTING,
  0,
  0
  );
 if hFileSource=INVALID_HANDLE_VALUE then
  raise Exception.Create('Cannot open file "'+AFileName+'"');
 try
  cbPathLen := Windows.GetFullPathNameW( aLinkWCFileName, MAX_PATH,
  aLinkFullName, pwFilePart );
  if cbPathLen<=0 then
  raise Exception.Create('Invalid link name "'+ALinkName+'"');
  cbPathLen := (cbPathLen+1)*SizeOf(WChar);
  lpContext := nil;
  rStreamId.dwStreamId := BACKUP_LINK;
  rStreamId.dwStreamAttributes := 0;
  rStreamId.dwStreamNameSize := 0;
  int64rec(rStreamId.Size).hi := 0;
  int64rec(rStreamId.Size).lo := cbPathLen;
  dwStreamHeaderSize := PChar(@rStreamId.cStreamName)-PChar(@rStreamId)
  +LongInt(rStreamId.dwStreamNameSize);
  if not BackupWrite(
  hFileSource,
  Pointer(@rStreamId), // buffer to write
  dwStreamHeaderSize, // number of bytes to write
  dwBytesWritten,
  False, // don't abort yet
  False, // don't process security
  lpContext
  ) then RaiseLastOSError;
  if not BackupWrite(
  hFileSource,
  Pointer(@aLinkFullName), // buffer to write
  cbPathLen, // number of bytes to write
  dwBytesWritten,
  False, // don't abort yet
  False, // don't process security
  lpContext
  ) then RaiseLastOSError;
  // free context
  if not BackupWrite(
  hFileSource,
  nil, // buffer to write
  0, // number of bytes to write
  dwBytesWritten,
  True, // abort
  False, // don't process security
  lpContext
  ) then RaiseLastOSError;
 finally
  CloseHandle(hFileSource);
 end;
end;

//-----------------------------------------------------------------------------

procedure CreateHardlink( AFileName, ALinkName: String; options: TOptions );
var
 dwAttributes: DWORD;
 aFileSource : Array[0..MAX_PATH] of WChar;
begin
 dwAttributes := Windows.GetFileAttributes(PChar(AFileName));
 if dwAttributes=FILE_DOES_NOT_EXIST then
  raise Exception.Create('File "'+AFileName+'" does not exist.');
 if (dwAttributes and FILE_ATTRIBUTE_DIRECTORY)<>0 then
  raise Exception.Create('Cannot create hardlink for directory (file "'
  +AFileName+'").');
 dwAttributes := Windows.GetFileAttributes(PChar(ALinkName));
 if dwAttributes<>FILE_DOES_NOT_EXIST then
 begin
  if not(optOverwrite in options) then
  raise Exception.Create('File "'+ALinkName+'" already exists.');
  if (dwAttributes and FILE_ATTRIBUTE_DIRECTORY)<>0 then
  raise Exception.Create('Cannot overwrite directory "'+AFileName+'".');
 end;
 StringToWidechar( AFileName, aFileSource, MAX_PATH );
 _CreateHardlink( AFileName, aFileSource, ALinkName, optOverwrite in options );
end;

//-----------------------------------------------------------------------------

initialization
 {$Ifdef ISDELPHI}
 SetUnhandledExceptionFilter(@UnhandledExceptionFilter);
 {$endif}
 SetErrorMode(SEM_NOGPFAULTERRORBOX);
 DateSeparator:='.';
 TimeSeparator:=':';
 ShortTimeFormat:='hh:mm:ss';
 ShortDateFormat:='dd.mm.yyyy';


end.

