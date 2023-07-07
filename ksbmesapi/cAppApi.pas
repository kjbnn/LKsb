unit cAppApi;

interface

const
  ALL_APPLICATION = 20;

type
  TAppMap = packed record
    Number: byte;
    Busy: byte;
    ExePath: array[0..256] of char;
    WinTitle: array[0..256] of char;
    Visible: byte;
    LiveCount: integer;
    LiveTimeout: integer;
    MaxLiveTimeout: integer;
    NetNumber: byte;
    Sign: byte;
  end;

type
  PTAppMap = ^TAppMap;

type
  TAppInfo = record
    WinTitle: string;
    ExePath: string;
  end;


procedure CreateApplications(net_number: integer);
function ConnectApplication(info: TAppInfo): integer;
function GetCaptionApplication(i: integer): string;
function GetExePathApplication(i: integer): string;
procedure SetVisibleApplication(i, val: integer);
function GetVisibleApplication(i: integer): integer;
procedure IncLiveApplication(i: integer);
function GetInfoApplication(i: integer): PTAppMap;
function FindApplication(fname: string): integer;
procedure SetSignature(i: integer; val: byte);
function GetSign(i: integer): byte;

implementation

uses SysUtils, cOsFeature, Dialogs;

var
  AppArray: array[0..ALL_APPLICATION] of PTAppMap;

//-----------------------------------------------------------------------------

function ConnectApplication(info: TAppInfo): integer;
var
  i, j: integer;
  str: string;
  app: string;
begin
  Result := -1;

  i := 0;
  while i <= ALL_APPLICATION do
  begin
    if (AppArray[i] = nil) then
    begin
      str := Format('APP_MAP_%d', [i]) + #0;
      AppArray[i] := CreateShared(str, 4096);
    end;
    Inc(i);
  end;

  app := AnsiLowerCase(info.ExePath) + #0;
  i := 1;
  while i < ALL_APPLICATION do
  begin
    if (StrIComp(AppArray[i]^.ExePath, PChar(@app[1])) = 0) then
    begin
      Result := i;
      break;
    end;
    Inc(i);
  end;

  if (Result = -1) then
  begin

    i := 1;
    while i < ALL_APPLICATION do
    begin
      if (AppArray[i]^.Busy = 0) then
      begin
        AppArray[i]^.Busy := 1;
        j := 0;
        while j < Length(app) do
        begin
          AppArray[i]^.ExePath[j] := app[1 + j];
          Inc(j);
        end;
        Result := i;
        break;
      end;
      Inc(i);
    end;

  end;

  if (Result = -1) then
    Result := 0;

  if (info.WinTitle <> '') then
  begin
    j := 0;
    str := info.WinTitle + #0;
    while j < Length(str) do
    begin
      AppArray[Result]^.WinTitle[j] := str[1 + j];
      Inc(j);
    end;
  end;
end;

//-----------------------------------------------------------------------------

procedure CreateApplications(net_number: integer);
var
  i: integer;
  str: string;
begin
  i := 0;
  while i < ALL_APPLICATION do
  begin
    str := Format('APP_MAP_%d', [i]);
    AppArray[i] := CreateShared(str, 4096);
    AppArray[i]^.Number := i;
    AppArray[i]^.NetNumber := net_number;
    Inc(i);
  end;

end;

//-----------------------------------------------------------------------------

function GetCaptionApplication(i: integer): string;
begin
  Result := '';
  if (AppArray[i] <> nil) and (AppArray[i]^.Busy > 0) then
    Result := AppArray[i]^.WinTitle;
end;

//-----------------------------------------------------------------------------

function GetSign(i: integer): byte;
begin
  if (AppArray[i] <> nil) and (AppArray[i]^.Busy > 0) then
    Result := AppArray[i]^.Sign
  else
    Result := 0;
end;

//-----------------------------------------------------------------------------

function GetExePathApplication(i: integer): string;
begin
  Result := '';
  if (AppArray[i] <> nil) and (AppArray[i]^.Busy > 0) then
    Result := AppArray[i]^.ExePath;
end;

//-----------------------------------------------------------------------------

procedure SetVisibleApplication(i, val: integer);
begin
  if (AppArray[i] <> nil) then
    AppArray[i]^.Visible := val;
end;

//-----------------------------------------------------------------------------

function GetVisibleApplication(i: integer): integer;
begin
  Result := 0;
  if (AppArray[i] <> nil) then
    Result := AppArray[i]^.Visible;
end;

//-----------------------------------------------------------------------------

procedure IncLiveApplication(i: integer);
begin
  try
    if (AppArray[i] <> nil) then
      AppArray[i]^.LiveCount := AppArray[i]^.LiveCount + 1;
  except
  end;
end;

//-----------------------------------------------------------------------------

function GetInfoApplication(i: integer): PTAppMap;
begin
  Result := AppArray[i];
end;

//-----------------------------------------------------------------------------

function FindApplication(fname: string): integer;
var
  i: integer;
  str: string;
begin
  Result := -1;
  i := 1;
  while i < ALL_APPLICATION do
  begin

    if (AppArray[i] = nil) then
    begin
      str := Format('APP_MAP_%d', [i]) + #0;
      AppArray[i] := CreateShared(str, 4096);
    end;

    if (StrIComp(AppArray[i]^.ExePath, PChar(@fname[1])) = 0) then
    begin
      Result := i;
      break;
    end;
    Inc(i);
  end;

end;

//-----------------------------------------------------------------------------

procedure SetSignature(i: integer; val: byte);
begin
  try
    if (AppArray[i] <> nil) then
      AppArray[i]^.Sign := val;
  except
  end;
end;

//-----------------------------------------------------------------------------

end.
