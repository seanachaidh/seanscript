unit uinterpreter;
{
 deze unit bevat de interpreter
}

{$mode objfpc}

interface
uses
  Classes, fgl, sysutils, symtab, helpers, typinfo, variants;

type
  TContext = class;
  TAstNode = class;

  TNodeList = specialize TFPGList<TAstNode>;
  TCompType = (GREATER, LESSER, EQUAL, NOT_EQUAL);
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
      myvalue: real;
    public
      property Naam: string read mynaam write mynaam;
      property Value: real read myvalue write myvalue;

      procedure Interpret(con: TContext); override;
      function ToString: ansistring; override;
      constructor Create(cnaam: string; cvalue: real);
  end;

  TParameterList = specialize TFPGList<TParameter>;

  {Deze klasse stelt een nummer voor}

  { TNumber }

  TNumber = class(TAstNode)
    private
      value: TValue;
    public
      function GetValue: double; virtual;
      procedure Interpret(con: TContext); override;
      function ToString: ansistring; override;

      Constructor Create(val: TValue);

  end;

  { TAssignedNumber }

  TAssignedNumber = class(TNumber)
    private
      myident: String;
    public
      function GetValue: real; override;
      procedure Interpret(con: TContext); override;
      function ToString: ansistring; override;

      constructor Create(val: string);
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

      function GetValue: real; override;
      procedure Interpret(con: TContext); override;
      function ToString: ansistring; override;

      constructor Create(cleft, cright: TAstNode; cop: TOperator);
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
      block: TAstNode;
    public
      property Left: TCalculation read myleft write myleft;
      property Right: TCalculation read myright write myright;
      property Comparator: TCompType read comp write comp;
      property CodeBlock: TAstNode read block write block;

      procedure Interpret(con: TContext); override;
      function ToString: AnsiString; override;

      //de codeblock moet hier nog veranderd worden door een AstNode
      constructor Create(cleft, cright: TAstNode; ccomp: TCompType;
        cblock: TAstNode);
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
      belse: TAstNode;
    public
      property ElseBlock: TAstNode read belse write belse;
      procedure Interpret(con: TContext); override;
      function ToString: AnsiString; override;

      constructor Create(cleft, cright: TAstNode; ccomp: TCompType;
        cblock: TAstNode; celse: TAstNode);
  end;

  { TAssingnment }

  TAssingnment = class(TAstNode)
    private
      num: TNumber;
      ident: String;
      mynewval: boolean;
    public
      property Calculation: TNumber read num write num;
      property Naam: string read ident write ident;
      property NewValue: boolean read mynewval;

      procedure Interpret(con: TContext); override;
      function ToString: AnsiString; override;

      constructor Create(cident: string; cnewval: boolean);
      constructor Create(cident: string; cnewval: boolean; cnum: TAstNode);

  end;

  { TContext }

  TContext = class
    private
      mysymbols: TSymbolTable;
    public
      property Symbols: TSymbolTable read mysymbols write mysymbols;

      //functies om de symbolentabel van deze context te beheren
      function SearchSymbol(snaam: string): TSymbol;
      {
      update een symbol
      Deze funtie geeft true wanneer er een symbol is toegevoegd
      False wanneer het slechts geüpdated is
      }
      function PutSymbol(snaam: string; svalue: variant): boolean;

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

      procedure ShowString;
      procedure ExecuteProgram;

  end;

  { TFunction }

  TFunction = class(TAstNode)
    private
      mymain: boolean;
      myname: string;
      myparameters: TParameterList;
    public
      constructor Create(cname: string; ccode: TAstNode);
      constructor Create(cname: string; cparameters: TParameterList; ccode: TAstNode);

      function ToString: ansistring; override;
      procedure Interpret(con: TContext); override;

  end;

implementation
uses appunit;

{ TFunction }

constructor TFunction.Create(cname: string; ccode: TAstNode);
begin
  myname:= cname;
  myparameters:= TParameterList.Create;
  AddChild(ccode);
end;

constructor TFunction.Create(cname: string; cparameters: TParameterList;
  ccode: TAstNode);
begin
  myparameters:= cparameters;
  myname:= cname;
  AddChild(ccode);
end;

function TFunction.ToString: ansistring;
var
  tmp: TAstNode;
begin
  Result:=inherited ToString + stnewline;
  Result+= 'functie naam: ' + myname + stnewline;
  for tmp in kinderen do
  begin
    Result+= tmp.ToString;
  end;
end;

procedure TFunction.Interpret(con: TContext);
begin

end;

{ TAssignedNumber }

function TAssignedNumber.GetValue: real;
begin
  //hier de symbolentabel van de interpreter aanspreken
  //tmp:=
  Result:= 0;
end;

procedure TAssignedNumber.Interpret(con: TContext);
begin
  inherited Interpret(con);
end;

function TAssignedNumber.ToString: ansistring;
begin
  Result:= inherited ToString;
  Result+= 'een assigned value: ' + myident;
end;

constructor TAssignedNumber.Create(val: string);
begin
  myident:= val;
end;

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

constructor TConditional.Create(cleft, cright: TAstNode; ccomp: TCompType;
  cblock: TAstNode);
begin
  self.Left:= cleft as TCalculation;
  self.Right:= cright as TCalculation;
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
  for tmp in toadd do
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

function TCalculation.GetValue: real;
begin
  //hier een case zetten die afhandelt wanneer er een boolean en een string wordt gebruikt
  case op of
  OPERATOR_PLUS: Result:= Left.GetValue + Right.GetValue;
  OPERATOR_MIN: Result:= Left.GetValue - Right.GetValue;
  OPERATOR_DIV: Result:= Left.GetValue / Right.GetValue;
  OPERATOR_MUL: Result:= Left.GetValue * Right.GetValue;
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

constructor TCalculation.Create(cleft, cright: TAstNode; cop: TOperator);
begin
  self.Left:= cleft as TNumber;
  self.Right:= cright as TNumber;
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

constructor TAssingnment.Create(cident: string; cnewval: boolean);
begin
  inherited Create;
  self.ident:= cident;
  self.mynewval:= cnewval;
end;

constructor TAssingnment.Create(cident: string; cnewval: boolean; cnum: TAstNode);
begin
  inherited Create;
  Self.ident:= cident;
  self.num:= cnum as TNumber;
  Self.mynewval:= cnewval;
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

constructor TIfStatement.Create(cleft, cright: TAstNode; ccomp: TCompType;
  cblock: TAstNode; celse: TAstNode);
begin
  self.Left:= cleft as TCalculation;
  self.Right:= cright as TCalculation;
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

function TNumber.GetValue: double;
begin
  if value.Kind = KIND_NUMBER then
  begin
    Result:= StrToFloat(value.ToString);
  end else begin
    Result:= 0;
  end;
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
  //retval+= 'nummerwaarde: ' + FloatToStr(self.GetValue);

  Result:= retval;
end;

constructor TNumber.Create(val: TValue);
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
           'parameter value: ' + FloatToStr(Value);

  Result:= retval;
end;

constructor TParameter.Create(cnaam: string; cvalue: real);
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
  myexpressions:= TNodeList.Create;
end;

constructor TInterpreter.Create(con: TContext);
begin
  inherited Create;
  mycontext:= con;
end;

procedure TInterpreter.ShowString;
var
  tmp: TAstNode;
begin
  for tmp in myexpressions do
  begin
      writeln(tmp.ToString);
  end;
end;

procedure TInterpreter.ExecuteProgram;
var
  tmp: TAstNode;
begin
  for tmp in myexpressions do
  begin
      tmp.Interpret(mycontext);
  end;
end;

{ TContext }

function TContext.SearchSymbol(snaam: string): TSymbol;
var
  tmp: TSymbol;
begin
  Result:= nil;

  for tmp in Symbols do
  begin
    if tmp.Name = snaam then
    begin
      Result:= tmp;
    end;
  end;

end;

function TContext.PutSymbol(snaam: string; svalue: variant): boolean;
var
  //ik maak gebruik van deze variable in plaats van result ten behoeve van de leesbaarheid.
  retval: boolean;
  tmpsymbol: TSymbol;
  tmpkind: TEnumKind;
begin
  retval:= true;

  for tmpsymbol in Symbols do
  begin
    if snaam = tmpsymbol.Name then
    begin
      tmpsymbol.Value:= TValue.Create(svalue);
      retval:= false;
    end;
  end;

  if retval then
  begin
    Symbols.Add(TSymbol.Create(snaam, TValue.Create(svalue), 0, true));
  end;

  Result:= retval;
end;

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
