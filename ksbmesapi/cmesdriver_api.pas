unit cmesdriver_api;

interface

uses
{$Ifdef UNIX}
{$else}
 LCLIntf, LCLType,
{$EndIf}
 cKsbmes,classes;


procedure WriteNet(mes : KSBMES; str : string); overload;
procedure WriteNet(mes : KSBMES); overload;
procedure WriteNet(strmes : string); overload;



implementation

uses cForFormKsb, SysUtils;

//-----------------------------------------------------------------------------

procedure _WriteToNetwork(strmes : string);
begin
 AppKsbSend(strmes);
end;

procedure WriteNet(mes : KSBMES; str : string);
begin
 if(mes.Code>0) then WriteNet(Pack(mes)+str);
end;

procedure WriteNet(mes : KSBMES);
begin
 mes.Size:=0;
 if(mes.Code>0) then WriteNet(Pack(mes));
end;

//-----------------------------------------------------------------------------

procedure WriteNet(strmes : string);
begin

  if(Length(strmes)<sizeof(KSBMES)*2) then
  begin
   exit;
  end;

  if( StrLComp(PChar(strmes),'AA55',4)<>0 ) then
  begin
   exit;
  end;

 _WriteToNetwork(strmes);
end;

//-----------------------------------------------------------------------------


end.
