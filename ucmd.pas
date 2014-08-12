unit ucmd;

{
 een unit met implementaties voor standaard commando's
}

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, uinterpreter, symtab;

type

  { TPrintCmd }

  TPrintCmd = class(TAstNode)
    private
      msg: string;
      isident: boolean;
    public
      constructor Create(toprint: string; cisident: boolean);

      function ToString: ansistring; override;

      //Als het bericht een identifier is schrijft het de waarde van het symbool waarmee
      //het overeenstemt naar het scherm, anders schrijft het gewoon het bericht naar het scherm.
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

uses appunit;

{ TExitCmd }

constructor TExitCmd.Create(cretval: integer);
begin
  retval:= cretval;
end;

{de mogelijkheid implementeren om zonder return value te halten}
procedure TExitCmd.Interpret(con: TContext);
begin
  //moet iets subtieler
  halt(retval);
end;

function TExitCmd.ToString: ansistring;
begin
  Result:= 'Exit commando: ' + IntToStr(retval);
end;

{ TPrintCmd }

constructor TPrintCmd.Create(toprint: string; cisident: boolean);
begin
  msg:= toprint;
  isident:= cisident;
end;

function TPrintCmd.ToString: ansistring;
begin
  Result:= 'een printcommando: ' + msg;
end;

procedure TPrintCmd.Interpret(con: TContext);
var
  tmpsym: TSymbol;
begin
  if isident then
  begin
    tmpsym:= con.SearchSymbol(msg);
    if not Assigned(tmpsym) then
    begin
      raise Exception.Create(Format('varaible niet gevonden: %s', [msg]));
    end else begin
      Write(tmpsym.Value.ToString);
    end;
  end else begin
    write(msg);
  end;
end;

end.
