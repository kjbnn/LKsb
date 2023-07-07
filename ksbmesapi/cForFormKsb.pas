unit cForFormKsb;

interface

uses
  Forms;

type
  T_AppKsbConsider = procedure(strmes: string);

type
  T_AppKsbShow = procedure(status: integer);

type
  TSetStatusNet = procedure(status: integer);

procedure AppKsbSend(strmes: string);
procedure AppKsbInit(form: TForm);
procedure AppKsbClearBuffer();
procedure AppKsbClearReceiveBuf();
procedure AppKsbTimer();
procedure SetStatusNet(status: integer);

var
  Pointer_AppKsbConsider: T_AppKsbConsider;

var
  Pointer_AppKsbShow: T_AppKsbShow;

var
  Pointer_SetStatusNet: TSetStatusNet;
  Number_From_Net: integer;
  NetSubChannel: integer;


implementation

uses cIniKey, cBufKsb, cAppApi, Classes, SysUtils, Dialogs;

var
  KsbNet: TBufKsb;
  _Visible: integer;
  // _KsbList: TStringList;
  MyForm: TForm;

//-----------------------------------------------------------------------------

procedure SetStatusNet(status: integer);
begin
  if Assigned(Pointer_SetStatusNet) then
    Pointer_SetStatusNet(status);
end;

//-----------------------------------------------------------------------------

procedure AppKsbSend(strmes: string);
begin
  KsbNet.SendInBuffer(strmes);
end;

//-----------------------------------------------------------------------------

procedure AppKsbClearReceiveBuf();
begin
  KsbNet.ClearReceiveBuf();
end;

//-----------------------------------------------------------------------------

procedure AppKsbInit(form: TForm);
var
  str: string;
  info: TAppInfo;
  pinfo: PTAppMap;
begin
  MyForm := form;
  _Visible := GetKey('VISIBLE', 1);

  info.WinTitle := form.Caption;
  info.ExePath := UpperCase(ParamStr(0));
  NetSubChannel := ConnectApplication(info);
  pinfo := GetInfoApplication(NetSubChannel);
  Number_From_Net := pinfo^.NetNumber;
  pinfo^.MaxLiveTimeout := GetKey('StartCount', 15);
  //_KsbList := TStringList.Create();
  KsbNet := TBufKsb.Create(nil);
  str := 'MAPNAME_' + IntToStr(NetSubChannel);
  KsbNet._Init(str, True, 4096);
  AppKsbClearBuffer();
end;

//-----------------------------------------------------------------------------

procedure AppKsbClearBuffer();
begin
  KsbNet.Clear();
end;

//-----------------------------------------------------------------------------

procedure AppKsbTimer();
var
  strmes: string;
  vis: integer;
begin

  IncLiveApplication(NetSubChannel);
  vis := GetVisibleApplication(NetSubChannel);

  if Assigned(Pointer_AppKsbShow) then
  begin
    Pointer_AppKsbShow(vis);
  end;


  case _Visible of
    -1:
    begin
      if (MyForm.Visible) then
        MyForm.Visible := False;
    end;

    0:
    begin
      if MyForm.Visible <> (vis > 0) then
        MyForm.Visible := vis > 0;
    end;

    1:
    begin
      if (not MyForm.Visible) then
      begin
        MyForm.Visible := True;
        MyForm.Show();
      end;
    end;

  end;//case

  while True do
  begin
    strmes := KsbNet.ReceiveString();
    if Assigned(Pointer_AppKsbConsider) and (strmes <> '') then
    begin
      Pointer_AppKsbConsider(strmes);
    end
    else
      break;
    SetStatusNet(1);
  end;

end;

//-----------------------------------------------------------------------------

end.
