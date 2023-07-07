unit cBufKsb;

interface
uses
{$ifdef IS_WINDOWS}
 Windows,
{$else}
 sema,
 BaseUnix,
{$endif}

 classes, Dialogs, extctrls, Sysutils;

type SHARED_BUFKSB = packed record
 HeadPointer : DWORD;
 EndPointer : DWORD;
 ReadCount  : DWORD;
 ClearFlag : DWORD;
 StrData : array [0..4096*4096] of char;
end;

type PSHARED_BUFKSB = ^SHARED_BUFKSB;

type
  TBufKsb = class(TTimer)
  private
  r : PSHARED_BUFKSB;
  s : PSHARED_BUFKSB;
  {$Ifdef IS_WINDOWS}
  r_mutex : DWORD;
  s_mutex : DWORD;
  {$else}
  r_mutex : pointer;
  s_mutex : pointer;
  {$endif}

  size : DWORD;
  SendList : TStringList;
  function SendInShared(str : string) : boolean;
  public
  AllSend : integer;
  AllReceive : integer;
  constructor Create(AOwner: TComponent); override;
  procedure _Init(sname : string; send : boolean; siz : WORD);
  procedure SendInBuffer(strmes : string);
  function ReceiveString : string;
  procedure SendTimer(Sender: TObject);
  function Clear : integer;
  function ClearReceiveBuf : integer;
  function GetReadCount() : DWORD;
end;

implementation

uses cOsFeature;

//----------------------------------------------------------------------------

function TBufKsb.GetReadCount() : DWORD;
begin
 Result:=s^.ReadCount;
end;

//----------------------------------------------------------------------------

function TBufKsb.ClearReceiveBuf() : integer;
begin
 Result:=0;
 r^.EndPointer:=0;
 r^.HeadPointer:=0;
 r^.ReadCount:=0;
 r^.ClearFlag:=1;
end;

//----------------------------------------------------------------------------

function TBufKsb.Clear() : integer;
begin
 Result:=0;
 r^.EndPointer:=0;
 r^.HeadPointer:=0;
 r^.ReadCount:=0;
 r^.ClearFlag:=1;

 s^.EndPointer:=0;
 s^.HeadPointer:=0;
 s^.ReadCount:=0;
 s^.ClearFlag:=1;
end;

//----------------------------------------------------------------------------

constructor TBufKsb.Create(AOwner: TComponent);
begin
 SendList:=TStringList.Create();
 inherited Create(AOwner);
 Enabled:=false;
 Interval:=10;
 AllSend:=0;
 AllReceive:=0;
 //OnTimer:={$Ifndef ISDELPHI}@{$EndIf}SendTimer;
 OnTimer:= SendTimer;
end;

//----------------------------------------------------------------------------

{$Ifdef IS_WINDOWS}
procedure _WaitMutex(mutex : DWORD);
begin
 WaitForSingleObject(mutex,1000);
end;
{$else}
procedure _WaitMutex(mutex : pointer);
begin
 sem_wait(mutex);
end;
{$endif}



{$Ifdef IS_WINDOWS}
procedure _ReleaseMutex(mutex : DWORD);
begin
 ReleaseMutex(mutex);
end;
{$else}
procedure _ReleaseMutex(mutex : pointer);
begin
 sem_post(mutex);
end;
{$endif}


procedure TBufKsb._Init(sname : string; send : boolean; siz : WORD);
begin
 size:=siz;
 if(send=true) then
 begin
  r:=CreateShared('r'+sname,size);
  s:=CreateShared('s'+sname,size);
{$Ifdef IS_WINDOWS}
  r_mutex:=CreateMutex(nil,false,PChar('rmutex'+sname));
  s_mutex:=CreateMutex(nil,false,PChar('smutex'+sname));
{$else}
 r_mutex:=sem_open(PChar('rmutex'+sname), O_CREAT, $1FF, 1);
 s_mutex:=sem_open(PChar('smutex'+sname), O_CREAT, $1FF, 1);
{$endif}

 end
 else
 begin
  r:=CreateShared('s'+sname,size);
  s:=CreateShared('r'+sname,size);
{$Ifdef IS_WINDOWS}
  s_mutex:=CreateMutex(nil,false,PChar('rmutex'+sname));
  r_mutex:=CreateMutex(nil,false,PChar('smutex'+sname));
{$else}
s_mutex:=sem_open(PChar('rmutex'+sname), O_CREAT, $1FF, 1);
r_mutex:=sem_open(PChar('smutex'+sname), O_CREAT, $1FF, 1);
{$endif}

 end;

 _WaitMutex(s_mutex);
 s^.EndPointer:=0;
 s^.HeadPointer:=0;
 s^.ClearFlag:=0;
 _ReleaseMutex(s_mutex);

 _WaitMutex(r_mutex);
 r^.EndPointer:=0;
 r^.HeadPointer:=0;
 r^.ClearFlag:=0;
 _ReleaseMutex(r_mutex);

 Enabled:=true;
end;

//----------------------------------------------------------------------------

function TBufKsb.ReceiveString() : string;
var
        i : DWORD;
begin
 _WaitMutex(r_mutex);
 Inc(r^.ReadCount);
 Result:='';
 i:=0;
 while r^.EndPointer<>r^.HeadPointer do
 begin

  if(r^.StrData[r^.EndPointer+i]<>#0) then
  begin
   Result:=Result + r^.StrData[r^.EndPointer+i];
   Inc(i);
  end else
  begin
   r^.EndPointer:=r^.EndPointer+i+1;
   Inc(AllReceive);
   _ReleaseMutex(r_mutex);
   exit;
  end;

 end;//while

 r^.EndPointer:=0;
 r^.HeadPointer:=0;
 _ReleaseMutex(r_mutex);
end;

//-----------------------------------------------------------------------------

procedure TBufKsb.SendTimer(Sender: TObject);
var
        str : string;
begin
 if(s^.ClearFlag>0) then
 begin
  SendList.Clear();
  s^.ClearFlag:=0;
  exit;
 end;

 while SendList.Count>0 do
 begin
  str:=SendList.Strings[0];
  if(SendInShared(str)) then
  begin
   SendList.Delete(0);
   Inc(AllSend);
  end else break;
 end;
end;

//-----------------------------------------------------------------------------

procedure TBufKsb.SendInBuffer(strmes : string);
var
 i : integer;
begin
 i:=pos(#0,strmes);
 if(i=0) then SendList.Add(strmes) else exit;
 while SendList.Count>2000 do
 begin
  SendList.Delete(0);
 end;
end;

//-----------------------------------------------------------------------------

function TBufKsb.SendInShared(str : string) : boolean;
var
        j : DWORD;
        len : DWORD;
begin
 Result:=false;
 len:=Length(str);
 _WaitMutex(s_mutex);

 if(s^.HeadPointer+len+1>=size-16) then
 begin
  _ReleaseMutex(s_mutex);
  exit;
 end;

 j:=0;
 while j<len do
 begin
  s^.StrData[s^.HeadPointer+j]:=str[1+j];
  Inc(j);
 end;


 s^.StrData[s^.HeadPointer+len]:=#0;
 s^.HeadPointer:=s^.HeadPointer+len+1;
 Result:=true;
 _ReleaseMutex(s_mutex);

end;

//-----------------------------------------------------------------------------

end.
