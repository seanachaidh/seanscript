unit varsystem;

{
 deze unit houdt het variablesysteem bij
}

{$mode objfpc}{$H+}
interface

uses
  Classes, SysUtils, variants, fgl;

type

  { TNonkelVar }

  //type TNonkelCallback = procedure(sender: TObject; Skript: pointer) of object;

  TNonkelVar = class
    private
      myvalue: Variant;
      myname: string;
      //function pointer (
      //FOnInit : TNonkelCallback;
    public
      property name: string read myname write myname;
      property value: variant read myvalue write myvalue;
      //property OnInit : TNonkelCallback read FOnInit write FOnInit;

      constructor Create(naam: string; val: variant);
      procedure WriteVar;

      //geeft een lege variable terug
      class function EmptyVar: TNonkelVar;

  end;

  TNonkelVarList = specialize TFPGList<TNonkelVar>;

  { TNonkelVarContainer }

  TNonkelVarContainer = class
    private
      mylist: TNonkelVarList;
    public
      constructor Create;

      property Varlist: TNonkelVarList read mylist;

      function getvar(naam: string): TNonkelVar;
      function setvar(naam: string; toset: TNonkelVar): TNonkelVar;
      function exist(naam: string): boolean;
  end;



//niet objectgeoriënteerde procedures
procedure WriteDown(towrite: TNonkelVar);

//aritmatische bewerkingen
function DoPlus(x, y: TNonkelVar): TNonkelVar;
function DoMin(x, y: TNonkelVar): TNonkelVar;
function DoMul(x, y: TNonkelVar): TNonkelVar;
function DoDiv(x, y: TNonkelVar): TNonkelVar;

var
  vlist: TNonkelVarContainer;

implementation

procedure WriteDown(towrite: TNonkelVar);
begin
  towrite.WriteVar;
  WriteLn;
end;

function DoPlus(x, y: TNonkelVar): TNonkelVar;
var
  retval: TNonkelVar;
  resultaat: Variant;
begin
  resultaat:= x.value + y.value;
  retval:= TNonkelVar.Create('result', resultaat);

  Result:= retval;
end;

function DoMin(x, y: TNonkelVar): TNonkelVar;
var
  retval: TNonkelVar;
  resultaat: variant;
begin
  resultaat:= x.value - y.value;
  retval:= TNonkelVar.Create('result', resultaat);

  Result:= retval;
end;

function DoMul(x, y: TNonkelVar): TNonkelVar;
var
  retval: TNonkelVar;
  resultaat: variant;
begin
  resultaat:= x.value * y.value;
  retval:= TNonkelVar.Create('result', resultaat);

  Result:= retval;
end;

function DoDiv(x, y: TNonkelVar): TNonkelVar;
var
  retval: TNonkelVar;
  resultaat: variant;
begin
  resultaat:= x.value / y.value;
  retval:= TNonkelVar.Create('result', resultaat);

  Result:= retval;
end;

constructor TNonkelVar.Create(naam: string; val: variant);
begin
  self.name:= naam;
  self.value:= val;
end;

procedure TNonkelVar.WriteVar;
begin
  write(myvalue);
end;

class function TNonkelVar.EmptyVar: TNonkelVar;
var
  retval: TNonkelVar;
begin

  retval:= TNonkelVar.Create('nil', nil);
  Result:= retval;

end;

{ TNonkelVarContainer }

constructor TNonkelVarContainer.Create;
begin
  mylist:= TNonkelVarList.Create;
end;

function TNonkelVarContainer.getvar(naam: string): TNonkelVar;
var
  retval: TNonkelVar;
  x: TNonkelVar;
begin
  for x in mylist do
  begin
    if x.name = naam then
    begin
      retval:= x;
    end;
  end;
  result:= retval;
end;

function TNonkelVarContainer.setvar(naam: string; toset: TNonkelVar): TNonkelVar;
var
  tmpvar: TNonkelVar;
  retval: TNonkelVar;
begin
  if not exist(naam) then
  begin
    tmpvar:= TNonkelVar.Create(naam, toset.value);
    mylist.Add(tmpvar);

    //waar teruggeven als er een nieuwe variable aan de lijst is toegevoegd
    retval:= tmpvar;

  end else begin
    for tmpvar in mylist do
    begin
      if tmpvar.name = naam then
      begin
        tmpvar.value:= toset.value;
      end;
    end;
    //vals teruggeven als de waarde van een bestaande variable is veranderd
    retval:= TNonkelVar.EmptyVar;
  end;

  Result:= retval;
end;

function TNonkelVarContainer.exist(naam: string): boolean;
var
  retval: boolean;
  x: TNonkelVar;
begin
  retval:= false;

  for x in mylist do
  begin
    if x.name = naam then
    begin
      retval:= true;
    end;
  end;
  result:= retval;
end;

initialization
vlist:= TNonkelVarContainer.Create;

end.

