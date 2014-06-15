unit uinterpreter;

{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils, FGL, symtab, variants;

type

  TOperatorType = (OPERATOR_PLUS, OPERATOR_MIN, OPERATOR_MUL, OPERATOR_DIV);
  TContext = class;
  TStatement = class;

  TStatementList = specialize TFPGList<TStatement>;

  { TStatement }

  TStatement = class
    private
      p_children: TStatementList;
    public
      procedure Interpret(c: TContext);virtual; abstract;
      procedure AddChild (child: TStatement);
      constructor Create;

      property children: TStatementList read p_children;

  end;

  { TCalcStatement }

  TCalcStatement = class(TStatement)
    private
      left, right: TCalcStatement;
      value: Variant;
      calcop: TOperatorType;
    public
      constructor Create(initleft, initright: TCalcStatement; op: TOperatorType);
      procedure Interpret(c: TContext); override;
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
    public
      Constructor Create;
  end;

implementation

{ TInterpreter }

constructor TInterpreter.Create;
begin
  stmts:= TStatementList.Create;
end;

{ TStatement }

procedure TStatement.AddChild(child: TStatement);
begin
  p_children.Add(child);
end;

constructor TStatement.Create;
begin
  p_children:=  TStatementList.Create;
end;

{ TCalcStatement }

constructor TCalcStatement.Create(initleft, initright: TCalcStatement; op: TOperatorType);
begin
  inherited Create;

  self.left:= initleft;
  self.right:= initright;
  self.calcop:= op;
end;

procedure TCalcStatement.Interpret(c: TContext);
var
  tmpval: Variant;
  tmpx, tmpy: Variant;
begin

  {
  deze constructie gaat fouten leveren bij vermenigdvuldigen en delen
  omdat er niet kan gedeeld worden door nul en omdat nul een opslorpend element is
  }
  if Assigned(left) then
  begin
    left.Interpret(c);
    tmpx:= left.value;
  end else begin
    left.value:= 0;
  end;

  if Assigned(right) then
  begin
    right.Interpret(c);
    tmpy := right.value;
  end else begin
      right.value:= 0;
  end;

  case calcop of
  OPERATOR_PLUS: self.value:= self.left.value + self.right.value;
  OPERATOR_DIV: self.value:= self.left.value / self.right.value;
  OPERATOR_MIN: self.value:= self.left.value - self.right.value;
  OPERATOR_MUL: self.value:= self.left.value * self.right.value;
  end;

end;

{ TContext }

constructor TContext.Create;
begin
  syms:= TSymbolList.Create;
end;

end.

