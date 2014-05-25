unit conditionsystem;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, variants;

type
  TConditionType = (CIF, CWHILE, CFOR);
  TCmpType = (GREATER, LESSER, EQUAL);

  { TNonkelCondition }

  TNonkelCondition = class
    ctype: TConditionType;
    cmptype: TCmpType;
    x, y: Variant;
    public
      constructor Create(cx, cy: Variant; cmp: TCmpType; cctype: TConditionType);
      function CeckCondition: boolean;
  end;

implementation

{ TNonkelCondition }

constructor TNonkelCondition.Create(cx, cy: Variant; cmp: TCmpType;
  cctype: TConditionType);
begin
  Self.x:= cx;
  Self.y:= cy;
  self.cmptype:= cmp;
  Self.ctype:= cctype;
end;

function TNonkelCondition.CeckCondition: boolean;

function PerformIf: boolean;
begin
  case cmptype of
    GREATER: if x > y then Result:= true else Result:= false;
    LESSER: if x < y then Result:= true else Result:= false;
    EQUAL: if x = y then Result:= true else Result:= false;
  end;
end;

begin

  //Dat wat nog niet geïmplementeerd is geeft false terug
  case ctype of
    CIF: Result:= PerformIf;
    CWHILE: Result:= false;
    CFOR: Result:= False;
  end;
end;

end.

