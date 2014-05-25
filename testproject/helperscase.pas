unit helperscase;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, helpers;

type

  { THelpersCase }

  THelpersCase= class(TTestCase)
  published
    procedure TestRandomString;
  end;

implementation

procedure THelpersCase.TestRandomString;
var
  tmpstring: string;
begin
  tmpstring:= helpers.GenerateRandomString;
  AssertFalse(tmpstring = '');
end;



initialization

  RegisterTest(THelpersCase);
end.

