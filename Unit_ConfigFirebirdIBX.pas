{ ============================================================================
  Unit_ConfigFirebirdIBX.pas
  Formulário de Configuração de Conexão Firebird IBX

  Descrição:
    Permite configurar os parâmetros de conexão do componente IBDatabase
    para bancos de dados Firebird, com suporte a criptografia de senha.

  Funcionalidades:
    - Configurar servidor, porta, caminho do banco, usuário e senha
    - Criptografia da senha usando função MyCrypt
    - Teste de conexão antes de salvar
    - Persistência das configurações em arquivo INI

  Compatibilidade: Delphi 10 Seattle
  ============================================================================ }

unit Unit_ConfigFirebirdIBX;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, System.IniFiles,
  IBX.IBDatabase;

type
  TForm_ConfigFirebirdIBX = class(TForm)
    Panel1: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    Image1: TImage;
    GroupBox1: TGroupBox;
    LabelServidor: TLabel;
    LabelPorta: TLabel;
    LabelCaminho: TLabel;
    LabelUsuario: TLabel;
    LabelSenha: TLabel;
    LabelCharSet: TLabel;
    LabelDialeto: TLabel;
    EditServidor: TEdit;
    EditPorta: TEdit;
    EditCaminhoBanco: TEdit;
    btnBrowse: TButton;
    EditUsuario: TEdit;
    EditSenha: TEdit;
    ComboCharacterSet: TComboBox;
    ComboDialeto: TComboBox;
    CheckBoxConexaoLocal: TCheckBox;
    PanelBotoes: TPanel;
    btnTestarConexao: TPanel;
    btnSalvar: TPanel;
    btnFechar: TPanel;
    OpenDialog1: TOpenDialog;
    procedure FormShow(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
    procedure btnTestarConexaoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure CheckBoxConexaoLocalClick(Sender: TObject);
  private
    { Métodos privados }
    procedure CarregarConfiguracoes;
    procedure AtualizarEstadoCamposServidor;
  public
    { Métodos públicos }
    procedure AplicarConfiguracoesAoIBDatabase(AIBDatabase: TIBDatabase);
  end;

var
  Form_ConfigFirebirdIBX: TForm_ConfigFirebirdIBX;

implementation

{$R *.dfm}

uses
  Biblioteca;

const
  SECAO_INI = 'SICFAR_LOCAL';
  ARQUIVO_INI = 'BaseSIC.ini';

{ ============================================================================
  Retorna o caminho completo do arquivo INI de configuração
  ============================================================================ }
function ObterCaminhoArquivoIni: String;
begin
  Result := ExtractFilePath(Application.ExeName) + ARQUIVO_INI;
end;

{ ============================================================================
  FormShow - Carrega as configurações salvas ao exibir o formulário
  ============================================================================ }
procedure TForm_ConfigFirebirdIBX.FormShow(Sender: TObject);
begin
  CarregarConfiguracoes;
end;

{ ============================================================================
  CarregarConfiguracoes - Lê as configurações do arquivo INI
  ============================================================================ }
procedure TForm_ConfigFirebirdIBX.CarregarConfiguracoes;
var
  IniFile: TIniFile;
  SenhaCriptografada: String;
  Servidor: String;
begin
  IniFile := TIniFile.Create(ObterCaminhoArquivoIni);
  try
    // Carregar campos do arquivo INI
    Servidor := IniFile.ReadString(SECAO_INI, 'Servidor', '');
    EditServidor.Text := Servidor;
    EditPorta.Text := IniFile.ReadString(SECAO_INI, 'Porta', '3050');
    EditCaminhoBanco.Text := IniFile.ReadString(SECAO_INI, 'Caminho', '');
    EditUsuario.Text := IniFile.ReadString(SECAO_INI, 'Usuario', 'SYSDBA');

    // Descriptografar senha ao carregar
    SenhaCriptografada := IniFile.ReadString(SECAO_INI, 'Senha', '');
    if SenhaCriptografada <> '' then
      EditSenha.Text := MyCrypt('D', SenhaCriptografada)
    else
      EditSenha.Text := '';

    // Carregar ComboBoxes
    ComboCharacterSet.Text := IniFile.ReadString(SECAO_INI, 'ChrSet', 'WIN1252');
    ComboDialeto.Text := IniFile.ReadString(SECAO_INI, 'Dialeto', '3');

    // Verificar se é conexão local (servidor vazio)
    CheckBoxConexaoLocal.Checked := (Trim(Servidor) = '');
    AtualizarEstadoCamposServidor;
  finally
    IniFile.Free;
  end;
end;

{ ============================================================================
  AtualizarEstadoCamposServidor - Habilita/desabilita campos de servidor
  ============================================================================ }
procedure TForm_ConfigFirebirdIBX.AtualizarEstadoCamposServidor;
begin
  EditServidor.Enabled := not CheckBoxConexaoLocal.Checked;
  EditPorta.Enabled := not CheckBoxConexaoLocal.Checked;

  if CheckBoxConexaoLocal.Checked then
  begin
    EditServidor.Text := '';
    EditServidor.Color := clBtnFace;
    EditPorta.Color := clBtnFace;
  end
  else
  begin
    EditServidor.Color := clWindow;
    EditPorta.Color := clWindow;
  end;
end;

{ ============================================================================
  CheckBoxConexaoLocalClick - Alterna entre conexão local e remota
  ============================================================================ }
procedure TForm_ConfigFirebirdIBX.CheckBoxConexaoLocalClick(Sender: TObject);
begin
  AtualizarEstadoCamposServidor;
end;

{ ============================================================================
  btnBrowseClick - Abre diálogo para selecionar arquivo do banco
  ============================================================================ }
procedure TForm_ConfigFirebirdIBX.btnBrowseClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
    EditCaminhoBanco.Text := OpenDialog1.FileName;
end;

{ ============================================================================
  btnSalvarClick - Salva as configurações no arquivo INI
  ============================================================================ }
procedure TForm_ConfigFirebirdIBX.btnSalvarClick(Sender: TObject);
var
  IniFile: TIniFile;
  SenhaCriptografada: String;
begin
  // Validar campos obrigatórios
  if Trim(EditCaminhoBanco.Text) = '' then
  begin
    ShowMessage('O caminho do banco de dados é obrigatório.');
    EditCaminhoBanco.SetFocus;
    Exit;
  end;

  if Trim(EditUsuario.Text) = '' then
  begin
    ShowMessage('O usuário é obrigatório.');
    EditUsuario.SetFocus;
    Exit;
  end;

  IniFile := TIniFile.Create(ObterCaminhoArquivoIni);
  try
    // Salvar servidor (vazio se conexão local)
    if CheckBoxConexaoLocal.Checked then
      IniFile.WriteString(SECAO_INI, 'Servidor', '')
    else
      IniFile.WriteString(SECAO_INI, 'Servidor', Trim(EditServidor.Text));

    IniFile.WriteString(SECAO_INI, 'Porta', Trim(EditPorta.Text));
    IniFile.WriteString(SECAO_INI, 'Caminho', Trim(EditCaminhoBanco.Text));
    IniFile.WriteString(SECAO_INI, 'Usuario', Trim(EditUsuario.Text));

    // Criptografar senha antes de salvar
    if Trim(EditSenha.Text) <> '' then
      SenhaCriptografada := Biblioteca.MyCrypt('C', Trim(EditSenha.Text))
    else
      SenhaCriptografada := '';
    IniFile.WriteString(SECAO_INI, 'Senha', SenhaCriptografada);

    IniFile.WriteString(SECAO_INI, 'ChrSet', ComboCharacterSet.Text);
    IniFile.WriteString(SECAO_INI, 'Dialeto', ComboDialeto.Text);

    ShowMessage('Configurações salvas com sucesso!');
  finally
    IniFile.Free;
  end;
end;

{ ============================================================================
  btnTestarConexaoClick - Testa a conexão com os parâmetros informados
  ============================================================================ }
procedure TForm_ConfigFirebirdIBX.btnTestarConexaoClick(Sender: TObject);
var
  IBDatabaseTeste: TIBDatabase;
  IBTransactionTeste: TIBTransaction;
  DatabasePath: String;
begin
  // Validar campos obrigatórios
  if Trim(EditCaminhoBanco.Text) = '' then
  begin
    ShowMessage('O caminho do banco de dados é obrigatório.');
    EditCaminhoBanco.SetFocus;
    Exit;
  end;

  Screen.Cursor := crHourGlass;
  IBDatabaseTeste := TIBDatabase.Create(nil);
  IBTransactionTeste := TIBTransaction.Create(nil);
  try
    try
      // Configurar transação
      IBTransactionTeste.DefaultDatabase := IBDatabaseTeste;
      IBDatabaseTeste.DefaultTransaction := IBTransactionTeste;

      // Montar caminho do banco: servidor/porta:caminho ou apenas caminho (local)
      if (not CheckBoxConexaoLocal.Checked) and (Trim(EditServidor.Text) <> '') then
        DatabasePath := Trim(EditServidor.Text) + '/' + Trim(EditPorta.Text) + ':' + Trim(EditCaminhoBanco.Text)
      else
        DatabasePath := Trim(EditCaminhoBanco.Text);

      // Configurar parâmetros de conexão
      IBDatabaseTeste.DatabaseName := DatabasePath;
      IBDatabaseTeste.Params.Clear;
      IBDatabaseTeste.Params.Add('user_name=' + Trim(EditUsuario.Text));
      IBDatabaseTeste.Params.Add('password=' + Trim(EditSenha.Text));
      IBDatabaseTeste.Params.Add('lc_ctype=' + ComboCharacterSet.Text);
      IBDatabaseTeste.SQLDialect := StrToIntDef(ComboDialeto.Text, 3);
      IBDatabaseTeste.LoginPrompt := False;

      // Tentar conectar
      IBDatabaseTeste.Connected := True;

      ShowMessage('Conexão realizada com sucesso!' + sLineBreak + sLineBreak +
                  'Banco: ' + DatabasePath);

      IBDatabaseTeste.Connected := False;
    except
      on E: Exception do
        ShowMessage('Falha na conexão:' + sLineBreak + sLineBreak + E.Message);
    end;
  finally
    Screen.Cursor := crDefault;
    IBTransactionTeste.Free;
    IBDatabaseTeste.Free;
  end;
end;

{ ============================================================================
  btnFecharClick - Fecha o formulário
  ============================================================================ }
procedure TForm_ConfigFirebirdIBX.btnFecharClick(Sender: TObject);
begin
  Close;
end;

{ ============================================================================
  AplicarConfiguracoesAoIBDatabase - Aplica as configurações a um TIBDatabase

  Parâmetros:
    AIBDatabase: Componente TIBDatabase a ser configurado

  Descrição:
    Lê as configurações do arquivo INI e aplica ao componente informado.
    A senha é descriptografada antes de ser aplicada.
  ============================================================================ }
procedure TForm_ConfigFirebirdIBX.AplicarConfiguracoesAoIBDatabase(AIBDatabase: TIBDatabase);
var
  IniFile: TIniFile;
  Caminho, Servidor, Porta, Usuario, SenhaCriptografada, Senha, CharSet: String;
  Dialeto: Integer;
  DatabasePath: String;
begin
  if not Assigned(AIBDatabase) then
  begin
    ShowMessage('Componente IBDatabase não informado.');
    Exit;
  end;

  IniFile := TIniFile.Create(ObterCaminhoArquivoIni);
  try
    // Ler configurações do INI
    Servidor := IniFile.ReadString(SECAO_INI, 'Servidor', '');
    Porta := IniFile.ReadString(SECAO_INI, 'Porta', '3050');
    Caminho := IniFile.ReadString(SECAO_INI, 'Caminho', '');
    Usuario := IniFile.ReadString(SECAO_INI, 'Usuario', 'SYSDBA');
    SenhaCriptografada := IniFile.ReadString(SECAO_INI, 'Senha', '');
    CharSet := IniFile.ReadString(SECAO_INI, 'ChrSet', 'WIN1252');
    Dialeto := StrToIntDef(IniFile.ReadString(SECAO_INI, 'Dialeto', '3'), 3);

    // Descriptografar senha
    if SenhaCriptografada <> '' then
      Senha := MyCrypt('D', SenhaCriptografada)
    else
      Senha := '';

    // Montar caminho completo do banco
    if Trim(Servidor) <> '' then
      DatabasePath := Servidor + '/' + Porta + ':' + Caminho
    else
      DatabasePath := Caminho;

    // Aplicar configurações ao componente
    AIBDatabase.Connected := False;
    AIBDatabase.DatabaseName := DatabasePath;
    AIBDatabase.Params.Clear;
    AIBDatabase.Params.Add('user_name=' + Usuario);
    AIBDatabase.Params.Add('password=' + Senha);
    AIBDatabase.Params.Add('lc_ctype=' + CharSet);
    AIBDatabase.SQLDialect := Dialeto;
    AIBDatabase.LoginPrompt := False;
  finally
    IniFile.Free;
  end;
end;

end.
