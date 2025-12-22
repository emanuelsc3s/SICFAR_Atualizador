unit Unit_Server;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdContext, Vcl.StdCtrls,
  IdAntiFreezeBase, Vcl.IdAntiFreeze, IdBaseComponent, IdComponent,
  IdCustomTCPServer, IdTCPServer, Vcl.ComCtrls, IdThreadComponent,
  System.ImageList, Vcl.ImgList, RzPanel, RzButton, Vcl.ExtCtrls, winsock,
  Vcl.Grids, System.Win.ScktComp, ShellAPI, Data.DB, IBX.IBCustomDataSet,
  IBX.IBQuery, Data.Win.ADODB, IBX.IBDatabase;

type
  TForm_PrincipalServer = class(TForm)
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    RzToolbar2: TRzToolbar;
    btn_Ativar: TRzToolButton;
    RzSpacer1: TRzSpacer;
    btn_Desativar: TRzToolButton;
    RzSpacer2: TRzSpacer;
    btn_Salvar: TRzToolButton;
    GroupBox1: TGroupBox;
    Memo_Arquivos: TMemo;
    GroupBox2: TGroupBox;
    Memo_Log: TMemo;
    Servidor: TIdTCPServer;
    IdAntiFreeze1: TIdAntiFreeze;
    imageCad: TImageList;
    Timer1: TTimer;
    SaveDialog1: TSaveDialog;
    Timer_Reuniao: TTimer;
    QR_REUNIAO: TIBQuery;
    QR_EMAIL: TIBQuery;
    Timer_Tabelas: TTimer;
    ADOQuery1: TADOQuery;
    Update: TIBQuery;
    GroupBox3: TGroupBox;
    Edit_PortaUpdate: TEdit;
    Label1: TLabel;
    btn_Fechar: TRzToolButton;
    RzSpacer3: TRzSpacer;
    RzSpacer4: TRzSpacer;
    btn_ConfigFirebird: TRzToolButton;
    RzSpacer5: TRzSpacer;
    procedure ServidorExecute(AContext: TIdContext);
    procedure btn_ConfigFirebirdClick(Sender: TObject);
    procedure ServidorConnect(AContext: TIdContext);
    procedure FormCreate(Sender: TObject);
    procedure btn_AtivarClick(Sender: TObject);
    procedure btn_DesativarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure btn_SalvarClick(Sender: TObject);
    procedure btn_FecharClick(Sender: TObject);
    procedure ServerSocketClientError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure FormShow(Sender: TObject);
    procedure Timer_ReuniaoTimer(Sender: TObject);
    procedure Timer_TabelasTimer(Sender: TObject);
  private
    { Private declarations }
    procedure pListaArquivos;
    procedure pCarregaParametrosServidor;
    function GetBuildInfo(prog: String): String;

    procedure pDisparaEmailReuniao(prPeriodo : String);

    procedure pAtualizaProduto;
    procedure pAtualizaFornecedor;
    procedure pAtualizaCondPagto;
    procedure pAtualizaCliente;
    procedure pAtualizaClienteAmazon;
    procedure pAtualizaPorta(prPorta : String);
    function fRetornaPorta : Integer;

    procedure pAtualizaSC;
    procedure pAtualizaDepto;
    procedure pAtualizaCC;

    procedure logErros(Erros: String);

    procedure pAtualizaPedidoCloudToLocal(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);
    procedure pAtualizaPedidoLocalToCloud(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);

    procedure pAtualizaPedidoItemLocalToCloud(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);
    procedure pAtualizaPedidoItemCloudToLocal(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);

    procedure pAtualizaSCCloudToLocal(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);
    procedure pAtualizaSCLocalToCloud(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);

    procedure pAtualizaItemScCloudToLocal(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);
    procedure pAtualizaItemScLocalToCloud(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);

    procedure pAtualizaUsuarioCloudToLocal(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);
    procedure pAtualizaUsuarioLocalToCloud(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);

    procedure pAtualizaDepartamentoCloudToLocal(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);
    procedure pAtualizaDepartamentoLocalToCloud(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);

    procedure pAtualizaProdutoCloudToLocal(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);
    procedure pAtualizaProdutoLocalToCloud(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction; prProdutoID : String);

    procedure pAtualizaPessoasLocalToCloud(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction; prPessoaID : String);
    procedure pAtualizaPessoasCloudToLocal(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);

    procedure pAtualizaCCCloudToLocal(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);
    procedure pAtualizaCCLocalToCloud(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);

    procedure pAtualizaLicitacaoCloudToLocal(
  ALocalDatabase, ACloudDatabase: TIBDatabase;
  ALocalTransaction, ACloudTransaction: TIBTransaction; prLicitacaoID : String);

  procedure pAtualizaLicitacaoLocalToCloud(
            ALocalDatabase, ACloudDatabase: TIBDatabase;
            ALocalTransaction, ACloudTransaction: TIBTransaction);

  procedure pImportaPessoa(prPessoaID : String);

    procedure pAtualizaLicitacaoItemCloudToLocal(
  ALocalDatabase, ACloudDatabase: TIBDatabase;
  ALocalTransaction, ACloudTransaction: TIBTransaction; prLicitacaoID : String);

  procedure pAtualizaLicitacaoItemLocalToCloud(
    ALocalDatabase, ACloudDatabase: TIBDatabase;
    ALocalTransaction, ACloudTransaction: TIBTransaction; prLicitacaoID : String);

  procedure pImportaProduto(prProdutoID : String);
  procedure pImportaLicitacao(prLicitacaoID : String);

  procedure pAtualizaLicitacaoAdiCloudToLocal(
    ALocalDatabase, ACloudDatabase: TIBDatabase;
    ALocalTransaction, ACloudTransaction: TIBTransaction; prLicitacaoID : String);

  procedure pAtualizaLicitacaoAdiLocalToCloud(
    ALocalDatabase, ACloudDatabase: TIBDatabase;
    ALocalTransaction, ACloudTransaction: TIBTransaction; prLicitacaoID : String);


  procedure pAtualizaLicitacaoEntregaCloudToLocal(
    ALocalDatabase, ACloudDatabase: TIBDatabase;
    ALocalTransaction, ACloudTransaction: TIBTransaction; prLicitacaoID : String);

  procedure pAtualizaLicitacaoEntregaLocalToCloud(
    ALocalDatabase, ACloudDatabase: TIBDatabase;
    ALocalTransaction, ACloudTransaction: TIBTransaction; prLicitacaoID : String);


  procedure pAtualizaLicitacaoOrgaoCloudToLocal(
    ALocalDatabase, ACloudDatabase: TIBDatabase;
    ALocalTransaction, ACloudTransaction: TIBTransaction; prLicitacaoId : String);

  procedure pAtualizaLicitacaoOrgaoLocalToCloud(
    ALocalDatabase, ACloudDatabase: TIBDatabase;
    ALocalTransaction, ACloudTransaction: TIBTransaction; prLicitacaoId : String);

  public
    { Public declarations }
    FMsgErro : string;
    LTOTVS   : Boolean;

    vQuerySIC, vQueryConstulta, vQuerySICWeb, vQueryConstultaWeb, vQueryUpdateSIC : TIBQuery;
    vQueryTOTVS, vQueryUpdate  : TADOQuery;
    vQueryReuniao : TIBQuery;

    vPararServidor : Boolean;
  end;

var
  Form_PrincipalServer: TForm_PrincipalServer;
  Caminho : String;
  TamanhoArquivos : integer;
  vlData : TDateTime;
  IndexConexao: integer;
  ConexaoCliente : Integer;
  AcessoID_Cliente : String;

implementation

uses
  System.IniFiles, Unit_DM1, Unit_dmProtheus, Biblioteca, Unit_ConfigFirebirdIBX;

{$R *.dfm}


procedure TForm_PrincipalServer.btn_AtivarClick(Sender: TObject);
var
  vlPortaBanco : String;
begin
  vlPortaBanco := IntToStr(fRetornaPorta);

  if SoNumeros(Trim(Edit_PortaUpdate.Text)) = '' then
    begin
      Application.MessageBox('Informe a porta de comunicação.', 'Atenção', MB_OK+MB_ICONERROR);
      Edit_PortaUpdate.SetFocus;
      Abort;
    end;

  try
    if SoNumeros(Trim(Edit_PortaUpdate.Text)) <> vlPortaBanco then
      begin
        if Application.MessageBox(PChar('A porta informada é diferente da atual. Deseja alterar a porta de [' + vlPortaBanco + '] para [' + SoNumeros(Trim(Edit_PortaUpdate.Text))+ ']'), 'Atenção',MB_YESNO+MB_ICONQUESTION) = mrYes then
          pAtualizaPorta(SoNumeros(Trim(Edit_PortaUpdate.Text)))
        else
          Edit_PortaUpdate.Text := vlPortaBanco;
      end;

    pCarregaParametrosServidor;
    pListaArquivos;

    Servidor.Active       := True;
    //timer1.Enabled      := True;

    //ShowMessage(IntToStr(Servidor.DefaultPort));

    btn_Ativar.Enabled    := False;
    btn_Desativar.Enabled := True;

    vPararServidor        := False;
    Timer_Tabelas.Enabled := True;

  except on E:Exception do
    begin
      //ShowMessage('Erro na Clonagem: ' + E.Message);
      logErros(DateTimeToStr(now) + ' - ' + 'Erro ao ativar o servidor de atualização: ' + E.Message);
      Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', Now) + ' - Erro ao ativar o servidor de atualização: ' + e.Message);
    end;
  end;
end;

procedure TForm_PrincipalServer.btn_DesativarClick(Sender: TObject);
begin
  try
    vPararServidor        := True;
    Servidor.Active       := False;
    btn_Ativar.Enabled    := True;
    btn_Desativar.Enabled := False;
    timer1.Enabled        := False;

    Memo_Arquivos.Clear;

    logErros(DateTimeToStr(now) + '-Servidor Desativado.');
  except on E: Exception do
    begin
      logErros(DateTimeToStr(now) + ' - ' + 'Erro ao desativar o servidor de atualização: ' + E.Message);
      Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', Now) + '-Erro ao Desativar o Servidor de Atualização: ' + e.Message);
      //Application.MessageBox('Erro ao desativar o servidor de atualização','Erro',MB_OK+MB_ICONERROR);
    end;
  end;
end;

procedure TForm_PrincipalServer.btn_FecharClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja realmente Fechar o Atualizador?','',MB_YESNO+MB_ICONQUESTION) = mrYes then
    begin
      FATALEXIT(0);
      Application.Terminate;
    end;
end;

{ ============================================================================
  btn_ConfigFirebirdClick - Abre o formulário de configuração Firebird IBX
  ============================================================================ }
procedure TForm_PrincipalServer.btn_ConfigFirebirdClick(Sender: TObject);
begin
  Form_ConfigFirebirdIBX := TForm_ConfigFirebirdIBX.Create(Self);
  try
    Form_ConfigFirebirdIBX.ShowModal;
  finally
    Form_ConfigFirebirdIBX.Free;
  end;
end;

procedure TForm_PrincipalServer.btn_SalvarClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
    begin
      try
        Memo_Log.Lines.SaveToFile(SaveDialog1.FileName);
        Application.MessageBox('Arquivo salvo com sucesso', 'Informação', MB_OK+MB_ICONINFORMATION);
      except on e : Exception do
        begin
         // Application.MessageBox('Erro ao salvar arquivo de log', 'Erro', MB_OK+MB_ICONERROR);
          logErros(DateTimeToStr(now) + ' - ' + 'Erro ao salvar arquivo de log: ' + E.Message);
          Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', Now) + ' - Erro ao salvar arquivo de log: ' + e.Message);
        end;
      end;
    end;
end;

procedure TForm_PrincipalServer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Application.MessageBox('Deseja Realmente Fechar o Servidor?','',MB_YESNO+MB_ICONQUESTION) = mrYes then
    begin
      FATALEXIT(0);
      Application.Terminate;
    end;
end;

procedure TForm_PrincipalServer.FormCreate(Sender: TObject);
var
  vQuerySync: TIBQuery;
begin
  LTOTVS := False;

  if not Assigned(dm1) then
    Application.CreateForm(Tdm1, dm1);

  vQuerySync := TIBQuery.Create(self);
  try
    with vQuerySync do
      begin
        Database    := dm1.IBDatabase1;
        Transaction := dm1.IBTransaction1;

        // Consulta para obter configurações da TBSYNC

        Close;
        SQL.Text := 'SELECT * FROM TBSYNC WHERE TABELA = :Tabela';
        ParamByName('Tabela').AsString := 'TOTVS';
        Open;
      end;

    if not vQuerySync.IsEmpty then
      begin
        LTOTVS := True;

        if not Assigned(dmProtheus) then
          Application.CreateForm(TdmProtheus, dmProtheus);

        vQueryTOTVS := TADOQuery.Create(Owner);
        with vQueryTOTVS do
          begin
            Connection     := dmProtheus.ADOConnection1;
            CommandTimeout := 999999;
          end;

        vQueryUpdate := TADOQuery.Create(Owner);
        with vQueryUpdate do
          begin
            Connection     := dmProtheus.ADOConnection1;
            CommandTimeout := 999999;
          end;
      end;

    vQuerySIC := TIBQuery.Create(Owner);
    with vQuerySIC do
      begin
        Database    := dm1.IBDatabase1;
        Transaction := dm1.IBTransaction1;
      end;

    vQueryConstulta := TIBQuery.Create(Owner);
    with vQueryConstulta do
      begin
        Database    := dm1.IBDatabase1;
        Transaction := dm1.IBTransaction1;
      end;

    // TOTVS->Pedidos Online Cloud
    vQuerySICWeb := TIBQuery.Create(Owner);
    with vQuerySICWeb do
      begin
        Database    := dm1.IBDatabase3;
        Transaction := dm1.IBTransaction3;
      end;

    // TOTVS->Pedidos Online Cloud
    vQueryConstultaWeb := TIBQuery.Create(Owner);
    with vQueryConstultaWeb do
      begin
        Database    := dm1.IBDatabase3;
        Transaction := dm1.IBTransaction3;
      end;

    vQueryReuniao := TIBQuery.Create(Owner);
    with vQueryReuniao do
      begin
        Database    := dm1.IBDatabase1;
        Transaction := dm1.IBTransaction1;
      end;

    vQueryUpdateSIC  := TIBQuery.Create(Owner);
    with vQueryUpdateSIC do
      begin
        Database    := dm1.IBDatabase1;
        Transaction := dm1.IBTransaction1;
      end;
  finally
    vQuerySync.Free;
  end;

  btn_Desativar.Enabled := False;
  vlData := Date;
  IndexConexao := -1;
end;

procedure TForm_PrincipalServer.FormShow(Sender: TObject);
begin
  Edit_PortaUpdate.Text := SoNumeros(IntToStr(fRetornaPorta));

  btn_AtivarClick(Sender);
end;

function TForm_PrincipalServer.fRetornaPorta: Integer;
var
  vlQuery : TIBQuery;
begin
  vlQuery := TIBQuery.Create(Owner);
  with vlQuery do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;

      Close;
      SQL.Text := 'select conteudo';
      SQL.Add(' from tbparametros');
      SQL.Add(' where parametro = ''PORTAUPDATE'' ');
      Open;
    end;

  Result := vlQuery.FieldByName('CONTEUDO').AsInteger;
  vlQuery.Free;
end;

function TForm_PrincipalServer.GetBuildInfo(prog: String): String;
var
  ver_infosize,
  ver_valuesize,
  dummy          : DWord;
  ver_info       : Pointer;
  ver_value      : PVSFixedFileInfo;
  v1, v2, v3, v4 : Word;
begin
  ver_infosize := GetFileVersionInfoSize(pchar(prog), dummy);
  GetMem(ver_info, ver_infosize);
  GetFileVersionInfo(PChar(prog), 0, ver_infosize, ver_info);
  VerQueryValue(ver_info, '\', Pointer(ver_value), ver_valuesize);
  With ver_value^ do begin
    v1 := dwFileVersionMS shr 16;
    v2 := dwFileVersionMS and $FFFF;
    v3 := dwFileVersionLS shr 16;
    v4 := dwFileVersionLS and $FFFF;
  end;
  FreeMem(ver_info, ver_infosize);

  Result := IntToStr(v1) + '.' +
            IntToStr(v2) + '.' +
            IntToStr(v3) + '.' +
            IntToStr(v4);
end;

procedure TForm_PrincipalServer.logErros(Erros: String);
var
  arq: TextFile;
begin

  try
    assignFile(arq, ExtractFilePath(Application.ExeName)   + 'ConsoleLog.txt');
    if not FileExists(ExtractFilePath(Application.ExeName) + 'ConsoleLog.txt') then
      Rewrite(arq, ExtractFilePath(Application.ExeName)    + 'ConsoleLog.txt');

    Append(arq);
    Writeln(arq, Erros);
    Writeln(arq, '-------------------------------------------');
  finally
    CloseFile(arq);
  end;
end;

procedure TForm_PrincipalServer.pAtualizaCC;
var
  vlData : TDateTime;
begin
  with vQuerySIC do
    begin
      Close;
      SQL.Text := 'select * from tbdepartamento where deletado = ''N'' ';
      SQL.Add(' and sync = ''N'' ');
      SQL.Add(' order by departamento_id');
      Open;
    end;

  vQuerySIC.First;

  while not vQuerySIC.Eof do
    begin
      vlData := Now;

       if vPararServidor = True then
         begin
           Timer_Tabelas.Enabled := False;
           Memo_Log.Lines.Add('Servidor Desativado.');
           Abort;
         end;

      with vQueryConstultaWeb do
        begin
          Close;
          SQL.Text := 'select * from tbdepartamento where deletado = ''N'' ';
          SQL.Add(' and departamento_id = ''' + Trim(vQuerySIC.FieldByName('DEPARTAMENTO_ID').AsString) + ''' ') ;
          Open;
        end;

      if vQueryConstultaWeb.IsEmpty then
        begin
          //Inserir
          with vQuerySICWeb do
            begin
              Close;
              SQL.Clear;
              SQL.Text := 'insert into tbdepartamento';
              SQL.Add(' (departamento_id, departamento, gerente_id, gerente, gerente_email,');
              SQL.Add(' codigo, data_inc, usuario_i, usuarionome_i,');
              SQL.Add(' data_alt, usuario_a, usuarionome_a, data_del,');
              SQL.Add(' usuario_d, usuarionome_d, deletado, bloqueado,');
              SQL.Add(' obs,  aprovadorpedido_id, aprovadorpedido, sync, sync_data)');
              SQL.Add(' values');
              SQL.Add(' (:pDepartamentoID, :pDepartamento, :pGerenteID, :pGerente, :pGerenteEmail,');
              SQL.Add(' :pCodigo, :pData_inc, :pUsuario_i, :pUsuarionome_i,');
              SQL.Add(' :pData_alt, :pUsuario_a, :pUsuarionome_a, :pData_del,');
              SQL.Add(' :pUsuario_d, :pUsuarionome_d, :pDeletado, :pBloqueado,');
              SQL.Add(' :pOBS, :pAprovadorPedidoID, :pAprovadorPedido, :pSync, :pSyncData)');
            end;
        end
      else
        begin
          //Atualizar
          with vQuerySICWeb do
            begin
              Close;
              SQL.Clear;
              SQL.Text := 'update tbdepartamento set';
              SQL.Add(' departamento_id = :pDepartamentoID,');
              SQL.Add(' departamento = :pDepartamento,');
              SQL.Add(' gerente_id = :pGerenteID,');
              SQL.Add(' gerente = :pGerente,');
              SQL.Add(' gerente_email = :pGerenteEmail,');
              SQL.Add(' codigo = :pCodigo,');
              SQL.Add(' data_inc = :pData_inc,');
              SQL.Add(' usuario_i = :pUsuario_i,');
              SQL.Add(' usuarionome_i = :pUsuarionome_i,');
              SQL.Add(' data_alt = :pData_alt,');
              SQL.Add(' usuario_a = :pUsuario_a,');
              SQL.Add(' usuarionome_a = :pUsuarionome_a,');
              SQL.Add(' data_del = :pData_del,');
              SQL.Add(' usuario_d = :pUsuario_d,');
              SQL.Add(' usuarionome_d = :pUsuarionome_d,');
              SQL.Add(' deletado = :pDeletado,');
              SQL.Add(' bloqueado = :pBloqueado,');
              SQL.Add(' obs = :pOBS,');
              SQL.Add(' aprovadorpedido_id = :pAprovadorPedidoID,');
              SQL.Add(' aprovadorpedido = :pAprovadorPedido,');
              SQL.Add(' sync = :psync,');
              SQL.Add(' sync_data = :pSyncData');

              SQL.Add(' where deletado = ''N'' ');
              SQL.Add(' and departamento_id = ''' + Trim(vQuerySIC.FieldByName('DEPARTAMENTO_ID').AsString) + ''' ');
            end;
        end;

      try
        try
          try
          with vQuerySICWeb do
            begin
              ParamByName('pDepartamentoID').Text    := Trim(vQuerySIC.FieldByName('DEPARTAMENTO_ID').AsString);
              ParamByName('pDepartamento').Text      := Trim(vQuerySIC.FieldByName('DEPARTAMENTO').AsString);
              ParamByName('pGerenteID').Text         := Trim(vQuerySIC.FieldByName('GERENTE_ID').AsString);
              ParamByName('pGerente').Text           := Trim(vQuerySIC.FieldByName('GERENTE').AsString);
              ParamByName('pGerenteEmail').Text      := Trim(vQuerySIC.FieldByName('GERENTE_EMAIL').AsString);
              ParamByName('pCodigo').Text            := Trim(vQuerySIC.FieldByName('CODIGO').AsString);
              ParamByName('pData_inc').AsDateTime    := vQuerySIC.FieldByName('DATA_INC').AsDateTime;
              ParamByName('pUsuario_i').Text         := Trim(vQuerySIC.FieldByName('USUARIO_I').AsString);
              ParamByName('pUsuarionome_i').Text     := Trim(vQuerySIC.FieldByName('USUARIONOME_I').AsString);
              ParamByName('pData_alt').AsDateTime    := vQuerySIC.FieldByName('DATA_ALT').AsDateTime;
              ParamByName('pUsuario_a').Text         := Trim(vQuerySIC.FieldByName('USUARIO_A').AsString);
              ParamByName('pUsuarionome_a').Text     := Trim(vQuerySIC.FieldByName('USUARIONOME_A').AsString);
              ParamByName('pData_del').AsDateTime    := vQuerySIC.FieldByName('DATA_DEL').AsDateTime;
              ParamByName('pUsuario_d').Text         := Trim(vQuerySIC.FieldByName('USUARIO_D').AsString);
              ParamByName('pUsuarionome_d').Text     := Trim(vQuerySIC.FieldByName('USUARIONOME_D').AsString);
              ParamByName('pDeletado').Text          := Trim(vQuerySIC.FieldByName('DELETADO').AsString);
              ParamByName('pBloqueado').Text         := Trim(vQuerySIC.FieldByName('BLOQUEADO').AsString);
              ParamByName('pOBS').Text               := Trim(vQuerySIC.FieldByName('OBS').AsString);
              ParamByName('pAprovadorPedidoID').Text := Trim(vQuerySIC.FieldByName('APROVADORPEDIDO_ID').AsString);
              ParamByName('pAprovadorPedido').Text   := Trim(vQuerySIC.FieldByName('APROVADORPEDIDO').AsString);
              ParamByName('pSync').Text              := Trim(vQuerySIC.FieldByName('SYNC').AsString);
              ParamByName('pSyncData').AsDateTime    := vlData;

              //InputBox('','',sql.Text) ;

              ExecSQL;
              Transaction.CommitRetaining;
            end;
          except on e: exception do
            begin
              ShowMessage(e.Message);
            end;

          end;
        finally
          with vQueryUpdateSIC do
            begin
              Close;

              SQL.Clear;
              SQL.Text := 'update tbdepartamento set';
              SQL.Add(' sync = ''S'', ');
              SQL.Add(' sync_data = ''' + FormatDateTime('DD.MM.YYYY HH:MM:SS', vlData) + ''' ');
              SQL.Add(' where deletado = ''N'' ');
              SQL.Add(' and  departamento_id = ''' + Trim(vQuerySIC.FieldByName('DEPARTAMENTO_ID').AsString) + ''' ');

              ExecSQL;
              Transaction.CommitRetaining;
            end;

          Memo_Log.Lines.Add('Departamento atualizado em ' + FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ': '
                            + Trim(vQuerySIC.FieldByName('DEPARTAMENTO_ID').AsString) + ' - ' + Trim(vQuerySIC.FieldByName('DEPARTAMENTO').AsString));
        end;
      except on e : Exception do
        begin
          Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ' - Erro ao atualizar Departamento: ' + e.Message);
          vQuerySICWeb.Transaction.RollbackRetaining;
          dm1.IBDatabase1.Connected := False;
          dm1.IBDatabase1.Connected := True;

        end;
      end;

      vQuerySIC.Next;
      Application.ProcessMessages;
    end;
end;

procedure TForm_PrincipalServer.pAtualizaCCCloudToLocal(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);
var
  vQueryLocal, vQueryCloud, vQueryUpdateCloud: TIBQuery;
  vlData: TDateTime;
begin
  vQueryLocal := TIBQuery.Create(self);
  vQueryCloud := TIBQuery.Create(self);
  vQueryUpdateCloud := TIBQuery.Create(self);

  try
    vQueryLocal.Database := ALocalDatabase;
    vQueryLocal.Transaction := ALocalTransaction;

    vQueryCloud.Database := ACloudDatabase;
    vQueryCloud.Transaction := ACloudTransaction;

    vQueryUpdateCloud.Database := ACloudDatabase;
    vQueryUpdateCloud.Transaction := ACloudTransaction;

    vQueryCloud.Close;
    vQueryCloud.SQL.Text := 'SELECT * FROM TBCC WHERE SYNC = ''N''';
    vQueryCloud.Open;
    vQueryCloud.First;
    while not vQueryCloud.Eof do
    begin
      try
        vlData := Now;
        vQueryLocal.Close;
        vQueryLocal.SQL.Clear;
        vQueryLocal.SQL.Add('UPDATE OR INSERT INTO TBCC');
        vQueryLocal.SQL.Add('(CC_ID, NOME, CLASSE, CC_PAI, ENDERECO, COMPLEMENTO, BAIRRO, CIDADE, UF, TELEFONE,');
        vQueryLocal.SQL.Add('CELULAR, SITE, EMAIL, DELETADO, DATA_ALT, DATA_INC, CODIGO_CENTRO, CEP, TEMPLATE_CONTRATO,');
        vQueryLocal.SQL.Add('SYNC, SYNC_DATA)');
        vQueryLocal.SQL.Add('VALUES');
        vQueryLocal.SQL.Add('(:CC_ID, :NOME, :CLASSE, :CC_PAI, :ENDERECO, :COMPLEMENTO, :BAIRRO, :CIDADE, :UF, :TELEFONE,');
        vQueryLocal.SQL.Add(':CELULAR, :SITE, :EMAIL, :DELETADO, :DATA_ALT, :DATA_INC, :CODIGO_CENTRO, :CEP, :TEMPLATE_CONTRATO,');
        vQueryLocal.SQL.Add(':SYNC, :SYNC_DATA)');
        vQueryLocal.SQL.Add('MATCHING (CC_ID)');

        // Parametros
        vQueryLocal.ParamByName('CC_ID').AsString := vQueryCloud.FieldByName('CC_ID').AsString;
        if not vQueryCloud.FieldByName('NOME').IsNull then
          vQueryLocal.ParamByName('NOME').AsString := vQueryCloud.FieldByName('NOME').AsString;
        if not vQueryCloud.FieldByName('CLASSE').IsNull then
          vQueryLocal.ParamByName('CLASSE').AsString := vQueryCloud.FieldByName('CLASSE').AsString;
        if not vQueryCloud.FieldByName('CC_PAI').IsNull then
          vQueryLocal.ParamByName('CC_PAI').AsString := vQueryCloud.FieldByName('CC_PAI').AsString;
        if not vQueryCloud.FieldByName('ENDERECO').IsNull then
          vQueryLocal.ParamByName('ENDERECO').AsString := vQueryCloud.FieldByName('ENDERECO').AsString;
        if not vQueryCloud.FieldByName('COMPLEMENTO').IsNull then
          vQueryLocal.ParamByName('COMPLEMENTO').AsString := vQueryCloud.FieldByName('COMPLEMENTO').AsString;
        if not vQueryCloud.FieldByName('BAIRRO').IsNull then
          vQueryLocal.ParamByName('BAIRRO').AsString := vQueryCloud.FieldByName('BAIRRO').AsString;
        if not vQueryCloud.FieldByName('CIDADE').IsNull then
          vQueryLocal.ParamByName('CIDADE').AsString := vQueryCloud.FieldByName('CIDADE').AsString;
        if not vQueryCloud.FieldByName('UF').IsNull then
          vQueryLocal.ParamByName('UF').AsString := vQueryCloud.FieldByName('UF').AsString;
        if not vQueryCloud.FieldByName('TELEFONE').IsNull then
          vQueryLocal.ParamByName('TELEFONE').AsString := vQueryCloud.FieldByName('TELEFONE').AsString;
        if not vQueryCloud.FieldByName('CELULAR').IsNull then
          vQueryLocal.ParamByName('CELULAR').AsString := vQueryCloud.FieldByName('CELULAR').AsString;
        if not vQueryCloud.FieldByName('SITE').IsNull then
          vQueryLocal.ParamByName('SITE').AsString := vQueryCloud.FieldByName('SITE').AsString;
        if not vQueryCloud.FieldByName('EMAIL').IsNull then
          vQueryLocal.ParamByName('EMAIL').AsString := vQueryCloud.FieldByName('EMAIL').AsString;
        if not vQueryCloud.FieldByName('DELETADO').IsNull then
          vQueryLocal.ParamByName('DELETADO').AsString := vQueryCloud.FieldByName('DELETADO').AsString;
        if not vQueryCloud.FieldByName('DATA_ALT').IsNull then
          vQueryLocal.ParamByName('DATA_ALT').AsDateTime := vQueryCloud.FieldByName('DATA_ALT').AsDateTime;
        if not vQueryCloud.FieldByName('DATA_INC').IsNull then
          vQueryLocal.ParamByName('DATA_INC').AsDateTime := vQueryCloud.FieldByName('DATA_INC').AsDateTime;
        if not vQueryCloud.FieldByName('CODIGO_CENTRO').IsNull then
          vQueryLocal.ParamByName('CODIGO_CENTRO').AsString := vQueryCloud.FieldByName('CODIGO_CENTRO').AsString;
        if not vQueryCloud.FieldByName('CEP').IsNull then
          vQueryLocal.ParamByName('CEP').AsString := vQueryCloud.FieldByName('CEP').AsString;
        if not vQueryCloud.FieldByName('TEMPLATE_CONTRATO').IsNull then
          vQueryLocal.ParamByName('TEMPLATE_CONTRATO').AsString := vQueryCloud.FieldByName('TEMPLATE_CONTRATO').AsString;
        vQueryLocal.ParamByName('SYNC').AsString := 'S';
        vQueryLocal.ParamByName('SYNC_DATA').AsDateTime := vlData;

        vQueryLocal.ExecSQL;
        vQueryLocal.Transaction.CommitRetaining;

        vQueryUpdateCloud.Close;
        vQueryUpdateCloud.SQL.Clear;
        vQueryUpdateCloud.SQL.Add('UPDATE TBCC SET SYNC = ''S'', SYNC_DATA = :SYNC_DATA WHERE CC_ID = :CC_ID');

        vQueryUpdateCloud.ParamByName('SYNC_DATA').AsDateTime := vlData;
        vQueryUpdateCloud.ParamByName('CC_ID').AsString := vQueryCloud.FieldByName('CC_ID').AsString;

        vQueryUpdateCloud.ExecSQL;
        vQueryUpdateCloud.Transaction.CommitRetaining;

        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-TBCC atualizada Cloud->Local: ' +
                           Trim(vQueryCloud.FieldByName('CC_ID').AsString) + '-' + Trim(vQueryCloud.FieldByName('NOME').AsString));
          end);
      except on E: Exception do
        begin
          TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-Erro ao atualizar TBCC Cloud->Local: ' + E.Message);
            end);

          vQueryUpdateCloud.Transaction.RollbackRetaining;
          vQueryLocal.Transaction.RollbackRetaining;

          ALocalDatabase.Connected := False;
          ALocalDatabase.Connected := True;

          ACloudDatabase.Connected := False;
          ACloudDatabase.Connected := True;

          Break;
        end;
      end;

      vQueryCloud.Next;
    end;
  finally
    vQueryLocal.Free;
    vQueryCloud.Free;
    vQueryUpdateCloud.Free;
  end;
end;

procedure TForm_PrincipalServer.pAtualizaCCLocalToCloud(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);
var
  vQueryLocal, vQueryCloud, vQueryUpdateLocal: TIBQuery;
  vlData: TDateTime;
begin
  vQueryLocal := TIBQuery.Create(self);
  vQueryCloud := TIBQuery.Create(self);
  vQueryUpdateLocal := TIBQuery.Create(self);

  try
    vQueryLocal.Database := ALocalDatabase;
    vQueryLocal.Transaction := ALocalTransaction;

    vQueryCloud.Database := ACloudDatabase;
    vQueryCloud.Transaction := ACloudTransaction;

    vQueryUpdateLocal.Database := ALocalDatabase;
    vQueryUpdateLocal.Transaction := ALocalTransaction;

    vQueryLocal.Close;
    vQueryLocal.SQL.Text := 'SELECT * FROM TBCC WHERE SYNC = ''N''';
    vQueryLocal.Open;
    vQueryLocal.First;
    while not vQueryLocal.Eof do
    begin
      try
        vlData := Now;
        vQueryCloud.Close;
        vQueryCloud.SQL.Clear;
        vQueryCloud.SQL.Add('UPDATE OR INSERT INTO TBCC');
        vQueryCloud.SQL.Add('(CC_ID, NOME, CLASSE, CC_PAI, ENDERECO, COMPLEMENTO, BAIRRO, CIDADE, UF, TELEFONE,');
        vQueryCloud.SQL.Add('CELULAR, SITE, EMAIL, DELETADO, DATA_ALT, DATA_INC, CODIGO_CENTRO, CEP, TEMPLATE_CONTRATO,');
        vQueryCloud.SQL.Add('SYNC, SYNC_DATA)');
        vQueryCloud.SQL.Add('VALUES');
        vQueryCloud.SQL.Add('(:CC_ID, :NOME, :CLASSE, :CC_PAI, :ENDERECO, :COMPLEMENTO, :BAIRRO, :CIDADE, :UF, :TELEFONE,');
        vQueryCloud.SQL.Add(':CELULAR, :SITE, :EMAIL, :DELETADO, :DATA_ALT, :DATA_INC, :CODIGO_CENTRO, :CEP, :TEMPLATE_CONTRATO,');
        vQueryCloud.SQL.Add(':SYNC, :SYNC_DATA)');
        vQueryCloud.SQL.Add('MATCHING (CC_ID)');

        // Parametros
        vQueryCloud.ParamByName('CC_ID').AsString := vQueryLocal.FieldByName('CC_ID').AsString;
        if not vQueryLocal.FieldByName('NOME').IsNull then
          vQueryCloud.ParamByName('NOME').AsString := vQueryLocal.FieldByName('NOME').AsString;
        if not vQueryLocal.FieldByName('CLASSE').IsNull then
          vQueryCloud.ParamByName('CLASSE').AsString := vQueryLocal.FieldByName('CLASSE').AsString;
        if not vQueryLocal.FieldByName('CC_PAI').IsNull then
          vQueryCloud.ParamByName('CC_PAI').AsString := vQueryLocal.FieldByName('CC_PAI').AsString;
        if not vQueryLocal.FieldByName('ENDERECO').IsNull then
          vQueryCloud.ParamByName('ENDERECO').AsString := vQueryLocal.FieldByName('ENDERECO').AsString;
        if not vQueryLocal.FieldByName('COMPLEMENTO').IsNull then
          vQueryCloud.ParamByName('COMPLEMENTO').AsString := vQueryLocal.FieldByName('COMPLEMENTO').AsString;
        if not vQueryLocal.FieldByName('BAIRRO').IsNull then
          vQueryCloud.ParamByName('BAIRRO').AsString := vQueryLocal.FieldByName('BAIRRO').AsString;
        if not vQueryLocal.FieldByName('CIDADE').IsNull then
          vQueryCloud.ParamByName('CIDADE').AsString := vQueryLocal.FieldByName('CIDADE').AsString;
        if not vQueryLocal.FieldByName('UF').IsNull then
          vQueryCloud.ParamByName('UF').AsString := vQueryLocal.FieldByName('UF').AsString;
        if not vQueryLocal.FieldByName('TELEFONE').IsNull then
          vQueryCloud.ParamByName('TELEFONE').AsString := vQueryLocal.FieldByName('TELEFONE').AsString;
        if not vQueryLocal.FieldByName('CELULAR').IsNull then
          vQueryCloud.ParamByName('CELULAR').AsString := vQueryLocal.FieldByName('CELULAR').AsString;
        if not vQueryLocal.FieldByName('SITE').IsNull then
          vQueryCloud.ParamByName('SITE').AsString := vQueryLocal.FieldByName('SITE').AsString;
        if not vQueryLocal.FieldByName('EMAIL').IsNull then
          vQueryCloud.ParamByName('EMAIL').AsString := vQueryLocal.FieldByName('EMAIL').AsString;
        if not vQueryLocal.FieldByName('DELETADO').IsNull then
          vQueryCloud.ParamByName('DELETADO').AsString := vQueryLocal.FieldByName('DELETADO').AsString;
        if not vQueryLocal.FieldByName('DATA_ALT').IsNull then
          vQueryCloud.ParamByName('DATA_ALT').AsDateTime := vQueryLocal.FieldByName('DATA_ALT').AsDateTime;
        if not vQueryLocal.FieldByName('DATA_INC').IsNull then
          vQueryCloud.ParamByName('DATA_INC').AsDateTime := vQueryLocal.FieldByName('DATA_INC').AsDateTime;
        if not vQueryLocal.FieldByName('CODIGO_CENTRO').IsNull then
          vQueryCloud.ParamByName('CODIGO_CENTRO').AsString := vQueryLocal.FieldByName('CODIGO_CENTRO').AsString;
        if not vQueryLocal.FieldByName('CEP').IsNull then
          vQueryCloud.ParamByName('CEP').AsString := vQueryLocal.FieldByName('CEP').AsString;
        if not vQueryLocal.FieldByName('TEMPLATE_CONTRATO').IsNull then
          vQueryCloud.ParamByName('TEMPLATE_CONTRATO').AsString := vQueryLocal.FieldByName('TEMPLATE_CONTRATO').AsString;
        vQueryCloud.ParamByName('SYNC').AsString := 'S';
        vQueryCloud.ParamByName('SYNC_DATA').AsDateTime := vlData;

        vQueryCloud.ExecSQL;
        vQueryCloud.Transaction.CommitRetaining;

        vQueryUpdateLocal.Close;
        vQueryUpdateLocal.SQL.Clear;
        vQueryUpdateLocal.SQL.Add('UPDATE TBCC SET SYNC = ''S'', SYNC_DATA = :SYNC_DATA WHERE CC_ID = :CC_ID');

        vQueryUpdateLocal.ParamByName('SYNC_DATA').AsDateTime := vlData;
        vQueryUpdateLocal.ParamByName('CC_ID').AsString := vQueryLocal.FieldByName('CC_ID').AsString;

        vQueryUpdateLocal.ExecSQL;
        vQueryUpdateLocal.Transaction.CommitRetaining;

        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-TBCC atualizada Local->Cloud: ' +
                           Trim(vQueryLocal.FieldByName('CC_ID').AsString) + '-' + Trim(vQueryLocal.FieldByName('NOME').AsString));
          end);
      except on e: Exception do

        begin
          TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-Erro ao atualizar Local->Cloud: ' + E.Message);
            end);

          vQueryCloud.Transaction.RollbackRetaining;
          vQueryUpdateLocal.Transaction.RollbackRetaining;

          ACloudDatabase.Connected := False;
          ACloudDatabase.Connected := True;

          ALocalDatabase.Connected := False;
          ALocalDatabase.Connected := True;
        end;
      end;

      vQueryLocal.Next;
      Application.ProcessMessages;
    end;
  finally
    vQueryLocal.Free;
    vQueryCloud.Free;
    vQueryUpdateLocal.Free;
  end;
end;

procedure TForm_PrincipalServer.pAtualizaCliente;
begin
  with vQueryTOTVS do
    begin
      Connection     := dmProtheus.ADOConnection1;
      CommandTimeout := 999999;
      Close;

      SQL.Text := 'SELECT';
      SQL.Add(' SA1.A1_COD, SA1.A1_NOME, SA1.A1_NREDUZ, SA1.A1_MUN, SA1.A1_EST, SA1.A1_END,');
      SQL.Add(' SA1.A1_BAIRRO, SA1.A1_COMPLEM, SA1.A1_CEP, SA1.A1_CGC,');
      SQL.Add(' RTRIM(SA1.A1_DDD)+''-''+SA1.A1_TEL AS TELEFONE,');
      SQL.Add(' SA1.A1_EMAIL, SA1.A1_YTPCLI,');
      SQL.Add(' CASE WHEN SA1.A1_ULTCOM <> '''' THEN CONVERT(VARCHAR,CAST(SA1.A1_ULTCOM AS DATETIME),103) END AS A1_ULTCOM,');
      SQL.Add(' SA1.A1_NROCOM,');
      SQL.Add(' CASE SA1.A1_PESSOA');
      SQL.Add(' WHEN ''F'' THEN ''Fisica'' ');
      SQL.Add(' WHEN ''J'' THEN ''Juridica'' ');
      SQL.Add(' END AS PESSOA,');
      SQL.Add(' CASE SA1.A1_YTPCLI');
      SQL.Add(' WHEN ''1'' THEN ''Publico'' ');
      SQL.Add(' WHEN ''2'' THEN ''Privado'' ');
      SQL.Add(' WHEN ''3'' THEN ''Distribuidor'' ');
      SQL.Add(' WHEN ''4'' THEN ''Farmacias e Drogarias Privadas'' ');
      SQL.Add(' WHEN ''5'' THEN ''Demais Clientes'' ');
      SQL.Add(' END AS TIPOCLIENTE, SA1.A1_VEND');
      SQL.Add(' FROM SA1010 (NOLOCK) SA1');
      SQL.Add(' WHERE D_E_L_E_T_ = '' '' ');
      SQL.Add(' AND A1_MSEXP = '''' ');
      Open;
    end;

  vQueryTOTVS.First;

  while not vQueryTOTVS.Eof do
    begin
      with vQueryConstulta do
        begin
          Close;
          SQL.Text := 'select * from tbpessoas where deletado = ''N'' ';
          SQL.Add(' and erp_codigo = ''' + Trim(vQueryTOTVS.FieldByName('A1_COD').AsString) + ''' ') ;
          SQL.Add(' and classes like ''%A;%'' ');
          Open;
        end;

      if vQueryConstulta.IsEmpty then
        begin
          //Inserir
          with vQuerySIC do
            begin
              Close;
              SQL.Text := 'insert into tbpessoas';
              SQL.Add(' (empresa_id, erp_codigo, nome_pupular, nome, endereco,');
              SQL.Add(' bairro, cidade, uf, cep, cpf_cnpj, fone_01,');
              SQL.Add(' email, classes, recno, data_inc, deletado)');
              SQL.Add(' values');
              SQL.Add(' (:pEmpresaID, :pERPCodigo, :pNomePopular, :pNome, :pEndereco,');
              SQL.Add(' :pBairro, :pCidade, :pUF, :pCEP, :pCPFCNPJ, :pTelefone');
              SQL.Add(' :pEmail, :pClasses, :pRECNO, :pData, :pDeletado)');
            end;
        end
      else
        begin
          //Atualizar
          with vQuerySIC do
            begin
              Close;
              SQL.Text := 'update tbpessoas set';
              SQL.Add(' empresa_id   = :pEmpresaID,');
              SQL.Add(' erp_codigo   = :pERPCodigo,');
              SQL.Add(' nome_pupular = :pNomePopular,');
              SQL.Add(' nome         = :pNome,');
              SQL.Add(' endereco     = :pEndereco,');
              SQL.Add(' bairro       = :pBairro,');
              SQL.Add(' cidade       = :pCidade,');
              SQL.Add(' uf           = :pUF,');
              SQL.Add(' cep          = :pCEP,');
              SQL.Add(' cpf_cnpj     = :pCPFCNPJ,');
              SQL.Add(' fone_01      = :pTelefone,');
              SQL.Add(' email        = :pEmail,');
              SQL.Add(' classes      = :pClasses,');
              SQL.Add(' recno        = :pRECNO,');
              SQL.Add(' data_alt     = :pData,');
              SQL.Add(' deletado     = :pDeletado');
              SQL.Add(' where erp_codigo = ''' + Trim(vQueryTOTVS.FieldByName('A1_COD').AsString) + ''' ');
              SQL.Add(' and classes like ''%A;%'' ')
            end;
        end;

      try
        try
          with vQuerySIC do
            begin
              Params[0].Text    := Trim(vQueryTOTVS.FieldByName('A1_FILIAL').AsString);
              Params[1].Text    := Trim(vQueryTOTVS.FieldByName('A1_COD').AsString);
              Params[2].Text    := Trim(vQueryTOTVS.FieldByName('A1_NREDUZ').AsString);
              Params[3].Text    := Trim(vQueryTOTVS.FieldByName('A1_NOME').AsString);
              Params[4].Text    := Trim(vQueryTOTVS.FieldByName('A1_END').AsString);
              Params[5].Text    := Trim(vQueryTOTVS.FieldByName('A1_BAIRRO').AsString);
              Params[6].Text    := Trim(vQueryTOTVS.FieldByName('A1_MUN').AsString);
              Params[7].Text    := Trim(vQueryTOTVS.FieldByName('A1_EST').AsString);
              Params[8].Text    := Trim(vQueryTOTVS.FieldByName('A1_CEP').AsString);
              Params[9].Text    := Trim(vQueryTOTVS.FieldByName('A1_CGC').AsString);
              Params[10].Text   := Trim(vQueryTOTVS.FieldByName('A1_DDD').AsString) + Trim(vQueryTOTVS.FieldByName('A1_TEL').AsString);
              Params[11].Text   := Trim(vQueryTOTVS.FieldByName('A1_EMAIL').AsString);
              Params[12].Text   := 'A;';
              Params[13].Text   := Trim(vQueryTOTVS.FieldByName('R_E_C_N_O_').AsString);
              Params[14].AsDate := Now;
              Params[15].Text   := 'N';

              ExecSQL;
              Transaction.CommitRetaining;
            end;
        finally
          with vQueryUpdate do
            begin
              //dmProtheus.ADOConnection1.BeginTrans;
              //Prepared := True;
              Close;

              SQL.Text := 'UPDATE SA1010 SET';
              SQL.Add(' A1_MSEXP = ''' + FormatDateTime('YYYYMMDD', Date) + ''' ');
              SQL.Add(' WHERE D_E_L_E_T_ = '''' ');
              SQL.Add(' AND A1_MSEXP = '''' ');
              SQL.Add(' AND A1_COD = ''' + Trim(vQueryTOTVS.FieldByName('A1_COD').AsString) + ''' ');

              ExecSQL;
              //dmProtheus.ADOConnection1.CommitTrans;
            end;
        end;
      except on e : Exception do
        begin
          Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', Now) + ' - Erro ao atualizar cliente: ' + e.Message);
          vQuerySIC.Transaction.RollbackRetaining;
          dm1.IBDatabase1.Connected := False;
          dm1.IBDatabase1.Connected := True;

          dmProtheus.ADOConnection1.RollbackTrans;
          dmProtheus.ADOConnection1.Connected := False;
          dmProtheus.ADOConnection1.Connected := True;
        end;
      end;

      vQueryTOTVS.Next;
      Application.ProcessMessages;
    end;
end;

procedure TForm_PrincipalServer.pAtualizaClienteAmazon;
var
  lClienteTOTVS, lNomeClienteTOTVS : string;
  vMsgErro : string;
begin
  with vQueryTOTVS do
    begin
      Connection     := dmProtheus.ADOConnection1;
      CommandTimeout := 999999;

      Close;
      SQL.Text := 'SELECT';
      SQL.Add(' SA1.A1_COD, SA1.A1_NOME, SA1.A1_NREDUZ, SA1.A1_MUN, SA1.A1_EST, SA1.A1_END,');
      SQL.Add(' SA1.A1_BAIRRO, SA1.A1_COMPLEM, SA1.A1_CEP, SA1.A1_CGC,');
      SQL.Add(' RTRIM(SA1.A1_DDD)+''-''+SA1.A1_TEL AS TELEFONE,');
      SQL.Add(' SA1.A1_EMAIL, SA1.A1_YTPCLI, SA1.A1_YCLIPRI,');
      SQL.Add(' CASE WHEN SA1.A1_ULTCOM <> '''' THEN CONVERT(VARCHAR,CAST(SA1.A1_ULTCOM AS DATETIME),103) END AS A1_ULTCOM,');
      SQL.Add(' SA1.A1_NROCOM,');
      SQL.Add(' CASE SA1.A1_PESSOA');
      SQL.Add(' WHEN ''F'' THEN ''Fisica'' ');
      SQL.Add(' WHEN ''J'' THEN ''Juridica'' ');
      SQL.Add(' END AS PESSOA,');
      SQL.Add(' CASE SA1.A1_YTPCLI');
      SQL.Add(' WHEN ''1'' THEN ''Publico'' ');
      SQL.Add(' WHEN ''2'' THEN ''Privado'' ');
      SQL.Add(' WHEN ''3'' THEN ''Distribuidor'' ');
      SQL.Add(' WHEN ''4'' THEN ''Farmacias e Drogarias Privadas'' ');
      SQL.Add(' WHEN ''5'' THEN ''Demais Clientes'' ');
      SQL.Add(' END AS TIPOCLIENTE, SA1.A1_VEND');
      SQL.Add(' FROM SA1010 (NOLOCK) SA1');
      SQL.Add(' WHERE D_E_L_E_T_ = '' '' ');
      SQL.Add(' AND A1_MSEXP = '''' ');
  //    InputBox('','',sql.Text);
      Open;
    end;

  if not vQueryTOTVS.IsEmpty then
    begin
      vQueryTOTVS.First;
      while not vQueryTOTVS.Eof do
        begin
          if vPararServidor = True then
           begin
             Timer_Tabelas.Enabled := False;
             Memo_Log.Lines.Add('Servidor Desativado.');
             Abort;
           end;

          lClienteTOTVS     := Trim(vQueryTOTVS.FieldByName('A1_COD').AsString);
          lNomeClienteTOTVS := Trim(vQueryTOTVS.FieldByName('A1_NOME').AsString);

          if Trim(vQueryTOTVS.FieldByName('A1_YCLIPRI').AsString) = '' then
            begin
              try
                with vQueryConstultaWeb do
                  begin
                    Close;
                    SQL.Text := 'select * from tbcliente where deletado = ''N'' ';
                    SQL.Add(' and erp_cliente = ''' +lClienteTOTVS + ''' ') ;
                    Open;
                  end;
              except on e : Exception do
                begin
                  TThread.Synchronize(TThread.CurrentThread,
                    procedure
                    begin
                      vMsgErro := FormatDateTime('DD/MM/YYYY HH:MM:SS', Now) + '-Erro ao estabelecer conexão Clientes Local->Cloud PedidosOnline: ' + e.Message;
                      logErros(vMsgErro);
                      Memo_Log.Lines.Add(vMsgErro);
                    end);

                  dm1.IBDatabase3.Connected := False;
                  dm1.IBDatabase3.Connected := True;

                  dmProtheus.ADOConnection1.Close;
                  dmProtheus.ADOConnection1.Open;

                  Break;
                end;
              end;

              if vQueryConstultaWeb.IsEmpty then
                begin
                  //Inserir
                  with vQuerySICWeb do
                    begin
                      Close;
                      SQL.Text := 'insert into tbcliente';
                      SQL.Add(' (erp_cliente, nome, cidade, endereco, uf,');
                      SQL.Add(' bairro, complemento, cep, cpfcnpj, telefone,');
                      SQL.Add(' email, compra_ultima, compra_numero, tipocliente_id, tipocliente,');
                      SQL.add(' tipopessoa, erp_vendedor, deletado, data_inc)');
                      SQL.Add(' values');
                      SQL.Add(' (:pERPCliente, :pNome, :pCidade, :pEndereco, :pUF,');
                      SQL.Add(' :pBairro, :pComplemento, :pCEP, :pCPFCNPJ, :pTelefone,');
                      SQL.Add(' :pEmail, :pCompraUltima, :pCompraNumero, :pTipoClienteID, :pTipoCliente,');
                      SQL.Add(' :pTipoPessoa, :pERPVendedor, :pDeletado, :pData)');
                    end;
                end
              else
                begin
                  //Atualizar
                  with vQuerySICWeb do
                    begin
                      Close;
                      SQL.Text := 'update tbcliente set';
                      SQL.Add(' erp_cliente    = :pERPCliente,');
                      SQL.Add(' nome           = :pNome,');
                      SQL.Add(' cidade         = :pCidade,');
                      SQL.Add(' endereco       = :pEndereco,');
                      SQL.Add(' uf             = :pUF,');
                      SQL.Add(' bairro         = :pBairro,');
                      SQL.Add(' complemento    = :pComplemento,');
                      SQL.Add(' cep            = :pCEP,');
                      SQL.Add(' cpfcnpj        = :pCPFCNPJ,');
                      SQL.Add(' telefone       = :pTelefone,');
                      SQL.Add(' email          = :pEmail,');
                      SQL.Add(' compra_ultima  = :pCompraUltima,');
                      SQL.Add(' compra_numero  = :pCompraNumero,');
                      SQL.Add(' tipocliente_id = :pTipoClienteID,');
                      SQL.Add(' tipocliente    = :pTipoCliente,');
                      SQL.Add(' tipopessoa     = :pTipoPessoa,');
                      SQL.Add(' erp_vendedor   = :pERPVendedor,');
                      SQL.Add(' deletado       = :pDeletado,');
                      SQL.Add(' data_alt       = :pData');
                      SQL.Add(' where erp_cliente = ''' + lClienteTOTVS + ''' ');
                    end;
                end;

              try
                try
                  with vQuerySICWeb do
                    begin
                      Params[0].Text        := Trim(vQueryTOTVS.FieldByName('A1_COD').AsString);
                      Params[1].Text        := Trim(vQueryTOTVS.FieldByName('A1_NOME').AsString);
                      Params[2].Text        := Trim(vQueryTOTVS.FieldByName('A1_MUN').AsString);
                      Params[3].Text        := Trim(vQueryTOTVS.FieldByName('A1_END').AsString);
                      Params[4].Text        := Trim(vQueryTOTVS.FieldByName('A1_EST').AsString);
                      Params[5].Text        := Trim(vQueryTOTVS.FieldByName('A1_BAIRRO').AsString);
                      Params[6].Text        := Trim(vQueryTOTVS.FieldByName('A1_COMPLEM').AsString);
                      Params[7].Text        := Trim(vQueryTOTVS.FieldByName('A1_CEP').AsString);
                      Params[8].Text        := Trim(vQueryTOTVS.FieldByName('A1_CGC').AsString);
                      Params[9].Text        := Trim(vQueryTOTVS.FieldByName('TELEFONE').AsString);
                      Params[10].Text       := Trim(vQueryTOTVS.FieldByName('A1_EMAIL').AsString);
                      Params[11].Text       := Trim(vQueryTOTVS.FieldByName('A1_ULTCOM').AsString);
                      Params[12].Text       := Trim(vQueryTOTVS.FieldByName('A1_NROCOM').AsString);
                      Params[13].Text       := Trim(vQueryTOTVS.FieldByName('A1_YTPCLI').AsString);
                      Params[14].Text       := Trim(vQueryTOTVS.FieldByName('TIPOCLIENTE').AsString);
                      Params[15].Text       := Trim(vQueryTOTVS.FieldByName('PESSOA').AsString);
                      Params[16].Text       := Trim(vQueryTOTVS.FieldByName('A1_VEND').AsString);
                      Params[17].Text       := 'N';
                      Params[18].AsDateTime := Now;

                      //InputBox('','',sql.Text);

                      ExecSQL;
                      Transaction.CommitRetaining;
                    end;
                finally
                  with vQueryUpdate do
                    begin
                      //dmProtheus.ADOConnection1.BeginTrans;
                      //Prepared := True;
                      Close;

                      SQL.Text := 'UPDATE SA1010 SET';
                      SQL.Add(' A1_MSEXP = ''' + FormatDateTime('YYYYMMDD', Date) + ''' ');
                      SQL.Add(' WHERE D_E_L_E_T_ = '''' ');
                      SQL.Add(' AND A1_MSEXP = '''' ');
                      SQL.Add(' AND A1_COD = ''' + lClienteTOTVS + ''' ');

                      ExecSQL;
                      //dmProtheus.ADOConnection1.CommitTrans;
                    end;

                  TThread.Synchronize(TThread.CurrentThread,
                    procedure
                    begin
                      Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', Now) + '-Cliente Atualizado PedidosOnline: ' +
                                        lClienteTOTVS + '-' + lNomeClienteTOTVS)
                    end);
                end;

              except on e : Exception do
                begin
                  TThread.Synchronize(TThread.CurrentThread,
                    procedure
                    begin
                      vMsgErro := FormatDateTime('DD/MM/YYYY HH:MM:SS', Now) + '-Erro ao estabelecer conexão Clientes Local->Cloud PedidosOnline: ' + e.Message;
                      logErros(vMsgErro);
                      Memo_Log.Lines.Add(vMsgErro);
                    end);

                  vQuerySICWeb.Transaction.RollbackRetaining;
                  dm1.IBDatabase1.Connected := False;
                  dm1.IBDatabase1.Connected := True;

                  dmProtheus.ADOConnection1.RollbackTrans;
                  dmProtheus.ADOConnection1.Connected := False;
                  dmProtheus.ADOConnection1.Connected := True;

                  Break;
                end;
              end;
            end
          else
            begin
              with vQueryConstultaWeb do
                begin
                  Close;
                  SQL.Text := 'select * from tbcliente_entrega where deletado = ''N'' ';
                  SQL.Add(' and erp_cliente = ''' + lClienteTOTVS + ''' ') ;
                  Open;
                end;

              if vQueryConstultaWeb.IsEmpty then
                begin
                  //Inserir
                  with vQuerySICWeb do
                    begin
                      Close;
                      SQL.Text := 'insert into tbcliente_entrega';
                      SQL.Add(' (erp_cliente, nome, cidade, endereco, uf,');
                      SQL.Add(' bairro, complemento, cep, cpfcnpj, telefone,');
                      SQL.Add(' email, compra_ultima, compra_numero, tipocliente_id, tipocliente,');
                      SQL.add(' tipopessoa, cliente_pri, deletado, data_inc)');
                      SQL.Add(' values');
                      SQL.Add(' (:pERPCliente, :pNome, :pCidade, :pEndereco, :pUF,');
                      SQL.Add(' :pBairro, :pComplemento, :pCEP, :pCPFCNPJ, :pTelefone,');
                      SQL.Add(' :pEmail, :pCompraUltima, :pCompraNumero, :pTipoClienteID, :pTipoCliente,');
                      SQL.Add(' :pTipoPessoa, :pClientePri, :pDeletado, :pData)');
                    end;
                end
              else
                begin
                  //Atualizar
                  with vQuerySICWeb do
                    begin
                      Close;
                      SQL.Text := 'update tbcliente_entrega set';
                      SQL.Add(' erp_cliente    = :pERPCliente,');
                      SQL.Add(' nome           = :pNome,');
                      SQL.Add(' cidade         = :pCidade,');
                      SQL.Add(' endereco       = :pEndereco,');
                      SQL.Add(' uf             = :pUF,');
                      SQL.Add(' bairro         = :pBairro,');
                      SQL.Add(' complemento    = :pComplemento,');
                      SQL.Add(' cep            = :pCEP,');
                      SQL.Add(' cpfcnpj        = :pCPFCNPJ,');
                      SQL.Add(' telefone       = :pTelefone,');
                      SQL.Add(' email          = :pEmail,');
                      SQL.Add(' compra_ultima  = :pCompraUltima,');
                      SQL.Add(' compra_numero  = :pCompraNumero,');
                      SQL.Add(' tipocliente_id = :pTipoClienteID,');
                      SQL.Add(' tipocliente    = :pTipoCliente,');
                      SQL.Add(' tipopessoa     = :pTipoPessoa,');
                      SQL.Add(' cliente_pri    = :pClientePri,');
                      SQL.Add(' deletado       = :pDeletado,');
                      SQL.Add(' data_alt       = :pData');
                      SQL.Add(' where erp_cliente = ''' + lClienteTOTVS + ''' ');
                    end;
                end;

              try
                try
                  with vQuerySICWeb do
                    begin
                      Params[0].Text        := Trim(vQueryTOTVS.FieldByName('A1_COD').AsString);
                      Params[1].Text        := Trim(vQueryTOTVS.FieldByName('A1_NOME').AsString);
                      Params[2].Text        := Trim(vQueryTOTVS.FieldByName('A1_MUN').AsString);
                      Params[3].Text        := Trim(vQueryTOTVS.FieldByName('A1_END').AsString);
                      Params[4].Text        := Trim(vQueryTOTVS.FieldByName('A1_EST').AsString);
                      Params[5].Text        := Trim(vQueryTOTVS.FieldByName('A1_BAIRRO').AsString);
                      Params[6].Text        := Trim(vQueryTOTVS.FieldByName('A1_COMPLEM').AsString);
                      Params[7].Text        := Trim(vQueryTOTVS.FieldByName('A1_CEP').AsString);
                      Params[8].Text        := Trim(vQueryTOTVS.FieldByName('A1_CGC').AsString);
                      Params[9].Text        := Trim(vQueryTOTVS.FieldByName('TELEFONE').AsString);
                      Params[10].Text       := Trim(vQueryTOTVS.FieldByName('A1_EMAIL').AsString);
                      Params[11].Text       := Trim(vQueryTOTVS.FieldByName('A1_ULTCOM').AsString);
                      Params[12].Text       := Trim(vQueryTOTVS.FieldByName('A1_NROCOM').AsString);
                      Params[13].Text       := Trim(vQueryTOTVS.FieldByName('A1_YTPCLI').AsString);
                      Params[14].Text       := Trim(vQueryTOTVS.FieldByName('TIPOCLIENTE').AsString);
                      Params[15].Text       := Trim(vQueryTOTVS.FieldByName('PESSOA').AsString);
                      Params[16].Text       := Trim(vQueryTOTVS.FieldByName('A1_YCLIPRI').AsString);
                      Params[17].Text       := 'N';
                      Params[18].AsDateTime := Now;

                      ExecSQL;
                      Transaction.CommitRetaining;
                    end;
                finally
                  with vQueryUpdate do
                    begin
                      //dmProtheus.ADOConnection1.BeginTrans;
                      //Prepared := True;
                      Close;

                      SQL.Text := 'UPDATE SA1010 SET';
                      SQL.Add(' A1_MSEXP = ''' + FormatDateTime('YYYYMMDD', Date) + ''' ');
                      SQL.Add(' WHERE D_E_L_E_T_ = '''' ');
                      SQL.Add(' AND A1_MSEXP = '''' ');
                      SQL.Add(' AND A1_COD = ''' + lClienteTOTVS + ''' ');

                      ExecSQL;
                      //dmProtheus.ADOConnection1.CommitTrans;
                    end;

                  TThread.Synchronize(TThread.CurrentThread,
                    procedure
                    begin
                      Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', Now) + '-Endereço de Entrega Atualizado PedidosOnline: ' +
                                         lClienteTOTVS + '-' + lNomeClienteTOTVS);
                    end);
                end;

              except on e : Exception do
                begin
                  TThread.Synchronize(TThread.CurrentThread,
                    procedure
                    begin
                      vMsgErro := FormatDateTime('DD/MM/YYYY HH:MM:SS', Now) + '-Erro ao atualizar Endereço de Entrega Local->Cloud PedidosOnline: ' + e.Message;
                      logErros(vMsgErro);
                      Memo_Log.Lines.Add(vMsgErro);
                    end);

                  vQuerySICWeb.Transaction.RollbackRetaining;
                  dm1.IBDatabase1.Connected := False;
                  dm1.IBDatabase1.Connected := True;

                  dmProtheus.ADOConnection1.RollbackTrans;
                  dmProtheus.ADOConnection1.Connected := False;
                  dmProtheus.ADOConnection1.Connected := True;
                end;
              end;
            end;

          vQueryTOTVS.Next;
        end;
    end;
end;

procedure TForm_PrincipalServer.pAtualizaCondPagto;
begin
  with vQueryTOTVS do
    begin
      Close;
      SQL.Text := 'SELECT * FROM SE4010 WHERE D_E_L_E_T_ = '''' ';
      SQL.Add(' AND E4_MSEXP = '''' ');
      Open;
    end;

  vQueryTOTVS.First;

  while not vQueryTOTVS.Eof do
    begin
       if vPararServidor = True then
         begin
           Timer_Tabelas.Enabled := False;
           Memo_Log.Lines.Add('Servidor Desativado.');
           Abort;
         end;

      with vQueryConstulta do
        begin
          Close;
          SQL.Text := 'select * from tbcondpagto where deletado = ''N'' ';
          SQL.Add(' and erp_codigo = ''' + Trim(vQueryTOTVS.FieldByName('E4_CODIGO').AsString) + ''' ') ;
          Open;
        end;

      if vQueryConstulta.IsEmpty then
        begin
          //Inserir
          with vQuerySIC do
            begin
              Close;
              SQL.Text := 'insert into tbcondpagto';
              SQL.Add(' (erp_codigo, condicao, descricao_condicao, deletado)');
              SQL.Add(' values');
              SQL.Add(' (:pERPCodigo, :pCondicao, :pCondicaoDescricao, :pDeletado)');
            end;
        end
      else
        begin
          //Atualizar
          with vQuerySIC do
            begin
              Close;
              SQL.Text := 'update tbcondpagto set';
              SQL.Add(' erp_codigo         = :pERPCodigo,');
              SQL.Add(' condicao           = :pCondicao,');
              SQL.Add(' descricao_condicao = :pCondicaoDescricao,');
              SQL.Add(' deletado           = :pDeletado');
              SQL.Add(' where erp_codigo = ''' + Trim(vQueryTOTVS.FieldByName('E4_CODIGO').AsString) + ''' ');
            end;
        end;

      try
        try
          with vQuerySIC do
            begin
              Params[0].Text := Trim(vQueryTOTVS.FieldByName('E4_CODIGO').AsString);
              Params[1].Text := Trim(vQueryTOTVS.FieldByName('E4_COND').AsString);
              Params[2].Text := Trim(vQueryTOTVS.FieldByName('E4_DESCRI').AsString);
              Params[3].Text := 'N';

              ExecSQL;
              Transaction.CommitRetaining;
            end;
        finally
          with vQueryUpdate do
            begin
              //dmProtheus.ADOConnection1.BeginTrans;
              //Prepared := True;
              Close;

              SQL.Text := 'UPDATE SE4010 SET';
              SQL.Add(' E4_MSEXP = ''' + FormatDateTime('YYYYMMDD', Date) + ''' ');
              SQL.Add(' WHERE D_E_L_E_T_ = '''' ');
              SQL.Add(' AND E4_MSEXP = '''' ');
              SQL.Add(' AND E4_CODIGO = ''' + Trim(vQueryTOTVS.FieldByName('E4_CODIGO').AsString) + ''' ');

              ExecSQL;
              //dmProtheus.ADOConnection1.CommitTrans;
            end;

          TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', Now) + '-TBCONDPAGTO atualizada TOTVS Local->PedidosOnline Cloud: '
                              + Trim(vQueryTOTVS.FieldByName('E4_CODIGO').AsString) + '-' + Trim(vQueryTOTVS.FieldByName('E4_DESCRI').AsString));
            end);
        end;
      except on e : Exception do
        begin
          TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', Now) + '-Erro ao atualizar TBCONDPAGTO TOTVS Local->PedidosOnline Cloud: ' + e.Message);
            end);

          vQuerySIC.Transaction.RollbackRetaining;

          dm1.IBDatabase1.Connected := False;
          dm1.IBDatabase1.Connected := True;

          dmProtheus.ADOConnection1.RollbackTrans;
          dmProtheus.ADOConnection1.Connected := False;
          dmProtheus.ADOConnection1.Connected := True;
          Break;
        end;
      end;

      vQueryTOTVS.Next;
    end;
end;

procedure TForm_PrincipalServer.pAtualizaDepartamentoCloudToLocal(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);
var
  vQueryLocal, vQueryCloud, vQueryUpdateCloud: TIBQuery;
  vlData: TDateTime;
begin
  vQueryLocal := TIBQuery.Create(self);
  vQueryCloud := TIBQuery.Create(self);
  vQueryUpdateCloud := TIBQuery.Create(self);

  try
    vQueryLocal.Database := ALocalDatabase;
    vQueryLocal.Transaction := ALocalTransaction;

    vQueryCloud.Database := ACloudDatabase;
    vQueryCloud.Transaction := ACloudTransaction;

    vQueryUpdateCloud.Database := ACloudDatabase;
    vQueryUpdateCloud.Transaction := ACloudTransaction;

    vQueryCloud.Close;
    vQueryCloud.SQL.Text := 'SELECT * FROM TBDEPARTAMENTO WHERE SYNC = ''N''';
    vQueryCloud.Open;
    vQueryCloud.First;
    while not vQueryCloud.Eof do
    begin
      try
        vlData := Now;
        vQueryLocal.Close;
        vQueryLocal.SQL.Clear;
        vQueryLocal.SQL.Add('UPDATE OR INSERT INTO TBDEPARTAMENTO');
        vQueryLocal.SQL.Add('(DEPARTAMENTO_ID, DEPARTAMENTO, GERENTE_ID, GERENTE, GERENTE_EMAIL, CODIGO, DATA_INC, USUARIO_I,');
        vQueryLocal.SQL.Add('USUARIONOME_I, DATA_ALT, USUARIO_A, USUARIONOME_A, DATA_DEL, USUARIO_D, USUARIONOME_D, DELETADO,');
        vQueryLocal.SQL.Add('OBS, BLOQUEADO, APROVADORPEDIDO_ID, APROVADORPEDIDO, SYNC, SYNC_DATA)');
        vQueryLocal.SQL.Add('VALUES');
        vQueryLocal.SQL.Add('(:DEPARTAMENTO_ID, :DEPARTAMENTO, :GERENTE_ID, :GERENTE, :GERENTE_EMAIL, :CODIGO, :DATA_INC, :USUARIO_I,');
        vQueryLocal.SQL.Add(':USUARIONOME_I, :DATA_ALT, :USUARIO_A, :USUARIONOME_A, :DATA_DEL, :USUARIO_D, :USUARIONOME_D, :DELETADO,');
        vQueryLocal.SQL.Add(':OBS, :BLOQUEADO, :APROVADORPEDIDO_ID, :APROVADORPEDIDO, :SYNC, :SYNC_DATA)');
        vQueryLocal.SQL.Add('MATCHING (DEPARTAMENTO_ID)');

        // Parametros
        vQueryLocal.ParamByName('DEPARTAMENTO_ID').AsString := vQueryCloud.FieldByName('DEPARTAMENTO_ID').AsString;
        vQueryLocal.ParamByName('DEPARTAMENTO').AsString := vQueryCloud.FieldByName('DEPARTAMENTO').AsString;
        vQueryLocal.ParamByName('GERENTE_ID').AsString := vQueryCloud.FieldByName('GERENTE_ID').AsString;
        vQueryLocal.ParamByName('GERENTE').AsString := vQueryCloud.FieldByName('GERENTE').AsString;
        vQueryLocal.ParamByName('GERENTE_EMAIL').AsString := vQueryCloud.FieldByName('GERENTE_EMAIL').AsString;
        vQueryLocal.ParamByName('CODIGO').AsString := vQueryCloud.FieldByName('CODIGO').AsString;
        if not vQueryCloud.FieldByName('DATA_INC').IsNull then
          vQueryLocal.ParamByName('DATA_INC').AsDateTime := vQueryCloud.FieldByName('DATA_INC').AsDateTime;
        vQueryLocal.ParamByName('USUARIO_I').AsString := vQueryCloud.FieldByName('USUARIO_I').AsString;
        vQueryLocal.ParamByName('USUARIONOME_I').AsString := vQueryCloud.FieldByName('USUARIONOME_I').AsString;
        if not vQueryCloud.FieldByName('DATA_ALT').IsNull then
          vQueryLocal.ParamByName('DATA_ALT').AsDateTime := vQueryCloud.FieldByName('DATA_ALT').AsDateTime;
        vQueryLocal.ParamByName('USUARIO_A').AsString := vQueryCloud.FieldByName('USUARIO_A').AsString;
        vQueryLocal.ParamByName('USUARIONOME_A').AsString := vQueryCloud.FieldByName('USUARIONOME_A').AsString;
        if not vQueryCloud.FieldByName('DATA_DEL').IsNull then
          vQueryLocal.ParamByName('DATA_DEL').AsDateTime := vQueryCloud.FieldByName('DATA_DEL').AsDateTime;
        vQueryLocal.ParamByName('USUARIO_D').AsString := vQueryCloud.FieldByName('USUARIO_D').AsString;
        vQueryLocal.ParamByName('USUARIONOME_D').AsString := vQueryCloud.FieldByName('USUARIONOME_D').AsString;
        vQueryLocal.ParamByName('DELETADO').AsString := vQueryCloud.FieldByName('DELETADO').AsString;
        vQueryLocal.ParamByName('OBS').Assign(vQueryCloud.FieldByName('OBS'));
        vQueryLocal.ParamByName('BLOQUEADO').AsString := vQueryCloud.FieldByName('BLOQUEADO').AsString;
        vQueryLocal.ParamByName('APROVADORPEDIDO_ID').AsString := vQueryCloud.FieldByName('APROVADORPEDIDO_ID').AsString;
        vQueryLocal.ParamByName('APROVADORPEDIDO').AsString := vQueryCloud.FieldByName('APROVADORPEDIDO').AsString;
        vQueryLocal.ParamByName('SYNC').AsString := 'S';
        vQueryLocal.ParamByName('SYNC_DATA').AsDateTime := vlData;

        vQueryLocal.ExecSQL;
        vQueryLocal.Transaction.CommitRetaining;

        vQueryUpdateCloud.Close;
        vQueryUpdateCloud.SQL.Clear;
        vQueryUpdateCloud.SQL.Add('UPDATE TBDEPARTAMENTO SET SYNC = ''S'', SYNC_DATA = :SYNC_DATA WHERE DEPARTAMENTO_ID = :DEPARTAMENTO_ID');

        vQueryUpdateCloud.ParamByName('SYNC_DATA').AsDateTime := vlData;
        vQueryUpdateCloud.ParamByName('DEPARTAMENTO_ID').AsString := vQueryCloud.FieldByName('DEPARTAMENTO_ID').AsString;

        vQueryUpdateCloud.ExecSQL;
        vQueryUpdateCloud.Transaction.CommitRetaining;

        Memo_Log.Lines.Add('Item atualizado em ' + FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ': ' +
                           Trim(vQueryCloud.FieldByName('DEPARTAMENTO_ID').AsString) + ' - ' + Trim(vQueryCloud.FieldByName('DEPARTAMENTO').AsString));
      except
        on E: Exception do
        begin
          Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ' - Erro ao atualizar Item: ' + E.Message);
          vQueryLocal.Transaction.RollbackRetaining;
          dm1.IBDatabase1.Connected := False;
          dm1.IBDatabase1.Connected := True;

          dm1.IBDatabaseCloudSICFAR.Connected := False;
          dm1.IBDatabaseCloudSICFAR.Connected := True;
        end;
      end;

      vQueryCloud.Next;
      Application.ProcessMessages;
    end;
  finally
    vQueryLocal.Free;
    vQueryCloud.Free;
    vQueryUpdateCloud.Free;
  end;
end;

procedure TForm_PrincipalServer.pAtualizaDepartamentoLocalToCloud(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);
var
  vQueryLocal, vQueryCloud, vQueryUpdateLocal: TIBQuery;
  vlData: TDateTime;
begin
  vQueryLocal := TIBQuery.Create(self);
  vQueryCloud := TIBQuery.Create(self);
  vQueryUpdateLocal := TIBQuery.Create(self);

  try
    vQueryLocal.Database := ALocalDatabase;
    vQueryLocal.Transaction := ALocalTransaction;

    vQueryCloud.Database := ACloudDatabase;
    vQueryCloud.Transaction := ACloudTransaction;

    vQueryUpdateLocal.Database := ALocalDatabase;
    vQueryUpdateLocal.Transaction := ALocalTransaction;

    vQueryLocal.Close;
    vQueryLocal.SQL.Text := 'SELECT * FROM TBDEPARTAMENTO WHERE SYNC = ''N''';
    vQueryLocal.Open;
    vQueryLocal.First;
    while not vQueryLocal.Eof do
    begin
      try
        vlData := Now;
        vQueryCloud.Close;
        vQueryCloud.SQL.Clear;
        vQueryCloud.SQL.Add('UPDATE OR INSERT INTO TBDEPARTAMENTO');
        vQueryCloud.SQL.Add('(DEPARTAMENTO_ID, DEPARTAMENTO, GERENTE_ID, GERENTE, GERENTE_EMAIL, CODIGO, DATA_INC, USUARIO_I,');
        vQueryCloud.SQL.Add('USUARIONOME_I, DATA_ALT, USUARIO_A, USUARIONOME_A, DATA_DEL, USUARIO_D, USUARIONOME_D, DELETADO,');
        vQueryCloud.SQL.Add('OBS, BLOQUEADO, APROVADORPEDIDO_ID, APROVADORPEDIDO, SYNC, SYNC_DATA)');
        vQueryCloud.SQL.Add('VALUES');
        vQueryCloud.SQL.Add('(:DEPARTAMENTO_ID, :DEPARTAMENTO, :GERENTE_ID, :GERENTE, :GERENTE_EMAIL, :CODIGO, :DATA_INC, :USUARIO_I,');
        vQueryCloud.SQL.Add(':USUARIONOME_I, :DATA_ALT, :USUARIO_A, :USUARIONOME_A, :DATA_DEL, :USUARIO_D, :USUARIONOME_D, :DELETADO,');
        vQueryCloud.SQL.Add(':OBS, :BLOQUEADO, :APROVADORPEDIDO_ID, :APROVADORPEDIDO, :SYNC, :SYNC_DATA)');
        vQueryCloud.SQL.Add('MATCHING (DEPARTAMENTO_ID)');

        // Parametros
        vQueryCloud.ParamByName('DEPARTAMENTO_ID').AsString := vQueryLocal.FieldByName('DEPARTAMENTO_ID').AsString;
        vQueryCloud.ParamByName('DEPARTAMENTO').AsString := vQueryLocal.FieldByName('DEPARTAMENTO').AsString;
        vQueryCloud.ParamByName('GERENTE_ID').AsString := vQueryLocal.FieldByName('GERENTE_ID').AsString;
        vQueryCloud.ParamByName('GERENTE').AsString := vQueryLocal.FieldByName('GERENTE').AsString;
        vQueryCloud.ParamByName('GERENTE_EMAIL').AsString := vQueryLocal.FieldByName('GERENTE_EMAIL').AsString;
        vQueryCloud.ParamByName('CODIGO').AsString := vQueryLocal.FieldByName('CODIGO').AsString;
        if not vQueryLocal.FieldByName('DATA_INC').IsNull then
          vQueryCloud.ParamByName('DATA_INC').AsDateTime := vQueryLocal.FieldByName('DATA_INC').AsDateTime;
        vQueryCloud.ParamByName('USUARIO_I').AsString := vQueryLocal.FieldByName('USUARIO_I').AsString;
        vQueryCloud.ParamByName('USUARIONOME_I').AsString := vQueryLocal.FieldByName('USUARIONOME_I').AsString;
        if not vQueryLocal.FieldByName('DATA_ALT').IsNull then
          vQueryCloud.ParamByName('DATA_ALT').AsDateTime := vQueryLocal.FieldByName('DATA_ALT').AsDateTime;
        vQueryCloud.ParamByName('USUARIO_A').AsString := vQueryLocal.FieldByName('USUARIO_A').AsString;
        vQueryCloud.ParamByName('USUARIONOME_A').AsString := vQueryLocal.FieldByName('USUARIONOME_A').AsString;
        if not vQueryLocal.FieldByName('DATA_DEL').IsNull then
          vQueryCloud.ParamByName('DATA_DEL').AsDateTime := vQueryLocal.FieldByName('DATA_DEL').AsDateTime;
        vQueryCloud.ParamByName('USUARIO_D').AsString := vQueryLocal.FieldByName('USUARIO_D').AsString;
        vQueryCloud.ParamByName('USUARIONOME_D').AsString := vQueryLocal.FieldByName('USUARIONOME_D').AsString;
        vQueryCloud.ParamByName('DELETADO').AsString := vQueryLocal.FieldByName('DELETADO').AsString;
        vQueryCloud.ParamByName('OBS').Assign(vQueryLocal.FieldByName('OBS'));
        vQueryCloud.ParamByName('BLOQUEADO').AsString := vQueryLocal.FieldByName('BLOQUEADO').AsString;
        vQueryCloud.ParamByName('APROVADORPEDIDO_ID').AsString := vQueryLocal.FieldByName('APROVADORPEDIDO_ID').AsString;
        vQueryCloud.ParamByName('APROVADORPEDIDO').AsString := vQueryLocal.FieldByName('APROVADORPEDIDO').AsString;
        vQueryCloud.ParamByName('SYNC').AsString := 'S';
        vQueryCloud.ParamByName('SYNC_DATA').AsDateTime := vlData;

        vQueryCloud.ExecSQL;
        vQueryCloud.Transaction.CommitRetaining;

        vQueryUpdateLocal.Close;
        vQueryUpdateLocal.SQL.Clear;
        vQueryUpdateLocal.SQL.Add('UPDATE TBDEPARTAMENTO SET SYNC = ''S'', SYNC_DATA = :SYNC_DATA WHERE DEPARTAMENTO_ID = :DEPARTAMENTO_ID');

        vQueryUpdateLocal.ParamByName('SYNC_DATA').AsDateTime := vlData;
        vQueryUpdateLocal.ParamByName('DEPARTAMENTO_ID').AsString := vQueryLocal.FieldByName('DEPARTAMENTO_ID').AsString;

        vQueryUpdateLocal.ExecSQL;
        vQueryUpdateLocal.Transaction.CommitRetaining;

        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-TBDEPARTAMENTO atualizado Local->Cloud: ' +
                               Trim(vQueryLocal.FieldByName('DEPARTAMENTO_ID').AsString) + '-' + Trim(vQueryLocal.FieldByName('DEPARTAMENTO').AsString));
          end);
      except on E: Exception do
        begin
          TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-Erro ao atualizar TBDEPARTAMENTO Local->Cloud: ' + E.Message);
            end);

          vQueryCloud.Transaction.RollbackRetaining;
          vQueryUpdateLocal.Transaction.RollbackRetaining;

          dm1.IBDatabase1.Connected := False;
          dm1.IBDatabase1.Connected := True;

          dm1.IBDatabaseCloudSICFAR.Connected := False;
          dm1.IBDatabaseCloudSICFAR.Connected := True;
          Break;
        end;
      end;

      vQueryLocal.Next;
    end;
  finally
    vQueryLocal.Free;
    vQueryCloud.Free;
    vQueryUpdateLocal.Free;
  end;
end;

procedure TForm_PrincipalServer.pAtualizaDepto;
var
  vlData : TDateTime;
begin
  with vQuerySIC do
    begin
      Close;
      SQL.Text := 'select * from tbdepartamento where deletado = ''N'' ';
      SQL.Add(' and sync = ''N'' ');
      SQL.Add(' order by departamento_id');
      Open;
    end;

  vQuerySIC.First;

  while not vQuerySIC.Eof do
    begin
      vlData := Now;

       if vPararServidor = True then
         begin
           Timer_Tabelas.Enabled := False;
           Memo_Log.Lines.Add('Servidor Desativado.');
           Abort;
         end;

      with vQueryConstultaWeb do
        begin
          Close;
          SQL.Text := 'select * from tbdepartamento where deletado = ''N'' ';
          SQL.Add(' and departamento_id = ''' + Trim(vQuerySIC.FieldByName('DEPARTAMENTO_ID').AsString) + ''' ') ;
          Open;
        end;

      if vQueryConstultaWeb.IsEmpty then
        begin
          //Inserir
          with vQuerySICWeb do
            begin
              Close;
              SQL.Clear;
              SQL.Text := 'insert into tbdepartamento';
              SQL.Add(' (departamento_id, departamento, gerente_id, gerente, gerente_email,');
              SQL.Add(' codigo, data_inc, usuario_i, usuarionome_i,');
              SQL.Add(' data_alt, usuario_a, usuarionome_a, data_del,');
              SQL.Add(' usuario_d, usuarionome_d, deletado, bloqueado,');
              SQL.Add(' obs,  aprovadorpedido_id, aprovadorpedido, sync, sync_data)');
              SQL.Add(' values');
              SQL.Add(' (:pDepartamentoID, :pDepartamento, :pGerenteID, :pGerente, :pGerenteEmail,');
              SQL.Add(' :pCodigo, :pData_inc, :pUsuario_i, :pUsuarionome_i,');
              SQL.Add(' :pData_alt, :pUsuario_a, :pUsuarionome_a, :pData_del,');
              SQL.Add(' :pUsuario_d, :pUsuarionome_d, :pDeletado, :pBloqueado,');
              SQL.Add(' :pOBS, :pAprovadorPedidoID, :pAprovadorPedido, :pSync, :pSyncData)');
            end;
        end
      else
        begin
          //Atualizar
          with vQuerySICWeb do
            begin
              Close;
              SQL.Clear;
              SQL.Text := 'update tbdepartamento set';
              SQL.Add(' departamento_id = :pDepartamentoID,');
              SQL.Add(' departamento = :pDepartamento,');
              SQL.Add(' gerente_id = :pGerenteID,');
              SQL.Add(' gerente = :pGerente,');
              SQL.Add(' gerente_email = :pGerenteEmail,');
              SQL.Add(' codigo = :pCodigo,');
              SQL.Add(' data_inc = :pData_inc,');
              SQL.Add(' usuario_i = :pUsuario_i,');
              SQL.Add(' usuarionome_i = :pUsuarionome_i,');
              SQL.Add(' data_alt = :pData_alt,');
              SQL.Add(' usuario_a = :pUsuario_a,');
              SQL.Add(' usuarionome_a = :pUsuarionome_a,');
              SQL.Add(' data_del = :pData_del,');
              SQL.Add(' usuario_d = :pUsuario_d,');
              SQL.Add(' usuarionome_d = :pUsuarionome_d,');
              SQL.Add(' deletado = :pDeletado,');
              SQL.Add(' bloqueado = :pBloqueado,');
              SQL.Add(' obs = :pOBS,');
              SQL.Add(' aprovadorpedido_id = :pAprovadorPedidoID,');
              SQL.Add(' aprovadorpedido = :pAprovadorPedido,');
              SQL.Add(' sync = :psync,');
              SQL.Add(' sync_data = :pSyncData');

              SQL.Add(' where deletado = ''N'' ');
              SQL.Add(' and departamento_id = ''' + Trim(vQuerySIC.FieldByName('DEPARTAMENTO_ID').AsString) + ''' ');
            end;
        end;

      try
        try
          try
          with vQuerySICWeb do
            begin
              ParamByName('pDepartamentoID').Text    := Trim(vQuerySIC.FieldByName('DEPARTAMENTO_ID').AsString);
              ParamByName('pDepartamento').Text      := Trim(vQuerySIC.FieldByName('DEPARTAMENTO').AsString);
              ParamByName('pGerenteID').Text         := Trim(vQuerySIC.FieldByName('GERENTE_ID').AsString);
              ParamByName('pGerente').Text           := Trim(vQuerySIC.FieldByName('GERENTE').AsString);
              ParamByName('pGerenteEmail').Text      := Trim(vQuerySIC.FieldByName('GERENTE_EMAIL').AsString);
              ParamByName('pCodigo').Text            := Trim(vQuerySIC.FieldByName('CODIGO').AsString);
              ParamByName('pData_inc').AsDateTime    := vQuerySIC.FieldByName('DATA_INC').AsDateTime;
              ParamByName('pUsuario_i').Text         := Trim(vQuerySIC.FieldByName('USUARIO_I').AsString);
              ParamByName('pUsuarionome_i').Text     := Trim(vQuerySIC.FieldByName('USUARIONOME_I').AsString);
              ParamByName('pData_alt').AsDateTime    := vQuerySIC.FieldByName('DATA_ALT').AsDateTime;
              ParamByName('pUsuario_a').Text         := Trim(vQuerySIC.FieldByName('USUARIO_A').AsString);
              ParamByName('pUsuarionome_a').Text     := Trim(vQuerySIC.FieldByName('USUARIONOME_A').AsString);
              ParamByName('pData_del').AsDateTime    := vQuerySIC.FieldByName('DATA_DEL').AsDateTime;
              ParamByName('pUsuario_d').Text         := Trim(vQuerySIC.FieldByName('USUARIO_D').AsString);
              ParamByName('pUsuarionome_d').Text     := Trim(vQuerySIC.FieldByName('USUARIONOME_D').AsString);
              ParamByName('pDeletado').Text          := Trim(vQuerySIC.FieldByName('DELETADO').AsString);
              ParamByName('pBloqueado').Text         := Trim(vQuerySIC.FieldByName('BLOQUEADO').AsString);
              ParamByName('pOBS').Text               := Trim(vQuerySIC.FieldByName('OBS').AsString);
              ParamByName('pAprovadorPedidoID').Text := Trim(vQuerySIC.FieldByName('APROVADORPEDIDO_ID').AsString);
              ParamByName('pAprovadorPedido').Text   := Trim(vQuerySIC.FieldByName('APROVADORPEDIDO').AsString);
              ParamByName('pSync').Text              := Trim(vQuerySIC.FieldByName('SYNC').AsString);
              ParamByName('pSyncData').AsDateTime    := vlData;

              //InputBox('','',sql.Text) ;

              ExecSQL;
              Transaction.CommitRetaining;
            end;
          except on e: exception do
            begin
              ShowMessage(e.Message);
            end;

          end;
        finally
          with vQueryUpdateSIC do
            begin
              Close;

              SQL.Clear;
              SQL.Text := 'update tbdepartamento set';
              SQL.Add(' sync = ''S'', ');
              SQL.Add(' sync_data = ''' + FormatDateTime('DD.MM.YYYY HH:MM:SS', vlData) + ''' ');
              SQL.Add(' where deletado = ''N'' ');
              SQL.Add(' and  departamento_id = ''' + Trim(vQuerySIC.FieldByName('DEPARTAMENTO_ID').AsString) + ''' ');

              ExecSQL;
              Transaction.CommitRetaining;
            end;

          Memo_Log.Lines.Add('Departamento atualizado em ' + FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ': '
                            + Trim(vQuerySIC.FieldByName('DEPARTAMENTO_ID').AsString) + ' - ' + Trim(vQuerySIC.FieldByName('DEPARTAMENTO').AsString));
        end;
      except on e : Exception do
        begin
          Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ' - Erro ao atualizar Departamento: ' + e.Message);
          vQuerySICWeb.Transaction.RollbackRetaining;
          dm1.IBDatabase1.Connected := False;
          dm1.IBDatabase1.Connected := True;

        end;
      end;

      vQuerySIC.Next;
      Application.ProcessMessages;
    end;
end;

procedure TForm_PrincipalServer.pAtualizaFornecedor;
begin
  with vQueryTOTVS do
    begin
      Close;
      SQL.Text := 'SELECT * FROM SA2010 WHERE D_E_L_E_T_ = '''' ';
      SQL.Add(' AND A2_MSEXP = '''' ');
      Open;
    end;

  vQueryTOTVS.First;

  while not vQueryTOTVS.Eof do
    begin
       if vPararServidor = True then
         begin
           Timer_Tabelas.Enabled := False;
           Memo_Log.Lines.Add('Servidor Desativado.');
           Abort;
         end;

      with vQueryConstulta do
        begin
          Close;
          SQL.Text := 'select * from tbpessoas where deletado = ''N'' ';
          SQL.Add(' and erp_codigo = ''' + Trim(vQueryTOTVS.FieldByName('A2_COD').AsString) + ''' ') ;
          SQL.Add(' and classes like ''%B;%'' ');
          Open;
        end;

      if vQueryConstulta.IsEmpty then
        begin
          //Inserir
          with vQuerySIC do
            begin
              Close;
              SQL.Text := 'insert into tbpessoas';
              SQL.Add(' (empresa_id, erp_codigo, nome_pupular, nome, endereco,');
              SQL.Add(' bairro, cidade, uf, cep, tipo,');
              SQL.Add(' cpf_cnpj, rg_cgf, fone_01, email, classes,');
              SQL.Add(' recno, data_inc, deletado)');
              SQL.Add(' values');
              SQL.Add(' (:pEmpresaID, :pERPCodigo, :pNomePopular, :pNome, :pEndereco,');
              SQL.Add(' :pBairro, :pCidade, :pUF, :pCEP, :pTipo,');
              SQL.Add(' :pCPFCNPJ, :pRGCGF, :pTelefone, :pEmail, :pClasses,');
              SQL.Add(' :pRECNO, :pData, :pDeletado)');
            end;
        end
      else
        begin
          //Atualizar
          with vQuerySIC do
            begin
              Close;
              SQL.Text := 'update tbpessoas set';
              SQL.Add(' empresa_id   = :pEmpresaID,');
              SQL.Add(' erp_codigo   = :pERPCodigo,');
              SQL.Add(' nome_pupular = :pNomePopular,');
              SQL.Add(' nome         = :pNome,');
              SQL.Add(' endereco     = :pEndereco,');
              SQL.Add(' bairro       = :pBairro,');
              SQL.Add(' cidade       = :pCidade,');
              SQL.Add(' uf           = :pUF,');
              SQL.Add(' cep          = :pCEP,');
              SQL.Add(' tipo         = :pTipo,');
              SQL.Add(' cpf_cnpj     = :pCPFCNPJ,');
              SQL.Add(' rg_cgf       = :pRGCGF,');
              SQL.Add(' fone_01      = :pTelefone,');
              SQL.Add(' email        = :pEmail,');
              SQL.Add(' classes      = :pClasses,');
              SQL.Add(' recno        = :pRECNO,');
              SQL.Add(' data_alt     = :pData,');
              SQL.Add(' deletado     = :pDeletado');
              SQL.Add(' where erp_codigo = ''' + Trim(vQueryTOTVS.FieldByName('A2_COD').AsString) + ''' ');
              SQL.Add(' and classes like ''%B;%'' ')
            end;
        end;

      try
        try
          with vQuerySIC do
            begin
              Params[0].Text    := Trim(vQueryTOTVS.FieldByName('A2_FILIAL').AsString);
              Params[1].Text    := Trim(vQueryTOTVS.FieldByName('A2_COD').AsString);
              Params[2].Text    := Trim(vQueryTOTVS.FieldByName('A2_NREDUZ').AsString);
              Params[3].Text    := Trim(vQueryTOTVS.FieldByName('A2_NOME').AsString);
              Params[4].Text    := Trim(vQueryTOTVS.FieldByName('A2_END').AsString);
              Params[5].Text    := Trim(vQueryTOTVS.FieldByName('A2_BAIRRO').AsString);
              Params[6].Text    := Trim(vQueryTOTVS.FieldByName('A2_MUN').AsString);
              Params[7].Text    := Trim(vQueryTOTVS.FieldByName('A2_EST').AsString);
              Params[8].Text    := Trim(vQueryTOTVS.FieldByName('A2_CEP').AsString);
              Params[9].Text    := Trim(vQueryTOTVS.FieldByName('A2_TIPO').AsString);
              Params[10].Text   := Trim(vQueryTOTVS.FieldByName('A2_CGC').AsString);
              Params[11].Text   := Trim(vQueryTOTVS.FieldByName('A2_INSCR').AsString);
              Params[12].Text   := Trim(vQueryTOTVS.FieldByName('A2_DDD').AsString) + Trim(vQueryTOTVS.FieldByName('A2_TEL').AsString);
              Params[13].Text   := Trim(vQueryTOTVS.FieldByName('A2_EMAIL').AsString);
              Params[14].Text   := 'B;';
              Params[15].Text   := Trim(vQueryTOTVS.FieldByName('R_E_C_N_O_').AsString);
              Params[16].AsDate := Now;
              Params[17].Text   := 'N';

              ExecSQL;
              Transaction.CommitRetaining;
            end;
        finally
          with vQueryUpdate do
            begin
              Close;
              SQL.Text := 'UPDATE SA2010 SET';
              SQL.Add(' A2_MSEXP = ''' + FormatDateTime('YYYYMMDD', Date) + ''' ');
              SQL.Add(' WHERE D_E_L_E_T_ = '''' ');
              SQL.Add(' AND A2_MSEXP = '''' ');
              SQL.Add(' AND A2_COD = ''' + Trim(vQueryTOTVS.FieldByName('A2_COD').AsString) + ''' ');

              ExecSQL;
            end;

          TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', Now) + '-TBPESSOAS atualizada Fornecedor TOTVS->PedidosOnline Cloud: '
                            + Trim(vQueryTOTVS.FieldByName('A2_COD').AsString) + '-' + Trim(vQueryTOTVS.FieldByName('A2_NOME').AsString));
            end);
        end;
      except on e : Exception do
        begin
          TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', Now) + '-Erro ao atualizar TBPESSOAS Fornecedor TOTVS->PedidosOnline Cloud: ' + e.Message);
            end);

          vQuerySIC.Transaction.RollbackRetaining;
          dm1.IBDatabase1.Connected := False;
          dm1.IBDatabase1.Connected := True;

          dmProtheus.ADOConnection1.RollbackTrans;
          dmProtheus.ADOConnection1.Connected := False;
          dmProtheus.ADOConnection1.Connected := True;
        end;
      end;

      vQueryTOTVS.Next;
      Application.ProcessMessages;
    end;
end;

procedure TForm_PrincipalServer.pAtualizaItemScCloudToLocal(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);
var
  vQueryLocal, vQueryCloud, vQueryUpdateCloud: TIBQuery;
  vlData: TDateTime;
begin
  vQueryLocal := TIBQuery.Create(self);
  vQueryCloud := TIBQuery.Create(self);
  vQueryUpdateCloud := TIBQuery.Create(self);

  try
    vQueryLocal.Database := ALocalDatabase;
    vQueryLocal.Transaction := ALocalTransaction;

    vQueryCloud.Database := ACloudDatabase;
    vQueryCloud.Transaction := ACloudTransaction;

    vQueryUpdateCloud.Database := ACloudDatabase;
    vQueryUpdateCloud.Transaction := ACloudTransaction;

    vQueryCloud.Close;
    vQueryCloud.SQL.Text := 'SELECT * FROM TBITEM_SC WHERE SYNC = ''N''';
    vQueryCloud.Open;
    vQueryCloud.First;
    while not vQueryCloud.Eof do
    begin
      try
        vlData := Now;
        vQueryLocal.Close;
        vQueryLocal.SQL.Clear;
        vQueryLocal.SQL.Add('UPDATE OR INSERT INTO TBITEM_SC');
        vQueryLocal.SQL.Add('(ITEMSC_ID, SC_ID, CC_ID, DEPARTAMENTO_ID, PRODUTO_ID, QTDE, ENTREGA, ESTOQUE_ID,');
        vQueryLocal.SQL.Add('ESTOQUE_REFERENCIA, MARCA, OBS, DESAUTORIZACAO, STATUS, USUARIO_ID, EMPRESA_ID,');
        vQueryLocal.SQL.Add('DATA_INC, DATA_ALT, DELETADO, COTADO, COTACAO_ID, COTACAOITEM_ID, PEDIDO_ID,');
        vQueryLocal.SQL.Add('PEDIDOITEM_ID, REPLICADO, CENTRO_CUSTO, ERP_CC, DEPARTAMENTO, ERP_DEPARTAMENTO,');
        vQueryLocal.SQL.Add('PRODUTO, ERP_PRODUTO, UNIDADE, LOTE, ESTOQUE, USUARIONOME_I, USUARIO_A,');
        vQueryLocal.SQL.Add('USUARIONOME_A, DATA_DEL, USUARIO_D, USUARIONOME_D, APLICACAO_ID, APLICACAO, PRECO,');
        vQueryLocal.SQL.Add('TOTAL, STATUS_DATA, STATUS_USUARIO, CANCELADO_ID, CANCELADO, PROJETO_ID, PROJETO, SYNC, SYNC_DATA)');
        vQueryLocal.SQL.Add('VALUES');
        vQueryLocal.SQL.Add('(:ITEMSC_ID, :SC_ID, :CC_ID, :DEPARTAMENTO_ID, :PRODUTO_ID, :QTDE, :ENTREGA, :ESTOQUE_ID,');
        vQueryLocal.SQL.Add(':ESTOQUE_REFERENCIA, :MARCA, :OBS, :DESAUTORIZACAO, :STATUS, :USUARIO_ID, :EMPRESA_ID,');
        vQueryLocal.SQL.Add(':DATA_INC, :DATA_ALT, :DELETADO, :COTADO, :COTACAO_ID, :COTACAOITEM_ID, :PEDIDO_ID,');
        vQueryLocal.SQL.Add(':PEDIDOITEM_ID, :REPLICADO, :CENTRO_CUSTO, :ERP_CC, :DEPARTAMENTO, :ERP_DEPARTAMENTO,');
        vQueryLocal.SQL.Add(':PRODUTO, :ERP_PRODUTO, :UNIDADE, :LOTE, :ESTOQUE, :USUARIONOME_I, :USUARIO_A,');
        vQueryLocal.SQL.Add(':USUARIONOME_A, :DATA_DEL, :USUARIO_D, :USUARIONOME_D, :APLICACAO_ID, :APLICACAO, :PRECO,');
        vQueryLocal.SQL.Add(':TOTAL, :STATUS_DATA, :STATUS_USUARIO, :CANCELADO_ID, :CANCELADO, :PROJETO_ID, :PROJETO, :SYNC, :SYNC_DATA)');
        vQueryLocal.SQL.Add('MATCHING (ITEMSC_ID)');

        // Parametros
        vQueryLocal.ParamByName('ITEMSC_ID').AsInteger := vQueryCloud.FieldByName('ITEMSC_ID').AsInteger;
        vQueryLocal.ParamByName('SC_ID').AsInteger := vQueryCloud.FieldByName('SC_ID').AsInteger;
        vQueryLocal.ParamByName('CC_ID').AsInteger := vQueryCloud.FieldByName('CC_ID').AsInteger;
        vQueryLocal.ParamByName('DEPARTAMENTO_ID').AsInteger := vQueryCloud.FieldByName('DEPARTAMENTO_ID').AsInteger;
        vQueryLocal.ParamByName('PRODUTO_ID').AsInteger := vQueryCloud.FieldByName('PRODUTO_ID').AsInteger;
        vQueryLocal.ParamByName('QTDE').AsFloat := vQueryCloud.FieldByName('QTDE').AsFloat;

        if not vQueryCloud.FieldByName('ENTREGA').IsNull then
          vQueryLocal.ParamByName('ENTREGA').AsDateTime := vQueryCloud.FieldByName('ENTREGA').AsDateTime;

        vQueryLocal.ParamByName('ESTOQUE_ID').AsString := vQueryCloud.FieldByName('ESTOQUE_ID').AsString;
        vQueryLocal.ParamByName('ESTOQUE_REFERENCIA').AsString := vQueryCloud.FieldByName('ESTOQUE_REFERENCIA').AsString;
        vQueryLocal.ParamByName('MARCA').AsString := vQueryCloud.FieldByName('MARCA').AsString;
        vQueryLocal.ParamByName('OBS').AsString := vQueryCloud.FieldByName('OBS').AsString;
        vQueryLocal.ParamByName('DESAUTORIZACAO').AsString := vQueryCloud.FieldByName('DESAUTORIZACAO').AsString;
        vQueryLocal.ParamByName('STATUS').AsString := vQueryCloud.FieldByName('STATUS').AsString;
        vQueryLocal.ParamByName('USUARIO_ID').AsInteger := vQueryCloud.FieldByName('USUARIO_ID').AsInteger;
        vQueryLocal.ParamByName('EMPRESA_ID').AsInteger := vQueryCloud.FieldByName('EMPRESA_ID').AsInteger;
        if not vQueryCloud.FieldByName('DATA_INC').IsNull then
          vQueryLocal.ParamByName('DATA_INC').AsDateTime := vQueryCloud.FieldByName('DATA_INC').AsDateTime;
        if not vQueryCloud.FieldByName('DATA_ALT').IsNull then
          vQueryLocal.ParamByName('DATA_ALT').AsDateTime := vQueryCloud.FieldByName('DATA_ALT').AsDateTime;
        vQueryLocal.ParamByName('DELETADO').AsString := vQueryCloud.FieldByName('DELETADO').AsString;
        vQueryLocal.ParamByName('COTADO').AsString := vQueryCloud.FieldByName('COTADO').AsString;
        vQueryLocal.ParamByName('COTACAO_ID').AsInteger := vQueryCloud.FieldByName('COTACAO_ID').AsInteger;
        vQueryLocal.ParamByName('COTACAOITEM_ID').AsInteger := vQueryCloud.FieldByName('COTACAOITEM_ID').AsInteger;
        vQueryLocal.ParamByName('PEDIDO_ID').AsInteger := vQueryCloud.FieldByName('PEDIDO_ID').AsInteger;
        vQueryLocal.ParamByName('PEDIDOITEM_ID').AsInteger := vQueryCloud.FieldByName('PEDIDOITEM_ID').AsInteger;
        vQueryLocal.ParamByName('REPLICADO').AsString := vQueryCloud.FieldByName('REPLICADO').AsString;
        vQueryLocal.ParamByName('CENTRO_CUSTO').AsString := vQueryCloud.FieldByName('CENTRO_CUSTO').AsString;
        vQueryLocal.ParamByName('ERP_CC').AsString := vQueryCloud.FieldByName('ERP_CC').AsString;
        vQueryLocal.ParamByName('DEPARTAMENTO').AsString := vQueryCloud.FieldByName('DEPARTAMENTO').AsString;
        vQueryLocal.ParamByName('ERP_DEPARTAMENTO').AsString := vQueryCloud.FieldByName('ERP_DEPARTAMENTO').AsString;
        vQueryLocal.ParamByName('PRODUTO').AsString := vQueryCloud.FieldByName('PRODUTO').AsString;
        vQueryLocal.ParamByName('ERP_PRODUTO').AsString := vQueryCloud.FieldByName('ERP_PRODUTO').AsString;
        vQueryLocal.ParamByName('UNIDADE').AsString := vQueryCloud.FieldByName('UNIDADE').AsString;
        vQueryLocal.ParamByName('LOTE').AsString := vQueryCloud.FieldByName('LOTE').AsString;
        vQueryLocal.ParamByName('ESTOQUE').AsString := vQueryCloud.FieldByName('ESTOQUE').AsString;
        vQueryLocal.ParamByName('USUARIONOME_I').AsString := vQueryCloud.FieldByName('USUARIONOME_I').AsString;
        vQueryLocal.ParamByName('USUARIO_A').AsInteger := vQueryCloud.FieldByName('USUARIO_A').AsInteger;
        vQueryLocal.ParamByName('USUARIONOME_A').AsString := vQueryCloud.FieldByName('USUARIONOME_A').AsString;
        if not vQueryCloud.FieldByName('DATA_DEL').IsNull then
          vQueryLocal.ParamByName('DATA_DEL').AsDateTime := vQueryCloud.FieldByName('DATA_DEL').AsDateTime;
        vQueryLocal.ParamByName('USUARIO_D').AsInteger := vQueryCloud.FieldByName('USUARIO_D').AsInteger;
        vQueryLocal.ParamByName('USUARIONOME_D').AsString := vQueryCloud.FieldByName('USUARIONOME_D').AsString;
        vQueryLocal.ParamByName('APLICACAO_ID').AsInteger := vQueryCloud.FieldByName('APLICACAO_ID').AsInteger;
        vQueryLocal.ParamByName('APLICACAO').AsString := vQueryCloud.FieldByName('APLICACAO').AsString;
        vQueryLocal.ParamByName('PRECO').AsFloat := vQueryCloud.FieldByName('PRECO').AsFloat;
        vQueryLocal.ParamByName('TOTAL').AsFloat := vQueryCloud.FieldByName('TOTAL').AsFloat;
        if not vQueryCloud.FieldByName('STATUS_DATA').IsNull then
          vQueryLocal.ParamByName('STATUS_DATA').AsDateTime := vQueryCloud.FieldByName('STATUS_DATA').AsDateTime;
        vQueryLocal.ParamByName('STATUS_USUARIO').AsString := vQueryCloud.FieldByName('STATUS_USUARIO').AsString;
        vQueryLocal.ParamByName('CANCELADO_ID').AsString := vQueryCloud.FieldByName('CANCELADO_ID').AsString;
        vQueryLocal.ParamByName('CANCELADO').AsString := vQueryCloud.FieldByName('CANCELADO').AsString;
        vQueryLocal.ParamByName('PROJETO_ID').AsInteger := vQueryCloud.FieldByName('PROJETO_ID').AsInteger;
        vQueryLocal.ParamByName('PROJETO').AsString := vQueryCloud.FieldByName('PROJETO').AsString;
        vQueryLocal.ParamByName('SYNC').AsString := 'S';
        vQueryLocal.ParamByName('SYNC_DATA').AsDateTime := vlData;

        vQueryLocal.ExecSQL;
        vQueryLocal.Transaction.CommitRetaining;

        vQueryUpdateCloud.Close;
        vQueryUpdateCloud.SQL.Clear;
        vQueryUpdateCloud.SQL.Add('UPDATE TBITEM_SC SET SYNC = ''S'', SYNC_DATA = :SYNC_DATA WHERE ITEMSC_ID = :ITEMSC_ID');

        vQueryUpdateCloud.ParamByName('SYNC_DATA').AsDateTime := vlData;
        vQueryUpdateCloud.ParamByName('ITEMSC_ID').AsInteger := vQueryCloud.FieldByName('ITEMSC_ID').AsInteger;

        vQueryUpdateCloud.ExecSQL;
        vQueryUpdateCloud.Transaction.CommitRetaining;

        Memo_Log.Lines.Add('Item SC atualizado em ' + FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ': ' +
                           vQueryCloud.FieldByName('ITEMSC_ID').AsString + ' - ' + vQueryCloud.FieldByName('PRODUTO').AsString);
      except
        on E: Exception do
        begin
          Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ' - Erro ao atualizar Item SC: ' + E.Message);
          vQueryLocal.Transaction.RollbackRetaining;
          dm1.IBDatabase1.Connected := False;
          dm1.IBDatabase1.Connected := True;

          dm1.IBDatabaseCloudSICFAR.Connected := False;
          dm1.IBDatabaseCloudSICFAR.Connected := True;
        end;
      end;

      vQueryCloud.Next;
      Application.ProcessMessages;
    end;
  finally
    vQueryLocal.Free;
    vQueryCloud.Free;
    vQueryUpdateCloud.Free;
  end;
end;

procedure TForm_PrincipalServer.pAtualizaItemScLocalToCloud(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);
var
  vQueryLocal, vQueryCloud, vQueryUpdateLocal: TIBQuery;
  vlData: TDateTime;
begin
  vQueryLocal := TIBQuery.Create(self);
  vQueryCloud := TIBQuery.Create(self);
  vQueryUpdateLocal := TIBQuery.Create(self);

  try
    vQueryLocal.Database := ALocalDatabase;
    vQueryLocal.Transaction := ALocalTransaction;

    vQueryCloud.Database := ACloudDatabase;
    vQueryCloud.Transaction := ACloudTransaction;

    vQueryUpdateLocal.Database := ALocalDatabase;
    vQueryUpdateLocal.Transaction := ALocalTransaction;

    vQueryLocal.Close;
    vQueryLocal.SQL.Text := 'SELECT * FROM TBITEM_SC WHERE SYNC = ''N''';
    vQueryLocal.Open;
    vQueryLocal.First;
    while not vQueryLocal.Eof do
    begin
      try
        vlData := Now;
        vQueryCloud.Close;
        vQueryCloud.SQL.Clear;
        vQueryCloud.SQL.Add('UPDATE OR INSERT INTO TBITEM_SC');
        vQueryCloud.SQL.Add('(ITEMSC_ID, SC_ID, CC_ID, DEPARTAMENTO_ID, PRODUTO_ID, QTDE, ENTREGA, ESTOQUE_ID,');
        vQueryCloud.SQL.Add('ESTOQUE_REFERENCIA, MARCA, OBS, DESAUTORIZACAO, STATUS, USUARIO_ID, EMPRESA_ID,');
        vQueryCloud.SQL.Add('DATA_INC, DATA_ALT, DELETADO, COTADO, COTACAO_ID, COTACAOITEM_ID, PEDIDO_ID,');
        vQueryCloud.SQL.Add('PEDIDOITEM_ID, REPLICADO, CENTRO_CUSTO, ERP_CC, DEPARTAMENTO, ERP_DEPARTAMENTO,');
        vQueryCloud.SQL.Add('PRODUTO, ERP_PRODUTO, UNIDADE, LOTE, ESTOQUE, USUARIONOME_I, USUARIO_A,');
        vQueryCloud.SQL.Add('USUARIONOME_A, DATA_DEL, USUARIO_D, USUARIONOME_D, APLICACAO_ID, APLICACAO, PRECO,');
        vQueryCloud.SQL.Add('TOTAL, STATUS_DATA, STATUS_USUARIO, CANCELADO_ID, CANCELADO, PROJETO_ID, PROJETO, SYNC, SYNC_DATA)');
        vQueryCloud.SQL.Add('VALUES');
        vQueryCloud.SQL.Add('(:ITEMSC_ID, :SC_ID, :CC_ID, :DEPARTAMENTO_ID, :PRODUTO_ID, :QTDE, :ENTREGA, :ESTOQUE_ID,');
        vQueryCloud.SQL.Add(':ESTOQUE_REFERENCIA, :MARCA, :OBS, :DESAUTORIZACAO, :STATUS, :USUARIO_ID, :EMPRESA_ID,');
        vQueryCloud.SQL.Add(':DATA_INC, :DATA_ALT, :DELETADO, :COTADO, :COTACAO_ID, :COTACAOITEM_ID, :PEDIDO_ID,');
        vQueryCloud.SQL.Add(':PEDIDOITEM_ID, :REPLICADO, :CENTRO_CUSTO, :ERP_CC, :DEPARTAMENTO, :ERP_DEPARTAMENTO,');
        vQueryCloud.SQL.Add(':PRODUTO, :ERP_PRODUTO, :UNIDADE, :LOTE, :ESTOQUE, :USUARIONOME_I, :USUARIO_A,');
        vQueryCloud.SQL.Add(':USUARIONOME_A, :DATA_DEL, :USUARIO_D, :USUARIONOME_D, :APLICACAO_ID, :APLICACAO, :PRECO,');
        vQueryCloud.SQL.Add(':TOTAL, :STATUS_DATA, :STATUS_USUARIO, :CANCELADO_ID, :CANCELADO, :PROJETO_ID, :PROJETO, :SYNC, :SYNC_DATA)');
        vQueryCloud.SQL.Add('MATCHING (ITEMSC_ID)');

        // Parametros
        vQueryCloud.ParamByName('ITEMSC_ID').AsInteger := vQueryLocal.FieldByName('ITEMSC_ID').AsInteger;
        vQueryCloud.ParamByName('SC_ID').AsInteger := vQueryLocal.FieldByName('SC_ID').AsInteger;
        vQueryCloud.ParamByName('CC_ID').AsInteger := vQueryLocal.FieldByName('CC_ID').AsInteger;
        vQueryCloud.ParamByName('DEPARTAMENTO_ID').AsInteger := vQueryLocal.FieldByName('DEPARTAMENTO_ID').AsInteger;
        vQueryCloud.ParamByName('PRODUTO_ID').AsInteger := vQueryLocal.FieldByName('PRODUTO_ID').AsInteger;
        vQueryCloud.ParamByName('QTDE').AsFloat := vQueryLocal.FieldByName('QTDE').AsFloat;
        if not vQueryLocal.FieldByName('ENTREGA').IsNull then
          vQueryCloud.ParamByName('ENTREGA').AsDateTime := vQueryLocal.FieldByName('ENTREGA').AsDateTime;
        vQueryCloud.ParamByName('ESTOQUE_ID').AsString := vQueryLocal.FieldByName('ESTOQUE_ID').AsString;
        vQueryCloud.ParamByName('ESTOQUE_REFERENCIA').AsString := vQueryLocal.FieldByName('ESTOQUE_REFERENCIA').AsString;
        vQueryCloud.ParamByName('MARCA').AsString := vQueryLocal.FieldByName('MARCA').AsString;
        vQueryCloud.ParamByName('OBS').AsString := vQueryLocal.FieldByName('OBS').AsString;
        vQueryCloud.ParamByName('DESAUTORIZACAO').AsString := vQueryLocal.FieldByName('DESAUTORIZACAO').AsString;
        vQueryCloud.ParamByName('STATUS').AsString := vQueryLocal.FieldByName('STATUS').AsString;
        vQueryCloud.ParamByName('USUARIO_ID').AsInteger := vQueryLocal.FieldByName('USUARIO_ID').AsInteger;
        vQueryCloud.ParamByName('EMPRESA_ID').AsInteger := vQueryLocal.FieldByName('EMPRESA_ID').AsInteger;
        if not vQueryLocal.FieldByName('DATA_INC').IsNull then
          vQueryCloud.ParamByName('DATA_INC').AsDateTime := vQueryLocal.FieldByName('DATA_INC').AsDateTime;
        if not vQueryLocal.FieldByName('DATA_ALT').IsNull then
          vQueryCloud.ParamByName('DATA_ALT').AsDateTime := vQueryLocal.FieldByName('DATA_ALT').AsDateTime;
        vQueryCloud.ParamByName('DELETADO').AsString := vQueryLocal.FieldByName('DELETADO').AsString;
        vQueryCloud.ParamByName('COTADO').AsString := vQueryLocal.FieldByName('COTADO').AsString;
        vQueryCloud.ParamByName('COTACAO_ID').AsInteger := vQueryLocal.FieldByName('COTACAO_ID').AsInteger;
        vQueryCloud.ParamByName('COTACAOITEM_ID').AsInteger := vQueryLocal.FieldByName('COTACAOITEM_ID').AsInteger;
        vQueryCloud.ParamByName('PEDIDO_ID').AsInteger := vQueryLocal.FieldByName('PEDIDO_ID').AsInteger;
        vQueryCloud.ParamByName('PEDIDOITEM_ID').AsInteger := vQueryLocal.FieldByName('PEDIDOITEM_ID').AsInteger;
        vQueryCloud.ParamByName('REPLICADO').AsString := vQueryLocal.FieldByName('REPLICADO').AsString;
        vQueryCloud.ParamByName('CENTRO_CUSTO').AsString := vQueryLocal.FieldByName('CENTRO_CUSTO').AsString;
        vQueryCloud.ParamByName('ERP_CC').AsString := vQueryLocal.FieldByName('ERP_CC').AsString;
        vQueryCloud.ParamByName('DEPARTAMENTO').AsString := vQueryLocal.FieldByName('DEPARTAMENTO').AsString;
        vQueryCloud.ParamByName('ERP_DEPARTAMENTO').AsString := vQueryLocal.FieldByName('ERP_DEPARTAMENTO').AsString;
        vQueryCloud.ParamByName('PRODUTO').AsString := vQueryLocal.FieldByName('PRODUTO').AsString;
        vQueryCloud.ParamByName('ERP_PRODUTO').AsString := vQueryLocal.FieldByName('ERP_PRODUTO').AsString;
        vQueryCloud.ParamByName('UNIDADE').AsString := vQueryLocal.FieldByName('UNIDADE').AsString;
        vQueryCloud.ParamByName('LOTE').AsString := vQueryLocal.FieldByName('LOTE').AsString;
        vQueryCloud.ParamByName('ESTOQUE').AsString := vQueryLocal.FieldByName('ESTOQUE').AsString;
        vQueryCloud.ParamByName('USUARIONOME_I').AsString := vQueryLocal.FieldByName('USUARIONOME_I').AsString;
        vQueryCloud.ParamByName('USUARIO_A').AsInteger := vQueryLocal.FieldByName('USUARIO_A').AsInteger;
        vQueryCloud.ParamByName('USUARIONOME_A').AsString := vQueryLocal.FieldByName('USUARIONOME_A').AsString;
        if not vQueryLocal.FieldByName('DATA_DEL').IsNull then
          vQueryCloud.ParamByName('DATA_DEL').AsDateTime := vQueryLocal.FieldByName('DATA_DEL').AsDateTime;
        vQueryCloud.ParamByName('USUARIO_D').AsInteger := vQueryLocal.FieldByName('USUARIO_D').AsInteger;
        vQueryCloud.ParamByName('USUARIONOME_D').AsString := vQueryLocal.FieldByName('USUARIONOME_D').AsString;
        vQueryCloud.ParamByName('APLICACAO_ID').AsInteger := vQueryLocal.FieldByName('APLICACAO_ID').AsInteger;
        vQueryCloud.ParamByName('APLICACAO').AsString := vQueryLocal.FieldByName('APLICACAO').AsString;
        vQueryCloud.ParamByName('PRECO').AsFloat := vQueryLocal.FieldByName('PRECO').AsFloat;
        vQueryCloud.ParamByName('TOTAL').AsFloat := vQueryLocal.FieldByName('TOTAL').AsFloat;
        if not vQueryLocal.FieldByName('STATUS_DATA').IsNull then
          vQueryCloud.ParamByName('STATUS_DATA').AsDateTime := vQueryLocal.FieldByName('STATUS_DATA').AsDateTime;
        vQueryCloud.ParamByName('STATUS_USUARIO').AsString := vQueryLocal.FieldByName('STATUS_USUARIO').AsString;
        vQueryCloud.ParamByName('CANCELADO_ID').AsString := vQueryLocal.FieldByName('CANCELADO_ID').AsString;
        vQueryCloud.ParamByName('CANCELADO').AsString := vQueryLocal.FieldByName('CANCELADO').AsString;
        vQueryCloud.ParamByName('PROJETO_ID').AsInteger := vQueryLocal.FieldByName('PROJETO_ID').AsInteger;
        vQueryCloud.ParamByName('PROJETO').AsString := vQueryLocal.FieldByName('PROJETO').AsString;
        vQueryCloud.ParamByName('SYNC').AsString := 'S';
        vQueryCloud.ParamByName('SYNC_DATA').AsDateTime := vlData;

        vQueryCloud.ExecSQL;
        vQueryCloud.Transaction.CommitRetaining;

        vQueryUpdateLocal.Close;
        vQueryUpdateLocal.SQL.Clear;
        vQueryUpdateLocal.SQL.Add('UPDATE TBITEM_SC SET SYNC = ''S'', SYNC_DATA = :SYNC_DATA WHERE ITEMSC_ID = :ITEMSC_ID');

        vQueryUpdateLocal.ParamByName('SYNC_DATA').AsDateTime := vlData;
        vQueryUpdateLocal.ParamByName('ITEMSC_ID').AsInteger := vQueryLocal.FieldByName('ITEMSC_ID').AsInteger;

        vQueryUpdateLocal.ExecSQL;
        vQueryUpdateLocal.Transaction.CommitRetaining;

        Memo_Log.Lines.Add('Item SC atualizado em ' + FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ': ' +
                           vQueryLocal.FieldByName('ITEMSC_ID').AsString + ' - ' + vQueryLocal.FieldByName('PRODUTO').AsString);
      except
        on E: Exception do
        begin
          Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ' - Erro ao atualizar Item SC: ' + E.Message);
          vQueryCloud.Transaction.RollbackRetaining;
          dm1.IBDatabase1.Connected := False;
          dm1.IBDatabase1.Connected := True;

          dm1.IBDatabaseCloudSICFAR.Connected := False;
          dm1.IBDatabaseCloudSICFAR.Connected := True;
        end;
      end;

      vQueryLocal.Next;
      Application.ProcessMessages;
    end;
  finally
    vQueryLocal.Free;
    vQueryCloud.Free;
    vQueryUpdateLocal.Free;
  end;
end;

procedure TForm_PrincipalServer.pAtualizaLicitacaoAdiCloudToLocal(
  ALocalDatabase, ACloudDatabase: TIBDatabase; ALocalTransaction,
  ACloudTransaction: TIBTransaction; prLicitacaoId : String);
var
  vQueryLocal, vQueryCloud, vQueryUpdateCloud: TIBQuery;
  vlData: TDateTime;
begin
  vQueryLocal := TIBQuery.Create(self);
  vQueryCloud := TIBQuery.Create(self);
  vQueryUpdateCloud := TIBQuery.Create(self);

  try
    vQueryLocal.Database := ALocalDatabase;
    vQueryLocal.Transaction := ALocalTransaction;

    vQueryCloud.Database := ACloudDatabase;
    vQueryCloud.Transaction := ACloudTransaction;

    vQueryUpdateCloud.Database := ACloudDatabase;
    vQueryUpdateCloud.Transaction := ACloudTransaction;

    vQueryCloud.Close;
    vQueryCloud.SQL.Text := 'SELECT * FROM TBLICITACAO_ADI WHERE 1=1';

    if Trim(prLicitacaoID) = '' then
      vQueryCloud.SQL.Add(' AND SYNC = ''N'' ')
    else
      vQueryCloud.SQL.Add(' AND LICITACAO_ID = ''' + Trim(prLicitacaoID) + ''' ');

    vQueryCloud.Open;
    vQueryCloud.First;
    while not vQueryCloud.Eof do
    begin
      try
        vlData := Now;
        vQueryLocal.Close;
        vQueryLocal.SQL.Clear;
        vQueryLocal.SQL.Add('UPDATE OR INSERT INTO TBLICITACAO_ADI');
        vQueryLocal.SQL.Add('(LICITACAOADI_ID, LICITACAO_ID, LICITACAOADESAO_ID, PRODUTO_ID, PRODUTO, ATENDIDO, PEDIDO, NF, NF_SERIE,');
        vQueryLocal.SQL.Add('DATA_INC, USUARIO_I, USUARIONOME_I, DATA_ALT, USUARIO_A, USUARIONOME_A, DATA_DEL, USUARIO_D, USUARIONOME_D,');
        vQueryLocal.SQL.Add('DELETADO, EMPENHO, SYNC, SYNC_DATA)');
        vQueryLocal.SQL.Add('VALUES');
        vQueryLocal.SQL.Add('(:LICITACAOADI_ID, :LICITACAO_ID, :LICITACAOADESAO_ID, :PRODUTO_ID, :PRODUTO, :ATENDIDO, :PEDIDO, :NF, :NF_SERIE,');
        vQueryLocal.SQL.Add(':DATA_INC, :USUARIO_I, :USUARIONOME_I, :DATA_ALT, :USUARIO_A, :USUARIONOME_A, :DATA_DEL, :USUARIO_D, :USUARIONOME_D,');
        vQueryLocal.SQL.Add(':DELETADO, :EMPENHO, :SYNC, :SYNC_DATA)');
        vQueryLocal.SQL.Add('MATCHING (LICITACAOADI_ID)');

        // Parametros
        vQueryLocal.ParamByName('LICITACAOADI_ID').AsString := vQueryCloud.FieldByName('LICITACAOADI_ID').AsString;
        if not vQueryCloud.FieldByName('LICITACAO_ID').IsNull then
          vQueryLocal.ParamByName('LICITACAO_ID').AsString := vQueryCloud.FieldByName('LICITACAO_ID').AsString;
        if not vQueryCloud.FieldByName('LICITACAOADESAO_ID').IsNull then
          vQueryLocal.ParamByName('LICITACAOADESAO_ID').AsString := vQueryCloud.FieldByName('LICITACAOADESAO_ID').AsString;
        if not vQueryCloud.FieldByName('PRODUTO_ID').IsNull then
          vQueryLocal.ParamByName('PRODUTO_ID').AsString := vQueryCloud.FieldByName('PRODUTO_ID').AsString;
        if not vQueryCloud.FieldByName('PRODUTO').IsNull then
          vQueryLocal.ParamByName('PRODUTO').AsString := vQueryCloud.FieldByName('PRODUTO').AsString;
        if not vQueryCloud.FieldByName('ATENDIDO').IsNull then
          vQueryLocal.ParamByName('ATENDIDO').AsFloat := vQueryCloud.FieldByName('ATENDIDO').AsFloat;
        if not vQueryCloud.FieldByName('PEDIDO').IsNull then
          vQueryLocal.ParamByName('PEDIDO').AsString := vQueryCloud.FieldByName('PEDIDO').AsString;
        if not vQueryCloud.FieldByName('NF').IsNull then
          vQueryLocal.ParamByName('NF').AsString := vQueryCloud.FieldByName('NF').AsString;
        if not vQueryCloud.FieldByName('NF_SERIE').IsNull then
          vQueryLocal.ParamByName('NF_SERIE').AsString := vQueryCloud.FieldByName('NF_SERIE').AsString;
        if not vQueryCloud.FieldByName('DATA_INC').IsNull then
          vQueryLocal.ParamByName('DATA_INC').AsDateTime := vQueryCloud.FieldByName('DATA_INC').AsDateTime;
        if not vQueryCloud.FieldByName('USUARIO_I').IsNull then
          vQueryLocal.ParamByName('USUARIO_I').AsString := vQueryCloud.FieldByName('USUARIO_I').AsString;
        if not vQueryCloud.FieldByName('USUARIONOME_I').IsNull then
          vQueryLocal.ParamByName('USUARIONOME_I').AsString := vQueryCloud.FieldByName('USUARIONOME_I').AsString;
        if not vQueryCloud.FieldByName('DATA_ALT').IsNull then
          vQueryLocal.ParamByName('DATA_ALT').AsDateTime := vQueryCloud.FieldByName('DATA_ALT').AsDateTime;
        if not vQueryCloud.FieldByName('USUARIO_A').IsNull then
          vQueryLocal.ParamByName('USUARIO_A').AsString := vQueryCloud.FieldByName('USUARIO_A').AsString;
        if not vQueryCloud.FieldByName('USUARIONOME_A').IsNull then
          vQueryLocal.ParamByName('USUARIONOME_A').AsString := vQueryCloud.FieldByName('USUARIONOME_A').AsString;
        if not vQueryCloud.FieldByName('DATA_DEL').IsNull then
          vQueryLocal.ParamByName('DATA_DEL').AsDateTime := vQueryCloud.FieldByName('DATA_DEL').AsDateTime;
        if not vQueryCloud.FieldByName('USUARIO_D').IsNull then
          vQueryLocal.ParamByName('USUARIO_D').AsString := vQueryCloud.FieldByName('USUARIO_D').AsString;
        if not vQueryCloud.FieldByName('USUARIONOME_D').IsNull then
          vQueryLocal.ParamByName('USUARIONOME_D').AsString := vQueryCloud.FieldByName('USUARIONOME_D').AsString;
        if not vQueryCloud.FieldByName('DELETADO').IsNull then
          vQueryLocal.ParamByName('DELETADO').AsString := vQueryCloud.FieldByName('DELETADO').AsString;
        if not vQueryCloud.FieldByName('EMPENHO').IsNull then
          vQueryLocal.ParamByName('EMPENHO').AsFloat := vQueryCloud.FieldByName('EMPENHO').AsFloat;
        vQueryLocal.ParamByName('SYNC').AsString := 'S';
        vQueryLocal.ParamByName('SYNC_DATA').AsDateTime := vlData;

        vQueryLocal.ExecSQL;
        vQueryLocal.Transaction.CommitRetaining;

        vQueryUpdateCloud.Close;
        vQueryUpdateCloud.SQL.Clear;
        vQueryUpdateCloud.SQL.Add('UPDATE TBLICITACAO_ADI SET SYNC = ''S'', SYNC_DATA = :SYNC_DATA WHERE LICITACAOADI_ID = :LICITACAOADI_ID');

        vQueryUpdateCloud.ParamByName('SYNC_DATA').AsDateTime := vlData;
        vQueryUpdateCloud.ParamByName('LICITACAOADI_ID').AsString := vQueryCloud.FieldByName('LICITACAOADI_ID').AsString;

        vQueryUpdateCloud.ExecSQL;
        vQueryUpdateCloud.Transaction.CommitRetaining;

        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-TBLICITACAO_ADI atualizada Cloud->Local: ' +
                         Trim(vQueryCloud.FieldByName('LICITACAOADI_ID').AsString));
          end);
      except on E: Exception do
        begin
          TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-Erro ao atualizar TBLICITACAO_ADI Cloud->Local: ' + E.Message);
            end);

          vQueryUpdateCloud.Transaction.RollbackRetaining;
          vQueryLocal.Transaction.RollbackRetaining;

          ALocalDatabase.Connected := False;
          ALocalDatabase.Connected := True;

          ACloudDatabase.Connected := False;
          ACloudDatabase.Connected := True;

          Break;
        end;
      end;

      vQueryCloud.Next;
    end;
  finally
    vQueryLocal.Free;
    vQueryCloud.Free;
    vQueryUpdateCloud.Free;
  end;
end;

procedure TForm_PrincipalServer.pAtualizaLicitacaoAdiLocalToCloud(
  ALocalDatabase, ACloudDatabase: TIBDatabase; ALocalTransaction,
  ACloudTransaction: TIBTransaction; prLicitacaoID : String);
var
  vQueryLocal, vQueryCloud, vQueryUpdateLocal: TIBQuery;
  vlData: TDateTime;
  vMsgErro : string;
begin
  vQueryLocal := TIBQuery.Create(self);
  vQueryCloud := TIBQuery.Create(self);
  vQueryUpdateLocal := TIBQuery.Create(self);

  try
    vQueryLocal.Database := ALocalDatabase;
    vQueryLocal.Transaction := ALocalTransaction;

    vQueryCloud.Database := ACloudDatabase;
    vQueryCloud.Transaction := ACloudTransaction;

    vQueryUpdateLocal.Database := ALocalDatabase;
    vQueryUpdateLocal.Transaction := ALocalTransaction;

    vQueryLocal.Close;
    vQueryLocal.SQL.Text := 'SELECT * FROM TBLICITACAO_ADI WHERE 1=1';

    if Trim(prLicitacaoID) = '' then
      vQueryLocal.SQL.Add(' AND SYNC = ''N'' ')
    else
      vQueryLocal.SQL.Add(' AND LICITACAO_ID = ''' + Trim(prLicitacaoID) + ''' ');

    vQueryLocal.Open;
    vQueryLocal.First;
    while not vQueryLocal.Eof do
    begin
      try
        vlData := Now;
        vQueryCloud.Close;
        vQueryCloud.SQL.Clear;
        vQueryCloud.SQL.Add('UPDATE OR INSERT INTO TBLICITACAO_ADI');
        vQueryCloud.SQL.Add('(LICITACAOADI_ID, LICITACAO_ID, LICITACAOADESAO_ID, PRODUTO_ID, PRODUTO, ATENDIDO, PEDIDO, NF, NF_SERIE,');
        vQueryCloud.SQL.Add('DATA_INC, USUARIO_I, USUARIONOME_I, DATA_ALT, USUARIO_A, USUARIONOME_A, DATA_DEL, USUARIO_D, USUARIONOME_D,');
        vQueryCloud.SQL.Add('DELETADO, EMPENHO, SYNC, SYNC_DATA)');
        vQueryCloud.SQL.Add('VALUES');
        vQueryCloud.SQL.Add('(:LICITACAOADI_ID, :LICITACAO_ID, :LICITACAOADESAO_ID, :PRODUTO_ID, :PRODUTO, :ATENDIDO, :PEDIDO, :NF, :NF_SERIE,');
        vQueryCloud.SQL.Add(':DATA_INC, :USUARIO_I, :USUARIONOME_I, :DATA_ALT, :USUARIO_A, :USUARIONOME_A, :DATA_DEL, :USUARIO_D, :USUARIONOME_D,');
        vQueryCloud.SQL.Add(':DELETADO, :EMPENHO, :SYNC, :SYNC_DATA)');
        vQueryCloud.SQL.Add('MATCHING (LICITACAOADI_ID)');

        // Parametros
        vQueryCloud.ParamByName('LICITACAOADI_ID').AsString := vQueryLocal.FieldByName('LICITACAOADI_ID').AsString;
        if not vQueryLocal.FieldByName('LICITACAO_ID').IsNull then
          vQueryCloud.ParamByName('LICITACAO_ID').AsString := vQueryLocal.FieldByName('LICITACAO_ID').AsString;
        if not vQueryLocal.FieldByName('LICITACAOADESAO_ID').IsNull then
          vQueryCloud.ParamByName('LICITACAOADESAO_ID').AsString := vQueryLocal.FieldByName('LICITACAOADESAO_ID').AsString;
        if not vQueryLocal.FieldByName('PRODUTO_ID').IsNull then
          vQueryCloud.ParamByName('PRODUTO_ID').AsString := vQueryLocal.FieldByName('PRODUTO_ID').AsString;
        if not vQueryLocal.FieldByName('PRODUTO').IsNull then
          vQueryCloud.ParamByName('PRODUTO').AsString := vQueryLocal.FieldByName('PRODUTO').AsString;
        if not vQueryLocal.FieldByName('ATENDIDO').IsNull then
          vQueryCloud.ParamByName('ATENDIDO').AsFloat := vQueryLocal.FieldByName('ATENDIDO').AsFloat;
        if not vQueryLocal.FieldByName('PEDIDO').IsNull then
          vQueryCloud.ParamByName('PEDIDO').AsString := vQueryLocal.FieldByName('PEDIDO').AsString;
        if not vQueryLocal.FieldByName('NF').IsNull then
          vQueryCloud.ParamByName('NF').AsString := vQueryLocal.FieldByName('NF').AsString;
        if not vQueryLocal.FieldByName('NF_SERIE').IsNull then
          vQueryCloud.ParamByName('NF_SERIE').AsString := vQueryLocal.FieldByName('NF_SERIE').AsString;
        if not vQueryLocal.FieldByName('DATA_INC').IsNull then
          vQueryCloud.ParamByName('DATA_INC').AsDateTime := vQueryLocal.FieldByName('DATA_INC').AsDateTime;
        if not vQueryLocal.FieldByName('USUARIO_I').IsNull then
          vQueryCloud.ParamByName('USUARIO_I').AsString := vQueryLocal.FieldByName('USUARIO_I').AsString;
        if not vQueryLocal.FieldByName('USUARIONOME_I').IsNull then
          vQueryCloud.ParamByName('USUARIONOME_I').AsString := vQueryLocal.FieldByName('USUARIONOME_I').AsString;
        if not vQueryLocal.FieldByName('DATA_ALT').IsNull then
          vQueryCloud.ParamByName('DATA_ALT').AsDateTime := vQueryLocal.FieldByName('DATA_ALT').AsDateTime;
        if not vQueryLocal.FieldByName('USUARIO_A').IsNull then
          vQueryCloud.ParamByName('USUARIO_A').AsString := vQueryLocal.FieldByName('USUARIO_A').AsString;
        if not vQueryLocal.FieldByName('USUARIONOME_A').IsNull then
          vQueryCloud.ParamByName('USUARIONOME_A').AsString := vQueryLocal.FieldByName('USUARIONOME_A').AsString;
        if not vQueryLocal.FieldByName('DATA_DEL').IsNull then
          vQueryCloud.ParamByName('DATA_DEL').AsDateTime := vQueryLocal.FieldByName('DATA_DEL').AsDateTime;
        if not vQueryLocal.FieldByName('USUARIO_D').IsNull then
          vQueryCloud.ParamByName('USUARIO_D').AsString := vQueryLocal.FieldByName('USUARIO_D').AsString;
        if not vQueryLocal.FieldByName('USUARIONOME_D').IsNull then
          vQueryCloud.ParamByName('USUARIONOME_D').AsString := vQueryLocal.FieldByName('USUARIONOME_D').AsString;
        if not vQueryLocal.FieldByName('DELETADO').IsNull then
          vQueryCloud.ParamByName('DELETADO').AsString := vQueryLocal.FieldByName('DELETADO').AsString;
        if not vQueryLocal.FieldByName('EMPENHO').IsNull then
          vQueryCloud.ParamByName('EMPENHO').AsFloat := vQueryLocal.FieldByName('EMPENHO').AsFloat;

        vQueryCloud.ParamByName('SYNC').AsString        := 'N';
        vQueryCloud.ParamByName('SYNC_DATA').AsDateTime := vlData;

        vQueryCloud.ExecSQL;
        vQueryCloud.Transaction.CommitRetaining;

        vQueryUpdateLocal.Close;
        vQueryUpdateLocal.SQL.Clear;
        vQueryUpdateLocal.SQL.Add('UPDATE TBLICITACAO_ADI SET SYNC = ''S'', SYNC_DATA = :SYNC_DATA WHERE LICITACAOADI_ID = :LICITACAOADI_ID');

        vQueryUpdateLocal.ParamByName('SYNC_DATA').AsDateTime := vlData;
        vQueryUpdateLocal.ParamByName('LICITACAOADI_ID').AsString := vQueryLocal.FieldByName('LICITACAOADI_ID').AsString;

        vQueryUpdateLocal.ExecSQL;
        vQueryUpdateLocal.Transaction.CommitRetaining;

        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-TBLICITACAO_ADI Local->Cloud atualizada: ' +
                               Trim(vQueryLocal.FieldByName('LICITACAOADI_ID').AsString));
          end);

      except on E: Exception do
        begin
          TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              vMsgErro := FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-Erro ao atualizar TBLICITACAO_ADI [' + vQueryLocal.FieldByName('LICITACAOADI_ID').AsString + '] Local->Cloud: ' + E.Message;
              logErros(vMsgErro);
              Memo_Log.Lines.Add(vMsgErro);
            end);

          vQueryUpdateLocal.Transaction.RollbackRetaining;
          vQueryCloud.Transaction.RollbackRetaining;

          ALocalDatabase.Connected := False;
          ALocalDatabase.Connected := True;

          ACloudDatabase.Connected := False;
          ACloudDatabase.Connected := True;

          Break;
        end;
      end;

      vQueryLocal.Next;
    end;
  finally
    vQueryLocal.Free;
    vQueryCloud.Free;
    vQueryUpdateLocal.Free;
  end;
end;

procedure TForm_PrincipalServer.pAtualizaLicitacaoCloudToLocal(ALocalDatabase,
  ACloudDatabase: TIBDatabase; ALocalTransaction,
  ACloudTransaction: TIBTransaction; prLicitacaoID : String);
var
  vQueryLocal, vQueryCloud, vQueryUpdateLocal, vQuerySync: TIBQuery;
  vlData: TDateTime;
  vCampo, vValor, vOperador, vFiltro: string;
begin
  vQueryLocal := TIBQuery.Create(self);
  vQueryCloud := TIBQuery.Create(self);
  vQueryUpdateLocal := TIBQuery.Create(self);
  vQuerySync := TIBQuery.Create(self);

  try
    vQuerySync.Database := ACloudDatabase;
    vQuerySync.Transaction := ACloudTransaction;

    // Consulta para obter configurações da TBSYNC
    vQuerySync.Close;
    vQuerySync.SQL.Text := 'SELECT * FROM TBSYNC WHERE TABELA = :Tabela';
    vQuerySync.ParamByName('Tabela').AsString := 'TBLICITACAO';
    vQuerySync.Open;

    // Construir cláusula WHERE dinamicamente
    if not vQuerySync.IsEmpty then
    begin
      vQueryLocal.Database := ALocalDatabase;
      vQueryLocal.Transaction := ALocalTransaction;

      vQueryCloud.Database := ACloudDatabase;
      vQueryCloud.Transaction := ACloudTransaction;

      vQueryUpdateLocal.Database := ALocalDatabase;
      vQueryUpdateLocal.Transaction := ALocalTransaction;

      // Adiciona filtros baseados em TBSYNC
      vQueryCloud.Close;
      vQueryCloud.SQL.Text := 'SELECT * FROM TBLICITACAO WHERE SYNC = ''N'' ';

      vQuerySync.First;
      while not vQuerySync.Eof do
      begin
        vCampo    := vQuerySync.FieldByName('CAMPO').AsString;
        vValor    := vQuerySync.FieldByName('VALOR').AsString;
        vOperador := vQuerySync.FieldByName('OPERADOR').AsString;

        if vOperador = 'IN' then
          vFiltro := Format(' AND %s IN (%s)', [vCampo, vValor])
        else
          vFiltro := Format(' AND %s %s ''%s''', [vCampo, vOperador, vValor]);

        vQueryCloud.SQL.Add(vFiltro);

        vQuerySync.Next;
      end;

      vQueryCloud.Open;
      vQueryCloud.First;
      while not vQueryCloud.Eof do
      begin
        try
          vlData := Now;
          vQueryLocal.Close;
          vQueryLocal.SQL.Clear;
          vQueryLocal.SQL.Add('UPDATE OR INSERT INTO TBLICITACAO');
          vQueryLocal.SQL.Add('(LICITACAO_ID, PESSOA_ID, DATA, PROCESSO, PROCESSO_ANO, PROCESSO_ADMIN, PROCESSO_ADMIN_ANO, PORTARIA, PORTARIA_ANO,');
          vQueryLocal.SQL.Add('MODALIDADE_ID, MODALIDADE_NUMERO, MODALIDADE_ANO, OBJETO_ID, DATA_INC, DATA_ALT, DATA_DEL, USUARIO_I, USUARIO_A, USUARIO_D,');
          vQueryLocal.SQL.Add('HORA, PARTICIPA, MOTIVO, OBS, TIPO, DELETADO, GANHA, PESSOA_VR, VIGENCIA, ENTREGA, VALIDADE_COTACAO, CLIENTE_ID, VIGENCIA_DATA,');
          vQueryLocal.SQL.Add('HOMOLOGACAO, TIPO_ENTREGA, ORIGEM, GARANTIA_PRECO, SITE, ENTREGAS, USUARIONOME_I, USUARIONOME_A, USUARIONOME_D, LICITACAO_ORIGEM,');
          vQueryLocal.SQL.Add('VIGENCIA_INI, STATUS, OBS_INTERNO, OBS_CLIENTE, SYNC, SYNC_DATA)');
          vQueryLocal.SQL.Add('VALUES');
          vQueryLocal.SQL.Add('(:LICITACAO_ID, :PESSOA_ID, :DATA, :PROCESSO, :PROCESSO_ANO, :PROCESSO_ADMIN, :PROCESSO_ADMIN_ANO, :PORTARIA, :PORTARIA_ANO,');
          vQueryLocal.SQL.Add(':MODALIDADE_ID, :MODALIDADE_NUMERO, :MODALIDADE_ANO, :OBJETO_ID, :DATA_INC, :DATA_ALT, :DATA_DEL, :USUARIO_I, :USUARIO_A, :USUARIO_D,');
          vQueryLocal.SQL.Add(':HORA, :PARTICIPA, :MOTIVO, :OBS, :TIPO, :DELETADO, :GANHA, :PESSOA_VR, :VIGENCIA, :ENTREGA, :VALIDADE_COTACAO, :CLIENTE_ID, :VIGENCIA_DATA,');
          vQueryLocal.SQL.Add(':HOMOLOGACAO, :TIPO_ENTREGA, :ORIGEM, :GARANTIA_PRECO, :SITE, :ENTREGAS, :USUARIONOME_I, :USUARIONOME_A, :USUARIONOME_D, :LICITACAO_ORIGEM,');
          vQueryLocal.SQL.Add(':VIGENCIA_INI, :STATUS, :OBS_INTERNO, :OBS_CLIENTE, :SYNC, :SYNC_DATA)');
          vQueryLocal.SQL.Add('MATCHING (LICITACAO_ID)');

          // Parametros
          vQueryLocal.ParamByName('LICITACAO_ID').AsInteger := vQueryCloud.FieldByName('LICITACAO_ID').AsInteger;

          if not vQueryCloud.FieldByName('PESSOA_ID').IsNull then
          begin
            pImportaPessoa(vQueryCloud.FieldByName('PESSOA_ID').AsString);
            vQueryLocal.ParamByName('PESSOA_ID').AsInteger := vQueryCloud.FieldByName('PESSOA_ID').AsInteger;
          end;

          if not vQueryCloud.FieldByName('CLIENTE_ID').IsNull then
          begin
            pImportaPessoa(vQueryCloud.FieldByName('CLIENTE_ID').AsString);
            vQueryLocal.ParamByName('CLIENTE_ID').AsInteger := vQueryCloud.FieldByName('CLIENTE_ID').AsInteger;
          end;

          if not vQueryCloud.FieldByName('PESSOA_VR').IsNull then
          begin
            pImportaPessoa(vQueryCloud.FieldByName('PESSOA_VR').AsString);
            vQueryLocal.ParamByName('PESSOA_VR').AsInteger := vQueryCloud.FieldByName('PESSOA_VR').AsInteger;
          end;

          if not vQueryCloud.FieldByName('DATA').IsNull then
            vQueryLocal.ParamByName('DATA').AsDateTime := vQueryCloud.FieldByName('DATA').AsDateTime;
          if not vQueryCloud.FieldByName('PROCESSO').IsNull then
            vQueryLocal.ParamByName('PROCESSO').AsString := vQueryCloud.FieldByName('PROCESSO').AsString;
          if not vQueryCloud.FieldByName('PROCESSO_ANO').IsNull then
            vQueryLocal.ParamByName('PROCESSO_ANO').AsString := vQueryCloud.FieldByName('PROCESSO_ANO').AsString;
          if not vQueryCloud.FieldByName('PROCESSO_ADMIN').IsNull then
            vQueryLocal.ParamByName('PROCESSO_ADMIN').AsString := vQueryCloud.FieldByName('PROCESSO_ADMIN').AsString;
          if not vQueryCloud.FieldByName('PROCESSO_ADMIN_ANO').IsNull then
            vQueryLocal.ParamByName('PROCESSO_ADMIN_ANO').AsString := vQueryCloud.FieldByName('PROCESSO_ADMIN_ANO').AsString;
          if not vQueryCloud.FieldByName('PORTARIA').IsNull then
            vQueryLocal.ParamByName('PORTARIA').AsString := vQueryCloud.FieldByName('PORTARIA').AsString;
          if not vQueryCloud.FieldByName('PORTARIA_ANO').IsNull then
            vQueryLocal.ParamByName('PORTARIA_ANO').AsString := vQueryCloud.FieldByName('PORTARIA_ANO').AsString;
          if not vQueryCloud.FieldByName('MODALIDADE_ID').IsNull then
            vQueryLocal.ParamByName('MODALIDADE_ID').AsInteger := vQueryCloud.FieldByName('MODALIDADE_ID').AsInteger;
          if not vQueryCloud.FieldByName('MODALIDADE_NUMERO').IsNull then
            vQueryLocal.ParamByName('MODALIDADE_NUMERO').AsString := vQueryCloud.FieldByName('MODALIDADE_NUMERO').AsString;
          if not vQueryCloud.FieldByName('MODALIDADE_ANO').IsNull then
            vQueryLocal.ParamByName('MODALIDADE_ANO').AsString := vQueryCloud.FieldByName('MODALIDADE_ANO').AsString;
          if not vQueryCloud.FieldByName('OBJETO_ID').IsNull then
            vQueryLocal.ParamByName('OBJETO_ID').AsInteger := vQueryCloud.FieldByName('OBJETO_ID').AsInteger;
          if not vQueryCloud.FieldByName('DATA_INC').IsNull then
            vQueryLocal.ParamByName('DATA_INC').AsDateTime := vQueryCloud.FieldByName('DATA_INC').AsDateTime;
          if not vQueryCloud.FieldByName('DATA_ALT').IsNull then
            vQueryLocal.ParamByName('DATA_ALT').AsDateTime := vQueryCloud.FieldByName('DATA_ALT').AsDateTime;
          if not vQueryCloud.FieldByName('DATA_DEL').IsNull then
            vQueryLocal.ParamByName('DATA_DEL').AsDateTime := vQueryCloud.FieldByName('DATA_DEL').AsDateTime;
          if not vQueryCloud.FieldByName('USUARIO_I').IsNull then
            vQueryLocal.ParamByName('USUARIO_I').AsInteger := vQueryCloud.FieldByName('USUARIO_I').AsInteger;
          if not vQueryCloud.FieldByName('USUARIO_A').IsNull then
            vQueryLocal.ParamByName('USUARIO_A').AsInteger := vQueryCloud.FieldByName('USUARIO_A').AsInteger;
          if not vQueryCloud.FieldByName('USUARIO_D').IsNull then
            vQueryLocal.ParamByName('USUARIO_D').AsInteger := vQueryCloud.FieldByName('USUARIO_D').AsInteger;
          if not vQueryCloud.FieldByName('HORA').IsNull then
            vQueryLocal.ParamByName('HORA').AsDateTime := vQueryCloud.FieldByName('HORA').AsDateTime;
          if not vQueryCloud.FieldByName('PARTICIPA').IsNull then
            vQueryLocal.ParamByName('PARTICIPA').AsString := vQueryCloud.FieldByName('PARTICIPA').AsString;
          if not vQueryCloud.FieldByName('MOTIVO').IsNull then
            vQueryLocal.ParamByName('MOTIVO').AsString := vQueryCloud.FieldByName('MOTIVO').AsString;
          if not vQueryCloud.FieldByName('OBS').IsNull then
            vQueryLocal.ParamByName('OBS').Assign(vQueryCloud.FieldByName('OBS'));
          if not vQueryCloud.FieldByName('TIPO').IsNull then
            vQueryLocal.ParamByName('TIPO').AsString := vQueryCloud.FieldByName('TIPO').AsString;
          if not vQueryCloud.FieldByName('DELETADO').IsNull then
            vQueryLocal.ParamByName('DELETADO').AsString := vQueryCloud.FieldByName('DELETADO').AsString;
          if not vQueryCloud.FieldByName('GANHA').IsNull then
            vQueryLocal.ParamByName('GANHA').AsString := vQueryCloud.FieldByName('GANHA').AsString;
          if not vQueryCloud.FieldByName('PESSOA_VR').IsNull then
            vQueryLocal.ParamByName('PESSOA_VR').AsInteger := vQueryCloud.FieldByName('PESSOA_VR').AsInteger;
          if not vQueryCloud.FieldByName('VIGENCIA').IsNull then
            vQueryLocal.ParamByName('VIGENCIA').AsFloat := vQueryCloud.FieldByName('VIGENCIA').AsFloat;
          if not vQueryCloud.FieldByName('ENTREGA').IsNull then
            vQueryLocal.ParamByName('ENTREGA').AsFloat := vQueryCloud.FieldByName('ENTREGA').AsFloat;
          if not vQueryCloud.FieldByName('VALIDADE_COTACAO').IsNull then
            vQueryLocal.ParamByName('VALIDADE_COTACAO').AsDateTime := vQueryCloud.FieldByName('VALIDADE_COTACAO').AsDateTime;
          if not vQueryCloud.FieldByName('CLIENTE_ID').IsNull then
            vQueryLocal.ParamByName('CLIENTE_ID').AsInteger := vQueryCloud.FieldByName('CLIENTE_ID').AsInteger;
          if not vQueryCloud.FieldByName('VIGENCIA_DATA').IsNull then
            vQueryLocal.ParamByName('VIGENCIA_DATA').AsDateTime := vQueryCloud.FieldByName('VIGENCIA_DATA').AsDateTime;
          if not vQueryCloud.FieldByName('HOMOLOGACAO').IsNull then
            vQueryLocal.ParamByName('HOMOLOGACAO').AsDateTime := vQueryCloud.FieldByName('HOMOLOGACAO').AsDateTime;
          if not vQueryCloud.FieldByName('TIPO_ENTREGA').IsNull then
            vQueryLocal.ParamByName('TIPO_ENTREGA').AsString := vQueryCloud.FieldByName('TIPO_ENTREGA').AsString;
          if not vQueryCloud.FieldByName('ORIGEM').IsNull then
            vQueryLocal.ParamByName('ORIGEM').AsString := vQueryCloud.FieldByName('ORIGEM').AsString;
          if not vQueryCloud.FieldByName('GARANTIA_PRECO').IsNull then
            vQueryLocal.ParamByName('GARANTIA_PRECO').AsDateTime := vQueryCloud.FieldByName('GARANTIA_PRECO').AsDateTime;
          if not vQueryCloud.FieldByName('SITE').IsNull then
            vQueryLocal.ParamByName('SITE').AsString := vQueryCloud.FieldByName('SITE').AsString;
          if not vQueryCloud.FieldByName('ENTREGAS').IsNull then
            vQueryLocal.ParamByName('ENTREGAS').AsInteger := vQueryCloud.FieldByName('ENTREGAS').AsInteger;
          if not vQueryCloud.FieldByName('USUARIONOME_I').IsNull then
            vQueryLocal.ParamByName('USUARIONOME_I').AsString := vQueryCloud.FieldByName('USUARIONOME_I').AsString;
          if not vQueryCloud.FieldByName('USUARIONOME_A').IsNull then
            vQueryLocal.ParamByName('USUARIONOME_A').AsString := vQueryCloud.FieldByName('USUARIONOME_A').AsString;
          if not vQueryCloud.FieldByName('USUARIONOME_D').IsNull then
            vQueryLocal.ParamByName('USUARIONOME_D').AsString := vQueryCloud.FieldByName('USUARIONOME_D').AsString;
          if not vQueryCloud.FieldByName('LICITACAO_ORIGEM').IsNull then
            vQueryLocal.ParamByName('LICITACAO_ORIGEM').AsInteger := vQueryCloud.FieldByName('LICITACAO_ORIGEM').AsInteger;
          if not vQueryCloud.FieldByName('VIGENCIA_INI').IsNull then
            vQueryLocal.ParamByName('VIGENCIA_INI').AsDateTime := vQueryCloud.FieldByName('VIGENCIA_INI').AsDateTime;
          if not vQueryCloud.FieldByName('STATUS').IsNull then
            vQueryLocal.ParamByName('STATUS').AsString := vQueryCloud.FieldByName('STATUS').AsString;
          if not vQueryCloud.FieldByName('OBS_INTERNO').IsNull then
            vQueryLocal.ParamByName('OBS_INTERNO').Assign(vQueryCloud.FieldByName('OBS_INTERNO'));
          if not vQueryCloud.FieldByName('OBS_CLIENTE').IsNull then
            vQueryLocal.ParamByName('OBS_CLIENTE').Assign(vQueryCloud.FieldByName('OBS_CLIENTE'));

          vQueryLocal.ParamByName('SYNC').AsString := 'S';
          vQueryLocal.ParamByName('SYNC_DATA').AsDateTime := vlData;

          vQueryLocal.ExecSQL;
          vQueryLocal.Transaction.CommitRetaining;

          vQueryUpdateLocal.Close;
          vQueryUpdateLocal.SQL.Clear;
          vQueryUpdateLocal.SQL.Add('UPDATE TBLICITACAO SET SYNC = ''S'', SYNC_DATA = :SYNC_DATA WHERE LICITACAO_ID = :LICITACAO_ID');

          vQueryUpdateLocal.ParamByName('SYNC_DATA').AsDateTime := vlData;
          vQueryUpdateLocal.ParamByName('LICITACAO_ID').AsInteger := vQueryCloud.FieldByName('LICITACAO_ID').AsInteger;

          vQueryUpdateLocal.ExecSQL;
          vQueryUpdateLocal.Transaction.CommitRetaining;

          TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-TBLICITACAO Cloud->Local atualizada: ' +
                                 Trim(vQueryCloud.FieldByName('LICITACAO_ID').AsString));
            end);

          pAtualizaLicitacaoItemCloudToLocal(dm1.IBDatabase1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransaction1, dm1.IBTransactionCloudSICFAR,    vQueryCloud.FieldByName('LICITACAO_ID').AsString);
          pAtualizaLicitacaoAdiCloudToLocal(dm1.IBDatabase1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransaction1, dm1.IBTransactionCloudSICFAR,     vQueryCloud.FieldByName('LICITACAO_ID').AsString);
          pAtualizaLicitacaoEntregaCloudToLocal(dm1.IBDatabase1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransaction1, dm1.IBTransactionCloudSICFAR, vQueryCloud.FieldByName('LICITACAO_ID').AsString);
          pAtualizaLicitacaoOrgaoCloudToLocal(dm1.IBDatabase1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransaction1, dm1.IBTransactionCloudSICFAR,   vQueryCloud.FieldByName('LICITACAO_ID').AsString);
        except on E: Exception do
          begin
            TThread.Synchronize(TThread.CurrentThread,
              procedure
              begin
                Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-Erro ao atualizar TBLICITACAO Cloud->Local: ' + E.Message);
              end);

            vQueryUpdateLocal.Transaction.RollbackRetaining;
            vQueryCloud.Transaction.RollbackRetaining;

            ALocalDatabase.Connected := False;
            ALocalDatabase.Connected := True;

            ACloudDatabase.Connected := False;
            ACloudDatabase.Connected := True;

            Break;  // Sai do loop while
          end;
        end;

        vQueryCloud.Next;
      end;
    end;
  finally
    vQueryLocal.Free;
    vQueryCloud.Free;
    vQueryUpdateLocal.Free;
    vQuerySync.Free;
  end;
end;

procedure TForm_PrincipalServer.pAtualizaLicitacaoEntregaCloudToLocal(
  ALocalDatabase, ACloudDatabase: TIBDatabase; ALocalTransaction,
  ACloudTransaction: TIBTransaction; prLicitacaoID : String);
var
  vQueryLocal, vQueryCloud, vQueryUpdateCloud: TIBQuery;
  vlData: TDateTime;
begin
  vQueryLocal := TIBQuery.Create(self);
  vQueryCloud := TIBQuery.Create(self);
  vQueryUpdateCloud := TIBQuery.Create(self);

  try
    vQueryLocal.Database := ALocalDatabase;
    vQueryLocal.Transaction := ALocalTransaction;

    vQueryCloud.Database := ACloudDatabase;
    vQueryCloud.Transaction := ACloudTransaction;

    vQueryUpdateCloud.Database := ACloudDatabase;
    vQueryUpdateCloud.Transaction := ACloudTransaction;

    vQueryCloud.Close;
    vQueryCloud.SQL.Text := 'SELECT * FROM TBLICITACAO_ENTREGA WHERE 1=1';

    if Trim(prLicitacaoID) = '' then
      vQueryCloud.SQL.Add(' AND SYNC = ''N'' ')
    else
      vQueryCloud.SQL.Add(' AND LICITACAO_ID = ''' + Trim(prLicitacaoID) + ''' ');

    vQueryCloud.Open;
    vQueryCloud.First;
    while not vQueryCloud.Eof do
    begin
      try
        vlData := Now;
        vQueryLocal.Close;
        vQueryLocal.SQL.Clear;
        vQueryLocal.SQL.Add('UPDATE OR INSERT INTO TBLICITACAO_ENTREGA');
        vQueryLocal.SQL.Add('(LICITACAOENTREGA_ID, LICITACAO_ID, CONTATO, ENDERECO, COMPLEMENTO, BAIRRO, CIDADE, UF, CEP, CNPJ,');
        vQueryLocal.SQL.Add('DATA_INC, USUARIO_I, USUARIONOME_I, DATA_ALT, USUARIO_A, USUARIONOME_A, DATA_DEL, USUARIO_D, USUARIONOME_D,');
        vQueryLocal.SQL.Add('DELETADO, SYNC, SYNC_DATA)');
        vQueryLocal.SQL.Add('VALUES');
        vQueryLocal.SQL.Add('(:LICITACAOENTREGA_ID, :LICITACAO_ID, :CONTATO, :ENDERECO, :COMPLEMENTO, :BAIRRO, :CIDADE, :UF, :CEP, :CNPJ,');
        vQueryLocal.SQL.Add(':DATA_INC, :USUARIO_I, :USUARIONOME_I, :DATA_ALT, :USUARIO_A, :USUARIONOME_A, :DATA_DEL, :USUARIO_D, :USUARIONOME_D,');
        vQueryLocal.SQL.Add(':DELETADO, :SYNC, :SYNC_DATA)');
        vQueryLocal.SQL.Add('MATCHING (LICITACAOENTREGA_ID)');

        // Parametros
        vQueryLocal.ParamByName('LICITACAOENTREGA_ID').AsString := vQueryCloud.FieldByName('LICITACAOENTREGA_ID').AsString;
        if not vQueryCloud.FieldByName('LICITACAO_ID').IsNull then
          vQueryLocal.ParamByName('LICITACAO_ID').AsString := vQueryCloud.FieldByName('LICITACAO_ID').AsString;
        if not vQueryCloud.FieldByName('CONTATO').IsNull then
          vQueryLocal.ParamByName('CONTATO').AsString := vQueryCloud.FieldByName('CONTATO').AsString;
        if not vQueryCloud.FieldByName('ENDERECO').IsNull then
          vQueryLocal.ParamByName('ENDERECO').AsString := vQueryCloud.FieldByName('ENDERECO').AsString;
        if not vQueryCloud.FieldByName('COMPLEMENTO').IsNull then
          vQueryLocal.ParamByName('COMPLEMENTO').AsString := vQueryCloud.FieldByName('COMPLEMENTO').AsString;
        if not vQueryCloud.FieldByName('BAIRRO').IsNull then
          vQueryLocal.ParamByName('BAIRRO').AsString := vQueryCloud.FieldByName('BAIRRO').AsString;
        if not vQueryCloud.FieldByName('CIDADE').IsNull then
          vQueryLocal.ParamByName('CIDADE').AsString := vQueryCloud.FieldByName('CIDADE').AsString;
        if not vQueryCloud.FieldByName('UF').IsNull then
          vQueryLocal.ParamByName('UF').AsString := vQueryCloud.FieldByName('UF').AsString;
        if not vQueryCloud.FieldByName('CEP').IsNull then
          vQueryLocal.ParamByName('CEP').AsString := vQueryCloud.FieldByName('CEP').AsString;
        if not vQueryCloud.FieldByName('CNPJ').IsNull then
          vQueryLocal.ParamByName('CNPJ').AsString := vQueryCloud.FieldByName('CNPJ').AsString;
        if not vQueryCloud.FieldByName('DATA_INC').IsNull then
          vQueryLocal.ParamByName('DATA_INC').AsDateTime := vQueryCloud.FieldByName('DATA_INC').AsDateTime;
        if not vQueryCloud.FieldByName('USUARIO_I').IsNull then
          vQueryLocal.ParamByName('USUARIO_I').AsString := vQueryCloud.FieldByName('USUARIO_I').AsString;
        if not vQueryCloud.FieldByName('USUARIONOME_I').IsNull then
          vQueryLocal.ParamByName('USUARIONOME_I').AsString := vQueryCloud.FieldByName('USUARIONOME_I').AsString;
        if not vQueryCloud.FieldByName('DATA_ALT').IsNull then
          vQueryLocal.ParamByName('DATA_ALT').AsDateTime := vQueryCloud.FieldByName('DATA_ALT').AsDateTime;
        if not vQueryCloud.FieldByName('USUARIO_A').IsNull then
          vQueryLocal.ParamByName('USUARIO_A').AsString := vQueryCloud.FieldByName('USUARIO_A').AsString;
        if not vQueryCloud.FieldByName('USUARIONOME_A').IsNull then
          vQueryLocal.ParamByName('USUARIONOME_A').AsString := vQueryCloud.FieldByName('USUARIONOME_A').AsString;
        if not vQueryCloud.FieldByName('DATA_DEL').IsNull then
          vQueryLocal.ParamByName('DATA_DEL').AsDateTime := vQueryCloud.FieldByName('DATA_DEL').AsDateTime;
        if not vQueryCloud.FieldByName('USUARIO_D').IsNull then
          vQueryLocal.ParamByName('USUARIO_D').AsString := vQueryCloud.FieldByName('USUARIO_D').AsString;
        if not vQueryCloud.FieldByName('USUARIONOME_D').IsNull then
          vQueryLocal.ParamByName('USUARIONOME_D').AsString := vQueryCloud.FieldByName('USUARIONOME_D').AsString;
        if not vQueryCloud.FieldByName('DELETADO').IsNull then
          vQueryLocal.ParamByName('DELETADO').AsString := vQueryCloud.FieldByName('DELETADO').AsString;
        vQueryLocal.ParamByName('SYNC').AsString := 'S';
        vQueryLocal.ParamByName('SYNC_DATA').AsDateTime := vlData;

        vQueryLocal.ExecSQL;
        vQueryLocal.Transaction.CommitRetaining;

        vQueryUpdateCloud.Close;
        vQueryUpdateCloud.SQL.Clear;
        vQueryUpdateCloud.SQL.Add('UPDATE TBLICITACAO_ENTREGA SET SYNC = ''S'', SYNC_DATA = :SYNC_DATA WHERE LICITACAOENTREGA_ID = :LICITACAOENTREGA_ID');

        vQueryUpdateCloud.ParamByName('SYNC_DATA').AsDateTime := vlData;
        vQueryUpdateCloud.ParamByName('LICITACAOENTREGA_ID').AsString := vQueryCloud.FieldByName('LICITACAOENTREGA_ID').AsString;

        vQueryUpdateCloud.ExecSQL;
        vQueryUpdateCloud.Transaction.CommitRetaining;

        Memo_Log.Lines.Add('Item atualizado em ' + FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ': ' +
                           Trim(vQueryCloud.FieldByName('LICITACAOENTREGA_ID').AsString) + ' - ' + Trim(vQueryCloud.FieldByName('CONTATO').AsString));
      except
        on E: Exception do
        begin
          Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ' - Erro ao atualizar Item: ' + E.Message);
          vQueryUpdateCloud.Transaction.RollbackRetaining;
          vQueryLocal.Transaction.RollbackRetaining;

          ALocalDatabase.Connected := False;
          ALocalDatabase.Connected := True;

          ACloudDatabase.Connected := False;
          ACloudDatabase.Connected := True;

          Break;
        end;
      end;

      vQueryCloud.Next;
      Application.ProcessMessages;
    end;
  finally
    vQueryLocal.Free;
    vQueryCloud.Free;
    vQueryUpdateCloud.Free;
  end;
end;

procedure TForm_PrincipalServer.pAtualizaLicitacaoEntregaLocalToCloud(
  ALocalDatabase, ACloudDatabase: TIBDatabase; ALocalTransaction,
  ACloudTransaction: TIBTransaction; prLicitacaoID : String);
var
  vQueryLocal, vQueryCloud, vQueryUpdateLocal: TIBQuery;
  vlData   : TDateTime;
  vMsgErro : string;
begin
  vQueryLocal := TIBQuery.Create(self);
  vQueryCloud := TIBQuery.Create(self);
  vQueryUpdateLocal := TIBQuery.Create(self);

  try
    vQueryLocal.Database := ALocalDatabase;
    vQueryLocal.Transaction := ALocalTransaction;

    vQueryCloud.Database := ACloudDatabase;
    vQueryCloud.Transaction := ACloudTransaction;

    vQueryUpdateLocal.Database := ALocalDatabase;
    vQueryUpdateLocal.Transaction := ALocalTransaction;

    vQueryLocal.Close;
    vQueryLocal.SQL.Text := 'SELECT * FROM TBLICITACAO_ENTREGA WHERE 1=1';

    if Trim(prLicitacaoID) = '' then
      vQueryLocal.SQL.Add(' AND SYNC = ''N'' ')
    else
      vQueryLocal.SQL.Add(' AND LICITACAO_ID = ''' + Trim(prLicitacaoID) + ''' ');

    vQueryLocal.Open;
    vQueryLocal.First;
    while not vQueryLocal.Eof do
    begin
      try
        vlData := Now;
        vQueryCloud.Close;
        vQueryCloud.SQL.Clear;
        vQueryCloud.SQL.Add('UPDATE OR INSERT INTO TBLICITACAO_ENTREGA');
        vQueryCloud.SQL.Add('(LICITACAOENTREGA_ID, LICITACAO_ID, CONTATO, ENDERECO, COMPLEMENTO, BAIRRO, CIDADE, UF, CEP, CNPJ,');
        vQueryCloud.SQL.Add('DATA_INC, USUARIO_I, USUARIONOME_I, DATA_ALT, USUARIO_A, USUARIONOME_A, DATA_DEL, USUARIO_D, USUARIONOME_D,');
        vQueryCloud.SQL.Add('DELETADO, SYNC, SYNC_DATA)');
        vQueryCloud.SQL.Add('VALUES');
        vQueryCloud.SQL.Add('(:LICITACAOENTREGA_ID, :LICITACAO_ID, :CONTATO, :ENDERECO, :COMPLEMENTO, :BAIRRO, :CIDADE, :UF, :CEP, :CNPJ,');
        vQueryCloud.SQL.Add(':DATA_INC, :USUARIO_I, :USUARIONOME_I, :DATA_ALT, :USUARIO_A, :USUARIONOME_A, :DATA_DEL, :USUARIO_D, :USUARIONOME_D,');
        vQueryCloud.SQL.Add(':DELETADO, :SYNC, :SYNC_DATA)');
        vQueryCloud.SQL.Add('MATCHING (LICITACAOENTREGA_ID)');

        // Parametros
        vQueryCloud.ParamByName('LICITACAOENTREGA_ID').AsString := vQueryLocal.FieldByName('LICITACAOENTREGA_ID').AsString;
        if not vQueryLocal.FieldByName('LICITACAO_ID').IsNull then
          vQueryCloud.ParamByName('LICITACAO_ID').AsString := vQueryLocal.FieldByName('LICITACAO_ID').AsString;
        if not vQueryLocal.FieldByName('CONTATO').IsNull then
          vQueryCloud.ParamByName('CONTATO').AsString := vQueryLocal.FieldByName('CONTATO').AsString;
        if not vQueryLocal.FieldByName('ENDERECO').IsNull then
          vQueryCloud.ParamByName('ENDERECO').AsString := vQueryLocal.FieldByName('ENDERECO').AsString;
        if not vQueryLocal.FieldByName('COMPLEMENTO').IsNull then
          vQueryCloud.ParamByName('COMPLEMENTO').AsString := vQueryLocal.FieldByName('COMPLEMENTO').AsString;
        if not vQueryLocal.FieldByName('BAIRRO').IsNull then
          vQueryCloud.ParamByName('BAIRRO').AsString := vQueryLocal.FieldByName('BAIRRO').AsString;
        if not vQueryLocal.FieldByName('CIDADE').IsNull then
          vQueryCloud.ParamByName('CIDADE').AsString := vQueryLocal.FieldByName('CIDADE').AsString;
        if not vQueryLocal.FieldByName('UF').IsNull then
          vQueryCloud.ParamByName('UF').AsString := vQueryLocal.FieldByName('UF').AsString;
        if not vQueryLocal.FieldByName('CEP').IsNull then
          vQueryCloud.ParamByName('CEP').AsString := vQueryLocal.FieldByName('CEP').AsString;
        if not vQueryLocal.FieldByName('CNPJ').IsNull then
          vQueryCloud.ParamByName('CNPJ').AsString := vQueryLocal.FieldByName('CNPJ').AsString;
        if not vQueryLocal.FieldByName('DATA_INC').IsNull then
          vQueryCloud.ParamByName('DATA_INC').AsDateTime := vQueryLocal.FieldByName('DATA_INC').AsDateTime;
        if not vQueryLocal.FieldByName('USUARIO_I').IsNull then
          vQueryCloud.ParamByName('USUARIO_I').AsString := vQueryLocal.FieldByName('USUARIO_I').AsString;
        if not vQueryLocal.FieldByName('USUARIONOME_I').IsNull then
           vQueryCloud.ParamByName('USUARIONOME_I').AsString := vQueryLocal.FieldByName('USUARIONOME_I').AsString;
        if not vQueryLocal.FieldByName('DATA_ALT').IsNull then
          vQueryCloud.ParamByName('DATA_ALT').AsDateTime := vQueryLocal.FieldByName('DATA_ALT').AsDateTime;
        if not vQueryLocal.FieldByName('USUARIO_A').IsNull then
          vQueryCloud.ParamByName('USUARIO_A').AsString := vQueryLocal.FieldByName('USUARIO_A').AsString;
        if not vQueryLocal.FieldByName('USUARIONOME_A').IsNull then
          vQueryCloud.ParamByName('USUARIONOME_A').AsString := vQueryLocal.FieldByName('USUARIONOME_A').AsString;
        if not vQueryLocal.FieldByName('DATA_DEL').IsNull then
          vQueryCloud.ParamByName('DATA_DEL').AsDateTime := vQueryLocal.FieldByName('DATA_DEL').AsDateTime;
        if not vQueryLocal.FieldByName('USUARIO_D').IsNull then
          vQueryCloud.ParamByName('USUARIO_D').AsString := vQueryLocal.FieldByName('USUARIO_D').AsString;
        if not vQueryLocal.FieldByName('USUARIONOME_D').IsNull then
          vQueryCloud.ParamByName('USUARIONOME_D').AsString := vQueryLocal.FieldByName('USUARIONOME_D').AsString;
        if not vQueryLocal.FieldByName('DELETADO').IsNull then
          vQueryCloud.ParamByName('DELETADO').AsString := vQueryLocal.FieldByName('DELETADO').AsString;

        vQueryCloud.ParamByName('SYNC').AsString        := 'N';
        vQueryCloud.ParamByName('SYNC_DATA').AsDateTime := vlData;

        vQueryCloud.ExecSQL;
        vQueryCloud.Transaction.CommitRetaining;

        vQueryUpdateLocal.Close;
        vQueryUpdateLocal.SQL.Clear;
        vQueryUpdateLocal.SQL.Add('UPDATE TBLICITACAO_ENTREGA SET SYNC = ''S'', SYNC_DATA = :SYNC_DATA WHERE LICITACAOENTREGA_ID = :LICITACAOENTREGA_ID');

        vQueryUpdateLocal.ParamByName('SYNC_DATA').AsDateTime := vlData;
        vQueryUpdateLocal.ParamByName('LICITACAOENTREGA_ID').AsString := vQueryLocal.FieldByName('LICITACAOENTREGA_ID').AsString;

        vQueryUpdateLocal.ExecSQL;
        vQueryUpdateLocal.Transaction.CommitRetaining;

        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-TBLICITACAO_ENTREGA Local->Cloud atualizada: ' +
                               Trim(vQueryLocal.FieldByName('LICITACAOENTREGA_ID').AsString));
          end);
      except on E: Exception do
        begin
          TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              vMsgErro := FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-Erro ao atualizar TBLICITACAO_ENTREGA [' + vQueryLocal.FieldByName('LICITACAOENTREGA_ID').AsString + '] Local->Cloud: ' + E.Message;
              logErros(vMsgErro);
              Memo_Log.Lines.Add(vMsgErro);
            end);

          vQueryUpdateLocal.Transaction.RollbackRetaining;
          vQueryCloud.Transaction.RollbackRetaining;

          ALocalDatabase.Connected := False;
          ALocalDatabase.Connected := True;

          ACloudDatabase.Connected := False;
          ACloudDatabase.Connected := True;

          Break;
        end;
      end;

      vQueryLocal.Next;
    end;
  finally
    vQueryLocal.Free;
    vQueryCloud.Free;
    vQueryUpdateLocal.Free;
  end;
end;

procedure TForm_PrincipalServer.pAtualizaLicitacaoItemCloudToLocal(
  ALocalDatabase, ACloudDatabase: TIBDatabase; ALocalTransaction,
  ACloudTransaction: TIBTransaction; prLicitacaoID : String);
var
  vQueryLocal, vQueryCloud, vQueryUpdateCloud: TIBQuery;
  vlData: TDateTime;
begin
  vQueryLocal := TIBQuery.Create(self);
  vQueryCloud := TIBQuery.Create(self);
  vQueryUpdateCloud := TIBQuery.Create(self);

  try
    vQueryLocal.Database := ALocalDatabase;
    vQueryLocal.Transaction := ALocalTransaction;

    vQueryCloud.Database := ACloudDatabase;
    vQueryCloud.Transaction := ACloudTransaction;

    vQueryUpdateCloud.Database := ACloudDatabase;
    vQueryUpdateCloud.Transaction := ACloudTransaction;

    vQueryCloud.Close;
    vQueryCloud.SQL.Text := 'SELECT * FROM TBLICITACAO_ITEM WHERE 1=1';

    if Trim(prLicitacaoID) = '' then
      vQueryCloud.SQL.Add(' AND SYNC = ''N'' ')
    else
      vQueryCloud.SQL.Add(' AND LICITACAO_ID = ''' + Trim(prLicitacaoID) + ''' ');

    vQueryCloud.Open;
    vQueryCloud.First;
    while not vQueryCloud.Eof do
    begin
      try
        vlData := Now;
        vQueryLocal.Close;
        vQueryLocal.SQL.Clear;
        vQueryLocal.SQL.Add('UPDATE OR INSERT INTO TBLICITACAO_ITEM');
        vQueryLocal.SQL.Add('(LITEM_ID, LICITACAO_ID, PRODUTO_ID, PRECO, QUANTIDADE, DATA_INC, DATA_ALT, DATA_DEL, USUARIO_I,');
        vQueryLocal.SQL.Add('USUARIONOME_I, USUARIO_A, USUARIO_D, DELETADO, PRECO_INICIAL, PRECO_FINAL, PDV, PRECO_GANHO,');
        vQueryLocal.SQL.Add('PARTICIPA, CONCORRENTE_ID, PRECO_CONCORRENTE, ITEM_EDITAL, STATUS, MARGEM, QTDE_PEDIDO, QTDE_NF,');
        vQueryLocal.SQL.Add('RESULTADO, MARCA, MOTIVOPERDA_ID, MOTIVOPERDA, PRECO_MAXIMO, SYNC, SYNC_DATA)');
        vQueryLocal.SQL.Add('VALUES');
        vQueryLocal.SQL.Add('(:LITEM_ID, :LICITACAO_ID, :PRODUTO_ID, :PRECO, :QUANTIDADE, :DATA_INC, :DATA_ALT, :DATA_DEL, :USUARIO_I,');
        vQueryLocal.SQL.Add(':USUARIONOME_I, :USUARIO_A, :USUARIO_D, :DELETADO, :PRECO_INICIAL, :PRECO_FINAL, :PDV, :PRECO_GANHO,');
        vQueryLocal.SQL.Add(':PARTICIPA, :CONCORRENTE_ID, :PRECO_CONCORRENTE, :ITEM_EDITAL, :STATUS, :MARGEM, :QTDE_PEDIDO, :QTDE_NF,');
        vQueryLocal.SQL.Add(':RESULTADO, :MARCA, :MOTIVOPERDA_ID, :MOTIVOPERDA, :PRECO_MAXIMO, :SYNC, :SYNC_DATA)');
        vQueryLocal.SQL.Add('MATCHING (LITEM_ID)');

        // Parametros
        vQueryLocal.ParamByName('LITEM_ID').AsInteger := vQueryCloud.FieldByName('LITEM_ID').AsInteger;
        if not vQueryCloud.FieldByName('LICITACAO_ID').IsNull then
          vQueryLocal.ParamByName('LICITACAO_ID').AsInteger := vQueryCloud.FieldByName('LICITACAO_ID').AsInteger;
        if not vQueryCloud.FieldByName('PRODUTO_ID').IsNull then
          vQueryLocal.ParamByName('PRODUTO_ID').AsInteger := vQueryCloud.FieldByName('PRODUTO_ID').AsInteger;
        if not vQueryCloud.FieldByName('PRECO').IsNull then
          vQueryLocal.ParamByName('PRECO').AsFloat := vQueryCloud.FieldByName('PRECO').AsFloat;
        if not vQueryCloud.FieldByName('QUANTIDADE').IsNull then
          vQueryLocal.ParamByName('QUANTIDADE').AsFloat := vQueryCloud.FieldByName('QUANTIDADE').AsFloat;
        if not vQueryCloud.FieldByName('DATA_INC').IsNull then
          vQueryLocal.ParamByName('DATA_INC').AsDateTime := vQueryCloud.FieldByName('DATA_INC').AsDateTime;
        if not vQueryCloud.FieldByName('DATA_ALT').IsNull then
          vQueryLocal.ParamByName('DATA_ALT').AsDateTime := vQueryCloud.FieldByName('DATA_ALT').AsDateTime;
        if not vQueryCloud.FieldByName('DATA_DEL').IsNull then
          vQueryLocal.ParamByName('DATA_DEL').AsDateTime := vQueryCloud.FieldByName('DATA_DEL').AsDateTime;
        if not vQueryCloud.FieldByName('USUARIO_I').IsNull then
          vQueryLocal.ParamByName('USUARIO_I').AsInteger := vQueryCloud.FieldByName('USUARIO_I').AsInteger;
        if not vQueryCloud.FieldByName('USUARIONOME_I').IsNull then
          vQueryLocal.ParamByName('USUARIONOME_I').AsString := vQueryCloud.FieldByName('USUARIONOME_I').AsString;
        if not vQueryCloud.FieldByName('USUARIO_A').IsNull then
          vQueryLocal.ParamByName('USUARIO_A').AsInteger := vQueryCloud.FieldByName('USUARIO_A').AsInteger;
        if not vQueryCloud.FieldByName('USUARIO_D').IsNull then
          vQueryLocal.ParamByName('USUARIO_D').AsInteger := vQueryCloud.FieldByName('USUARIO_D').AsInteger;
        if not vQueryCloud.FieldByName('DELETADO').IsNull then
          vQueryLocal.ParamByName('DELETADO').AsString := vQueryCloud.FieldByName('DELETADO').AsString;
        if not vQueryCloud.FieldByName('PRECO_INICIAL').IsNull then
          vQueryLocal.ParamByName('PRECO_INICIAL').AsFloat := vQueryCloud.FieldByName('PRECO_INICIAL').AsFloat;
        if not vQueryCloud.FieldByName('PRECO_FINAL').IsNull then
          vQueryLocal.ParamByName('PRECO_FINAL').AsFloat := vQueryCloud.FieldByName('PRECO_FINAL').AsFloat;
        if not vQueryCloud.FieldByName('PDV').IsNull then
          vQueryLocal.ParamByName('PDV').AsFloat := vQueryCloud.FieldByName('PDV').AsFloat;
        if not vQueryCloud.FieldByName('PRECO_GANHO').IsNull then
          vQueryLocal.ParamByName('PRECO_GANHO').AsFloat := vQueryCloud.FieldByName('PRECO_GANHO').AsFloat;
        if not vQueryCloud.FieldByName('PARTICIPA').IsNull then
          vQueryLocal.ParamByName('PARTICIPA').AsString := vQueryCloud.FieldByName('PARTICIPA').AsString;
        if not vQueryCloud.FieldByName('CONCORRENTE_ID').IsNull then
          vQueryLocal.ParamByName('CONCORRENTE_ID').AsInteger := vQueryCloud.FieldByName('CONCORRENTE_ID').AsInteger;
        if not vQueryCloud.FieldByName('PRECO_CONCORRENTE').IsNull then
          vQueryLocal.ParamByName('PRECO_CONCORRENTE').AsFloat := vQueryCloud.FieldByName('PRECO_CONCORRENTE').AsFloat;
        if not vQueryCloud.FieldByName('ITEM_EDITAL').IsNull then
          vQueryLocal.ParamByName('ITEM_EDITAL').AsString := vQueryCloud.FieldByName('ITEM_EDITAL').AsString;
        if not vQueryCloud.FieldByName('STATUS').IsNull then
          vQueryLocal.ParamByName('STATUS').AsString := vQueryCloud.FieldByName('STATUS').AsString;
        if not vQueryCloud.FieldByName('MARGEM').IsNull then
          vQueryLocal.ParamByName('MARGEM').AsFloat := vQueryCloud.FieldByName('MARGEM').AsFloat;
        if not vQueryCloud.FieldByName('QTDE_PEDIDO').IsNull then
          vQueryLocal.ParamByName('QTDE_PEDIDO').AsFloat := vQueryCloud.FieldByName('QTDE_PEDIDO').AsFloat;
        if not vQueryCloud.FieldByName('QTDE_NF').IsNull then
          vQueryLocal.ParamByName('QTDE_NF').AsFloat := vQueryCloud.FieldByName('QTDE_NF').AsFloat;
        if not vQueryCloud.FieldByName('RESULTADO').IsNull then
          vQueryLocal.ParamByName('RESULTADO').AsString := vQueryCloud.FieldByName('RESULTADO').AsString;
        if not vQueryCloud.FieldByName('MARCA').IsNull then
          vQueryLocal.ParamByName('MARCA').AsString := vQueryCloud.FieldByName('MARCA').AsString;
        if not vQueryCloud.FieldByName('MOTIVOPERDA_ID').IsNull then
          vQueryLocal.ParamByName('MOTIVOPERDA_ID').AsInteger := vQueryCloud.FieldByName('MOTIVOPERDA_ID').AsInteger;
        if not vQueryCloud.FieldByName('MOTIVOPERDA').IsNull then
          vQueryLocal.ParamByName('MOTIVOPERDA').AsString := vQueryCloud.FieldByName('MOTIVOPERDA').AsString;
        if not vQueryCloud.FieldByName('PRECO_MAXIMO').IsNull then
          vQueryLocal.ParamByName('PRECO_MAXIMO').AsFloat := vQueryCloud.FieldByName('PRECO_MAXIMO').AsFloat;
        vQueryLocal.ParamByName('SYNC').AsString := 'S';
        vQueryLocal.ParamByName('SYNC_DATA').AsDateTime := vlData;

        vQueryLocal.ExecSQL;
        vQueryLocal.Transaction.CommitRetaining;

        vQueryUpdateCloud.Close;
        vQueryUpdateCloud.SQL.Clear;
        vQueryUpdateCloud.SQL.Add('UPDATE TBLICITACAO_ITEM SET SYNC = ''S'', SYNC_DATA = :SYNC_DATA WHERE LITEM_ID = :LITEM_ID');

        vQueryUpdateCloud.ParamByName('SYNC_DATA').AsDateTime := vlData;
        vQueryUpdateCloud.ParamByName('LITEM_ID').AsInteger := vQueryCloud.FieldByName('LITEM_ID').AsInteger;

        vQueryUpdateCloud.ExecSQL;
        vQueryUpdateCloud.Transaction.CommitRetaining;

        Memo_Log.Lines.Add('Item atualizado em ' + FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ': ' +
                           Trim(vQueryCloud.FieldByName('LITEM_ID').AsString) + ' - ' + Trim(vQueryCloud.FieldByName('PRODUTO_ID').AsString));
      except on E: Exception do
        begin
          Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ' - Erro ao atualizar Item: ' + E.Message);

          vQueryUpdateCloud.Transaction.RollbackRetaining;
          vQueryLocal.Transaction.RollbackRetaining;

          ALocalDatabase.Connected := False;
          ALocalDatabase.Connected := True;

          ACloudDatabase.Connected := False;
          ACloudDatabase.Connected := True;

          Break;
        end;
      end;

      vQueryCloud.Next;
      Application.ProcessMessages;
    end;
  finally
    vQueryLocal.Free;
    vQueryCloud.Free;
    vQueryUpdateCloud.Free;
  end;
end;

procedure TForm_PrincipalServer.pAtualizaLicitacaoItemLocalToCloud(
  ALocalDatabase, ACloudDatabase: TIBDatabase; ALocalTransaction,
  ACloudTransaction: TIBTransaction; prLicitacaoID : String);
var
  vQueryLocal, vQueryCloud, vQueryUpdateLocal: TIBQuery;
  vlData: TDateTime;
  vMsgErro : string;
begin
  vQueryLocal := TIBQuery.Create(self);
  vQueryCloud := TIBQuery.Create(self);
  vQueryUpdateLocal := TIBQuery.Create(self);

  try
    vQueryLocal.Database := ALocalDatabase;
    vQueryLocal.Transaction := ALocalTransaction;

    vQueryCloud.Database := ACloudDatabase;
    vQueryCloud.Transaction := ACloudTransaction;

    vQueryUpdateLocal.Database := ALocalDatabase;
    vQueryUpdateLocal.Transaction := ALocalTransaction;

    vQueryLocal.Close;
    vQueryLocal.SQL.Text := 'SELECT * FROM TBLICITACAO_ITEM WHERE 1=1';

    if Trim(prLicitacaoID) = '' then
      vQueryLocal.SQL.Add(' AND SYNC = ''N'' ')
    else
      vQueryLocal.SQL.Add(' AND LICITACAO_ID = ''' + Trim(prLicitacaoID) + ''' ');

    vQueryLocal.Open;
    vQueryLocal.First;
    while not vQueryLocal.Eof do
    begin
      try
        vlData := Now;
        vQueryCloud.Close;
        vQueryCloud.SQL.Clear;
        vQueryCloud.SQL.Add('UPDATE OR INSERT INTO TBLICITACAO_ITEM');
        vQueryCloud.SQL.Add('(LITEM_ID, LICITACAO_ID, PRODUTO_ID, PRECO, QUANTIDADE, DATA_INC, DATA_ALT, DATA_DEL, USUARIO_I,');
        vQueryCloud.SQL.Add('USUARIONOME_I, USUARIO_A, USUARIO_D, DELETADO, PRECO_INICIAL, PRECO_FINAL, PDV, PRECO_GANHO,');
        vQueryCloud.SQL.Add('PARTICIPA, CONCORRENTE_ID, PRECO_CONCORRENTE, ITEM_EDITAL, STATUS, MARGEM, QTDE_PEDIDO, QTDE_NF,');
        vQueryCloud.SQL.Add('RESULTADO, MARCA, MOTIVOPERDA_ID, MOTIVOPERDA, PRECO_MAXIMO, SYNC, SYNC_DATA)');
        vQueryCloud.SQL.Add('VALUES');
        vQueryCloud.SQL.Add('(:LITEM_ID, :LICITACAO_ID, :PRODUTO_ID, :PRECO, :QUANTIDADE, :DATA_INC, :DATA_ALT, :DATA_DEL, :USUARIO_I,');
        vQueryCloud.SQL.Add(':USUARIONOME_I, :USUARIO_A, :USUARIO_D, :DELETADO, :PRECO_INICIAL, :PRECO_FINAL, :PDV, :PRECO_GANHO,');
        vQueryCloud.SQL.Add(':PARTICIPA, :CONCORRENTE_ID, :PRECO_CONCORRENTE, :ITEM_EDITAL, :STATUS, :MARGEM, :QTDE_PEDIDO, :QTDE_NF,');
        vQueryCloud.SQL.Add(':RESULTADO, :MARCA, :MOTIVOPERDA_ID, :MOTIVOPERDA, :PRECO_MAXIMO, :SYNC, :SYNC_DATA)');
        vQueryCloud.SQL.Add('MATCHING (LITEM_ID)');

        // Parametros
        vQueryCloud.ParamByName('LITEM_ID').AsInteger := vQueryLocal.FieldByName('LITEM_ID').AsInteger;
        if not vQueryLocal.FieldByName('LICITACAO_ID').IsNull then
          begin
//            pImportaLicitacao(vQueryLocal.FieldByName('LICITACAO_ID').AsString);
            vQueryCloud.ParamByName('LICITACAO_ID').AsInteger := vQueryLocal.FieldByName('LICITACAO_ID').AsInteger;
          end;

        if not vQueryLocal.FieldByName('PRODUTO_ID').IsNull then
          begin
            pImportaProduto(vQueryLocal.FieldByName('PRODUTO_ID').AsString);
            vQueryCloud.ParamByName('PRODUTO_ID').AsInteger := vQueryLocal.FieldByName('PRODUTO_ID').AsInteger;
          end;

        if not vQueryLocal.FieldByName('PRECO').IsNull then
          vQueryCloud.ParamByName('PRECO').AsFloat := vQueryLocal.FieldByName('PRECO').AsFloat;
        if not vQueryLocal.FieldByName('QUANTIDADE').IsNull then
          vQueryCloud.ParamByName('QUANTIDADE').AsFloat := vQueryLocal.FieldByName('QUANTIDADE').AsFloat;
        if not vQueryLocal.FieldByName('DATA_INC').IsNull then
          vQueryCloud.ParamByName('DATA_INC').AsDateTime := vQueryLocal.FieldByName('DATA_INC').AsDateTime;
        if not vQueryLocal.FieldByName('DATA_ALT').IsNull then
          vQueryCloud.ParamByName('DATA_ALT').AsDateTime := vQueryLocal.FieldByName('DATA_ALT').AsDateTime;
        if not vQueryLocal.FieldByName('DATA_DEL').IsNull then
          vQueryCloud.ParamByName('DATA_DEL').AsDateTime := vQueryLocal.FieldByName('DATA_DEL').AsDateTime;
        if not vQueryLocal.FieldByName('USUARIO_I').IsNull then
          vQueryCloud.ParamByName('USUARIO_I').AsInteger := vQueryLocal.FieldByName('USUARIO_I').AsInteger;
        if not vQueryLocal.FieldByName('USUARIONOME_I').IsNull then
          vQueryCloud.ParamByName('USUARIONOME_I').AsString := vQueryLocal.FieldByName('USUARIONOME_I').AsString;
        if not vQueryLocal.FieldByName('USUARIO_A').IsNull then
          vQueryCloud.ParamByName('USUARIO_A').AsInteger := vQueryLocal.FieldByName('USUARIO_A').AsInteger;
        if not vQueryLocal.FieldByName('USUARIO_D').IsNull then
          vQueryCloud.ParamByName('USUARIO_D').AsInteger := vQueryLocal.FieldByName('USUARIO_D').AsInteger;
        if not vQueryLocal.FieldByName('DELETADO').IsNull then
          vQueryCloud.ParamByName('DELETADO').AsString := vQueryLocal.FieldByName('DELETADO').AsString;
        if not vQueryLocal.FieldByName('PRECO_INICIAL').IsNull then
          vQueryCloud.ParamByName('PRECO_INICIAL').AsFloat := vQueryLocal.FieldByName('PRECO_INICIAL').AsFloat;
        if not vQueryLocal.FieldByName('PRECO_FINAL').IsNull then
          vQueryCloud.ParamByName('PRECO_FINAL').AsFloat := vQueryLocal.FieldByName('PRECO_FINAL').AsFloat;
        if not vQueryLocal.FieldByName('PDV').IsNull then
          vQueryCloud.ParamByName('PDV').AsFloat := vQueryLocal.FieldByName('PDV').AsFloat;
        if not vQueryLocal.FieldByName('PRECO_GANHO').IsNull then
          vQueryCloud.ParamByName('PRECO_GANHO').AsFloat := vQueryLocal.FieldByName('PRECO_GANHO').AsFloat;
        if not vQueryLocal.FieldByName('PARTICIPA').IsNull then
          vQueryCloud.ParamByName('PARTICIPA').AsString := vQueryLocal.FieldByName('PARTICIPA').AsString;
        if not vQueryLocal.FieldByName('CONCORRENTE_ID').IsNull then
          vQueryCloud.ParamByName('CONCORRENTE_ID').AsInteger := vQueryLocal.FieldByName('CONCORRENTE_ID').AsInteger;
        if not vQueryLocal.FieldByName('PRECO_CONCORRENTE').IsNull then
          vQueryCloud.ParamByName('PRECO_CONCORRENTE').AsFloat := vQueryLocal.FieldByName('PRECO_CONCORRENTE').AsFloat;
        if not vQueryLocal.FieldByName('ITEM_EDITAL').IsNull then
          vQueryCloud.ParamByName('ITEM_EDITAL').AsString := vQueryLocal.FieldByName('ITEM_EDITAL').AsString;
        if not vQueryLocal.FieldByName('STATUS').IsNull then
          vQueryCloud.ParamByName('STATUS').AsString := vQueryLocal.FieldByName('STATUS').AsString;
        if not vQueryLocal.FieldByName('MARGEM').IsNull then
          vQueryCloud.ParamByName('MARGEM').AsFloat := vQueryLocal.FieldByName('MARGEM').AsFloat;
        if not vQueryLocal.FieldByName('QTDE_PEDIDO').IsNull then
          vQueryCloud.ParamByName('QTDE_PEDIDO').AsFloat := vQueryLocal.FieldByName('QTDE_PEDIDO').AsFloat;
        if not vQueryLocal.FieldByName('QTDE_NF').IsNull then
          vQueryCloud.ParamByName('QTDE_NF').AsFloat := vQueryLocal.FieldByName('QTDE_NF').AsFloat;
        if not vQueryLocal.FieldByName('RESULTADO').IsNull then
          vQueryCloud.ParamByName('RESULTADO').AsString := vQueryLocal.FieldByName('RESULTADO').AsString;
        if not vQueryLocal.FieldByName('MARCA').IsNull then
          vQueryCloud.ParamByName('MARCA').AsString := vQueryLocal.FieldByName('MARCA').AsString;
        if not vQueryLocal.FieldByName('MOTIVOPERDA_ID').IsNull then
          vQueryCloud.ParamByName('MOTIVOPERDA_ID').AsInteger := vQueryLocal.FieldByName('MOTIVOPERDA_ID').AsInteger;
        if not vQueryLocal.FieldByName('MOTIVOPERDA').IsNull then
          vQueryCloud.ParamByName('MOTIVOPERDA').AsString := vQueryLocal.FieldByName('MOTIVOPERDA').AsString;
        if not vQueryLocal.FieldByName('PRECO_MAXIMO').IsNull then
          vQueryCloud.ParamByName('PRECO_MAXIMO').AsFloat := vQueryLocal.FieldByName('PRECO_MAXIMO').AsFloat;

        vQueryCloud.ParamByName('SYNC').AsString        := 'N';
        vQueryCloud.ParamByName('SYNC_DATA').AsDateTime := vlData;

        vQueryCloud.ExecSQL;
        vQueryCloud.Transaction.CommitRetaining;

        vQueryUpdateLocal.Close;
        vQueryUpdateLocal.SQL.Clear;
        vQueryUpdateLocal.SQL.Add('UPDATE TBLICITACAO_ITEM SET SYNC = ''S'', SYNC_DATA = :SYNC_DATA WHERE LITEM_ID = :LITEM_ID');

        vQueryUpdateLocal.ParamByName('SYNC_DATA').AsDateTime := vlData;
        vQueryUpdateLocal.ParamByName('LITEM_ID').AsInteger   := vQueryLocal.FieldByName('LITEM_ID').AsInteger;

        vQueryUpdateLocal.ExecSQL;
        vQueryUpdateLocal.Transaction.CommitRetaining;

        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-TBLICITACAO_ITEM Local->Cloud atualizada: ' +
                               Trim(vQueryLocal.FieldByName('LITEM_ID').AsString));
          end);
      except on E: Exception do
        begin
          TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              vMsgErro := FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-Erro ao atualizar TBLICITACAO_ITEM [' + vQueryLocal.FieldByName('LITEM_ID').AsString + '] Local->Cloud: ' + E.Message;
              logErros(vMsgErro);
              Memo_Log.Lines.Add(vMsgErro);
            end);

          vQueryUpdateLocal.Transaction.RollbackRetaining;
          vQueryCloud.Transaction.RollbackRetaining;

          ALocalDatabase.Connected := False;
          ALocalDatabase.Connected := True;

          ACloudDatabase.Connected := False;
          ACloudDatabase.Connected := True;

          Break;
        end;
      end;

      vQueryLocal.Next;
    end;
  finally
    vQueryLocal.Free;
    vQueryCloud.Free;
    vQueryUpdateLocal.Free;
  end;
end;

procedure TForm_PrincipalServer.pAtualizaLicitacaoLocalToCloud(ALocalDatabase,
  ACloudDatabase: TIBDatabase; ALocalTransaction, ACloudTransaction: TIBTransaction);
var
  vQueryLocal, vQueryCloud, vQueryUpdateLocal, vQuerySync: TIBQuery;
  vlData: TDateTime;
  vCampo, vValor, vOperador, vFiltro: string;
  vMsgErro: string;
begin
  vQueryLocal       := TIBQuery.Create(self);
  vQueryCloud       := TIBQuery.Create(self);
  vQueryUpdateLocal := TIBQuery.Create(self);
  vQuerySync        := TIBQuery.Create(self);

  try
    vQuerySync.Database    := ALocalDatabase;
    vQuerySync.Transaction := ALocalTransaction;

    // Consulta para obter configurações da TBSYNC
    vQuerySync.Close;
    vQuerySync.SQL.Text := 'SELECT * FROM TBSYNC WHERE TABELA = :Tabela';
    vQuerySync.ParamByName('Tabela').AsString := 'TBLICITACAO';
    vQuerySync.Open;

    // Construir cláusula WHERE dinamicamente
    if not vQuerySync.IsEmpty then
    begin
      vQueryLocal.Database    := ALocalDatabase;
      vQueryLocal.Transaction := ALocalTransaction;

      vQueryCloud.Database    := ACloudDatabase;
      vQueryCloud.Transaction := ACloudTransaction;

      vQueryUpdateLocal.Database    := ALocalDatabase;
      vQueryUpdateLocal.Transaction := ALocalTransaction;

      // Adiciona filtros baseados em TBSYNC
      vQueryLocal.Close;
      vQueryLocal.SQL.Text := 'SELECT * FROM TBLICITACAO WHERE SYNC = ''N'' ';

      vQuerySync.First;
      while not vQuerySync.Eof do
      begin
        vCampo    := vQuerySync.FieldByName('CAMPO').AsString;
        vValor    := vQuerySync.FieldByName('VALOR').AsString;
        vOperador := vQuerySync.FieldByName('OPERADOR').AsString;

        if vOperador = 'IN' then
          vFiltro := Format(' AND %s IN (%s)', [vCampo, vValor])
        else
          vFiltro := Format(' AND %s %s ''%s''', [vCampo, vOperador, vValor]);

        vQueryLocal.SQL.Add(vFiltro);

        vQuerySync.Next;
      end;

      vQueryLocal.Open;
      vQueryLocal.First;
      while not vQueryLocal.Eof do
      begin
        try
          if vPararServidor = True then
            begin
              Timer_Tabelas.Enabled := False;
              Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', Now) + '-Servidor Desativado. TBLICITACAO Desativada.');
              Abort;
            end;

          vlData := Now;
          vQueryCloud.Close;
          vQueryCloud.SQL.Clear;
          vQueryCloud.SQL.Add('UPDATE OR INSERT INTO TBLICITACAO');
          vQueryCloud.SQL.Add('(LICITACAO_ID, PESSOA_ID, DATA, PROCESSO, PROCESSO_ANO, PROCESSO_ADMIN, PROCESSO_ADMIN_ANO, PORTARIA, PORTARIA_ANO,');
          vQueryCloud.SQL.Add('MODALIDADE_ID, MODALIDADE_NUMERO, MODALIDADE_ANO, OBJETO_ID, DATA_INC, DATA_ALT, DATA_DEL, USUARIO_I, USUARIO_A, USUARIO_D,');
          vQueryCloud.SQL.Add('HORA, PARTICIPA, MOTIVO, OBS, TIPO, DELETADO, GANHA, PESSOA_VR, VIGENCIA, ENTREGA, VALIDADE_COTACAO, CLIENTE_ID, VIGENCIA_DATA,');
          vQueryCloud.SQL.Add('HOMOLOGACAO, TIPO_ENTREGA, ORIGEM, GARANTIA_PRECO, SITE, ENTREGAS, USUARIONOME_I, USUARIONOME_A, USUARIONOME_D, LICITACAO_ORIGEM,');
          vQueryCloud.SQL.Add('VIGENCIA_INI, STATUS, OBS_INTERNO, OBS_CLIENTE, SYNC, SYNC_DATA)');
          vQueryCloud.SQL.Add('VALUES');
          vQueryCloud.SQL.Add('(:LICITACAO_ID, :PESSOA_ID, :DATA, :PROCESSO, :PROCESSO_ANO, :PROCESSO_ADMIN, :PROCESSO_ADMIN_ANO, :PORTARIA, :PORTARIA_ANO,');
          vQueryCloud.SQL.Add(':MODALIDADE_ID, :MODALIDADE_NUMERO, :MODALIDADE_ANO, :OBJETO_ID, :DATA_INC, :DATA_ALT, :DATA_DEL, :USUARIO_I, :USUARIO_A, :USUARIO_D,');
          vQueryCloud.SQL.Add(':HORA, :PARTICIPA, :MOTIVO, :OBS, :TIPO, :DELETADO, :GANHA, :PESSOA_VR, :VIGENCIA, :ENTREGA, :VALIDADE_COTACAO, :CLIENTE_ID, :VIGENCIA_DATA,');
          vQueryCloud.SQL.Add(':HOMOLOGACAO, :TIPO_ENTREGA, :ORIGEM, :GARANTIA_PRECO, :SITE, :ENTREGAS, :USUARIONOME_I, :USUARIONOME_A, :USUARIONOME_D, :LICITACAO_ORIGEM,');
          vQueryCloud.SQL.Add(':VIGENCIA_INI, :STATUS, :OBS_INTERNO, :OBS_CLIENTE, :SYNC, :SYNC_DATA)');
          vQueryCloud.SQL.Add('MATCHING (LICITACAO_ID)');

          // Parametros
          vQueryCloud.ParamByName('LICITACAO_ID').AsInteger := vQueryLocal.FieldByName('LICITACAO_ID').AsInteger;

          if not vQueryLocal.FieldByName('PESSOA_ID').IsNull then
            begin
              pImportaPessoa(vQueryLocal.FieldByName('PESSOA_ID').AsString);
              vQueryCloud.ParamByName('PESSOA_ID').AsInteger := vQueryLocal.FieldByName('PESSOA_ID').AsInteger;
            end;

          if not vQueryLocal.FieldByName('CLIENTE_ID').IsNull then
            begin
              pImportaPessoa(vQueryLocal.FieldByName('CLIENTE_ID').AsString);
              vQueryCloud.ParamByName('CLIENTE_ID').AsInteger := vQueryLocal.FieldByName('CLIENTE_ID').AsInteger;
            end;

          if not vQueryLocal.FieldByName('PESSOA_VR').IsNull then // VendedorID pela TBPESSOAS
            begin
              pImportaPessoa(vQueryLocal.FieldByName('PESSOA_VR').AsString);
              vQueryCloud.ParamByName('PESSOA_VR').AsInteger := vQueryLocal.FieldByName('PESSOA_VR').AsInteger;
            end;

          if not vQueryLocal.FieldByName('DATA').IsNull then
            vQueryCloud.ParamByName('DATA').AsDateTime := vQueryLocal.FieldByName('DATA').AsDateTime;
          if not vQueryLocal.FieldByName('PROCESSO').IsNull then
            vQueryCloud.ParamByName('PROCESSO').AsString := vQueryLocal.FieldByName('PROCESSO').AsString;
          if not vQueryLocal.FieldByName('PROCESSO_ANO').IsNull then
            vQueryCloud.ParamByName('PROCESSO_ANO').AsString := vQueryLocal.FieldByName('PROCESSO_ANO').AsString;
          if not vQueryLocal.FieldByName('PROCESSO_ADMIN').IsNull then
            vQueryCloud.ParamByName('PROCESSO_ADMIN').AsString := vQueryLocal.FieldByName('PROCESSO_ADMIN').AsString;
          if not vQueryLocal.FieldByName('PROCESSO_ADMIN_ANO').IsNull then
            vQueryCloud.ParamByName('PROCESSO_ADMIN_ANO').AsString := vQueryLocal.FieldByName('PROCESSO_ADMIN_ANO').AsString;
          if not vQueryLocal.FieldByName('PORTARIA').IsNull then
            vQueryCloud.ParamByName('PORTARIA').AsString := vQueryLocal.FieldByName('PORTARIA').AsString;
          if not vQueryLocal.FieldByName('PORTARIA_ANO').IsNull then
            vQueryCloud.ParamByName('PORTARIA_ANO').AsString := vQueryLocal.FieldByName('PORTARIA_ANO').AsString;
          if not vQueryLocal.FieldByName('MODALIDADE_ID').IsNull then
            vQueryCloud.ParamByName('MODALIDADE_ID').AsInteger := vQueryLocal.FieldByName('MODALIDADE_ID').AsInteger;
          if not vQueryLocal.FieldByName('MODALIDADE_NUMERO').IsNull then
            vQueryCloud.ParamByName('MODALIDADE_NUMERO').AsString := vQueryLocal.FieldByName('MODALIDADE_NUMERO').AsString;
          if not vQueryLocal.FieldByName('MODALIDADE_ANO').IsNull then
            vQueryCloud.ParamByName('MODALIDADE_ANO').AsString := vQueryLocal.FieldByName('MODALIDADE_ANO').AsString;
          if not vQueryLocal.FieldByName('OBJETO_ID').IsNull then
            vQueryCloud.ParamByName('OBJETO_ID').AsInteger := vQueryLocal.FieldByName('OBJETO_ID').AsInteger;
          if not vQueryLocal.FieldByName('DATA_INC').IsNull then
            vQueryCloud.ParamByName('DATA_INC').AsDateTime := vQueryLocal.FieldByName('DATA_INC').AsDateTime;
          if not vQueryLocal.FieldByName('DATA_ALT').IsNull then
            vQueryCloud.ParamByName('DATA_ALT').AsDateTime := vQueryLocal.FieldByName('DATA_ALT').AsDateTime;
          if not vQueryLocal.FieldByName('DATA_DEL').IsNull then
            vQueryCloud.ParamByName('DATA_DEL').AsDateTime := vQueryLocal.FieldByName('DATA_DEL').AsDateTime;
          if not vQueryLocal.FieldByName('USUARIO_I').IsNull then
            vQueryCloud.ParamByName('USUARIO_I').AsInteger := vQueryLocal.FieldByName('USUARIO_I').AsInteger;
          if not vQueryLocal.FieldByName('USUARIO_A').IsNull then
            vQueryCloud.ParamByName('USUARIO_A').AsInteger := vQueryLocal.FieldByName('USUARIO_A').AsInteger;
          if not vQueryLocal.FieldByName('USUARIO_D').IsNull then
            vQueryCloud.ParamByName('USUARIO_D').AsInteger := vQueryLocal.FieldByName('USUARIO_D').AsInteger;
          if not vQueryLocal.FieldByName('HORA').IsNull then
            vQueryCloud.ParamByName('HORA').AsDateTime := vQueryLocal.FieldByName('HORA').AsDateTime;
          if not vQueryLocal.FieldByName('PARTICIPA').IsNull then
            vQueryCloud.ParamByName('PARTICIPA').AsString := vQueryLocal.FieldByName('PARTICIPA').AsString;
          if not vQueryLocal.FieldByName('MOTIVO').IsNull then
            vQueryCloud.ParamByName('MOTIVO').AsString := vQueryLocal.FieldByName('MOTIVO').AsString;
          if not vQueryLocal.FieldByName('OBS').IsNull then
            vQueryCloud.ParamByName('OBS').Assign(vQueryLocal.FieldByName('OBS'));
          if not vQueryLocal.FieldByName('TIPO').IsNull then
            vQueryCloud.ParamByName('TIPO').AsString := vQueryLocal.FieldByName('TIPO').AsString;
          if not vQueryLocal.FieldByName('DELETADO').IsNull then
            vQueryCloud.ParamByName('DELETADO').AsString := vQueryLocal.FieldByName('DELETADO').AsString;
          if not vQueryLocal.FieldByName('GANHA').IsNull then
            vQueryCloud.ParamByName('GANHA').AsString := vQueryLocal.FieldByName('GANHA').AsString;
          if not vQueryLocal.FieldByName('VIGENCIA').IsNull then
            vQueryCloud.ParamByName('VIGENCIA').AsFloat := vQueryLocal.FieldByName('VIGENCIA').AsFloat;
          if not vQueryLocal.FieldByName('ENTREGA').IsNull then
            vQueryCloud.ParamByName('ENTREGA').AsFloat := vQueryLocal.FieldByName('ENTREGA').AsFloat;
          if not vQueryLocal.FieldByName('VALIDADE_COTACAO').IsNull then
            vQueryCloud.ParamByName('VALIDADE_COTACAO').AsDateTime := vQueryLocal.FieldByName('VALIDADE_COTACAO').AsDateTime;
          if not vQueryLocal.FieldByName('VIGENCIA_DATA').IsNull then
            vQueryCloud.ParamByName('VIGENCIA_DATA').AsDateTime := vQueryLocal.FieldByName('VIGENCIA_DATA').AsDateTime;
          if not vQueryLocal.FieldByName('HOMOLOGACAO').IsNull then
            vQueryCloud.ParamByName('HOMOLOGACAO').AsDateTime := vQueryLocal.FieldByName('HOMOLOGACAO').AsDateTime;
          if not vQueryLocal.FieldByName('TIPO_ENTREGA').IsNull then
            vQueryCloud.ParamByName('TIPO_ENTREGA').AsString := vQueryLocal.FieldByName('TIPO_ENTREGA').AsString;
          if not vQueryLocal.FieldByName('ORIGEM').IsNull then
            vQueryCloud.ParamByName('ORIGEM').AsString := vQueryLocal.FieldByName('ORIGEM').AsString;
          if not vQueryLocal.FieldByName('GARANTIA_PRECO').IsNull then
            vQueryCloud.ParamByName('GARANTIA_PRECO').AsDateTime := vQueryLocal.FieldByName('GARANTIA_PRECO').AsDateTime;
          if not vQueryLocal.FieldByName('SITE').IsNull then
            vQueryCloud.ParamByName('SITE').AsString := vQueryLocal.FieldByName('SITE').AsString;
          if not vQueryLocal.FieldByName('ENTREGAS').IsNull then
            vQueryCloud.ParamByName('ENTREGAS').AsInteger := vQueryLocal.FieldByName('ENTREGAS').AsInteger;
          if not vQueryLocal.FieldByName('USUARIONOME_I').IsNull then
            vQueryCloud.ParamByName('USUARIONOME_I').AsString := vQueryLocal.FieldByName('USUARIONOME_I').AsString;
          if not vQueryLocal.FieldByName('USUARIONOME_A').IsNull then
            vQueryCloud.ParamByName('USUARIONOME_A').AsString := vQueryLocal.FieldByName('USUARIONOME_A').AsString;
          if not vQueryLocal.FieldByName('USUARIONOME_D').IsNull then
            vQueryCloud.ParamByName('USUARIONOME_D').AsString := vQueryLocal.FieldByName('USUARIONOME_D').AsString;
          if not vQueryLocal.FieldByName('LICITACAO_ORIGEM').IsNull then
            vQueryCloud.ParamByName('LICITACAO_ORIGEM').AsInteger := vQueryLocal.FieldByName('LICITACAO_ORIGEM').AsInteger;
          if not vQueryLocal.FieldByName('VIGENCIA_INI').IsNull then
            vQueryCloud.ParamByName('VIGENCIA_INI').AsDateTime := vQueryLocal.FieldByName('VIGENCIA_INI').AsDateTime;
          if not vQueryLocal.FieldByName('STATUS').IsNull then
            vQueryCloud.ParamByName('STATUS').AsString := vQueryLocal.FieldByName('STATUS').AsString;
          if not vQueryLocal.FieldByName('OBS_INTERNO').IsNull then
            vQueryCloud.ParamByName('OBS_INTERNO').Assign(vQueryLocal.FieldByName('OBS_INTERNO'));
          if not vQueryLocal.FieldByName('OBS_CLIENTE').IsNull then
            vQueryCloud.ParamByName('OBS_CLIENTE').Assign(vQueryLocal.FieldByName('OBS_CLIENTE'));

          vQueryCloud.ParamByName('SYNC').AsString        := 'N';
          vQueryCloud.ParamByName('SYNC_DATA').AsDateTime := vlData;

          vQueryCloud.ExecSQL;
          vQueryCloud.Transaction.CommitRetaining;

          vQueryUpdateLocal.Close;
          vQueryUpdateLocal.SQL.Clear;
          vQueryUpdateLocal.SQL.Add('UPDATE TBLICITACAO SET SYNC = ''S'', SYNC_DATA = :SYNC_DATA WHERE LICITACAO_ID = :LICITACAO_ID');

          vQueryUpdateLocal.ParamByName('SYNC_DATA').AsDateTime   := vlData;
          vQueryUpdateLocal.ParamByName('LICITACAO_ID').AsInteger := vQueryLocal.FieldByName('LICITACAO_ID').AsInteger;

          vQueryUpdateLocal.ExecSQL;
          vQueryUpdateLocal.Transaction.CommitRetaining;

          TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-TBLICITACAO Local->Cloud atualizada: ' +
                                 Trim(vQueryLocal.FieldByName('LICITACAO_ID').AsString));
            end);

          pAtualizaLicitacaoItemLocalToCloud(dm1.IBDatabase1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransaction1, dm1.IBTransactionCloudSICFAR,    vQueryLocal.FieldByName('LICITACAO_ID').AsString);
          pAtualizaLicitacaoAdiLocalToCloud(dm1.IBDatabase1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransaction1, dm1.IBTransactionCloudSICFAR,     vQueryLocal.FieldByName('LICITACAO_ID').AsString);
          pAtualizaLicitacaoEntregaLocalToCloud(dm1.IBDatabase1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransaction1, dm1.IBTransactionCloudSICFAR, vQueryLocal.FieldByName('LICITACAO_ID').AsString);
          pAtualizaLicitacaoOrgaoLocalToCloud(dm1.IBDatabase1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransaction1, dm1.IBTransactionCloudSICFAR,   vQueryLocal.FieldByName('LICITACAO_ID').AsString);

        except on E: Exception do
          begin
            TThread.Synchronize(TThread.CurrentThread,
              procedure
              begin
                vMsgErro := FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-Erro ao atualizar TBLICITACAO [' + vQueryLocal.FieldByName('LICITACAO_ID').AsString + '] Local->Cloud: ' + E.Message;
                logErros(vMsgErro);
                Memo_Log.Lines.Add(vMsgErro);
              end);

            vQueryUpdateLocal.Transaction.RollbackRetaining;
            vQueryCloud.Transaction.RollbackRetaining;

            ALocalDatabase.Connected := False;
            ALocalDatabase.Connected := True;

            ACloudDatabase.Connected := False;
            ACloudDatabase.Connected := True;

            Break;  // Sai do loop while
          end;
        end;

        vQueryLocal.Next;
      end;
    end;
  finally
    vQueryLocal.Free;
    vQueryCloud.Free;
    vQueryUpdateLocal.Free;
  end;
end;

procedure TForm_PrincipalServer.pAtualizaLicitacaoOrgaoCloudToLocal(
  ALocalDatabase, ACloudDatabase: TIBDatabase; ALocalTransaction,
  ACloudTransaction: TIBTransaction; prLicitacaoId: String);
var
  vQueryLocal, vQueryCloud, vQueryUpdateCloud: TIBQuery;
  vlData: TDateTime;
begin
  vQueryLocal := TIBQuery.Create(self);
  vQueryCloud := TIBQuery.Create(self);
  vQueryUpdateCloud := TIBQuery.Create(self);

  try
    vQueryLocal.Database := ALocalDatabase;
    vQueryLocal.Transaction := ALocalTransaction;

    vQueryCloud.Database := ACloudDatabase;
    vQueryCloud.Transaction := ACloudTransaction;

    vQueryUpdateCloud.Database := ACloudDatabase;
    vQueryUpdateCloud.Transaction := ACloudTransaction;

    vQueryCloud.Close;
    vQueryCloud.SQL.Text := 'SELECT * FROM TBLICITACAO_ORGAO WHERE 1=1';

    if Trim(prLicitacaoID) = '' then
      vQueryCloud.SQL.Add(' AND SYNC = ''N'' ')
    else
      vQueryCloud.SQL.Add(' AND LICITACAO_ID = ''' + Trim(prLicitacaoID) + ''' ');

    vQueryCloud.Open;
    vQueryCloud.First;
    while not vQueryCloud.Eof do
    begin
      try
        vlData := Now;
        vQueryLocal.Close;
        vQueryLocal.SQL.Clear;
        vQueryLocal.SQL.Add('UPDATE OR INSERT INTO TBLICITACAO_ORGAO');
        vQueryLocal.SQL.Add('(LICITACAOORGAO_ID, LICITACAO_ID, PESSOA_ID, RAZAOSOCIAL, CIDADE, UF, CNPJ, TELEFONE, DELETADO,');
        vQueryLocal.SQL.Add('DATA_INC, USUARIO_I, USUARIONOME_I, DATA_ALT, USUARIO_A, USUARIONOME_A, DATA_DEL, USUARIO_D,');
        vQueryLocal.SQL.Add('USUARIONOME_D, SYNC, SYNC_DATA)');
        vQueryLocal.SQL.Add('VALUES');
        vQueryLocal.SQL.Add('(:LICITACAOORGAO_ID, :LICITACAO_ID, :PESSOA_ID, :RAZAOSOCIAL, :CIDADE, :UF, :CNPJ, :TELEFONE, :DELETADO,');
        vQueryLocal.SQL.Add(':DATA_INC, :USUARIO_I, :USUARIONOME_I, :DATA_ALT, :USUARIO_A, :USUARIONOME_A, :DATA_DEL, :USUARIO_D,');
        vQueryLocal.SQL.Add(':USUARIONOME_D, :SYNC, :SYNC_DATA)');
        vQueryLocal.SQL.Add('MATCHING (LICITACAOORGAO_ID)');

        // Parametros
        vQueryLocal.ParamByName('LICITACAOORGAO_ID').AsString := vQueryCloud.FieldByName('LICITACAOORGAO_ID').AsString;
        if not vQueryCloud.FieldByName('LICITACAO_ID').IsNull then
          vQueryLocal.ParamByName('LICITACAO_ID').AsString := vQueryCloud.FieldByName('LICITACAO_ID').AsString;
        if not vQueryCloud.FieldByName('PESSOA_ID').IsNull then
          vQueryLocal.ParamByName('PESSOA_ID').AsString := vQueryCloud.FieldByName('PESSOA_ID').AsString;
        if not vQueryCloud.FieldByName('RAZAOSOCIAL').IsNull then
          vQueryLocal.ParamByName('RAZAOSOCIAL').AsString := vQueryCloud.FieldByName('RAZAOSOCIAL').AsString;
        if not vQueryCloud.FieldByName('CIDADE').IsNull then
          vQueryLocal.ParamByName('CIDADE').AsString := vQueryCloud.FieldByName('CIDADE').AsString;
        if not vQueryCloud.FieldByName('UF').IsNull then
          vQueryLocal.ParamByName('UF').AsString := vQueryCloud.FieldByName('UF').AsString;
        if not vQueryCloud.FieldByName('CNPJ').IsNull then
          vQueryLocal.ParamByName('CNPJ').AsString := vQueryCloud.FieldByName('CNPJ').AsString;
        if not vQueryCloud.FieldByName('TELEFONE').IsNull then
          vQueryLocal.ParamByName('TELEFONE').AsString := vQueryCloud.FieldByName('TELEFONE').AsString;
        if not vQueryCloud.FieldByName('DELETADO').IsNull then
          vQueryLocal.ParamByName('DELETADO').AsString := vQueryCloud.FieldByName('DELETADO').AsString;
        if not vQueryCloud.FieldByName('DATA_INC').IsNull then
          vQueryLocal.ParamByName('DATA_INC').AsDateTime := vQueryCloud.FieldByName('DATA_INC').AsDateTime;
        if not vQueryCloud.FieldByName('USUARIO_I').IsNull then
          vQueryLocal.ParamByName('USUARIO_I').AsString := vQueryCloud.FieldByName('USUARIO_I').AsString;
        if not vQueryCloud.FieldByName('USUARIONOME_I').IsNull then
          vQueryLocal.ParamByName('USUARIONOME_I').AsString := vQueryCloud.FieldByName('USUARIONOME_I').AsString;
        if not vQueryCloud.FieldByName('DATA_ALT').IsNull then
          vQueryLocal.ParamByName('DATA_ALT').AsDateTime := vQueryCloud.FieldByName('DATA_ALT').AsDateTime;
        if not vQueryCloud.FieldByName('USUARIO_A').IsNull then
          vQueryLocal.ParamByName('USUARIO_A').AsString := vQueryCloud.FieldByName('USUARIO_A').AsString;
        if not vQueryCloud.FieldByName('USUARIONOME_A').IsNull then
         vQueryLocal.ParamByName('USUARIONOME_A').AsString := vQueryCloud.FieldByName('USUARIONOME_A').AsString;
        if not vQueryCloud.FieldByName('DATA_DEL').IsNull then
          vQueryLocal.ParamByName('DATA_DEL').AsDateTime := vQueryCloud.FieldByName('DATA_DEL').AsDateTime;
        if not vQueryCloud.FieldByName('USUARIO_D').IsNull then
          vQueryLocal.ParamByName('USUARIO_D').AsString := vQueryCloud.FieldByName('USUARIO_D').AsString;
        if not vQueryCloud.FieldByName('USUARIONOME_D').IsNull then
         vQueryLocal.ParamByName('USUARIONOME_D').AsString := vQueryCloud.FieldByName('USUARIONOME_D').AsString;
        vQueryLocal.ParamByName('SYNC').AsString := 'S';
        vQueryLocal.ParamByName('SYNC_DATA').AsDateTime := vlData;

        vQueryLocal.ExecSQL;
        vQueryLocal.Transaction.CommitRetaining;

        vQueryUpdateCloud.Close;
        vQueryUpdateCloud.SQL.Clear;
        vQueryUpdateCloud.SQL.Add('UPDATE TBLICITACAO_ORGAO SET SYNC = ''S'', SYNC_DATA = :SYNC_DATA WHERE LICITACAOORGAO_ID = :LICITACAOORGAO_ID');

        vQueryUpdateCloud.ParamByName('SYNC_DATA').AsDateTime := vlData;
        vQueryUpdateCloud.ParamByName('LICITACAOORGAO_ID').AsString := vQueryCloud.FieldByName('LICITACAOORGAO_ID').AsString;

        vQueryUpdateCloud.ExecSQL;
        vQueryUpdateCloud.Transaction.CommitRetaining;

        Memo_Log.Lines.Add('Item atualizado em ' + FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ': ' +
                           Trim(vQueryCloud.FieldByName('LICITACAOORGAO_ID').AsString) + ' - ' + Trim(vQueryCloud.FieldByName('RAZAOSOCIAL').AsString));
      except on E: Exception do
        begin
          Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ' - Erro ao atualizar Item: ' + E.Message);
          vQueryUpdateCloud.Transaction.RollbackRetaining;
          vQueryLocal.Transaction.RollbackRetaining;

          ALocalDatabase.Connected := False;
          ALocalDatabase.Connected := True;

          ACloudDatabase.Connected := False;
          ACloudDatabase.Connected := True;

          Break;
        end;
      end;

      vQueryCloud.Next;
      Application.ProcessMessages;
    end;
  finally
    vQueryLocal.Free;
    vQueryCloud.Free;
    vQueryUpdateCloud.Free;
  end;
end;

procedure TForm_PrincipalServer.pAtualizaLicitacaoOrgaoLocalToCloud(
  ALocalDatabase, ACloudDatabase: TIBDatabase; ALocalTransaction,
  ACloudTransaction: TIBTransaction; prLicitacaoId: String);
var
  vQueryLocal, vQueryCloud, vQueryUpdateLocal: TIBQuery;
  vlData   : TDateTime;
  vMsgErro : string;
begin
  vQueryLocal := TIBQuery.Create(self);
  vQueryCloud := TIBQuery.Create(self);
  vQueryUpdateLocal := TIBQuery.Create(self);

  try
    vQueryLocal.Database := ALocalDatabase;
    vQueryLocal.Transaction := ALocalTransaction;

    vQueryCloud.Database := ACloudDatabase;
    vQueryCloud.Transaction := ACloudTransaction;

    vQueryUpdateLocal.Database := ALocalDatabase;
    vQueryUpdateLocal.Transaction := ALocalTransaction;

    vQueryLocal.Close;
    vQueryLocal.SQL.Text := 'SELECT * FROM TBLICITACAO_ORGAO WHERE 1=1';

    if Trim(prLicitacaoID) = '' then
      vQueryLocal.SQL.Add(' AND SYNC = ''N'' ')
    else
      vQueryLocal.SQL.Add(' AND LICITACAO_ID = ''' + Trim(prLicitacaoID) + ''' ');

    vQueryLocal.Open;
    vQueryLocal.First;
    while not vQueryLocal.Eof do
    begin
      try
        vlData := Now;
        vQueryCloud.Close;
        vQueryCloud.SQL.Clear;
        vQueryCloud.SQL.Add('UPDATE OR INSERT INTO TBLICITACAO_ORGAO');
        vQueryCloud.SQL.Add('(LICITACAOORGAO_ID, LICITACAO_ID, PESSOA_ID, RAZAOSOCIAL, CIDADE, UF, CNPJ, TELEFONE, DELETADO,');
        vQueryCloud.SQL.Add('DATA_INC, USUARIO_I, USUARIONOME_I, DATA_ALT, USUARIO_A, USUARIONOME_A, DATA_DEL, USUARIO_D,');
        vQueryCloud.SQL.Add('USUARIONOME_D, SYNC, SYNC_DATA)');
        vQueryCloud.SQL.Add('VALUES');
        vQueryCloud.SQL.Add('(:LICITACAOORGAO_ID, :LICITACAO_ID, :PESSOA_ID, :RAZAOSOCIAL, :CIDADE, :UF, :CNPJ, :TELEFONE, :DELETADO,');
        vQueryCloud.SQL.Add(':DATA_INC, :USUARIO_I, :USUARIONOME_I, :DATA_ALT, :USUARIO_A, :USUARIONOME_A, :DATA_DEL, :USUARIO_D,');
        vQueryCloud.SQL.Add(':USUARIONOME_D, :SYNC, :SYNC_DATA)');
        vQueryCloud.SQL.Add('MATCHING (LICITACAOORGAO_ID)');

        // Parametros
        vQueryCloud.ParamByName('LICITACAOORGAO_ID').AsString := vQueryLocal.FieldByName('LICITACAOORGAO_ID').AsString;
        if not vQueryLocal.FieldByName('LICITACAO_ID').IsNull then
          vQueryCloud.ParamByName('LICITACAO_ID').AsString := vQueryLocal.FieldByName('LICITACAO_ID').AsString;
        if not vQueryLocal.FieldByName('PESSOA_ID').IsNull then
          vQueryCloud.ParamByName('PESSOA_ID').AsString := vQueryLocal.FieldByName('PESSOA_ID').AsString;
        if not vQueryLocal.FieldByName('RAZAOSOCIAL').IsNull then
          vQueryCloud.ParamByName('RAZAOSOCIAL').AsString := vQueryLocal.FieldByName('RAZAOSOCIAL').AsString;
        if not vQueryLocal.FieldByName('CIDADE').IsNull then
          vQueryCloud.ParamByName('CIDADE').AsString := vQueryLocal.FieldByName('CIDADE').AsString;
        if not vQueryLocal.FieldByName('UF').IsNull then
          vQueryCloud.ParamByName('UF').AsString := vQueryLocal.FieldByName('UF').AsString;
        if not vQueryLocal.FieldByName('CNPJ').IsNull then
          vQueryCloud.ParamByName('CNPJ').AsString := vQueryLocal.FieldByName('CNPJ').AsString;
        if not vQueryLocal.FieldByName('TELEFONE').IsNull then
          vQueryCloud.ParamByName('TELEFONE').AsString := vQueryLocal.FieldByName('TELEFONE').AsString;
        if not vQueryLocal.FieldByName('DELETADO').IsNull then
          vQueryCloud.ParamByName('DELETADO').AsString := vQueryLocal.FieldByName('DELETADO').AsString;
        if not vQueryLocal.FieldByName('DATA_INC').IsNull then
          vQueryCloud.ParamByName('DATA_INC').AsDateTime := vQueryLocal.FieldByName('DATA_INC').AsDateTime;
        if not vQueryLocal.FieldByName('USUARIO_I').IsNull then
          vQueryCloud.ParamByName('USUARIO_I').AsString := vQueryLocal.FieldByName('USUARIO_I').AsString;
        if not vQueryLocal.FieldByName('USUARIONOME_I').IsNull then
          vQueryCloud.ParamByName('USUARIONOME_I').AsString := vQueryLocal.FieldByName('USUARIONOME_I').AsString;
        if not vQueryLocal.FieldByName('DATA_ALT').IsNull then
          vQueryCloud.ParamByName('DATA_ALT').AsDateTime := vQueryLocal.FieldByName('DATA_ALT').AsDateTime;
        if not vQueryLocal.FieldByName('USUARIO_A').IsNull then
          vQueryCloud.ParamByName('USUARIO_A').AsString := vQueryLocal.FieldByName('USUARIO_A').AsString;
        if not vQueryLocal.FieldByName('USUARIONOME_A').IsNull then
          vQueryCloud.ParamByName('USUARIONOME_A').AsString := vQueryLocal.FieldByName('USUARIONOME_A').AsString;
        if not vQueryLocal.FieldByName('DATA_DEL').IsNull then
          vQueryCloud.ParamByName('DATA_DEL').AsDateTime := vQueryLocal.FieldByName('DATA_DEL').AsDateTime;
        if not vQueryLocal.FieldByName('USUARIO_D').IsNull then
          vQueryCloud.ParamByName('USUARIO_D').AsString := vQueryLocal.FieldByName('USUARIO_D').AsString;
        if not vQueryLocal.FieldByName('USUARIONOME_D').IsNull then
          vQueryCloud.ParamByName('USUARIONOME_D').AsString := vQueryLocal.FieldByName('USUARIONOME_D').AsString;

        vQueryCloud.ParamByName('SYNC').AsString        := 'N';
        vQueryCloud.ParamByName('SYNC_DATA').AsDateTime := vlData;

        vQueryCloud.ExecSQL;
        vQueryCloud.Transaction.CommitRetaining;

        vQueryUpdateLocal.Close;
        vQueryUpdateLocal.SQL.Clear;
        vQueryUpdateLocal.SQL.Add('UPDATE TBLICITACAO_ORGAO SET SYNC = ''S'', SYNC_DATA = :SYNC_DATA WHERE LICITACAOORGAO_ID = :LICITACAOORGAO_ID');

        vQueryUpdateLocal.ParamByName('SYNC_DATA').AsDateTime := vlData;
        vQueryUpdateLocal.ParamByName('LICITACAOORGAO_ID').AsString := vQueryLocal.FieldByName('LICITACAOORGAO_ID').AsString;

        vQueryUpdateLocal.ExecSQL;
        vQueryUpdateLocal.Transaction.CommitRetaining;

        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-TBLICITACAO_ORGAO Local->Cloud atualizada: ' +
                               Trim(vQueryLocal.FieldByName('LICITACAOORGAO_ID').AsString));
          end);
      except on E: Exception do
        begin
          TThread.Queue(TThread.CurrentThread,
            procedure
            begin
              vMsgErro := FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-Erro ao atualizar TBLICITACAO_ORGAO [' + vQueryLocal.FieldByName('LICITACAOORGAO_ID').AsString + '] Local->Cloud: ' + E.Message;
              logErros(vMsgErro);
              Memo_Log.Lines.Add(vMsgErro);
            end);

          vQueryUpdateLocal.Transaction.RollbackRetaining;
          vQueryCloud.Transaction.RollbackRetaining;

          ALocalDatabase.Connected := False;
          ALocalDatabase.Connected := True;

          ACloudDatabase.Connected := False;
          ACloudDatabase.Connected := True;

          Break;
        end;
      end;

      vQueryLocal.Next;
    end;
  finally
    vQueryLocal.Free;
    vQueryCloud.Free;
    vQueryUpdateLocal.Free;
  end;
end;

procedure TForm_PrincipalServer.pAtualizaPedidoCloudToLocal(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);
var
  vQueryLocal, vQueryCloud, vQueryUpdateCloud: TIBQuery;
  vlData: TDateTime;
begin
  vQueryLocal := TIBQuery.Create(self);
  vQueryCloud := TIBQuery.Create(self);
  vQueryUpdateCloud := TIBQuery.Create(self);

  try
    vQueryLocal.Database := ALocalDatabase;
    vQueryLocal.Transaction := ALocalTransaction;

    vQueryCloud.Database := ACloudDatabase;
    vQueryCloud.Transaction := ACloudTransaction;

    vQueryUpdateCloud.Database := ACloudDatabase;
    vQueryUpdateCloud.Transaction := ACloudTransaction;

    vQueryCloud.Close;
    vQueryCloud.SQL.Text := 'SELECT * FROM TBPEDIDO WHERE SYNC = ''N'' ';
    vQueryCloud.Open;
    vQueryCloud.First;
    while not vQueryCloud.Eof do
    begin
      try
        vlData := Now;
        vQueryLocal.Close;
        vQueryLocal.SQL.Clear;
        vQueryLocal.SQL.Add('UPDATE OR INSERT INTO TBPEDIDO');
        vQueryLocal.SQL.Add('(PEDIDO_ID, DATAWARE, PEDIDO_NUM, ORCAMENTO_ID, EMISSAO, VALIDADE, HORA, SC_ID, COTACAO_ID, CC_ID,');
        vQueryLocal.SQL.Add('ENTRADA_SAIDA, PESSOA_ID, PESSOA_VR, VALOR_PEDIDO, VALOR_FRETE, VALOR_DESPESAS, VALOR_DESCONTO,');
        vQueryLocal.SQL.Add('VALOR_ICMS, BASE_ICMS, VALOR_IPI, BASE_IPI, TRANSPORTADOR_ID, VEICULO_ID, DATA_INC, USUARIO_I,');
        vQueryLocal.SQL.Add('USUARIONOME_I, DATA_ALT, USUARIO_A, USUARIONOME_A, DATA_DEL, USUARIO_D, USUARIONOME_D, USUARIO_ID,');
        vQueryLocal.SQL.Add('EMPRESA_ID, DELETADO, IDENTIFICACAO_PEDIDO, CONDPAGTO_ID, ERP_CONDPAGTO, CONDPAGTO, TIPO_FRETE,');
        vQueryLocal.SQL.Add('VALOR_ITENS, OBS_PEDIDO, ENTREGA_PEDIDO, ID, ANO, REPLICADO, CLIENTE_ID, IMOVEL_ID, WEB_SESSION_ID,');
        vQueryLocal.SQL.Add('FORNECEDOR_ID, REPRESENTADA_ID, REPRESENTADA, CLI_NOME, ERP_CLIENTE, CLI_ENDERECO, CLI_COMPLEMENTO,');
        vQueryLocal.SQL.Add('CLI_BAIRRO, CLI_CEP, CLI_CIDADE, CLI_UF, CLI_TELEFONE, CLI_EMAIL, CLI_TIPO, CLI_CPFCNPJ, CLI_IE,');
        vQueryLocal.SQL.Add('CLI_RGCGF, ERP_ENTREGA, ENT_CPFCNPJ, ENT_NOME, ENT_CONTATO, ENT_ENDERECO, ENT_COMPLEMENTO, ENT_BAIRRO,');
        vQueryLocal.SQL.Add('ENT_CEP, ENT_CIDADE, ENT_UF, ENT_TELEFONE, ENT_EMAIL, ENT_RGCGF, EMPENHO, PROCESSO, PROCESSO_ANO,');
        vQueryLocal.SQL.Add('ORIGEM, IMPRESSO, SITUACAO, DATA_SITUACAO, HPRINT, ERP_VENDEDOR, ERP_VENDEDOR_NOME, ERP_REPRESENTANTE,');
        vQueryLocal.SQL.Add('ERP_REPRESENTANTE_NOME, CODIGO, INTEGRADO, INTEGRADO_DATA, OBS, STATUS, IMPRESSAO_ULTIMA, IMPRESSAO_USUARIO,');
        vQueryLocal.SQL.Add('STATUS_DATA, STATUS_USUARIO, VALOR_ACRESCIMO, TRANSPORTADOR_NOME, TRANSPORTADOR_ENDERECO,');
        vQueryLocal.SQL.Add('TRANSPORTADOR_CIDADE, TRANSPORTADOR_UF, TRANSPORTADOR_BAIRRO, TRANSPORTADOR_CPFCNPJ,');
        vQueryLocal.SQL.Add('TRANSPORTADOR_IERG, TRANSPORTADOR_VALORFRETE, TRANSPORTADOR_VALORSEGURO, TRANSPORTADOR_TELEFONE,');
        vQueryLocal.SQL.Add('TRANSPORTADOR_VEICULO_ID, TRANSPORTADOR_VEICULO, TRANSPORTADOR_CODANTT, TRANSPORTADOR_PLACAVEICULO,');
        vQueryLocal.SQL.Add('TRANSPORTADOR_UFVEICULO, ARQUIVO, EMPENHO_ANO, EMPENHO_COMPLETO, SYNC, SYNC_DATA)');

        vQueryLocal.SQL.Add('VALUES');

        vQueryLocal.SQL.Add('(:PEDIDO_ID, :DATAWARE, :PEDIDO_NUM, :ORCAMENTO_ID, :EMISSAO, :VALIDADE, :HORA, :SC_ID, :COTACAO_ID, :CC_ID,');
        vQueryLocal.SQL.Add(':ENTRADA_SAIDA, :PESSOA_ID, :PESSOA_VR, :VALOR_PEDIDO, :VALOR_FRETE, :VALOR_DESPESAS, :VALOR_DESCONTO,');
        vQueryLocal.SQL.Add(':VALOR_ICMS, :BASE_ICMS, :VALOR_IPI, :BASE_IPI, :TRANSPORTADOR_ID, :VEICULO_ID, :DATA_INC, :USUARIO_I,');
        vQueryLocal.SQL.Add(':USUARIONOME_I, :DATA_ALT, :USUARIO_A, :USUARIONOME_A, :DATA_DEL, :USUARIO_D, :USUARIONOME_D, :USUARIO_ID,');
        vQueryLocal.SQL.Add(':EMPRESA_ID, :DELETADO, :IDENTIFICACAO_PEDIDO, :CONDPAGTO_ID, :ERP_CONDPAGTO, :CONDPAGTO, :TIPO_FRETE,');
        vQueryLocal.SQL.Add(':VALOR_ITENS, :OBS_PEDIDO, :ENTREGA_PEDIDO, :ID, :ANO, :REPLICADO, :CLIENTE_ID, :IMOVEL_ID, :WEB_SESSION_ID,');
        vQueryLocal.SQL.Add(':FORNECEDOR_ID, :REPRESENTADA_ID, :REPRESENTADA, :CLI_NOME, :ERP_CLIENTE, :CLI_ENDERECO, :CLI_COMPLEMENTO,');
        vQueryLocal.SQL.Add(':CLI_BAIRRO, :CLI_CEP, :CLI_CIDADE, :CLI_UF, :CLI_TELEFONE, :CLI_EMAIL, :CLI_TIPO, :CLI_CPFCNPJ, :CLI_IE,');
        vQueryLocal.SQL.Add(':CLI_RGCGF, :ERP_ENTREGA, :ENT_CPFCNPJ, :ENT_NOME, :ENT_CONTATO, :ENT_ENDERECO, :ENT_COMPLEMENTO, :ENT_BAIRRO,');
        vQueryLocal.SQL.Add(':ENT_CEP, :ENT_CIDADE, :ENT_UF, :ENT_TELEFONE, :ENT_EMAIL, :ENT_RGCGF, :EMPENHO, :PROCESSO, :PROCESSO_ANO,');
        vQueryLocal.SQL.Add(':ORIGEM, :IMPRESSO, :SITUACAO, :DATA_SITUACAO, :HPRINT, :ERP_VENDEDOR, :ERP_VENDEDOR_NOME, :ERP_REPRESENTANTE,');
        vQueryLocal.SQL.Add(':ERP_REPRESENTANTE_NOME, :CODIGO, :INTEGRADO, :INTEGRADO_DATA, :OBS, :STATUS, :IMPRESSAO_ULTIMA, :IMPRESSAO_USUARIO,');
        vQueryLocal.SQL.Add(':STATUS_DATA, :STATUS_USUARIO, :VALOR_ACRESCIMO, :TRANSPORTADOR_NOME, :TRANSPORTADOR_ENDERECO,');
        vQueryLocal.SQL.Add(':TRANSPORTADOR_CIDADE, :TRANSPORTADOR_UF, :TRANSPORTADOR_BAIRRO, :TRANSPORTADOR_CPFCNPJ,');
        vQueryLocal.SQL.Add(':TRANSPORTADOR_IERG, :TRANSPORTADOR_VALORFRETE, :TRANSPORTADOR_VALORSEGURO, :TRANSPORTADOR_TELEFONE,');
        vQueryLocal.SQL.Add(':TRANSPORTADOR_VEICULO_ID, :TRANSPORTADOR_VEICULO, :TRANSPORTADOR_CODANTT, :TRANSPORTADOR_PLACAVEICULO,');
        vQueryLocal.SQL.Add(':TRANSPORTADOR_UFVEICULO, :ARQUIVO, :EMPENHO_ANO, :EMPENHO_COMPLETO, :SYNC, :SYNC_DATA)');

        vQueryLocal.SQL.Add('MATCHING (PEDIDO_ID)');

        // Parametros
        vQueryLocal.ParamByName('PEDIDO_ID').AsInteger    := vQueryCloud.FieldByName('PEDIDO_ID').AsInteger;
        vQueryLocal.ParamByName('DATAWARE').AsString      := Trim(vQueryCloud.FieldByName('DATAWARE').AsString);
        vQueryLocal.ParamByName('PEDIDO_NUM').AsString    := Trim(vQueryCloud.FieldByName('PEDIDO_NUM').AsString);
        vQueryLocal.ParamByName('ORCAMENTO_ID').AsInteger := vQueryCloud.FieldByName('ORCAMENTO_ID').AsInteger;
        vQueryLocal.ParamByName('EMISSAO').AsDateTime     := vQueryCloud.FieldByName('EMISSAO').AsDateTime;
        vQueryLocal.ParamByName('VALIDADE').AsDateTime    := vQueryCloud.FieldByName('VALIDADE').AsDateTime;
        vQueryLocal.ParamByName('HORA').AsTime            := vQueryCloud.FieldByName('HORA').AsDateTime;
        vQueryLocal.ParamByName('SC_ID').AsInteger        := vQueryCloud.FieldByName('SC_ID').AsInteger;
        vQueryLocal.ParamByName('COTACAO_ID').AsInteger   := vQueryCloud.FieldByName('COTACAO_ID').AsInteger;
        vQueryLocal.ParamByName('CC_ID').AsInteger        := vQueryCloud.FieldByName('CC_ID').AsInteger;
        vQueryLocal.ParamByName('ENTRADA_SAIDA').AsString := Trim(vQueryCloud.FieldByName('ENTRADA_SAIDA').AsString);
        vQueryLocal.ParamByName('PESSOA_ID').AsInteger    := vQueryCloud.FieldByName('PESSOA_ID').AsInteger;
        vQueryLocal.ParamByName('PESSOA_VR').AsInteger    := vQueryCloud.FieldByName('PESSOA_VR').AsInteger;
        vQueryLocal.ParamByName('VALOR_PEDIDO').AsFloat   := vQueryCloud.FieldByName('VALOR_PEDIDO').AsFloat;
        vQueryLocal.ParamByName('VALOR_FRETE').AsFloat    := vQueryCloud.FieldByName('VALOR_FRETE').AsFloat;
        vQueryLocal.ParamByName('VALOR_DESPESAS').AsFloat := vQueryCloud.FieldByName('VALOR_DESPESAS').AsFloat;
        vQueryLocal.ParamByName('VALOR_DESCONTO').AsFloat := vQueryCloud.FieldByName('VALOR_DESCONTO').AsFloat;
        vQueryLocal.ParamByName('VALOR_ICMS').AsFloat     := vQueryCloud.FieldByName('VALOR_ICMS').AsFloat;
        vQueryLocal.ParamByName('BASE_ICMS').AsFloat      := vQueryCloud.FieldByName('BASE_ICMS').AsFloat;
        vQueryLocal.ParamByName('VALOR_IPI').AsFloat      := vQueryCloud.FieldByName('VALOR_IPI').AsFloat;
        vQueryLocal.ParamByName('BASE_IPI').AsFloat       := vQueryCloud.FieldByName('BASE_IPI').AsFloat;
        vQueryLocal.ParamByName('TRANSPORTADOR_ID').AsInteger := vQueryCloud.FieldByName('TRANSPORTADOR_ID').AsInteger;
        vQueryLocal.ParamByName('VEICULO_ID').AsInteger   := vQueryCloud.FieldByName('VEICULO_ID').AsInteger;
        vQueryLocal.ParamByName('DATA_INC').AsDateTime    := vQueryCloud.FieldByName('DATA_INC').AsDateTime;
        vQueryLocal.ParamByName('USUARIO_I').AsInteger    := vQueryCloud.FieldByName('USUARIO_I').AsInteger;
        vQueryLocal.ParamByName('USUARIONOME_I').AsString := Trim(vQueryCloud.FieldByName('USUARIONOME_I').AsString);
        vQueryLocal.ParamByName('DATA_ALT').AsDateTime    := vQueryCloud.FieldByName('DATA_ALT').AsDateTime;
        vQueryLocal.ParamByName('USUARIO_A').AsInteger    := vQueryCloud.FieldByName('USUARIO_A').AsInteger;
        vQueryLocal.ParamByName('USUARIONOME_A').AsString := Trim(vQueryCloud.FieldByName('USUARIONOME_A').AsString);
        vQueryLocal.ParamByName('DATA_DEL').AsDateTime    := vQueryCloud.FieldByName('DATA_DEL').AsDateTime;
        vQueryLocal.ParamByName('USUARIO_D').AsInteger    := vQueryCloud.FieldByName('USUARIO_D').AsInteger;
        vQueryLocal.ParamByName('USUARIONOME_D').AsString := Trim(vQueryCloud.FieldByName('USUARIONOME_D').AsString);
        vQueryLocal.ParamByName('USUARIO_ID').AsInteger   := vQueryCloud.FieldByName('USUARIO_ID').AsInteger;
        vQueryLocal.ParamByName('EMPRESA_ID').AsInteger   := vQueryCloud.FieldByName('EMPRESA_ID').AsInteger;
        vQueryLocal.ParamByName('DELETADO').AsString      := Trim(vQueryCloud.FieldByName('DELETADO').AsString);
        vQueryLocal.ParamByName('IDENTIFICACAO_PEDIDO').AsString := Trim(vQueryCloud.FieldByName('IDENTIFICACAO_PEDIDO').AsString);
        vQueryLocal.ParamByName('CONDPAGTO_ID').AsInteger  := vQueryCloud.FieldByName('CONDPAGTO_ID').AsInteger;
        vQueryLocal.ParamByName('ERP_CONDPAGTO').AsInteger := vQueryCloud.FieldByName('ERP_CONDPAGTO').AsInteger;
        vQueryLocal.ParamByName('CONDPAGTO').AsString  := Trim(vQueryCloud.FieldByName('CONDPAGTO').AsString);
        vQueryLocal.ParamByName('TIPO_FRETE').AsString := Trim(vQueryCloud.FieldByName('TIPO_FRETE').AsString);
        vQueryLocal.ParamByName('VALOR_ITENS').AsFloat := vQueryCloud.FieldByName('VALOR_ITENS').AsFloat;
        vQueryLocal.ParamByName('OBS_PEDIDO').AsString := Trim(vQueryCloud.FieldByName('OBS_PEDIDO').AsString);
        vQueryLocal.ParamByName('ENTREGA_PEDIDO').AsDateTime := vQueryCloud.FieldByName('ENTREGA_PEDIDO').AsDateTime;
        vQueryLocal.ParamByName('ID').AsInteger := vQueryCloud.FieldByName('ID').AsInteger;
        vQueryLocal.ParamByName('ANO').AsString := Trim(vQueryCloud.FieldByName('ANO').AsString);
        vQueryLocal.ParamByName('REPLICADO').AsString := Trim(vQueryCloud.FieldByName('REPLICADO').AsString);
        vQueryLocal.ParamByName('CLIENTE_ID').AsInteger := vQueryCloud.FieldByName('CLIENTE_ID').AsInteger;
        vQueryLocal.ParamByName('IMOVEL_ID').AsInteger := vQueryCloud.FieldByName('IMOVEL_ID').AsInteger;
        vQueryLocal.ParamByName('WEB_SESSION_ID').AsString := Trim(vQueryCloud.FieldByName('WEB_SESSION_ID').AsString);
        vQueryLocal.ParamByName('FORNECEDOR_ID').AsInteger := vQueryCloud.FieldByName('FORNECEDOR_ID').AsInteger;
        vQueryLocal.ParamByName('REPRESENTADA_ID').AsInteger := vQueryCloud.FieldByName('REPRESENTADA_ID').AsInteger;
        vQueryLocal.ParamByName('REPRESENTADA').AsString := Trim(vQueryCloud.FieldByName('REPRESENTADA').AsString);
        vQueryLocal.ParamByName('CLI_NOME').AsString := Trim(vQueryCloud.FieldByName('CLI_NOME').AsString);
        vQueryLocal.ParamByName('ERP_CLIENTE').AsString := Trim(vQueryCloud.FieldByName('ERP_CLIENTE').AsString);
        vQueryLocal.ParamByName('CLI_ENDERECO').AsString := Trim(vQueryCloud.FieldByName('CLI_ENDERECO').AsString);
        vQueryLocal.ParamByName('CLI_COMPLEMENTO').AsString := Trim(vQueryCloud.FieldByName('CLI_COMPLEMENTO').AsString);
        vQueryLocal.ParamByName('CLI_BAIRRO').AsString := Trim(vQueryCloud.FieldByName('CLI_BAIRRO').AsString);
        vQueryLocal.ParamByName('CLI_CEP').AsString := Trim(vQueryCloud.FieldByName('CLI_CEP').AsString);
        vQueryLocal.ParamByName('CLI_CIDADE').AsString := Trim(vQueryCloud.FieldByName('CLI_CIDADE').AsString);
        vQueryLocal.ParamByName('CLI_UF').AsString := Trim(vQueryCloud.FieldByName('CLI_UF').AsString);
        vQueryLocal.ParamByName('CLI_TELEFONE').AsString := Trim(vQueryCloud.FieldByName('CLI_TELEFONE').AsString);
        vQueryLocal.ParamByName('CLI_EMAIL').AsString := Trim(vQueryCloud.FieldByName('CLI_EMAIL').AsString);
        vQueryLocal.ParamByName('CLI_TIPO').AsString := Trim(vQueryCloud.FieldByName('CLI_TIPO').AsString);
        vQueryLocal.ParamByName('CLI_CPFCNPJ').AsString := Trim(vQueryCloud.FieldByName('CLI_CPFCNPJ').AsString);
        vQueryLocal.ParamByName('CLI_IE').AsString := Trim(vQueryCloud.FieldByName('CLI_IE').AsString);
        vQueryLocal.ParamByName('CLI_RGCGF').AsString := Trim(vQueryCloud.FieldByName('CLI_RGCGF').AsString);
        vQueryLocal.ParamByName('ERP_ENTREGA').AsString := Trim(vQueryCloud.FieldByName('ERP_ENTREGA').AsString);
        vQueryLocal.ParamByName('ENT_CPFCNPJ').AsString := Trim(vQueryCloud.FieldByName('ENT_CPFCNPJ').AsString);
        vQueryLocal.ParamByName('ENT_NOME').AsString := Trim(vQueryCloud.FieldByName('ENT_NOME').AsString);
        vQueryLocal.ParamByName('ENT_CONTATO').AsString := Trim(vQueryCloud.FieldByName('ENT_CONTATO').AsString);
        vQueryLocal.ParamByName('ENT_ENDERECO').AsString := Trim(vQueryCloud.FieldByName('ENT_ENDERECO').AsString);
        vQueryLocal.ParamByName('ENT_COMPLEMENTO').AsString := Trim(vQueryCloud.FieldByName('ENT_COMPLEMENTO').AsString);
        vQueryLocal.ParamByName('ENT_BAIRRO').AsString := Trim(vQueryCloud.FieldByName('ENT_BAIRRO').AsString);
        vQueryLocal.ParamByName('ENT_CEP').AsString := Trim(vQueryCloud.FieldByName('ENT_CEP').AsString);
        vQueryLocal.ParamByName('ENT_CIDADE').AsString := Trim(vQueryCloud.FieldByName('ENT_CIDADE').AsString);
        vQueryLocal.ParamByName('ENT_UF').AsString := Trim(vQueryCloud.FieldByName('ENT_UF').AsString);
        vQueryLocal.ParamByName('ENT_TELEFONE').AsString := Trim(vQueryCloud.FieldByName('ENT_TELEFONE').AsString);
        vQueryLocal.ParamByName('ENT_EMAIL').AsString := Trim(vQueryCloud.FieldByName('ENT_EMAIL').AsString);
        vQueryLocal.ParamByName('ENT_RGCGF').AsString := Trim(vQueryCloud.FieldByName('ENT_RGCGF').AsString);
        vQueryLocal.ParamByName('EMPENHO').AsString := Trim(vQueryCloud.FieldByName('EMPENHO').AsString);
        vQueryLocal.ParamByName('PROCESSO').AsString := Trim(vQueryCloud.FieldByName('PROCESSO').AsString);
        vQueryLocal.ParamByName('PROCESSO_ANO').AsString := Trim(vQueryCloud.FieldByName('PROCESSO_ANO').AsString);
        vQueryLocal.ParamByName('ORIGEM').AsString := Trim(vQueryCloud.FieldByName('ORIGEM').AsString);
        vQueryLocal.ParamByName('IMPRESSO').AsString := Trim(vQueryCloud.FieldByName('IMPRESSO').AsString);
        vQueryLocal.ParamByName('SITUACAO').AsString := Trim(vQueryCloud.FieldByName('SITUACAO').AsString);
        vQueryLocal.ParamByName('DATA_SITUACAO').AsDateTime := vQueryCloud.FieldByName('DATA_SITUACAO').AsDateTime;
        vQueryLocal.ParamByName('HPRINT').AsDateTime := vQueryCloud.FieldByName('HPRINT').AsDateTime;
        vQueryLocal.ParamByName('ERP_VENDEDOR').AsString := Trim(vQueryCloud.FieldByName('ERP_VENDEDOR').AsString);
        vQueryLocal.ParamByName('ERP_VENDEDOR_NOME').AsString := Trim(vQueryCloud.FieldByName('ERP_VENDEDOR_NOME').AsString);
        vQueryLocal.ParamByName('ERP_REPRESENTANTE').AsString := Trim(vQueryCloud.FieldByName('ERP_REPRESENTANTE').AsString);
        vQueryLocal.ParamByName('ERP_REPRESENTANTE_NOME').AsString := Trim(vQueryCloud.FieldByName('ERP_REPRESENTANTE_NOME').AsString);
        vQueryLocal.ParamByName('CODIGO').AsString := Trim(vQueryCloud.FieldByName('CODIGO').AsString);
        vQueryLocal.ParamByName('INTEGRADO').AsString := Trim(vQueryCloud.FieldByName('INTEGRADO').AsString);
        vQueryLocal.ParamByName('INTEGRADO_DATA').AsDateTime := vQueryCloud.FieldByName('INTEGRADO_DATA').AsDateTime;
        vQueryLocal.ParamByName('OBS').AsString := Trim(vQueryCloud.FieldByName('OBS').AsString);
        vQueryLocal.ParamByName('STATUS').AsString := Trim(vQueryCloud.FieldByName('STATUS').AsString);
        vQueryLocal.ParamByName('IMPRESSAO_ULTIMA').AsDateTime := vQueryCloud.FieldByName('IMPRESSAO_ULTIMA').AsDateTime;
        vQueryLocal.ParamByName('IMPRESSAO_USUARIO').AsString := Trim(vQueryCloud.FieldByName('IMPRESSAO_USUARIO').AsString);
        vQueryLocal.ParamByName('STATUS_DATA').AsDateTime := vQueryCloud.FieldByName('STATUS_DATA').AsDateTime;
        vQueryLocal.ParamByName('STATUS_USUARIO').AsString := Trim(vQueryCloud.FieldByName('STATUS_USUARIO').AsString);
        vQueryLocal.ParamByName('VALOR_ACRESCIMO').AsFloat := vQueryCloud.FieldByName('VALOR_ACRESCIMO').AsFloat;
        vQueryLocal.ParamByName('TRANSPORTADOR_NOME').AsString := Trim(vQueryCloud.FieldByName('TRANSPORTADOR_NOME').AsString);
        vQueryLocal.ParamByName('TRANSPORTADOR_ENDERECO').AsString := Trim(vQueryCloud.FieldByName('TRANSPORTADOR_ENDERECO').AsString);
        vQueryLocal.ParamByName('TRANSPORTADOR_CIDADE').AsString := Trim(vQueryCloud.FieldByName('TRANSPORTADOR_CIDADE').AsString);
        vQueryLocal.ParamByName('TRANSPORTADOR_UF').AsString := Trim(vQueryCloud.FieldByName('TRANSPORTADOR_UF').AsString);
        vQueryLocal.ParamByName('TRANSPORTADOR_BAIRRO').AsString := Trim(vQueryCloud.FieldByName('TRANSPORTADOR_BAIRRO').AsString);
        vQueryLocal.ParamByName('TRANSPORTADOR_CPFCNPJ').AsString := Trim(vQueryCloud.FieldByName('TRANSPORTADOR_CPFCNPJ').AsString);
        vQueryLocal.ParamByName('TRANSPORTADOR_IERG').AsString := Trim(vQueryCloud.FieldByName('TRANSPORTADOR_IERG').AsString);
        vQueryLocal.ParamByName('TRANSPORTADOR_VALORFRETE').AsFloat := vQueryCloud.FieldByName('TRANSPORTADOR_VALORFRETE').AsFloat;
        vQueryLocal.ParamByName('TRANSPORTADOR_VALORSEGURO').AsFloat := vQueryCloud.FieldByName('TRANSPORTADOR_VALORSEGURO').AsFloat;
        vQueryLocal.ParamByName('TRANSPORTADOR_TELEFONE').AsString := Trim(vQueryCloud.FieldByName('TRANSPORTADOR_TELEFONE').AsString);
        vQueryLocal.ParamByName('TRANSPORTADOR_VEICULO_ID').AsInteger := vQueryCloud.FieldByName('TRANSPORTADOR_VEICULO_ID').AsInteger;
        vQueryLocal.ParamByName('TRANSPORTADOR_VEICULO').AsString := Trim(vQueryCloud.FieldByName('TRANSPORTADOR_VEICULO').AsString);
        vQueryLocal.ParamByName('TRANSPORTADOR_CODANTT').AsString := Trim(vQueryCloud.FieldByName('TRANSPORTADOR_CODANTT').AsString);
        vQueryLocal.ParamByName('TRANSPORTADOR_PLACAVEICULO').AsString := Trim(vQueryCloud.FieldByName('TRANSPORTADOR_PLACAVEICULO').AsString);
        vQueryLocal.ParamByName('TRANSPORTADOR_UFVEICULO').AsString := Trim(vQueryCloud.FieldByName('TRANSPORTADOR_UFVEICULO').AsString);
        vQueryLocal.ParamByName('ARQUIVO').AsString := Trim(vQueryCloud.FieldByName('ARQUIVO').AsString);
        vQueryLocal.ParamByName('EMPENHO_ANO').AsString := Trim(vQueryCloud.FieldByName('EMPENHO_ANO').AsString);
        vQueryLocal.ParamByName('EMPENHO_COMPLETO').AsString := Trim(vQueryCloud.FieldByName('EMPENHO_COMPLETO').AsString);
        vQueryLocal.ParamByName('SYNC').AsString := 'S';
        vQueryLocal.ParamByName('SYNC_DATA').AsDateTime := vlData;

        vQueryLocal.ExecSQL;
        vQueryLocal.Transaction.CommitRetaining;

        vQueryUpdateCloud.Close;
        vQueryUpdateCloud.SQL.Clear;
        vQueryUpdateCloud.SQL.Add('UPDATE TBPEDIDO SET SYNC = ''S'', SYNC_DATA = :SYNC_DATA WHERE PEDIDO_ID = :PEDIDO_ID');

        vQueryUpdateCloud.ParamByName('SYNC_DATA').AsDateTime := vlData;
        vQueryUpdateCloud.ParamByName('PEDIDO_ID').AsInteger := vQueryCloud.FieldByName('PEDIDO_ID').AsInteger;

        vQueryUpdateCloud.ExecSQL;
        vQueryUpdateCloud.Transaction.CommitRetaining;

        Memo_Log.Lines.Add('Pedido atualizado em ' + FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ': ' +
                           Trim(vQueryCloud.FieldByName('PEDIDO_ID').AsString) + ' - ' + Trim(vQueryCloud.FieldByName('PEDIDO_NUM').AsString));
      except
        on E: Exception do
        begin
          Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ' - Erro ao atualizar Pedido: ' + E.Message);
          vQueryLocal.Transaction.RollbackRetaining;
          dm1.IBDatabase1.Connected := False;
          dm1.IBDatabase1.Connected := True;

          dm1.IBDatabaseCloudSICFAR.Connected := False;
          dm1.IBDatabaseCloudSICFAR.Connected := True;
        end;
      end;

      vQueryCloud.Next;
      Application.ProcessMessages;
    end;
  finally
    vQueryLocal.Free;
    vQueryCloud.Free;
    vQueryUpdateCloud.Free;
  end;
end;

procedure TForm_PrincipalServer.pAtualizaPedidoItemCloudToLocal(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);
var
  vQueryLocal, vQueryCloud, vQueryUpdateCloud: TIBQuery;
  vlData: TDateTime;
begin
  vQueryLocal := TIBQuery.Create(self);
  vQueryCloud := TIBQuery.Create(self);
  vQueryUpdateCloud := TIBQuery.Create(self);

  try
    vQueryLocal.Database := ALocalDatabase;
    vQueryLocal.Transaction := ALocalTransaction;

    vQueryCloud.Database := ACloudDatabase;
    vQueryCloud.Transaction := ACloudTransaction;

    vQueryUpdateCloud.Database := ACloudDatabase;
    vQueryUpdateCloud.Transaction := ACloudTransaction;

    vQueryCloud.Close;
    vQueryCloud.SQL.Text := 'SELECT * FROM TBPEDIDO_ITEM WHERE SYNC = ''N''';
    vQueryCloud.Open;
    vQueryCloud.First;
    while not vQueryCloud.Eof do
    begin
      try
        vlData := Now;
        vQueryLocal.Close;
        vQueryLocal.SQL.Clear;
        vQueryLocal.SQL.Add('UPDATE OR INSERT INTO TBPEDIDO_ITEM');
        vQueryLocal.SQL.Add('(PEDIDOITEM_ID, DATAWARE, PEDIDO_ID, PRODUTO_ID, ORCAMENTO_ID, ORCAMENTOITEM_ID, PESSOA_ID, DATA, ITEM, ERP_PRODUTO,');
        vQueryLocal.SQL.Add('PRODUTO, QUANTIDADE, IPI, ICMS, PRECO, SUBTOTAL, BASE_ICMS, BASE_IPI, VALOR_ICMS, VALOR_IPI,');
        vQueryLocal.SQL.Add('ESTOQUE_ID, COMISSAO, VALOR_DESCONTO, VALOR_ACRESCIMO, CC_ID, APLICACAO_ID, COTACAO_ID, DEPARTAMENTO_ID, SC_ID,');
        vQueryLocal.SQL.Add('ITEMSC_ID, DATA_INC, USUARIO_I, USUARIONOME_I, DATA_ALT, USUARIO_A, USUARIONOME_A, DATA_DEL, USUARIO_D,');
        vQueryLocal.SQL.Add('USUARIONOME_D, USUARIO_ID, EMPRESA_ID, DELETADO, PRAZO, MARCA, COTACAOITEM_ID, ENTREGA_PEDITEM, REPLICADO,');
        vQueryLocal.SQL.Add('TOTAL, WEB_SESSION_ID, FORNECEDOR_ID, QTDE, QTDE_ENTREGA, GERA_ESTOQUE, INTEGRADO, INTEGRADO_DATA, PEDIDO_CODIGO,');
        vQueryLocal.SQL.Add('STATUS, LOTE, OBS, STATUS_DATA, STATUS_USUARIO, CENTRO_CUSTO, DEPARTAMENTO, APLICACAO, ENTREGUE_TIPO, ENTREGUE_DATA,');
        vQueryLocal.SQL.Add('ENTREGUE_USUARIO, ENTREGUE_USUARIONOME, ENTREGUE_OBS, TIPO_FRETE, VALOR_FRETE, NF, NF_SERIE, NF_CHAVE, DESCONTO, SYNC, SYNC_DATA)');
        vQueryLocal.SQL.Add('VALUES');
        vQueryLocal.SQL.Add('(:PEDIDOITEM_ID, :DATAWARE, :PEDIDO_ID, :PRODUTO_ID, :ORCAMENTO_ID, :ORCAMENTOITEM_ID, :PESSOA_ID, :DATA, :ITEM, :ERP_PRODUTO,');
        vQueryLocal.SQL.Add(':PRODUTO, :QUANTIDADE, :IPI, :ICMS, :PRECO, :SUBTOTAL, :BASE_ICMS, :BASE_IPI, :VALOR_ICMS, :VALOR_IPI,');
        vQueryLocal.SQL.Add(':ESTOQUE_ID, :COMISSAO, :VALOR_DESCONTO, :VALOR_ACRESCIMO, :CC_ID, :APLICACAO_ID, :COTACAO_ID, :DEPARTAMENTO_ID, :SC_ID,');
        vQueryLocal.SQL.Add(':ITEMSC_ID, :DATA_INC, :USUARIO_I, :USUARIONOME_I, :DATA_ALT, :USUARIO_A, :USUARIONOME_A, :DATA_DEL, :USUARIO_D,');
        vQueryLocal.SQL.Add(':USUARIONOME_D, :USUARIO_ID, :EMPRESA_ID, :DELETADO, :PRAZO, :MARCA, :COTACAOITEM_ID, :ENTREGA_PEDITEM, :REPLICADO,');
        vQueryLocal.SQL.Add(':TOTAL, :WEB_SESSION_ID, :FORNECEDOR_ID, :QTDE, :QTDE_ENTREGA, :GERA_ESTOQUE, :INTEGRADO, :INTEGRADO_DATA, :PEDIDO_CODIGO,');
        vQueryLocal.SQL.Add(':STATUS, :LOTE, :OBS, :STATUS_DATA, :STATUS_USUARIO, :CENTRO_CUSTO, :DEPARTAMENTO, :APLICACAO, :ENTREGUE_TIPO, :ENTREGUE_DATA,');
        vQueryLocal.SQL.Add(':ENTREGUE_USUARIO, :ENTREGUE_USUARIONOME, :ENTREGUE_OBS, :TIPO_FRETE, :VALOR_FRETE, :NF, :NF_SERIE, :NF_CHAVE, :DESCONTO, :SYNC, :SYNC_DATA)');
        vQueryLocal.SQL.Add('MATCHING (PEDIDOITEM_ID)');

        // Parametros
        vQueryLocal.ParamByName('PEDIDOITEM_ID').AsInteger := vQueryCloud.FieldByName('PEDIDOITEM_ID').AsInteger;
        vQueryLocal.ParamByName('DATAWARE').AsString := Trim(vQueryCloud.FieldByName('DATAWARE').AsString);
        vQueryLocal.ParamByName('PEDIDO_ID').AsInteger := vQueryCloud.FieldByName('PEDIDO_ID').AsInteger;
        vQueryLocal.ParamByName('PRODUTO_ID').AsInteger := vQueryCloud.FieldByName('PRODUTO_ID').AsInteger;
        vQueryLocal.ParamByName('ORCAMENTO_ID').AsInteger := vQueryCloud.FieldByName('ORCAMENTO_ID').AsInteger;
        vQueryLocal.ParamByName('ORCAMENTOITEM_ID').AsInteger := vQueryCloud.FieldByName('ORCAMENTOITEM_ID').AsInteger;
        vQueryLocal.ParamByName('PESSOA_ID').AsInteger := vQueryCloud.FieldByName('PESSOA_ID').AsInteger;
        vQueryLocal.ParamByName('DATA').AsDateTime := vQueryCloud.FieldByName('DATA').AsDateTime;
        vQueryLocal.ParamByName('ITEM').AsString := Trim(vQueryCloud.FieldByName('ITEM').AsString);
        vQueryLocal.ParamByName('ERP_PRODUTO').AsString := Trim(vQueryCloud.FieldByName('ERP_PRODUTO').AsString);
        vQueryLocal.ParamByName('PRODUTO').AsString := Trim(vQueryCloud.FieldByName('PRODUTO').AsString);
        vQueryLocal.ParamByName('QUANTIDADE').AsFloat := vQueryCloud.FieldByName('QUANTIDADE').AsFloat;
        vQueryLocal.ParamByName('IPI').AsFloat := vQueryCloud.FieldByName('IPI').AsFloat;
        vQueryLocal.ParamByName('ICMS').AsFloat := vQueryCloud.FieldByName('ICMS').AsFloat;
        vQueryLocal.ParamByName('PRECO').AsFloat := vQueryCloud.FieldByName('PRECO').AsFloat;
        vQueryLocal.ParamByName('SUBTOTAL').AsFloat := vQueryCloud.FieldByName('SUBTOTAL').AsFloat;
        vQueryLocal.ParamByName('BASE_ICMS').AsFloat := vQueryCloud.FieldByName('BASE_ICMS').AsFloat;
        vQueryLocal.ParamByName('BASE_IPI').AsFloat := vQueryCloud.FieldByName('BASE_IPI').AsFloat;
        vQueryLocal.ParamByName('VALOR_ICMS').AsFloat := vQueryCloud.FieldByName('VALOR_ICMS').AsFloat;
        vQueryLocal.ParamByName('VALOR_IPI').AsFloat := vQueryCloud.FieldByName('VALOR_IPI').AsFloat;
        vQueryLocal.ParamByName('ESTOQUE_ID').AsInteger := vQueryCloud.FieldByName('ESTOQUE_ID').AsInteger;
        vQueryLocal.ParamByName('COMISSAO').AsFloat := vQueryCloud.FieldByName('COMISSAO').AsFloat;
        vQueryLocal.ParamByName('VALOR_DESCONTO').AsFloat := vQueryCloud.FieldByName('VALOR_DESCONTO').AsFloat;
        vQueryLocal.ParamByName('VALOR_ACRESCIMO').AsFloat := vQueryCloud.FieldByName('VALOR_ACRESCIMO').AsFloat;
        vQueryLocal.ParamByName('CC_ID').AsInteger := vQueryCloud.FieldByName('CC_ID').AsInteger;
        vQueryLocal.ParamByName('APLICACAO_ID').AsInteger := vQueryCloud.FieldByName('APLICACAO_ID').AsInteger;
        vQueryLocal.ParamByName('COTACAO_ID').AsInteger := vQueryCloud.FieldByName('COTACAO_ID').AsInteger;
        vQueryLocal.ParamByName('DEPARTAMENTO_ID').AsInteger := vQueryCloud.FieldByName('DEPARTAMENTO_ID').AsInteger;
        vQueryLocal.ParamByName('SC_ID').AsInteger := vQueryCloud.FieldByName('SC_ID').AsInteger;
        vQueryLocal.ParamByName('ITEMSC_ID').AsInteger := vQueryCloud.FieldByName('ITEMSC_ID').AsInteger;
        vQueryLocal.ParamByName('DATA_INC').AsDateTime := vQueryCloud.FieldByName('DATA_INC').AsDateTime;
        vQueryLocal.ParamByName('USUARIO_I').AsInteger := vQueryCloud.FieldByName('USUARIO_I').AsInteger;
        vQueryLocal.ParamByName('USUARIONOME_I').AsString := Trim(vQueryCloud.FieldByName('USUARIONOME_I').AsString);
        vQueryLocal.ParamByName('DATA_ALT').AsDateTime := vQueryCloud.FieldByName('DATA_ALT').AsDateTime;
        vQueryLocal.ParamByName('USUARIO_A').AsInteger := vQueryCloud.FieldByName('USUARIO_A').AsInteger;
        vQueryLocal.ParamByName('USUARIONOME_A').AsString := Trim(vQueryCloud.FieldByName('USUARIONOME_A').AsString);
        vQueryLocal.ParamByName('DATA_DEL').AsDateTime := vQueryCloud.FieldByName('DATA_DEL').AsDateTime;
        vQueryLocal.ParamByName('USUARIO_D').AsInteger := vQueryCloud.FieldByName('USUARIO_D').AsInteger;
        vQueryLocal.ParamByName('USUARIONOME_D').AsString := Trim(vQueryCloud.FieldByName('USUARIONOME_D').AsString);
        vQueryLocal.ParamByName('USUARIO_ID').AsInteger := vQueryCloud.FieldByName('USUARIO_ID').AsInteger;
        vQueryLocal.ParamByName('EMPRESA_ID').AsInteger := vQueryCloud.FieldByName('EMPRESA_ID').AsInteger;
        vQueryLocal.ParamByName('DELETADO').AsString := Trim(vQueryCloud.FieldByName('DELETADO').AsString);
        vQueryLocal.ParamByName('PRAZO').AsInteger := vQueryCloud.FieldByName('PRAZO').AsInteger;
        vQueryLocal.ParamByName('MARCA').AsString := Trim(vQueryCloud.FieldByName('MARCA').AsString);
        vQueryLocal.ParamByName('COTACAOITEM_ID').AsInteger := vQueryCloud.FieldByName('COTACAOITEM_ID').AsInteger;
        vQueryLocal.ParamByName('ENTREGA_PEDITEM').AsDateTime := vQueryCloud.FieldByName('ENTREGA_PEDITEM').AsDateTime;
        vQueryLocal.ParamByName('REPLICADO').AsString := Trim(vQueryCloud.FieldByName('REPLICADO').AsString);
        vQueryLocal.ParamByName('TOTAL').AsFloat := vQueryCloud.FieldByName('TOTAL').AsFloat;
        vQueryLocal.ParamByName('WEB_SESSION_ID').AsString := Trim(vQueryCloud.FieldByName('WEB_SESSION_ID').AsString);
        vQueryLocal.ParamByName('FORNECEDOR_ID').AsInteger := vQueryCloud.FieldByName('FORNECEDOR_ID').AsInteger;
        vQueryLocal.ParamByName('QTDE').AsFloat := vQueryCloud.FieldByName('QTDE').AsFloat;
        vQueryLocal.ParamByName('QTDE_ENTREGA').AsFloat := vQueryCloud.FieldByName('QTDE_ENTREGA').AsFloat;
        vQueryLocal.ParamByName('GERA_ESTOQUE').AsString := Trim(vQueryCloud.FieldByName('GERA_ESTOQUE').AsString);
        vQueryLocal.ParamByName('INTEGRADO').AsString := Trim(vQueryCloud.FieldByName('INTEGRADO').AsString);
        vQueryLocal.ParamByName('INTEGRADO_DATA').AsDateTime := vQueryCloud.FieldByName('INTEGRADO_DATA').AsDateTime;
        vQueryLocal.ParamByName('PEDIDO_CODIGO').AsString := Trim(vQueryCloud.FieldByName('PEDIDO_CODIGO').AsString);
        vQueryLocal.ParamByName('STATUS').AsString := Trim(vQueryCloud.FieldByName('STATUS').AsString);
        vQueryLocal.ParamByName('LOTE').AsString := Trim(vQueryCloud.FieldByName('LOTE').AsString);
        vQueryLocal.ParamByName('OBS').AsString := vQueryCloud.FieldByName('OBS').AsString;
        vQueryLocal.ParamByName('STATUS_DATA').AsDateTime := vQueryCloud.FieldByName('STATUS_DATA').AsDateTime;
        vQueryLocal.ParamByName('STATUS_USUARIO').AsString := Trim(vQueryCloud.FieldByName('STATUS_USUARIO').AsString);
        vQueryLocal.ParamByName('CENTRO_CUSTO').AsString := Trim(vQueryCloud.FieldByName('CENTRO_CUSTO').AsString);
        vQueryLocal.ParamByName('DEPARTAMENTO').AsString := Trim(vQueryCloud.FieldByName('DEPARTAMENTO').AsString);
        vQueryLocal.ParamByName('APLICACAO').AsString := Trim(vQueryCloud.FieldByName('APLICACAO').AsString);
        vQueryLocal.ParamByName('ENTREGUE_TIPO').AsString := Trim(vQueryCloud.FieldByName('ENTREGUE_TIPO').AsString);
        vQueryLocal.ParamByName('ENTREGUE_DATA').AsDateTime := vQueryCloud.FieldByName('ENTREGUE_DATA').AsDateTime;
        vQueryLocal.ParamByName('ENTREGUE_USUARIO').AsInteger := vQueryCloud.FieldByName('ENTREGUE_USUARIO').AsInteger;
        vQueryLocal.ParamByName('ENTREGUE_USUARIONOME').AsString := Trim(vQueryCloud.FieldByName('ENTREGUE_USUARIONOME').AsString);
        vQueryLocal.ParamByName('ENTREGUE_OBS').AsString := Trim(vQueryCloud.FieldByName('ENTREGUE_OBS').AsString);
        vQueryLocal.ParamByName('TIPO_FRETE').AsString := Trim(vQueryCloud.FieldByName('TIPO_FRETE').AsString);
        vQueryLocal.ParamByName('VALOR_FRETE').AsFloat := vQueryCloud.FieldByName('VALOR_FRETE').AsFloat;
        vQueryLocal.ParamByName('NF').AsString := Trim(vQueryCloud.FieldByName('NF').AsString);
        vQueryLocal.ParamByName('NF_SERIE').AsString := Trim(vQueryCloud.FieldByName('NF_SERIE').AsString);
        vQueryLocal.ParamByName('NF_CHAVE').AsString := Trim(vQueryCloud.FieldByName('NF_CHAVE').AsString);
        vQueryLocal.ParamByName('DESCONTO').AsFloat := vQueryCloud.FieldByName('DESCONTO').AsFloat;
        vQueryLocal.ParamByName('SYNC').AsString := 'S';
        vQueryLocal.ParamByName('SYNC_DATA').AsDateTime := vlData;

        vQueryLocal.ExecSQL;
        vQueryLocal.Transaction.CommitRetaining;

        vQueryUpdateCloud.Close;
        vQueryUpdateCloud.SQL.Clear;
        vQueryUpdateCloud.SQL.Add('UPDATE TBPEDIDO_ITEM SET SYNC = ''S'', SYNC_DATA = :SYNC_DATA WHERE PEDIDOITEM_ID = :PEDIDOITEM_ID');

        vQueryUpdateCloud.ParamByName('SYNC_DATA').AsDateTime := vlData;
        vQueryUpdateCloud.ParamByName('PEDIDOITEM_ID').AsInteger := vQueryCloud.FieldByName('PEDIDOITEM_ID').AsInteger;

        vQueryUpdateCloud.ExecSQL;
        vQueryUpdateCloud.Transaction.CommitRetaining;

        Memo_Log.Lines.Add('Item atualizado em ' + FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ': ' +
                           Trim(vQueryCloud.FieldByName('PEDIDOITEM_ID').AsString) + ' - ' + Trim(vQueryCloud.FieldByName('PRODUTO').AsString));
      except
        on E: Exception do
        begin
          Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ' - Erro ao atualizar Item: ' + E.Message);
          vQueryLocal.Transaction.RollbackRetaining;
          dm1.IBDatabase1.Connected := False;
          dm1.IBDatabase1.Connected := True;

          dm1.IBDatabaseCloudSICFAR.Connected := False;
          dm1.IBDatabaseCloudSICFAR.Connected := True;
        end;
      end;

      vQueryCloud.Next;
      Application.ProcessMessages;
    end;
  finally
    vQueryLocal.Free;
    vQueryCloud.Free;
    vQueryUpdateCloud.Free;
  end;

end;

procedure TForm_PrincipalServer.pAtualizaPedidoItemLocalToCloud(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);
var
  vQueryLocal, vQueryCloud, vQueryUpdateLocal: TIBQuery;
  vlData: TDateTime;
begin
  vQueryLocal := TIBQuery.Create(self);
  vQueryCloud := TIBQuery.Create(self);
  vQueryUpdateLocal := TIBQuery.Create(self);

  try
    vQueryLocal.Database := dm1.IBDatabase1;
    vQueryLocal.Transaction := dm1.IBTransaction1;

    vQueryCloud.Database := dm1.IBDatabaseCloudSICFAR;
    vQueryCloud.Transaction := dm1.IBTransactionCloudSICFAR;

    vQueryUpdateLocal.Database := dm1.IBDatabase1;
    vQueryUpdateLocal.Transaction := dm1.IBTransaction1;

    vQueryLocal.Close;
    vQueryLocal.SQL.Text := 'SELECT * FROM TBPEDIDO_ITEM WHERE SYNC = ''N''';
    vQueryLocal.Open;
    vQueryLocal.First;
    while not vQueryLocal.Eof do
    begin
      try
        vlData := Now;
        vQueryCloud.Close;
        vQueryCloud.SQL.Clear;
        vQueryCloud.SQL.Add('UPDATE OR INSERT INTO TBPEDIDO_ITEM');
        vQueryCloud.SQL.Add('(PEDIDOITEM_ID, DATAWARE, PEDIDO_ID, PRODUTO_ID, ORCAMENTO_ID, ORCAMENTOITEM_ID, PESSOA_ID, DATA, ITEM, ERP_PRODUTO,');
        vQueryCloud.SQL.Add('PRODUTO, QUANTIDADE, IPI, ICMS, PRECO, SUBTOTAL, BASE_ICMS, BASE_IPI, VALOR_ICMS, VALOR_IPI,');
        vQueryCloud.SQL.Add('ESTOQUE_ID, COMISSAO, VALOR_DESCONTO, VALOR_ACRESCIMO, CC_ID, APLICACAO_ID, COTACAO_ID, DEPARTAMENTO_ID, SC_ID,');
        vQueryCloud.SQL.Add('ITEMSC_ID, DATA_INC, USUARIO_I, USUARIONOME_I, DATA_ALT, USUARIO_A, USUARIONOME_A, DATA_DEL, USUARIO_D,');
        vQueryCloud.SQL.Add('USUARIONOME_D, USUARIO_ID, EMPRESA_ID, DELETADO, PRAZO, MARCA, COTACAOITEM_ID, ENTREGA_PEDITEM, REPLICADO,');
        vQueryCloud.SQL.Add('TOTAL, WEB_SESSION_ID, FORNECEDOR_ID, QTDE, QTDE_ENTREGA, GERA_ESTOQUE, INTEGRADO, INTEGRADO_DATA, PEDIDO_CODIGO,');
        vQueryCloud.SQL.Add('STATUS, LOTE, OBS, STATUS_DATA, STATUS_USUARIO, CENTRO_CUSTO, DEPARTAMENTO, APLICACAO, ENTREGUE_TIPO, ENTREGUE_DATA,');
        vQueryCloud.SQL.Add('ENTREGUE_USUARIO, ENTREGUE_USUARIONOME, ENTREGUE_OBS, TIPO_FRETE, VALOR_FRETE, NF, NF_SERIE, NF_CHAVE, DESCONTO, SYNC, SYNC_DATA)');
        vQueryCloud.SQL.Add('VALUES');
        vQueryCloud.SQL.Add('(:PEDIDOITEM_ID, :DATAWARE, :PEDIDO_ID, :PRODUTO_ID, :ORCAMENTO_ID, :ORCAMENTOITEM_ID, :PESSOA_ID, :DATA, :ITEM, :ERP_PRODUTO,');
        vQueryCloud.SQL.Add(':PRODUTO, :QUANTIDADE, :IPI, :ICMS, :PRECO, :SUBTOTAL, :BASE_ICMS, :BASE_IPI, :VALOR_ICMS, :VALOR_IPI,');
        vQueryCloud.SQL.Add(':ESTOQUE_ID, :COMISSAO, :VALOR_DESCONTO, :VALOR_ACRESCIMO, :CC_ID, :APLICACAO_ID, :COTACAO_ID, :DEPARTAMENTO_ID, :SC_ID,');
        vQueryCloud.SQL.Add(':ITEMSC_ID, :DATA_INC, :USUARIO_I, :USUARIONOME_I, :DATA_ALT, :USUARIO_A, :USUARIONOME_A, :DATA_DEL, :USUARIO_D,');
        vQueryCloud.SQL.Add(':USUARIONOME_D, :USUARIO_ID, :EMPRESA_ID, :DELETADO, :PRAZO, :MARCA, :COTACAOITEM_ID, :ENTREGA_PEDITEM, :REPLICADO,');
        vQueryCloud.SQL.Add(':TOTAL, :WEB_SESSION_ID, :FORNECEDOR_ID, :QTDE, :QTDE_ENTREGA, :GERA_ESTOQUE, :INTEGRADO, :INTEGRADO_DATA, :PEDIDO_CODIGO,');
        vQueryCloud.SQL.Add(':STATUS, :LOTE, :OBS, :STATUS_DATA, :STATUS_USUARIO, :CENTRO_CUSTO, :DEPARTAMENTO, :APLICACAO, :ENTREGUE_TIPO, :ENTREGUE_DATA,');
        vQueryCloud.SQL.Add(':ENTREGUE_USUARIO, :ENTREGUE_USUARIONOME, :ENTREGUE_OBS, :TIPO_FRETE, :VALOR_FRETE, :NF, :NF_SERIE, :NF_CHAVE, :DESCONTO, :SYNC, :SYNC_DATA)');
        vQueryCloud.SQL.Add('MATCHING (PEDIDOITEM_ID)');

        // Parametros
        vQueryCloud.ParamByName('PEDIDOITEM_ID').AsInteger := vQueryLocal.FieldByName('PEDIDOITEM_ID').AsInteger;
        vQueryCloud.ParamByName('DATAWARE').AsString := Trim(vQueryLocal.FieldByName('DATAWARE').AsString);
        vQueryCloud.ParamByName('PEDIDO_ID').AsInteger := vQueryLocal.FieldByName('PEDIDO_ID').AsInteger;
        vQueryCloud.ParamByName('PRODUTO_ID').AsInteger := vQueryLocal.FieldByName('PRODUTO_ID').AsInteger;
        vQueryCloud.ParamByName('ORCAMENTO_ID').AsInteger := vQueryLocal.FieldByName('ORCAMENTO_ID').AsInteger;
        vQueryCloud.ParamByName('ORCAMENTOITEM_ID').AsInteger := vQueryLocal.FieldByName('ORCAMENTOITEM_ID').AsInteger;
        vQueryCloud.ParamByName('PESSOA_ID').AsInteger := vQueryLocal.FieldByName('PESSOA_ID').AsInteger;
        vQueryCloud.ParamByName('DATA').AsDateTime := vQueryLocal.FieldByName('DATA').AsDateTime;
        vQueryCloud.ParamByName('ITEM').AsString := Trim(vQueryLocal.FieldByName('ITEM').AsString);
        vQueryCloud.ParamByName('ERP_PRODUTO').AsString := Trim(vQueryLocal.FieldByName('ERP_PRODUTO').AsString);
        vQueryCloud.ParamByName('PRODUTO').AsString := Trim(vQueryLocal.FieldByName('PRODUTO').AsString);
        vQueryCloud.ParamByName('QUANTIDADE').AsFloat := vQueryLocal.FieldByName('QUANTIDADE').AsFloat;
        vQueryCloud.ParamByName('IPI').AsFloat := vQueryLocal.FieldByName('IPI').AsFloat;
        vQueryCloud.ParamByName('ICMS').AsFloat := vQueryLocal.FieldByName('ICMS').AsFloat;
        vQueryCloud.ParamByName('PRECO').AsFloat := vQueryLocal.FieldByName('PRECO').AsFloat;
        vQueryCloud.ParamByName('SUBTOTAL').AsFloat := vQueryLocal.FieldByName('SUBTOTAL').AsFloat;
        vQueryCloud.ParamByName('BASE_ICMS').AsFloat := vQueryLocal.FieldByName('BASE_ICMS').AsFloat;
        vQueryCloud.ParamByName('BASE_IPI').AsFloat := vQueryLocal.FieldByName('BASE_IPI').AsFloat;
        vQueryCloud.ParamByName('VALOR_ICMS').AsFloat := vQueryLocal.FieldByName('VALOR_ICMS').AsFloat;
        vQueryCloud.ParamByName('VALOR_IPI').AsFloat := vQueryLocal.FieldByName('VALOR_IPI').AsFloat;
        vQueryCloud.ParamByName('ESTOQUE_ID').AsInteger := vQueryLocal.FieldByName('ESTOQUE_ID').AsInteger;
        vQueryCloud.ParamByName('COMISSAO').AsFloat := vQueryLocal.FieldByName('COMISSAO').AsFloat;
        vQueryCloud.ParamByName('VALOR_DESCONTO').AsFloat := vQueryLocal.FieldByName('VALOR_DESCONTO').AsFloat;
        vQueryCloud.ParamByName('VALOR_ACRESCIMO').AsFloat := vQueryLocal.FieldByName('VALOR_ACRESCIMO').AsFloat;
        vQueryCloud.ParamByName('CC_ID').AsInteger := vQueryLocal.FieldByName('CC_ID').AsInteger;
        vQueryCloud.ParamByName('APLICACAO_ID').AsInteger := vQueryLocal.FieldByName('APLICACAO_ID').AsInteger;
        vQueryCloud.ParamByName('COTACAO_ID').AsInteger := vQueryLocal.FieldByName('COTACAO_ID').AsInteger;
        vQueryCloud.ParamByName('DEPARTAMENTO_ID').AsInteger := vQueryLocal.FieldByName('DEPARTAMENTO_ID').AsInteger;
        vQueryCloud.ParamByName('SC_ID').AsInteger := vQueryLocal.FieldByName('SC_ID').AsInteger;
        vQueryCloud.ParamByName('ITEMSC_ID').AsInteger := vQueryLocal.FieldByName('ITEMSC_ID').AsInteger;
        vQueryCloud.ParamByName('DATA_INC').AsDateTime := vQueryLocal.FieldByName('DATA_INC').AsDateTime;
        vQueryCloud.ParamByName('USUARIO_I').AsInteger := vQueryLocal.FieldByName('USUARIO_I').AsInteger;
        vQueryCloud.ParamByName('USUARIONOME_I').AsString := Trim(vQueryLocal.FieldByName('USUARIONOME_I').AsString);
        vQueryCloud.ParamByName('DATA_ALT').AsDateTime := vQueryLocal.FieldByName('DATA_ALT').AsDateTime;
        vQueryCloud.ParamByName('USUARIO_A').AsInteger := vQueryLocal.FieldByName('USUARIO_A').AsInteger;
        vQueryCloud.ParamByName('USUARIONOME_A').AsString := Trim(vQueryLocal.FieldByName('USUARIONOME_A').AsString);
        vQueryCloud.ParamByName('DATA_DEL').AsDateTime := vQueryLocal.FieldByName('DATA_DEL').AsDateTime;
        vQueryCloud.ParamByName('USUARIO_D').AsInteger := vQueryLocal.FieldByName('USUARIO_D').AsInteger;
        vQueryCloud.ParamByName('USUARIONOME_D').AsString := Trim(vQueryLocal.FieldByName('USUARIONOME_D').AsString);
        vQueryCloud.ParamByName('USUARIO_ID').AsInteger := vQueryLocal.FieldByName('USUARIO_ID').AsInteger;
        vQueryCloud.ParamByName('EMPRESA_ID').AsInteger := vQueryLocal.FieldByName('EMPRESA_ID').AsInteger;
        vQueryCloud.ParamByName('DELETADO').AsString := Trim(vQueryLocal.FieldByName('DELETADO').AsString);
        vQueryCloud.ParamByName('PRAZO').AsInteger := vQueryLocal.FieldByName('PRAZO').AsInteger;
        vQueryCloud.ParamByName('MARCA').AsString := Trim(vQueryLocal.FieldByName('MARCA').AsString);
        vQueryCloud.ParamByName('COTACAOITEM_ID').AsInteger := vQueryLocal.FieldByName('COTACAOITEM_ID').AsInteger;
        vQueryCloud.ParamByName('ENTREGA_PEDITEM').AsDateTime := vQueryLocal.FieldByName('ENTREGA_PEDITEM').AsDateTime;
        vQueryCloud.ParamByName('REPLICADO').AsString := Trim(vQueryLocal.FieldByName('REPLICADO').AsString);
        vQueryCloud.ParamByName('TOTAL').AsFloat := vQueryLocal.FieldByName('TOTAL').AsFloat;
        vQueryCloud.ParamByName('WEB_SESSION_ID').AsString := Trim(vQueryLocal.FieldByName('WEB_SESSION_ID').AsString);
        vQueryCloud.ParamByName('FORNECEDOR_ID').AsInteger := vQueryLocal.FieldByName('FORNECEDOR_ID').AsInteger;
        vQueryCloud.ParamByName('QTDE').AsFloat := vQueryLocal.FieldByName('QTDE').AsFloat;
        vQueryCloud.ParamByName('QTDE_ENTREGA').AsFloat := vQueryLocal.FieldByName('QTDE_ENTREGA').AsFloat;
        vQueryCloud.ParamByName('GERA_ESTOQUE').AsString := Trim(vQueryLocal.FieldByName('GERA_ESTOQUE').AsString);
        vQueryCloud.ParamByName('INTEGRADO').AsString := Trim(vQueryLocal.FieldByName('INTEGRADO').AsString);
        vQueryCloud.ParamByName('INTEGRADO_DATA').AsDateTime := vQueryLocal.FieldByName('INTEGRADO_DATA').AsDateTime;
        vQueryCloud.ParamByName('PEDIDO_CODIGO').AsString := Trim(vQueryLocal.FieldByName('PEDIDO_CODIGO').AsString);
        vQueryCloud.ParamByName('STATUS').AsString := Trim(vQueryLocal.FieldByName('STATUS').AsString);
        vQueryCloud.ParamByName('LOTE').AsString := Trim(vQueryLocal.FieldByName('LOTE').AsString);
        vQueryCloud.ParamByName('OBS').AsString := vQueryLocal.FieldByName('OBS').AsString;
        vQueryCloud.ParamByName('STATUS_DATA').AsDateTime := vQueryLocal.FieldByName('STATUS_DATA').AsDateTime;
        vQueryCloud.ParamByName('STATUS_USUARIO').AsString := Trim(vQueryLocal.FieldByName('STATUS_USUARIO').AsString);
        vQueryCloud.ParamByName('CENTRO_CUSTO').AsString := Trim(vQueryLocal.FieldByName('CENTRO_CUSTO').AsString);
        vQueryCloud.ParamByName('DEPARTAMENTO').AsString := Trim(vQueryLocal.FieldByName('DEPARTAMENTO').AsString);
        vQueryCloud.ParamByName('APLICACAO').AsString := Trim(vQueryLocal.FieldByName('APLICACAO').AsString);
        vQueryCloud.ParamByName('ENTREGUE_TIPO').AsString := Trim(vQueryLocal.FieldByName('ENTREGUE_TIPO').AsString);
        vQueryCloud.ParamByName('ENTREGUE_DATA').AsDateTime := vQueryLocal.FieldByName('ENTREGUE_DATA').AsDateTime;
        vQueryCloud.ParamByName('ENTREGUE_USUARIO').AsInteger := vQueryLocal.FieldByName('ENTREGUE_USUARIO').AsInteger;
        vQueryCloud.ParamByName('ENTREGUE_USUARIONOME').AsString := Trim(vQueryLocal.FieldByName('ENTREGUE_USUARIONOME').AsString);
        vQueryCloud.ParamByName('ENTREGUE_OBS').AsString := Trim(vQueryLocal.FieldByName('ENTREGUE_OBS').AsString);
        vQueryCloud.ParamByName('TIPO_FRETE').AsString := Trim(vQueryLocal.FieldByName('TIPO_FRETE').AsString);
        vQueryCloud.ParamByName('VALOR_FRETE').AsFloat := vQueryLocal.FieldByName('VALOR_FRETE').AsFloat;
        vQueryCloud.ParamByName('NF').AsString := Trim(vQueryLocal.FieldByName('NF').AsString);
        vQueryCloud.ParamByName('NF_SERIE').AsString := Trim(vQueryLocal.FieldByName('NF_SERIE').AsString);
        vQueryCloud.ParamByName('NF_CHAVE').AsString := Trim(vQueryLocal.FieldByName('NF_CHAVE').AsString);
        vQueryCloud.ParamByName('DESCONTO').AsFloat := vQueryLocal.FieldByName('DESCONTO').AsFloat;
        vQueryCloud.ParamByName('SYNC').AsString := 'S';
        vQueryCloud.ParamByName('SYNC_DATA').AsDateTime := vlData;

        vQueryCloud.ExecSQL;
        vQueryCloud.Transaction.CommitRetaining;

        vQueryUpdateLocal.Close;
        vQueryUpdateLocal.SQL.Clear;
        vQueryUpdateLocal.SQL.Add('UPDATE TBPEDIDO_ITEM SET SYNC = ''S'', SYNC_DATA = :SYNC_DATA WHERE PEDIDOITEM_ID = :PEDIDOITEM_ID');

        vQueryUpdateLocal.ParamByName('SYNC_DATA').AsDateTime := vlData;
        vQueryUpdateLocal.ParamByName('PEDIDOITEM_ID').AsInteger := vQueryLocal.FieldByName('PEDIDOITEM_ID').AsInteger;

        vQueryUpdateLocal.ExecSQL;
        vQueryUpdateLocal.Transaction.CommitRetaining;

        Memo_Log.Lines.Add('Item atualizado em ' + FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ': ' +
                           Trim(vQueryLocal.FieldByName('PEDIDOITEM_ID').AsString) + ' - ' + Trim(vQueryLocal.FieldByName('PRODUTO').AsString));
      except
        on E: Exception do
        begin
          Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ' - Erro ao atualizar Item: ' + E.Message);
          vQueryCloud.Transaction.RollbackRetaining;
          dm1.IBDatabase1.Connected := False;
          dm1.IBDatabase1.Connected := True;

          dm1.IBDatabaseCloudSICFAR.Connected := False;
          dm1.IBDatabaseCloudSICFAR.Connected := True;
        end;
      end;

      vQueryLocal.Next;
      Application.ProcessMessages;
    end;
  finally
    vQueryLocal.Free;
    vQueryCloud.Free;
    vQueryUpdateLocal.Free;
  end;
end;

procedure TForm_PrincipalServer.pAtualizaPedidoLocalToCloud(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);
var
  vQueryLocal, vQueryCloud, vQueryUpdateLocal: TIBQuery;
  vlData: TDateTime;
begin
  vQueryLocal := TIBQuery.Create(self);
  vQueryCloud := TIBQuery.Create(self);
  vQueryUpdateLocal := TIBQuery.Create(self);

  try
    vQueryLocal.Database := ALocalDatabase;
    vQueryLocal.Transaction := ALocalTransaction;

    vQueryCloud.Database := ACloudDatabase;
    vQueryCloud.Transaction := ACloudTransaction;

    vQueryUpdateLocal.Database := ALocalDatabase;
    vQueryUpdateLocal.Transaction := ALocalTransaction;

    vQueryLocal.Close;
    vQueryLocal.SQL.Text := 'SELECT * FROM TBPEDIDO WHERE SYNC = ''N'' ';
    vQueryLocal.Open;
    vQueryLocal.First;
    while not vQueryLocal.Eof do
    begin
      try
        vlData := Now;
        vQueryCloud.Close;
        vQueryCloud.SQL.Clear;
        vQueryCloud.SQL.Add('UPDATE OR INSERT INTO TBPEDIDO');
        vQueryCloud.SQL.Add('(PEDIDO_ID, DATAWARE, PEDIDO_NUM, ORCAMENTO_ID, EMISSAO, VALIDADE, HORA, SC_ID, COTACAO_ID, CC_ID,');
        vQueryCloud.SQL.Add('ENTRADA_SAIDA, PESSOA_ID, PESSOA_VR, VALOR_PEDIDO, VALOR_FRETE, VALOR_DESPESAS, VALOR_DESCONTO,');
        vQueryCloud.SQL.Add('VALOR_ICMS, BASE_ICMS, VALOR_IPI, BASE_IPI, TRANSPORTADOR_ID, VEICULO_ID, DATA_INC, USUARIO_I,');
        vQueryCloud.SQL.Add('USUARIONOME_I, DATA_ALT, USUARIO_A, USUARIONOME_A, DATA_DEL, USUARIO_D, USUARIONOME_D, USUARIO_ID,');
        vQueryCloud.SQL.Add('EMPRESA_ID, DELETADO, IDENTIFICACAO_PEDIDO, CONDPAGTO_ID, ERP_CONDPAGTO, CONDPAGTO, TIPO_FRETE,');
        vQueryCloud.SQL.Add('VALOR_ITENS, OBS_PEDIDO, ENTREGA_PEDIDO, ID, ANO, REPLICADO, CLIENTE_ID, IMOVEL_ID, WEB_SESSION_ID,');
        vQueryCloud.SQL.Add('FORNECEDOR_ID, REPRESENTADA_ID, REPRESENTADA, CLI_NOME, ERP_CLIENTE, CLI_ENDERECO, CLI_COMPLEMENTO,');
        vQueryCloud.SQL.Add('CLI_BAIRRO, CLI_CEP, CLI_CIDADE, CLI_UF, CLI_TELEFONE, CLI_EMAIL, CLI_TIPO, CLI_CPFCNPJ, CLI_IE,');
        vQueryCloud.SQL.Add('CLI_RGCGF, ERP_ENTREGA, ENT_CPFCNPJ, ENT_NOME, ENT_CONTATO, ENT_ENDERECO, ENT_COMPLEMENTO, ENT_BAIRRO,');
        vQueryCloud.SQL.Add('ENT_CEP, ENT_CIDADE, ENT_UF, ENT_TELEFONE, ENT_EMAIL, ENT_RGCGF, EMPENHO, PROCESSO, PROCESSO_ANO,');
        vQueryCloud.SQL.Add('ORIGEM, IMPRESSO, SITUACAO, DATA_SITUACAO, HPRINT, ERP_VENDEDOR, ERP_VENDEDOR_NOME, ERP_REPRESENTANTE,');
        vQueryCloud.SQL.Add('ERP_REPRESENTANTE_NOME, CODIGO, INTEGRADO, INTEGRADO_DATA, OBS, STATUS, IMPRESSAO_ULTIMA, IMPRESSAO_USUARIO,');
        vQueryCloud.SQL.Add('STATUS_DATA, STATUS_USUARIO, VALOR_ACRESCIMO, TRANSPORTADOR_NOME, TRANSPORTADOR_ENDERECO,');
        vQueryCloud.SQL.Add('TRANSPORTADOR_CIDADE, TRANSPORTADOR_UF, TRANSPORTADOR_BAIRRO, TRANSPORTADOR_CPFCNPJ,');
        vQueryCloud.SQL.Add('TRANSPORTADOR_IERG, TRANSPORTADOR_VALORFRETE, TRANSPORTADOR_VALORSEGURO, TRANSPORTADOR_TELEFONE,');
        vQueryCloud.SQL.Add('TRANSPORTADOR_VEICULO_ID, TRANSPORTADOR_VEICULO, TRANSPORTADOR_CODANTT, TRANSPORTADOR_PLACAVEICULO,');
        vQueryCloud.SQL.Add('TRANSPORTADOR_UFVEICULO, ARQUIVO, EMPENHO_ANO, EMPENHO_COMPLETO, SYNC, SYNC_DATA)');

        vQueryCloud.SQL.Add('VALUES');

        vQueryCloud.SQL.Add('(:PEDIDO_ID, :DATAWARE, :PEDIDO_NUM, :ORCAMENTO_ID, :EMISSAO, :VALIDADE, :HORA, :SC_ID, :COTACAO_ID, :CC_ID,');
        vQueryCloud.SQL.Add(':ENTRADA_SAIDA, :PESSOA_ID, :PESSOA_VR, :VALOR_PEDIDO, :VALOR_FRETE, :VALOR_DESPESAS, :VALOR_DESCONTO,');
        vQueryCloud.SQL.Add(':VALOR_ICMS, :BASE_ICMS, :VALOR_IPI, :BASE_IPI, :TRANSPORTADOR_ID, :VEICULO_ID, :DATA_INC, :USUARIO_I,');
        vQueryCloud.SQL.Add(':USUARIONOME_I, :DATA_ALT, :USUARIO_A, :USUARIONOME_A, :DATA_DEL, :USUARIO_D, :USUARIONOME_D, :USUARIO_ID,');
        vQueryCloud.SQL.Add(':EMPRESA_ID, :DELETADO, :IDENTIFICACAO_PEDIDO, :CONDPAGTO_ID, :ERP_CONDPAGTO, :CONDPAGTO, :TIPO_FRETE,');
        vQueryCloud.SQL.Add(':VALOR_ITENS, :OBS_PEDIDO, :ENTREGA_PEDIDO, :ID, :ANO, :REPLICADO, :CLIENTE_ID, :IMOVEL_ID, :WEB_SESSION_ID,');
        vQueryCloud.SQL.Add(':FORNECEDOR_ID, :REPRESENTADA_ID, :REPRESENTADA, :CLI_NOME, :ERP_CLIENTE, :CLI_ENDERECO, :CLI_COMPLEMENTO,');
        vQueryCloud.SQL.Add(':CLI_BAIRRO, :CLI_CEP, :CLI_CIDADE, :CLI_UF, :CLI_TELEFONE, :CLI_EMAIL, :CLI_TIPO, :CLI_CPFCNPJ, :CLI_IE,');
        vQueryCloud.SQL.Add(':CLI_RGCGF, :ERP_ENTREGA, :ENT_CPFCNPJ, :ENT_NOME, :ENT_CONTATO, :ENT_ENDERECO, :ENT_COMPLEMENTO, :ENT_BAIRRO,');
        vQueryCloud.SQL.Add(':ENT_CEP, :ENT_CIDADE, :ENT_UF, :ENT_TELEFONE, :ENT_EMAIL, :ENT_RGCGF, :EMPENHO, :PROCESSO, :PROCESSO_ANO,');
        vQueryCloud.SQL.Add(':ORIGEM, :IMPRESSO, :SITUACAO, :DATA_SITUACAO, :HPRINT, :ERP_VENDEDOR, :ERP_VENDEDOR_NOME, :ERP_REPRESENTANTE,');
        vQueryCloud.SQL.Add(':ERP_REPRESENTANTE_NOME, :CODIGO, :INTEGRADO, :INTEGRADO_DATA, :OBS, :STATUS, :IMPRESSAO_ULTIMA, :IMPRESSAO_USUARIO,');
        vQueryCloud.SQL.Add(':STATUS_DATA, :STATUS_USUARIO, :VALOR_ACRESCIMO, :TRANSPORTADOR_NOME, :TRANSPORTADOR_ENDERECO,');
        vQueryCloud.SQL.Add(':TRANSPORTADOR_CIDADE, :TRANSPORTADOR_UF, :TRANSPORTADOR_BAIRRO, :TRANSPORTADOR_CPFCNPJ,');
        vQueryCloud.SQL.Add(':TRANSPORTADOR_IERG, :TRANSPORTADOR_VALORFRETE, :TRANSPORTADOR_VALORSEGURO, :TRANSPORTADOR_TELEFONE,');
        vQueryCloud.SQL.Add(':TRANSPORTADOR_VEICULO_ID, :TRANSPORTADOR_VEICULO, :TRANSPORTADOR_CODANTT, :TRANSPORTADOR_PLACAVEICULO,');
        vQueryCloud.SQL.Add(':TRANSPORTADOR_UFVEICULO, :ARQUIVO, :EMPENHO_ANO, :EMPENHO_COMPLETO, :SYNC, :SYNC_DATA)');

        vQueryCloud.SQL.Add('MATCHING (PEDIDO_ID)');

        // Parametros
        vQueryCloud.ParamByName('PEDIDO_ID').AsInteger := vQueryLocal.FieldByName('PEDIDO_ID').AsInteger;
        vQueryCloud.ParamByName('DATAWARE').AsString := Trim(vQueryLocal.FieldByName('DATAWARE').AsString);
        vQueryCloud.ParamByName('PEDIDO_NUM').AsString := Trim(vQueryLocal.FieldByName('PEDIDO_NUM').AsString);
        vQueryCloud.ParamByName('ORCAMENTO_ID').AsInteger := vQueryLocal.FieldByName('ORCAMENTO_ID').AsInteger;
        vQueryCloud.ParamByName('EMISSAO').AsDateTime := vQueryLocal.FieldByName('EMISSAO').AsDateTime;
        vQueryCloud.ParamByName('VALIDADE').AsDateTime := vQueryLocal.FieldByName('VALIDADE').AsDateTime;
        vQueryCloud.ParamByName('HORA').AsTime := vQueryLocal.FieldByName('HORA').AsDateTime;
        vQueryCloud.ParamByName('SC_ID').AsInteger := vQueryLocal.FieldByName('SC_ID').AsInteger;
        vQueryCloud.ParamByName('COTACAO_ID').AsInteger := vQueryLocal.FieldByName('COTACAO_ID').AsInteger;
        vQueryCloud.ParamByName('CC_ID').AsInteger := vQueryLocal.FieldByName('CC_ID').AsInteger;
        vQueryCloud.ParamByName('ENTRADA_SAIDA').AsString := Trim(vQueryLocal.FieldByName('ENTRADA_SAIDA').AsString);
        vQueryCloud.ParamByName('PESSOA_ID').AsInteger := vQueryLocal.FieldByName('PESSOA_ID').AsInteger;
        vQueryCloud.ParamByName('PESSOA_VR').AsInteger := vQueryLocal.FieldByName('PESSOA_VR').AsInteger;
        vQueryCloud.ParamByName('VALOR_PEDIDO').AsFloat := vQueryLocal.FieldByName('VALOR_PEDIDO').AsFloat;
        vQueryCloud.ParamByName('VALOR_FRETE').AsFloat := vQueryLocal.FieldByName('VALOR_FRETE').AsFloat;
        vQueryCloud.ParamByName('VALOR_DESPESAS').AsFloat := vQueryLocal.FieldByName('VALOR_DESPESAS').AsFloat;
        vQueryCloud.ParamByName('VALOR_DESCONTO').AsFloat := vQueryLocal.FieldByName('VALOR_DESCONTO').AsFloat;
        vQueryCloud.ParamByName('VALOR_ICMS').AsFloat := vQueryLocal.FieldByName('VALOR_ICMS').AsFloat;
        vQueryCloud.ParamByName('BASE_ICMS').AsFloat := vQueryLocal.FieldByName('BASE_ICMS').AsFloat;
        vQueryCloud.ParamByName('VALOR_IPI').AsFloat := vQueryLocal.FieldByName('VALOR_IPI').AsFloat;
        vQueryCloud.ParamByName('BASE_IPI').AsFloat := vQueryLocal.FieldByName('BASE_IPI').AsFloat;
        vQueryCloud.ParamByName('TRANSPORTADOR_ID').AsInteger := vQueryLocal.FieldByName('TRANSPORTADOR_ID').AsInteger;
        vQueryCloud.ParamByName('VEICULO_ID').AsInteger := vQueryLocal.FieldByName('VEICULO_ID').AsInteger;
        vQueryCloud.ParamByName('DATA_INC').AsDateTime := vQueryLocal.FieldByName('DATA_INC').AsDateTime;
        vQueryCloud.ParamByName('USUARIO_I').AsInteger := vQueryLocal.FieldByName('USUARIO_I').AsInteger;
        vQueryCloud.ParamByName('USUARIONOME_I').AsString := Trim(vQueryLocal.FieldByName('USUARIONOME_I').AsString);
        vQueryCloud.ParamByName('DATA_ALT').AsDateTime := vQueryLocal.FieldByName('DATA_ALT').AsDateTime;
        vQueryCloud.ParamByName('USUARIO_A').AsInteger := vQueryLocal.FieldByName('USUARIO_A').AsInteger;
        vQueryCloud.ParamByName('USUARIONOME_A').AsString := Trim(vQueryLocal.FieldByName('USUARIONOME_A').AsString);
        vQueryCloud.ParamByName('DATA_DEL').AsDateTime := vQueryLocal.FieldByName('DATA_DEL').AsDateTime;
        vQueryCloud.ParamByName('USUARIO_D').AsInteger := vQueryLocal.FieldByName('USUARIO_D').AsInteger;
        vQueryCloud.ParamByName('USUARIONOME_D').AsString := Trim(vQueryLocal.FieldByName('USUARIONOME_D').AsString);
        vQueryCloud.ParamByName('USUARIO_ID').AsInteger := vQueryLocal.FieldByName('USUARIO_ID').AsInteger;
        vQueryCloud.ParamByName('EMPRESA_ID').AsInteger := vQueryLocal.FieldByName('EMPRESA_ID').AsInteger;
        vQueryCloud.ParamByName('DELETADO').AsString := Trim(vQueryLocal.FieldByName('DELETADO').AsString);
        vQueryCloud.ParamByName('IDENTIFICACAO_PEDIDO').AsString := Trim(vQueryLocal.FieldByName('IDENTIFICACAO_PEDIDO').AsString);
        vQueryCloud.ParamByName('CONDPAGTO_ID').AsInteger := vQueryLocal.FieldByName('CONDPAGTO_ID').AsInteger;
        vQueryCloud.ParamByName('ERP_CONDPAGTO').AsInteger := vQueryLocal.FieldByName('ERP_CONDPAGTO').AsInteger;
        vQueryCloud.ParamByName('CONDPAGTO').AsString := Trim(vQueryLocal.FieldByName('CONDPAGTO').AsString);
        vQueryCloud.ParamByName('TIPO_FRETE').AsString := Trim(vQueryLocal.FieldByName('TIPO_FRETE').AsString);
        vQueryCloud.ParamByName('VALOR_ITENS').AsFloat := vQueryLocal.FieldByName('VALOR_ITENS').AsFloat;
        vQueryCloud.ParamByName('OBS_PEDIDO').AsString := Trim(vQueryLocal.FieldByName('OBS_PEDIDO').AsString);
        vQueryCloud.ParamByName('ENTREGA_PEDIDO').AsDateTime := vQueryLocal.FieldByName('ENTREGA_PEDIDO').AsDateTime;
        vQueryCloud.ParamByName('ID').AsInteger := vQueryLocal.FieldByName('ID').AsInteger;
        vQueryCloud.ParamByName('ANO').AsString := Trim(vQueryLocal.FieldByName('ANO').AsString);
        vQueryCloud.ParamByName('REPLICADO').AsString := Trim(vQueryLocal.FieldByName('REPLICADO').AsString);
        vQueryCloud.ParamByName('CLIENTE_ID').AsInteger := vQueryLocal.FieldByName('CLIENTE_ID').AsInteger;
        vQueryCloud.ParamByName('IMOVEL_ID').AsInteger := vQueryLocal.FieldByName('IMOVEL_ID').AsInteger;
        vQueryCloud.ParamByName('WEB_SESSION_ID').AsString := Trim(vQueryLocal.FieldByName('WEB_SESSION_ID').AsString);
        vQueryCloud.ParamByName('FORNECEDOR_ID').AsInteger := vQueryLocal.FieldByName('FORNECEDOR_ID').AsInteger;
        vQueryCloud.ParamByName('REPRESENTADA_ID').AsInteger := vQueryLocal.FieldByName('REPRESENTADA_ID').AsInteger;
        vQueryCloud.ParamByName('REPRESENTADA').AsString := Trim(vQueryLocal.FieldByName('REPRESENTADA').AsString);
        vQueryCloud.ParamByName('CLI_NOME').AsString := Trim(vQueryLocal.FieldByName('CLI_NOME').AsString);
        vQueryCloud.ParamByName('ERP_CLIENTE').AsString := Trim(vQueryLocal.FieldByName('ERP_CLIENTE').AsString);
        vQueryCloud.ParamByName('CLI_ENDERECO').AsString := Trim(vQueryLocal.FieldByName('CLI_ENDERECO').AsString);
        vQueryCloud.ParamByName('CLI_COMPLEMENTO').AsString := Trim(vQueryLocal.FieldByName('CLI_COMPLEMENTO').AsString);
        vQueryCloud.ParamByName('CLI_BAIRRO').AsString := Trim(vQueryLocal.FieldByName('CLI_BAIRRO').AsString);
        vQueryCloud.ParamByName('CLI_CEP').AsString := Trim(vQueryLocal.FieldByName('CLI_CEP').AsString);
        vQueryCloud.ParamByName('CLI_CIDADE').AsString := Trim(vQueryLocal.FieldByName('CLI_CIDADE').AsString);
        vQueryCloud.ParamByName('CLI_UF').AsString := Trim(vQueryLocal.FieldByName('CLI_UF').AsString);
        vQueryCloud.ParamByName('CLI_TELEFONE').AsString := Trim(vQueryLocal.FieldByName('CLI_TELEFONE').AsString);
        vQueryCloud.ParamByName('CLI_EMAIL').AsString := Trim(vQueryLocal.FieldByName('CLI_EMAIL').AsString);
        vQueryCloud.ParamByName('CLI_TIPO').AsString := Trim(vQueryLocal.FieldByName('CLI_TIPO').AsString);
        vQueryCloud.ParamByName('CLI_CPFCNPJ').AsString := Trim(vQueryLocal.FieldByName('CLI_CPFCNPJ').AsString);
        vQueryCloud.ParamByName('CLI_IE').AsString := Trim(vQueryLocal.FieldByName('CLI_IE').AsString);
        vQueryCloud.ParamByName('CLI_RGCGF').AsString := Trim(vQueryLocal.FieldByName('CLI_RGCGF').AsString);
        vQueryCloud.ParamByName('ERP_ENTREGA').AsString := Trim(vQueryLocal.FieldByName('ERP_ENTREGA').AsString);
        vQueryCloud.ParamByName('ENT_CPFCNPJ').AsString := Trim(vQueryLocal.FieldByName('ENT_CPFCNPJ').AsString);
        vQueryCloud.ParamByName('ENT_NOME').AsString := Trim(vQueryLocal.FieldByName('ENT_NOME').AsString);
        vQueryCloud.ParamByName('ENT_CONTATO').AsString := Trim(vQueryLocal.FieldByName('ENT_CONTATO').AsString);
        vQueryCloud.ParamByName('ENT_ENDERECO').AsString := Trim(vQueryLocal.FieldByName('ENT_ENDERECO').AsString);
        vQueryCloud.ParamByName('ENT_COMPLEMENTO').AsString := Trim(vQueryLocal.FieldByName('ENT_COMPLEMENTO').AsString);
        vQueryCloud.ParamByName('ENT_BAIRRO').AsString := Trim(vQueryLocal.FieldByName('ENT_BAIRRO').AsString);
        vQueryCloud.ParamByName('ENT_CEP').AsString := Trim(vQueryLocal.FieldByName('ENT_CEP').AsString);
        vQueryCloud.ParamByName('ENT_CIDADE').AsString := Trim(vQueryLocal.FieldByName('ENT_CIDADE').AsString);
        vQueryCloud.ParamByName('ENT_UF').AsString := Trim(vQueryLocal.FieldByName('ENT_UF').AsString);
        vQueryCloud.ParamByName('ENT_TELEFONE').AsString := Trim(vQueryLocal.FieldByName('ENT_TELEFONE').AsString);
        vQueryCloud.ParamByName('ENT_EMAIL').AsString := Trim(vQueryLocal.FieldByName('ENT_EMAIL').AsString);
        vQueryCloud.ParamByName('ENT_RGCGF').AsString := Trim(vQueryLocal.FieldByName('ENT_RGCGF').AsString);
        vQueryCloud.ParamByName('EMPENHO').AsString := Trim(vQueryLocal.FieldByName('EMPENHO').AsString);
        vQueryCloud.ParamByName('PROCESSO').AsString := Trim(vQueryLocal.FieldByName('PROCESSO').AsString);
        vQueryCloud.ParamByName('PROCESSO_ANO').AsString := Trim(vQueryLocal.FieldByName('PROCESSO_ANO').AsString);
        vQueryCloud.ParamByName('ORIGEM').AsString := Trim(vQueryLocal.FieldByName('ORIGEM').AsString);
        vQueryCloud.ParamByName('IMPRESSO').AsString := Trim(vQueryLocal.FieldByName('IMPRESSO').AsString);
        vQueryCloud.ParamByName('SITUACAO').AsString := Trim(vQueryLocal.FieldByName('SITUACAO').AsString);
        vQueryCloud.ParamByName('DATA_SITUACAO').AsDateTime := vQueryLocal.FieldByName('DATA_SITUACAO').AsDateTime;
        vQueryCloud.ParamByName('HPRINT').AsDateTime := vQueryLocal.FieldByName('HPRINT').AsDateTime;
        vQueryCloud.ParamByName('ERP_VENDEDOR').AsString := Trim(vQueryLocal.FieldByName('ERP_VENDEDOR').AsString);
        vQueryCloud.ParamByName('ERP_VENDEDOR_NOME').AsString := Trim(vQueryLocal.FieldByName('ERP_VENDEDOR_NOME').AsString);
        vQueryCloud.ParamByName('ERP_REPRESENTANTE').AsString := Trim(vQueryLocal.FieldByName('ERP_REPRESENTANTE').AsString);
        vQueryCloud.ParamByName('ERP_REPRESENTANTE_NOME').AsString := Trim(vQueryLocal.FieldByName('ERP_REPRESENTANTE_NOME').AsString);
        vQueryCloud.ParamByName('CODIGO').AsString := Trim(vQueryLocal.FieldByName('CODIGO').AsString);
        vQueryCloud.ParamByName('INTEGRADO').AsString := Trim(vQueryLocal.FieldByName('INTEGRADO').AsString);
        vQueryCloud.ParamByName('INTEGRADO_DATA').AsDateTime := vQueryLocal.FieldByName('INTEGRADO_DATA').AsDateTime;
        vQueryCloud.ParamByName('OBS').AsString := Trim(vQueryLocal.FieldByName('OBS').AsString);
        vQueryCloud.ParamByName('STATUS').AsString := Trim(vQueryLocal.FieldByName('STATUS').AsString);
        vQueryCloud.ParamByName('IMPRESSAO_ULTIMA').AsDateTime := vQueryLocal.FieldByName('IMPRESSAO_ULTIMA').AsDateTime;
        vQueryCloud.ParamByName('IMPRESSAO_USUARIO').AsString := Trim(vQueryLocal.FieldByName('IMPRESSAO_USUARIO').AsString);
        vQueryCloud.ParamByName('STATUS_DATA').AsDateTime := vQueryLocal.FieldByName('STATUS_DATA').AsDateTime;
        vQueryCloud.ParamByName('STATUS_USUARIO').AsString := Trim(vQueryLocal.FieldByName('STATUS_USUARIO').AsString);
        vQueryCloud.ParamByName('VALOR_ACRESCIMO').AsFloat := vQueryLocal.FieldByName('VALOR_ACRESCIMO').AsFloat;
        vQueryCloud.ParamByName('TRANSPORTADOR_NOME').AsString := Trim(vQueryLocal.FieldByName('TRANSPORTADOR_NOME').AsString);
        vQueryCloud.ParamByName('TRANSPORTADOR_ENDERECO').AsString := Trim(vQueryLocal.FieldByName('TRANSPORTADOR_ENDERECO').AsString);
        vQueryCloud.ParamByName('TRANSPORTADOR_CIDADE').AsString := Trim(vQueryLocal.FieldByName('TRANSPORTADOR_CIDADE').AsString);
        vQueryCloud.ParamByName('TRANSPORTADOR_UF').AsString := Trim(vQueryLocal.FieldByName('TRANSPORTADOR_UF').AsString);
        vQueryCloud.ParamByName('TRANSPORTADOR_BAIRRO').AsString := Trim(vQueryLocal.FieldByName('TRANSPORTADOR_BAIRRO').AsString);
        vQueryCloud.ParamByName('TRANSPORTADOR_CPFCNPJ').AsString := Trim(vQueryLocal.FieldByName('TRANSPORTADOR_CPFCNPJ').AsString);
        vQueryCloud.ParamByName('TRANSPORTADOR_IERG').AsString := Trim(vQueryLocal.FieldByName('TRANSPORTADOR_IERG').AsString);
        vQueryCloud.ParamByName('TRANSPORTADOR_VALORFRETE').AsFloat := vQueryLocal.FieldByName('TRANSPORTADOR_VALORFRETE').AsFloat;
        vQueryCloud.ParamByName('TRANSPORTADOR_VALORSEGURO').AsFloat := vQueryLocal.FieldByName('TRANSPORTADOR_VALORSEGURO').AsFloat;
        vQueryCloud.ParamByName('TRANSPORTADOR_TELEFONE').AsString := Trim(vQueryLocal.FieldByName('TRANSPORTADOR_TELEFONE').AsString);
        vQueryCloud.ParamByName('TRANSPORTADOR_VEICULO_ID').AsInteger := vQueryLocal.FieldByName('TRANSPORTADOR_VEICULO_ID').AsInteger;
        vQueryCloud.ParamByName('TRANSPORTADOR_VEICULO').AsString := Trim(vQueryLocal.FieldByName('TRANSPORTADOR_VEICULO').AsString);
        vQueryCloud.ParamByName('TRANSPORTADOR_CODANTT').AsString := Trim(vQueryLocal.FieldByName('TRANSPORTADOR_CODANTT').AsString);
        vQueryCloud.ParamByName('TRANSPORTADOR_PLACAVEICULO').AsString := Trim(vQueryLocal.FieldByName('TRANSPORTADOR_PLACAVEICULO').AsString);
        vQueryCloud.ParamByName('TRANSPORTADOR_UFVEICULO').AsString := Trim(vQueryLocal.FieldByName('TRANSPORTADOR_UFVEICULO').AsString);
        vQueryCloud.ParamByName('ARQUIVO').AsString                 := Trim(vQueryLocal.FieldByName('ARQUIVO').AsString);
        vQueryCloud.ParamByName('EMPENHO_ANO').AsString             := Trim(vQueryLocal.FieldByName('EMPENHO_ANO').AsString);
        vQueryCloud.ParamByName('EMPENHO_COMPLETO').AsString        := Trim(vQueryLocal.FieldByName('EMPENHO_COMPLETO').AsString);
        vQueryCloud.ParamByName('SYNC').AsString        := 'S';
        vQueryCloud.ParamByName('SYNC_DATA').AsDateTime := vlData;

        vQueryCloud.ExecSQL;
        vQueryCloud.Transaction.CommitRetaining;

        vQueryUpdateLocal.Close;
        vQueryUpdateLocal.SQL.Clear;
        vQueryUpdateLocal.SQL.Add('UPDATE TBPEDIDO SET SYNC = ''S'', SYNC_DATA = :SYNC_DATA WHERE PEDIDO_ID = :PEDIDO_ID');

        vQueryUpdateLocal.ParamByName('SYNC_DATA').AsDateTime := vlData;
        vQueryUpdateLocal.ParamByName('PEDIDO_ID').AsInteger := vQueryLocal.FieldByName('PEDIDO_ID').AsInteger;

        vQueryUpdateLocal.ExecSQL;
        vQueryUpdateLocal.Transaction.CommitRetaining;

        Memo_Log.Lines.Add('Pedido atualizado em ' + FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ': ' +
                           Trim(vQueryLocal.FieldByName('PEDIDO_ID').AsString) + ' - ' + Trim(vQueryLocal.FieldByName('PEDIDO_NUM').AsString));
      except
        on E: Exception do
        begin
          Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ' - Erro ao atualizar Pedido: ' + E.Message);
          vQueryCloud.Transaction.RollbackRetaining;
          dm1.IBDatabase1.Connected := False;
          dm1.IBDatabase1.Connected := True;

          dm1.IBDatabaseCloudSICFAR.Connected := False;
          dm1.IBDatabaseCloudSICFAR.Connected := True;
        end;
      end;

      vQueryLocal.Next;
      Application.ProcessMessages;
    end;
  finally
    vQueryLocal.Free;
    vQueryCloud.Free;
    vQueryUpdateLocal.Free;
  end;
end;

procedure TForm_PrincipalServer.pAtualizaPessoasCloudToLocal(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);
var
  vQueryLocal, vQueryCloud, vQueryUpdateCloud: TIBQuery;
  vlData: TDateTime;
begin
  vQueryLocal := TIBQuery.Create(self);
  vQueryCloud := TIBQuery.Create(self);
  vQueryUpdateCloud := TIBQuery.Create(self);

  try
    vQueryLocal.Database := ALocalDatabase;
    vQueryLocal.Transaction := ALocalTransaction;

    vQueryCloud.Database := ACloudDatabase;
    vQueryCloud.Transaction := ACloudTransaction;

    vQueryUpdateCloud.Database := ACloudDatabase;
    vQueryUpdateCloud.Transaction := ACloudTransaction;

    vQueryCloud.Close;
    vQueryCloud.SQL.Text := 'SELECT * FROM TBPESSOAS WHERE SYNC = ''N''';
    vQueryCloud.Open;
    vQueryCloud.First;
    while not vQueryCloud.Eof do
    begin
      try
        vlData := Now;
        vQueryLocal.Close;
        vQueryLocal.SQL.Clear;
        vQueryLocal.SQL.Add('UPDATE OR INSERT INTO TBPESSOAS (');
        vQueryLocal.SQL.Add('PESSOA_ID, PESSOA_VR, EMPRESA_ID, USUARIO_ID, NOME_PUPULAR, NOME, ENDERECO, COMPLEMENTO, BAIRRO,');
        vQueryLocal.SQL.Add('CIDADE, UF, CEP, NATURALIDADE, NASCIMENTO, SEXO, TIPO, CPF_CNPJ, RG_CGF, ESTCIVIL, CLASSES,');
        vQueryLocal.SQL.Add('OBS, PAI, MAE, LIMITE_CREDITO, ENT_NOME, ENT_ENDERECO, ENT_BAIRRO, ENT_CIDADE, ENT_UF, ENT_FONE,');
        vQueryLocal.SQL.Add('FONE_01, FONE_02, FONE_03, FONE_04, CONJUGE, COMISSAO, DATACADASTRO, ALTERADO, REF_01NOME,');
        vQueryLocal.SQL.Add('REF_02NOME, REF_03NOME, REF_01FONE, REF_02FONE, REF_03FONE, COB_ENDERECO, COB_BAIRRO, COB_CIDADE,');
        vQueryLocal.SQL.Add('COB_UF, COB_CEP, SITUACAO, CONTABIL, DATA_ALT, DELETADO, DATA_INC, TIPO_TRANSP, EMAIL, SITE,');
        vQueryLocal.SQL.Add('CODIGO_ANTT, REC_CONTRATO, REC_CONTRATO_DATA, REC_DIMOB, REC_DIMOB_DATA, IDSOFT, CPF_CONJUGE,');
        vQueryLocal.SQL.Add('RG_CONJUGE, RG_ORGAO, RG_UF, RG_ORGAO_CONJUGE, RG_UF_CONJUGE, PROFISSAO, NATURAL_ID, NACIONALIDADE,');
        vQueryLocal.SQL.Add('REGIME_CASAMENTO, RENDA_CONJUGE, NACIONALIDADE_CONJUGE, PROFISSAO_CONJUGE, NUMERO, SUFRAMA, CIDADE_ID,');
        vQueryLocal.SQL.Add('PAIS_ID, MEMBRO, EQUIPE_ID, FOTO, DATA_BATISMO, DATA_CONVERSAO, DATA_MEMBRO, EMPREGADO, DOM_ID,');
        vQueryLocal.SQL.Add('DATA_AFASTADO, CARGO_ID, FUNCAO_ID, VIUVO, ORFAO, GRUPO_ID, SUBGRUPO_ID, NASCIMENTO_CONJUGE,');
        vQueryLocal.SQL.Add('PAGAMENTO_ID, ORACAO, PAGAMENTO_VALOR, DIA_VENCIMENTO, PERIODO, DC, FV, IMPOSTOS, PESSOAL,');
        vQueryLocal.SQL.Add('CAMPANHA_ID, VALOR_CONTRIBUICAO, CAPTADOR, CC_ID, TIPO_CLIENTE, CONTRIBUINTE, ESPECIE, CNH, CNH_CATEGORIA,');
        vQueryLocal.SQL.Add('CNH_EMISSAO, CNH_EMISSAO1, CNH_VENCIMENTO, RG_EMISSAO, USUARIONOME_I, USUARIO_A, USUARIONOME_A, USUARIO_D,');
        vQueryLocal.SQL.Add('USUARIONOME_D, DATA_DEL, RECNO, ERP_CODIGO, REPLICADO, ID_OLD, TIPO_FISCAL, CRACHA, NOME_CRACHA, BATE_PONTO,');
        vQueryLocal.SQL.Add('CARGO, FUNCAO, DATA_EXAME, PROXIMO_EXAME, DEPARTAMENTO_ID_SEG, DEPARTAMENTO_SEG, CTPS_N, CTPS_S, CTPS_UF,');
        vQueryLocal.SQL.Add('NIT, DEPARTAMENTO_ID, DEPARTAMENTO, COMPRAS, FUNCIONARIOS, CTPS_EMISSAO, CNH_UF, DATA_ADMISSAO,');
        vQueryLocal.SQL.Add('DEFICIENCIA, TIPO_DEFICIENCIA, CONTRIBUICAO_SINDICAL, CONTRATO_EXPERIENCIA, APRENDIZ, PRIMEIRO_EMPREGO,');
        vQueryLocal.SQL.Add('TITULO_NUMERO, TITULO_ZONA, TITULO_SECAO, BANCO_ID, BANCO, AGENCIA, CONTA, SALARIO, COR, GRAU_INSTRUCAO,');
        vQueryLocal.SQL.Add('ULTIMA_COMPRA, BLOQUEADO, BLOQUEIO_ID, VENDEDOR, CONTATORH_ID, CONTATORH, DIA_FATURA, OPF, OPF_DESCRICAO,');
        vQueryLocal.SQL.Add('MES_VENCIMENTO, PIS, SETOR_ID, SETOR, WHATSAPP, SYNC, SYNC_DATA)');
        vQueryLocal.SQL.Add('VALUES (');
        vQueryLocal.SQL.Add(':PESSOA_ID, :PESSOA_VR, :EMPRESA_ID, :USUARIO_ID, :NOME_PUPULAR, :NOME, :ENDERECO, :COMPLEMENTO, :BAIRRO,');
        vQueryLocal.SQL.Add(':CIDADE, :UF, :CEP, :NATURALIDADE, :NASCIMENTO, :SEXO, :TIPO, :CPF_CNPJ, :RG_CGF, :ESTCIVIL, :CLASSES,');
        vQueryLocal.SQL.Add(':OBS, :PAI, :MAE, :LIMITE_CREDITO, :ENT_NOME, :ENT_ENDERECO, :ENT_BAIRRO, :ENT_CIDADE, :ENT_UF, :ENT_FONE,');
        vQueryLocal.SQL.Add(':FONE_01, :FONE_02, :FONE_03, :FONE_04, :CONJUGE, :COMISSAO, :DATACADASTRO, :ALTERADO, :REF_01NOME,');
        vQueryLocal.SQL.Add(':REF_02NOME, :REF_03NOME, :REF_01FONE, :REF_02FONE, :REF_03FONE, :COB_ENDERECO, :COB_BAIRRO, :COB_CIDADE,');
        vQueryLocal.SQL.Add(':COB_UF, :COB_CEP, :SITUACAO, :CONTABIL, :DATA_ALT, :DELETADO, :DATA_INC, :TIPO_TRANSP, :EMAIL, :SITE,');
        vQueryLocal.SQL.Add(':CODIGO_ANTT, :REC_CONTRATO, :REC_CONTRATO_DATA, :REC_DIMOB, :REC_DIMOB_DATA, :IDSOFT, :CPF_CONJUGE,');
        vQueryLocal.SQL.Add(':RG_CONJUGE, :RG_ORGAO, :RG_UF, :RG_ORGAO_CONJUGE, :RG_UF_CONJUGE, :PROFISSAO, :NATURAL_ID, :NACIONALIDADE,');
        vQueryLocal.SQL.Add(':REGIME_CASAMENTO, :RENDA_CONJUGE, :NACIONALIDADE_CONJUGE, :PROFISSAO_CONJUGE, :NUMERO, :SUFRAMA, :CIDADE_ID,');
        vQueryLocal.SQL.Add(':PAIS_ID, :MEMBRO, :EQUIPE_ID, :FOTO, :DATA_BATISMO, :DATA_CONVERSAO, :DATA_MEMBRO, :EMPREGADO, :DOM_ID,');
        vQueryLocal.SQL.Add(':DATA_AFASTADO, :CARGO_ID, :FUNCAO_ID, :VIUVO, :ORFAO, :GRUPO_ID, :SUBGRUPO_ID, :NASCIMENTO_CONJUGE,');
        vQueryLocal.SQL.Add(':PAGAMENTO_ID, :ORACAO, :PAGAMENTO_VALOR, :DIA_VENCIMENTO, :PERIODO, :DC, :FV, :IMPOSTOS, :PESSOAL,');
        vQueryLocal.SQL.Add(':CAMPANHA_ID, :VALOR_CONTRIBUICAO, :CAPTADOR, :CC_ID, :TIPO_CLIENTE, :CONTRIBUINTE, :ESPECIE, :CNH, :CNH_CATEGORIA,');
        vQueryLocal.SQL.Add(':CNH_EMISSAO, :CNH_EMISSAO1, :CNH_VENCIMENTO, :RG_EMISSAO, :USUARIONOME_I, :USUARIO_A, :USUARIONOME_A, :USUARIO_D,');
        vQueryLocal.SQL.Add(':USUARIONOME_D, :DATA_DEL, :RECNO, :ERP_CODIGO, :REPLICADO, :ID_OLD, :TIPO_FISCAL, :CRACHA, :NOME_CRACHA, :BATE_PONTO,');
        vQueryLocal.SQL.Add(':CARGO, :FUNCAO, :DATA_EXAME, :PROXIMO_EXAME, :DEPARTAMENTO_ID_SEG, :DEPARTAMENTO_SEG, :CTPS_N, :CTPS_S, :CTPS_UF,');
        vQueryLocal.SQL.Add(':NIT, :DEPARTAMENTO_ID, :DEPARTAMENTO, :COMPRAS, :FUNCIONARIOS, :CTPS_EMISSAO, :CNH_UF, :DATA_ADMISSAO,');
        vQueryLocal.SQL.Add(':DEFICIENCIA, :TIPO_DEFICIENCIA, :CONTRIBUICAO_SINDICAL, :CONTRATO_EXPERIENCIA, :APRENDIZ, :PRIMEIRO_EMPREGO,');
        vQueryLocal.SQL.Add(':TITULO_NUMERO, :TITULO_ZONA, :TITULO_SECAO, :BANCO_ID, :BANCO, :AGENCIA, :CONTA, :SALARIO, :COR, :GRAU_INSTRUCAO,');
        vQueryLocal.SQL.Add(':ULTIMA_COMPRA, :BLOQUEADO, :BLOQUEIO_ID, :VENDEDOR, :CONTATORH_ID, :CONTATORH, :DIA_FATURA, :OPF, :OPF_DESCRICAO,');
        vQueryLocal.SQL.Add(':MES_VENCIMENTO, :PIS, :SETOR_ID, :SETOR, :WHATSAPP, :SYNC, :SYNC_DATA)');
        vQueryLocal.SQL.Add('MATCHING (PESSOA_ID)');

        // Parametros
        vQueryLocal.ParamByName('PESSOA_ID').AsString := vQueryCloud.FieldByName('PESSOA_ID').AsString;
        vQueryLocal.ParamByName('PESSOA_VR').AsString := vQueryCloud.FieldByName('PESSOA_VR').AsString;
        vQueryLocal.ParamByName('EMPRESA_ID').AsString := vQueryCloud.FieldByName('EMPRESA_ID').AsString;
        vQueryLocal.ParamByName('USUARIO_ID').AsString := vQueryCloud.FieldByName('USUARIO_ID').AsString;
        vQueryLocal.ParamByName('NOME_PUPULAR').AsString := vQueryCloud.FieldByName('NOME_PUPULAR').AsString;
        vQueryLocal.ParamByName('NOME').AsString := vQueryCloud.FieldByName('NOME').AsString;
        if not vQueryCloud.FieldByName('ENDERECO').IsNull then
          vQueryLocal.ParamByName('ENDERECO').AsString := vQueryCloud.FieldByName('ENDERECO').AsString;
        if not vQueryCloud.FieldByName('COMPLEMENTO').IsNull then
          vQueryLocal.ParamByName('COMPLEMENTO').AsString := vQueryCloud.FieldByName('COMPLEMENTO').AsString;
        if not vQueryCloud.FieldByName('BAIRRO').IsNull then
          vQueryLocal.ParamByName('BAIRRO').AsString := vQueryCloud.FieldByName('BAIRRO').AsString;
        if not vQueryCloud.FieldByName('CIDADE').IsNull then
          vQueryLocal.ParamByName('CIDADE').AsString := vQueryCloud.FieldByName('CIDADE').AsString;
        if not vQueryCloud.FieldByName('UF').IsNull then
          vQueryLocal.ParamByName('UF').AsString := vQueryCloud.FieldByName('UF').AsString;
        if not vQueryCloud.FieldByName('CEP').IsNull then
          vQueryLocal.ParamByName('CEP').AsString := vQueryCloud.FieldByName('CEP').AsString;
        if not vQueryCloud.FieldByName('NATURALIDADE').IsNull then
          vQueryLocal.ParamByName('NATURALIDADE').AsString := vQueryCloud.FieldByName('NATURALIDADE').AsString;
        if not vQueryCloud.FieldByName('NASCIMENTO').IsNull then
          vQueryLocal.ParamByName('NASCIMENTO').AsDateTime := vQueryCloud.FieldByName('NASCIMENTO').AsDateTime;
        vQueryLocal.ParamByName('SEXO').AsString := vQueryCloud.FieldByName('SEXO').AsString;
        vQueryLocal.ParamByName('TIPO').AsString := vQueryCloud.FieldByName('TIPO').AsString;
        if not vQueryCloud.FieldByName('CPF_CNPJ').IsNull then
          vQueryLocal.ParamByName('CPF_CNPJ').AsString := vQueryCloud.FieldByName('CPF_CNPJ').AsString;
        if not vQueryCloud.FieldByName('RG_CGF').IsNull then
          vQueryLocal.ParamByName('RG_CGF').AsString := vQueryCloud.FieldByName('RG_CGF').AsString;
        vQueryLocal.ParamByName('ESTCIVIL').AsString := vQueryCloud.FieldByName('ESTCIVIL').AsString;
        vQueryLocal.ParamByName('CLASSES').AsString := vQueryCloud.FieldByName('CLASSES').AsString;
        if not vQueryCloud.FieldByName('OBS').IsNull then
          vQueryLocal.ParamByName('OBS').AsString := vQueryCloud.FieldByName('OBS').AsString;
        if not vQueryCloud.FieldByName('PAI').IsNull then
          vQueryLocal.ParamByName('PAI').AsString := vQueryCloud.FieldByName('PAI').AsString;
        if not vQueryCloud.FieldByName('MAE').IsNull then
          vQueryLocal.ParamByName('MAE').AsString := vQueryCloud.FieldByName('MAE').AsString;
        if not vQueryCloud.FieldByName('LIMITE_CREDITO').IsNull then
          vQueryLocal.ParamByName('LIMITE_CREDITO').AsFloat := vQueryCloud.FieldByName('LIMITE_CREDITO').AsFloat;
        if not vQueryCloud.FieldByName('ENT_NOME').IsNull then
          vQueryLocal.ParamByName('ENT_NOME').AsString := vQueryCloud.FieldByName('ENT_NOME').AsString;
        if not vQueryCloud.FieldByName('ENT_ENDERECO').IsNull then
          vQueryLocal.ParamByName('ENT_ENDERECO').AsString := vQueryCloud.FieldByName('ENT_ENDERECO').AsString;
        if not vQueryCloud.FieldByName('ENT_BAIRRO').IsNull then
          vQueryLocal.ParamByName('ENT_BAIRRO').AsString := vQueryCloud.FieldByName('ENT_BAIRRO').AsString;
        if not vQueryCloud.FieldByName('ENT_CIDADE').IsNull then
          vQueryLocal.ParamByName('ENT_CIDADE').AsString := vQueryCloud.FieldByName('ENT_CIDADE').AsString;
        if not vQueryCloud.FieldByName('ENT_UF').IsNull then
          vQueryLocal.ParamByName('ENT_UF').AsString := vQueryCloud.FieldByName('ENT_UF').AsString;
        if not vQueryCloud.FieldByName('ENT_FONE').IsNull then
          vQueryLocal.ParamByName('ENT_FONE').AsString := vQueryCloud.FieldByName('ENT_FONE').AsString;
        if not vQueryCloud.FieldByName('FONE_01').IsNull then
          vQueryLocal.ParamByName('FONE_01').AsString := vQueryCloud.FieldByName('FONE_01').AsString;
        if not vQueryCloud.FieldByName('FONE_02').IsNull then
          vQueryLocal.ParamByName('FONE_02').AsString := vQueryCloud.FieldByName('FONE_02').AsString;
        if not vQueryCloud.FieldByName('FONE_03').IsNull then
          vQueryLocal.ParamByName('FONE_03').AsString := vQueryCloud.FieldByName('FONE_03').AsString;
        if not vQueryCloud.FieldByName('FONE_04').IsNull then
          vQueryLocal.ParamByName('FONE_04').AsString := vQueryCloud.FieldByName('FONE_04').AsString;
        if not vQueryCloud.FieldByName('CONJUGE').IsNull then
          vQueryLocal.ParamByName('CONJUGE').AsString := vQueryCloud.FieldByName('CONJUGE').AsString;
        if not vQueryCloud.FieldByName('COMISSAO').IsNull then
          vQueryLocal.ParamByName('COMISSAO').AsFloat := vQueryCloud.FieldByName('COMISSAO').AsFloat;
        if not vQueryCloud.FieldByName('DATACADASTRO').IsNull then
          vQueryLocal.ParamByName('DATACADASTRO').AsDateTime := vQueryCloud.FieldByName('DATACADASTRO').AsDateTime;
        if not vQueryCloud.FieldByName('ALTERADO').IsNull then
          vQueryLocal.ParamByName('ALTERADO').AsDateTime := vQueryCloud.FieldByName('ALTERADO').AsDateTime;
        if not vQueryCloud.FieldByName('REF_01NOME').IsNull then
          vQueryLocal.ParamByName('REF_01NOME').AsString := vQueryCloud.FieldByName('REF_01NOME').AsString;
        if not vQueryCloud.FieldByName('REF_02NOME').IsNull then
          vQueryLocal.ParamByName('REF_02NOME').AsString := vQueryCloud.FieldByName('REF_02NOME').AsString;
        if not vQueryCloud.FieldByName('REF_03NOME').IsNull then
          vQueryLocal.ParamByName('REF_03NOME').AsString := vQueryCloud.FieldByName('REF_03NOME').AsString;
        if not vQueryCloud.FieldByName('REF_01FONE').IsNull then
          vQueryLocal.ParamByName('REF_01FONE').AsString := vQueryCloud.FieldByName('REF_01FONE').AsString;
        if not vQueryCloud.FieldByName('REF_02FONE').IsNull then
          vQueryLocal.ParamByName('REF_02FONE').AsString := vQueryCloud.FieldByName('REF_02FONE').AsString;
        if not vQueryCloud.FieldByName('REF_03FONE').IsNull then
          vQueryLocal.ParamByName('REF_03FONE').AsString := vQueryCloud.FieldByName('REF_03FONE').AsString;
        if not vQueryCloud.FieldByName('COB_ENDERECO').IsNull then
          vQueryLocal.ParamByName('COB_ENDERECO').AsString := vQueryCloud.FieldByName('COB_ENDERECO').AsString;
        if not vQueryCloud.FieldByName('COB_BAIRRO').IsNull then
          vQueryLocal.ParamByName('COB_BAIRRO').AsString := vQueryCloud.FieldByName('COB_BAIRRO').AsString;
        if not vQueryCloud.FieldByName('COB_CIDADE').IsNull then
          vQueryLocal.ParamByName('COB_CIDADE').AsString := vQueryCloud.FieldByName('COB_CIDADE').AsString;
        if not vQueryCloud.FieldByName('COB_UF').IsNull then
          vQueryLocal.ParamByName('COB_UF').AsString := vQueryCloud.FieldByName('COB_UF').AsString;
        if not vQueryCloud.FieldByName('COB_CEP').IsNull then
          vQueryLocal.ParamByName('COB_CEP').AsString := vQueryCloud.FieldByName('COB_CEP').AsString;
        vQueryLocal.ParamByName('SITUACAO').AsString := vQueryCloud.FieldByName('SITUACAO').AsString;
        if not vQueryCloud.FieldByName('CONTABIL').IsNull then
          vQueryLocal.ParamByName('CONTABIL').AsString := vQueryCloud.FieldByName('CONTABIL').AsString;
        if not vQueryCloud.FieldByName('DATA_ALT').IsNull then
          vQueryLocal.ParamByName('DATA_ALT').AsDateTime := vQueryCloud.FieldByName('DATA_ALT').AsDateTime;
        vQueryLocal.ParamByName('DELETADO').AsString := vQueryCloud.FieldByName('DELETADO').AsString;
        if not vQueryCloud.FieldByName('DATA_INC').IsNull then
          vQueryLocal.ParamByName('DATA_INC').AsDateTime := vQueryCloud.FieldByName('DATA_INC').AsDateTime;
        if not vQueryCloud.FieldByName('TIPO_TRANSP').IsNull then
          vQueryLocal.ParamByName('TIPO_TRANSP').AsString := vQueryCloud.FieldByName('TIPO_TRANSP').AsString;
        if not vQueryCloud.FieldByName('EMAIL').IsNull then
          vQueryLocal.ParamByName('EMAIL').AsString := vQueryCloud.FieldByName('EMAIL').AsString;
        if not vQueryCloud.FieldByName('SITE').IsNull then
          vQueryLocal.ParamByName('SITE').AsString := vQueryCloud.FieldByName('SITE').AsString;
        if not vQueryCloud.FieldByName('CODIGO_ANTT').IsNull then
          vQueryLocal.ParamByName('CODIGO_ANTT').AsString := vQueryCloud.FieldByName('CODIGO_ANTT').AsString;
        if not vQueryCloud.FieldByName('REC_CONTRATO').IsNull then
          vQueryLocal.ParamByName('REC_CONTRATO').AsString := vQueryCloud.FieldByName('REC_CONTRATO').AsString;
        if not vQueryCloud.FieldByName('REC_CONTRATO_DATA').IsNull then
          vQueryLocal.ParamByName('REC_CONTRATO_DATA').AsDateTime := vQueryCloud.FieldByName('REC_CONTRATO_DATA').AsDateTime;
        if not vQueryCloud.FieldByName('REC_DIMOB').IsNull then
          vQueryLocal.ParamByName('REC_DIMOB').AsString := vQueryCloud.FieldByName('REC_DIMOB').AsString;
        if not vQueryCloud.FieldByName('REC_DIMOB_DATA').IsNull then
          vQueryLocal.ParamByName('REC_DIMOB_DATA').AsDateTime := vQueryCloud.FieldByName('REC_DIMOB_DATA').AsDateTime;
        if not vQueryCloud.FieldByName('IDSOFT').IsNull then
          vQueryLocal.ParamByName('IDSOFT').AsString := vQueryCloud.FieldByName('IDSOFT').AsString;
        if not vQueryCloud.FieldByName('CPF_CONJUGE').IsNull then
          vQueryLocal.ParamByName('CPF_CONJUGE').AsString := vQueryCloud.FieldByName('CPF_CONJUGE').AsString;
        if not vQueryCloud.FieldByName('RG_CONJUGE').IsNull then
          vQueryLocal.ParamByName('RG_CONJUGE').AsString := vQueryCloud.FieldByName('RG_CONJUGE').AsString;
        if not vQueryCloud.FieldByName('RG_ORGAO').IsNull then
          vQueryLocal.ParamByName('RG_ORGAO').AsString := vQueryCloud.FieldByName('RG_ORGAO').AsString;
        if not vQueryCloud.FieldByName('RG_UF').IsNull then
          vQueryLocal.ParamByName('RG_UF').AsString := vQueryCloud.FieldByName('RG_UF').AsString;
        if not vQueryCloud.FieldByName('RG_ORGAO_CONJUGE').IsNull then
          vQueryLocal.ParamByName('RG_ORGAO_CONJUGE').AsString := vQueryCloud.FieldByName('RG_ORGAO_CONJUGE').AsString;
        if not vQueryCloud.FieldByName('RG_UF_CONJUGE').IsNull then
          vQueryLocal.ParamByName('RG_UF_CONJUGE').AsString := vQueryCloud.FieldByName('RG_UF_CONJUGE').AsString;
        if not vQueryCloud.FieldByName('PROFISSAO').IsNull then
          vQueryLocal.ParamByName('PROFISSAO').AsString := vQueryCloud.FieldByName('PROFISSAO').AsString;
        if not vQueryCloud.FieldByName('NATURAL_ID').IsNull then
          vQueryLocal.ParamByName('NATURAL_ID').AsString := vQueryCloud.FieldByName('NATURAL_ID').AsString;
        if not vQueryCloud.FieldByName('NACIONALIDADE').IsNull then
          vQueryLocal.ParamByName('NACIONALIDADE').AsString := vQueryCloud.FieldByName('NACIONALIDADE').AsString;
        if not vQueryCloud.FieldByName('REGIME_CASAMENTO').IsNull then
          vQueryLocal.ParamByName('REGIME_CASAMENTO').AsString := vQueryCloud.FieldByName('REGIME_CASAMENTO').AsString;
        if not vQueryCloud.FieldByName('RENDA_CONJUGE').IsNull then
          vQueryLocal.ParamByName('RENDA_CONJUGE').AsFloat := vQueryCloud.FieldByName('RENDA_CONJUGE').AsFloat;
        if not vQueryCloud.FieldByName('NACIONALIDADE_CONJUGE').IsNull then
          vQueryLocal.ParamByName('NACIONALIDADE_CONJUGE').AsString := vQueryCloud.FieldByName('NACIONALIDADE_CONJUGE').AsString;
        if not vQueryCloud.FieldByName('PROFISSAO_CONJUGE').IsNull then
          vQueryLocal.ParamByName('PROFISSAO_CONJUGE').AsString := vQueryCloud.FieldByName('PROFISSAO_CONJUGE').AsString;
        if not vQueryCloud.FieldByName('NUMERO').IsNull then
          vQueryLocal.ParamByName('NUMERO').AsString := vQueryCloud.FieldByName('NUMERO').AsString;
        if not vQueryCloud.FieldByName('SUFRAMA').IsNull then
          vQueryLocal.ParamByName('SUFRAMA').AsString := vQueryCloud.FieldByName('SUFRAMA').AsString;
        if not vQueryCloud.FieldByName('CIDADE_ID').IsNull then
          vQueryLocal.ParamByName('CIDADE_ID').AsString := vQueryCloud.FieldByName('CIDADE_ID').AsString;
        if not vQueryCloud.FieldByName('PAIS_ID').IsNull then
          vQueryLocal.ParamByName('PAIS_ID').AsString := vQueryCloud.FieldByName('PAIS_ID').AsString;
        if not vQueryCloud.FieldByName('MEMBRO').IsNull then
          vQueryLocal.ParamByName('MEMBRO').AsString := vQueryCloud.FieldByName('MEMBRO').AsString;
        if not vQueryCloud.FieldByName('EQUIPE_ID').IsNull then
          vQueryLocal.ParamByName('EQUIPE_ID').AsString := vQueryCloud.FieldByName('EQUIPE_ID').AsString;
        if not vQueryCloud.FieldByName('FOTO').IsNull then
          vQueryLocal.ParamByName('FOTO').AsString := vQueryCloud.FieldByName('FOTO').AsString;
        if not vQueryCloud.FieldByName('DATA_BATISMO').IsNull then
          vQueryLocal.ParamByName('DATA_BATISMO').AsDateTime := vQueryCloud.FieldByName('DATA_BATISMO').AsDateTime;
        if not vQueryCloud.FieldByName('DATA_CONVERSAO').IsNull then
          vQueryLocal.ParamByName('DATA_CONVERSAO').AsDateTime := vQueryCloud.FieldByName('DATA_CONVERSAO').AsDateTime;
        if not vQueryCloud.FieldByName('DATA_MEMBRO').IsNull then
          vQueryLocal.ParamByName('DATA_MEMBRO').AsDateTime := vQueryCloud.FieldByName('DATA_MEMBRO').AsDateTime;
        if not vQueryCloud.FieldByName('EMPREGADO').IsNull then
          vQueryLocal.ParamByName('EMPREGADO').AsString := vQueryCloud.FieldByName('EMPREGADO').AsString;
        if not vQueryCloud.FieldByName('DOM_ID').IsNull then
          vQueryLocal.ParamByName('DOM_ID').AsString := vQueryCloud.FieldByName('DOM_ID').AsString;
        if not vQueryCloud.FieldByName('DATA_AFASTADO').IsNull then
          vQueryLocal.ParamByName('DATA_AFASTADO').AsDateTime := vQueryCloud.FieldByName('DATA_AFASTADO').AsDateTime;
        if not vQueryCloud.FieldByName('CARGO_ID').IsNull then
          vQueryLocal.ParamByName('CARGO_ID').AsString := vQueryCloud.FieldByName('CARGO_ID').AsString;
        if not vQueryCloud.FieldByName('FUNCAO_ID').IsNull then
          vQueryLocal.ParamByName('FUNCAO_ID').AsString := vQueryCloud.FieldByName('FUNCAO_ID').AsString;
        if not vQueryCloud.FieldByName('VIUVO').IsNull then
          vQueryLocal.ParamByName('VIUVO').AsString := vQueryCloud.FieldByName('VIUVO').AsString;
        if not vQueryCloud.FieldByName('ORFAO').IsNull then
          vQueryLocal.ParamByName('ORFAO').AsString := vQueryCloud.FieldByName('ORFAO').AsString;
        if not vQueryCloud.FieldByName('GRUPO_ID').IsNull then
          vQueryLocal.ParamByName('GRUPO_ID').AsString := vQueryCloud.FieldByName('GRUPO_ID').AsString;
        if not vQueryCloud.FieldByName('SUBGRUPO_ID').IsNull then
          vQueryLocal.ParamByName('SUBGRUPO_ID').AsString := vQueryCloud.FieldByName('SUBGRUPO_ID').AsString;
        if not vQueryCloud.FieldByName('NASCIMENTO_CONJUGE').IsNull then
          vQueryLocal.ParamByName('NASCIMENTO_CONJUGE').AsDateTime := vQueryCloud.FieldByName('NASCIMENTO_CONJUGE').AsDateTime;
        if not vQueryCloud.FieldByName('PAGAMENTO_ID').IsNull then
          vQueryLocal.ParamByName('PAGAMENTO_ID').AsString := vQueryCloud.FieldByName('PAGAMENTO_ID').AsString;
        if not vQueryCloud.FieldByName('ORACAO').IsNull then
          vQueryLocal.ParamByName('ORACAO').AsString := vQueryCloud.FieldByName('ORACAO').AsString;
        if not vQueryCloud.FieldByName('PAGAMENTO_VALOR').IsNull then
          vQueryLocal.ParamByName('PAGAMENTO_VALOR').AsFloat := vQueryCloud.FieldByName('PAGAMENTO_VALOR').AsFloat;
        if not vQueryCloud.FieldByName('DIA_VENCIMENTO').IsNull then
          vQueryLocal.ParamByName('DIA_VENCIMENTO').AsString := vQueryCloud.FieldByName('DIA_VENCIMENTO').AsString;
        if not vQueryCloud.FieldByName('PERIODO').IsNull then
          vQueryLocal.ParamByName('PERIODO').AsString := vQueryCloud.FieldByName('PERIODO').AsString;
        if not vQueryCloud.FieldByName('DC').IsNull then
          vQueryLocal.ParamByName('DC').AsString := vQueryCloud.FieldByName('DC').AsString;
        if not vQueryCloud.FieldByName('FV').IsNull then
          vQueryLocal.ParamByName('FV').AsString := vQueryCloud.FieldByName('FV').AsString;
        if not vQueryCloud.FieldByName('IMPOSTOS').IsNull then
          vQueryLocal.ParamByName('IMPOSTOS').AsString := vQueryCloud.FieldByName('IMPOSTOS').AsString;
        if not vQueryCloud.FieldByName('PESSOAL').IsNull then
          vQueryLocal.ParamByName('PESSOAL').AsString := vQueryCloud.FieldByName('PESSOAL').AsString;
        if not vQueryCloud.FieldByName('CAMPANHA_ID').IsNull then
          vQueryLocal.ParamByName('CAMPANHA_ID').AsString := vQueryCloud.FieldByName('CAMPANHA_ID').AsString;
        if not vQueryCloud.FieldByName('VALOR_CONTRIBUICAO').IsNull then
          vQueryLocal.ParamByName('VALOR_CONTRIBUICAO').AsFloat := vQueryCloud.FieldByName('VALOR_CONTRIBUICAO').AsFloat;
        if not vQueryCloud.FieldByName('CAPTADOR').IsNull then
          vQueryLocal.ParamByName('CAPTADOR').AsString := vQueryCloud.FieldByName('CAPTADOR').AsString;
        if not vQueryCloud.FieldByName('CC_ID').IsNull then
          vQueryLocal.ParamByName('CC_ID').AsString := vQueryCloud.FieldByName('CC_ID').AsString;
        if not vQueryCloud.FieldByName('TIPO_CLIENTE').IsNull then
          vQueryLocal.ParamByName('TIPO_CLIENTE').AsString := vQueryCloud.FieldByName('TIPO_CLIENTE').AsString;
        if not vQueryCloud.FieldByName('CONTRIBUINTE').IsNull then
          vQueryLocal.ParamByName('CONTRIBUINTE').AsString := vQueryCloud.FieldByName('CONTRIBUINTE').AsString;
        if not vQueryCloud.FieldByName('ESPECIE').IsNull then
          vQueryLocal.ParamByName('ESPECIE').AsString := vQueryCloud.FieldByName('ESPECIE').AsString;
        if not vQueryCloud.FieldByName('CNH').IsNull then
          vQueryLocal.ParamByName('CNH').AsString := vQueryCloud.FieldByName('CNH').AsString;
        if not vQueryCloud.FieldByName('CNH_CATEGORIA').IsNull then
          vQueryLocal.ParamByName('CNH_CATEGORIA').AsString := vQueryCloud.FieldByName('CNH_CATEGORIA').AsString;
        if not vQueryCloud.FieldByName('CNH_EMISSAO').IsNull then
          vQueryLocal.ParamByName('CNH_EMISSAO').AsDateTime := vQueryCloud.FieldByName('CNH_EMISSAO').AsDateTime;
        if not vQueryCloud.FieldByName('CNH_EMISSAO1').IsNull then
          vQueryLocal.ParamByName('CNH_EMISSAO1').AsDateTime := vQueryCloud.FieldByName('CNH_EMISSAO1').AsDateTime;
        if not vQueryCloud.FieldByName('CNH_VENCIMENTO').IsNull then
          vQueryLocal.ParamByName('CNH_VENCIMENTO').AsDateTime := vQueryCloud.FieldByName('CNH_VENCIMENTO').AsDateTime;
        if not vQueryCloud.FieldByName('RG_EMISSAO').IsNull then
          vQueryLocal.ParamByName('RG_EMISSAO').AsDateTime := vQueryCloud.FieldByName('RG_EMISSAO').AsDateTime;
        if not vQueryCloud.FieldByName('USUARIONOME_I').IsNull then
          vQueryLocal.ParamByName('USUARIONOME_I').AsString := vQueryCloud.FieldByName('USUARIONOME_I').AsString;
        if not vQueryCloud.FieldByName('USUARIO_A').IsNull then
          vQueryLocal.ParamByName('USUARIO_A').AsString := vQueryCloud.FieldByName('USUARIO_A').AsString;
        if not vQueryCloud.FieldByName('USUARIONOME_A').IsNull then
          vQueryLocal.ParamByName('USUARIONOME_A').AsString := vQueryCloud.FieldByName('USUARIONOME_A').AsString;
        if not vQueryCloud.FieldByName('USUARIO_D').IsNull then
          vQueryLocal.ParamByName('USUARIO_D').AsString := vQueryCloud.FieldByName('USUARIO_D').AsString;
        if not vQueryCloud.FieldByName('USUARIONOME_D').IsNull then
          vQueryLocal.ParamByName('USUARIONOME_D').AsString := vQueryCloud.FieldByName('USUARIONOME_D').AsString;
        if not vQueryCloud.FieldByName('DATA_DEL').IsNull then
          vQueryLocal.ParamByName('DATA_DEL').AsDateTime := vQueryCloud.FieldByName('DATA_DEL').AsDateTime;
        if not vQueryCloud.FieldByName('RECNO').IsNull then
          vQueryLocal.ParamByName('RECNO').AsString := vQueryCloud.FieldByName('RECNO').AsString;
        if not vQueryCloud.FieldByName('ERP_CODIGO').IsNull then
          vQueryLocal.ParamByName('ERP_CODIGO').AsString := vQueryCloud.FieldByName('ERP_CODIGO').AsString;
        if not vQueryCloud.FieldByName('REPLICADO').IsNull then
          vQueryLocal.ParamByName('REPLICADO').AsString := vQueryCloud.FieldByName('REPLICADO').AsString;
        if not vQueryCloud.FieldByName('ID_OLD').IsNull then
          vQueryLocal.ParamByName('ID_OLD').AsString := vQueryCloud.FieldByName('ID_OLD').AsString;
        if not vQueryCloud.FieldByName('TIPO_FISCAL').IsNull then
          vQueryLocal.ParamByName('TIPO_FISCAL').AsString := vQueryCloud.FieldByName('TIPO_FISCAL').AsString;
        if not vQueryCloud.FieldByName('CRACHA').IsNull then
          vQueryLocal.ParamByName('CRACHA').AsString := vQueryCloud.FieldByName('CRACHA').AsString;
        if not vQueryCloud.FieldByName('NOME_CRACHA').IsNull then
          vQueryLocal.ParamByName('NOME_CRACHA').AsString := vQueryCloud.FieldByName('NOME_CRACHA').AsString;
        if not vQueryCloud.FieldByName('BATE_PONTO').IsNull then
          vQueryLocal.ParamByName('BATE_PONTO').AsString := vQueryCloud.FieldByName('BATE_PONTO').AsString;
        if not vQueryCloud.FieldByName('CARGO').IsNull then
          vQueryLocal.ParamByName('CARGO').AsString := vQueryCloud.FieldByName('CARGO').AsString;
        if not vQueryCloud.FieldByName('FUNCAO').IsNull then
          vQueryLocal.ParamByName('FUNCAO').AsString := vQueryCloud.FieldByName('FUNCAO').AsString;
        if not vQueryCloud.FieldByName('DATA_EXAME').IsNull then
          vQueryLocal.ParamByName('DATA_EXAME').AsDateTime := vQueryCloud.FieldByName('DATA_EXAME').AsDateTime;
        if not vQueryCloud.FieldByName('PROXIMO_EXAME').IsNull then
          vQueryLocal.ParamByName('PROXIMO_EXAME').AsDateTime := vQueryCloud.FieldByName('PROXIMO_EXAME').AsDateTime;
        if not vQueryCloud.FieldByName('DEPARTAMENTO_ID_SEG').IsNull then
          vQueryLocal.ParamByName('DEPARTAMENTO_ID_SEG').AsString := vQueryCloud.FieldByName('DEPARTAMENTO_ID_SEG').AsString;
        if not vQueryCloud.FieldByName('DEPARTAMENTO_SEG').IsNull then
          vQueryLocal.ParamByName('DEPARTAMENTO_SEG').AsString := vQueryCloud.FieldByName('DEPARTAMENTO_SEG').AsString;
        if not vQueryCloud.FieldByName('CTPS_N').IsNull then
          vQueryLocal.ParamByName('CTPS_N').AsString := vQueryCloud.FieldByName('CTPS_N').AsString;
        if not vQueryCloud.FieldByName('CTPS_S').IsNull then
          vQueryLocal.ParamByName('CTPS_S').AsString := vQueryCloud.FieldByName('CTPS_S').AsString;
        if not vQueryCloud.FieldByName('CTPS_UF').IsNull then
          vQueryLocal.ParamByName('CTPS_UF').AsString := vQueryCloud.FieldByName('CTPS_UF').AsString;
        if not vQueryCloud.FieldByName('NIT').IsNull then
          vQueryLocal.ParamByName('NIT').AsString := vQueryCloud.FieldByName('NIT').AsString;
        if not vQueryCloud.FieldByName('DEPARTAMENTO_ID').IsNull then
          vQueryLocal.ParamByName('DEPARTAMENTO_ID').AsString := vQueryCloud.FieldByName('DEPARTAMENTO_ID').AsString;
        if not vQueryCloud.FieldByName('DEPARTAMENTO').IsNull then
          vQueryLocal.ParamByName('DEPARTAMENTO').AsString := vQueryCloud.FieldByName('DEPARTAMENTO').AsString;
        if not vQueryCloud.FieldByName('COMPRAS').IsNull then
          vQueryLocal.ParamByName('COMPRAS').AsString := vQueryCloud.FieldByName('COMPRAS').AsString;
        if not vQueryCloud.FieldByName('FUNCIONARIOS').IsNull then
          vQueryLocal.ParamByName('FUNCIONARIOS').AsString := vQueryCloud.FieldByName('FUNCIONARIOS').AsString;
        if not vQueryCloud.FieldByName('CTPS_EMISSAO').IsNull then
          vQueryLocal.ParamByName('CTPS_EMISSAO').AsDateTime := vQueryCloud.FieldByName('CTPS_EMISSAO').AsDateTime;
        if not vQueryCloud.FieldByName('CNH_UF').IsNull then
          vQueryLocal.ParamByName('CNH_UF').AsString := vQueryCloud.FieldByName('CNH_UF').AsString;
        if not vQueryCloud.FieldByName('DATA_ADMISSAO').IsNull then
          vQueryLocal.ParamByName('DATA_ADMISSAO').AsDateTime := vQueryCloud.FieldByName('DATA_ADMISSAO').AsDateTime;
        if not vQueryCloud.FieldByName('DEFICIENCIA').IsNull then
          vQueryLocal.ParamByName('DEFICIENCIA').AsString := vQueryCloud.FieldByName('DEFICIENCIA').AsString;
        if not vQueryCloud.FieldByName('TIPO_DEFICIENCIA').IsNull then
          vQueryLocal.ParamByName('TIPO_DEFICIENCIA').AsString := vQueryCloud.FieldByName('TIPO_DEFICIENCIA').AsString;
        if not vQueryCloud.FieldByName('CONTRIBUICAO_SINDICAL').IsNull then
          vQueryLocal.ParamByName('CONTRIBUICAO_SINDICAL').AsString := vQueryCloud.FieldByName('CONTRIBUICAO_SINDICAL').AsString;
        if not vQueryCloud.FieldByName('CONTRATO_EXPERIENCIA').IsNull then
          vQueryLocal.ParamByName('CONTRATO_EXPERIENCIA').AsString := vQueryCloud.FieldByName('CONTRATO_EXPERIENCIA').AsString;
        if not vQueryCloud.FieldByName('APRENDIZ').IsNull then
          vQueryLocal.ParamByName('APRENDIZ').AsString := vQueryCloud.FieldByName('APRENDIZ').AsString;
        if not vQueryCloud.FieldByName('PRIMEIRO_EMPREGO').IsNull then
          vQueryLocal.ParamByName('PRIMEIRO_EMPREGO').AsString := vQueryCloud.FieldByName('PRIMEIRO_EMPREGO').AsString;
        if not vQueryCloud.FieldByName('TITULO_NUMERO').IsNull then
          vQueryLocal.ParamByName('TITULO_NUMERO').AsString := vQueryCloud.FieldByName('TITULO_NUMERO').AsString;
        if not vQueryCloud.FieldByName('TITULO_ZONA').IsNull then
          vQueryLocal.ParamByName('TITULO_ZONA').AsString := vQueryCloud.FieldByName('TITULO_ZONA').AsString;
        if not vQueryCloud.FieldByName('TITULO_SECAO').IsNull then
          vQueryLocal.ParamByName('TITULO_SECAO').AsString := vQueryCloud.FieldByName('TITULO_SECAO').AsString;
        if not vQueryCloud.FieldByName('BANCO_ID').IsNull then
          vQueryLocal.ParamByName('BANCO_ID').AsString := vQueryCloud.FieldByName('BANCO_ID').AsString;
        if not vQueryCloud.FieldByName('BANCO').IsNull then
          vQueryLocal.ParamByName('BANCO').AsString := vQueryCloud.FieldByName('BANCO').AsString;
        if not vQueryCloud.FieldByName('AGENCIA').IsNull then
          vQueryLocal.ParamByName('AGENCIA').AsString := vQueryCloud.FieldByName('AGENCIA').AsString;
        if not vQueryCloud.FieldByName('CONTA').IsNull then
          vQueryLocal.ParamByName('CONTA').AsString := vQueryCloud.FieldByName('CONTA').AsString;
        if not vQueryCloud.FieldByName('SALARIO').IsNull then
          vQueryLocal.ParamByName('SALARIO').AsFloat := vQueryCloud.FieldByName('SALARIO').AsFloat;
        if not vQueryCloud.FieldByName('COR').IsNull then
          vQueryLocal.ParamByName('COR').AsString := vQueryCloud.FieldByName('COR').AsString;
        if not vQueryCloud.FieldByName('GRAU_INSTRUCAO').IsNull then
          vQueryLocal.ParamByName('GRAU_INSTRUCAO').AsString := vQueryCloud.FieldByName('GRAU_INSTRUCAO').AsString;
        if not vQueryCloud.FieldByName('ULTIMA_COMPRA').IsNull then
          vQueryLocal.ParamByName('ULTIMA_COMPRA').AsDateTime := vQueryCloud.FieldByName('ULTIMA_COMPRA').AsDateTime;
        vQueryLocal.ParamByName('BLOQUEADO').AsString := vQueryCloud.FieldByName('BLOQUEADO').AsString;
        if not vQueryCloud.FieldByName('BLOQUEIO_ID').IsNull then
          vQueryLocal.ParamByName('BLOQUEIO_ID').AsString := vQueryCloud.FieldByName('BLOQUEIO_ID').AsString;
        if not vQueryCloud.FieldByName('VENDEDOR').IsNull then
          vQueryLocal.ParamByName('VENDEDOR').AsString := vQueryCloud.FieldByName('VENDEDOR').AsString;
        if not vQueryCloud.FieldByName('CONTATORH_ID').IsNull then
          vQueryLocal.ParamByName('CONTATORH_ID').AsString := vQueryCloud.FieldByName('CONTATORH_ID').AsString;
        if not vQueryCloud.FieldByName('CONTATORH').IsNull then
          vQueryLocal.ParamByName('CONTATORH').AsString := vQueryCloud.FieldByName('CONTATORH').AsString;
        if not vQueryCloud.FieldByName('DIA_FATURA').IsNull then
          vQueryLocal.ParamByName('DIA_FATURA').AsString := vQueryCloud.FieldByName('DIA_FATURA').AsString;
        if not vQueryCloud.FieldByName('OPF').IsNull then
          vQueryLocal.ParamByName('OPF').AsString := vQueryCloud.FieldByName('OPF').AsString;
        if not vQueryCloud.FieldByName('OPF_DESCRICAO').IsNull then
          vQueryLocal.ParamByName('OPF_DESCRICAO').AsString := vQueryCloud.FieldByName('OPF_DESCRICAO').AsString;
        if not vQueryCloud.FieldByName('MES_VENCIMENTO').IsNull then
          vQueryLocal.ParamByName('MES_VENCIMENTO').AsString := vQueryCloud.FieldByName('MES_VENCIMENTO').AsString;
        if not vQueryCloud.FieldByName('PIS').IsNull then
          vQueryLocal.ParamByName('PIS').AsString := vQueryCloud.FieldByName('PIS').AsString;
        if not vQueryCloud.FieldByName('SETOR_ID').IsNull then
          vQueryLocal.ParamByName('SETOR_ID').AsString := vQueryCloud.FieldByName('SETOR_ID').AsString;
        if not vQueryCloud.FieldByName('SETOR').IsNull then
          vQueryLocal.ParamByName('SETOR').AsString := vQueryCloud.FieldByName('SETOR').AsString;
        if not vQueryCloud.FieldByName('WHATSAPP').IsNull then
          vQueryLocal.ParamByName('WHATSAPP').AsString := vQueryCloud.FieldByName('WHATSAPP').AsString;
        vQueryLocal.ParamByName('SYNC').AsString := 'S';
        vQueryLocal.ParamByName('SYNC_DATA').AsDateTime := vlData;

        vQueryLocal.ExecSQL;
        vQueryLocal.Transaction.CommitRetaining;

        vQueryUpdateCloud.Close;
        vQueryUpdateCloud.SQL.Clear;
        vQueryUpdateCloud.SQL.Add('UPDATE TBPESSOAS SET SYNC = ''S'', SYNC_DATA = :SYNC_DATA WHERE PESSOA_ID = :PESSOA_ID');

        vQueryUpdateCloud.ParamByName('SYNC_DATA').AsDateTime := vlData;
        vQueryUpdateCloud.ParamByName('PESSOA_ID').AsString := vQueryCloud.FieldByName('PESSOA_ID').AsString;

        vQueryUpdateCloud.ExecSQL;
        vQueryUpdateCloud.Transaction.CommitRetaining;

        Memo_Log.Lines.Add('Item atualizado em ' + FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ': ' +
                           vQueryCloud.FieldByName('PESSOA_ID').AsString + ' - ' + vQueryCloud.FieldByName('NOME').AsString);
      except
        on E: Exception do
        begin
          Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ' - Erro ao atualizar Item: ' + E.Message);
          vQueryLocal.Transaction.RollbackRetaining;
          dm1.IBDatabase1.Connected := False;
          dm1.IBDatabase1.Connected := True;

          dm1.IBDatabaseCloudSICFAR.Connected := False;
          dm1.IBDatabaseCloudSICFAR.Connected := True;
        end;
      end;

      vQueryCloud.Next;
      Application.ProcessMessages;
    end;
  finally
    vQueryLocal.Free;
    vQueryCloud.Free;
    vQueryUpdateCloud.Free;
  end;
end;

procedure TForm_PrincipalServer.pAtualizaPessoasLocalToCloud(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction; prPessoaID : String);
var
  vQueryLocal, vQueryCloud, vQueryUpdateLocal: TIBQuery;
  vlData: TDateTime;
begin
  vQueryLocal := TIBQuery.Create(self);
  vQueryCloud := TIBQuery.Create(self);
  vQueryUpdateLocal := TIBQuery.Create(self);

  try
    vQueryLocal.Database := ALocalDatabase;
    vQueryLocal.Transaction := ALocalTransaction;

    vQueryCloud.Database := ACloudDatabase;
    vQueryCloud.Transaction := ACloudTransaction;

    vQueryUpdateLocal.Database := ALocalDatabase;
    vQueryUpdateLocal.Transaction := ALocalTransaction;

    vQueryLocal.Close;
    vQueryLocal.SQL.Text := 'SELECT * FROM TBPESSOAS WHERE 1=1';

    if Trim(prPessoaID) = '' then
      vQueryLocal.SQL.Add(' AND SYNC = ''N'' ')
    else
      vQueryLocal.SQL.Add(' AND PESSOA_ID = ''' + Trim(prPessoaID) + ''' '); // pronto, blz? se for assim, lá ou outro método vou ter que dar update na pessoa, no campo sync

      //assim? sim, assim dá certo, arr oca. o teste que eu ia fazer ia ser nesse mesmo sentido kkkk arrocha

    vQueryLocal.Open;
    vQueryLocal.First;
    while not vQueryLocal.Eof do
    begin
      try
        vlData := Now;
        vQueryCloud.Close;
        vQueryCloud.SQL.Clear;
        vQueryCloud.SQL.Add('UPDATE OR INSERT INTO TBPESSOAS (');
        vQueryCloud.SQL.Add('PESSOA_ID, PESSOA_VR, EMPRESA_ID, USUARIO_ID, NOME_PUPULAR, NOME, ENDERECO, COMPLEMENTO, BAIRRO,');
        vQueryCloud.SQL.Add('CIDADE, UF, CEP, NATURALIDADE, NASCIMENTO, SEXO, TIPO, CPF_CNPJ, RG_CGF, ESTCIVIL, CLASSES,');
        vQueryCloud.SQL.Add('OBS, PAI, MAE, LIMITE_CREDITO, ENT_NOME, ENT_ENDERECO, ENT_BAIRRO, ENT_CIDADE, ENT_UF, ENT_FONE,');
        vQueryCloud.SQL.Add('FONE_01, FONE_02, FONE_03, FONE_04, CONJUGE, COMISSAO, DATACADASTRO, ALTERADO, REF_01NOME,');
        vQueryCloud.SQL.Add('REF_02NOME, REF_03NOME, REF_01FONE, REF_02FONE, REF_03FONE, COB_ENDERECO, COB_BAIRRO, COB_CIDADE,');
        vQueryCloud.SQL.Add('COB_UF, COB_CEP, SITUACAO, CONTABIL, DATA_ALT, DELETADO, DATA_INC, TIPO_TRANSP, EMAIL, SITE,');
        vQueryCloud.SQL.Add('CODIGO_ANTT, REC_CONTRATO, REC_CONTRATO_DATA, REC_DIMOB, REC_DIMOB_DATA, IDSOFT, CPF_CONJUGE,');
        vQueryCloud.SQL.Add('RG_CONJUGE, RG_ORGAO, RG_UF, RG_ORGAO_CONJUGE, RG_UF_CONJUGE, PROFISSAO, NATURAL_ID, NACIONALIDADE,');
        vQueryCloud.SQL.Add('REGIME_CASAMENTO, RENDA_CONJUGE, NACIONALIDADE_CONJUGE, PROFISSAO_CONJUGE, NUMERO, SUFRAMA, CIDADE_ID,');
        vQueryCloud.SQL.Add('PAIS_ID, MEMBRO, EQUIPE_ID, FOTO, DATA_BATISMO, DATA_CONVERSAO, DATA_MEMBRO, EMPREGADO, DOM_ID,');
        vQueryCloud.SQL.Add('DATA_AFASTADO, CARGO_ID, FUNCAO_ID, VIUVO, ORFAO, GRUPO_ID, SUBGRUPO_ID, NASCIMENTO_CONJUGE,');
        vQueryCloud.SQL.Add('PAGAMENTO_ID, ORACAO, PAGAMENTO_VALOR, DIA_VENCIMENTO, PERIODO, DC, FV, IMPOSTOS, PESSOAL,');
        vQueryCloud.SQL.Add('CAMPANHA_ID, VALOR_CONTRIBUICAO, CAPTADOR, CC_ID, TIPO_CLIENTE, CONTRIBUINTE, ESPECIE, CNH, CNH_CATEGORIA,');
        vQueryCloud.SQL.Add('CNH_EMISSAO, CNH_EMISSAO1, CNH_VENCIMENTO, RG_EMISSAO, USUARIONOME_I, USUARIO_A, USUARIONOME_A, USUARIO_D,');
        vQueryCloud.SQL.Add('USUARIONOME_D, DATA_DEL, RECNO, ERP_CODIGO, REPLICADO, ID_OLD, TIPO_FISCAL, CRACHA, NOME_CRACHA, BATE_PONTO,');
        vQueryCloud.SQL.Add('CARGO, FUNCAO, DATA_EXAME, PROXIMO_EXAME, DEPARTAMENTO_ID_SEG, DEPARTAMENTO_SEG, CTPS_N, CTPS_S, CTPS_UF,');
        vQueryCloud.SQL.Add('NIT, DEPARTAMENTO_ID, DEPARTAMENTO, COMPRAS, FUNCIONARIOS, CTPS_EMISSAO, CNH_UF, DATA_ADMISSAO,');
        vQueryCloud.SQL.Add('DEFICIENCIA, TIPO_DEFICIENCIA, CONTRIBUICAO_SINDICAL, CONTRATO_EXPERIENCIA, APRENDIZ, PRIMEIRO_EMPREGO,');
        vQueryCloud.SQL.Add('TITULO_NUMERO, TITULO_ZONA, TITULO_SECAO, BANCO_ID, BANCO, AGENCIA, CONTA, SALARIO, COR, GRAU_INSTRUCAO,');
        vQueryCloud.SQL.Add('ULTIMA_COMPRA, BLOQUEADO, BLOQUEIO_ID, VENDEDOR, CONTATORH_ID, CONTATORH, DIA_FATURA, OPF, OPF_DESCRICAO,');
        vQueryCloud.SQL.Add('MES_VENCIMENTO, PIS, SETOR_ID, SETOR, WHATSAPP, SYNC, SYNC_DATA)');
        vQueryCloud.SQL.Add('VALUES (');
        vQueryCloud.SQL.Add(':PESSOA_ID, :PESSOA_VR, :EMPRESA_ID, :USUARIO_ID, :NOME_PUPULAR, :NOME, :ENDERECO, :COMPLEMENTO, :BAIRRO,');
        vQueryCloud.SQL.Add(':CIDADE, :UF, :CEP, :NATURALIDADE, :NASCIMENTO, :SEXO, :TIPO, :CPF_CNPJ, :RG_CGF, :ESTCIVIL, :CLASSES,');
        vQueryCloud.SQL.Add(':OBS, :PAI, :MAE, :LIMITE_CREDITO, :ENT_NOME, :ENT_ENDERECO, :ENT_BAIRRO, :ENT_CIDADE, :ENT_UF, :ENT_FONE,');
        vQueryCloud.SQL.Add(':FONE_01, :FONE_02, :FONE_03, :FONE_04, :CONJUGE, :COMISSAO, :DATACADASTRO, :ALTERADO, :REF_01NOME,');
        vQueryCloud.SQL.Add(':REF_02NOME, :REF_03NOME, :REF_01FONE, :REF_02FONE, :REF_03FONE, :COB_ENDERECO, :COB_BAIRRO, :COB_CIDADE,');
        vQueryCloud.SQL.Add(':COB_UF, :COB_CEP, :SITUACAO, :CONTABIL, :DATA_ALT, :DELETADO, :DATA_INC, :TIPO_TRANSP, :EMAIL, :SITE,');
        vQueryCloud.SQL.Add(':CODIGO_ANTT, :REC_CONTRATO, :REC_CONTRATO_DATA, :REC_DIMOB, :REC_DIMOB_DATA, :IDSOFT, :CPF_CONJUGE,');
        vQueryCloud.SQL.Add(':RG_CONJUGE, :RG_ORGAO, :RG_UF, :RG_ORGAO_CONJUGE, :RG_UF_CONJUGE, :PROFISSAO, :NATURAL_ID, :NACIONALIDADE,');
        vQueryCloud.SQL.Add(':REGIME_CASAMENTO, :RENDA_CONJUGE, :NACIONALIDADE_CONJUGE, :PROFISSAO_CONJUGE, :NUMERO, :SUFRAMA, :CIDADE_ID,');
        vQueryCloud.SQL.Add(':PAIS_ID, :MEMBRO, :EQUIPE_ID, :FOTO, :DATA_BATISMO, :DATA_CONVERSAO, :DATA_MEMBRO, :EMPREGADO, :DOM_ID,');
        vQueryCloud.SQL.Add(':DATA_AFASTADO, :CARGO_ID, :FUNCAO_ID, :VIUVO, :ORFAO, :GRUPO_ID, :SUBGRUPO_ID, :NASCIMENTO_CONJUGE,');
        vQueryCloud.SQL.Add(':PAGAMENTO_ID, :ORACAO, :PAGAMENTO_VALOR, :DIA_VENCIMENTO, :PERIODO, :DC, :FV, :IMPOSTOS, :PESSOAL,');
        vQueryCloud.SQL.Add(':CAMPANHA_ID, :VALOR_CONTRIBUICAO, :CAPTADOR, :CC_ID, :TIPO_CLIENTE, :CONTRIBUINTE, :ESPECIE, :CNH, :CNH_CATEGORIA,');
        vQueryCloud.SQL.Add(':CNH_EMISSAO, :CNH_EMISSAO1, :CNH_VENCIMENTO, :RG_EMISSAO, :USUARIONOME_I, :USUARIO_A, :USUARIONOME_A, :USUARIO_D,');
        vQueryCloud.SQL.Add(':USUARIONOME_D, :DATA_DEL, :RECNO, :ERP_CODIGO, :REPLICADO, :ID_OLD, :TIPO_FISCAL, :CRACHA, :NOME_CRACHA, :BATE_PONTO,');
        vQueryCloud.SQL.Add(':CARGO, :FUNCAO, :DATA_EXAME, :PROXIMO_EXAME, :DEPARTAMENTO_ID_SEG, :DEPARTAMENTO_SEG, :CTPS_N, :CTPS_S, :CTPS_UF,');
        vQueryCloud.SQL.Add(':NIT, :DEPARTAMENTO_ID, :DEPARTAMENTO, :COMPRAS, :FUNCIONARIOS, :CTPS_EMISSAO, :CNH_UF, :DATA_ADMISSAO,');
        vQueryCloud.SQL.Add(':DEFICIENCIA, :TIPO_DEFICIENCIA, :CONTRIBUICAO_SINDICAL, :CONTRATO_EXPERIENCIA, :APRENDIZ, :PRIMEIRO_EMPREGO,');
        vQueryCloud.SQL.Add(':TITULO_NUMERO, :TITULO_ZONA, :TITULO_SECAO, :BANCO_ID, :BANCO, :AGENCIA, :CONTA, :SALARIO, :COR, :GRAU_INSTRUCAO,');
        vQueryCloud.SQL.Add(':ULTIMA_COMPRA, :BLOQUEADO, :BLOQUEIO_ID, :VENDEDOR, :CONTATORH_ID, :CONTATORH, :DIA_FATURA, :OPF, :OPF_DESCRICAO,');
        vQueryCloud.SQL.Add(':MES_VENCIMENTO, :PIS, :SETOR_ID, :SETOR, :WHATSAPP, :SYNC, :SYNC_DATA)');
        vQueryCloud.SQL.Add('MATCHING (PESSOA_ID)');

        // Parametros
        vQueryCloud.ParamByName('PESSOA_ID').AsString := vQueryLocal.FieldByName('PESSOA_ID').AsString;
        vQueryCloud.ParamByName('PESSOA_VR').AsString := vQueryLocal.FieldByName('PESSOA_VR').AsString;
        vQueryCloud.ParamByName('EMPRESA_ID').AsString := vQueryLocal.FieldByName('EMPRESA_ID').AsString;
        vQueryCloud.ParamByName('USUARIO_ID').AsString := vQueryLocal.FieldByName('USUARIO_ID').AsString;
        vQueryCloud.ParamByName('NOME_PUPULAR').AsString := vQueryLocal.FieldByName('NOME_PUPULAR').AsString;
        vQueryCloud.ParamByName('NOME').AsString := vQueryLocal.FieldByName('NOME').AsString;
        vQueryCloud.ParamByName('ENDERECO').AsString := vQueryLocal.FieldByName('ENDERECO').AsString;
        if not vQueryLocal.FieldByName('COMPLEMENTO').IsNull then
          vQueryCloud.ParamByName('COMPLEMENTO').AsString := vQueryLocal.FieldByName('COMPLEMENTO').AsString;
        if not vQueryLocal.FieldByName('BAIRRO').IsNull then
          vQueryCloud.ParamByName('BAIRRO').AsString := vQueryLocal.FieldByName('BAIRRO').AsString;
        if not vQueryLocal.FieldByName('CIDADE').IsNull then
          vQueryCloud.ParamByName('CIDADE').AsString := vQueryLocal.FieldByName('CIDADE').AsString;
        if not vQueryLocal.FieldByName('UF').IsNull then
          vQueryCloud.ParamByName('UF').AsString := vQueryLocal.FieldByName('UF').AsString;
        if not vQueryLocal.FieldByName('CEP').IsNull then
          vQueryCloud.ParamByName('CEP').AsString := vQueryLocal.FieldByName('CEP').AsString;
        if not vQueryLocal.FieldByName('NATURALIDADE').IsNull then
          vQueryCloud.ParamByName('NATURALIDADE').AsString := vQueryLocal.FieldByName('NATURALIDADE').AsString;
        if not vQueryLocal.FieldByName('NASCIMENTO').IsNull then
          vQueryCloud.ParamByName('NASCIMENTO').AsDateTime := vQueryLocal.FieldByName('NASCIMENTO').AsDateTime;
        if not vQueryLocal.FieldByName('SEXO').IsNull then
          vQueryCloud.ParamByName('SEXO').AsString := vQueryLocal.FieldByName('SEXO').AsString;
        if not vQueryLocal.FieldByName('TIPO').IsNull then
          vQueryCloud.ParamByName('TIPO').AsString := vQueryLocal.FieldByName('TIPO').AsString;
        if not vQueryLocal.FieldByName('CPF_CNPJ').IsNull then
          vQueryCloud.ParamByName('CPF_CNPJ').AsString := vQueryLocal.FieldByName('CPF_CNPJ').AsString;
        if not vQueryLocal.FieldByName('RG_CGF').IsNull then
          vQueryCloud.ParamByName('RG_CGF').AsString := vQueryLocal.FieldByName('RG_CGF').AsString;
        if not vQueryLocal.FieldByName('ESTCIVIL').IsNull then
          vQueryCloud.ParamByName('ESTCIVIL').AsString := vQueryLocal.FieldByName('ESTCIVIL').AsString;
        if not vQueryLocal.FieldByName('CLASSES').IsNull then
          vQueryCloud.ParamByName('CLASSES').AsString := vQueryLocal.FieldByName('CLASSES').AsString;
        if not vQueryLocal.FieldByName('OBS').IsNull then
          vQueryCloud.ParamByName('OBS').AsString := vQueryLocal.FieldByName('OBS').AsString;
        if not vQueryLocal.FieldByName('PAI').IsNull then
          vQueryCloud.ParamByName('PAI').AsString := vQueryLocal.FieldByName('PAI').AsString;
        if not vQueryLocal.FieldByName('MAE').IsNull then
          vQueryCloud.ParamByName('MAE').AsString := vQueryLocal.FieldByName('MAE').AsString;
        if not vQueryLocal.FieldByName('LIMITE_CREDITO').IsNull then
          vQueryCloud.ParamByName('LIMITE_CREDITO').AsFloat := vQueryLocal.FieldByName('LIMITE_CREDITO').AsFloat;
        if not vQueryLocal.FieldByName('ENT_NOME').IsNull then
          vQueryCloud.ParamByName('ENT_NOME').AsString := vQueryLocal.FieldByName('ENT_NOME').AsString;
        if not vQueryLocal.FieldByName('ENT_ENDERECO').IsNull then
          vQueryCloud.ParamByName('ENT_ENDERECO').AsString := vQueryLocal.FieldByName('ENT_ENDERECO').AsString;
        if not vQueryLocal.FieldByName('ENT_BAIRRO').IsNull then
          vQueryCloud.ParamByName('ENT_BAIRRO').AsString := vQueryLocal.FieldByName('ENT_BAIRRO').AsString;
        if not vQueryLocal.FieldByName('ENT_CIDADE').IsNull then
          vQueryCloud.ParamByName('ENT_CIDADE').AsString := vQueryLocal.FieldByName('ENT_CIDADE').AsString;
        if not vQueryLocal.FieldByName('ENT_UF').IsNull then
          vQueryCloud.ParamByName('ENT_UF').AsString := vQueryLocal.FieldByName('ENT_UF').AsString;
        if not vQueryLocal.FieldByName('ENT_FONE').IsNull then
          vQueryCloud.ParamByName('ENT_FONE').AsString := vQueryLocal.FieldByName('ENT_FONE').AsString;
        if not vQueryLocal.FieldByName('FONE_01').IsNull then
          vQueryCloud.ParamByName('FONE_01').AsString := vQueryLocal.FieldByName('FONE_01').AsString;
        if not vQueryLocal.FieldByName('FONE_02').IsNull then
          vQueryCloud.ParamByName('FONE_02').AsString := vQueryLocal.FieldByName('FONE_02').AsString;
        if not vQueryLocal.FieldByName('FONE_03').IsNull then
          vQueryCloud.ParamByName('FONE_03').AsString := vQueryLocal.FieldByName('FONE_03').AsString;
        if not vQueryLocal.FieldByName('FONE_04').IsNull then
          vQueryCloud.ParamByName('FONE_04').AsString := vQueryLocal.FieldByName('FONE_04').AsString;
        if not vQueryLocal.FieldByName('CONJUGE').IsNull then
          vQueryCloud.ParamByName('CONJUGE').AsString := vQueryLocal.FieldByName('CONJUGE').AsString;
        if not vQueryLocal.FieldByName('COMISSAO').IsNull then
          vQueryCloud.ParamByName('COMISSAO').AsFloat := vQueryLocal.FieldByName('COMISSAO').AsFloat;
        if not vQueryLocal.FieldByName('DATACADASTRO').IsNull then
          vQueryCloud.ParamByName('DATACADASTRO').AsDateTime := vQueryLocal.FieldByName('DATACADASTRO').AsDateTime;
        if not vQueryLocal.FieldByName('ALTERADO').IsNull then
          vQueryCloud.ParamByName('ALTERADO').AsDateTime := vQueryLocal.FieldByName('ALTERADO').AsDateTime;
        if not vQueryLocal.FieldByName('REF_01NOME').IsNull then
          vQueryCloud.ParamByName('REF_01NOME').AsString := vQueryLocal.FieldByName('REF_01NOME').AsString;
        if not vQueryLocal.FieldByName('REF_02NOME').IsNull then
          vQueryCloud.ParamByName('REF_02NOME').AsString := vQueryLocal.FieldByName('REF_02NOME').AsString;
        if not vQueryLocal.FieldByName('REF_03NOME').IsNull then
          vQueryCloud.ParamByName('REF_03NOME').AsString := vQueryLocal.FieldByName('REF_03NOME').AsString;
        if not vQueryLocal.FieldByName('REF_01FONE').IsNull then
          vQueryCloud.ParamByName('REF_01FONE').AsString := vQueryLocal.FieldByName('REF_01FONE').AsString;
        if not vQueryLocal.FieldByName('REF_02FONE').IsNull then
          vQueryCloud.ParamByName('REF_02FONE').AsString := vQueryLocal.FieldByName('REF_02FONE').AsString;
        if not vQueryLocal.FieldByName('REF_03FONE').IsNull then
          vQueryCloud.ParamByName('REF_03FONE').AsString := vQueryLocal.FieldByName('REF_03FONE').AsString;
        if not vQueryLocal.FieldByName('COB_ENDERECO').IsNull then
          vQueryCloud.ParamByName('COB_ENDERECO').AsString := vQueryLocal.FieldByName('COB_ENDERECO').AsString;
        if not vQueryLocal.FieldByName('COB_BAIRRO').IsNull then
          vQueryCloud.ParamByName('COB_BAIRRO').AsString := vQueryLocal.FieldByName('COB_BAIRRO').AsString;
        if not vQueryLocal.FieldByName('COB_CIDADE').IsNull then
          vQueryCloud.ParamByName('COB_CIDADE').AsString := vQueryLocal.FieldByName('COB_CIDADE').AsString;
        if not vQueryLocal.FieldByName('COB_UF').IsNull then
          vQueryCloud.ParamByName('COB_UF').AsString := vQueryLocal.FieldByName('COB_UF').AsString;
        if not vQueryLocal.FieldByName('COB_CEP').IsNull then
          vQueryCloud.ParamByName('COB_CEP').AsString := vQueryLocal.FieldByName('COB_CEP').AsString;
        if not vQueryLocal.FieldByName('SITUACAO').IsNull then
          vQueryCloud.ParamByName('SITUACAO').AsString := vQueryLocal.FieldByName('SITUACAO').AsString;
        if not vQueryLocal.FieldByName('CONTABIL').IsNull then
          vQueryCloud.ParamByName('CONTABIL').AsString := vQueryLocal.FieldByName('CONTABIL').AsString;
        if not vQueryLocal.FieldByName('DATA_ALT').IsNull then
          vQueryCloud.ParamByName('DATA_ALT').AsDateTime := vQueryLocal.FieldByName('DATA_ALT').AsDateTime;
        if not vQueryLocal.FieldByName('DELETADO').IsNull then
          vQueryCloud.ParamByName('DELETADO').AsString := vQueryLocal.FieldByName('DELETADO').AsString;
        if not vQueryLocal.FieldByName('DATA_INC').IsNull then
          vQueryCloud.ParamByName('DATA_INC').AsDateTime := vQueryLocal.FieldByName('DATA_INC').AsDateTime;
        if not vQueryLocal.FieldByName('TIPO_TRANSP').IsNull then
          vQueryCloud.ParamByName('TIPO_TRANSP').AsString := vQueryLocal.FieldByName('TIPO_TRANSP').AsString;
        if not vQueryLocal.FieldByName('EMAIL').IsNull then
          vQueryCloud.ParamByName('EMAIL').AsString := vQueryLocal.FieldByName('EMAIL').AsString;
        if not vQueryLocal.FieldByName('SITE').IsNull then
          vQueryCloud.ParamByName('SITE').AsString := vQueryLocal.FieldByName('SITE').AsString;
        if not vQueryLocal.FieldByName('CODIGO_ANTT').IsNull then
          vQueryCloud.ParamByName('CODIGO_ANTT').AsString := vQueryLocal.FieldByName('CODIGO_ANTT').AsString;
        if not vQueryLocal.FieldByName('REC_CONTRATO').IsNull then
          vQueryCloud.ParamByName('REC_CONTRATO').AsString := vQueryLocal.FieldByName('REC_CONTRATO').AsString;
        if not vQueryLocal.FieldByName('REC_CONTRATO_DATA').IsNull then
          vQueryCloud.ParamByName('REC_CONTRATO_DATA').AsDateTime := vQueryLocal.FieldByName('REC_CONTRATO_DATA').AsDateTime;
        if not vQueryLocal.FieldByName('REC_DIMOB').IsNull then
          vQueryCloud.ParamByName('REC_DIMOB').AsString := vQueryLocal.FieldByName('REC_DIMOB').AsString;
        if not vQueryLocal.FieldByName('REC_DIMOB_DATA').IsNull then
          vQueryCloud.ParamByName('REC_DIMOB_DATA').AsDateTime := vQueryLocal.FieldByName('REC_DIMOB_DATA').AsDateTime;
        if not vQueryLocal.FieldByName('IDSOFT').IsNull then
          vQueryCloud.ParamByName('IDSOFT').AsString := vQueryLocal.FieldByName('IDSOFT').AsString;
        if not vQueryLocal.FieldByName('CPF_CONJUGE').IsNull then
          vQueryCloud.ParamByName('CPF_CONJUGE').AsString := vQueryLocal.FieldByName('CPF_CONJUGE').AsString;
        if not vQueryLocal.FieldByName('RG_CONJUGE').IsNull then
          vQueryCloud.ParamByName('RG_CONJUGE').AsString := vQueryLocal.FieldByName('RG_CONJUGE').AsString;
        if not vQueryLocal.FieldByName('RG_ORGAO').IsNull then
          vQueryCloud.ParamByName('RG_ORGAO').AsString := vQueryLocal.FieldByName('RG_ORGAO').AsString;
        if not vQueryLocal.FieldByName('RG_UF').IsNull then
          vQueryCloud.ParamByName('RG_UF').AsString := vQueryLocal.FieldByName('RG_UF').AsString;
        if not vQueryLocal.FieldByName('RG_ORGAO_CONJUGE').IsNull then
          vQueryCloud.ParamByName('RG_ORGAO_CONJUGE').AsString := vQueryLocal.FieldByName('RG_ORGAO_CONJUGE').AsString;
        if not vQueryLocal.FieldByName('RG_UF_CONJUGE').IsNull then
          vQueryCloud.ParamByName('RG_UF_CONJUGE').AsString := vQueryLocal.FieldByName('RG_UF_CONJUGE').AsString;
        if not vQueryLocal.FieldByName('PROFISSAO').IsNull then
          vQueryCloud.ParamByName('PROFISSAO').AsString := vQueryLocal.FieldByName('PROFISSAO').AsString;
        if not vQueryLocal.FieldByName('NATURAL_ID').IsNull then
          vQueryCloud.ParamByName('NATURAL_ID').AsString := vQueryLocal.FieldByName('NATURAL_ID').AsString;
        if not vQueryLocal.FieldByName('NACIONALIDADE').IsNull then
          vQueryCloud.ParamByName('NACIONALIDADE').AsString := vQueryLocal.FieldByName('NACIONALIDADE').AsString;
        if not vQueryLocal.FieldByName('REGIME_CASAMENTO').IsNull then
          vQueryCloud.ParamByName('REGIME_CASAMENTO').AsString := vQueryLocal.FieldByName('REGIME_CASAMENTO').AsString;
        if not vQueryLocal.FieldByName('RENDA_CONJUGE').IsNull then
          vQueryCloud.ParamByName('RENDA_CONJUGE').AsFloat := vQueryLocal.FieldByName('RENDA_CONJUGE').AsFloat;
        if not vQueryLocal.FieldByName('NACIONALIDADE_CONJUGE').IsNull then
          vQueryCloud.ParamByName('NACIONALIDADE_CONJUGE').AsString := vQueryLocal.FieldByName('NACIONALIDADE_CONJUGE').AsString;
        if not vQueryLocal.FieldByName('PROFISSAO_CONJUGE').IsNull then
          vQueryCloud.ParamByName('PROFISSAO_CONJUGE').AsString := vQueryLocal.FieldByName('PROFISSAO_CONJUGE').AsString;
        if not vQueryLocal.FieldByName('NUMERO').IsNull then
          vQueryCloud.ParamByName('NUMERO').AsString := vQueryLocal.FieldByName('NUMERO').AsString;
        if not vQueryLocal.FieldByName('SUFRAMA').IsNull then
          vQueryCloud.ParamByName('SUFRAMA').AsString := vQueryLocal.FieldByName('SUFRAMA').AsString;
        if not vQueryLocal.FieldByName('CIDADE_ID').IsNull then
          vQueryCloud.ParamByName('CIDADE_ID').AsString := vQueryLocal.FieldByName('CIDADE_ID').AsString;
        if not vQueryLocal.FieldByName('PAIS_ID').IsNull then
          vQueryCloud.ParamByName('PAIS_ID').AsString := vQueryLocal.FieldByName('PAIS_ID').AsString;
        if not vQueryLocal.FieldByName('MEMBRO').IsNull then
          vQueryCloud.ParamByName('MEMBRO').AsString := vQueryLocal.FieldByName('MEMBRO').AsString;
        if not vQueryLocal.FieldByName('EQUIPE_ID').IsNull then
          vQueryCloud.ParamByName('EQUIPE_ID').AsString := vQueryLocal.FieldByName('EQUIPE_ID').AsString;
        if not vQueryLocal.FieldByName('FOTO').IsNull then
          vQueryCloud.ParamByName('FOTO').AsString := vQueryLocal.FieldByName('FOTO').AsString;
        if not vQueryLocal.FieldByName('DATA_BATISMO').IsNull then
          vQueryCloud.ParamByName('DATA_BATISMO').AsDateTime := vQueryLocal.FieldByName('DATA_BATISMO').AsDateTime;
        if not vQueryLocal.FieldByName('DATA_CONVERSAO').IsNull then
          vQueryCloud.ParamByName('DATA_CONVERSAO').AsDateTime := vQueryLocal.FieldByName('DATA_CONVERSAO').AsDateTime;
        if not vQueryLocal.FieldByName('DATA_MEMBRO').IsNull then
          vQueryCloud.ParamByName('DATA_MEMBRO').AsDateTime := vQueryLocal.FieldByName('DATA_MEMBRO').AsDateTime;
        if not vQueryLocal.FieldByName('EMPREGADO').IsNull then
          vQueryCloud.ParamByName('EMPREGADO').AsString := vQueryLocal.FieldByName('EMPREGADO').AsString;
        if not vQueryLocal.FieldByName('DOM_ID').IsNull then
          vQueryCloud.ParamByName('DOM_ID').AsString := vQueryLocal.FieldByName('DOM_ID').AsString;
        if not vQueryLocal.FieldByName('DATA_AFASTADO').IsNull then
          vQueryCloud.ParamByName('DATA_AFASTADO').AsDateTime := vQueryLocal.FieldByName('DATA_AFASTADO').AsDateTime;
        if not vQueryLocal.FieldByName('CARGO_ID').IsNull then
          vQueryCloud.ParamByName('CARGO_ID').AsString := vQueryLocal.FieldByName('CARGO_ID').AsString;
        if not vQueryLocal.FieldByName('FUNCAO_ID').IsNull then
          vQueryCloud.ParamByName('FUNCAO_ID').AsString := vQueryLocal.FieldByName('FUNCAO_ID').AsString;
        if not vQueryLocal.FieldByName('VIUVO').IsNull then
          vQueryCloud.ParamByName('VIUVO').AsString := vQueryLocal.FieldByName('VIUVO').AsString;
        if not vQueryLocal.FieldByName('ORFAO').IsNull then
          vQueryCloud.ParamByName('ORFAO').AsString := vQueryLocal.FieldByName('ORFAO').AsString;
        if not vQueryLocal.FieldByName('GRUPO_ID').IsNull then
          vQueryCloud.ParamByName('GRUPO_ID').AsString := vQueryLocal.FieldByName('GRUPO_ID').AsString;
        if not vQueryLocal.FieldByName('SUBGRUPO_ID').IsNull then
          vQueryCloud.ParamByName('SUBGRUPO_ID').AsString := vQueryLocal.FieldByName('SUBGRUPO_ID').AsString;
        if not vQueryLocal.FieldByName('NASCIMENTO_CONJUGE').IsNull then
          vQueryCloud.ParamByName('NASCIMENTO_CONJUGE').AsDateTime := vQueryLocal.FieldByName('NASCIMENTO_CONJUGE').AsDateTime;
        if not vQueryLocal.FieldByName('PAGAMENTO_ID').IsNull then
          vQueryCloud.ParamByName('PAGAMENTO_ID').AsString := vQueryLocal.FieldByName('PAGAMENTO_ID').AsString;
        if not vQueryLocal.FieldByName('ORACAO').IsNull then
          vQueryCloud.ParamByName('ORACAO').AsString := vQueryLocal.FieldByName('ORACAO').AsString;
        if not vQueryLocal.FieldByName('PAGAMENTO_VALOR').IsNull then
          vQueryCloud.ParamByName('PAGAMENTO_VALOR').AsFloat := vQueryLocal.FieldByName('PAGAMENTO_VALOR').AsFloat;
        if not vQueryLocal.FieldByName('DIA_VENCIMENTO').IsNull then
          vQueryCloud.ParamByName('DIA_VENCIMENTO').AsString := vQueryLocal.FieldByName('DIA_VENCIMENTO').AsString;
        if not vQueryLocal.FieldByName('PERIODO').IsNull then
          vQueryCloud.ParamByName('PERIODO').AsString := vQueryLocal.FieldByName('PERIODO').AsString;
        if not vQueryLocal.FieldByName('DC').IsNull then
          vQueryCloud.ParamByName('DC').AsString := vQueryLocal.FieldByName('DC').AsString;
        if not vQueryLocal.FieldByName('FV').IsNull then
          vQueryCloud.ParamByName('FV').AsString := vQueryLocal.FieldByName('FV').AsString;
        if not vQueryLocal.FieldByName('IMPOSTOS').IsNull then
          vQueryCloud.ParamByName('IMPOSTOS').AsString := vQueryLocal.FieldByName('IMPOSTOS').AsString;
        if not vQueryLocal.FieldByName('PESSOAL').IsNull then
          vQueryCloud.ParamByName('PESSOAL').AsString := vQueryLocal.FieldByName('PESSOAL').AsString;
        if not vQueryLocal.FieldByName('CAMPANHA_ID').IsNull then
          vQueryCloud.ParamByName('CAMPANHA_ID').AsString := vQueryLocal.FieldByName('CAMPANHA_ID').AsString;
        if not vQueryLocal.FieldByName('VALOR_CONTRIBUICAO').IsNull then
          vQueryCloud.ParamByName('VALOR_CONTRIBUICAO').AsFloat := vQueryLocal.FieldByName('VALOR_CONTRIBUICAO').AsFloat;
        if not vQueryLocal.FieldByName('CAPTADOR').IsNull then
          vQueryCloud.ParamByName('CAPTADOR').AsString := vQueryLocal.FieldByName('CAPTADOR').AsString;
        if not vQueryLocal.FieldByName('CC_ID').IsNull then
          vQueryCloud.ParamByName('CC_ID').AsString := vQueryLocal.FieldByName('CC_ID').AsString;
        if not vQueryLocal.FieldByName('TIPO_CLIENTE').IsNull then
          vQueryCloud.ParamByName('TIPO_CLIENTE').AsString := vQueryLocal.FieldByName('TIPO_CLIENTE').AsString;
        if not vQueryLocal.FieldByName('CONTRIBUINTE').IsNull then
          vQueryCloud.ParamByName('CONTRIBUINTE').AsString := vQueryLocal.FieldByName('CONTRIBUINTE').AsString;
        if not vQueryLocal.FieldByName('ESPECIE').IsNull then
          vQueryCloud.ParamByName('ESPECIE').AsString := vQueryLocal.FieldByName('ESPECIE').AsString;
        if not vQueryLocal.FieldByName('CNH').IsNull then
          vQueryCloud.ParamByName('CNH').AsString := vQueryLocal.FieldByName('CNH').AsString;
        if not vQueryLocal.FieldByName('CNH_CATEGORIA').IsNull then
          vQueryCloud.ParamByName('CNH_CATEGORIA').AsString := vQueryLocal.FieldByName('CNH_CATEGORIA').AsString;
        if not vQueryLocal.FieldByName('CNH_EMISSAO').IsNull then
          vQueryCloud.ParamByName('CNH_EMISSAO').AsDateTime := vQueryLocal.FieldByName('CNH_EMISSAO').AsDateTime;
        if not vQueryLocal.FieldByName('CNH_EMISSAO1').IsNull then
          vQueryCloud.ParamByName('CNH_EMISSAO1').AsDateTime := vQueryLocal.FieldByName('CNH_EMISSAO1').AsDateTime;
        if not vQueryLocal.FieldByName('CNH_VENCIMENTO').IsNull then
          vQueryCloud.ParamByName('CNH_VENCIMENTO').AsDateTime := vQueryLocal.FieldByName('CNH_VENCIMENTO').AsDateTime;
        if not vQueryLocal.FieldByName('RG_EMISSAO').IsNull then
          vQueryCloud.ParamByName('RG_EMISSAO').AsDateTime := vQueryLocal.FieldByName('RG_EMISSAO').AsDateTime;
        if not vQueryLocal.FieldByName('USUARIONOME_I').IsNull then
          vQueryCloud.ParamByName('USUARIONOME_I').AsString := vQueryLocal.FieldByName('USUARIONOME_I').AsString;
        if not vQueryLocal.FieldByName('USUARIO_A').IsNull then
          vQueryCloud.ParamByName('USUARIO_A').AsString := vQueryLocal.FieldByName('USUARIO_A').AsString;
        if not vQueryLocal.FieldByName('USUARIONOME_A').IsNull then
          vQueryCloud.ParamByName('USUARIONOME_A').AsString := vQueryLocal.FieldByName('USUARIONOME_A').AsString;
        if not vQueryLocal.FieldByName('USUARIO_D').IsNull then
          vQueryCloud.ParamByName('USUARIO_D').AsString := vQueryLocal.FieldByName('USUARIO_D').AsString;
        if not vQueryLocal.FieldByName('USUARIONOME_D').IsNull then
          vQueryCloud.ParamByName('USUARIONOME_D').AsString := vQueryLocal.FieldByName('USUARIONOME_D').AsString;
        if not vQueryLocal.FieldByName('DATA_DEL').IsNull then
          vQueryCloud.ParamByName('DATA_DEL').AsDateTime := vQueryLocal.FieldByName('DATA_DEL').AsDateTime;
        if not vQueryLocal.FieldByName('RECNO').IsNull then
          vQueryCloud.ParamByName('RECNO').AsString := vQueryLocal.FieldByName('RECNO').AsString;
        if not vQueryLocal.FieldByName('ERP_CODIGO').IsNull then
          vQueryCloud.ParamByName('ERP_CODIGO').AsString := vQueryLocal.FieldByName('ERP_CODIGO').AsString;
        if not vQueryLocal.FieldByName('REPLICADO').IsNull then
          vQueryCloud.ParamByName('REPLICADO').AsString := vQueryLocal.FieldByName('REPLICADO').AsString;
        if not vQueryLocal.FieldByName('ID_OLD').IsNull then
          vQueryCloud.ParamByName('ID_OLD').AsString := vQueryLocal.FieldByName('ID_OLD').AsString;
        if not vQueryLocal.FieldByName('TIPO_FISCAL').IsNull then
          vQueryCloud.ParamByName('TIPO_FISCAL').AsString := vQueryLocal.FieldByName('TIPO_FISCAL').AsString;
        if not vQueryLocal.FieldByName('CRACHA').IsNull then
          vQueryCloud.ParamByName('CRACHA').AsString := vQueryLocal.FieldByName('CRACHA').AsString;
        if not vQueryLocal.FieldByName('NOME_CRACHA').IsNull then
          vQueryCloud.ParamByName('NOME_CRACHA').AsString := vQueryLocal.FieldByName('NOME_CRACHA').AsString;
        if not vQueryLocal.FieldByName('BATE_PONTO').IsNull then
          vQueryCloud.ParamByName('BATE_PONTO').AsString := vQueryLocal.FieldByName('BATE_PONTO').AsString;
        if not vQueryLocal.FieldByName('CARGO').IsNull then
          vQueryCloud.ParamByName('CARGO').AsString := vQueryLocal.FieldByName('CARGO').AsString;
        if not vQueryLocal.FieldByName('FUNCAO').IsNull then
          vQueryCloud.ParamByName('FUNCAO').AsString := vQueryLocal.FieldByName('FUNCAO').AsString;
        if not vQueryLocal.FieldByName('DATA_EXAME').IsNull then
          vQueryCloud.ParamByName('DATA_EXAME').AsDateTime := vQueryLocal.FieldByName('DATA_EXAME').AsDateTime;
        if not vQueryLocal.FieldByName('PROXIMO_EXAME').IsNull then
          vQueryCloud.ParamByName('PROXIMO_EXAME').AsDateTime := vQueryLocal.FieldByName('PROXIMO_EXAME').AsDateTime;
        if not vQueryLocal.FieldByName('DEPARTAMENTO_ID_SEG').IsNull then
          vQueryCloud.ParamByName('DEPARTAMENTO_ID_SEG').AsString := vQueryLocal.FieldByName('DEPARTAMENTO_ID_SEG').AsString;
        if not vQueryLocal.FieldByName('DEPARTAMENTO_SEG').IsNull then
          vQueryCloud.ParamByName('DEPARTAMENTO_SEG').AsString := vQueryLocal.FieldByName('DEPARTAMENTO_SEG').AsString;
        if not vQueryLocal.FieldByName('CTPS_N').IsNull then
          vQueryCloud.ParamByName('CTPS_N').AsString := vQueryLocal.FieldByName('CTPS_N').AsString;
        if not vQueryLocal.FieldByName('CTPS_S').IsNull then
          vQueryCloud.ParamByName('CTPS_S').AsString := vQueryLocal.FieldByName('CTPS_S').AsString;
        if not vQueryLocal.FieldByName('CTPS_UF').IsNull then
          vQueryCloud.ParamByName('CTPS_UF').AsString := vQueryLocal.FieldByName('CTPS_UF').AsString;
        if not vQueryLocal.FieldByName('NIT').IsNull then
          vQueryCloud.ParamByName('NIT').AsString := vQueryLocal.FieldByName('NIT').AsString;
        if not vQueryLocal.FieldByName('DEPARTAMENTO_ID').IsNull then
          vQueryCloud.ParamByName('DEPARTAMENTO_ID').AsString := vQueryLocal.FieldByName('DEPARTAMENTO_ID').AsString;
        if not vQueryLocal.FieldByName('DEPARTAMENTO').IsNull then
          vQueryCloud.ParamByName('DEPARTAMENTO').AsString := vQueryLocal.FieldByName('DEPARTAMENTO').AsString;
        if not vQueryLocal.FieldByName('COMPRAS').IsNull then
          vQueryCloud.ParamByName('COMPRAS').AsString := vQueryLocal.FieldByName('COMPRAS').AsString;
        if not vQueryLocal.FieldByName('FUNCIONARIOS').IsNull then
          vQueryCloud.ParamByName('FUNCIONARIOS').AsString := vQueryLocal.FieldByName('FUNCIONARIOS').AsString;
        if not vQueryLocal.FieldByName('CTPS_EMISSAO').IsNull then
          vQueryCloud.ParamByName('CTPS_EMISSAO').AsDateTime := vQueryLocal.FieldByName('CTPS_EMISSAO').AsDateTime;
        if not vQueryLocal.FieldByName('CNH_UF').IsNull then
          vQueryCloud.ParamByName('CNH_UF').AsString := vQueryLocal.FieldByName('CNH_UF').AsString;
        if not vQueryLocal.FieldByName('DATA_ADMISSAO').IsNull then
          vQueryCloud.ParamByName('DATA_ADMISSAO').AsDateTime := vQueryLocal.FieldByName('DATA_ADMISSAO').AsDateTime;
        if not vQueryLocal.FieldByName('DEFICIENCIA').IsNull then
          vQueryCloud.ParamByName('DEFICIENCIA').AsString := vQueryLocal.FieldByName('DEFICIENCIA').AsString;
        if not vQueryLocal.FieldByName('TIPO_DEFICIENCIA').IsNull then
          vQueryCloud.ParamByName('TIPO_DEFICIENCIA').AsString := vQueryLocal.FieldByName('TIPO_DEFICIENCIA').AsString;
        if not vQueryLocal.FieldByName('CONTRIBUICAO_SINDICAL').IsNull then
          vQueryCloud.ParamByName('CONTRIBUICAO_SINDICAL').AsString := vQueryLocal.FieldByName('CONTRIBUICAO_SINDICAL').AsString;
        if not vQueryLocal.FieldByName('CONTRATO_EXPERIENCIA').IsNull then
          vQueryCloud.ParamByName('CONTRATO_EXPERIENCIA').AsString := vQueryLocal.FieldByName('CONTRATO_EXPERIENCIA').AsString;
        if not vQueryLocal.FieldByName('APRENDIZ').IsNull then
          vQueryCloud.ParamByName('APRENDIZ').AsString := vQueryLocal.FieldByName('APRENDIZ').AsString;
        if not vQueryLocal.FieldByName('PRIMEIRO_EMPREGO').IsNull then
          vQueryCloud.ParamByName('PRIMEIRO_EMPREGO').AsString := vQueryLocal.FieldByName('PRIMEIRO_EMPREGO').AsString;
        if not vQueryLocal.FieldByName('TITULO_NUMERO').IsNull then
          vQueryCloud.ParamByName('TITULO_NUMERO').AsString := vQueryLocal.FieldByName('TITULO_NUMERO').AsString;
        if not vQueryLocal.FieldByName('TITULO_ZONA').IsNull then
          vQueryCloud.ParamByName('TITULO_ZONA').AsString := vQueryLocal.FieldByName('TITULO_ZONA').AsString;
        if not vQueryLocal.FieldByName('TITULO_SECAO').IsNull then
          vQueryCloud.ParamByName('TITULO_SECAO').AsString := vQueryLocal.FieldByName('TITULO_SECAO').AsString;
        if not vQueryLocal.FieldByName('BANCO_ID').IsNull then
          vQueryCloud.ParamByName('BANCO_ID').AsString := vQueryLocal.FieldByName('BANCO_ID').AsString;
        if not vQueryLocal.FieldByName('BANCO').IsNull then
          vQueryCloud.ParamByName('BANCO').AsString := vQueryLocal.FieldByName('BANCO').AsString;
        if not vQueryLocal.FieldByName('AGENCIA').IsNull then
          vQueryCloud.ParamByName('AGENCIA').AsString := vQueryLocal.FieldByName('AGENCIA').AsString;
        if not vQueryLocal.FieldByName('CONTA').IsNull then
          vQueryCloud.ParamByName('CONTA').AsString := vQueryLocal.FieldByName('CONTA').AsString;
        if not vQueryLocal.FieldByName('SALARIO').IsNull then
          vQueryCloud.ParamByName('SALARIO').AsFloat := vQueryLocal.FieldByName('SALARIO').AsFloat;
        if not vQueryLocal.FieldByName('COR').IsNull then
          vQueryCloud.ParamByName('COR').AsString := vQueryLocal.FieldByName('COR').AsString;
        if not vQueryLocal.FieldByName('GRAU_INSTRUCAO').IsNull then
          vQueryCloud.ParamByName('GRAU_INSTRUCAO').AsString := vQueryLocal.FieldByName('GRAU_INSTRUCAO').AsString;
        if not vQueryLocal.FieldByName('ULTIMA_COMPRA').IsNull then
          vQueryCloud.ParamByName('ULTIMA_COMPRA').AsDateTime := vQueryLocal.FieldByName('ULTIMA_COMPRA').AsDateTime;
        if not vQueryLocal.FieldByName('BLOQUEADO').IsNull then
          vQueryCloud.ParamByName('BLOQUEADO').AsString := vQueryLocal.FieldByName('BLOQUEADO').AsString;
        if not vQueryLocal.FieldByName('BLOQUEIO_ID').IsNull then
          vQueryCloud.ParamByName('BLOQUEIO_ID').AsString := vQueryLocal.FieldByName('BLOQUEIO_ID').AsString;
        if not vQueryLocal.FieldByName('VENDEDOR').IsNull then
          vQueryCloud.ParamByName('VENDEDOR').AsString := vQueryLocal.FieldByName('VENDEDOR').AsString;
        if not vQueryLocal.FieldByName('CONTATORH_ID').IsNull then
          vQueryCloud.ParamByName('CONTATORH_ID').AsString := vQueryLocal.FieldByName('CONTATORH_ID').AsString;
        if not vQueryLocal.FieldByName('CONTATORH').IsNull then
          vQueryCloud.ParamByName('CONTATORH').AsString := vQueryLocal.FieldByName('CONTATORH').AsString;
        if not vQueryLocal.FieldByName('DIA_FATURA').IsNull then
          vQueryCloud.ParamByName('DIA_FATURA').AsString := vQueryLocal.FieldByName('DIA_FATURA').AsString;
        if not vQueryLocal.FieldByName('OPF').IsNull then
          vQueryCloud.ParamByName('OPF').AsString := vQueryLocal.FieldByName('OPF').AsString;
        if not vQueryLocal.FieldByName('OPF_DESCRICAO').IsNull then
          vQueryCloud.ParamByName('OPF_DESCRICAO').AsString := vQueryLocal.FieldByName('OPF_DESCRICAO').AsString;
        if not vQueryLocal.FieldByName('MES_VENCIMENTO').IsNull then
          vQueryCloud.ParamByName('MES_VENCIMENTO').AsString := vQueryLocal.FieldByName('MES_VENCIMENTO').AsString;
        if not vQueryLocal.FieldByName('PIS').IsNull then
          vQueryCloud.ParamByName('PIS').AsString := vQueryLocal.FieldByName('PIS').AsString;
        if not vQueryLocal.FieldByName('SETOR_ID').IsNull then
          vQueryCloud.ParamByName('SETOR_ID').AsString := vQueryLocal.FieldByName('SETOR_ID').AsString;
        if not vQueryLocal.FieldByName('SETOR').IsNull then
          vQueryCloud.ParamByName('SETOR').AsString := vQueryLocal.FieldByName('SETOR').AsString;
        if not vQueryLocal.FieldByName('WHATSAPP').IsNull then
          vQueryCloud.ParamByName('WHATSAPP').AsString := vQueryLocal.FieldByName('WHATSAPP').AsString;

        vQueryCloud.ParamByName('SYNC').AsString := 'S';
        vQueryCloud.ParamByName('SYNC_DATA').AsDateTime := vlData;

        vQueryCloud.ExecSQL;
        vQueryCloud.Transaction.CommitRetaining;

        vQueryUpdateLocal.Close;
        vQueryUpdateLocal.SQL.Clear;
        vQueryUpdateLocal.SQL.Add('UPDATE TBPESSOAS SET SYNC = ''S'', SYNC_DATA = :SYNC_DATA WHERE PESSOA_ID = :PESSOA_ID');

        vQueryUpdateLocal.ParamByName('SYNC_DATA').AsDateTime := vlData;
        vQueryUpdateLocal.ParamByName('PESSOA_ID').AsString := vQueryLocal.FieldByName('PESSOA_ID').AsString;

        vQueryUpdateLocal.ExecSQL;
        vQueryUpdateLocal.Transaction.CommitRetaining;

        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-TBPESSOAS Local->Cloud atualizada: ' +
                           Trim(vQueryLocal.FieldByName('PESSOA_ID').AsString) + '-' + Trim(vQueryLocal.FieldByName('NOME').AsString));
          end);
      except on E: Exception do

        begin
          TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-Erro ao atualizar TBPESSOAS PESSOA_ID = [' + vQueryLocal.FieldByName('PESSOA_ID').AsString + '] Local->Cloud: ' + E.Message);
            end);

          vQueryCloud.Transaction.RollbackRetaining;
          vQueryUpdateLocal.Transaction.RollbackRetaining;

          dm1.IBDatabase1.Connected := False;
          dm1.IBDatabase1.Connected := True;

          dm1.IBDatabaseCloudSICFAR.Connected := False;
          dm1.IBDatabaseCloudSICFAR.Connected := True;

          Break;
        end;
      end;

      vQueryLocal.Next;
    end;
  finally
    vQueryLocal.Free;
    vQueryCloud.Free;
    vQueryUpdateLocal.Free;
  end;
end;

procedure TForm_PrincipalServer.pAtualizaPorta(prPorta: String);
var
  vlQuery : TIBQuery;
begin
  vlQuery := TIBQuery.Create(Owner);
  with vlQuery do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;

      Close;
      SQL.Text := 'update tbparametros set';
      SQL.Add(' conteudo = ''' + prPorta + ''' ');
      SQL.Add(' where parametro = ''PORTAUPDATE'' ');
      ExecSQL;
      Transaction.CommitRetaining;
    end;

  vlQuery.Free;
end;

procedure TForm_PrincipalServer.pAtualizaProduto;
begin
  with vQueryTOTVS do
    begin
      Close;
      SQL.Text := 'SELECT * FROM SB1010 (NOLOCK) WHERE D_E_L_E_T_ = '''' ';
      SQL.Add(' AND B1_MSEXP = '''' ');
      Open;
    end;

  vQueryTOTVS.First;

  while not vQueryTOTVS.Eof do
    begin
       if vPararServidor = True then
         begin
           Timer_Tabelas.Enabled := False;
           Memo_Log.Lines.Add('Servidor Desativado.');
           Abort;
         end;

      with vQueryConstulta do
        begin
          Close;
          SQL.Text := 'select * from tbprodutos where deletado = ''N'' ';
          SQL.Add(' and recno = ''' + Trim(vQueryTOTVS.FieldByName('R_E_C_N_O_').AsString) + ''' ') ;
          Open;
        end;

      if vQueryConstulta.IsEmpty then
        begin
          //Inserir
          with update do
            begin
              Close;
              SQL.Clear;
              SQL.Text := 'insert into tbprodutos';
              SQL.Add(' (empresa_id, referencia, descricao, unidade, grupo_id,');
              SQL.Add(' subgrupo_id, recno, deletado, data_inc)');
              SQL.Add(' values');
              SQL.Add('(:pFilial, :pReferencia, :pDescricao, :pUnidade, :pGrupoID,');
              SQL.Add(' :pSubgrupoID, :pRecno, :pDeletado, :pData)');
            end;
        end
      else
        begin
          //Atualizar
          with update do
            begin
              Close;
              SQL.Clear;
              SQL.Text := 'update tbprodutos set';
              SQL.Add(' empresa_id  = :pFilial,');
              SQL.Add(' referencia  = :pReferencia,');
              SQL.Add(' descricao   = :pDescricao,');
              SQL.Add(' unidade     = :pUnidade,');
              SQL.Add(' grupo_id    = :pGrupoID,');
              SQL.Add(' subgrupo_id = :pSubgrupoID,');
              SQL.Add(' recno       = :pRecno,');
              SQL.Add(' deletado    = :pDeletado,');
              SQL.Add(' data_alt    = :pData');
              SQL.Add(' where deletado = ''N'' ');
              SQL.Add(' and recno = ''' + Trim(vQueryTOTVS.FieldByName('R_E_C_N_O_').AsString) + ''' ');
            end;
        end;

      try
        try
          try
          with update do
            begin
              Params[0].Text := Trim(vQueryTOTVS.FieldByName('B1_FILIAL').AsString);
              Params[1].Text := Trim(vQueryTOTVS.FieldByName('B1_COD').AsString);
              Params[2].Text := Trim(vQueryTOTVS.FieldByName('B1_DESC').AsString);
              Params[3].Text := Trim(vQueryTOTVS.FieldByName('B1_UM').AsString);
              Params[4].Text := Trim(vQueryTOTVS.FieldByName('B1_GRUPO').AsString);
              Params[5].Text := Trim(vQueryTOTVS.FieldByName('B1_TIPO').AsString);
              Params[6].Text := Trim(vQueryTOTVS.FieldByName('R_E_C_N_O_').AsString);
              Params[7].Text := 'N';
              Params[8].AsDateTime := Now;

              //inputbox('','',sql.Text);

              ExecSQL;
              Transaction.CommitRetaining;
            end;
          except on e: exception do
            begin
              ShowMessage(e.Message);
            end;

          end;
        finally
          with vQueryUpdate do
            begin
              //dmProtheus.ADOConnection1.BeginTrans;
              //Prepared := True;
              Close;

              SQL.Clear;
              SQL.Text := 'UPDATE SB1010 SET';
              SQL.Add(' B1_MSEXP = ''' + FormatDateTime('YYYYMMDD', Date) + ''' ');
              SQL.Add(' WHERE D_E_L_E_T_ = '''' ');
              SQL.Add(' AND B1_COD = ''' + Trim(vQueryTOTVS.FieldByName('B1_COD').AsString) + ''' ');

              ExecSQL;
              //dmProtheus.ADOConnection1.CommitTrans;
            end;

          TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', Now) + '-TBPRODUTOS atualizada TOTVS Local->PedidosOnline Cloud: '
                              + Trim(vQueryTOTVS.FieldByName('B1_COD').AsString) + '-' + Trim(vQueryTOTVS.FieldByName('B1_DESC').AsString));
            end);
        end;
      except on e : Exception do
        begin
          TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', Now) + '-Erro ao atualizar TBPRODUTOS TOTVS Local->PedidosOnline Cloud: ' + e.Message);
            end);

          vQuerySIC.Transaction.RollbackRetaining;
          dm1.IBDatabase1.Connected := False;
          dm1.IBDatabase1.Connected := True;

          dmProtheus.ADOConnection1.RollbackTrans;
          dmProtheus.ADOConnection1.Connected := False;
          dmProtheus.ADOConnection1.Connected := True;
        end;
      end;

      vQueryTOTVS.Next;
      Application.ProcessMessages;
    end;
end;

procedure TForm_PrincipalServer.pAtualizaProdutoCloudToLocal;
var
  vQueryLocal, vQueryCloud, vQueryUpdateCloud: TIBQuery;
  vlData: TDateTime;
begin
  vQueryLocal := TIBQuery.Create(self);
  vQueryCloud := TIBQuery.Create(self);
  vQueryUpdateCloud := TIBQuery.Create(self);

  try
    vQueryLocal.Database := ALocalDatabase;
    vQueryLocal.Transaction := ALocalTransaction;

    vQueryCloud.Database := ACloudDatabase;
    vQueryCloud.Transaction := ACloudTransaction;

    vQueryUpdateCloud.Database := ACloudDatabase;
    vQueryUpdateCloud.Transaction := ACloudTransaction;

    vQueryCloud.Close;
    vQueryCloud.SQL.Text := 'SELECT * FROM TBPRODUTOS WHERE SYNC = ''N''';

    vQueryCloud.Open;
    vQueryCloud.First;
    while not vQueryCloud.Eof do
    begin
      try
        vlData := Now;
        vQueryLocal.Close;
        vQueryLocal.SQL.Clear;
        vQueryLocal.SQL.Add('UPDATE OR INSERT INTO TBPRODUTOS');
        vQueryLocal.SQL.Add('(PRODUTO_ID, EMPRESA_ID, USUARIO_ID, PESSOA_ID, RECNO, REFERENCIA, DESCRICAO, ESTOQUE,');
        vQueryLocal.SQL.Add('PRECO_VENDA, PRECO_MINIMO, PRECO_COMPRA, CODBARRA, IPI, ICMS, UNIDADE, PESO_BRUTO, PESO_LIQUIDO,');
        vQueryLocal.SQL.Add('ESTOQUE_MINIMO, CUSTOCOM, CUSTOSEM, FOTO, DELETADO, COMISSAO, ESTOQUE_ID, ESTOQUE_NOME,');
        vQueryLocal.SQL.Add('DATA_INC, DATA_ALT, ENDERECO, CIDADE, UF, BAIRRO, CEP, TIPOPRODUTO_ID, GRUPO_ID, VOLUME, ESPECIFICA_I,');
        vQueryLocal.SQL.Add('ESPECIFICA_F, PESO_VAZIO, MASSA, DENSIDADE, DENSIDADE_REFERENCIA, ULTIMOPRECO_VENDA, REPLICADO,');
        vQueryLocal.SQL.Add('NCM, AREA_M2, FRENTE_MT, FUNDOS_MT, ESQUERDO_MT, DIREITO_MT, TIPO_ITEM, EX_TIPI, GENERO_ITEM,');
        vQueryLocal.SQL.Add('COD_LST, PRECO_ALUGUEL, PRECO_CONDOMINIO, NATUREZA, TIPO_IMOVEL, IMOVEL, CC_ID, SUBGRUPO_ID,');
        vQueryLocal.SQL.Add('AREA_CONTRUIDA, QUADRA_ID, OBS, ERP_CODIGO, POLICIAFEDERAL, TIPOSTATUS, QTDE_CAIXA, PRECO_MAXIMO,');
        vQueryLocal.SQL.Add('CONTROLA_TEOR, USUARIO_I, USUARIONOME_I, USUARIO_A, USUARIONOME_A, USUARIO_D, USUARIONOME_D,');
        vQueryLocal.SQL.Add('DATA_DEL, CONTROLA_LOTE, BLOQUEADO, ESPECIFICACAO_PADRAO, VALIDADE_PROCESSO, SYNC, SYNC_DATA)');
        vQueryLocal.SQL.Add('VALUES');
        vQueryLocal.SQL.Add('(:PRODUTO_ID, :EMPRESA_ID, :USUARIO_ID, :PESSOA_ID, :RECNO, :REFERENCIA, :DESCRICAO, :ESTOQUE,');
        vQueryLocal.SQL.Add(':PRECO_VENDA, :PRECO_MINIMO, :PRECO_COMPRA, :CODBARRA, :IPI, :ICMS, :UNIDADE, :PESO_BRUTO, :PESO_LIQUIDO,');
        vQueryLocal.SQL.Add(':ESTOQUE_MINIMO, :CUSTOCOM, :CUSTOSEM, :FOTO, :DELETADO, :COMISSAO, :ESTOQUE_ID, :ESTOQUE_NOME,');
        vQueryLocal.SQL.Add(':DATA_INC, :DATA_ALT, :ENDERECO, :CIDADE, :UF, :BAIRRO, :CEP, :TIPOPRODUTO_ID, :GRUPO_ID, :VOLUME, :ESPECIFICA_I,');
        vQueryLocal.SQL.Add(':ESPECIFICA_F, :PESO_VAZIO, :MASSA, :DENSIDADE, :DENSIDADE_REFERENCIA, :ULTIMOPRECO_VENDA, :REPLICADO,');
        vQueryLocal.SQL.Add(':NCM, :AREA_M2, :FRENTE_MT, :FUNDOS_MT, :ESQUERDO_MT, :DIREITO_MT, :TIPO_ITEM, :EX_TIPI, :GENERO_ITEM,');
        vQueryLocal.SQL.Add(':COD_LST, :PRECO_ALUGUEL, :PRECO_CONDOMINIO, :NATUREZA, :TIPO_IMOVEL, :IMOVEL, :CC_ID, :SUBGRUPO_ID,');
        vQueryLocal.SQL.Add(':AREA_CONTRUIDA, :QUADRA_ID, :OBS, :ERP_CODIGO, :POLICIAFEDERAL, :TIPOSTATUS, :QTDE_CAIXA, :PRECO_MAXIMO,');
        vQueryLocal.SQL.Add(':CONTROLA_TEOR, :USUARIO_I, :USUARIONOME_I, :USUARIO_A, :USUARIONOME_A, :USUARIO_D, :USUARIONOME_D,');
        vQueryLocal.SQL.Add(':DATA_DEL, :CONTROLA_LOTE, :BLOQUEADO, :ESPECIFICACAO_PADRAO, :VALIDADE_PROCESSO, :SYNC, :SYNC_DATA)');
        vQueryLocal.SQL.Add('MATCHING (PRODUTO_ID)');

        // Parametros
        vQueryLocal.ParamByName('PRODUTO_ID').AsInteger := vQueryCloud.FieldByName('PRODUTO_ID').AsInteger;
        if not vQueryCloud.FieldByName('EMPRESA_ID').IsNull then
          vQueryLocal.ParamByName('EMPRESA_ID').AsInteger := vQueryCloud.FieldByName('EMPRESA_ID').AsInteger;
        if not vQueryCloud.FieldByName('USUARIO_ID').IsNull then
          vQueryLocal.ParamByName('USUARIO_ID').AsInteger := vQueryCloud.FieldByName('USUARIO_ID').AsInteger;
        if not vQueryCloud.FieldByName('PESSOA_ID').IsNull then
          vQueryLocal.ParamByName('PESSOA_ID').AsInteger := vQueryCloud.FieldByName('PESSOA_ID').AsInteger;
        if not vQueryCloud.FieldByName('RECNO').IsNull then
          vQueryLocal.ParamByName('RECNO').AsInteger := vQueryCloud.FieldByName('RECNO').AsInteger;
        if not vQueryCloud.FieldByName('REFERENCIA').IsNull then
          vQueryLocal.ParamByName('REFERENCIA').AsString := vQueryCloud.FieldByName('REFERENCIA').AsString;
        if not vQueryCloud.FieldByName('DESCRICAO').IsNull then
          vQueryLocal.ParamByName('DESCRICAO').AsString := vQueryCloud.FieldByName('DESCRICAO').AsString;
        if not vQueryCloud.FieldByName('ESTOQUE').IsNull then
          vQueryLocal.ParamByName('ESTOQUE').AsString := vQueryCloud.FieldByName('ESTOQUE').AsString;
        if not vQueryCloud.FieldByName('PRECO_VENDA').IsNull then
          vQueryLocal.ParamByName('PRECO_VENDA').AsFloat := vQueryCloud.FieldByName('PRECO_VENDA').AsFloat;
        if not vQueryCloud.FieldByName('PRECO_MINIMO').IsNull then
          vQueryLocal.ParamByName('PRECO_MINIMO').AsFloat := vQueryCloud.FieldByName('PRECO_MINIMO').AsFloat;
        if not vQueryCloud.FieldByName('PRECO_COMPRA').IsNull then
          vQueryLocal.ParamByName('PRECO_COMPRA').AsFloat := vQueryCloud.FieldByName('PRECO_COMPRA').AsFloat;
        if not vQueryCloud.FieldByName('CODBARRA').IsNull then
          vQueryLocal.ParamByName('CODBARRA').AsString := vQueryCloud.FieldByName('CODBARRA').AsString;
        if not vQueryCloud.FieldByName('IPI').IsNull then
          vQueryLocal.ParamByName('IPI').AsFloat := vQueryCloud.FieldByName('IPI').AsFloat;
        if not vQueryCloud.FieldByName('ICMS').IsNull then
          vQueryLocal.ParamByName('ICMS').AsFloat := vQueryCloud.FieldByName('ICMS').AsFloat;
        if not vQueryCloud.FieldByName('UNIDADE').IsNull then
          vQueryLocal.ParamByName('UNIDADE').AsString := vQueryCloud.FieldByName('UNIDADE').AsString;
        if not vQueryCloud.FieldByName('PESO_BRUTO').IsNull then
          vQueryLocal.ParamByName('PESO_BRUTO').AsFloat := vQueryCloud.FieldByName('PESO_BRUTO').AsFloat;
        if not vQueryCloud.FieldByName('PESO_LIQUIDO').IsNull then
          vQueryLocal.ParamByName('PESO_LIQUIDO').AsFloat := vQueryCloud.FieldByName('PESO_LIQUIDO').AsFloat;
        if not vQueryCloud.FieldByName('ESTOQUE_MINIMO').IsNull then
          vQueryLocal.ParamByName('ESTOQUE_MINIMO').AsInteger := vQueryCloud.FieldByName('ESTOQUE_MINIMO').AsInteger;
        if not vQueryCloud.FieldByName('CUSTOCOM').IsNull then
          vQueryLocal.ParamByName('CUSTOCOM').AsFloat := vQueryCloud.FieldByName('CUSTOCOM').AsFloat;
        if not vQueryCloud.FieldByName('CUSTOSEM').IsNull then
          vQueryLocal.ParamByName('CUSTOSEM').AsFloat := vQueryCloud.FieldByName('CUSTOSEM').AsFloat;
        if not vQueryCloud.FieldByName('FOTO').IsNull then
          vQueryLocal.ParamByName('FOTO').Assign(vQueryCloud.FieldByName('FOTO'));
        if not vQueryCloud.FieldByName('DELETADO').IsNull then
          vQueryLocal.ParamByName('DELETADO').AsString := vQueryCloud.FieldByName('DELETADO').AsString;
        if not vQueryCloud.FieldByName('COMISSAO').IsNull then
          vQueryLocal.ParamByName('COMISSAO').AsFloat := vQueryCloud.FieldByName('COMISSAO').AsFloat;
        if not vQueryCloud.FieldByName('ESTOQUE_ID').IsNull then
          vQueryLocal.ParamByName('ESTOQUE_ID').AsInteger := vQueryCloud.FieldByName('ESTOQUE_ID').AsInteger;
        if not vQueryCloud.FieldByName('ESTOQUE_NOME').IsNull then
          vQueryLocal.ParamByName('ESTOQUE_NOME').AsString := vQueryCloud.FieldByName('ESTOQUE_NOME').AsString;
        if not vQueryCloud.FieldByName('DATA_INC').IsNull then
          vQueryLocal.ParamByName('DATA_INC').AsDateTime := vQueryCloud.FieldByName('DATA_INC').AsDateTime;
        if not vQueryCloud.FieldByName('DATA_ALT').IsNull then
          vQueryLocal.ParamByName('DATA_ALT').AsDateTime := vQueryCloud.FieldByName('DATA_ALT').AsDateTime;
        if not vQueryCloud.FieldByName('ENDERECO').IsNull then
          vQueryLocal.ParamByName('ENDERECO').AsString := vQueryCloud.FieldByName('ENDERECO').AsString;
        if not vQueryCloud.FieldByName('CIDADE').IsNull then
          vQueryLocal.ParamByName('CIDADE').AsString := vQueryCloud.FieldByName('CIDADE').AsString;
        if not vQueryCloud.FieldByName('UF').IsNull then
          vQueryLocal.ParamByName('UF').AsString := vQueryCloud.FieldByName('UF').AsString;
        if not vQueryCloud.FieldByName('BAIRRO').IsNull then
          vQueryLocal.ParamByName('BAIRRO').AsString := vQueryCloud.FieldByName('BAIRRO').AsString;
        if not vQueryCloud.FieldByName('CEP').IsNull then
          vQueryLocal.ParamByName('CEP').AsString := vQueryCloud.FieldByName('CEP').AsString;
        if not vQueryCloud.FieldByName('TIPOPRODUTO_ID').IsNull then
          vQueryLocal.ParamByName('TIPOPRODUTO_ID').AsInteger := vQueryCloud.FieldByName('TIPOPRODUTO_ID').AsInteger;
        if not vQueryCloud.FieldByName('GRUPO_ID').IsNull then
          vQueryLocal.ParamByName('GRUPO_ID').AsString := vQueryCloud.FieldByName('GRUPO_ID').AsString;
        if not vQueryCloud.FieldByName('VOLUME').IsNull then
          vQueryLocal.ParamByName('VOLUME').AsFloat := vQueryCloud.FieldByName('VOLUME').AsFloat;
        if not vQueryCloud.FieldByName('ESPECIFICA_I').IsNull then
          vQueryLocal.ParamByName('ESPECIFICA_I').AsFloat := vQueryCloud.FieldByName('ESPECIFICA_I').AsFloat;
        if not vQueryCloud.FieldByName('ESPECIFICA_F').IsNull then
          vQueryLocal.ParamByName('ESPECIFICA_F').AsFloat := vQueryCloud.FieldByName('ESPECIFICA_F').AsFloat;
        if not vQueryCloud.FieldByName('PESO_VAZIO').IsNull then
          vQueryLocal.ParamByName('PESO_VAZIO').AsFloat := vQueryCloud.FieldByName('PESO_VAZIO').AsFloat;
        if not vQueryCloud.FieldByName('MASSA').IsNull then
          vQueryLocal.ParamByName('MASSA').AsFloat := vQueryCloud.FieldByName('MASSA').AsFloat;
        if not vQueryCloud.FieldByName('DENSIDADE').IsNull then
          vQueryLocal.ParamByName('DENSIDADE').AsFloat := vQueryCloud.FieldByName('DENSIDADE').AsFloat;
        if not vQueryCloud.FieldByName('DENSIDADE_REFERENCIA').IsNull then
          vQueryLocal.ParamByName('DENSIDADE_REFERENCIA').AsFloat := vQueryCloud.FieldByName('DENSIDADE_REFERENCIA').AsFloat;
        if not vQueryCloud.FieldByName('ULTIMOPRECO_VENDA').IsNull then
          vQueryLocal.ParamByName('ULTIMOPRECO_VENDA').AsFloat := vQueryCloud.FieldByName('ULTIMOPRECO_VENDA').AsFloat;
        if not vQueryCloud.FieldByName('REPLICADO').IsNull then
          vQueryLocal.ParamByName('REPLICADO').AsString := vQueryCloud.FieldByName('REPLICADO').AsString;
        if not vQueryCloud.FieldByName('NCM').IsNull then
          vQueryLocal.ParamByName('NCM').AsString := vQueryCloud.FieldByName('NCM').AsString;
        if not vQueryCloud.FieldByName('AREA_M2').IsNull then
          vQueryLocal.ParamByName('AREA_M2').AsFloat := vQueryCloud.FieldByName('AREA_M2').AsFloat;
        if not vQueryCloud.FieldByName('FRENTE_MT').IsNull then
          vQueryLocal.ParamByName('FRENTE_MT').AsFloat := vQueryCloud.FieldByName('FRENTE_MT').AsFloat;
        if not vQueryCloud.FieldByName('FUNDOS_MT').IsNull then
          vQueryLocal.ParamByName('FUNDOS_MT').AsFloat := vQueryCloud.FieldByName('FUNDOS_MT').AsFloat;
        if not vQueryCloud.FieldByName('ESQUERDO_MT').IsNull then
          vQueryLocal.ParamByName('ESQUERDO_MT').AsFloat := vQueryCloud.FieldByName('ESQUERDO_MT').AsFloat;
        if not vQueryCloud.FieldByName('DIREITO_MT').IsNull then
          vQueryLocal.ParamByName('DIREITO_MT').AsFloat := vQueryCloud.FieldByName('DIREITO_MT').AsFloat;
        if not vQueryCloud.FieldByName('TIPO_ITEM').IsNull then
          vQueryLocal.ParamByName('TIPO_ITEM').AsString := vQueryCloud.FieldByName('TIPO_ITEM').AsString;
        if not vQueryCloud.FieldByName('EX_TIPI').IsNull then
          vQueryLocal.ParamByName('EX_TIPI').AsString := vQueryCloud.FieldByName('EX_TIPI').AsString;
        if not vQueryCloud.FieldByName('GENERO_ITEM').IsNull then
          vQueryLocal.ParamByName('GENERO_ITEM').AsString := vQueryCloud.FieldByName('GENERO_ITEM').AsString;
        if not vQueryCloud.FieldByName('COD_LST').IsNull then
          vQueryLocal.ParamByName('COD_LST').AsString := vQueryCloud.FieldByName('COD_LST').AsString;
        if not vQueryCloud.FieldByName('PRECO_ALUGUEL').IsNull then
          vQueryLocal.ParamByName('PRECO_ALUGUEL').AsFloat := vQueryCloud.FieldByName('PRECO_ALUGUEL').AsFloat;
        if not vQueryCloud.FieldByName('PRECO_CONDOMINIO').IsNull then
          vQueryLocal.ParamByName('PRECO_CONDOMINIO').AsFloat := vQueryCloud.FieldByName('PRECO_CONDOMINIO').AsFloat;
        if not vQueryCloud.FieldByName('NATUREZA').IsNull then
          vQueryLocal.ParamByName('NATUREZA').AsString := vQueryCloud.FieldByName('NATUREZA').AsString;
        if not vQueryCloud.FieldByName('TIPO_IMOVEL').IsNull then
          vQueryLocal.ParamByName('TIPO_IMOVEL').AsString := vQueryCloud.FieldByName('TIPO_IMOVEL').AsString;
        if not vQueryCloud.FieldByName('IMOVEL').IsNull then
          vQueryLocal.ParamByName('IMOVEL').AsString := vQueryCloud.FieldByName('IMOVEL').AsString;
        if not vQueryCloud.FieldByName('CC_ID').IsNull then
          vQueryLocal.ParamByName('CC_ID').AsInteger := vQueryCloud.FieldByName('CC_ID').AsInteger;
        if not vQueryCloud.FieldByName('SUBGRUPO_ID').IsNull then
          vQueryLocal.ParamByName('SUBGRUPO_ID').AsString := vQueryCloud.FieldByName('SUBGRUPO_ID').AsString;
        if not vQueryCloud.FieldByName('AREA_CONTRUIDA').IsNull then
          vQueryLocal.ParamByName('AREA_CONTRUIDA').AsFloat := vQueryCloud.FieldByName('AREA_CONTRUIDA').AsFloat;
        if not vQueryCloud.FieldByName('QUADRA_ID').IsNull then
          vQueryLocal.ParamByName('QUADRA_ID').AsInteger := vQueryCloud.FieldByName('QUADRA_ID').AsInteger;
        if not vQueryCloud.FieldByName('OBS').IsNull then
          vQueryLocal.ParamByName('OBS').Assign(vQueryCloud.FieldByName('OBS'));
        if not vQueryCloud.FieldByName('ERP_CODIGO').IsNull then
          vQueryLocal.ParamByName('ERP_CODIGO').AsString := vQueryCloud.FieldByName('ERP_CODIGO').AsString;
        if not vQueryCloud.FieldByName('POLICIAFEDERAL').IsNull then
          vQueryLocal.ParamByName('POLICIAFEDERAL').AsString := vQueryCloud.FieldByName('POLICIAFEDERAL').AsString;
        if not vQueryCloud.FieldByName('TIPOSTATUS').IsNull then
          vQueryLocal.ParamByName('TIPOSTATUS').AsString := vQueryCloud.FieldByName('TIPOSTATUS').AsString;
        if not vQueryCloud.FieldByName('QTDE_CAIXA').IsNull then
          vQueryLocal.ParamByName('QTDE_CAIXA').AsFloat := vQueryCloud.FieldByName('QTDE_CAIXA').AsFloat;
        if not vQueryCloud.FieldByName('PRECO_MAXIMO').IsNull then
          vQueryLocal.ParamByName('PRECO_MAXIMO').AsFloat := vQueryCloud.FieldByName('PRECO_MAXIMO').AsFloat;
        if not vQueryCloud.FieldByName('CONTROLA_TEOR').IsNull then
          vQueryLocal.ParamByName('CONTROLA_TEOR').AsString := vQueryCloud.FieldByName('CONTROLA_TEOR').AsString;
        if not vQueryCloud.FieldByName('USUARIO_I').IsNull then
          vQueryLocal.ParamByName('USUARIO_I').AsInteger := vQueryCloud.FieldByName('USUARIO_I').AsInteger;
        if not vQueryCloud.FieldByName('USUARIONOME_I').IsNull then
          vQueryLocal.ParamByName('USUARIONOME_I').AsString := vQueryCloud.FieldByName('USUARIONOME_I').AsString;
        if not vQueryCloud.FieldByName('USUARIO_A').IsNull then
          vQueryLocal.ParamByName('USUARIO_A').AsInteger := vQueryCloud.FieldByName('USUARIO_A').AsInteger;
        if not vQueryCloud.FieldByName('USUARIONOME_A').IsNull then
          vQueryLocal.ParamByName('USUARIONOME_A').AsString := vQueryCloud.FieldByName('USUARIONOME_A').AsString;
        if not vQueryCloud.FieldByName('USUARIO_D').IsNull then
          vQueryLocal.ParamByName('USUARIO_D').AsInteger := vQueryCloud.FieldByName('USUARIO_D').AsInteger;
        if not vQueryCloud.FieldByName('USUARIONOME_D').IsNull then
          vQueryLocal.ParamByName('USUARIONOME_D').AsString := vQueryCloud.FieldByName('USUARIONOME_D').AsString;
        if not vQueryCloud.FieldByName('DATA_DEL').IsNull then
          vQueryLocal.ParamByName('DATA_DEL').AsDateTime := vQueryCloud.FieldByName('DATA_DEL').AsDateTime;
        if not vQueryCloud.FieldByName('CONTROLA_LOTE').IsNull then
          vQueryLocal.ParamByName('CONTROLA_LOTE').AsString := vQueryCloud.FieldByName('CONTROLA_LOTE').AsString;
        if not vQueryCloud.FieldByName('BLOQUEADO').IsNull then
          vQueryLocal.ParamByName('BLOQUEADO').AsString := vQueryCloud.FieldByName('BLOQUEADO').AsString;
        if not vQueryCloud.FieldByName('ESPECIFICACAO_PADRAO').IsNull then
          vQueryLocal.ParamByName('ESPECIFICACAO_PADRAO').Assign(vQueryCloud.FieldByName('ESPECIFICACAO_PADRAO'));
        if not vQueryCloud.FieldByName('VALIDADE_PROCESSO').IsNull then
          vQueryLocal.ParamByName('VALIDADE_PROCESSO').AsDateTime := vQueryCloud.FieldByName('VALIDADE_PROCESSO').AsDateTime;
        vQueryLocal.ParamByName('SYNC').AsString := 'S';
        vQueryLocal.ParamByName('SYNC_DATA').AsDateTime := vlData;

        vQueryLocal.ExecSQL;
        vQueryLocal.Transaction.CommitRetaining;

        vQueryUpdateCloud.Close;
        vQueryUpdateCloud.SQL.Clear;
        vQueryUpdateCloud.SQL.Add('UPDATE TBPRODUTOS SET SYNC = ''S'', SYNC_DATA = :SYNC_DATA WHERE PRODUTO_ID = :PRODUTO_ID');

        vQueryUpdateCloud.ParamByName('SYNC_DATA').AsDateTime := vlData;
        vQueryUpdateCloud.ParamByName('PRODUTO_ID').AsInteger := vQueryCloud.FieldByName('PRODUTO_ID').AsInteger;

        vQueryUpdateCloud.ExecSQL;
        vQueryUpdateCloud.Transaction.CommitRetaining;

        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-TBPRODUTOS atualizada Cloud->Local: ' +
                           Trim(vQueryCloud.FieldByName('PRODUTO_ID').AsString) + '-' + Trim(vQueryCloud.FieldByName('DESCRICAO').AsString));
          end);
      except on e: Exception do

        begin
          TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-Erro ao atualizar TBPRODUTOS Cloud->Local: ' + E.Message);
            end);

          vQueryLocal.Transaction.RollbackRetaining;
          ALocalDatabase.Connected := False;
          ALocalDatabase.Connected := True;

          ACloudDatabase.Connected := False;
          ACloudDatabase.Connected := True;
        end;
      end;

      vQueryCloud.Next;
      Application.ProcessMessages;
    end;
  finally
    vQueryLocal.Free;
    vQueryCloud.Free;
    vQueryUpdateCloud.Free;
  end;
end;

procedure TForm_PrincipalServer.pAtualizaProdutoLocalToCloud(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction; prProdutoID : String);
var
  vQueryLocal, vQueryCloud, vQueryUpdateLocal: TIBQuery;
  vlData: TDateTime;
begin
  vQueryLocal := TIBQuery.Create(self);
  vQueryCloud := TIBQuery.Create(self);
  vQueryUpdateLocal := TIBQuery.Create(self);

  try
    vQueryLocal.Database := ALocalDatabase;
    vQueryLocal.Transaction := ALocalTransaction;

    vQueryCloud.Database := ACloudDatabase;
    vQueryCloud.Transaction := ACloudTransaction;

    vQueryUpdateLocal.Database := ALocalDatabase;
    vQueryUpdateLocal.Transaction := ALocalTransaction;

    vQueryLocal.Close;
    vQueryLocal.SQL.Text := 'SELECT * FROM TBPRODUTOS WHERE 1=1';

    if Trim(prProdutoID) = '' then
      vQueryLocal.SQL.Add(' AND SYNC = ''N'' ')
    else
      vQueryLocal.SQL.Add(' AND PRODUTO_ID = ''' + Trim(prProdutoID) + ''' ');

    vQueryLocal.Open;
    vQueryLocal.First;
    while not vQueryLocal.Eof do
    begin
      try
        vlData := Now;
        vQueryCloud.Close;
        vQueryCloud.SQL.Clear;
        vQueryCloud.SQL.Add('UPDATE OR INSERT INTO TBPRODUTOS');
        vQueryCloud.SQL.Add('(PRODUTO_ID, EMPRESA_ID, USUARIO_ID, PESSOA_ID, RECNO, REFERENCIA, DESCRICAO, ESTOQUE,');
        vQueryCloud.SQL.Add('PRECO_VENDA, PRECO_MINIMO, PRECO_COMPRA, CODBARRA, IPI, ICMS, UNIDADE, PESO_BRUTO, PESO_LIQUIDO,');
        vQueryCloud.SQL.Add('ESTOQUE_MINIMO, CUSTOCOM, CUSTOSEM, FOTO, DELETADO, COMISSAO, ESTOQUE_ID, ESTOQUE_NOME,');
        vQueryCloud.SQL.Add('DATA_INC, DATA_ALT, ENDERECO, CIDADE, UF, BAIRRO, CEP, TIPOPRODUTO_ID, GRUPO_ID, VOLUME, ESPECIFICA_I,');
        vQueryCloud.SQL.Add('ESPECIFICA_F, PESO_VAZIO, MASSA, DENSIDADE, DENSIDADE_REFERENCIA, ULTIMOPRECO_VENDA, REPLICADO,');
        vQueryCloud.SQL.Add('NCM, AREA_M2, FRENTE_MT, FUNDOS_MT, ESQUERDO_MT, DIREITO_MT, TIPO_ITEM, EX_TIPI, GENERO_ITEM,');
        vQueryCloud.SQL.Add('COD_LST, PRECO_ALUGUEL, PRECO_CONDOMINIO, NATUREZA, TIPO_IMOVEL, IMOVEL, CC_ID, SUBGRUPO_ID,');
        vQueryCloud.SQL.Add('AREA_CONTRUIDA, QUADRA_ID, OBS, ERP_CODIGO, POLICIAFEDERAL, TIPOSTATUS, QTDE_CAIXA, PRECO_MAXIMO,');
        vQueryCloud.SQL.Add('CONTROLA_TEOR, USUARIO_I, USUARIONOME_I, USUARIO_A, USUARIONOME_A, USUARIO_D, USUARIONOME_D,');
        vQueryCloud.SQL.Add('DATA_DEL, CONTROLA_LOTE, BLOQUEADO, ESPECIFICACAO_PADRAO, VALIDADE_PROCESSO, SYNC, SYNC_DATA)');
        vQueryCloud.SQL.Add('VALUES');
        vQueryCloud.SQL.Add('(:PRODUTO_ID, :EMPRESA_ID, :USUARIO_ID, :PESSOA_ID, :RECNO, :REFERENCIA, :DESCRICAO, :ESTOQUE,');
        vQueryCloud.SQL.Add(':PRECO_VENDA, :PRECO_MINIMO, :PRECO_COMPRA, :CODBARRA, :IPI, :ICMS, :UNIDADE, :PESO_BRUTO, :PESO_LIQUIDO,');
        vQueryCloud.SQL.Add(':ESTOQUE_MINIMO, :CUSTOCOM, :CUSTOSEM, :FOTO, :DELETADO, :COMISSAO, :ESTOQUE_ID, :ESTOQUE_NOME,');
        vQueryCloud.SQL.Add(':DATA_INC, :DATA_ALT, :ENDERECO, :CIDADE, :UF, :BAIRRO, :CEP, :TIPOPRODUTO_ID, :GRUPO_ID, :VOLUME, :ESPECIFICA_I,');
        vQueryCloud.SQL.Add(':ESPECIFICA_F, :PESO_VAZIO, :MASSA, :DENSIDADE, :DENSIDADE_REFERENCIA, :ULTIMOPRECO_VENDA, :REPLICADO,');
        vQueryCloud.SQL.Add(':NCM, :AREA_M2, :FRENTE_MT, :FUNDOS_MT, :ESQUERDO_MT, :DIREITO_MT, :TIPO_ITEM, :EX_TIPI, :GENERO_ITEM,');
        vQueryCloud.SQL.Add(':COD_LST, :PRECO_ALUGUEL, :PRECO_CONDOMINIO, :NATUREZA, :TIPO_IMOVEL, :IMOVEL, :CC_ID, :SUBGRUPO_ID,');
        vQueryCloud.SQL.Add(':AREA_CONTRUIDA, :QUADRA_ID, :OBS, :ERP_CODIGO, :POLICIAFEDERAL, :TIPOSTATUS, :QTDE_CAIXA, :PRECO_MAXIMO,');
        vQueryCloud.SQL.Add(':CONTROLA_TEOR, :USUARIO_I, :USUARIONOME_I, :USUARIO_A, :USUARIONOME_A, :USUARIO_D, :USUARIONOME_D,');
        vQueryCloud.SQL.Add(':DATA_DEL, :CONTROLA_LOTE, :BLOQUEADO, :ESPECIFICACAO_PADRAO, :VALIDADE_PROCESSO, :SYNC, :SYNC_DATA)');
        vQueryCloud.SQL.Add('MATCHING (PRODUTO_ID)');

        // Parametros
        vQueryCloud.ParamByName('PRODUTO_ID').AsInteger := vQueryLocal.FieldByName('PRODUTO_ID').AsInteger;
        if not vQueryLocal.FieldByName('EMPRESA_ID').IsNull then
          vQueryCloud.ParamByName('EMPRESA_ID').AsInteger := vQueryLocal.FieldByName('EMPRESA_ID').AsInteger;
        if not vQueryLocal.FieldByName('USUARIO_ID').IsNull then
          vQueryCloud.ParamByName('USUARIO_ID').AsInteger := vQueryLocal.FieldByName('USUARIO_ID').AsInteger;
        if not vQueryLocal.FieldByName('PESSOA_ID').IsNull then
          vQueryCloud.ParamByName('PESSOA_ID').AsInteger := vQueryLocal.FieldByName('PESSOA_ID').AsInteger;
        if not vQueryLocal.FieldByName('RECNO').IsNull then
          vQueryCloud.ParamByName('RECNO').AsInteger := vQueryLocal.FieldByName('RECNO').AsInteger;
        if not vQueryLocal.FieldByName('REFERENCIA').IsNull then
          vQueryCloud.ParamByName('REFERENCIA').AsString := vQueryLocal.FieldByName('REFERENCIA').AsString;
        if not vQueryLocal.FieldByName('DESCRICAO').IsNull then
          vQueryCloud.ParamByName('DESCRICAO').AsString := vQueryLocal.FieldByName('DESCRICAO').AsString;
        if not vQueryLocal.FieldByName('ESTOQUE').IsNull then
          vQueryCloud.ParamByName('ESTOQUE').AsString := vQueryLocal.FieldByName('ESTOQUE').AsString;
        if not vQueryLocal.FieldByName('PRECO_VENDA').IsNull then
          vQueryCloud.ParamByName('PRECO_VENDA').AsFloat := vQueryLocal.FieldByName('PRECO_VENDA').AsFloat;
        if not vQueryLocal.FieldByName('PRECO_MINIMO').IsNull then
          vQueryCloud.ParamByName('PRECO_MINIMO').AsFloat := vQueryLocal.FieldByName('PRECO_MINIMO').AsFloat;
        if not vQueryLocal.FieldByName('PRECO_COMPRA').IsNull then
          vQueryCloud.ParamByName('PRECO_COMPRA').AsFloat := vQueryLocal.FieldByName('PRECO_COMPRA').AsFloat;
        if not vQueryLocal.FieldByName('CODBARRA').IsNull then
          vQueryCloud.ParamByName('CODBARRA').AsString := vQueryLocal.FieldByName('CODBARRA').AsString;
        if not vQueryLocal.FieldByName('IPI').IsNull then
          vQueryCloud.ParamByName('IPI').AsFloat := vQueryLocal.FieldByName('IPI').AsFloat;
        if not vQueryLocal.FieldByName('ICMS').IsNull then
          vQueryCloud.ParamByName('ICMS').AsFloat := vQueryLocal.FieldByName('ICMS').AsFloat;
        if not vQueryLocal.FieldByName('UNIDADE').IsNull then
          vQueryCloud.ParamByName('UNIDADE').AsString := vQueryLocal.FieldByName('UNIDADE').AsString;
        if not vQueryLocal.FieldByName('PESO_BRUTO').IsNull then
          vQueryCloud.ParamByName('PESO_BRUTO').AsFloat := vQueryLocal.FieldByName('PESO_BRUTO').AsFloat;
        if not vQueryLocal.FieldByName('PESO_LIQUIDO').IsNull then
          vQueryCloud.ParamByName('PESO_LIQUIDO').AsFloat := vQueryLocal.FieldByName('PESO_LIQUIDO').AsFloat;
        if not vQueryLocal.FieldByName('ESTOQUE_MINIMO').IsNull then
          vQueryCloud.ParamByName('ESTOQUE_MINIMO').AsInteger := vQueryLocal.FieldByName('ESTOQUE_MINIMO').AsInteger;
        if not vQueryLocal.FieldByName('CUSTOCOM').IsNull then
          vQueryCloud.ParamByName('CUSTOCOM').AsFloat := vQueryLocal.FieldByName('CUSTOCOM').AsFloat;
        if not vQueryLocal.FieldByName('CUSTOSEM').IsNull then
          vQueryCloud.ParamByName('CUSTOSEM').AsFloat := vQueryLocal.FieldByName('CUSTOSEM').AsFloat;
        if not vQueryLocal.FieldByName('FOTO').IsNull then
          vQueryCloud.ParamByName('FOTO').Assign(vQueryLocal.FieldByName('FOTO'));
        if not vQueryLocal.FieldByName('DELETADO').IsNull then
          vQueryCloud.ParamByName('DELETADO').AsString := vQueryLocal.FieldByName('DELETADO').AsString;
        if not vQueryLocal.FieldByName('COMISSAO').IsNull then
          vQueryCloud.ParamByName('COMISSAO').AsFloat := vQueryLocal.FieldByName('COMISSAO').AsFloat;
        if not vQueryLocal.FieldByName('ESTOQUE_ID').IsNull then
          vQueryCloud.ParamByName('ESTOQUE_ID').AsInteger := vQueryLocal.FieldByName('ESTOQUE_ID').AsInteger;
        if not vQueryLocal.FieldByName('ESTOQUE_NOME').IsNull then
          vQueryCloud.ParamByName('ESTOQUE_NOME').AsString := vQueryLocal.FieldByName('ESTOQUE_NOME').AsString;
        if not vQueryLocal.FieldByName('DATA_INC').IsNull then
          vQueryCloud.ParamByName('DATA_INC').AsDateTime := vQueryLocal.FieldByName('DATA_INC').AsDateTime;
        if not vQueryLocal.FieldByName('DATA_ALT').IsNull then
          vQueryCloud.ParamByName('DATA_ALT').AsDateTime := vQueryLocal.FieldByName('DATA_ALT').AsDateTime;
        if not vQueryLocal.FieldByName('ENDERECO').IsNull then
          vQueryCloud.ParamByName('ENDERECO').AsString := vQueryLocal.FieldByName('ENDERECO').AsString;
        if not vQueryLocal.FieldByName('CIDADE').IsNull then
          vQueryCloud.ParamByName('CIDADE').AsString := vQueryLocal.FieldByName('CIDADE').AsString;
        if not vQueryLocal.FieldByName('UF').IsNull then
          vQueryCloud.ParamByName('UF').AsString := vQueryLocal.FieldByName('UF').AsString;
        if not vQueryLocal.FieldByName('BAIRRO').IsNull then
          vQueryCloud.ParamByName('BAIRRO').AsString := vQueryLocal.FieldByName('BAIRRO').AsString;
        if not vQueryLocal.FieldByName('CEP').IsNull then
          vQueryCloud.ParamByName('CEP').AsString := vQueryLocal.FieldByName('CEP').AsString;
        if not vQueryLocal.FieldByName('TIPOPRODUTO_ID').IsNull then
          vQueryCloud.ParamByName('TIPOPRODUTO_ID').AsInteger := vQueryLocal.FieldByName('TIPOPRODUTO_ID').AsInteger;
        if not vQueryLocal.FieldByName('GRUPO_ID').IsNull then
          vQueryCloud.ParamByName('GRUPO_ID').AsString := vQueryLocal.FieldByName('GRUPO_ID').AsString;
        if not vQueryLocal.FieldByName('VOLUME').IsNull then
          vQueryCloud.ParamByName('VOLUME').AsFloat := vQueryLocal.FieldByName('VOLUME').AsFloat;
        if not vQueryLocal.FieldByName('ESPECIFICA_I').IsNull then
          vQueryCloud.ParamByName('ESPECIFICA_I').AsFloat := vQueryLocal.FieldByName('ESPECIFICA_I').AsFloat;
        if not vQueryLocal.FieldByName('ESPECIFICA_F').IsNull then
          vQueryCloud.ParamByName('ESPECIFICA_F').AsFloat := vQueryLocal.FieldByName('ESPECIFICA_F').AsFloat;
        if not vQueryLocal.FieldByName('PESO_VAZIO').IsNull then
          vQueryCloud.ParamByName('PESO_VAZIO').AsFloat := vQueryLocal.FieldByName('PESO_VAZIO').AsFloat;
        if not vQueryLocal.FieldByName('MASSA').IsNull then
          vQueryCloud.ParamByName('MASSA').AsFloat := vQueryLocal.FieldByName('MASSA').AsFloat;
        if not vQueryLocal.FieldByName('DENSIDADE').IsNull then
          vQueryCloud.ParamByName('DENSIDADE').AsFloat := vQueryLocal.FieldByName('DENSIDADE').AsFloat;
        if not vQueryLocal.FieldByName('DENSIDADE_REFERENCIA').IsNull then
          vQueryCloud.ParamByName('DENSIDADE_REFERENCIA').AsFloat := vQueryLocal.FieldByName('DENSIDADE_REFERENCIA').AsFloat;
        if not vQueryLocal.FieldByName('ULTIMOPRECO_VENDA').IsNull then
          vQueryCloud.ParamByName('ULTIMOPRECO_VENDA').AsFloat := vQueryLocal.FieldByName('ULTIMOPRECO_VENDA').AsFloat;
        if not vQueryLocal.FieldByName('REPLICADO').IsNull then
          vQueryCloud.ParamByName('REPLICADO').AsString := vQueryLocal.FieldByName('REPLICADO').AsString;
        if not vQueryLocal.FieldByName('NCM').IsNull then
          vQueryCloud.ParamByName('NCM').AsString := vQueryLocal.FieldByName('NCM').AsString;
        if not vQueryLocal.FieldByName('AREA_M2').IsNull then
          vQueryCloud.ParamByName('AREA_M2').AsFloat := vQueryLocal.FieldByName('AREA_M2').AsFloat;
        if not vQueryLocal.FieldByName('FRENTE_MT').IsNull then
          vQueryCloud.ParamByName('FRENTE_MT').AsFloat := vQueryLocal.FieldByName('FRENTE_MT').AsFloat;
        if not vQueryLocal.FieldByName('FUNDOS_MT').IsNull then
          vQueryCloud.ParamByName('FUNDOS_MT').AsFloat := vQueryLocal.FieldByName('FUNDOS_MT').AsFloat;
        if not vQueryLocal.FieldByName('ESQUERDO_MT').IsNull then
          vQueryCloud.ParamByName('ESQUERDO_MT').AsFloat := vQueryLocal.FieldByName('ESQUERDO_MT').AsFloat;
        if not vQueryLocal.FieldByName('DIREITO_MT').IsNull then
          vQueryCloud.ParamByName('DIREITO_MT').AsFloat := vQueryLocal.FieldByName('DIREITO_MT').AsFloat;
        if not vQueryLocal.FieldByName('TIPO_ITEM').IsNull then
          vQueryCloud.ParamByName('TIPO_ITEM').AsString := vQueryLocal.FieldByName('TIPO_ITEM').AsString;
        if not vQueryLocal.FieldByName('EX_TIPI').IsNull then
          vQueryCloud.ParamByName('EX_TIPI').AsString := vQueryLocal.FieldByName('EX_TIPI').AsString;
        if not vQueryLocal.FieldByName('GENERO_ITEM').IsNull then
          vQueryCloud.ParamByName('GENERO_ITEM').AsString := vQueryLocal.FieldByName('GENERO_ITEM').AsString;
        if not vQueryLocal.FieldByName('COD_LST').IsNull then
          vQueryCloud.ParamByName('COD_LST').AsString := vQueryLocal.FieldByName('COD_LST').AsString;
        if not vQueryLocal.FieldByName('PRECO_ALUGUEL').IsNull then
          vQueryCloud.ParamByName('PRECO_ALUGUEL').AsFloat := vQueryLocal.FieldByName('PRECO_ALUGUEL').AsFloat;
        if not vQueryLocal.FieldByName('PRECO_CONDOMINIO').IsNull then
          vQueryCloud.ParamByName('PRECO_CONDOMINIO').AsFloat := vQueryLocal.FieldByName('PRECO_CONDOMINIO').AsFloat;
        if not vQueryLocal.FieldByName('NATUREZA').IsNull then
          vQueryCloud.ParamByName('NATUREZA').AsString := vQueryLocal.FieldByName('NATUREZA').AsString;
        if not vQueryLocal.FieldByName('TIPO_IMOVEL').IsNull then
          vQueryCloud.ParamByName('TIPO_IMOVEL').AsString := vQueryLocal.FieldByName('TIPO_IMOVEL').AsString;
        if not vQueryLocal.FieldByName('IMOVEL').IsNull then
          vQueryCloud.ParamByName('IMOVEL').AsString := vQueryLocal.FieldByName('IMOVEL').AsString;
        if not vQueryLocal.FieldByName('CC_ID').IsNull then
          vQueryCloud.ParamByName('CC_ID').AsInteger := vQueryLocal.FieldByName('CC_ID').AsInteger;
        if not vQueryLocal.FieldByName('SUBGRUPO_ID').IsNull then
          vQueryCloud.ParamByName('SUBGRUPO_ID').AsString := vQueryLocal.FieldByName('SUBGRUPO_ID').AsString;
        if not vQueryLocal.FieldByName('AREA_CONTRUIDA').IsNull then
          vQueryCloud.ParamByName('AREA_CONTRUIDA').AsFloat := vQueryLocal.FieldByName('AREA_CONTRUIDA').AsFloat;
        if not vQueryLocal.FieldByName('QUADRA_ID').IsNull then
          vQueryCloud.ParamByName('QUADRA_ID').AsInteger := vQueryLocal.FieldByName('QUADRA_ID').AsInteger;
        if not vQueryLocal.FieldByName('OBS').IsNull then
          vQueryCloud.ParamByName('OBS').Assign(vQueryLocal.FieldByName('OBS'));
        if not vQueryLocal.FieldByName('ERP_CODIGO').IsNull then
          vQueryCloud.ParamByName('ERP_CODIGO').AsString := vQueryLocal.FieldByName('ERP_CODIGO').AsString;
        if not vQueryLocal.FieldByName('POLICIAFEDERAL').IsNull then
          vQueryCloud.ParamByName('POLICIAFEDERAL').AsString := vQueryLocal.FieldByName('POLICIAFEDERAL').AsString;
        if not vQueryLocal.FieldByName('TIPOSTATUS').IsNull then
          vQueryCloud.ParamByName('TIPOSTATUS').AsString := vQueryLocal.FieldByName('TIPOSTATUS').AsString;
        if not vQueryLocal.FieldByName('QTDE_CAIXA').IsNull then
          vQueryCloud.ParamByName('QTDE_CAIXA').AsFloat := vQueryLocal.FieldByName('QTDE_CAIXA').AsFloat;
        if not vQueryLocal.FieldByName('PRECO_MAXIMO').IsNull then
          vQueryCloud.ParamByName('PRECO_MAXIMO').AsFloat := vQueryLocal.FieldByName('PRECO_MAXIMO').AsFloat;
        if not vQueryLocal.FieldByName('CONTROLA_TEOR').IsNull then
          vQueryCloud.ParamByName('CONTROLA_TEOR').AsString := vQueryLocal.FieldByName('CONTROLA_TEOR').AsString;
        if not vQueryLocal.FieldByName('USUARIO_I').IsNull then
          vQueryCloud.ParamByName('USUARIO_I').AsInteger := vQueryLocal.FieldByName('USUARIO_I').AsInteger;
        if not vQueryLocal.FieldByName('USUARIONOME_I').IsNull then
          vQueryCloud.ParamByName('USUARIONOME_I').AsString := vQueryLocal.FieldByName('USUARIONOME_I').AsString;
        if not vQueryLocal.FieldByName('USUARIO_A').IsNull then
          vQueryCloud.ParamByName('USUARIO_A').AsInteger := vQueryLocal.FieldByName('USUARIO_A').AsInteger;
        if not vQueryLocal.FieldByName('USUARIONOME_A').IsNull then
          vQueryCloud.ParamByName('USUARIONOME_A').AsString := vQueryLocal.FieldByName('USUARIONOME_A').AsString;
        if not vQueryLocal.FieldByName('USUARIO_D').IsNull then
          vQueryCloud.ParamByName('USUARIO_D').AsInteger := vQueryLocal.FieldByName('USUARIO_D').AsInteger;
        if not vQueryLocal.FieldByName('USUARIONOME_D').IsNull then
          vQueryCloud.ParamByName('USUARIONOME_D').AsString := vQueryLocal.FieldByName('USUARIONOME_D').AsString;
        if not vQueryLocal.FieldByName('DATA_DEL').IsNull then
          vQueryCloud.ParamByName('DATA_DEL').AsDateTime := vQueryLocal.FieldByName('DATA_DEL').AsDateTime;
        if not vQueryLocal.FieldByName('CONTROLA_LOTE').IsNull then
          vQueryCloud.ParamByName('CONTROLA_LOTE').AsString := vQueryLocal.FieldByName('CONTROLA_LOTE').AsString;
        if not vQueryLocal.FieldByName('BLOQUEADO').IsNull then
          vQueryCloud.ParamByName('BLOQUEADO').AsString := vQueryLocal.FieldByName('BLOQUEADO').AsString;
        if not vQueryLocal.FieldByName('ESPECIFICACAO_PADRAO').IsNull then
          vQueryCloud.ParamByName('ESPECIFICACAO_PADRAO').Assign(vQueryLocal.FieldByName('ESPECIFICACAO_PADRAO'));
        if not vQueryLocal.FieldByName('VALIDADE_PROCESSO').IsNull then
          vQueryCloud.ParamByName('VALIDADE_PROCESSO').AsDateTime := vQueryLocal.FieldByName('VALIDADE_PROCESSO').AsDateTime;
        vQueryCloud.ParamByName('SYNC').AsString := 'S';
        vQueryCloud.ParamByName('SYNC_DATA').AsDateTime := vlData;

        vQueryCloud.ExecSQL;
        vQueryCloud.Transaction.CommitRetaining;

        vQueryUpdateLocal.Close;
        vQueryUpdateLocal.SQL.Clear;
        vQueryUpdateLocal.SQL.Add('UPDATE TBPRODUTOS SET SYNC = ''S'', SYNC_DATA = :SYNC_DATA WHERE PRODUTO_ID = :PRODUTO_ID');

        vQueryUpdateLocal.ParamByName('SYNC_DATA').AsDateTime := vlData;
        vQueryUpdateLocal.ParamByName('PRODUTO_ID').AsInteger := vQueryLocal.FieldByName('PRODUTO_ID').AsInteger;

        vQueryUpdateLocal.ExecSQL;
        vQueryUpdateLocal.Transaction.CommitRetaining;

        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-TBPRODUTOS Local->Cloud atualizada: ' +
                           Trim(vQueryLocal.FieldByName('PRODUTO_ID').AsString) + '-' + Trim(vQueryLocal.FieldByName('DESCRICAO').AsString));
          end);
      except on E: Exception do
        begin
          TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-Erro ao atualizar TBPRODUTOS Local->Cloud: ' + E.Message);
            end);

          vQueryCloud.Transaction.RollbackRetaining;
          vQueryUpdateLocal.Transaction.RollbackRetaining;

          ACloudDatabase.Connected := False;
          ACloudDatabase.Connected := True;

          ALocalDatabase.Connected := False;
          ALocalDatabase.Connected := True;

          Break;
        end;
      end;

      vQueryLocal.Next;
    end;
  finally
    vQueryLocal.Free;
    vQueryCloud.Free;
    vQueryUpdateLocal.Free;
  end;
end;

procedure TForm_PrincipalServer.pAtualizaSC;
begin
  with vQuerySIC do
    begin
      Close;
      SQL.Text := 'select * from tbsc where deletado = ''N'' ';
      SQL.Add(' and sync = ''N'' ');
      Open;
    end;

  vQuerySIC.First;

  while not vQuerySIC.Eof do
    begin
       if vPararServidor = True then
         begin
           Timer_Tabelas.Enabled := False;
           Memo_Log.Lines.Add('Servidor Desativado.');
           Abort;
         end;

      with vQueryConstultaWeb do
        begin
          Close;
          SQL.Text := 'select * from tbsc where deletado = ''N'' ';
          SQL.Add(' and sc_id = ''' + Trim(vQuerySIC.FieldByName('SC_ID').AsString) + ''' ') ;
          Open;
        end;

      if vQueryConstultaWeb.IsEmpty then
        begin
          //Inserir
          with vQuerySICWeb do
            begin
              Close;
              SQL.Clear;
              SQL.Text := 'insrt into tbsc sc';
              SQL.Add(' (sc.sc_id, sc.emissao, sc.solicitante_id, sc.solicitante, sc.solicitante_email,');
              SQL.Add(' sc.codigo_interno, sc.data_inc, sc.usuario_i, sc.usuarionome_i,');
              SQL.Add(' sc.data_alt, sc.usuario_a, sc.usuarionome_a, sc.data_del,');
              SQL.Add(' sc.usuario_d, sc.usuarionome_d, sc.usuario_id, sc.empresa_id, sc.deletado, sc.obs,');
              SQL.Add(' sc.tipo,  sc.identificacao, sc.entrega_sc, sc.departamento_id, sc.cc_id,');
              SQL.Add(' sc.aplicacao_id, sc.remoto, sc.impresso, sc.id, sc.ano,');
              SQL.Add(' sc.replicado, sc.imovel_id, sc.pessoa_id, sc.vistoriador,');
              SQL.Add(' sc.supervisor, sc.status, sc.sync, sc.sync_data)');
              SQL.Add(' values');
              SQL.Add(' :psc_id, :pemissao, :psolicitante_id, :psolicitante, :psolicitante_email,');
              SQL.Add(' :pcodigo_interno, :pdata_inc, :pusuario_i, :pusuarionome_i,');
              SQL.Add(' :pdata_alt, :pusuario_a, :pusuarionome_a, :pdata_del,');
              SQL.Add(' :pusuario_d, :pusuarionome_d, :pusuario_id, :pempresa_id, :pdeletado, :pobs,');
              SQL.Add(' :ptipo,  :pidentificacao, :pentrega_sc, :pdepartamento_id, :pcc_id,');
              SQL.Add(' :paplicacao_id, :premoto, :pimpresso, :pid, :pano,');
              SQL.Add(' :preplicado, :pimovel_id, :ppessoa_id, :pvistoriador,');
              SQL.Add(' :psupervisor, :pstatus, :psync, :psync_data');
            end;
        end
      else
        begin
          //Atualizar
          with vQuerySICWeb do
            begin
              Close;
              SQL.Clear;
              SQL.Text := 'update tbsc set';
              SQL.Add(' sc.sc_id = :psc_id,');
              SQL.Add(' sc.emissao = :pemissao,');
              SQL.Add(' sc.solicitante_id = :psolicitante_id,');
              SQL.Add(' sc.solicitante = :psolicitante,');
              SQL.Add(' sc.solicitante_email = :psolicitante_email,');
              SQL.Add(' sc.codigo_interno = :pcodigo_interno,');
              SQL.Add(' sc.data_inc = :pdata_inc,');
              SQL.Add(' sc.usuario_i = :pusuario_i,');
              SQL.Add(' sc.usuarionome_i = :pusuarionome_i,');
              SQL.Add(' sc.data_alt = :pdata_alt,');
              SQL.Add(' sc.usuario_a = :pusuario_a,');
              SQL.Add(' sc.usuarionome_a = :pusuarionome_a,');
              SQL.Add(' sc.data_del = :pdata_del,');
              SQL.Add(' sc.usuario_d = :pusuario_d,');
              SQL.Add(' sc.usuarionome_d = :pusuarionome_d,');
              SQL.Add(' sc.usuario_id = :pusuario_id,');
              SQL.Add(' sc.empresa_id = :pempresa_id,');
              SQL.Add(' sc.deletado = :pdeletado,');
              SQL.Add(' sc.obs = :pobs,');
              SQL.Add(' sc.tipo = :ptipo,');
              SQL.Add(' sc.identificacao = :pidentificacao,');
              SQL.Add(' sc.entrega_sc = :pentrega_sc,');
              SQL.Add(' sc.departamento_id = :pdepartamento_id,');
              SQL.Add(' sc.cc_id = :pcc_id,');
              SQL.Add(' sc.aplicacao_id = :paplicacao_id,');
              SQL.Add(' sc.remoto = :premoto,');
              SQL.Add(' sc.impresso = :pimpresso,');
              SQL.Add(' sc.id = :pid,');
              SQL.Add(' sc.ano = :pano,');
              SQL.Add(' sc.replicado = :preplicado,');
              SQL.Add(' sc.imovel_id = :pimovel_id,');
              SQL.Add(' sc.pessoa_id = :ppessoa_id,');
              SQL.Add(' sc.vistoriador = :pvistoriador,');
              SQL.Add(' sc.supervisor = :psupervisor,');
              SQL.Add(' sc.status = :pstatus,');
              SQL.Add(' sc.sync = :psync,');
              SQL.Add(' sc.sync_data = :psync_data)');

              SQL.Add(' where deletado = ''N'' ');
              SQL.Add(' and sc_id = ''' + Trim(vQuerySIC.FieldByName('SC_ID').AsString) + ''' ');
            end;
        end;

      try
        try
          try
          with vQuerySICWeb do
            begin
              ParamByName('psc_id').Text             := Trim(vQuerySIC.FieldByName('SC_ID').AsString);
              ParamByName('pemissao').Text           := Trim(vQuerySIC.FieldByName('EMISSAO').AsString);
              ParamByName('psolicitante_id').Text    := Trim(vQuerySIC.FieldByName('SOLICITANTE_ID').AsString);
              ParamByName('psolicitante').Text       := Trim(vQuerySIC.FieldByName('SOLICITANTE').AsString);
              ParamByName('psolicitante_email').Text := Trim(vQuerySIC.FieldByName('SOLICITANTE_EMAIL').AsString);
              ParamByName('pcodigo_interno').Text    := Trim(vQuerySIC.FieldByName('CODIGO_INTERNO').AsString);
              ParamByName('pdata_inc').Text          := Trim(vQuerySIC.FieldByName('DATA_INC').AsString);
              ParamByName('pusuario_i').Text         := Trim(vQuerySIC.FieldByName('USUARIO_I').AsString);
              ParamByName('pusuarionome_i').Text     := Trim(vQuerySIC.FieldByName('USUARIONOME_I').AsString);
              ParamByName('pdata_alt').Text          := Trim(vQuerySIC.FieldByName('DATA_ALT').AsString);
              ParamByName('pusuario_a').Text         := Trim(vQuerySIC.FieldByName('USUARIO_A').AsString);
              ParamByName('pusuarionome_a').Text     := Trim(vQuerySIC.FieldByName('USUARIONOME_A').AsString);
              ParamByName('pdata_del').Text          := Trim(vQuerySIC.FieldByName('DATA_DEL').AsString);
              ParamByName('pusuario_d').Text         := Trim(vQuerySIC.FieldByName('USUARIO_D').AsString);
              ParamByName('pusuarionome_d').Text     := Trim(vQuerySIC.FieldByName('USUARIONOME_D').AsString);
              ParamByName('pusuario_id').Text        := Trim(vQuerySIC.FieldByName('USUARIO_ID').AsString);
              ParamByName('pempresa_id').Text        := Trim(vQuerySIC.FieldByName('EMPRESA_ID').AsString);
              ParamByName('pdeletado').Text          := Trim(vQuerySIC.FieldByName('DELETADO').AsString);
              ParamByName('pobs').Text               := Trim(vQuerySIC.FieldByName('OBS').AsString);
              ParamByName('ptipo').Text              := Trim(vQuerySIC.FieldByName('TIPO').AsString);
              ParamByName('pidentificacao').Text     := Trim(vQuerySIC.FieldByName('IDENTIFICACAO').AsString);
              ParamByName('pentrega_sc').Text        := Trim(vQuerySIC.FieldByName('ENTREGA_SC').AsString);
              ParamByName('pdepartamento_id').Text   := Trim(vQuerySIC.FieldByName('DEPARTAMENTO_ID').AsString);
              ParamByName('pcc_id').Text             := Trim(vQuerySIC.FieldByName('CC_ID').AsString);
              ParamByName('paplicacao_id').Text      := Trim(vQuerySIC.FieldByName('APLICACAO_ID').AsString);
              ParamByName('premoto').Text            := Trim(vQuerySIC.FieldByName('REMOTO').AsString);
              ParamByName('pimpresso').Text          := Trim(vQuerySIC.FieldByName('IMPRESSO').AsString);
              ParamByName('pid').Text                := Trim(vQuerySIC.FieldByName('ID').AsString);
              ParamByName('pano').Text               := Trim(vQuerySIC.FieldByName('ANO').AsString);
              ParamByName('preplicado').Text         := Trim(vQuerySIC.FieldByName('REPLICADO').AsString);
              ParamByName('pimovel_id').Text         := Trim(vQuerySIC.FieldByName('IMOVEL_ID').AsString);
              ParamByName('ppessoa_id').Text         := Trim(vQuerySIC.FieldByName('PESSOA_ID').AsString);
              ParamByName('pvistoriador').Text       := Trim(vQuerySIC.FieldByName('VISTORIADOR').AsString);
              ParamByName('psupervisor').Text        := Trim(vQuerySIC.FieldByName('SUPERVISOR').AsString);
              ParamByName('pstatus').Text            := Trim(vQuerySIC.FieldByName('STATUS').AsString);
              ParamByName('psync').Text              := Trim(vQuerySIC.FieldByName('SYNC').AsString);
              ParamByName('psync_data').Text         := Trim(vQuerySIC.FieldByName('SYNC_DATA').AsString);

              ExecSQL;
              Transaction.CommitRetaining;
            end;
          except on e: exception do
            begin
              ShowMessage(e.Message);
            end;

          end;
        finally
          with vQueryUpdate do
            begin
              Close;

              SQL.Clear;
              SQL.Text := 'update tbsc set';
              SQL.Add(' sync = ''S'' ');
              SQL.Add(' sync_data = ''' + FormatDateTime('DD.MM.YYYY HH:MM:SS', Now) + ''' ');
              SQL.Add(' where deletado = ''N'' ');
              SQL.Add(' and  sc_id = ''' + Trim(vQuerySIC.FieldByName('SC_ID').AsString) + ''' ');

              ExecSQL;
            end;

          Memo_Log.Lines.Add('Solicitação de Compras atualizado em ' + FormatDateTime('DD/MM/YYYY HH:MM:SS', Now) + ': '
                            + Trim(vQuerySIC.FieldByName('SC_ID').AsString));
        end;
      except on e : Exception do
        begin
          Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', Now) + ' - Erro ao atualizar produto: ' + e.Message);
          vQuerySICWeb.Transaction.RollbackRetaining;
          dm1.IBDatabase1.Connected := False;
          dm1.IBDatabase1.Connected := True;

        end;
      end;

      vQuerySIC.Next;
      Application.ProcessMessages;
    end;
end;

procedure TForm_PrincipalServer.pAtualizaSCCloudToLocal(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);
var
  vQueryLocal, vQueryCloud, vQueryUpdateCloud: TIBQuery;
  vlData: TDateTime;
begin
  vQueryLocal := TIBQuery.Create(self);
  vQueryCloud := TIBQuery.Create(self);
  vQueryUpdateCloud := TIBQuery.Create(self);

  try
    vQueryLocal.Database := ALocalDatabase;
    vQueryLocal.Transaction := ALocalTransaction;

    vQueryCloud.Database := ACloudDatabase;
    vQueryCloud.Transaction := ACloudTransaction;

    vQueryUpdateCloud.Database := ACloudDatabase;
    vQueryUpdateCloud.Transaction := ACloudTransaction;

    vQueryCloud.Close;
    vQueryCloud.SQL.Text := 'SELECT * FROM TBSC WHERE SYNC = ''N''';
    vQueryCloud.Open;
    vQueryCloud.First;
    while not vQueryCloud.Eof do
    begin
      try
        vlData := Now;
        vQueryLocal.Close;
        vQueryLocal.SQL.Clear;
        vQueryLocal.SQL.Add('UPDATE OR INSERT INTO TBSC');
        vQueryLocal.SQL.Add('(SC_ID, STATUS, EMISSAO, SOLICITANTE_ID, CODIGO_INTERNO, DATA_INC, DATA_ALT, USUARIO_ID, EMPRESA_ID, DELETADO,');
        vQueryLocal.SQL.Add('OBS, TIPO, IDENTIFICACAO, ENTREGA_SC, DEPARTAMENTO_ID, ERP_DEPARTAMENTO, DEPARTAMENTO, CC_ID, CENTRO_CUSTO,');
        vQueryLocal.SQL.Add('ERP_CC, APLICACAO_ID, APLICACAO, REMOTO, IMPRESSO, ID, ANO, REPLICADO, IMOVEL_ID, IMOVEL, PESSOA_ID,');
        vQueryLocal.SQL.Add('CLIENTE, VISTORIADOR, SUPERVISOR, SOLICITANTE, SOLICITANTE_EMAIL, USUARIO_I, USUARIONOME_I, USUARIO_A,');
        vQueryLocal.SQL.Add('USUARIONOME_A, DATA_DEL, USUARIO_D, USUARIONOME_D, DATA_PREVISAO, ENTREGA_ID, ENTREGA, STATUS_DATA,');
        vQueryLocal.SQL.Add('STATUS_USUARIO, SYNC, SYNC_DATA)');
        vQueryLocal.SQL.Add('VALUES');
        vQueryLocal.SQL.Add('(:SC_ID, :STATUS, :EMISSAO, :SOLICITANTE_ID, :CODIGO_INTERNO, :DATA_INC, :DATA_ALT, :USUARIO_ID, :EMPRESA_ID, :DELETADO,');
        vQueryLocal.SQL.Add(':OBS, :TIPO, :IDENTIFICACAO, :ENTREGA_SC, :DEPARTAMENTO_ID, :ERP_DEPARTAMENTO, :DEPARTAMENTO, :CC_ID, :CENTRO_CUSTO,');
        vQueryLocal.SQL.Add(':ERP_CC, :APLICACAO_ID, :APLICACAO, :REMOTO, :IMPRESSO, :ID, :ANO, :REPLICADO, :IMOVEL_ID, :IMOVEL, :PESSOA_ID,');
        vQueryLocal.SQL.Add(':CLIENTE, :VISTORIADOR, :SUPERVISOR, :SOLICITANTE, :SOLICITANTE_EMAIL, :USUARIO_I, :USUARIONOME_I, :USUARIO_A,');
        vQueryLocal.SQL.Add(':USUARIONOME_A, :DATA_DEL, :USUARIO_D, :USUARIONOME_D, :DATA_PREVISAO, :ENTREGA_ID, :ENTREGA, :STATUS_DATA,');
        vQueryLocal.SQL.Add(':STATUS_USUARIO, :SYNC, :SYNC_DATA)');
        vQueryLocal.SQL.Add('MATCHING (SC_ID)');

        // Parâmetros
        vQueryLocal.ParamByName('SC_ID').AsInteger := vQueryCloud.FieldByName('SC_ID').AsInteger;
        vQueryLocal.ParamByName('STATUS').AsString := Trim(vQueryCloud.FieldByName('STATUS').AsString);

        if Trim(vQueryCloud.FieldByName('EMISSAO').AsString) <> '' then
          vQueryLocal.ParamByName('EMISSAO').AsDateTime := vQueryCloud.FieldByName('EMISSAO').AsDateTime;

        vQueryLocal.ParamByName('SOLICITANTE_ID').AsInteger := vQueryCloud.FieldByName('SOLICITANTE_ID').AsInteger;
        vQueryLocal.ParamByName('CODIGO_INTERNO').AsString := Trim(vQueryCloud.FieldByName('CODIGO_INTERNO').AsString);

        if Trim(vQueryCloud.FieldByName('DATA_INC').AsString) <> '' then
          vQueryLocal.ParamByName('DATA_INC').AsDateTime := vQueryCloud.FieldByName('DATA_INC').AsDateTime;

        if Trim(vQueryCloud.FieldByName('DATA_ALT').AsString) <> '' then
          vQueryLocal.ParamByName('DATA_ALT').AsDateTime := vQueryCloud.FieldByName('DATA_ALT').AsDateTime;

        vQueryLocal.ParamByName('USUARIO_ID').AsInteger := vQueryCloud.FieldByName('USUARIO_ID').AsInteger;
        vQueryLocal.ParamByName('EMPRESA_ID').AsInteger := vQueryCloud.FieldByName('EMPRESA_ID').AsInteger;
        vQueryLocal.ParamByName('DELETADO').AsString := Trim(vQueryCloud.FieldByName('DELETADO').AsString);
        vQueryLocal.ParamByName('OBS').AsString := Trim(vQueryCloud.FieldByName('OBS').AsString);
        vQueryLocal.ParamByName('TIPO').AsString := Trim(vQueryCloud.FieldByName('TIPO').AsString);
        vQueryLocal.ParamByName('IDENTIFICACAO').AsString := Trim(vQueryCloud.FieldByName('IDENTIFICACAO').AsString);

        if Trim(vQueryCloud.FieldByName('ENTREGA_SC').AsString) <> '' then
          vQueryLocal.ParamByName('ENTREGA_SC').AsDateTime := vQueryCloud.FieldByName('ENTREGA_SC').AsDateTime;

        vQueryLocal.ParamByName('DEPARTAMENTO_ID').AsInteger := vQueryCloud.FieldByName('DEPARTAMENTO_ID').AsInteger;
        vQueryLocal.ParamByName('ERP_DEPARTAMENTO').AsString := Trim(vQueryCloud.FieldByName('ERP_DEPARTAMENTO').AsString);
        vQueryLocal.ParamByName('DEPARTAMENTO').AsString := Trim(vQueryCloud.FieldByName('DEPARTAMENTO').AsString);
        vQueryLocal.ParamByName('CC_ID').AsInteger := vQueryCloud.FieldByName('CC_ID').AsInteger;
        vQueryLocal.ParamByName('CENTRO_CUSTO').AsString := Trim(vQueryCloud.FieldByName('CENTRO_CUSTO').AsString);
        vQueryLocal.ParamByName('ERP_CC').AsString := Trim(vQueryCloud.FieldByName('ERP_CC').AsString);
        vQueryLocal.ParamByName('APLICACAO_ID').AsInteger := vQueryCloud.FieldByName('APLICACAO_ID').AsInteger;
        vQueryLocal.ParamByName('APLICACAO').AsString := Trim(vQueryCloud.FieldByName('APLICACAO').AsString);
        vQueryLocal.ParamByName('REMOTO').AsString := Trim(vQueryCloud.FieldByName('REMOTO').AsString);
        vQueryLocal.ParamByName('IMPRESSO').AsString := Trim(vQueryCloud.FieldByName('IMPRESSO').AsString);
        vQueryLocal.ParamByName('ID').AsInteger := vQueryCloud.FieldByName('ID').AsInteger;
        vQueryLocal.ParamByName('ANO').AsString := Trim(vQueryCloud.FieldByName('ANO').AsString);
        vQueryLocal.ParamByName('REPLICADO').AsString := Trim(vQueryCloud.FieldByName('REPLICADO').AsString);
        vQueryLocal.ParamByName('IMOVEL_ID').AsInteger := vQueryCloud.FieldByName('IMOVEL_ID').AsInteger;
        vQueryLocal.ParamByName('IMOVEL').AsString := Trim(vQueryCloud.FieldByName('IMOVEL').AsString);
        vQueryLocal.ParamByName('PESSOA_ID').AsInteger := vQueryCloud.FieldByName('PESSOA_ID').AsInteger;
        vQueryLocal.ParamByName('CLIENTE').AsString := Trim(vQueryCloud.FieldByName('CLIENTE').AsString);
        vQueryLocal.ParamByName('VISTORIADOR').AsString := Trim(vQueryCloud.FieldByName('VISTORIADOR').AsString);
        vQueryLocal.ParamByName('SUPERVISOR').AsString := Trim(vQueryCloud.FieldByName('SUPERVISOR').AsString);
        vQueryLocal.ParamByName('SOLICITANTE').AsString := Trim(vQueryCloud.FieldByName('SOLICITANTE').AsString);
        vQueryLocal.ParamByName('SOLICITANTE_EMAIL').AsString := Trim(vQueryCloud.FieldByName('SOLICITANTE_EMAIL').AsString);
        vQueryLocal.ParamByName('USUARIO_I').AsInteger := vQueryCloud.FieldByName('USUARIO_I').AsInteger;
        vQueryLocal.ParamByName('USUARIONOME_I').AsString := Trim(vQueryCloud.FieldByName('USUARIONOME_I').AsString);
        vQueryLocal.ParamByName('USUARIO_A').AsInteger := vQueryCloud.FieldByName('USUARIO_A').AsInteger;
        vQueryLocal.ParamByName('USUARIONOME_A').AsString := Trim(vQueryCloud.FieldByName('USUARIONOME_A').AsString);

        if Trim(vQueryCloud.FieldByName('DATA_DEL').AsString) <> '' then
          vQueryLocal.ParamByName('DATA_DEL').AsDateTime := vQueryCloud.FieldByName('DATA_DEL').AsDateTime;

        vQueryLocal.ParamByName('USUARIO_D').AsInteger := vQueryCloud.FieldByName('USUARIO_D').AsInteger;
        vQueryLocal.ParamByName('USUARIONOME_D').AsString := Trim(vQueryCloud.FieldByName('USUARIONOME_D').AsString);

        if Trim(vQueryCloud.FieldByName('DATA_PREVISAO').AsString) <> '' then
          vQueryLocal.ParamByName('DATA_PREVISAO').AsDateTime := vQueryCloud.FieldByName('DATA_PREVISAO').AsDateTime;

        vQueryLocal.ParamByName('ENTREGA_ID').AsString := Trim(vQueryCloud.FieldByName('ENTREGA_ID').AsString);
        vQueryLocal.ParamByName('ENTREGA').AsString := Trim(vQueryCloud.FieldByName('ENTREGA').AsString);

        if Trim(vQueryCloud.FieldByName('STATUS_DATA').AsString) <> '' then
          vQueryLocal.ParamByName('STATUS_DATA').AsDateTime := vQueryCloud.FieldByName('STATUS_DATA').AsDateTime;

        vQueryLocal.ParamByName('STATUS_USUARIO').AsString := Trim(vQueryCloud.FieldByName('STATUS_USUARIO').AsString);
        vQueryLocal.ParamByName('SYNC').AsString := 'S';
        vQueryLocal.ParamByName('SYNC_DATA').AsDateTime := vlData;

        vQueryLocal.ExecSQL;
        vQueryLocal.Transaction.CommitRetaining;

        vQueryUpdateCloud.Close;
        vQueryUpdateCloud.SQL.Clear;
        vQueryUpdateCloud.SQL.Add('UPDATE TBSC SET SYNC = ''S'', SYNC_DATA = :SYNC_DATA WHERE SC_ID = :SC_ID');

        vQueryUpdateCloud.ParamByName('SYNC_DATA').AsDateTime := vlData;
        vQueryUpdateCloud.ParamByName('SC_ID').AsInteger := vQueryCloud.FieldByName('SC_ID').AsInteger;

        vQueryUpdateCloud.ExecSQL;
        vQueryUpdateCloud.Transaction.CommitRetaining;

        Memo_Log.Lines.Add('SC atualizado em ' + FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ': ' +
                           Trim(vQueryCloud.FieldByName('SC_ID').AsString) + ' - ' + Trim(vQueryCloud.FieldByName('STATUS').AsString));
      except
        on E: Exception do
        begin
          Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ' - Erro ao atualizar SC: ' + E.Message);
          vQueryLocal.Transaction.RollbackRetaining;
          dm1.IBDatabase1.Connected := False;
          dm1.IBDatabase1.Connected := True;

          dm1.IBDatabaseCloudSICFAR.Connected := False;
          dm1.IBDatabaseCloudSICFAR.Connected := True;
        end;
      end;

      vQueryCloud.Next;
      Application.ProcessMessages;
    end;
  finally
    vQueryLocal.Free;
    vQueryCloud.Free;
    vQueryUpdateCloud.Free;
  end;
end;

procedure TForm_PrincipalServer.pAtualizaSCLocalToCloud(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);
var
  vQueryLocal, vQueryCloud, vQueryUpdateLocal: TIBQuery;
  vlData: TDateTime;
begin
  vQueryLocal := TIBQuery.Create(self);
  vQueryCloud := TIBQuery.Create(self);
  vQueryUpdateLocal := TIBQuery.Create(self);

  try
    vQueryLocal.Database := ALocalDatabase;
    vQueryLocal.Transaction := ALocalTransaction;

    vQueryCloud.Database := ACloudDatabase;
    vQueryCloud.Transaction := ACloudTransaction;

    vQueryUpdateLocal.Database := ALocalDatabase;
    vQueryUpdateLocal.Transaction := ALocalTransaction;

    vQueryLocal.Close;
    vQueryLocal.SQL.Text := 'SELECT * FROM TBSC WHERE SYNC = ''N''';
    vQueryLocal.Open;
    vQueryLocal.First;
    while not vQueryLocal.Eof do
    begin
      try
        vlData := Now;
        vQueryCloud.Close;
        vQueryCloud.SQL.Clear;
        vQueryCloud.SQL.Add('UPDATE OR INSERT INTO TBSC');
        vQueryCloud.SQL.Add('(SC_ID, STATUS, EMISSAO, SOLICITANTE_ID, CODIGO_INTERNO, DATA_INC, DATA_ALT, USUARIO_ID, EMPRESA_ID, DELETADO,');
        vQueryCloud.SQL.Add('OBS, TIPO, IDENTIFICACAO, ENTREGA_SC, DEPARTAMENTO_ID, ERP_DEPARTAMENTO, DEPARTAMENTO, CC_ID, CENTRO_CUSTO,');
        vQueryCloud.SQL.Add('ERP_CC, APLICACAO_ID, APLICACAO, REMOTO, IMPRESSO, ID, ANO, REPLICADO, IMOVEL_ID, IMOVEL, PESSOA_ID,');
        vQueryCloud.SQL.Add('CLIENTE, VISTORIADOR, SUPERVISOR, SOLICITANTE, SOLICITANTE_EMAIL, USUARIO_I, USUARIONOME_I, USUARIO_A,');
        vQueryCloud.SQL.Add('USUARIONOME_A, DATA_DEL, USUARIO_D, USUARIONOME_D, DATA_PREVISAO, ENTREGA_ID, ENTREGA, STATUS_DATA,');
        vQueryCloud.SQL.Add('STATUS_USUARIO, SYNC, SYNC_DATA)');
        vQueryCloud.SQL.Add('VALUES');
        vQueryCloud.SQL.Add('(:SC_ID, :STATUS, :EMISSAO, :SOLICITANTE_ID, :CODIGO_INTERNO, :DATA_INC, :DATA_ALT, :USUARIO_ID, :EMPRESA_ID, :DELETADO,');
        vQueryCloud.SQL.Add(':OBS, :TIPO, :IDENTIFICACAO, :ENTREGA_SC, :DEPARTAMENTO_ID, :ERP_DEPARTAMENTO, :DEPARTAMENTO, :CC_ID, :CENTRO_CUSTO,');
        vQueryCloud.SQL.Add(':ERP_CC, :APLICACAO_ID, :APLICACAO, :REMOTO, :IMPRESSO, :ID, :ANO, :REPLICADO, :IMOVEL_ID, :IMOVEL, :PESSOA_ID,');
        vQueryCloud.SQL.Add(':CLIENTE, :VISTORIADOR, :SUPERVISOR, :SOLICITANTE, :SOLICITANTE_EMAIL, :USUARIO_I, :USUARIONOME_I, :USUARIO_A,');
        vQueryCloud.SQL.Add(':USUARIONOME_A, :DATA_DEL, :USUARIO_D, :USUARIONOME_D, :DATA_PREVISAO, :ENTREGA_ID, :ENTREGA, :STATUS_DATA,');
        vQueryCloud.SQL.Add(':STATUS_USUARIO, :SYNC, :SYNC_DATA)');
        vQueryCloud.SQL.Add('MATCHING (SC_ID)');

        // Parâmetros
        vQueryCloud.ParamByName('SC_ID').AsInteger := vQueryLocal.FieldByName('SC_ID').AsInteger;
        vQueryCloud.ParamByName('STATUS').AsString := Trim(vQueryLocal.FieldByName('STATUS').AsString);
        vQueryCloud.ParamByName('EMISSAO').AsDateTime := vQueryLocal.FieldByName('EMISSAO').AsDateTime;
        vQueryCloud.ParamByName('SOLICITANTE_ID').AsInteger := vQueryLocal.FieldByName('SOLICITANTE_ID').AsInteger;
        vQueryCloud.ParamByName('CODIGO_INTERNO').AsString := Trim(vQueryLocal.FieldByName('CODIGO_INTERNO').AsString);
        vQueryCloud.ParamByName('DATA_INC').AsDateTime := vQueryLocal.FieldByName('DATA_INC').AsDateTime;
        vQueryCloud.ParamByName('DATA_ALT').AsDateTime := vQueryLocal.FieldByName('DATA_ALT').AsDateTime;
        vQueryCloud.ParamByName('USUARIO_ID').AsInteger := vQueryLocal.FieldByName('USUARIO_ID').AsInteger;
        vQueryCloud.ParamByName('EMPRESA_ID').AsInteger := vQueryLocal.FieldByName('EMPRESA_ID').AsInteger;
        vQueryCloud.ParamByName('DELETADO').AsString := Trim(vQueryLocal.FieldByName('DELETADO').AsString);
        vQueryCloud.ParamByName('OBS').AsString := Trim(vQueryLocal.FieldByName('OBS').AsString);
        vQueryCloud.ParamByName('TIPO').AsString := Trim(vQueryLocal.FieldByName('TIPO').AsString);
        vQueryCloud.ParamByName('IDENTIFICACAO').AsString := Trim(vQueryLocal.FieldByName('IDENTIFICACAO').AsString);
        vQueryCloud.ParamByName('ENTREGA_SC').AsDateTime := vQueryLocal.FieldByName('ENTREGA_SC').AsDateTime;
        vQueryCloud.ParamByName('DEPARTAMENTO_ID').AsInteger := vQueryLocal.FieldByName('DEPARTAMENTO_ID').AsInteger;
        vQueryCloud.ParamByName('ERP_DEPARTAMENTO').AsString := Trim(vQueryLocal.FieldByName('ERP_DEPARTAMENTO').AsString);
        vQueryCloud.ParamByName('DEPARTAMENTO').AsString := Trim(vQueryLocal.FieldByName('DEPARTAMENTO').AsString);
        vQueryCloud.ParamByName('CC_ID').AsInteger := vQueryLocal.FieldByName('CC_ID').AsInteger;
        vQueryCloud.ParamByName('CENTRO_CUSTO').AsString := Trim(vQueryLocal.FieldByName('CENTRO_CUSTO').AsString);
        vQueryCloud.ParamByName('ERP_CC').AsString := Trim(vQueryLocal.FieldByName('ERP_CC').AsString);
        vQueryCloud.ParamByName('APLICACAO_ID').AsInteger := vQueryLocal.FieldByName('APLICACAO_ID').AsInteger;
        vQueryCloud.ParamByName('APLICACAO').AsString := Trim(vQueryLocal.FieldByName('APLICACAO').AsString);
        vQueryCloud.ParamByName('REMOTO').AsString := Trim(vQueryLocal.FieldByName('REMOTO').AsString);
        vQueryCloud.ParamByName('IMPRESSO').AsString := Trim(vQueryLocal.FieldByName('IMPRESSO').AsString);
        vQueryCloud.ParamByName('ID').AsInteger := vQueryLocal.FieldByName('ID').AsInteger;
        vQueryCloud.ParamByName('ANO').AsString := Trim(vQueryLocal.FieldByName('ANO').AsString);
        vQueryCloud.ParamByName('REPLICADO').AsString := Trim(vQueryLocal.FieldByName('REPLICADO').AsString);
        vQueryCloud.ParamByName('IMOVEL_ID').AsInteger := vQueryLocal.FieldByName('IMOVEL_ID').AsInteger;
        vQueryCloud.ParamByName('IMOVEL').AsString := Trim(vQueryLocal.FieldByName('IMOVEL').AsString);
        vQueryCloud.ParamByName('PESSOA_ID').AsInteger := vQueryLocal.FieldByName('PESSOA_ID').AsInteger;
        vQueryCloud.ParamByName('CLIENTE').AsString := Trim(vQueryLocal.FieldByName('CLIENTE').AsString);
        vQueryCloud.ParamByName('VISTORIADOR').AsString := Trim(vQueryLocal.FieldByName('VISTORIADOR').AsString);
        vQueryCloud.ParamByName('SUPERVISOR').AsString := Trim(vQueryLocal.FieldByName('SUPERVISOR').AsString);
        vQueryCloud.ParamByName('SOLICITANTE').AsString := Trim(vQueryLocal.FieldByName('SOLICITANTE').AsString);
        vQueryCloud.ParamByName('SOLICITANTE_EMAIL').AsString := Trim(vQueryLocal.FieldByName('SOLICITANTE_EMAIL').AsString);
        vQueryCloud.ParamByName('USUARIO_I').AsInteger := vQueryLocal.FieldByName('USUARIO_I').AsInteger;
        vQueryCloud.ParamByName('USUARIONOME_I').AsString := Trim(vQueryLocal.FieldByName('USUARIONOME_I').AsString);
        vQueryCloud.ParamByName('USUARIO_A').AsInteger := vQueryLocal.FieldByName('USUARIO_A').AsInteger;
        vQueryCloud.ParamByName('USUARIONOME_A').AsString := Trim(vQueryLocal.FieldByName('USUARIONOME_A').AsString);
        vQueryCloud.ParamByName('DATA_DEL').AsDateTime := vQueryLocal.FieldByName('DATA_DEL').AsDateTime;
        vQueryCloud.ParamByName('USUARIO_D').AsInteger := vQueryLocal.FieldByName('USUARIO_D').AsInteger;
        vQueryCloud.ParamByName('USUARIONOME_D').AsString := Trim(vQueryLocal.FieldByName('USUARIONOME_D').AsString);
        vQueryCloud.ParamByName('DATA_PREVISAO').AsDateTime := vQueryLocal.FieldByName('DATA_PREVISAO').AsDateTime;
        vQueryCloud.ParamByName('ENTREGA_ID').AsString := Trim(vQueryLocal.FieldByName('ENTREGA_ID').AsString);
        vQueryCloud.ParamByName('ENTREGA').AsString := Trim(vQueryLocal.FieldByName('ENTREGA').AsString);
        vQueryCloud.ParamByName('STATUS_DATA').AsDateTime := vQueryLocal.FieldByName('STATUS_DATA').AsDateTime;
        vQueryCloud.ParamByName('STATUS_USUARIO').AsString := Trim(vQueryLocal.FieldByName('STATUS_USUARIO').AsString);
        vQueryCloud.ParamByName('SYNC').AsString := 'S';
        vQueryCloud.ParamByName('SYNC_DATA').AsDateTime := vlData;

        vQueryCloud.ExecSQL;
        vQueryCloud.Transaction.CommitRetaining;

        vQueryUpdateLocal.Close;
        vQueryUpdateLocal.SQL.Clear;
        vQueryUpdateLocal.SQL.Add('UPDATE TBSC SET SYNC = ''S'', SYNC_DATA = :SYNC_DATA WHERE SC_ID = :SC_ID');

        vQueryUpdateLocal.ParamByName('SYNC_DATA').AsDateTime := vlData;
        vQueryUpdateLocal.ParamByName('SC_ID').AsInteger := vQueryLocal.FieldByName('SC_ID').AsInteger;

        vQueryUpdateLocal.ExecSQL;
        vQueryUpdateLocal.Transaction.CommitRetaining;

        Memo_Log.Lines.Add('SC atualizado em ' + FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ': ' +
                           Trim(vQueryLocal.FieldByName('SC_ID').AsString) + ' - ' + Trim(vQueryLocal.FieldByName('STATUS').AsString));
      except
        on E: Exception do
        begin
          Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + ' - Erro ao atualizar SC: ' + E.Message);
          vQueryCloud.Transaction.RollbackRetaining;
          dm1.IBDatabase1.Connected := False;
          dm1.IBDatabase1.Connected := True;

          dm1.IBDatabaseCloudSICFAR.Connected := False;
          dm1.IBDatabaseCloudSICFAR.Connected := True;
        end;
      end;

      vQueryLocal.Next;
      Application.ProcessMessages;
    end;
  finally
    vQueryLocal.Free;
    vQueryCloud.Free;
    vQueryUpdateLocal.Free;
  end;
end;

procedure TForm_PrincipalServer.pAtualizaUsuarioCloudToLocal(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);
var
  vQueryLocal, vQueryCloud, vQueryUpdateCloud: TIBQuery;
  vlData: TDateTime;
begin
  vQueryLocal := TIBQuery.Create(self);
  vQueryCloud := TIBQuery.Create(self);
  vQueryUpdateCloud := TIBQuery.Create(self);

  try
    vQueryLocal.Database := ALocalDatabase;
    vQueryLocal.Transaction := ALocalTransaction;

    vQueryCloud.Database := ACloudDatabase;
    vQueryCloud.Transaction := ACloudTransaction;

    vQueryUpdateCloud.Database := ACloudDatabase;
    vQueryUpdateCloud.Transaction := ACloudTransaction;

    vQueryCloud.Close;
    vQueryCloud.SQL.Text := 'SELECT * FROM TBUSUARIO WHERE SYNC = ''N''';
    vQueryCloud.Open;
    vQueryCloud.First;
    while not vQueryCloud.Eof do
    begin
      try
        vlData := Now;
        vQueryLocal.Close;
        vQueryLocal.SQL.Clear;
        vQueryLocal.SQL.Add('UPDATE OR INSERT INTO TBUSUARIO');
        vQueryLocal.SQL.Add('(USUARIO_ID, NOME, SENHA, PERFIL_ID, PERFIL, DELETADO, DATA_INC, USUARIO_I, USUARIONOME_I,');
        vQueryLocal.SQL.Add('DATA_ALT, USUARIO_A, USUARIONOME_A, DATA_DEL, USUARIO_D, USUARIONOME_D, EMAIL, RAMAL,');
        vQueryLocal.SQL.Add('ERP_VENDEDOR, ERP_VENDEDOR_NOME, ERP_REPRESENTANTE, ERP_REPRESENTANTE_NOME, GRUPO_PRODUTO,');
        vQueryLocal.SQL.Add('VENDEDOR_ID, REPRESENTANTE_ID, BANCOS, EXPIRACAO, BLOQUEADO, NOME_FANTASIA, DEPARTAMENTO_ID,');
        vQueryLocal.SQL.Add('DEPARTAMENTO, DEPARTAMENTOS, LABORATORIO_ID, VERSAO, ATUALIZADO, ONLINE, LABORATORIO, REMOTO,');
        vQueryLocal.SQL.Add('ACESSO, ASSINATURA, CONEXAO, EXPIRA_SENHA, IP, BALANCAS, ATIV_DEPTOS, ARMAZENS, PROJETO_DEPTOS,');
        vQueryLocal.SQL.Add('EXPIRACAO_DIAS, TENTATIVAS_ACESSO, CARGO_ID, CARGO, SYNC, SYNC_DATA)');
        vQueryLocal.SQL.Add('VALUES');
        vQueryLocal.SQL.Add('(:USUARIO_ID, :NOME, :SENHA, :PERFIL_ID, :PERFIL, :DELETADO, :DATA_INC, :USUARIO_I, :USUARIONOME_I,');
        vQueryLocal.SQL.Add(':DATA_ALT, :USUARIO_A, :USUARIONOME_A, :DATA_DEL, :USUARIO_D, :USUARIONOME_D, :EMAIL, :RAMAL,');
        vQueryLocal.SQL.Add(':ERP_VENDEDOR, :ERP_VENDEDOR_NOME, :ERP_REPRESENTANTE, :ERP_REPRESENTANTE_NOME, :GRUPO_PRODUTO,');
        vQueryLocal.SQL.Add(':VENDEDOR_ID, :REPRESENTANTE_ID, :BANCOS, :EXPIRACAO, :BLOQUEADO, :NOME_FANTASIA, :DEPARTAMENTO_ID,');
        vQueryLocal.SQL.Add(':DEPARTAMENTO, :DEPARTAMENTOS, :LABORATORIO_ID, :VERSAO, :ATUALIZADO, :ONLINE, :LABORATORIO, :REMOTO,');
        vQueryLocal.SQL.Add(':ACESSO, :ASSINATURA, :CONEXAO, :EXPIRA_SENHA, :IP, :BALANCAS, :ATIV_DEPTOS, :ARMAZENS, :PROJETO_DEPTOS,');
        vQueryLocal.SQL.Add(':EXPIRACAO_DIAS, :TENTATIVAS_ACESSO, :CARGO_ID, :CARGO, :SYNC, :SYNC_DATA)');
        vQueryLocal.SQL.Add('MATCHING (USUARIO_ID)');

        // Parametros
        vQueryLocal.ParamByName('USUARIO_ID').AsString := vQueryCloud.FieldByName('USUARIO_ID').AsString;
        if not vQueryCloud.FieldByName('NOME').IsNull then
          vQueryLocal.ParamByName('NOME').AsString := vQueryCloud.FieldByName('NOME').AsString;
        if not vQueryCloud.FieldByName('SENHA').IsNull then
          vQueryLocal.ParamByName('SENHA').AsString := vQueryCloud.FieldByName('SENHA').AsString;
        if not vQueryCloud.FieldByName('PERFIL_ID').IsNull then
          vQueryLocal.ParamByName('PERFIL_ID').AsString := vQueryCloud.FieldByName('PERFIL_ID').AsString;
        if not vQueryCloud.FieldByName('PERFIL').IsNull then
          vQueryLocal.ParamByName('PERFIL').AsString := vQueryCloud.FieldByName('PERFIL').AsString;
        if not vQueryCloud.FieldByName('DELETADO').IsNull then
          vQueryLocal.ParamByName('DELETADO').AsString := vQueryCloud.FieldByName('DELETADO').AsString;
        if not vQueryCloud.FieldByName('DATA_INC').IsNull then
          vQueryLocal.ParamByName('DATA_INC').AsDateTime := vQueryCloud.FieldByName('DATA_INC').AsDateTime;
        if not vQueryCloud.FieldByName('USUARIO_I').IsNull then
          vQueryLocal.ParamByName('USUARIO_I').AsString := vQueryCloud.FieldByName('USUARIO_I').AsString;
        if not vQueryCloud.FieldByName('USUARIONOME_I').IsNull then
          vQueryLocal.ParamByName('USUARIONOME_I').AsString := vQueryCloud.FieldByName('USUARIONOME_I').AsString;
        if not vQueryCloud.FieldByName('DATA_ALT').IsNull then
          vQueryLocal.ParamByName('DATA_ALT').AsDateTime := vQueryCloud.FieldByName('DATA_ALT').AsDateTime;
        if not vQueryCloud.FieldByName('USUARIO_A').IsNull then
          vQueryLocal.ParamByName('USUARIO_A').AsString := vQueryCloud.FieldByName('USUARIO_A').AsString;
        if not vQueryCloud.FieldByName('USUARIONOME_A').IsNull then
          vQueryLocal.ParamByName('USUARIONOME_A').AsString := vQueryCloud.FieldByName('USUARIONOME_A').AsString;
        if not vQueryCloud.FieldByName('DATA_DEL').IsNull then
          vQueryLocal.ParamByName('DATA_DEL').AsDateTime := vQueryCloud.FieldByName('DATA_DEL').AsDateTime;
        if not vQueryCloud.FieldByName('USUARIO_D').IsNull then
          vQueryLocal.ParamByName('USUARIO_D').AsString := vQueryCloud.FieldByName('USUARIO_D').AsString;
        if not vQueryCloud.FieldByName('USUARIONOME_D').IsNull then
          vQueryLocal.ParamByName('USUARIONOME_D').AsString := vQueryCloud.FieldByName('USUARIONOME_D').AsString;
        if not vQueryCloud.FieldByName('EMAIL').IsNull then
          vQueryLocal.ParamByName('EMAIL').AsString := vQueryCloud.FieldByName('EMAIL').AsString;
        if not vQueryCloud.FieldByName('RAMAL').IsNull then
          vQueryLocal.ParamByName('RAMAL').AsString := vQueryCloud.FieldByName('RAMAL').AsString;
        if not vQueryCloud.FieldByName('ERP_VENDEDOR').IsNull then
          vQueryLocal.ParamByName('ERP_VENDEDOR').AsString := vQueryCloud.FieldByName('ERP_VENDEDOR').AsString;
        if not vQueryCloud.FieldByName('ERP_VENDEDOR_NOME').IsNull then
          vQueryLocal.ParamByName('ERP_VENDEDOR_NOME').AsString := vQueryCloud.FieldByName('ERP_VENDEDOR_NOME').AsString;
        if not vQueryCloud.FieldByName('ERP_REPRESENTANTE').IsNull then
          vQueryLocal.ParamByName('ERP_REPRESENTANTE').AsString := vQueryCloud.FieldByName('ERP_REPRESENTANTE').AsString;
        if not vQueryCloud.FieldByName('ERP_REPRESENTANTE_NOME').IsNull then
          vQueryLocal.ParamByName('ERP_REPRESENTANTE_NOME').AsString := vQueryCloud.FieldByName('ERP_REPRESENTANTE_NOME').AsString;
        if not vQueryCloud.FieldByName('GRUPO_PRODUTO').IsNull then
          vQueryLocal.ParamByName('GRUPO_PRODUTO').AsString := vQueryCloud.FieldByName('GRUPO_PRODUTO').AsString;
        if not vQueryCloud.FieldByName('VENDEDOR_ID').IsNull then
          vQueryLocal.ParamByName('VENDEDOR_ID').AsString := vQueryCloud.FieldByName('VENDEDOR_ID').AsString;
        if not vQueryCloud.FieldByName('REPRESENTANTE_ID').IsNull then
          vQueryLocal.ParamByName('REPRESENTANTE_ID').AsString := vQueryCloud.FieldByName('REPRESENTANTE_ID').AsString;
        if not vQueryCloud.FieldByName('BANCOS').IsNull then
          vQueryLocal.ParamByName('BANCOS').AsString := vQueryCloud.FieldByName('BANCOS').AsString;
        if not vQueryCloud.FieldByName('EXPIRACAO').IsNull then
          vQueryLocal.ParamByName('EXPIRACAO').AsDateTime := vQueryCloud.FieldByName('EXPIRACAO').AsDateTime;
        if not vQueryCloud.FieldByName('BLOQUEADO').IsNull then
          vQueryLocal.ParamByName('BLOQUEADO').AsString := vQueryCloud.FieldByName('BLOQUEADO').AsString;
        if not vQueryCloud.FieldByName('NOME_FANTASIA').IsNull then
          vQueryLocal.ParamByName('NOME_FANTASIA').AsString := vQueryCloud.FieldByName('NOME_FANTASIA').AsString;
        if not vQueryCloud.FieldByName('DEPARTAMENTO_ID').IsNull then
          vQueryLocal.ParamByName('DEPARTAMENTO_ID').AsString := vQueryCloud.FieldByName('DEPARTAMENTO_ID').AsString;
        if not vQueryCloud.FieldByName('DEPARTAMENTO').IsNull then
          vQueryLocal.ParamByName('DEPARTAMENTO').AsString := vQueryCloud.FieldByName('DEPARTAMENTO').AsString;
        if not vQueryCloud.FieldByName('DEPARTAMENTOS').IsNull then
          vQueryLocal.ParamByName('DEPARTAMENTOS').AsString := vQueryCloud.FieldByName('DEPARTAMENTOS').AsString;
        if not vQueryCloud.FieldByName('LABORATORIO_ID').IsNull then
          vQueryLocal.ParamByName('LABORATORIO_ID').AsString := vQueryCloud.FieldByName('LABORATORIO_ID').AsString;
        if not vQueryCloud.FieldByName('VERSAO').IsNull then
          vQueryLocal.ParamByName('VERSAO').AsString := vQueryCloud.FieldByName('VERSAO').AsString;
        if not vQueryCloud.FieldByName('ATUALIZADO').IsNull then
          vQueryLocal.ParamByName('ATUALIZADO').AsString := vQueryCloud.FieldByName('ATUALIZADO').AsString;
        if not vQueryCloud.FieldByName('ONLINE').IsNull then
          vQueryLocal.ParamByName('ONLINE').AsString := vQueryCloud.FieldByName('ONLINE').AsString;
        if not vQueryCloud.FieldByName('LABORATORIO').IsNull then
          vQueryLocal.ParamByName('LABORATORIO').AsString := vQueryCloud.FieldByName('LABORATORIO').AsString;
        if not vQueryCloud.FieldByName('REMOTO').IsNull then
          vQueryLocal.ParamByName('REMOTO').AsString := vQueryCloud.FieldByName('REMOTO').AsString;
        if not vQueryCloud.FieldByName('ACESSO').IsNull then
          vQueryLocal.ParamByName('ACESSO').AsDateTime := vQueryCloud.FieldByName('ACESSO').AsDateTime;
        if not vQueryCloud.FieldByName('ASSINATURA').IsNull then
          vQueryLocal.ParamByName('ASSINATURA').Assign(vQueryCloud.FieldByName('ASSINATURA'));
        if not vQueryCloud.FieldByName('CONEXAO').IsNull then
          vQueryLocal.ParamByName('CONEXAO').AsString := vQueryCloud.FieldByName('CONEXAO').AsString;
        if not vQueryCloud.FieldByName('EXPIRA_SENHA').IsNull then
          vQueryLocal.ParamByName('EXPIRA_SENHA').AsDateTime := vQueryCloud.FieldByName('EXPIRA_SENHA').AsDateTime;
        if not vQueryCloud.FieldByName('IP').IsNull then
          vQueryLocal.ParamByName('IP').AsString := vQueryCloud.FieldByName('IP').AsString;
        if not vQueryCloud.FieldByName('BALANCAS').IsNull then
          vQueryLocal.ParamByName('BALANCAS').AsString := vQueryCloud.FieldByName('BALANCAS').AsString;
        if not vQueryCloud.FieldByName('ATIV_DEPTOS').IsNull then
          vQueryLocal.ParamByName('ATIV_DEPTOS').AsString := vQueryCloud.FieldByName('ATIV_DEPTOS').AsString;
        if not vQueryCloud.FieldByName('ARMAZENS').IsNull then
          vQueryLocal.ParamByName('ARMAZENS').AsString := vQueryCloud.FieldByName('ARMAZENS').AsString;
        if not vQueryCloud.FieldByName('PROJETO_DEPTOS').IsNull then
          vQueryLocal.ParamByName('PROJETO_DEPTOS').AsString := vQueryCloud.FieldByName('PROJETO_DEPTOS').AsString;
        if not vQueryCloud.FieldByName('EXPIRACAO_DIAS').IsNull then
          vQueryLocal.ParamByName('EXPIRACAO_DIAS').AsString := vQueryCloud.FieldByName('EXPIRACAO_DIAS').AsString;
        if not vQueryCloud.FieldByName('TENTATIVAS_ACESSO').IsNull then
          vQueryLocal.ParamByName('TENTATIVAS_ACESSO').AsString := vQueryCloud.FieldByName('TENTATIVAS_ACESSO').AsString;
        if not vQueryCloud.FieldByName('CARGO_ID').IsNull then
          vQueryLocal.ParamByName('CARGO_ID').AsString := vQueryCloud.FieldByName('CARGO_ID').AsString;
        if not vQueryCloud.FieldByName('CARGO').IsNull then
          vQueryLocal.ParamByName('CARGO').AsString := vQueryCloud.FieldByName('CARGO').AsString;
        vQueryLocal.ParamByName('SYNC').AsString := 'S';
        vQueryLocal.ParamByName('SYNC_DATA').AsDateTime := vlData;

        vQueryLocal.ExecSQL;
        vQueryLocal.Transaction.CommitRetaining;

        vQueryUpdateCloud.Close;
        vQueryUpdateCloud.SQL.Clear;
        vQueryUpdateCloud.SQL.Add('UPDATE TBUSUARIO SET SYNC = ''S'', SYNC_DATA = :SYNC_DATA WHERE USUARIO_ID = :USUARIO_ID');

        vQueryUpdateCloud.ParamByName('SYNC_DATA').AsDateTime := vlData;
        vQueryUpdateCloud.ParamByName('USUARIO_ID').AsString := vQueryCloud.FieldByName('USUARIO_ID').AsString;

        vQueryUpdateCloud.ExecSQL;
        vQueryUpdateCloud.Transaction.CommitRetaining;

        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-TBUSUARIOS Cloud->Local atualizado: ' +
                              vQueryCloud.FieldByName('USUARIO_ID').AsString + '-' + vQueryCloud.FieldByName('NOME').AsString);
          end);
      except on E: Exception do
        begin
          TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-Erro ao atualizar TBUSUARIOS Cloud->Local: ' + E.Message);
            end);

          vQueryLocal.Transaction.RollbackRetaining;
          dm1.IBDatabase1.Connected := False;
          dm1.IBDatabase1.Connected := True;

          dm1.IBDatabaseCloudSICFAR.Connected := False;
          dm1.IBDatabaseCloudSICFAR.Connected := True;
        end;
      end;

      vQueryCloud.Next;
      Application.ProcessMessages;
    end;
  finally
    vQueryLocal.Free;
    vQueryCloud.Free;
    vQueryUpdateCloud.Free;
  end;
end;

procedure TForm_PrincipalServer.pAtualizaUsuarioLocalToCloud(
  ALocalDatabase: TIBDatabase; ALocalTransaction: TIBTransaction;
  ACloudDatabase: TIBDatabase; ACloudTransaction: TIBTransaction);
var
  vQueryLocal, vQueryCloud, vQueryUpdateLocal: TIBQuery;
  vlData: TDateTime;
begin
  vQueryLocal := TIBQuery.Create(self);
  vQueryCloud := TIBQuery.Create(self);
  vQueryUpdateLocal := TIBQuery.Create(self);

  try
    vQueryLocal.Database := ALocalDatabase;
    vQueryLocal.Transaction := ALocalTransaction;

    vQueryCloud.Database := ACloudDatabase;
    vQueryCloud.Transaction := ACloudTransaction;

    vQueryUpdateLocal.Database := ALocalDatabase;
    vQueryUpdateLocal.Transaction := ALocalTransaction;

    vQueryLocal.Close;
    vQueryLocal.SQL.Text := 'SELECT * FROM TBUSUARIO WHERE SYNC = ''N''';
    vQueryLocal.Open;
    vQueryLocal.First;
    while not vQueryLocal.Eof do
    begin
      try
        vlData := Now;
        vQueryCloud.Close;
        vQueryCloud.SQL.Clear;
        vQueryCloud.SQL.Add('UPDATE OR INSERT INTO TBUSUARIO');
        vQueryCloud.SQL.Add('(USUARIO_ID, NOME, SENHA, PERFIL_ID, PERFIL, DELETADO, DATA_INC, USUARIO_I, USUARIONOME_I,');
        vQueryCloud.SQL.Add('DATA_ALT, USUARIO_A, USUARIONOME_A, DATA_DEL, USUARIO_D, USUARIONOME_D, EMAIL, RAMAL,');
        vQueryCloud.SQL.Add('ERP_VENDEDOR, ERP_VENDEDOR_NOME, ERP_REPRESENTANTE, ERP_REPRESENTANTE_NOME, GRUPO_PRODUTO,');
        vQueryCloud.SQL.Add('VENDEDOR_ID, REPRESENTANTE_ID, BANCOS, EXPIRACAO, BLOQUEADO, NOME_FANTASIA, DEPARTAMENTO_ID,');
        vQueryCloud.SQL.Add('DEPARTAMENTO, DEPARTAMENTOS, LABORATORIO_ID, VERSAO, ATUALIZADO, ONLINE, LABORATORIO, REMOTO,');
        vQueryCloud.SQL.Add('ACESSO, ASSINATURA, CONEXAO, EXPIRA_SENHA, IP, BALANCAS, ATIV_DEPTOS, ARMAZENS, PROJETO_DEPTOS,');
        vQueryCloud.SQL.Add('EXPIRACAO_DIAS, TENTATIVAS_ACESSO, CARGO_ID, CARGO, SYNC, SYNC_DATA)');
        vQueryCloud.SQL.Add('VALUES');
        vQueryCloud.SQL.Add('(:USUARIO_ID, :NOME, :SENHA, :PERFIL_ID, :PERFIL, :DELETADO, :DATA_INC, :USUARIO_I, :USUARIONOME_I,');
        vQueryCloud.SQL.Add(':DATA_ALT, :USUARIO_A, :USUARIONOME_A, :DATA_DEL, :USUARIO_D, :USUARIONOME_D, :EMAIL, :RAMAL,');
        vQueryCloud.SQL.Add(':ERP_VENDEDOR, :ERP_VENDEDOR_NOME, :ERP_REPRESENTANTE, :ERP_REPRESENTANTE_NOME, :GRUPO_PRODUTO,');
        vQueryCloud.SQL.Add(':VENDEDOR_ID, :REPRESENTANTE_ID, :BANCOS, :EXPIRACAO, :BLOQUEADO, :NOME_FANTASIA, :DEPARTAMENTO_ID,');
        vQueryCloud.SQL.Add(':DEPARTAMENTO, :DEPARTAMENTOS, :LABORATORIO_ID, :VERSAO, :ATUALIZADO, :ONLINE, :LABORATORIO, :REMOTO,');
        vQueryCloud.SQL.Add(':ACESSO, :ASSINATURA, :CONEXAO, :EXPIRA_SENHA, :IP, :BALANCAS, :ATIV_DEPTOS, :ARMAZENS, :PROJETO_DEPTOS,');
        vQueryCloud.SQL.Add(':EXPIRACAO_DIAS, :TENTATIVAS_ACESSO, :CARGO_ID, :CARGO, :SYNC, :SYNC_DATA)');
        vQueryCloud.SQL.Add('MATCHING (USUARIO_ID)');

        // Parametros
        vQueryCloud.ParamByName('USUARIO_ID').AsString := vQueryLocal.FieldByName('USUARIO_ID').AsString;
        if not vQueryLocal.FieldByName('NOME').IsNull then
          vQueryCloud.ParamByName('NOME').AsString := vQueryLocal.FieldByName('NOME').AsString;
        if not vQueryLocal.FieldByName('SENHA').IsNull then
          vQueryCloud.ParamByName('SENHA').AsString := vQueryLocal.FieldByName('SENHA').AsString;
        if not vQueryLocal.FieldByName('PERFIL_ID').IsNull then
          vQueryCloud.ParamByName('PERFIL_ID').AsString := vQueryLocal.FieldByName('PERFIL_ID').AsString;
        if not vQueryLocal.FieldByName('PERFIL').IsNull then
          vQueryCloud.ParamByName('PERFIL').AsString := vQueryLocal.FieldByName('PERFIL').AsString;
        if not vQueryLocal.FieldByName('DELETADO').IsNull then
          vQueryCloud.ParamByName('DELETADO').AsString := vQueryLocal.FieldByName('DELETADO').AsString;
        if not vQueryLocal.FieldByName('DATA_INC').IsNull then
          vQueryCloud.ParamByName('DATA_INC').AsDateTime := vQueryLocal.FieldByName('DATA_INC').AsDateTime;
        if not vQueryLocal.FieldByName('USUARIO_I').IsNull then
          vQueryCloud.ParamByName('USUARIO_I').AsString := vQueryLocal.FieldByName('USUARIO_I').AsString;
        if not vQueryLocal.FieldByName('USUARIONOME_I').IsNull then
          vQueryCloud.ParamByName('USUARIONOME_I').AsString := vQueryLocal.FieldByName('USUARIONOME_I').AsString;
        if not vQueryLocal.FieldByName('DATA_ALT').IsNull then
          vQueryCloud.ParamByName('DATA_ALT').AsDateTime := vQueryLocal.FieldByName('DATA_ALT').AsDateTime;
        if not vQueryLocal.FieldByName('USUARIO_A').IsNull then
          vQueryCloud.ParamByName('USUARIO_A').AsString := vQueryLocal.FieldByName('USUARIO_A').AsString;
        if not vQueryLocal.FieldByName('USUARIONOME_A').IsNull then
          vQueryCloud.ParamByName('USUARIONOME_A').AsString := vQueryLocal.FieldByName('USUARIONOME_A').AsString;
        if not vQueryLocal.FieldByName('DATA_DEL').IsNull then
          vQueryCloud.ParamByName('DATA_DEL').AsDateTime := vQueryLocal.FieldByName('DATA_DEL').AsDateTime;
        if not vQueryLocal.FieldByName('USUARIO_D').IsNull then
          vQueryCloud.ParamByName('USUARIO_D').AsString := vQueryLocal.FieldByName('USUARIO_D').AsString;
        if not vQueryLocal.FieldByName('USUARIONOME_D').IsNull then
          vQueryCloud.ParamByName('USUARIONOME_D').AsString := vQueryLocal.FieldByName('USUARIONOME_D').AsString;
        if not vQueryLocal.FieldByName('EMAIL').IsNull then
          vQueryCloud.ParamByName('EMAIL').AsString := vQueryLocal.FieldByName('EMAIL').AsString;
        if not vQueryLocal.FieldByName('RAMAL').IsNull then
          vQueryCloud.ParamByName('RAMAL').AsString := vQueryLocal.FieldByName('RAMAL').AsString;
        if not vQueryLocal.FieldByName('ERP_VENDEDOR').IsNull then
          vQueryCloud.ParamByName('ERP_VENDEDOR').AsString := vQueryLocal.FieldByName('ERP_VENDEDOR').AsString;
        if not vQueryLocal.FieldByName('ERP_VENDEDOR_NOME').IsNull then
          vQueryCloud.ParamByName('ERP_VENDEDOR_NOME').AsString := vQueryLocal.FieldByName('ERP_VENDEDOR_NOME').AsString;
        if not vQueryLocal.FieldByName('ERP_REPRESENTANTE').IsNull then
          vQueryCloud.ParamByName('ERP_REPRESENTANTE').AsString := vQueryLocal.FieldByName('ERP_REPRESENTANTE').AsString;
        if not vQueryLocal.FieldByName('ERP_REPRESENTANTE_NOME').IsNull then
          vQueryCloud.ParamByName('ERP_REPRESENTANTE_NOME').AsString := vQueryLocal.FieldByName('ERP_REPRESENTANTE_NOME').AsString;
        if not vQueryLocal.FieldByName('GRUPO_PRODUTO').IsNull then
          vQueryCloud.ParamByName('GRUPO_PRODUTO').AsString := vQueryLocal.FieldByName('GRUPO_PRODUTO').AsString;
        if not vQueryLocal.FieldByName('VENDEDOR_ID').IsNull then
          vQueryCloud.ParamByName('VENDEDOR_ID').AsString := vQueryLocal.FieldByName('VENDEDOR_ID').AsString;
        if not vQueryLocal.FieldByName('REPRESENTANTE_ID').IsNull then
          vQueryCloud.ParamByName('REPRESENTANTE_ID').AsString := vQueryLocal.FieldByName('REPRESENTANTE_ID').AsString;
        if not vQueryLocal.FieldByName('BANCOS').IsNull then
          vQueryCloud.ParamByName('BANCOS').AsString := vQueryLocal.FieldByName('BANCOS').AsString;
        if not vQueryLocal.FieldByName('EXPIRACAO').IsNull then
          vQueryCloud.ParamByName('EXPIRACAO').AsDateTime := vQueryLocal.FieldByName('EXPIRACAO').AsDateTime;
        if not vQueryLocal.FieldByName('BLOQUEADO').IsNull then
          vQueryCloud.ParamByName('BLOQUEADO').AsString := vQueryLocal.FieldByName('BLOQUEADO').AsString;
        if not vQueryLocal.FieldByName('NOME_FANTASIA').IsNull then
          vQueryCloud.ParamByName('NOME_FANTASIA').AsString := vQueryLocal.FieldByName('NOME_FANTASIA').AsString;
        if not vQueryLocal.FieldByName('DEPARTAMENTO_ID').IsNull then
          vQueryCloud.ParamByName('DEPARTAMENTO_ID').AsString := vQueryLocal.FieldByName('DEPARTAMENTO_ID').AsString;
        if not vQueryLocal.FieldByName('DEPARTAMENTO').IsNull then
          vQueryCloud.ParamByName('DEPARTAMENTO').AsString := vQueryLocal.FieldByName('DEPARTAMENTO').AsString;
        if not vQueryLocal.FieldByName('DEPARTAMENTOS').IsNull then
          vQueryCloud.ParamByName('DEPARTAMENTOS').AsString := vQueryLocal.FieldByName('DEPARTAMENTOS').AsString;
        if not vQueryLocal.FieldByName('LABORATORIO_ID').IsNull then
          vQueryCloud.ParamByName('LABORATORIO_ID').AsString := vQueryLocal.FieldByName('LABORATORIO_ID').AsString;
        if not vQueryLocal.FieldByName('VERSAO').IsNull then
          vQueryCloud.ParamByName('VERSAO').AsString := vQueryLocal.FieldByName('VERSAO').AsString;
        if not vQueryLocal.FieldByName('ATUALIZADO').IsNull then
          vQueryCloud.ParamByName('ATUALIZADO').AsString := vQueryLocal.FieldByName('ATUALIZADO').AsString;
        if not vQueryLocal.FieldByName('ONLINE').IsNull then
          vQueryCloud.ParamByName('ONLINE').AsString := vQueryLocal.FieldByName('ONLINE').AsString;
        if not vQueryLocal.FieldByName('LABORATORIO').IsNull then
          vQueryCloud.ParamByName('LABORATORIO').AsString := vQueryLocal.FieldByName('LABORATORIO').AsString;
        if not vQueryLocal.FieldByName('REMOTO').IsNull then
          vQueryCloud.ParamByName('REMOTO').AsString := vQueryLocal.FieldByName('REMOTO').AsString;
        if not vQueryLocal.FieldByName('ACESSO').IsNull then
          vQueryCloud.ParamByName('ACESSO').AsDateTime := vQueryLocal.FieldByName('ACESSO').AsDateTime;
        if not vQueryLocal.FieldByName('ASSINATURA').IsNull then
          vQueryCloud.ParamByName('ASSINATURA').Assign(vQueryLocal.FieldByName('ASSINATURA'));
        if not vQueryLocal.FieldByName('CONEXAO').IsNull then
          vQueryCloud.ParamByName('CONEXAO').AsString := vQueryLocal.FieldByName('CONEXAO').AsString;
        if not vQueryLocal.FieldByName('EXPIRA_SENHA').IsNull then
          vQueryCloud.ParamByName('EXPIRA_SENHA').AsDateTime := vQueryLocal.FieldByName('EXPIRA_SENHA').AsDateTime;
        if not vQueryLocal.FieldByName('IP').IsNull then
          vQueryCloud.ParamByName('IP').AsString := vQueryLocal.FieldByName('IP').AsString;
        if not vQueryLocal.FieldByName('BALANCAS').IsNull then
          vQueryCloud.ParamByName('BALANCAS').AsString := vQueryLocal.FieldByName('BALANCAS').AsString;
        if not vQueryLocal.FieldByName('ATIV_DEPTOS').IsNull then
          vQueryCloud.ParamByName('ATIV_DEPTOS').AsString := vQueryLocal.FieldByName('ATIV_DEPTOS').AsString;
        if not vQueryLocal.FieldByName('ARMAZENS').IsNull then
          vQueryCloud.ParamByName('ARMAZENS').AsString := vQueryLocal.FieldByName('ARMAZENS').AsString;
        if not vQueryLocal.FieldByName('PROJETO_DEPTOS').IsNull then
          vQueryCloud.ParamByName('PROJETO_DEPTOS').AsString := vQueryLocal.FieldByName('PROJETO_DEPTOS').AsString;
        if not vQueryLocal.FieldByName('EXPIRACAO_DIAS').IsNull then
          vQueryCloud.ParamByName('EXPIRACAO_DIAS').AsString := vQueryLocal.FieldByName('EXPIRACAO_DIAS').AsString;
        if not vQueryLocal.FieldByName('TENTATIVAS_ACESSO').IsNull then
          vQueryCloud.ParamByName('TENTATIVAS_ACESSO').AsString := vQueryLocal.FieldByName('TENTATIVAS_ACESSO').AsString;
        if not vQueryLocal.FieldByName('CARGO_ID').IsNull then
          vQueryCloud.ParamByName('CARGO_ID').AsString := vQueryLocal.FieldByName('CARGO_ID').AsString;
        if not vQueryLocal.FieldByName('CARGO').IsNull then
          vQueryCloud.ParamByName('CARGO').AsString := vQueryLocal.FieldByName('CARGO').AsString;
        vQueryCloud.ParamByName('SYNC').AsString := 'S';
        vQueryCloud.ParamByName('SYNC_DATA').AsDateTime := vlData;

        vQueryCloud.ExecSQL;
        vQueryCloud.Transaction.CommitRetaining;

        vQueryUpdateLocal.Close;
        vQueryUpdateLocal.SQL.Clear;
        vQueryUpdateLocal.SQL.Add('UPDATE TBUSUARIO SET SYNC = ''S'', SYNC_DATA = :SYNC_DATA WHERE USUARIO_ID = :USUARIO_ID');

        vQueryUpdateLocal.ParamByName('SYNC_DATA').AsDateTime := vlData;
        vQueryUpdateLocal.ParamByName('USUARIO_ID').AsString := vQueryLocal.FieldByName('USUARIO_ID').AsString;

        vQueryUpdateLocal.ExecSQL;
        vQueryUpdateLocal.Transaction.CommitRetaining;

        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-TBUSUARIO atualizado Local->Cloud: ' +
                               vQueryLocal.FieldByName('USUARIO_ID').AsString + '-' + vQueryLocal.FieldByName('NOME').AsString);
          end);
      except on E: Exception do
        begin
          TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', vlData) + '-Erro ao atualizar TBUSUARIO Local->Cloud: ' + E.Message);
            end);

          vQueryCloud.Transaction.RollbackRetaining;
          vQueryUpdateLocal.Transaction.RollbackRetaining;

          dm1.IBDatabase1.Connected := False;
          dm1.IBDatabase1.Connected := True;

          dm1.IBDatabaseCloudSICFAR.Connected := False;
          dm1.IBDatabaseCloudSICFAR.Connected := True;
          Break;
        end;
      end;

      vQueryLocal.Next;
    end;
  finally
    vQueryLocal.Free;
    vQueryCloud.Free;
    vQueryUpdateLocal.Free;
  end;
end;

procedure TForm_PrincipalServer.pCarregaParametrosServidor;
var
  vlQuery : TIBQuery;
  Porta : Integer;
  IP : String;
  ArqIni : TIniFile;
begin
  vlQuery := TIBQuery.Create(Owner);

  Caminho := GetCurrentDir;
  Porta   := fRetornaPorta;

  with vlQuery do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;
      Close;
      SQL.Text := 'select conteudo';
      SQL.Add(' from tbparametros');
      SQL.Add(' where parametro = ''ATUALIZADOR_HOST'' ');
      Open;
    end;

  IP:= vlQuery.FieldByName('CONTEUDO').AsString;

//  ArqIni := TIniFile.Create(GetCurrentDir + '\BaseSIC.Ini');
//  Try
//    Caminho := ArqIni.ReadString  ('ATUALIZADOR', 'Caminho' , Caminho);
//    Porta   := ArqIni.ReadInteger ('ATUALIZADOR', 'Porta' , Porta);
//    IP      := ArqIni.ReadString  ('ATUALIZADOR', 'IP' , IP);
//  Finally
//    ArqIni.Free;
//  end;

  vlQuery.Free;
  Servidor.DefaultPort := Porta;
end;

procedure TForm_PrincipalServer.pDisparaEmailReuniao(prPeriodo : String);
var
  vlQuerySIC : TIBQuery;
  vlEmail : String;
begin
  with QR_EMAIL do
    begin
      Close;
      SQL.Text := 'select distinct';
      SQL.Add(' r.solicitante_email as email');
      SQL.Add(' from tbreuniao r');
      SQL.Add(' where r.deletado = ''N'' ');

      SQL.Add(' and (r.data = current_date');

      if prPeriodo = 'M' then
        SQL.Add(' and r.hora < ''12:00'' ')
      else
        SQL.Add(' and r.hora >= ''12:00'' ');

      SQL.Add(' or (r.data = current_date +1)) ');

      SQL.Add(' union');

      SQL.Add(' select');
      SQL.Add(' distinct c.email');
      SQL.Add(' from tbreuniao_contato c');
      SQL.Add(' inner join tbreuniao r on r.reuniao_id = c.reuniao_id and r.deletado = ''N'' ');
      SQL.Add(' where c.deletado = ''N'' ');

      SQL.Add(' and (r.data = current_date');

      if prPeriodo = 'M' then
        SQL.Add(' and r.hora < ''12:00'' ')
      else
        SQL.Add(' and r.hora >= ''12:00'' ');

      SQL.Add(' or (r.data = current_date +1)) ');

      //InputBox('','',sql.Text);

      Open;
    end;

  if not QR_EMAIL.IsEmpty then
    begin
      vlQuerySIC := TIBQuery.Create(Owner);
      with vlQuerySIC do
        begin
          Database    := dm1.IBDatabase1;
          Transaction := dm1.IBTransaction1;
        end;

      QR_EMAIL.First;
      while not QR_EMAIL.Eof do
        begin
          with QR_REUNIAO do
            begin
              Close;
              SQL.Text :=  'select';
              SQL.Add(' distinct');
              SQL.Add(' r.reuniao_id');
              SQL.Add(' from tbreuniao r');
              SQL.Add(' left join tbreuniao_contato c on c.reuniao_id = r.reuniao_id and c.deletado = ''N'' ');
              SQL.Add(' where r.deletado = ''N'' ');

              SQL.Add(' and (r.data = current_date');

              if prPeriodo = 'M' then
                SQL.Add(' and r.hora < ''12:00'' ')
              else
                SQL.Add(' and r.hora >= ''12:00'' ');

              SQL.Add(' or (r.data = current_date +1)) ');


              SQL.Add(' and (r.solicitante_email = ''' + QR_EMAIL.FieldByName('EMAIL').AsString + ''' or (c.email = ''' + QR_EMAIL.FieldByName('EMAIL').AsString + '''))');
              //inputbox('','',sql.Text);
              Open;
            end;

          if not QR_REUNIAO.IsEmpty then
            dm1.fEnviaEmailReuniaoDiaria('Lembrete de Reunião',QR_EMAIL.FieldByName('EMAIL').AsString,'',QR_REUNIAO);

          QR_EMAIL.Next;
        end;

      with vlQuerySIC do
        begin
          Close;
          SQL.Text := 'update tbparametros set';
          SQL.Add(' CONTEUDO = ''' + FormatDateTime('DD/MM/YYYY', Date) + ''' ');

          if prPeriodo = 'M' then
            SQL.Add(' where parametro = ''REUNIAO_EMAIL_MANHA'' ')
          else
            SQL.Add(' where parametro = ''REUNIAO_EMAIL_TARDE'' ');

          ExecSQL;
          Transaction.CommitRetaining;
        end;

      if prPeriodo = 'M' then
        Memo_Log.Text := Memo_Log.Text + #13 + 'Lembrete de Reunião (Manhã) enviado em: ' + FormatDateTime('DD/MM/YYYY HH:MM:SS', Now)
      else
        Memo_Log.Text := Memo_Log.Text + #13 + 'Lembrete de Reunião (Tarde) enviado em: ' + FormatDateTime('DD/MM/YYYY HH:MM:SS', Now);

      vlQuerySIC.Free;
    end;
end;

procedure TForm_PrincipalServer.pImportaLicitacao(prLicitacaoID: String);
var
  vlQuerySIC : TIBQuery;
begin
  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabaseCloudSICFAR;
      Transaction := dm1.IBTransactionCloudSICFAR;

      Close;
      SQL.Text := 'select licitacao_id from tblicitacao';
      SQL.Add(' where deletado = ''N'' ');
      SQL.Add(' and licitacao_id = ''' + prLicitacaoID + ''' ');
      Open;
    end;

   if vlQuerySIC.IsEmpty then
       pAtualizaLicitacaoLocalToCloud(dm1.IBDatabase1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransaction1, dm1.IBTransactionCloudSICFAR);

  vlQuerySIC.Free;
end;

procedure TForm_PrincipalServer.pImportaPessoa(prPessoaID: String);
var
  vlQuerySIC : TIBQuery;
begin
  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabaseCloudSICFAR;
      Transaction := dm1.IBTransactionCloudSICFAR;

      Close;
      SQL.Text := 'select pessoa_id from tbpessoas';
      SQL.Add(' where deletado = ''N'' ');
      SQL.Add(' and pessoa_id = ''' + prPessoaID + ''' ');
      Open;
    end;

   if vlQuerySIC.IsEmpty then
       pAtualizaPessoasLocalToCloud(dm1.IBDatabase1, dm1.IBTransaction1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransactionCloudSICFAR, prPessoaID);

  vlQuerySIC.Free;
end;

procedure TForm_PrincipalServer.pImportaProduto(prProdutoID: String);
var
  vlQuerySIC : TIBQuery;
begin
  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabaseCloudSICFAR;
      Transaction := dm1.IBTransactionCloudSICFAR;

      Close;
      SQL.Text := 'select produto_id from tbprodutos';
      SQL.Add(' where deletado = ''N'' ');
      SQL.Add(' and produto_id = ''' + prProdutoID + ''' ');
      Open;
    end;

   if vlQuerySIC.IsEmpty then
       pAtualizaProdutoLocalToCloud(dm1.IBDatabase1, dm1.IBTransaction1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransactionCloudSICFAR, prProdutoID);

  vlQuerySIC.Free;
end;

procedure TForm_PrincipalServer.pListaArquivos();
var
  SR, SRDir: TSearchRec;
  I, SI: integer;
  J: integer;
  dir : String;
  IDir : integer;
  vlteste : String;
  vlSistemas : TStringList;
  vlSistema : String;

  arquivo, arquivo_comp : TStringList;
  ai, aj : integer;
  nome1, nome2, data1, data2 : String;
  aux : integer;
begin
  vlSistemas:= TStringList.Create;
  vlSistemas.LoadFromFile(Caminho + '\SISTEMAS.txt');
  for SI:= 0 to vlSistemas.Count-1 do
    begin
      vlSistema := vlSistemas.Strings[SI];
      DeleteFile(vlSistema + '_arquivos.txt');
      Memo_Arquivos.Clear;
      TamanhoArquivos := 0;

      I := FindFirst(Caminho+'\Atualizador\' + vlSistema + '\'+'*.*', faAnyFile, SR);
      while I = 0 do
        begin
          if ((sr.Name <> '.') and (sr.Name <> '..')) then
            begin
              if sr.Name = vlSistema + '.exe' then
                Memo_Arquivos.Lines.Add(sr.Name+'='+GetBuildInfo(Caminho + '\Atualizador\' + vlSistema + '\'+sr.Name))
              else
                begin
                  if Copy(sr.Name, 1, Pos('.', sr.Name, 1)) = '' then
                    begin
                      dir := sr.Name + '\';
                      IDir := FindFirst(Caminho+'\Atualizador\' + vlSistema + '\'+dir+'*.*', faAnyFile, SRDir);
                      while IDir = 0 do
                        begin
                          if ((SRDir.Name <> '.') and (SRDir.Name <> '..')) then
                            begin
                              if SRDir.Name = vlSistema + '.exe' then
                                Memo_Arquivos.Lines.Add(dir+SRDir.Name+'='+GetBuildInfo(Caminho+'\Atualizador\' + vlSistema + '\'+dir+SRDir.Name))
                              else
                                Memo_Arquivos.Lines.Add(dir+SRDir.Name+'='+DateTimeToStr(FileDateToDateTime(FileAge(Caminho+'\Atualizador\' + vlSistema + '\'+dir+SRDir.Name))));
                              TamanhoArquivos := TamanhoArquivos + SRDir.Size;
                            end;

                          IDir := FindNext(SRDir);
                        end;
                    end
                  else
                    Memo_Arquivos.Lines.Add(sr.Name+'='+DateTimeToStr(FileDateToDateTime(FileAge(Caminho+'\Atualizador\' + vlSistema + '\'+sr.Name))));
                end;

              TamanhoArquivos := TamanhoArquivos + sr.Size;
            end;

          I := FindNext(SR);
        end;

      Memo_Arquivos.Lines.SaveToFile(GetCurrentDir + '\' + vlSistema + '_arquivos.txt');

      arquivo := TStringList.Create;
      arquivo_comp := TStringList.Create;

      arquivo.LoadFromFile(GetCurrentDir+'\' + vlSistema + '_arquivos.txt');
      arquivo_comp.LoadFromFile(GetCurrentDir+'\' + vlSistema + '_arquivos_comp.txt');

      aux := 0;

      for ai := 0 to arquivo.Count -1 do
        begin
          data1 := Copy(arquivo[ai], pos('=', arquivo[ai])+1, length(arquivo[ai]) );
          nome1 := Copy(arquivo[ai], 1, pos('=', arquivo[ai])-1);
          for j := 0 to arquivo_comp.Count -1 do
            begin
              data2 := Copy(arquivo_comp[aj], pos('=', arquivo_comp[aj])+1, length(arquivo_comp[aj]) );
              nome2 := Copy(arquivo_comp[aj], 1, pos('=', arquivo_comp[aj])-1);

              if nome1 = nome2 then
                begin
                  aux := 1;
                  if data1 <> data2 then
                    begin
                      Memo_Log.Lines.Add('--------------------------------------------------------------------------------------------------------');
                      Memo_Log.Lines.Add(nome1 + ' foi alterado em ' + FormatDateTime('DD/MM/YYYY HH:MM:SS', Now));
                    end;
                end;
            end;

          if aux = 0 then
            begin
              Memo_Log.Lines.Add('--------------------------------------------------------------------------------------------------------');
              Memo_Log.Lines.Add(nome1 + ' foi inserido em ' + FormatDateTime('DD/MM/YYYY HH:MM:SS', Now));
            end;

          aux := 0;
        end;

      for i := 0 to arquivo_comp.Count -1 do
        begin
          nome1 := Copy(arquivo_comp[i], 1, pos('=', arquivo_comp[i])-1);
          for j := 0 to arquivo.Count -1 do
            begin
              nome2 := Copy(arquivo[j], 1, pos('=', arquivo[j])-1);
              if nome1 = nome2 then
                aux := 1;
            end;
          if aux = 0 then
            begin
              Memo_Log.Lines.Add('--------------------------------------------------------------------------------------------------------');
              Memo_Log.Lines.Add(nome1 + ' foi removido em ' + FormatDateTime('DD/MM/YYYY HH:MM:SS', Now))
            end
          else
            aux:=0;
        end;

      if not FileExists(GetCurrentDir+'\' + vlSistema + '_arquivos_comp.txt') then
        DeleteFile(GetCurrentDir+'\' + vlSistema + '_arquivos_comp.txt');

      Memo_Arquivos.Lines.SaveToFile(GetCurrentDir+'\' + vlSistema + '_arquivos_comp.txt');

    end;

  vlSistemas.Free;
end;

procedure TForm_PrincipalServer.ServerSocketClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
   ShellExecute(0,Nil,PChar(GetCurrentDir+'\SICServidorAtualizador.exe'),'', Nil, SW_SHOWNORMAL);
   Application.Terminate;

{  if ((ErrorCode = 10053) or (ErrorCode = 10054)) then
    begin
      Memo_Log.Lines.Add('IP: ' + Socket.RemoteAddress +
                         ' | Computador: ' + Socket.RemoteHost +
                         ' | Erro: ' + IntToStr(ErrorCode));
      ErrorCode := 0;
      ServerSocket.Active := False;
      ServerSocket.Active := True;
    end;}
end;

procedure TForm_PrincipalServer.ServidorConnect(AContext: TIdContext);
var
  Computador : String;
begin
  try
    Computador := AContext.Connection.IOHandler.ReadLn;
    Memo_Log.Lines.Add('--------------------------------------------------------------------------------------------------------');
    Memo_Log.Lines.Add('Usuário: ' + Computador
      + ' || IP: ' + AContext.Connection.Socket.Binding.PeerIP
      + ' || Conectado em ' + FormatDateTime('DD/MM/YYYY HH:MM:SS', Now));
    AContext.Connection.IOHandler.WriteLn(IntToStr(TamanhoArquivos));
  except on E: Exception do
    begin
      logErros(DateTimeToStr(now) + ' - ' + 'Erro ao Conectar ao Servidor de Atualização: ' + E.Message);
      Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', Now) + ' - Erro ao Conectar ao Servidor de Atualização: ' + e.Message);
    end;
  end;
end;

procedure TForm_PrincipalServer.ServidorExecute(AContext: TIdContext);
var
  Comando, ComandoAux, Parametro, Linha, IP, Computador, Sistema: string;
  Stream: TMemoryStream;
  i : integer;
  s : string;
begin
  try
    Timer_Reuniao.Enabled := False;
    Timer_Tabelas.Enabled := False;
    //Procesando os comandos
    Linha:= AContext.Connection.IOHandler.ReadLn; //Lê a linha enviada.
    IP:= AContext.Connection.socket.Binding.PeerIP;

    Sistema    := copy(Linha,1, pos('.',Linha)-1);
    ComandoAux := copy(Linha,pos('_',Linha) +1, Pos('#',Linha)-1);
    Comando    := copy(ComandoAux,1, Pos('#',ComandoAux)-1);
    Parametro  := copy(Linha, Pos('#',Linha)+1,  length(Linha));

    if Comando = 'arquivos' then
      begin
        //Envia para o cliente, o aquivo de versões
        try
          try
            Memo_Log.Lines.Add({IP + ' :: }'Requisição de atualização de arquivos em '
              + FormatDateTime('DD/MM/YYYY HH:MM:SS', Now));
            Memo_Log.Lines.Add(#13);
            Stream:= TMemoryStream.Create;
            //Memo2.Lines.SaveToStream(Stream);
            Stream.LoadFromFile(GetCurrentDir + '\'+ Sistema + '_arquivos.txt');
            AContext.Connection.IOHandler.WriteLn(inttostr(Stream.Size)); //Envia o tamanho do arquivo
            Acontext.Connection.IOHandler.Write(Stream);
          finally
            Stream.Free;
          end;

        except on E: Exception do
          begin
            logErros(DateTimeToStr(now) + ' - ' + 'Erro ao Enviar Arquivos de Versões: ' + E.Message);
            Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', Now) + ' - Erro ao Enviar Arquivos de Versões: ' + e.Message);
          end;
        end;
      end
    else
      if Comando = 'get' then
        begin
          //Envia para o cliente, o aquivo que ele pediu.
          try
            try
              Memo_Log.Lines.Add({IP + ' :: }'Requisição do arquivo "' + Parametro + '" em '
                + FormatDateTime('DD/MM/YYYY HH:MM:SS', Now));
              Stream:= TMemoryStream.Create;
              Stream.LoadFromFile(Caminho + '\Atualizador\' + Sistema + '\' +  Parametro);
              AContext.Connection.IOHandler.WriteLn(inttostr(Stream.Size)); //Envia o tamanho do arquivo
              Acontext.Connection.IOHandler.Write(Stream);
            finally
              Stream.Free;
            end;

          except on E: Exception do
            begin
              logErros(DateTimeToStr(now) + ' - ' + 'Erro ao Enviar Arquivo ao Cliente: ' + E.Message);
              Memo_Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', Now) + ' - Erro ao Enviar Arquivo ao Cliente: ' + e.Message);
            end;
          end;
        end;
  finally
    Timer_Reuniao.Enabled := True;
    Timer_Tabelas.Enabled := True;
  end;
end;

procedure TForm_PrincipalServer.Timer1Timer(Sender: TObject);
var
  arquivo, arquivo_comp : TStringList;
  i, j : integer;
  nome1, nome2, data1, data2 : String;
  aux : integer;
begin
  if Memo_Log.Lines.Text <> '' then
    begin
      if vlData <> Date then
        begin
          Memo_Log.Lines.SaveToFile(GetCurrentDir+'\Log\Log Atualização - '+ FormatDateTime('DD-MM-YYYY',vlData)+'.txt');
          vlData := Date;
          Memo_Log.Clear;
        end;
    end;

  pListaArquivos;
end;

procedure TForm_PrincipalServer.Timer_TabelasTimer(Sender: TObject);
begin
  Timer_Tabelas.Enabled := False;

  if vPararServidor = False then
    begin
      TThread.CreateAnonymousThread(
        procedure
        begin
          if LTOTVS then
            begin
              // TBProdutos TOTVS->Local
              pAtualizaProduto;

              // TBPessoas TOTVS->Local
              pAtualizaFornecedor;

              // TBCONDPAGTO TOTVS->Local
              pAtualizaCondPagto;

              // SA1 TOTVS Local->Cloud
//              pAtualizaClienteAmazon;

    //        pAtualizaSC;

    //        pAtualizaDepto;
            end;

//          pAtualizaSCCloudToLocal(dm1.IBDatabase1, dm1.IBTransaction1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransactionCloudSICFAR);
//          pAtualizaSCLocalToCloud(dm1.IBDatabase1, dm1.IBTransaction1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransactionCloudSICFAR);
//
//          pAtualizaItemScCloudToLocal(dm1.IBDatabase1, dm1.IBTransaction1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransactionCloudSICFAR);
//          pAtualizaItemScLocalToCloud(dm1.IBDatabase1, dm1.IBTransaction1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransactionCloudSICFAR);
//
//          pAtualizaPedidoCloudToLocal(dm1.IBDatabase1, dm1.IBTransaction1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransactionCloudSICFAR);
//          pAtualizaPedidoLocalToCloud(dm1.IBDatabase1, dm1.IBTransaction1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransactionCloudSICFAR);
//
//          pAtualizaPedidoItemCloudToLocal(dm1.IBDatabase1, dm1.IBTransaction1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransactionCloudSICFAR);
//          pAtualizaPedidoItemLocalToCloud(dm1.IBDatabase1, dm1.IBTransaction1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransactionCloudSICFAR);
//
//          pAtualizaUsuarioCloudToLocal(dm1.IBDatabase1, dm1.IBTransaction1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransactionCloudSICFAR);
//          pAtualizaUsuarioLocalToCloud(dm1.IBDatabase1, dm1.IBTransaction1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransactionCloudSICFAR);
//
//          pAtualizaDepartamentoCloudToLocal(dm1.IBDatabase1, dm1.IBTransaction1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransactionCloudSICFAR);
//          pAtualizaDepartamentoLocalToCloud(dm1.IBDatabase1, dm1.IBTransaction1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransactionCloudSICFAR);
//
//          pAtualizaProdutoCloudToLocal(dm1.IBDatabase1, dm1.IBTransaction1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransactionCloudSICFAR);
//          pAtualizaProdutoLocalToCloud(dm1.IBDatabase1, dm1.IBTransaction1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransactionCloudSICFAR, '');
//
//          pAtualizaPessoasLocalToCloud(dm1.IBDatabase1, dm1.IBTransaction1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransactionCloudSICFAR, '');
//          pAtualizaPessoasCloudToLocal(dm1.IBDatabase1, dm1.IBTransaction1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransactionCloudSICFAR);
//
//          pAtualizaCCCloudToLocal(dm1.IBDatabase1, dm1.IBTransaction1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransactionCloudSICFAR);
//          pAtualizaCCLocalToCloud(dm1.IBDatabase1, dm1.IBTransaction1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransactionCloudSICFAR);

          // Banco de Dados SICFAR Nuvem - APFAR One Way Sync
          // TBLICITACAO
//          pAtualizaLicitacaoLocalToCloud(dm1.IBDatabase1, dm1.IBDatabaseCloudSICFAR, dm1.IBTransaction1, dm1.IBTransactionCloudSICFAR);

          // Reativar o timer após a execução
          TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              Timer_Tabelas.Enabled := True;
            end);
        end).Start;
    end
  else
    Timer_Tabelas.Enabled := True;
end;

procedure TForm_PrincipalServer.Timer_ReuniaoTimer(Sender: TObject);
begin
  Timer_Reuniao.Enabled := False;

  if ((Time > StrToTime('06:00:00')) and (Time < StrToTime('12:00:00')))  then
    begin
      try
        with vQueryReuniao do
          begin
            Close;
            SQL.Text := 'select conteudo from tbparametros';
            SQL.Add(' where parametro = ''REUNIAO_EMAIL_MANHA'' ');
            Open;
          end;

        if StrToDate(vQueryReuniao.FieldByName('CONTEUDO').AsString) <> Date then
          pDisparaEmailReuniao('M');

      except on e : exception do
        begin
          Memo_Log.Text := Memo_Log.Text + #13 + 'Erro ao enviar lembrete da manhã: ' + e.Message;
          logErros(DateTimeToStr(now) + ' - ' + 'Erro ao enviar lembrete da manhã: ' + E.Message);
          Timer_Reuniao.Enabled := False;
          Timer_Reuniao.Enabled := True;
        end;
      end;
    end;

  if ((Time >= StrToTime('12:00:00')) and (Time < StrToTime('17:00:00')))  then
    begin
      try
        with vQueryReuniao do
          begin
            Close;
            SQL.Text := 'select conteudo from tbparametros';
            SQL.Add(' where parametro = ''REUNIAO_EMAIL_TARDE'' ');
            Open;
          end;

        if StrToDate(vQueryReuniao.FieldByName('CONTEUDO').AsString) <> Date then
          pDisparaEmailReuniao('T');
      except on e : exception do
        begin
          Memo_Log.Text := Memo_Log.Text + #13 + 'Erro ao enviar lembrete da tarde: ' + e.Message;
          logErros(DateTimeToStr(now) + ' - ' + 'Erro ao enviar lembrete da tarde: ' + E.Message);
          Timer_Reuniao.Enabled := False;
          Timer_Reuniao.Enabled := True;
        end;
      end;
    end;

  Timer_Reuniao.Enabled := True;
end;

end.
