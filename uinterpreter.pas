unit uinterpreter;
{
 deze unit bevat de interpreter
}

{$mode objfpc}

interface
uses
  Classes, fgl, sysutils, symtab, helpers, typinfo, variants, NonkelExceptions;

type
  TAstNode = class;

  TNodeList = specialize TFPGList<TAstNode>;
  TCompType = (GREATER, LESSER, EQUAL, NOT_EQUAL);
  TOperator = (OPERATOR_PLUS, OPERATOR_DIV, OPERATOR_MIN, OPERATOR_MUL);

  { TAstNode }

  TAstNode = class
    private
      mykinderen: TNodeList;
      myparent: TAstNode;
    public
      procedure Interpret(con: TContext);virtual;
      procedure AddChild(toadd: TAstNode);
      procedure AddSibling(toadd: TAstNode);

      //dit is een minder efficiënte methode
      procedure AddInFront(toadd: TAstNode);
      function ToString: ansistring; override;

      constructor Create;
      constructor Create(initkinderen: TNodeList);

      //een constructor die het mogelijk maakt om te initialiseren met één kind
      constructor Create(initkind: TAstNode);

      property Kinderen: TNodeList read mykinderen write mykinderen;
      property Parent: TAstNode read myparent write myparent;

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

  { TStatement }

  TStatement = class (TAstNode)
    private
      //het statement na dit statement. Nil indien er geen meer volgt
      mynext: TStatement;
    public
      constructor Create;
      constructor Create(cnext: TStatement);

      property Next: TStatement read mynext write mynext;
      procedure Interpret(con: TContext); override;
      function ToString: ansistring; override;
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



  { TScriptDeclaration }

  {Deze kasse stelt een hoofding voor van een programma}
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

  TConditional = class(TStatement)
    private
      myleft, myright: TNumber;
      comp: TCompType;
      block: TAstNode;
    protected
      function CheckCondition: boolean;
    public
      property Left: TNumber read myleft write myleft;
      property Right: TNumber read myright write myright;
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

  TAssingnment = class(TStatement)
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

function RevertList(input: TNodeList): TNodeList;
implementation
uses appunit;

{ TStatement }

constructor TStatement.Create;
begin
  mynext:= nil;
end;

constructor TStatement.Create(cnext: TStatement);
begin
  mynext:= cnext;
end;

procedure TStatement.Interpret(con: TContext);
begin
  if Assigned(mynext) then mynext.Interpret(con);
end;

function TStatement.ToString: ansistring;
begin
  Result:='nog geen tostring';
end;

{ TFunction }

constructor TFunction.Create(cname: string; ccode: TAstNode);
begin
  inherited Create;
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
  for tmp in mykinderen do
  begin
    if assigned(tmp) then
    begin
      Result+= tmp.ToString;
    end;
  end;
end;

procedure TFunction.Interpret(con: TContext);
var
  tmpnode: TAstNode;
begin
  for tmpnode in mykinderen do
  begin
    tmpnode.interpret(con);
  end;
end;

{ TAssignedNumber }

function TAssignedNumber.GetValue: real;
var
  tmp: TValue;
  exists: boolean;
  tmpsym: TSymbol;
begin
  //hier de symbolentabel van de interpreter aanspreken
  exists:= TNonkelScript.maininterpreter.Context.SymbolExists(myident);
  if not exists then begin
    raise TVariableNotExistsException.Create(myident);
    Result:= 0;
  end else begin
    tmpsym:= TNonkelScript.maininterpreter.Context.SearchSymbol(myident);
    Result:=tmpsym.Value.DoubleValue;
  end;
end;

procedure TAssignedNumber.Interpret(con: TContext);
begin
  inherited Interpret(con);
end;

function TAssignedNumber.ToString: ansistring;
begin
  Result:= inherited ToString;
  Result+= 'een assigned value: ' + myident + stnewline;
end;

constructor TAssignedNumber.Create(val: string);
begin
  //ik maak dit voorlopig nil
  inherited Create(nil);
  myident:= val;
end;

{ TWhileStatement }

procedure TWhileStatement.Interpret(con: TContext);
var
  tmpnode: TAstNode;
begin
  while CheckCondition do
  begin
      for tmpnode in mykinderen do tmpnode.Interpret(con);
  end;
  inherited Interpret(con);
end;

function TWhileStatement.ToString: AnsiString;
begin
  Result:=inherited ToString;
end;

{ TConditional }

function TConditional.CheckCondition: boolean;
var
  x, y: double;
begin
  //deze functie kijkt na of de voorwaarde waar of vals is.
  x:= Left.GetValue; y:= Right.GetValue;
  case Comparator of
    LESSER: if x < y then Result:= true else Result:= false;
    GREATER: if x > y then Result:= true else Result:= false;
    EQUAL: if x = y then Result:= true else Result:= false;
    NOT_EQUAL: if x <> y then Result:= true else Result:= false;
  end;
end;

procedure TConditional.Interpret(con: TContext);
begin
  //is er geen mooiere manier om dit op te lossen?
  raise Exception.Create('De interpret methode van deze klasse mag niet direct aangeroepen worden');
end;

function TConditional.ToString: AnsiString;
begin
  Result:=inherited ToString + stnewline;
  Result+= 'Left: ' + Left.ToString;
  Result+= 'Right: ' + Right.ToString;
end;

constructor TConditional.Create(cleft, cright: TAstNode; ccomp: TCompType;
  cblock: TAstNode);
begin
  inherited Create;
  self.Left:= cleft as TNumber;
  self.Right:= cright as TNumber;
  Self.comp:= ccomp;
  Self.CodeBlock:= cblock;
end;

{ TScriptDeclaration }

procedure TScriptDeclaration.Interpret(con: TContext);
var
  tmpnode: TAstNode;
begin
  for tmpnode in mykinderen do tmpnode.Interpret(con);
end;

function TScriptDeclaration.ToString: ansistring;
var
  tmp: TAstNode;
begin
  Result:=inherited ToString + stnewlinetab;
  Result+= 'Script naam: ' + Naam + stnewline + myprogram.ToString;
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
  //heeft geen specifieke implementatie.
end;

function TCalculation.ToString: ansistring;
begin
  Result:=inherited ToString + stnewline;
  Result+= 'Operator: ' + GetEnumName(TypeInfo(TOperator), integer(self.op)) + stnewline;
  Result+= 'Left:' + left.ToString;
  Result+= 'Right:' + stnewlinetab + right.ToString;
end;

constructor TCalculation.Create(cleft, cright: TAstNode; cop: TOperator);
begin
  //ik maak dit voorlopig nil
  inherited Create(nil);
  self.Left:= cleft as TNumber;
  self.Right:= cright as TNumber;
  self.op:= cop;
end;

{ TAssingnment }

procedure TAssingnment.Interpret(con: TContext);
begin
  con.PutSymbol(naam, Calculation.GetValue);
  inherited Interpret(con);
end;

function TAssingnment.ToString: AnsiString;
begin
  Result:=inherited ToString;
  Result+= 'Een assingment: ' + ident + stnewline;
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
var
  tmpnode: TAstNode;
begin
  for tmpnode in mykinderen do
  begin
    tmpnode.Interpret(con);
  end;
end;

function TCodeBlock.ToString: ansistring;
var
  tmp: TAstNode;
begin
  Result:=inherited ToString + stnewline;
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
var
  tmpnode: TAstNode;
begin
  if CheckCondition then
  begin
    for tmpnode in mykinderen do tmpnode.Interpret(con);
  end;
  inherited Interpret(con);
end;

function TIfStatement.ToString: AnsiString;
begin
  Result:=inherited ToString;
  Result += 'elseblock: ' + belse.ToString;
end;

constructor TIfStatement.Create(cleft, cright: TAstNode; ccomp: TCompType;
  cblock: TAstNode; celse: TAstNode);
begin
  self.Left:= cleft as TNumber;
  self.Right:= cright as TNumber;
  self.comp:= ccomp;
  self.CodeBlock:= cblock;
  self.ElseBlock:= celse;
end;

{ TAstNode }

procedure TAstNode.Interpret(con: TContext);
var
  tmp: TAstNode;
begin
  for tmp in mykinderen do
  begin
    tmp.Interpret(con);
  end;
end;

procedure TAstNode.AddChild(toadd: TAstNode);
begin
  if not Assigned(mykinderen) then mykinderen:= TNodeList.Create;
  mykinderen.Add(toadd);
end;

procedure TAstNode.AddSibling(toadd: TAstNode);
begin
  self.parent.AddChild(toadd);
end;

procedure TAstNode.AddInFront(toadd: TAstNode);
begin
  toadd.Parent:= self;
  mykinderen.Insert(0, toadd);
end;

function TAstNode.ToString: ansistring;
var
  tmp: TAstNode;
begin
  Result:='naam node: ' + ClassName + stnewline;
  for tmp in mykinderen do
  begin
    //een beetje een dodgy manier
    if Assigned(tmp) then
    begin
      Result+= tmp.ToString;
    end;
  end;
end;

constructor TAstNode.Create;
begin
  inherited Create;
  Self.mykinderen:= TNodeList.Create;
end;

constructor TAstNode.Create(initkinderen: TNodeList);
var
  tmp: TAstNode;
begin
  inherited Create;
  for tmp in initkinderen do
  begin
    tmp.Parent:= self;
  end;
  self.mykinderen:= initkinderen;
end;

constructor TAstNode.Create(initkind: TAstNode);
begin
  mykinderen:= TNodeList.Create;
  mykinderen.Add(initkind);
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
  //heeft geen specifieke implementatie
end;

function TNumber.ToString: ansistring;
var
  retval: string;
begin
  //retval:= inherited ToString + stnewline;
  retval:= 'nummerwaarde: ' + FloatToStr(self.GetValue) + stnewline;

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
  retval+= 'parameter naam: '+ Naam + stnewline;
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

function RevertList(input: TNodeList): TNodeList;
var
  tmp: TAstNode;
  total: integer;
  tmpint: integer;
begin
  total:= input.Count - 1;
  Result:= TNodeList.Create;
  for tmpint:= total downto 0 do
  begin
    tmp:= input.Items[tmpint];
    result.Add(tmp);
  end;
end;

end.

