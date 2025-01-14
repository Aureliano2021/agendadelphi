unit unt_validacaoemail;

interface

uses

System.RegularExpressions, Vcl.Mask;

type
  TValidaEmail = class
    private
    FEmail: String;
    FRegEx : TRegEx;
    public
      function ValidaEmailRegex(Value:String) : Boolean;
      property Email: String read FEmail write FEmail;
      end;


implementation

{ TValidaEmail }

function TValidaEmail.ValidaEmailRegex(Value:String): Boolean;
begin
  FEmail :=  Value;
  FRegEx := TRegEx.Create('^[\w\.-]+@[\w\.-]+\.\w+$');

  if not FRegEx.IsMatch(FEmail) then
  begin
     Result := false;
  end
  else
    Result:= true;
end;

end.
