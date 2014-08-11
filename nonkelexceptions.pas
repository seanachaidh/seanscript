unit NonkelExceptions;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  { VariableExistsException }

  VariableExistsException = class(Exception)
    private
      varname: string;
    public
      constructor Create(cname: string);
      property Name: string read varname write varname;
  end;

implementation

{ VariableExistsException }

constructor VariableExistsException.Create(cname: string);
begin
  inherited Create('Variable bestaat al: ', cname);
  self.Name:= cname;
end;

end.

