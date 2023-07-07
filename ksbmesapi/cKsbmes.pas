unit cKsbmes;

interface

{$Ifdef UNIX}
{$else}
uses Windows;

{$EndIf}

type
  {
  KSBMES = packed record
    VerMinor: byte;     // Младший байт версии
    VerMajor: byte;     // Старший байт версии
    Num: DWORD;         // Порядковый номер сообщения
    SysDevice: word;
    // подсистема из набора SYSTEM_OPS,SYSTEM_SUD,SYSTEM_TV
    NetDevice: word;    //  Номер контроллера поддержки
    BigDevice: word;    //  номер Vista,RS90
    SmallDevice: word;  //   номер зоны ,считывателя
    Code: word;         //   код сообщения
    Partion: word;      //  раздел Висты
    Level: word;        //   уровень доступа
    NumberGroup: word;
    //  Непонятное поле - украдено Демидовым
    User: word;         //  пользователь Рубежа
    Size: word;                //   длина масива Data этой структуры
    CmdTime,
    SendTime: TDateTime;       //   Дата и время отправки
    WriteTime : TDateTime;      //   Дата и время приёма
    ReservDw1: DWORD;
    ReservB1: byte;
    ReservB2: byte;
    ReservB3: byte;
    ReservB4: byte;
    PIN: array[0..5] of char;  //  ПИН для карты или клавиша в ТВ
    Fill: array[0..2] of byte; // различные данные от RS90
    Proga: word;               // номер программного модуля
    Keyboard: word;            // клавиатура в ТВ
    Camera: word;              // камера
    Monitor: word;        // номер монитора
    NumCard: word;        // номер карты
    RepPass: byte;        // "количество повторов" - параметр при добавление карты
    Facility: byte;       // код в RS90
    __Scenary: word;        // номер сценария в ТВ
    TypeDevice: word;     // тип устройства
    NumDevice: word;     // порядковай номер устройства (где ?)
    Mode: word;           // режим
    GroupID: DWORD;         // группа зон
    ElementID: DWORD;

    OperatorID: DWORD;    // оператор выполнивший действия
    UserID: DWORD;        // большой номер карты
    ClientID: DWORD;
    // посетитель в данный момент привязанный к большому номеру карты
    __ComputerID: DWORD;
    Reserv: array[0..2] of byte;// зарезервировано
    Data: array[0..1] of byte;
  end;
   }

KSBMES = packed record
 VerMinor : BYTE;         // Младший байт версии
 VerMajor : BYTE;         // Старший байт версии
 Num : DWORD;             // Порядковый номер сообщения
 SysDevice : WORD;        // подсистема из набора SYSTEM_OPS,SYSTEM_SUD,SYSTEM_TV
 NetDevice : WORD;        // Номер контроллера поддержки
 BigDevice : WORD;        // номер Vista,RS90,Ernitec,Uniplex
 SmallDevice : WORD;      // номер зоны ,считывателя
 Code : WORD;             // код сообщения
 Partion : WORD;          // раздел Висты
 Level : WORD;            // уровень доступа
 _Group : WORD;           // группа зон
 User : WORD;             // пользователь Висты или компьютера
 Size : WORD;             // длина масива Data этой структуры
 SendTime : TDateTime;    // Дата и время отправки
 WriteTime : TDateTime;   // Дата и время приёма
 PIN : array[0..5] of Char;   // ПИН для карты или клавиша в ТВ
 Fill : array[0..2] of BYTE;  // различные данные от RS90
 Proga : WORD;            // номер программного модуля
 Keyboard : WORD;         // клавиатура в ТВ
 Camera : WORD;           // камера
 Monitor : WORD;          // номер монитора
 NumCard : WORD;          // номер карты
 RepPass : BYTE;          // "количество повторов" - параметр при добавление карты
 Facility : BYTE;         // код в RS90
 Scenary : WORD;          // номер сценария в ТВ
 TypeDevice : WORD;       // тип устройства
 NumDevice  : WORD;       // порядковай номер устройства (где ?)
 Mode : WORD;             // режим
 Group : DWORD;           // группа зон
 ElementID : DWORD;       // Ид элемента
 CodeID : DWORD;          // Ид вида события
 EmployeeID: WORD;        // Ид сотрудника
 OperatorID: WORD;        // Ид рабочего места
 CmdTime: TDateTime;      // Дата и время подтверждения
 IsQuit: WORD;            // Квитированное сообщение
 DomainId: Byte;          // Ид домена
 Data: array[0..1] of BYTE; // Произвольные данные
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





