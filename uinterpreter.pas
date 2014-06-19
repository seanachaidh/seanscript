unit uinterpreter;

{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils, FGL, symtab, variants;

type

  TOperatorType = (OPERATOR_PLUS, OPERATOR_MIN, OPERATOR_MUL, OPERATOR_DIV);
  TCmpType = (GREATER, LESSER, EQUAL);

  TContext = class;
  TAstNode = class;

  TStatementList = specialize TFPGList<TStatement>;

  { TAstNode }

  TAstNode = class
    private
      p_children: TStatementList;
    public
      procedure Interpret(c: TContext);virtual; abstract;
      procedure AddChild (child: TAstNode);
      constructor Create;

      property children: TStatementList read p_children;

  end;


   TSymbolList = specialize TFPGList<TSymbol>;
  { TContext }

  TContext = class
    private
      syms: TSymbolList;
    public
      constructor Create;
      property Symbols: TSymbolList read syms write syms;
  end;

  { TInterpreter }

  TInterpreter = class
    private
      stmts: TStatementList;
      context: TContext;
    public
      Constructor Create(con: TContext);
      //start de interpreter
      procedure Execute;
  end;

var
  {Ik moet ervoor zorgen dat ik hier geen globale variable nodig heb}
  interpreter: TInterpreter;

implementation

{ TInterpreter }

constructor TInterpreter.Create(con: TContext);
begin
  stmts:= TStatementList.Create;
end;

procedure TInterpreter.Execute;
var
  x: TAstNode;
begin
  for x in stmts do
  begin
    x.Interpret();
  end;
end;

{ TAstNode }

procedure TAstNode.AddChild(child: TAstNode);
begin
  p_children.Add(child);
end;

constructor TAstNode.Create;
begin
  p_children:=  TStatementList.Create;
end;

{ TContext }

constructor TContext.Create;
begin
  syms:= TSymbolList.Create;
end;

initialization
interpreter:= TInterpreter.Create(TContext.Create);

end.

