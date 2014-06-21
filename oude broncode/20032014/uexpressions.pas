unit uexpressions;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fgl;

type
  //deze enum wordt gebruikt bij vergelijkingen
  TCompType = (GREATER, LESSER, EQUAL);

  TAstNode = class
    public
      procedure Interpret(con: TContext);virtual; abstract;
  end;

  TNodeList = specialize TFPGList<TAstNode>;
  TParameter = class(TAstNode);

  {Deze klasse stelt een nummer voor}
  TNumber = class(TAstNode)
    private
      value: Variant;
    public
      function GetValue: Variant; virtual;
      procedure Interpret(con: TContext); override;

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
      constructor Create(cleft, cright: TNumber);
  end;

  {Deze klasse stelt een block voor}
  TCodeBlock = class (TAstNode)
    private
      mystatements: TNodeList;
    public
      property Statements: TNodeList read mystatements write mystatements;

      procedure Interpret(con: TContext); override;
      constructor Create;
  end;

  {Deze kasse stelt een hoofding voor van een programma}
  TScriptDeclaration = class(TAstNode)
    private
      mynaam: String;
    public
      property Naam: string read mynaam write mynaam;
      procedure Interpret(con: TContext); override;

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
      constructor Create(cleft, cright: TCalculation; ccomp: TCompType;
        cblock: TCodeBlock);
  end;

  TWhileStatement = class(TConditional)
    public
      procedure Interpret(con: TContext); override;
  end;

  TIfStatement = class(TConditional)
    private
      belse: TCodeBlock;
    public
      property ElseBlock: TCodeBlock read belse write belse;
      procedure Interpret(con: TContext); override;
      constructor Create(cleft, cright: TCalculation; ccomp: TCompType;
        cblock: TCodeBlock; celse: TCodeBlock);
  end;

  TParameter = class(TAstNode)
    private
      mynaam: string;
      myvalue: Variant;
    public
      property Naam: string read mynaam write mynaam;
      property Value: Variant read myvalue write myvalue;

      procedure Interpret(con: TContext); override;
      constructor Create(cnaam: string; cvalue: variant);

  end;

implementation

end.

