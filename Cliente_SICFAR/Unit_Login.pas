unit Unit_Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RzButton, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, RzEdit, RzBtnEdt, Vcl.StdCtrls, Vcl.Mask, Data.DB,
  IBX.IBCustomDataSet, IBX.IBQuery, System.Win.ScktComp, IdBaseComponent, IdComponent, IdIPWatch,
  IdTCPConnection, IdTCPClient;

type
  TForm_Login = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label6: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label10: TLabel;
    DataBase: TRzDateTimeEdit;
    Edit_PesqEmp: TRzButtonEdit;
    Edit_Empresa: TRzEdit;
    Edit_User: TRzEdit;
    Edit_Senha: TRzEdit;
    btn_Acessar: TRzBitBtn;
    btnSair: TRzBitBtn;
    QR_LOGIN: TIBQuery;
    Label_Versao: TLabel;
    Timer1: TTimer;
    DS_ACESSO: TIBDataSet;
    DS_ACESSOACESSO_ID: TIntegerField;
    DS_ACESSODATA: TDateTimeField;
    DS_ACESSOUSUARIO_ID: TIntegerField;
    DS_ACESSOUSUARIO: TIBStringField;
    DS_ACESSOLOCAL: TIBStringField;
    DS_ACESSOTIPO: TIBStringField;
    DS_ACESSOATIVIDADE: TIBStringField;
    DS_ACESSOONLINE: TIBStringField;
    DS_ACESSOIP: TIBStringField;
    DS_ACESSOCOMPUTADOR: TIBStringField;
    procedure btn_AcessarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit_UserExit(Sender: TObject);
    procedure Edit_PesqEmpButtonClick(Sender: TObject);
    procedure Edit_PesqEmpExit(Sender: TObject);
    procedure Edit_PesqEmpKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
  private
    { Private declarations }
    procedure pAtualizador;
    procedure pConectaMonitor;
    procedure pGravaConexao(conexao : string);
    procedure pGravaAcesso;
  public
    { Public declarations }
  end;

var
  Form_Login: TForm_Login;
  vlHostMonitor : String;
  vlPortaMonitor : Integer;
  vlDataAcesso : String;

implementation

{$R *.dfm}

uses Biblioteca, {U_Cipher,} Unit_dm1, Unit_Principal, Unit_Busca_Empresa,
  Unit_UsuarioAlterarSenha, idHashMessageDigest, Unit_dmProtheus,
  Unit_Atualizador; // MD5

procedure TForm_Login.btnSairClick(Sender: TObject);
begin
//  ClientSocket.Active := false;
  Application.Terminate;
end;

procedure TForm_Login.btn_AcessarClick(Sender: TObject);
var
  Msg : String;
  MD5 : TidHashMessageDigest5;
begin
  if Edit_PesqEmp.Text = '' then
    begin
      Application.MessageBox('Informe a Empresa','Validação', MB_OK+MB_ICONWARNING);
      Edit_PesqEmp.SetFocus;
      Exit;
    end;

  MD5 := TIdHashMessageDigest5.Create;
  with QR_LOGIN do
    begin
      Close;
      SQL.Text := 'select * from TBUSUARIO U WHERE u.deletado = ''N'' and NOME = :NOME and SENHA = :SENHA';

      ParamByName('NOME').AsString  := Trim(Edit_User.Text);
      ParamByName('SENHA').AsString := MD5.HashStringAsHex(UsuarioID + Trim(Edit_Senha.Text));

      // InputBox('SQL', 'Text', SQL.Text);

      Open;
    end;

  if not QR_LOGIN.IsEmpty then // Se não for Vazio
    begin
      if dmProtheus = nil then
        Application.CreateForm(TdmProtheus, dmProtheus);

//      vAplicacaoPrincipal := False;

      UsuarioID           := QR_LOGIN.FieldByName('USUARIO_ID').AsString;
      Usuario             := QR_LOGIN.FieldByName('NOME').AsString;
//      UsuarioNomeFantasia := QR_LOGIN.FieldByName('NOME_FANTASIA').AsString;

      if not QR_LOGIN.FieldByName('EXPIRACAO').IsNull then
        begin
          if QR_LOGIN.FieldByName('EXPIRACAO').AsDateTime <= Date then
            begin
              Application.MessageBox('Senha Expirada, Clique em OK para informar nova Senha!','Dados obrigatórios...', MB_OK+MB_ICONEXCLAMATION);

              if Form_UsuarioAlterarSenha = nil then
                Application.CreateForm(TForm_UsuarioAlterarSenha, Form_UsuarioAlterarSenha);

              Form_UsuarioAlterarSenha.ShowModal;

              Edit_Senha.SetFocus;
              Edit_Senha.Clear;

              Exit;
            end;
        end;

      vPerfilID := QR_LOGIN.FieldByName('PERFIL_ID').AsString;
      dm1.Perfil.Close;
      dm1.Perfil.SQL.Text := 'select * from tbperfil_rotina where perfil_id = ''' + vPerfilID + ''' and acesso = ''S'' order by rotina';
      dm1.Perfil.Open;
      dm1.Perfil.First;

      pGravaAcesso;
      pConectaMonitor;
      Form_Login.Hide;
      Sleep(2000);
      pAtualizador;
      Form_Principal.Show;
    end
  else
    begin
      Msg := 'O Nome ou a Senha do Usuário estão inválidos.' + #13 + #13
            +'Se você esqueceu sua senha, Consulte' + #13
            +'o Administrador do Sistema ou tente novamente.';

      Application.MessageBox(PChar(Msg), 'Login não Autorizado', MB_OK+MB_ICONERROR);
      Edit_User.SetFocus;
      Edit_Senha.Clear;
    end;
end;

procedure TForm_Login.ClientSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
//  ClientSocket.Socket.SendText(DS_ACESSOACESSO_ID.AsString);
end;

procedure TForm_Login.ClientSocketError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
{  if ErrorCode = 10061 then
    ErrorCode := 0;

  if ErrorCode = 10053 then
    begin
      ShowMessage('Erro 10053');
      ErrorCode := 0;
    end;  }
end;

procedure TForm_Login.ClientSocketRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  msg : string;
  conexao : string;
begin
  msg := Socket.ReceiveText;
  if msg = 'desconectar' then
    begin
      Application.Terminate;
    end;

  if copy(msg, 1, 4) = 'cnx:' then
    begin
      conexao := Copy(msg, pos(':', msg)+1, length(msg));
      pGravaConexao(conexao);
    end;

  if msg = 'conexao' then
    begin
      //ClientSocket.Socket.SendText(Usuario + '|' + vlDataAcesso);
    end;

end;

procedure TForm_Login.Edit_PesqEmpButtonClick(Sender: TObject);
begin
  Application.CreateForm(TForm_Busca_Empresa, Form_Busca_Empresa);
  Form_Busca_Empresa.ShowModal;

  If Form_Busca_Empresa.ModalResult = mrOK Then
    begin
      Edit_PesqEmp.Text := Form_Busca_Empresa.QR_EMPRESAEMPRESA_ID.AsString;
      Edit_Empresa.Text := Form_Busca_Empresa.QR_EMPRESARAZAO_SOCIAL.AsString;
    end;
end;

procedure TForm_Login.Edit_PesqEmpExit(Sender: TObject);
begin
  If btnSair.Focused Then
    Exit;


  if Edit_PesqEmp.Text <> '' then
    begin
      dm1.QR_TEMP.Close;
      dm1.QR_TEMP.SQL.Text := 'select empresa_id, razao_social, uf, ambiente_nfe from tbempresas where deletado = ''N'' and empresa_id = '''+ Edit_PesqEmp.Text +''' ';
      dm1.QR_TEMP.Open;
      if not (dm1.QR_TEMP.IsEmpty) then
        begin
          Edit_PesqEmp.Text := dm1.QR_TEMP.FieldByName('EMPRESA_ID').AsString;
          EmpresaID         := dm1.QR_TEMP.FieldByName('EMPRESA_ID').AsString;
          vUFEmpresa        := dm1.QR_TEMP.FieldByName('UF').AsString;
          Edit_Empresa.Text := dm1.QR_TEMP.FieldByName('RAZAO_SOCIAL').AsString;
          Empresa           := dm1.QR_TEMP.FieldByName('RAZAO_SOCIAL').AsString;
        end
      else
        begin
          Application.MessageBox('Conta não encontrada. Deseja efetuar um novo Cadastro?','Informação...', MB_OK+MB_ICONINFORMATION);
          Edit_PesqEmp.SetFocus;
          Exit;
        end;
    end
end;

procedure TForm_Login.Edit_PesqEmpKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F3 then
    Edit_PesqEmpButtonClick(sender);
end;

procedure TForm_Login.Edit_UserExit(Sender: TObject);
var
  vQuery: TIBQuery;
begin
  if btnSair.Focused then
    Exit;

  vQuery := TIBQuery.Create(Owner);
  with vQuery do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;

      Close;
      SQL.Text := 'select usuario_id, nome, expiracao from tbusuario where deletado = ''N'' ';
      SQL.Add(' and nome = ''' + Trim(Edit_User.Text) + ''' ');
      Open;
      UsuarioID := vQuery.FieldByName('USUARIO_ID').AsString;
    end;
  FreeAndNil(vQuery);
end;

procedure TForm_Login.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TForm_Login.FormShow(Sender: TObject);
begin
  Label_Versao.Caption := 'Versão: ' + Get_Versao;
  DataBase.Date        := Now;

  Edit_PesqEmp.Text := '1';
  Edit_PesqEmp.OnExit(Sender);
  Edit_User.SetFocus;
end;

procedure TForm_Login.pAtualizador;
var
  vlQuerySIC : TIBQuery;
  vlVersaoEXE, vlVersaoBanco : String;
begin
  Application.ProcessMessages;

  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;

      Close;
      SQL.Text := 'select versao from tbusuario';

      SQL.Add(' where deletado = ''N'' ');
      SQL.Add(' and usuario_id = ''' + UsuarioID + ''' ');
      Open;
    end;

  vlVersaoBanco := vlQuerySIC.FieldByName('VERSAO').AsString;
  vlVersaoEXE := dm1.Get_Versao;

  if vlVersaoEXE <> vlVersaoBanco then
    begin

      Application.CreateForm(TForm_Atualizador, Form_Atualizador);
      Form_Atualizador.ShowModal;
    end;
end;

procedure TForm_Login.pConectaMonitor;
var
  vlQuerySIC : TIBQuery;
begin
  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;
      Close;
      SQL.Text := 'select conteudo from tbparametros where parametro = ''ATUALIZADOR_HOST'' ';
      Open;
    end;
   vlHostMonitor := vlQuerySIC.FieldByName('CONTEUDO').AsString;

  with vlQuerySIC do
    begin
      Close;
      SQL.Text := 'select conteudo from tbparametros where parametro = ''MONITOR_PORTA'' ';
      Open;
    end;
   vlPortaMonitor := vlQuerySIC.FieldByName('CONTEUDO').AsInteger;

  FreeAndNil(vlQuerySIC);

  vlDataAcesso := FormatDateTime('DD/MM/YYYY HH:MM:SS', Now);

  Timer1.Enabled := True;
end;

procedure TForm_Login.pGravaAcesso;
var
  vlQuerySIC : TIBQuery;
begin
  DS_ACESSO.Close;
  DS_ACESSO.SelectSQL.Text := 'SELECT * FROM TBACESSO WHERE ACESSO_ID = 0';
  DS_ACESSO.Open;

  DS_ACESSO.Insert;
  DS_ACESSODATA.AsDateTime     := Now;

  DS_ACESSOUSUARIO_ID.AsString := UsuarioID;
  DS_ACESSOUSUARIO.AsString    := Usuario;

  DS_ACESSOCOMPUTADOR.AsString := GetNomeComputador;
  DS_ACESSOIP.AsString         := GetIPAddress;
  DS_ACESSOONLINE.AsString     := 'S';

  AcessoID := DS_ACESSOACESSO_ID.AsString;

  DS_ACESSO.Post;
  DS_ACESSO.Transaction.CommitRetaining;
  {vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;

      Close;

      SQL.Text := 'update tbusuario set';
      SQL.Add(' acesso = ''' + FormatDateTime('DD/MM/YYYY HH:MM:SS', Now) + ''' ');
      SQL.Add(' where deletado = ''N'' ');
      SQl.Add(' and usuario_id = ''' + UsuarioID + ''' ');

      ExecSQL;
      Transaction.CommitRetaining;
    end;
  FreeAndNil(vlQuerySIC);}
end;

procedure TForm_Login.pGravaConexao(conexao : string);
var
  vlQuerySIC : TIBQuery;
begin
  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;

      Close;

      SQL.Text := 'update tbusuario set';
      SQL.Add(' conexao = ''' + conexao + ''' ');
      SQL.Add(' where deletado = ''N'' ');
      SQl.Add(' and usuario_id = ''' + UsuarioID + ''' ');

      ExecSQL;
      Transaction.CommitRetaining;
    end;
  FreeAndNil(vlQuerySIC);
end;

procedure TForm_Login.Timer1Timer(Sender: TObject);
begin
{  try
    with ClientSocket do
      begin
        if Active = False then
          begin
            Port   := vlPortaMonitor;
            Host   := vlHostMonitor;
            Active := True;
          end;
        ClientSocket.Socket.SendText(Usuario + '|' + vlDataAcesso);
      end;
  except
    ClientSocket.Active := False;
  end;}
end;

end.
