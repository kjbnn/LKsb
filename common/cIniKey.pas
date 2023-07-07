unit cIniKey;

interface

uses Classes;

procedure DeleteKey(key: string);
function GetKey(key, def: string): string; overload;
function GetKey(sec, key, def: string): string; overload;
function GetKey(key: string; def: integer): integer; overload;
function GetKey(sec, key: string; def: integer): integer; overload;

procedure SetKey(key: string; Value: string); overload;
procedure SetKey(key: string; Value: integer); overload;
procedure SetKey(sec: string; key: string; Value: string); overload;
function ReadPath(): string;
function GetAppName(): string;
function EncryptKey(InString: string): string;
function DecryptKey(InString: string): string;

implementation

uses IniFiles, SysUtils, Forms, Dialogs;

const
  StartKey = 473; // Start default key
  MultKey = 62141; // Mult default key
  AddKey = 11717; // Add default key


//-----------------------------------------------------------------------------

function GetKey(key, def: string): string;
var
  sec: string;
  ini: TIniFile;
begin
  Result := def;
  try
    ini := TIniFile.Create(ReadPath() + 'setting.ini');
    sec := GetAppName();
    if ((not ini.SectionExists(sec)) or (not ini.ValueExists(sec, key))) then
    begin
      SetKey(key, def);
    end;
    Result := ini.ReadString(sec, key, def);
    ini.Free();
  except
  end;
end;

//-----------------------------------------------------------------------------

function GetKey(key: string; def: integer): integer;
var
  sec: string;
  ini: TIniFile;
begin
  Result := def;
  try
    ini := TIniFile.Create(ReadPath() + 'setting.ini');
    sec := GetAppName();
    if ((not ini.SectionExists(sec)) or (not ini.ValueExists(sec, key))) then
    begin
      SetKey(key, def);
    end;
    Result := ini.ReadInteger(sec, key, def);
  finally
    ini.Free();
  end;
end;

function GetKey(sec, key: string; def: integer): integer;
var
  ini: TIniFile;
begin
  Result := def;
  try
    ini := TIniFile.Create(ReadPath() + 'setting.ini');
    sec := GetAppName();
    if ((not ini.SectionExists(sec)) or (not ini.ValueExists(sec, key))) then
    begin
      SetKey(key, def);
    end;
    Result := ini.ReadInteger(sec, key, def);
    ini.Free();
  except
  end;
end;

//-----------------------------------------------------------------------------

procedure SetKey(key: string; Value: string);
var
  sec: string;
  ini: TIniFile;
begin
  try
    ini := TIniFile.Create(ReadPath() + 'setting.ini');
    sec := GetAppName();
    ini.WriteString(sec, key, Value);
    ini.Free();
  except
  end;
end;

procedure SetKey(key: string; Value: integer);
var
  sec: string;
  ini: TIniFile;
begin
  try
    ini := TIniFile.Create(ReadPath() + 'setting.ini');
    sec := GetAppName();
    ini.WriteInteger(sec, key, Value);
    ini.Free();
  except
  end;
end;

//-----------------------------------------------------------------------------

function GetKey(sec, key, def: string): string;
var
  ini: TIniFile;
begin
  Result := def;
  try
    ini := TIniFile.Create(ReadPath() + 'setting.ini');
    if ((not ini.SectionExists(sec)) or (not ini.ValueExists(sec, key))) then
    begin
      SetKey(key, def);
    end;
    Result := ini.ReadString(sec, key, def);
    ini.Free();
  except
  end;
end;

//-----------------------------------------------------------------------------

procedure SetKey(sec: string; key: string; Value: string);
var
  ini: TIniFile;
begin
  try
    ini := TIniFile.Create(ReadPath() + 'setting.ini');
    ini.WriteString(sec, key, Value);
    ini.Free();
  except
  end;
end;

//-----------------------------------------------------------------------------

procedure DeleteKey(key: string);
var
  str: string;
  ini: TIniFile;
begin
  try
    ini := TIniFile.Create(ReadPath() + 'setting.ini');
    str := GetAppName();
    ini.DeleteKey(str, key);
    ini.Free();
  except
  end;
end;

//-----------------------------------------------------------------------------

function ReadPath(): string;
begin
{$IFDEF UNIX}
  Result := GetCurrentDir() + '/';
{$ELSE}
  Result := ExtractFilePath(Application.ExeName);
{$ENDIF}
end;

//-----------------------------------------------------------------------------

function GetAppName(): string;
var
  str: string;
  i: integer;
begin
  str := ExtractFileName(ParamStr(0));
  i := pos('.', str);
  if (i > 1) then
    SetLength(str, i - 1);
  Result := AnsiUpperCase(str);
end;

//-----------------------------------------------------------------------------

function EncryptKey(InString: string): string;
var
  I: byte;
  //  Key : integer;
begin
  //  key:=StartKey;
  Result := '';
  for I := 1 to Length(InString) do
  begin
    Result := Result + char(byte(InString[I]) xor (StartKey shr 8));
    //    Key := (Byte(Result[I]) + StartKey) * MultKey + AddKey;
  end;
end;

//-----------------------------------------------------------------------------

function DecryptKey(InString: string): string;
var
  I: byte;
  //  Key : integer;
begin
  //  key:=StartKey;
  Result := '';
  for I := 1 to Length(InString) do
  begin
    Result := Result + char(byte(InString[I]) xor (StartKey shr 8));
    //    Key := (Byte(InString[I]) + StartKey) * MultKey + AddKey;
  end;
end;

//-----------------------------------------------------------------------------


end.




