unit uinterpreter;
{
 deze unit bevat de interpreter
}

{$mode objfpc}

interface
uses
  Classes, fgl, sysutils, symtab, helpers, typinfo;

type
  //deze enum wordt gebruikt bij vergelijkingen


  TContext = class;
  TAstNode = class;

  TNodeList = specialize TFPGList<TAstNode>;
  TCompType = (GREATER, LESSER, EQUAL);
  TOperator = (OPERATOR_PLUS, OPERATOR_DIV, OPERATOR_MIN, OPERATOR_MUL);

  { TAstNode }

  TAstNode = class
    private
      kinderen: TNodeList;
    public
      procedure Interpret(con: TContext);virtual; abstract;
      procedure AddChild(toadd: TAstNode);
      function ToString: ansistring; override;

      constructor Create;
      constructor Create(initkinderen: TNodeList);

  end;

  { TParameter }

  TParameter = class(TAstNode)
    private
      mynaam: string;
      myvalue: float;
    public
      property Naam: string read mynaam write mynaam;
      property Value: float read myvalue write myvalue;

      procedure Interpret(con: TContext); override;
      function ToString: ansistring; override;
      constructor Create(cnaam: string; cvalue: float);
  end;

  TParameterList = specialize TFPGList<TParameter>;

  {Deze klasse stelt een nummer voor}

  { TNumber }

  TNumber = class(TAstNode)
    private
      value: float;
    public
      function GetValue: float; virtual;
      procedure Interpret(con: TContext); override;
      function ToString: ansistring; override;

      Constructor Create(val: Float);
  end;

  {Deze klasse stelt een berekening voor}

  { TCalculation }

  TCalculation = class(TNumber)
    private
      myleft, myright: TNumber;
      op: TOperator;
    public
      property Left: TNumber read myleft write myleft;
      property Right: TNumber read myright write myright;

      function GetValue: float; override;
      procedure Interpret(con: TContext); override;
      function ToString: ansistring; override;

      constructor Create(cleft, cright: TNumber; cop: TOperator);
  end;

  {Deze klasse stelt een block voor}

  { TCodeBlock }

  TCodeBlock = class (TAstNode)
    private
      mystatements: TNodeList;
    public
      property Statements: TNodeList read mystatements write mystatements;

      procedure Interpret(con: TContext); override;
      function ToString: ansistring; override;

      constructor Create;
  end;

  {Deze kasse stelt een hoofding voor van een programma}

  { TScriptDeclaration }

  TScriptDeclaration = class(TAstNode)
    private
      mynaam: String;
      myprogram: TNodeList;
    public
      property Naam: string read mynaam write mynaam;
      procedure Interpret(con: TContext); override;
      function ToString: ansistring; override;
      procedure AddProgram(toadd: TNodeList);

      constructor Create(cnaam: String);
  end;

  { TConditional }

  TConditional = class(TAstNode)
    private
      myleft, myright: TCalculation;
      comp: TCompType;
      block: TCodeBlock;
    public
      property Left: TCalculation read myleft write myleft;
      property Right: TCalculation read myright write myright;
      property Comparator: TCompType read comp write comp;
      property CodeBlock: TCodeBlock read block write block;

      procedure Interpret(con: TContext); override;
      function ToString: AnsiString; override;

      constructor Create(cleft, cright: TCalculation; ccomp: TCompType;
        cblock: TCodeBlock);
  end;

  { TWhileStatement }

  TWhileStatement = class(TConditional)
    public
      procedure Interpret(con: TContext); override;
      function ToString: AnsiString; override;
  end;

  { TIfStatement }

  TIfStatement = class(TConditional)
    private
      belse: TCodeBlock;
    public
      property ElseBlock: TCodeBlock read belse write belse;
      procedure Interpret(con: TContext); override;
      function ToString: AnsiString; override;

      constructor Create(cleft, cright: TCalculation; ccomp: TCompType;
        cblock: TCodeBlock; celse: TCodeBlock);
  end;

  { TAssingnment }

  TAssingnment = class(TAstNode)
    private
      calc: TCalculation;
      ident: String;
    public
      property Calculation: TCalculation read calc write calc;
      property Naam: string read ident write ident;

      procedure Interpret(con: TContext); override;
      function ToString: AnsiString; override;

      constructor Create(cident: string);
      constructor Create(cident: string; ccalc: TCalculation);

  end;

  { TContext }

  TContext = class
    private
      mysymbols: TSymbolTable;
    public
      property Symbols: TSymbolTable read mysymbols write mysymbols;
      constructor Create(syms: TSymbolTable);
      constructor Create;
  end;

  { TInterpreter }

  TInterpreter = class
    private
      mycontext: TContext;
      myexpressions: TNodeList;
    public
      property Context: TContext read mycontext write mycontext;

      procedure AddExpression(expr: TAstNode);
      Constructor Create;
      constructor Create(con: TContext);
  end;

implementation

{ TWhileStatement }

procedure TWhileStatement.Interpret(con: TContext);
begin
  inherited Interpret(con);
end;

function TWhileStatement.ToString: AnsiString;
begin
  Result:=inherited ToString;
end;

{ TConditional }

procedure TConditional.Interpret(con: TContext);
begin
  raise Exception.Create('nog niet geimplementeerd');
end;

function TConditional.ToString: AnsiString;
begin
  Result:=inherited ToString + stnewline;
  Result+= 'Left: ' + stnewline + Left.ToString + stnewline;
  Result+= 'Right: ' + stnewline + Right.ToString;
end;

constructor TConditional.Create(cleft, cright: TCalculation; ccomp: TCompType;
  cblock: TCodeBlock);
begin
  self.Left:= cleft;
  self.Right:= cright;
  Self.comp:= ccomp;
  Self.CodeBlock:= cblock;
end;

{ TScriptDeclaration }

procedure TScriptDeclaration.Interpret(con: TContext);
begin
  raise Exception.Create('nog niet geimplemteerd');
end;

function TScriptDeclaration.ToString: ansistring;
begin
  Result:=inherited ToString + stnewlinetab;
  Result+= 'Script naam: ' + Naam;
end;

procedure TScriptDeclaration.AddProgram(toadd: TNodeList);
var
  tmp: TAstNode;
begin
  for tmp in toadd
  begin
    myprogram.Add(tmp);
  end;
end;

constructor TScriptDeclaration.Create(cnaam: String);
begin
  Self.Naam:= cnaam;
  self.myprogram:= TNodeList.Create;
end;

{ TCalculation }

function TCalculation.GetValue: float;
begin
  case op of
  OPERATOR_PLUS: Result:= Left.value + Right.value;
  OPERATOR_MIN: Result:= Left.value - Right.value;
  OPERATOR_DIV: Result:= Left.value / Right.value;
  OPERATOR_MUL: Result:= Left.value * Right.value;
  end;
end;

procedure TCalculation.Interpret(con: TContext);
begin
  raise Exception.Create('nog niet geimplementeerd');
end;

function TCalculation.ToString: ansistring;
begin
  Result:=inherited ToString + stnewline;
  Result+= 'Operator: ' + GetEnumName(TypeInfo(TOperator), integer(self.op)) + stnewline;
  Result+= 'Left:' + stnewlinetab + left.ToString + stnewline;
  Result+= 'Right:' + stnewlinetab + right.ToString;
end;

constructor TCalculation.Create(cleft, cright: TNumber; cop: TOperator);
begin
  self.Left:= cleft;
  self.Right:= cright;
  self.op:= cop;
end;

{ TAssingnment }

procedure TAssingnment.Interpret(con: TContext);
begin
  raise Exception.Create('nog niet geimplementeerd');
end;

function TAssingnment.ToString: AnsiString;
begin
  Result:=inherited ToString + stnewlinetab;
  Result+= self.ident + stnewlinetab;
end;

constructor TAssingnment.Create(cident: string);
begin
  inherited Create;
  self.ident:= cident;
end;

constructor TAssingnment.Create(cident: string; ccalc: TCalculation);
begin
  inherited Create;
  Self.ident:= cident;
  self.calc:= ccalc;
end;

{ TCodeBlock }

procedure TCodeBlock.Interpret(con: TContext);
begin
  raise Exception.Create('nog niet geimplementeerd');
end;

function TCodeBlock.ToString: ansistring;
var
  tmp: TAstNode;
begin
  Result:=inherited ToString + stnewlinetab;
  for tmp in Statements do
  begin
    Result+= tmp.ToString;
  end;
end;

constructor TCodeBlock.Create;
begin
  inherited Create;
  Statements:= TNodeList.Create;
end;

{ TIfStatement }

procedure TIfStatement.Interpret(con: TContext);
begin
  raise Exception.Create('nog niet geimplementeerd');
end;

function TIfStatement.ToString: AnsiString;
begin
  Result:=inherited ToString;
  Result += 'elseblock: ' + stnewlinetab + belse.ToString;
end;

constructor TIfStatement.Create(cleft, cright: TCalculation; ccomp: TCompType;
  cblock: TCodeBlock; celse: TCodeBlock);
begin
  inherited Create;
  self.Left:= cleft;
  self.Right:= cright;
  self.comp:= ccomp;
  self.CodeBlock:= cblock;
  self.ElseBlock:= celse;
end;

{ TAstNode }

procedure TAstNode.AddChild(toadd: TAstNode);
begin
  kinderen.Add(toadd);
end;

function TAstNode.ToString: ansistring;
begin
  Result:='naam node: ' + ClassName;
end;

constructor TAstNode.Create;
begin
  inherited Create;
  Self.kinderen:= TNodeList.Create;
end;

constructor TAstNode.Create(initkinderen: TNodeList);
begin
  inherited Create;
  self.kinderen:= initkinderen;
end;

{ TNumber }

function TNumber.GetValue: float;
begin
  Result:= value;
end;

procedure TNumber.Interpret(con: TContext);
begin
  raise Exception.Create('nog niet geimplementeerd');
end;

function TNumber.ToString: ansistring;
var
  retval: string;
begin
  retval:= inherited ToString + stnewlinetab;
  retval+= 'nummerwaarde: ' + value;

  Result:= retval;
end;

constructor TNumber.Create(val: float);
begin
  inherited Create;
  self.value:= val;
end;

{ TParameter }

procedure TParameter.Interpret(con: TContext);
begin
  raise Exception.Create('nog niet geimplementeerd');
end;

function TParameter.ToString: ansistring;
var
  retval: string;
begin
  retval:= inherited ToString + stnewlinetab;
  retval+= 'parameter naam: '+ Naam + stnewlinetab +
           'parameter value: ' + Value;

  Result:= retval;
end;

constructor TParameter.Create(cnaam: string; cvalue: float);
begin
  inherited Create;
  Self.Naam:= cnaam;
  self.Value:= cvalue;
end;

{ TInterpreter }

procedure TInterpreter.AddExpression(expr: TAstNode);
begin
  myexpressions.Add(expr);
end;

constructor TInterpreter.Create;
begin
  inherited Create;
  mycontext:= TContext.Create;
end;

constructor TInterpreter.Create(con: TContext);
begin
  inherited Create;
  mycontext:= con;
end;

{ TContext }

constructor TContext.Create(syms: TSymbolTable);
begin
  inherited Create;
  mysymbols:= syms;
end;

constructor TContext.Create;
begin
  inherited Create;
  mysymbols:= TSymbolTable.Create;
end;

end.
