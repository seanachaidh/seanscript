unit symtab;

{$mode objfpc}{$H+}

{
 in deze unit bewaren we de symbolentabel
}

interface

uses
  Classes, SysUtils, fgl, variants;

type
  TEnumKind = (KIND_BOOL, KIND_STRING, KIND_NUMBER);

  { TSymbol }

  //deze klasse moet  ervoor zorgen dat er zo weinig mogelijk gebruik gemaakt wordt
  //van het variant.

  { TValue }

  TValue = class
    private
      myboolean: boolean;
      mystring: string;
      mynumber: float;

      mykind: TEnumKind;

    public
      constructor Create(cvalue: variant; ckind: TEnumKind);
      function ToString: ansistring; override;

      property Kind: TEnumKind read mykind;

  end;

  TSymbol = class
    private
      myname: string;
      //is dit handig om te bewaren?
      mykind: TEnumKind;
      myvalue: Variant;
      //om het debuggen van code gemakkelijker te maken
      mylinenum: integer;
      myglobal: boolean;

    public
      property Name: string read myname write myname;
      //Is dit relevant?
      property Kind: TEnumKind read mykind write mykind;
      property Value: Variant read myvalue write myvalue;
      property Linenum: integer read mylinenum write mylinenum;
      property Global: boolean read myglobal write myglobal;

      Constructor Create(cname: String; ckind: TEnumKind; cvalue: Variant;
        clinenum: integer; cglobal: boolean);

      function ToString: ansistring; override;

  end;

  TSymbolTable = specialize TFPGList<TSymbol>;

implementation

{ TValue }

constructor TValue.Create(cvalue: variant; ckind: TEnumKind);
begin

end;

function TValue.ToString: ansistring;
begin
  case mykind of
  KIND_STRING: Result:= mystring;
  KIND_NUMBER: Result:= FloatToStr(mynumber);
  KIND_BOOL: Result:= BoolToStr(myboolean, 'true', 'false');
  end;
end;

{ TSymbol }

constructor TSymbol.Create(cname: String; ckind: TEnumKind; cvalue: Variant;
  clinenum: integer; cglobal: boolean);
begin
  myname:= cname;
  mykind:= ckind;
  myglobal:= cglobal;
  mylinenum:= clinenum;
  myvalue:= cvalue;
end;

function TSymbol.ToString: ansistring;
begin
  Result:= 'Symbol naam: ' + Name + ', value: ' + Value;
end;

end.

