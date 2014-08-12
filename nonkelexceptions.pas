unit NonkelExceptions;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TVariableNotExistsException }

  TVariableNotExistsException = class(Exception)
    private
      varname: string;
    public
      constructor Create(cname: string);
      property Name: string read varname write varname;
  end;

implementation

{ TVariableNotExistsException }

constructor TVariableNotExistsException.Create(cname: string);
begin
  inherited Create(Format('De variable bestaat niet: %s', [cname]));
  self.Name:= cname;
end;

end.

