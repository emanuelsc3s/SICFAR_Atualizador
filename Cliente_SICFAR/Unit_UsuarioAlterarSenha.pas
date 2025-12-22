unit Unit_UsuarioAlterarSenha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IBX.IBCustomDataSet, Data.DB, idHashMessageDigest,
  IBX.IBQuery, Vcl.StdCtrls;

type
  TForm_UsuarioAlterarSenha = class(TForm)
    Edit_NovaSenha: TEdit;
    Edit_CNovaSenha: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    btn_Salvar: TButton;
    QR_LOGIN: TIBQuery;
    DS_Login: TIBDataSet;
    DS_LoginUSUARIO_ID: TIntegerField;
    DS_LoginEXPIRACAO: TDateField;
    DS_LoginSENHA: TIBStringField;
    procedure Edit_NovaSenhaExit(Sender: TObject);
    procedure Edit_CNovaSenhaExit(Sender: TObject);
    procedure btn_SalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_UsuarioAlterarSenha: TForm_UsuarioAlterarSenha;

implementation

{$R *.dfm}

uses Unit_dm1;

procedure TForm_UsuarioAlterarSenha.btn_SalvarClick(Sender: TObject);
var
  MD5 : TidHashMessageDigest5;
begin
  MD5 := TIdHashMessageDigest5.Create;

  try
    with DS_Login do
      begin
        Close;
        SelectSQL.Text := 'select * from tbusuario where usuario_id = ''' + UsuarioID + ''' ';
        Open;
      end;

      DS_Login.Edit;

      DS_LoginSENHA.Text           :=  MD5.HashStringAsHex(UsuarioID+Edit_CNovaSenha.Text);
      DS_LoginEXPIRACAO.AsDateTime := Date + 60;
      DS_Login.Post;
      DS_Login.Transaction.CommitRetaining;

      ShowMessage('Senha alterada com sucesso! Expirará novamente em 60 Dias.');

      Edit_NovaSenha.Clear;
      Edit_CNovaSenha.Clear;
  finally
    Close;
  end;
end;

procedure TForm_UsuarioAlterarSenha.Edit_CNovaSenhaExit(Sender: TObject);
begin
  if (Trim(Edit_NovaSenha.Text) <> Trim(Edit_CNovaSenha.Text)) then
    begin
      ShowMessage('Senhas não conferem!');
      Edit_CNovaSenha.Clear;
      Edit_NovaSenha.SetFocus;
    end;
end;

procedure TForm_UsuarioAlterarSenha.Edit_NovaSenhaExit(Sender: TObject);
begin
  if Trim(Edit_NovaSenha.Text) = '' then
    begin
      ShowMessage('Insira a nova senha');
      Edit_NovaSenha.SetFocus;
    end;
end;

procedure TForm_UsuarioAlterarSenha.FormShow(Sender: TObject);
begin
  Edit_NovaSenha.SetFocus;
  Edit_NovaSenha.Clear;
  Edit_CNovaSenha.Clear;
end;

end.
