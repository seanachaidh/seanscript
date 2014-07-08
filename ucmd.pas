unit ucmd;

{
 een unit met implementaties voor standaard commando's
}

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, uinterpreter;

type

  { TPrintCmd }

  TPrintCmd = class(TAstNode)
    private
      msg: string;
    public
      constructor Create(toprint: string);

      function ToString: ansistring; override;
      procedure Interpret(con: TContext); override;

      property Message: string read msg write msg;

  end;


  { TExitCmd }

  TExitCmd = class(TAstNode)
    private
      retval: integer;
    public
      constructor Create(cretval: integer);
      procedure Interpret(con: TContext); override;
      function ToString: ansistring; override;

      property ReturnValue: integer read retval write retval;
  end;

implementation

{ TExitCmd }

constructor TExitCmd.Create(cretval: integer);
begin
  retval:= cretval;
end;

{de mogelijkheid implementeren om zonder return value te halten}
procedure TExitCmd.Interpret(con: TContext);
begin
  halt(retval);
end;

function TExitCmd.ToString: ansistring;
begin
  Result:= 'Exit commando: ' + retval;
end;

{ TPrintCmd }

constructor TPrintCmd.Create(toprint: string);
begin
  msg:= toprint;
end;

function TPrintCmd.ToString: ansistring;
begin
  Result:= 'een printcommando: ' + msg;
end;

procedure TPrintCmd.Interpret(con: TContext);
begin
  write(msg);
end;

end.
