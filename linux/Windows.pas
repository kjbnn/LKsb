{$LongStrings On}
unit Windows;

interface

const
  MAXDWORD = DWORD($FFFFFFFF);

const
  MAXWORD = DWORD($FFFF);

function GetTickCount(): DWORD;

implementation

function GetTickCount(): DWORD;
var
  wHour, wMinute, wSecond, wMilliseconds: word;
begin
 {
 DecodeTime(time, wHour, wMinute, wSecond, wMilliseconds);
 Result:=wMilliseconds +
         1000*wSecond +
         1000*60*wMinute +
         1000*60*60 +wHour;
 }
end;

end.
