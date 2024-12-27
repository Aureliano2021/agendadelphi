program prj_contatos;

uses
  Vcl.Forms,
  unt_agendadecontatos in 'unt_agendadecontatos.pas' {Form1},
  unt_validacaoemail in 'unt_validacaoemail.pas',
  unt_editarcontato in 'unt_editarcontato.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
