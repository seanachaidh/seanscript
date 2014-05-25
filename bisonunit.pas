unit bisonunit;

{
deze unit combineert de parser en de lexer
}

{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils, helpers, YaccLib, LexLib;

procedure ReadFromFile(filename: string);
procedure ReadFromString(toread: string);
type
  func = (fn_print, fn_exit);

implementation
{$include parser.pas}
{$include lexer.pas}

{ TODO 1 -oPieter -cDeze procedure moet opnieuw gemaakt worden }
procedure ReadFromFile(filename: string);
var
  tmpfile: Text;
  tmpname: string;
begin
  tmpname:= GenerateRandomString + '.tmp';
  Assign(tmpfile, tmpname);

  Reset(tmpfile);
  write(tmpfile, filename);
end;

procedure ReadFromString(toread: string);
{een extra testvariable}
var
  x: integer;
begin
  write(toread);
  x:= yylex;
  write(x);
end;

end.

