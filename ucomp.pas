unit ucomp;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fgl;

type

  TAbstractComponent = class
    private
      mynaam: string;
    public
      procedure Add(item: TAbstractComponent); virtual; abstract;
      procedure Remove(item: TAbstractComponent); virtual; abstract;
      function Get(index: integer): TAbstractComponent; virtual; abstract;

      procedure process; virtual; abstract;

      property naam: string read mynaam write mynaam;

  end;

  TComponentList = specialize TFPGList<TAbstractComponent>;

  { TBlad }

  TBlad = class (TAbstractComponent)
    public

      constructor Create(x: string);

      procedure Add(item: TAbstractComponent); override;
      procedure Remove(item: TAbstractComponent); override;
      function Get(index: integer): TAbstractComponent; override;
      procedure process; override;
  end;

   { TTak }

   TTak = class (TAbstractComponent)
     private
       myitems: TComponentList;
     public
       constructor create(x: string);

       procedure Add(item: TAbstractComponent); override;
       procedure Remove(item: TAbstractComponent); override;
       function Get(index: integer): TAbstractComponent; override;
       procedure process; override;

       //Ik maak dit readonly. Ik weet niet waarom.?
       property items: TComponentList read myitems;

   end;

implementation

{ TTak }

constructor TTak.create(x: string);
begin
  myitems:= TComponentList.Create;
  self.naam:= x;
end;

procedure TTak.Add(item: TAbstractComponent);
begin
  self.myitems.Add(item);
end;

procedure TTak.Remove(item: TAbstractComponent);
begin
  myitems.Remove(item);
end;

function TTak.Get(index: integer): TAbstractComponent;
var
  retval: TAbstractComponent;
begin
  //gooit dit een exceptie?
  Retval:= items.Items[index];
  Result:= retval;
end;

procedure TTak.process;
var
  x: TAbstractComponent;
begin
  writeln('ik ben een tak: ', naam);
  for x in myitems do
  begin
    x.process;
  end;
end;

{ TBlad }

constructor TBlad.Create(x: string);
begin
  self.naam:= x;
end;

procedure TBlad.Add(item: TAbstractComponent);
begin
  raise Exception.Create('Dit is een leaf en ondersteunt deze operatie dus niet');
end;

procedure TBlad.Remove(item: TAbstractComponent);
begin
  raise Exception.Create('Dit is een leaf en ondersteunt deze operatie dus niet');
end;

function TBlad.Get(index: integer): TAbstractComponent;
begin
  raise Exception.Create('Dit is een leaf en ondersteunt deze operatie dus niet');
  Result:= nil;
end;

procedure TBlad.process;
begin
  writeln('ik ben een leaf: ', naam);
end;

end.

