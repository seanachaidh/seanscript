unit symtab;

{$mode objfpc}{$H+}

{
 in deze unit bewaren we de symbolentabel
}

interface

uses
  Classes, SysUtils, fgl;

type
  TEnumKind = (KIND_BOOL, KIND_STRING, KIND_INTEGER, KIND_FLOAT);

  { TSymbol }

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

  end;

  TSymbolTable = specialize TFPGList<TSymbol>;

implementation

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

end.

