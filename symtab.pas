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
      mynumber: double;

      mykind: TEnumKind;

    public
      constructor Create(val: boolean);
      constructor Create(val: double);
      constructor Create(val: string);
      function ToString: ansistring; override;

      property DoubleValue: double read mynumber;
      property Kind: TEnumKind read mykind;

  end;

  TSymbol = class
    private
      myname: string;
      myvalue: TValue;
      //om het debuggen van code gemakkelijker te maken
      mylinenum: integer;
      myglobal: boolean;

    public
      property Name: string read myname write myname;
      property Value: TValue read myvalue write myvalue;
      property Linenum: integer read mylinenum write mylinenum;
      property Global: boolean read myglobal write myglobal;

      Constructor Create(cname: String; ckind: TEnumKind; cvalue: TValue;
        clinenum: integer; cglobal: boolean);

      function ToString: ansistring; override;

  end;

  TSymbolTable = specialize TFPGList<TSymbol>;

implementation

{ TValue }

constructor TValue.Create(val: boolean);
begin
  mykind:= KIND_BOOL;
  myboolean:= val;
end;

constructor TValue.Create(val: double);
begin
  mykind:= KIND_NUMBER;
  mynumber:= val;
end;

constructor TValue.Create(val: string);
begin
  mykind:= KIND_STRING;
  mystring:= val;
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

//hier moeten een paar paramters uit worden verwijderd
constructor TSymbol.Create(cname: String; ckind: TEnumKind; cvalue: TValue;
  clinenum: integer; cglobal: boolean);
begin
  myname:= cname;
  myglobal:= cglobal;
  mylinenum:= clinenum;
  myvalue:= cvalue;
end;

function TSymbol.ToString: ansistring;
begin
  Result:= 'Symbol naam: ' + Name + ', value: ' + Value.ToString;
end;

end.

