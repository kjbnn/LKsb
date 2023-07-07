{not lazarus}
{$LongStrings On}
// {$A-}
unit cOsFeature;

interface

uses Forms;

var
        ApplicationLoaded : THandle;


function GetComputerName2() : string;
procedure SetEng();
procedure SetRus();
procedure CheckExecute(_load : boolean; _show : boolean);
procedure SelfKill();
procedure RunProgram(   str : string);
function OpenMap(filename : string; _size : DWORD) : pointer;
procedure SaveMemory();
//function SetControllerTime(dt : TDateTime) : string;
function SetControllerTime(sec : DWORD) : string;
function CreateShared(name : string; size : DWORD) : Pointer;

implementation

uses Dialogs,SysUtils,Classes,Unix, BaseUnix, dateutils;

//-----------------------------------------------------------------------------

procedure RunProgram(str : string);
begin
 fpsystem(str);
end;

//-----------------------------------------------------------------------------

procedure SetRus();
begin
end;

//-----------------------------------------------------------------------------

procedure SetEng();
begin
end;

//-----------------------------------------------------------------------------

procedure CheckExecute(_load : boolean; _show : boolean);
begin
end;


procedure SelfKill();
begin
 Application.Terminate;
end;
//-----------------------------------------------------------------------------

function OpenMap(filename : string; _size : DWORD) : pointer;
var
        HandleFile : DWORD;
        p : pointer;
begin
 try
 if(not FileExists(filename)) then
 begin
  with TFileStream.Create(filename,fmCreate) do
  begin
   Size:=_size;
   Free;
  end;
 end;

 HandleFile:=fpopen (filename, O_RDWR, 0);

 p:=Fpmmap(nil,_size,PROT_READ + PROT_WRITE, MAP_SHARED,HandleFile,0);
 if(p=nil) then
 begin
   ShowMessage('TMapFile.Create :: Not create file `'+FileName+'`!');
   halt;
 end;
 Result:=p;
 except
  ShowMessage('Error open '+filename);
 end;
end;

procedure SaveMemory();
begin
// fpmsync(map, MEMORY_SIZE, MS_SYNC));
end;

function SetControllerTime2(dt : TDateTime) : string;
var
   wYear, wMonth, wDay, wDayOfWeek : WORD;
   wHour, wMin, wSec, wMSec : Word;
   tz: timezone;
   tv: timeval;
   ms : int64;
begin
  DecodeDateFully(dt, wYear, wMonth, wDay, wDayOfWeek);
  DecodeTime(dt,wHour,wMin,wSec,wMSec);

  fpgettimeofday(@tv, @tz);

//WriteProt(Format('%d %d %d %d',[tz.tz_minuteswest, tz.tz_dsttime, tv.tv_sec, tv.tv_usec]));

  ms := MilliSecondsBetween(dt,EncodeDateTime(1970,1,1,4,0,0,0)) div 1000;
  Result:=DateTimeToStr(dt)+Format('[%u %u %d]',[ms, tv.tv_sec, tv.tv_sec-ms]);

//  tz.tz_minuteswest := -2;//
//  tz.tz_dsttime := 0;//
  tv.tv_sec := ms; //  00:00, 1  1970
  tv.tv_usec := 00;//
  fpsettimeofday(@tv, @tz);
end;

function GetComputerName2() : string;
var
         s : TStringList;
begin
     try
      s:=TStringList.Create();
      s.LoadFromFile('/etc/hostname');
      Result:=s.Strings[0];
      s.Free;
     except
      Result:='Unknow computer name';
     end;
end;

function SetControllerTime(sec : DWORD) : string;
var
   tz: timezone;
   tv: timeval;
   ms : int64;
begin
  fpgettimeofday(@tv, @tz);
  Result:=DateTimeToStr(UnixToDateTime(sec))+Format('[%u %u %d]',
   [sec, tv.tv_sec, tv.tv_sec-sec]);
  tv.tv_sec := sec; //  00:00, 1  1970
  tv.tv_usec := 00;//
  fpsettimeofday(@tv, @tz);
end;

function CreateShared(name : string; size : DWORD) : Pointer;
var
        FileName : string;
        map : Pointer;
begin
 Result:=nil;
 FileName:='/tmp/'+name;//+'.bin';

 if(not FileExists(filename)) then
 begin
  with TFileStream.Create(filename,fmCreate) do
  begin
   Size:=1024*1024;
   Free;
  end;
 end;

 map:=OpenMap(filename,Size);
// WriteLog(IntToStr(integer(map))+'`'+filename+'`');
 Result:=map;
end;
end.
