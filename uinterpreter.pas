unit uinterpreter;
{
 deze unit bevat de interpreter
}

{$mode objfpc}

interface
uses
  Classes, fgl, sysutils, symtab, helpers;

type
  //deze enum wordt gebruikt bij vergelijkingen
  TCompType = (GREATER, LESSER, EQUAL);
  TContext = class;

  { TAstNode }

  TAstNode = class
    public
      procedure Interpret(con: TContext);virtual; abstract;
      function ToString: ansistring; override;
  end;

  { TParameter }

  TParameter = class(TAstNode)
    private
      mynaam: string;
      myvalue: Variant;
    public
      property Naam: string read mynaam write mynaam;
      property Value: Variant read myvalue write myvalue;

      procedure Interpret(con: TContext); override;
      function ToString: ansistring; override;
      constructor Create(cnaam: string; cvalue: variant);
  end;

  TNodeList = specialize TFPGList<TAstNode>;
  TParameterList = specialize TFPGList<TParameter>;

  {Deze klasse stelt een nummer voor}

  { TNumber }

  TNumber = class(TAstNode)
    private
      value: Variant;
    public
      function GetValue: Variant; virtual;
      procedure Interpret(con: TContext); override;
      function ToString: ansistring; override;

      Constructor Create(val: Variant);
  end;

  {Deze klasse stelt een berekening voor}
  TCalculation = class(TNumber)
    private
      myleft, myright: TNumber;
    public
      property Left: TNumber read myleft write myleft;
      property Right: TNumber read myright write myright;

      function GetValue: Variant; override;
      procedure Interpret(con: TContext); override;
      function ToString: ansistring; override;

      constructor Create(cleft, cright: TNumber);
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
  TScriptDeclaration = class(TAstNode)
    private
      mynaam: String;
    public
      property Naam: string read mynaam write mynaam;
      procedure Interpret(con: TContext); override;
      function ToString: ansistring; override;

      constructor Create(cnaam: String);
  end;

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
  self.Left:= cleft;
  self.Right:= cright;
  self.comp:= ccomp;
  self.CodeBlock:= cblock;
  self.ElseBlock:= celse;
end;

{ TAstNode }

function TAstNode.ToString: ansistring;
begin
  Result:='naam node: ' + ClassName;
end;

{ TNumber }

function TNumber.GetValue: Variant;
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

constructor TNumber.Create(val: Variant);
begin
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

constructor TParameter.Create(cnaam: string; cvalue: variant);
begin
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
  mycontext:= TContext.Create;
end;

constructor TInterpreter.Create(con: TContext);
begin
  mycontext:= con;
end;

{ TContext }

constructor TContext.Create(syms: TSymbolTable);
begin
  mysymbols:= syms;
end;

constructor TContext.Create;
begin
  mysymbols:= TSymbolTable.Create;
end;

end.

