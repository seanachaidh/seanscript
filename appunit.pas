unit appunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, symtab, uinterpreter, CustApp, YaccLib, LexLib, ucmd;

type

  { TNonkelScript }

  TNonkelScript = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    class var maininterpreter: TInterpreter;

    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

implementation

{ TNonkelScript }

{$include parser.pas}
{$include lexer.pas}

procedure TNonkelScript.DoRun;
var
  ErrorMsg: String;
begin
  // quick check parameters
  ErrorMsg:=CheckOptions('h d i:','help debug input:');
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

  //Een debugoptie
  if HasOption('d', 'debug') then
  begin
    yydebug:= true;
    NonkelDebug:= true;
  end;

  if HasOption('i', 'input') then
  begin
    writeln('parsing file: ', GetOptionValue('i', 'input'));
    AssignFile(yyinput, GetOptionValue('i', 'input'));
    Reset(yyinput);
  end;

  writeln('welkom');
  //is het niet veiliger om dit in de constructor te doen?
  TNonkelScript.maininterpreter:= TInterpreter.Create;

  //De resulterende syntaxtree wordt opgeslagen in maininterpreter
  yyparse;

  TNonkelScript.maininterpreter.ShowString;

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

end.
