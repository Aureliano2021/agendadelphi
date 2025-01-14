unit unt_editarcontato;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    MaskEdit1: TMaskEdit;
    Edit2: TEdit;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FNomeSel: String;
    FNomeEdit: String;
    FCancelar: boolean;
    { Private declarations }
  public
    { Public declarations }
    property NomeSel: String read FNomeSel write FNomeSel;
    property NomeEdit: String read FNomeEdit write FNomeEdit;
    property Cancelar: boolean read FCancelar write FCancelar;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var
Agenda: TStringList;
begin
  try
    Agenda := TStringList.Create;
    Agenda.LoadFromFile('C:\Users\Congregação Jucati\Documents\Embarcadero\Studio\Projects\Agenda\contatos.txt');
    Agenda.Strings[Agenda.IndexOf(FNomeSel) + 2] := Edit2.Text;
    Agenda.Strings[Agenda.IndexOf(FNomeSel) + 1] := MaskEdit1.Text;
    Agenda.Strings[Agenda.IndexOf(FNomeSel)] := Edit1.Text;
    Agenda.SaveToFile('C:\Users\Congregação Jucati\Documents\Embarcadero\Studio\Projects\Agenda\contatos.txt');
    FNomeEdit := Edit1.Text;
  finally
    Agenda.Free;
    Close;
  end;

end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  FCancelar := true;
  Close;
end;

end.
