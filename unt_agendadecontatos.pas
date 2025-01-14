unit unt_agendadecontatos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  unt_validacaoemail, unt_editarcontato;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    edt_Nome: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    medt_telefone: TMaskEdit;
    Label3: TLabel;
    medt_email: TMaskEdit;
    btn_salvar: TButton;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    btn_Delete: TButton;
    btn_Editar: TButton;
    Label11: TLabel;
    procedure medt_emailExit(Sender: TObject);
    procedure edt_NomeExit(Sender: TObject);
    procedure btn_salvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure btn_EditarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.btn_DeleteClick(Sender: TObject);
var
NomeSel: String;
IndiceSel: Integer;
Agenda: TStringList;
begin
try
  Agenda := TStringList.Create;
  Agenda.LoadFromFile('C:\Users\Congregação Jucati\Documents\Embarcadero\Studio\Projects\Agenda\contatos.txt');
  IndiceSel := ListBox1.ItemIndex;

  NomeSel := ListBox1.Items[IndiceSel];
  Agenda.Delete(Agenda.IndexOf(NomeSel) + 2);
  Agenda.Delete(Agenda.IndexOf(NomeSel) + 1);
  Agenda.Delete(Agenda.IndexOf(NomeSel));
  ListBox1.Items.Delete(IndiceSel);

  Agenda.SaveToFile('C:\Users\Congregação Jucati\Documents\Embarcadero\Studio\Projects\Agenda\contatos.txt');
  ListBox1.Items.SaveToFile('C:\Users\Congregação Jucati\Documents\Embarcadero\Studio\Projects\Agenda\lista.txt')
finally
  Agenda.Free;
  Label8.Caption := '';
  Label9.Caption := '';
  Label10.Caption := '';
end;
end;

procedure TForm1.btn_EditarClick(Sender: TObject);
var
lIndice: Integer;
Form2: TForm2;
Agenda: TStringList;
begin
   lIndice := ListBox1.ItemIndex;

   if lIndice = -1 then
  begin
    ShowMessage('Nenhum item selecionado.');
    Exit;
  end;
   Agenda := TStringList.Create;
   Agenda.LoadFromFile('C:\Users\Congregação Jucati\Documents\Embarcadero\Studio\Projects\Agenda\contatos.txt');
   Form2 := TForm2.Create(Self);
   try
     if Agenda.IsEmpty then
     Exit
     else

     Form2.NomeSel := ListBox1.Items[lIndice];
     Form2.Edit1.Text := Form2.NomeSel;
     Form2.Edit2.Text := Agenda.Strings[Agenda.IndexOf(Form2.NomeSel)+2];

     Form2.MaskEdit1.EditMask := '';
     Form2.MaskEdit1.Text := Agenda.Strings[Agenda.IndexOf(Form2.NomeSel)+1];
     Form2.MaskEdit1.EditMask := '(00)00000-0000;0; ';

     Form2.ShowModal;

     if Form2.Cancelar <> True then
     begin
     ListBox1.Items[lIndice] := Form2.NomeEdit;
     ListBox1.Items.SaveToFile('C:\Users\Congregação Jucati\Documents\Embarcadero\Studio\Projects\Agenda\lista.txt');
     end;
   finally
     Form2.Free;
     Agenda.Free;
   end;
end;

procedure TForm1.btn_salvarClick(Sender: TObject);
var
 Nome: String;
 Telefone: String;
 Email: String;
 Agenda: TStringList;
begin
  Nome := edt_Nome.Text;
  Telefone := medt_telefone.Text;
  Email := medt_email.Text;
  try
    Agenda := TStringList.Create;
    Agenda.LoadFromFile('C:\Users\Congregação Jucati\Documents\Embarcadero\Studio\Projects\Agenda\contatos.txt');
    Agenda.Add(Nome);
    Agenda.Add(Telefone);
    Agenda.Add(Email);

    Agenda.SaveToFile('C:\Users\Congregação Jucati\Documents\Embarcadero\Studio\Projects\Agenda\contatos.txt');

    ListBox1.Items.Add(Nome);
    ListBox1.Items.SaveToFile('C:\Users\Congregação Jucati\Documents\Embarcadero\Studio\Projects\Agenda\lista.txt');
  finally
    edt_Nome.Clear;
    medt_telefone.Clear;
    medt_email.Clear;
    Agenda.Free;
  end;

end;

procedure TForm1.edt_NomeExit(Sender: TObject);
var
  contador: integer;
  texto: string;
begin
  texto := edt_Nome.Text;
  contador := texto.Length;

  if contador < 2 then
  begin
    ShowMessage('Nome precisa conter no minímo 2 letras');
    edt_Nome.SetFocus;
  end;


end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ListBox1.Items.LoadFromFile('C:\Users\Congregação Jucati\Documents\Embarcadero\Studio\Projects\Agenda\lista.txt');
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
var
  IndiceSel: Integer;
  NomeSel: String;
  Agenda: TStringList;
begin

  try
    IndiceSel := ListBox1.ItemIndex;

    if IndiceSel <> -1 then
    begin
      NomeSel := ListBox1.Items[IndiceSel];
      Agenda := TStringList.Create;
      Agenda.LoadFromFile('C:\Users\Congregação Jucati\Documents\Embarcadero\Studio\Projects\Agenda\contatos.txt');

      Label8.Caption := Agenda.Strings[Agenda.IndexOf(NomeSel)];
      Label9.Caption := Agenda.Strings[Agenda.IndexOf(NomeSel) + 1];
      Label10.Caption := Agenda.Strings[Agenda.IndexOf(NomeSel) + 2];

    end;


  finally
  Agenda.Free
  end;


end;

procedure TForm1.medt_emailExit(Sender: TObject);
var
 ValidaEmail: TValidaEmail;
begin
    try
      ValidaEmail:= TValidaEmail.Create;

      if medt_email.Text = '' then
        Exit
      else if ValidaEmail.ValidaEmailRegex(medt_email.Text) = false then
      begin
        ShowMessage('E-mail inválido, tente novamente');
        medt_email.SetFocus;
      end;


    finally
      ValidaEmail.Free;
    end;

end;

end.
