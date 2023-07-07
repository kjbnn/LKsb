unit cKsbmes;

interface

{$Ifdef UNIX}
{$else}
uses Windows;

{$EndIf}

type
  {
  KSBMES = packed record
    VerMinor: byte;     // ������� ���� ������
    VerMajor: byte;     // ������� ���� ������
    Num: DWORD;         // ���������� ����� ���������
    SysDevice: word;
    // ���������� �� ������ SYSTEM_OPS,SYSTEM_SUD,SYSTEM_TV
    NetDevice: word;    //  ����� ����������� ���������
    BigDevice: word;    //  ����� Vista,RS90
    SmallDevice: word;  //   ����� ���� ,�����������
    Code: word;         //   ��� ���������
    Partion: word;      //  ������ �����
    Level: word;        //   ������� �������
    NumberGroup: word;
    //  ���������� ���� - �������� ���������
    User: word;         //  ������������ ������
    Size: word;                //   ����� ������ Data ���� ���������
    CmdTime,
    SendTime: TDateTime;       //   ���� � ����� ��������
    WriteTime : TDateTime;      //   ���� � ����� �����
    ReservDw1: DWORD;
    ReservB1: byte;
    ReservB2: byte;
    ReservB3: byte;
    ReservB4: byte;
    PIN: array[0..5] of char;  //  ��� ��� ����� ��� ������� � ��
    Fill: array[0..2] of byte; // ��������� ������ �� RS90
    Proga: word;               // ����� ������������ ������
    Keyboard: word;            // ���������� � ��
    Camera: word;              // ������
    Monitor: word;        // ����� ��������
    NumCard: word;        // ����� �����
    RepPass: byte;        // "���������� ��������" - �������� ��� ���������� �����
    Facility: byte;       // ��� � RS90
    __Scenary: word;        // ����� �������� � ��
    TypeDevice: word;     // ��� ����������
    NumDevice: word;     // ���������� ����� ���������� (��� ?)
    Mode: word;           // �����
    GroupID: DWORD;         // ������ ���
    ElementID: DWORD;

    OperatorID: DWORD;    // �������� ����������� ��������
    UserID: DWORD;        // ������� ����� �����
    ClientID: DWORD;
    // ���������� � ������ ������ ����������� � �������� ������ �����
    __ComputerID: DWORD;
    Reserv: array[0..2] of byte;// ���������������
    Data: array[0..1] of byte;
  end;
   }

KSBMES = packed record
 VerMinor : BYTE;         // ������� ���� ������
 VerMajor : BYTE;         // ������� ���� ������
 Num : DWORD;             // ���������� ����� ���������
 SysDevice : WORD;        // ���������� �� ������ SYSTEM_OPS,SYSTEM_SUD,SYSTEM_TV
 NetDevice : WORD;        // ����� ����������� ���������
 BigDevice : WORD;        // ����� Vista,RS90,Ernitec,Uniplex
 SmallDevice : WORD;      // ����� ���� ,�����������
 Code : WORD;             // ��� ���������
 Partion : WORD;          // ������ �����
 Level : WORD;            // ������� �������
 _Group : WORD;           // ������ ���
 User : WORD;             // ������������ ����� ��� ����������
 Size : WORD;             // ����� ������ Data ���� ���������
 SendTime : TDateTime;    // ���� � ����� ��������
 WriteTime : TDateTime;   // ���� � ����� �����
 PIN : array[0..5] of Char;   // ��� ��� ����� ��� ������� � ��
 Fill : array[0..2] of BYTE;  // ��������� ������ �� RS90
 Proga : WORD;            // ����� ������������ ������
 Keyboard : WORD;         // ���������� � ��
 Camera : WORD;           // ������
 Monitor : WORD;          // ����� ��������
 NumCard : WORD;          // ����� �����
 RepPass : BYTE;          // "���������� ��������" - �������� ��� ���������� �����
 Facility : BYTE;         // ��� � RS90
 Scenary : WORD;          // ����� �������� � ��
 TypeDevice : WORD;       // ��� ����������
 NumDevice  : WORD;       // ���������� ����� ���������� (��� ?)
 Mode : WORD;             // �����
 Group : DWORD;           // ������ ���
 ElementID : DWORD;       // �� ��������
 CodeID : DWORD;          // �� ���� �������
 EmployeeID: WORD;        // �� ����������
 OperatorID: WORD;        // �� �������� �����
 CmdTime: TDateTime;      // ���� � ����� �������������
 IsQuit: WORD;            // ������������� ���������
 DomainId: Byte;          // �� ������
 Data: array[0..1] of BYTE; // ������������ ������
end;


var
  KsbAppType: integer;

function Pack(mes: KSBMES): string;
procedure UnPack(strmes: string; var mes: KSBMES; var tail: string);
procedure Simbol2Bin(str: string; mes: PChar; n: integer);
function Bin2Simbol(bin: PChar; n: integer): string;
procedure Init(out mes: KSBMES);

implementation

uses SysUtils, Dialogs;

//-----------------------------------------------------------------------------

function Char2Int(x: integer): integer;
begin
  if (x >= 65) and (x <= 70) then
  begin
    x := x - 55;
  end
  else
  if (x >= 48) and (x <= 58) then
  begin
    x := x - 48;
  end;
  Result := x;
end;

//-----------------------------------------------------------------------------

procedure Simbol2Bin(str: string; mes: PChar; n: integer);
var
  i: integer;
  x1: integer;
  x2: integer;
  len: integer;
begin
  len := Length(str);
  n := n * 2;

  i := 1;
  while (i <= len) and (i < n) do
  begin
    x1 := integer(str[i]);
    x2 := integer(str[i + 1]);
    mes[i shr 1] := char((Char2Int(x1) shl 4) + Char2Int(x2));
    i := i + 2;
  end;
end;

//-----------------------------------------------------------------------------

const
  BytesHex: array[0..15] of char =
    ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F');

function Bin2Simbol(bin: PChar; n: integer): string;
var
  i: integer;
begin
  SetLength(Result, 2 * n);
  i := 0;
  while i < n do
  begin
    Result[1 + 2 * i] := BytesHex[byte(bin[i]) shr 4];
    Result[2 * i + 2] := BytesHex[byte(bin[i]) and $F];
    Inc(i);
  end;
end;


//-----------------------------------------------------------------------------

function Pack(mes: KSBMES): string;
begin
  Result := Bin2Simbol(PChar(@mes), sizeof(KSBMES));
end;

//-----------------------------------------------------------------------------

procedure UnPack(strmes: string; var mes: KSBMES; var tail: string);
var
  len: integer;
begin
  len := sizeof(mes) * 2;
  tail := '';
  Simbol2Bin(strmes, PChar(@mes), sizeof(mes));
  if (Length(strmes) > len) then
    tail := Copy(strmes, len + 1, Length(strmes));

end;

//-----------------------------------------------------------------------------

procedure Init(out mes: KSBMES);
begin
  FillChar(mes, sizeof(KSBMES), 0);
  mes.VerMinor := $AA;
  mes.VerMajor := $55;
  mes.SendTime := Now();
  mes.Proga := KsbAppType;
  mes._Group:= $3412;
end;

//-----------------------------------------------------------------------------


end.





