unit sema;

interface

uses UnixType;
{
//uses ipc
//  semget,
//  semop
//  semctl
}
{$linklib pthread}

function sem_open(name : PChar; oflag : longint;  mode : TMode; value : longint) : pointer; overload; cdecl;
function sem_open(name : PChar; oflag : longint) : pointer; overload; cdecl;
function sem_post(sem : pointer) : integer; cdecl;
function sem_wait(sem : pointer) : integer; cdecl;



implementation

function sem_open(name : PChar; oflag : longint;  mode : TMode; value : longint) : pointer; overload; cdecl; external;
function sem_open(name : PChar; oflag : longint) : pointer; overload; cdecl; external;
function sem_post(sem : pointer) : integer; cdecl; external;
function sem_wait(sem : pointer) : integer; cdecl; external;


end.
