program nonkelscr;

{$mode objfpc}{$H+}

uses
  classes, sysutils, CustApp, varsystem, yacclib, lexlib, helpers,
  conditionsystem, symtab, ucomp, uinterpreter, ucmd, appunit, NonkelExceptions;

var
  Application: TNonkelScript;
begin
  Application:=TNonkelScript.Create(nil);
  Application.Title:='NonkelScript';
  Application.Run;
  Application.Free;
end.

