unit helpers;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fgl;

{enkele constanten voor het maken van newlines en tabs in strings}
const
  stnewline = {$ifdef WINDOWS} AnsiString(#10#13); {$else} AnsiString(#10); {$endif}
  stnewlinetab = {$ifdef windows} AnsiString(#10#13#9); {$else} AnsiString(#10#9); {$endif}

function GenerateRandomString: string;

implementation

function GenerateRandomString: string;
const
  chars = '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
var
  retval: string;
  tmp: integer;
begin
  Randomize;
  for tmp:= 1 to 9 do
  begin
    retval:= retval + chars[Random(60) + 1];
  end;
  Result:= retval;
end;

end.

