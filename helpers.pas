unit helpers;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

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

