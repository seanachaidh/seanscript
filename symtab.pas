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
      constructor Create(val: variant);

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

      Constructor Create(cname: String; cvalue: TValue;
        clinenum: integer; cglobal: boolean);

      function ToString: ansistring; override;

  end;

  TSymbolList = specialize TFPGList<TSymbol>;


  { TContext }

  TContext = class
    private
      mysymbols: TSymbolList;
    public
      property Symbols: TSymbolList read mysymbols write mysymbols;

      //functies om de symbolentabel van deze context te beheren

      //deze functie zoekt een symbool op. Geeft nil indien dit symbool niet gevonden werd
      function SearchSymbol(snaam: string): TSymbol;
      {
      update een symbol
      Deze funtie geeft true wanneer er een symbol is toegevoegd
      False wanneer het slechts geüpdated is
      }
      function PutSymbol(snaam: string; svalue: variant): boolean;

      constructor Create(syms: TSymbolList);
      constructor Create;
  end;

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

constructor TValue.Create(val: variant);
begin
  if VarIsNumeric(val) then
  begin
    mykind:= KIND_NUMBER;
    myboolean:= val;
  end else if VarIsStr(val) then
  begin
    mykind:= KIND_STRING;
    mystring:= val;
  end else if VarIsBool(val) then
  begin
    mykind:= KIND_BOOL;
    myboolean:= val;
  end;
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
constructor TSymbol.Create(cname: String; cvalue: TValue;
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

constructor TContext.Create(syms: TSymbolList);
begin
  inherited Create;
  mysymbols:= syms;
end;

constructor TContext.Create;
begin
  inherited Create;
  mysymbols:= TSymbolList.Create;
end;

end.

