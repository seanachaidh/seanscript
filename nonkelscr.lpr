program nonkelscr;

{$mode objfpc}{$H+}

uses
  classes, sysutils, CustApp, varsystem, yacclib, lexlib, helpers,
  conditionsystem, symtab, ucomp, uinterpreter;

type

  { TNonkelScript }

  TNonkelScript = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ TNonkelScript }

{$include parser.pas}
{$include lexer.pas}

procedure TNonkelScript.DoRun;
var
  ErrorMsg: String;
begin
  // quick check parameters
  ErrorMsg:=CheckOptions('h','help');
  if ErrorMsg<>'' then begin
    ShowException(Exception.Create(ErrorMsg));
    Terminate;
    Exit;
  end;

  // parse parameters
  if HasOption('h','help') then begin
    WriteHelp;
    Terminate;
    Exit;
  end;

  writeln('welkom');
  yyparse;

  // stop program loop
  Terminate;
end;

constructor TNonkelScript.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor TNonkelScript.Destroy;
begin
  inherited Destroy;
end;

procedure TNonkelScript.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ',ExeName,' -h');
end;

var
  Application: TNonkelScript;
begin
  Application:=TNonkelScript.Create(nil);
  Application.Title:='NonkelScript';
  Application.Run;
  Application.Free;
end.

