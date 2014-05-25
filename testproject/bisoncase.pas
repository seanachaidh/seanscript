unit bisoncase;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, bisonunit;

type

  TBisonCase= class(TTestCase)
  protected
    procedure SetUp; override;
  published
    procedure TestReadString;
  end;

implementation

procedure TBisonCase.TestReadString;
var
  tmpstring: string;
begin
  tmpstring:= '5';
  bisonunit.ReadFromString(tmpstring);

  Fail('Ik kan bij deze test geen resultaat opvragen');
end;

procedure TBisonCase.SetUp;
begin
  {voorlopig heb ik geen setup nodig}
end;


initialization

  RegisterTest(TBisonCase);
end.

