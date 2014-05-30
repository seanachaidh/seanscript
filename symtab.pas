unit symtab;

{$mode objfpc}{$H+}

{
 in deze unit bewaren we de symbolentabel
}

interface

uses
  Classes, SysUtils, fgl;

type
  TEnumType = (KIND_BOOL, KIND_STRING, KIND_INTEGER, KIND_FLOAT);
  TSymbol = class
    private
      myname: string;
      mykind: TEnumType;
      myvalue: Variant;
      //om het debuggen van code gemakkelijker te maken
      mylinenum: integer;
      myglobal: boolean;

    public
      property Name: string read myname write myname;
      property Kind: TEnumType read mykind write mykind;
      property Value: Variant read myvalue write myvalue;
      property Linenum: integer read mylinenum write mylinenum;
      property Global: boolean read myglobal write myglobal;

  end;

  TFunction = class(TSymbol)
    private
      myparams: integer;
      param_kinds: array of TEnumType;
    public
      property Params: integer read myparams write myparams;
  end;

  TSymbolList = specialize TFPGList<TSymbol>;
var
  symlist TSymbolList;

implementation

initialization
symlist:= TSymbolList.Create;

end.

