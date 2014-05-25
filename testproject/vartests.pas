unit vartests;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, varsystem;

type

  { VarSystemTestCase }

  VarSystemTestCase= class(TTestCase)
  private
    testlist: TNonkelVarContainer;

  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published

    procedure TestGet;
    procedure TestSet;
    procedure TestExist;

  end;

implementation

procedure VarSystemTestCase.SetUp;
begin
  testlist:= TNonkelVarContainer.Create;
end;

procedure VarSystemTestCase.TearDown;
begin
  {voorlopig nog niets}
end;

procedure VarSystemTestCase.TestGet;
var
  x: integer;
  setretval: boolean;
begin
  setretval:= testlist.setvar('hello', 5);
  x:= testlist.getvar('hello');

  //kijken of de variable wel degelijk is toegevoegd
  AssertTrue(setretval);
  AssertEquals(x, 5);
end;

procedure VarSystemTestCase.TestSet;
var
  setretval: boolean;
  x: integer;
begin
  setretval:= testlist.setvar('hey', 5);
  AssertTrue(setretval);
  x:= testlist.getvar('hey');
  AssertEquals(x, 5);

  setretval:= testlist.setvar('hey', 6);
  AssertTrue(not setretval);
  x:=testlist.getvar('hey');
  AssertEquals(x, 6);


end;

procedure VarSystemTestCase.TestExist;
begin
  testlist.setvar('hey', 8);
  AssertTrue(testlist.exist('hey'));
end;

initialization
  RegisterTest(VarSystemTestCase);
end.

