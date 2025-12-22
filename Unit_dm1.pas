unit Unit_dm1;

interface

uses
  System.SysUtils, System.Classes, Data.DB, IBX.IBCustomDataSet, IBX.IBDatabase,
  IBX.IBQuery, IniFiles, IdSSL, IdSSLOpenSSL, IdMessage, IdText, idSmtp,
  IdExplicitTLSClientServerBase, IdAttachmentFile, Data.Win.ADODB, comobj,
  Datasnap.DBClient, Vcl.Dialogs;

type
  Tdm1 = class(TDataModule)
    IBTransaction1: TIBTransaction;
    IBDatabase1: TIBDatabase;
    DataSource1: TDataSource;
    DataSourceDepartamentos: TDataSource;
    QueryStatus: TIBQuery;
    DataSourceStatus: TDataSource;
    QueryTipo: TIBQuery;
    DataSourceTipo: TDataSource;
    QuerySuporte: TIBQuery;
    DataSourceSuporte: TDataSource;
    QueryGrupo: TIBQuery;
    DataSourceGrupo: TDataSource;
    QueryDepartamentos: TIBQuery;
    QueryDetalhesChamado: TIBQuery;
    DS_DetalhesChamado: TIBDataSet;
    DS_DetalhesChamadoID_CHAMADO: TIntegerField;
    DS_DetalhesChamadoANOTACAO: TWideMemoField;
    DS_DetalhesChamadoID: TIntegerField;
    dtsChamados: TDataSource;
    QueryChamados: TIBQuery;
    DS_Interacao: TIBDataSet;
    DS_InteracaoID_CHAMADO: TIntegerField;
    DS_InteracaoINTERACAO: TDateTimeField;
    QR_TEMP: TIBQuery;
    Perfil: TIBQuery;
    QR_AMOSTRA: TIBQuery;
    QR_BUSCA: TIBQuery;
    cdsCampos: TClientDataSet;
    cdsCamposCAMPO: TStringField;
    cdsCamposDE: TStringField;
    cdsCamposPARA: TStringField;
    cdsCamposDESCRICAO: TStringField;
    DS_CHAMADO: TIBDataSet;
    DS_CHAMADOCHAMADO_ID: TIntegerField;
    DS_CHAMADODATA: TDateField;
    DS_CHAMADOSOLICITANTE_ID: TIntegerField;
    DS_CHAMADOSOLICITANTE: TIBStringField;
    DS_CHAMADOASSUNTO: TIBStringField;
    DS_CHAMADODEPARTAMENTO_ID: TIntegerField;
    DS_CHAMADODEPARTAMENTO: TIBStringField;
    DS_CHAMADOTIPO_ID: TIntegerField;
    DS_CHAMADOTIPO: TIBStringField;
    DS_CHAMADOSTATUS: TIBStringField;
    DS_CHAMADOPRIORIDADE: TIBStringField;
    DS_CHAMADOGRUPO_ID: TIntegerField;
    DS_CHAMADOGRUPO: TIBStringField;
    DS_CHAMADOANALISTA_ID: TIntegerField;
    DS_CHAMADOANALISTA: TIBStringField;
    DS_CHAMADOSUPORTE: TIBStringField;
    DS_CHAMADOSUPORTE_ID: TIntegerField;
    DS_CHAMADODESCRICAO: TWideMemoField;
    DS_CHAMADOUSUARIO_I: TIntegerField;
    DS_CHAMADOUSUARIONOME_I: TIBStringField;
    DS_CHAMADODATA_INC: TDateTimeField;
    DS_CHAMADOUSUARIO_A: TIntegerField;
    DS_CHAMADOUSUARIONOME_A: TIBStringField;
    DS_CHAMADODATA_ALT: TDateTimeField;
    DS_CHAMADOUSUARIO_D: TIntegerField;
    DS_CHAMADOUSUARIONOME_D: TIBStringField;
    DS_CHAMADODATA_DEL: TDateTimeField;
    DS_CHAMADOEMPRESA_ID: TIntegerField;
    DS_CHAMADODELETADO: TIBStringField;
    DS_CHAMADODE: TIBStringField;
    DS_CHAMADOPARA: TIBStringField;
    DS_CHAMADOLOTE: TIBStringField;
    DS_CHAMADOPRODUTO_ID: TIntegerField;
    DS_CHAMADOERP_PRODUTO: TIBStringField;
    DS_CHAMADOPRODUTO: TIBStringField;
    DS_CHAMADOMOTORISTA_ID: TIntegerField;
    DS_CHAMADOMOTORISTA: TIBStringField;
    DS_CHAMADOSUPORTE_EMAIL: TIBStringField;
    DS_CHAMADOPESSOA_ID: TIntegerField;
    DS_CHAMADOERP_CLIENTE: TIBStringField;
    DS_CHAMADOCLIENTE: TIBStringField;
    DS_CHAMADOCLI_ENDERECO: TIBStringField;
    DS_CHAMADOCLI_BAIRRO: TIBStringField;
    DS_CHAMADOCLI_CIDADE: TIBStringField;
    DS_CHAMADOCLI_CEP: TIBStringField;
    DS_CHAMADOCLI_UF: TIBStringField;
    DS_CHAMADOCLI_COMPLEMENTO: TIBStringField;
    DS_CHAMADOCLI_TELEFONE: TIBStringField;
    DS_CHAMADOCLI_TIPO: TIBStringField;
    DS_CHAMADOCLI_CPFCNPJ: TIBStringField;
    DS_CHAMADOCLI_IE: TIBStringField;
    DS_CHAMADOVENCIMENTO: TDateField;
    DS_CHAMADOPROTOCOLO: TIBStringField;
    DS_CHAMADOFECHAMENTO_DATA: TDateField;
    DS_CHAMADOFECHAMENTO_HORA: TTimeField;
    DS_CHAMADONUMERO: TIBStringField;
    DS_CHAMADORETORNO_DATA: TDateField;
    DS_CHAMADORETORNO_HORA: TTimeField;
    DS_CHAMADOREGISTRO: TIBStringField;
    DS_CHAMADOFECHAMENTO_USUARIO: TIBStringField;
    DS_CHAMADOPROJETO_ID: TIntegerField;
    DS_CHAMADOPROJETOITEM_ID: TIntegerField;
    DS_CHAMADOPROJETO: TIBStringField;
    DS_CHAMADOCUSTO: TIBBCDField;
    DS_CHAMADODEMANDA_ID: TIntegerField;
    DS_CHAMADODEMANDA: TIBStringField;
    DS_CHAMADOINICIO_HORA: TTimeField;
    DS_CHAMADOINICIO_DATA: TDateField;
    DS_CHAMADOFECHAMENTO_STATUS: TIBStringField;
    DS_CHAMADOCLIENTE_DEPARTAMENTO_ID: TIntegerField;
    DS_CHAMADOCLIENTE_DEPARTAMENTO: TIBStringField;
    DS_CHAMADOEQUIPAMENTO_ID: TIntegerField;
    DS_CHAMADOEQUIPAMENTO: TIBStringField;
    DS_CHAMADOEQUIPAMENTO_TAG: TIBStringField;
    DS_CHAMADOCAPA_ID: TIntegerField;
    DS_CHAMADOCAPAITEM_ID: TIntegerField;
    DS_CHAMADOOBRIGA_ANEXO: TIBStringField;
    DS_CHAMADOEQUIPE_ID: TIntegerField;
    DS_CHAMADOEQUIPE: TIBStringField;
    DS_CHAMADODESCRICAO_LIMPO: TWideMemoField;
    DS_CHAMADOCM_ID: TIntegerField;
    DS_CHAMADOCMACAO_ID: TIntegerField;
    DS_CHAMADODATAWARE: TIBStringField;
    IBDatabase3: TIBDatabase;
    IBTransaction3: TIBTransaction;
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
    DS_ACESSOVERSAO: TIBStringField;
    DS_ACESSOCONEXAO: TLargeintField;
    IBDatabaseCloudSICFAR: TIBDatabase;
    IBTransactionCloudSICFAR: TIBTransaction;
    procedure DataModuleCreate(Sender: TObject);
    procedure IBDatabase1AfterConnect(Sender: TObject);
  private
    procedure Get_Build_Info(var v1, v2, v3, v4 : Word);
  public
    { Public declarations }
    function Get_Versao : String;
    function fPerfilRotina(prUsuarioID, prRotina: string): Boolean;
    function fEnviaEmailRNC(const AAssunto, ADestino, AAnexo, prRNCID : String; prCDSCampos : TClientDataSet): Boolean;

    function fEnviaEmailRetem(const AAssunto, ADestino, AAnexo, prSQL : String): Boolean;
    function fRetornaEtiquetaAmostraImpressa(prAmostraID : String) : Boolean;
    function fRetornaStatusCAPA(prCAPAID : String) : String;

    //Envia E-mail CAPA
    function fEnviaEmailCAPA(const AAssunto, ADestino, prCAPAID : String) : Boolean;
    function fEnviaEmailAcaoAtrasada(const AAssunto, ADestino, prAcaoID : String): Boolean;

    //E-mail Estabilidade
    function fEnviaEmailPDIFinalidade(const AAssunto, ADestino, prStatus, prFinalidadeID : String): Boolean;
    function fEnviaEmailPDIEstudo(const AAssunto, ADestino, prStatus, prEstudoID : String): Boolean;
    function fEnviaEmailPDIAmostra(const AAssunto, ADestino, prStatus, prAmostraID : String): Boolean;

    //Usu�rio
    function fRetornaUsuario(prUsuarioID : String) : String;
    function fRetornaUsuarioEmail(prUsuarioID : String) : String;
    function fRetornaUsuarioDepto(prUsuarioID : String) : String;

    //Solicitante
    function fRetornaSolicitante(prSolicitanteID : String) : String;
    function fRetornaSolicitanteEmail(prSolicitanteID : String) : String;

    //Departamento
    function fRetornaDepartamento(prDepartamentoID : String) : String;

    //Grupo Atividade
    function fRetornaGrupoAtividade(prGrupoID : String) : String;

    //Tipo de Atividade
    function fRetornaTipoAtividade(prTipoID, prGrupoID : String) : String;

    //Equipe
    function fRetornaEquipe(prEquipeID : String) : String;

    function fRetornaMaxPedido(prUsuarioID : String) : Integer;
    function fRetornaCampoUsuario(prUsuarioID, prCampo: string) : String;

    //Envia E-mail Reuni�o
    function fEnviaEmailReuniao(const AAssunto, ADestino, prReuniaoID : String) : Boolean;

    //Atualiza��o da situa��o do Equipamento
    procedure pAtualizaStatusEquipamentos;
    procedure pAtualizaStatusEquipamentoIndividual(prEquipamentoID : String);

    procedure pAtualizaStatusRealizadoTreinamento(prTreinamentoID : String);
    procedure pAtualizaStatusFrequenciaTreinamento(prTreinamentoID : String);

    function fEnviarEmailValidadeLote(const AAssunto, ADestino, AAnexo, prParametros: String; prQuery : TADOQuery): Boolean;

    procedure pCapaIntegraAtividade(prTipo, prCapaID, prCapaItemId : String);

    procedure pGeraAtividadeProgramada;

    function fRetornaCampoTabela(prCampo, prTabela, prCampoWhere, prValorWhere : String) : String;

    procedure pInsereAtividadeCMAcao(prCMID, prCMAcaoID : String);

    function fEnviaEmailReuniaoDiaria(const AAssunto, ADestino, AAnexo : String; prQuery : TIBQuery): Boolean;
  end;

var
  dm1: Tdm1;
  // Dados do Usuario Logado
  UsuarioID, Usuario, UsuarioDeptoID, UsuarioDepto, UsuarioLabID, UsuarioEmail, UsuarioErpVendedor, UsuarioErpRepresentante : string;
  UsuarioAnalistaID, UsuarioAtivDeptos, UsuarioArmazens : String;
  UsuarioProjetoDeptos : String;

  vModalidadeLicitacao : String;

  vTipoProduto, vGrupoProduto, vLocalProduto, vLocalProdutoN : String;

  TipoPessoa : String;

  vTipoImovel : String;

  //Chamdaos
  vChamadoID, vChamadoGrupoID : String;

  ChaveTabela : String;

  EntradaSaida : String;

  vRNCTipo : String;

  vAmostraID, vAmostraVolumeI, vAmostraVolumeF : String;

  vEmailDe, vEmailAssunto, vEmailPara : String;

  vProdutoERP, vLocalERP, vLote : String;
  AcessoID: String;
  vRNCOrigemID : String;
  vRNCEmailPara : String;
  vRNCID, vCodigoCausa : String;

  vBalancas : String;

  // IDs dos Lan�amentos Atuais
  vMercadoriaID, vDocumentoID, vAtendimentoID, vVendaRapidaID, vPessoaID, vRadioID,
  vVendaImovelID, EmpresaID, Empresa, vUFEmpresa, vVendedorID, vCentroCustoID,
  vCondPagtoID, vBancoID, vBancoChequeID, vAgenteID, vTitularID, vContaID, vPedidoID,
  vPerfilID, vRotina, vProdutoID, vCargaID : String;

  vDocumento : String;

  vDocConsulta, vDocConsultaParametro, vDocCaption, vDocVisualizacao : String;
  vArquivo, vDocumentoVersao, vDocumentoExtensao : String;

  vRegEtqAmostragem : String;

  vTipoEtiquetaIQA : String;

  vEmailRecebimentoAmostra : String;

  RotinaMaster, UsuarioMasterID, UsuarioMaster, UsuarioMasterEmail,UsuarioMasterDeptoID, UsuarioMasterDepto : String;


  vAnaliseID, vAnaliseItemID, vEspecificacaoID, vEspecificacaoItemID, vEnsaioID : String;

  vRNCDocCausaEfeitoCaption : String;

  vProjetoID, vProjeto, vTreinamentoID : String;

  //E-mail respons�vel estabilidade
  vEmailEstabilidade : String;


  vSolicitacaoComprasID, vSolicitacaoComprasDeptoID : String;

  vCotacaoID : String;

  vRiscoProcessoID : String;
  //ID do Controle de Mudan�a
  vCM, vCMAcao : String;

  vERUID, vERUItemID : String;

  vPesagemID : String;

  vAuditoriaTabela, vAuditoriaCampo, vAuditoriaCampoValor : String;
implementation

uses
  Winapi.Windows, Vcl.DBCtrls, Vcl.Forms, Biblioteca, Unit_ConfigFirebirdIBX,
  Unit_Server;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure Tdm1.DataModuleCreate(Sender: TObject);
var
  caminho,
  caminho2,
  usuario,
  usuario2,
  senha,
  senha2,
  Auto,
  character, Maquina : string;
  dialeto   : Integer;
  ArqIni : tIniFile;
  CaminhoPedido,
  UsuarioPedido,
  SenhaPedido,
  AutoPedido,
  CharacterPedido : string;
  DialetoPedido : Integer;
  AuditTrail: string;
  qUser : TIBQuery;
begin
  ArqIni := TIniFile.Create(GetCurrentDir + '\BaseSIC.ini');
  try
    // SICFAR LOCAL
    Caminho    := ArqIni.ReadString  ('SICFAR_LOCAL', 'Caminho' ,    Caminho);
    Dialeto    := ArqIni.ReadInteger ('SICFAR_LOCAL', 'Dialeto' ,    Dialeto);
    Usuario    := ArqIni.ReadString  ('SICFAR_LOCAL', 'Usuario' ,    Usuario);
    Senha      := ArqIni.ReadString  ('SICFAR_LOCAL', 'Senha'   ,    Senha);
    Character  := ArqIni.ReadString  ('SICFAR_LOCAL', 'ChrSet'  ,    Character);
    AuditTrail := ArqIni.ReadString  ('SICFAR_LOCAL', 'AuditTrail' , AuditTrail);

    with IBDatabase1 do
      begin
        Connected    := False;
        DatabaseName := Caminho;

        Params.Clear;
        Params.Add('user_name=' + Usuario);

        // Tentar descriptografar a senha - se falhar, senha não está criptografada
        try
          Params.Add('password=' + Biblioteca.MyCrypt('D', Senha));
        except
          on E: EConvertError do
          begin
            MessageDlg('A senha de conexão precisa ser reconfigurada.' + sLineBreak +
                       'O formulário de configuração será aberto.', mtWarning, [mbOK], 0);

            // Desativar o servidor antes de abrir o formulário de configuração
            if Assigned(Form_PrincipalServer) then
              Form_PrincipalServer.btn_DesativarClick(nil);

            // Criar e exibir formulário de configuração
            Application.CreateForm(TForm_ConfigFirebirdIBX, Form_ConfigFirebirdIBX);
            try
              Form_ConfigFirebirdIBX.ShowModal;

              // Após fechar o form, aplicar as novas configurações
              Form_ConfigFirebirdIBX.AplicarConfiguracoesAoIBDatabase(IBDatabase1);
            finally
              FreeAndNil(Form_ConfigFirebirdIBX);
            end;
            Exit; // Sair do procedimento pois as configurações já foram aplicadas
          end;
        end;

        Params.Add('lc_ctype=' + Character);
        SQLDialect := Dialeto;

        try
          IBDatabase1.Connected := True;
          IBTransaction1.Active := True;

          if Trim(AuditTrail) = 'S' then
            begin
              qUser := TIBQuery.Create(self);
              try
                with qUser do
                  begin
                    Database    := dm1.IBDatabase1;
                    Transaction := dm1.IBTransaction1;

                    Close;
                    SQL.Text := 'SELECT RDB$SET_CONTEXT(''USER_SESSION'',''USUARIOLOGADO'',''Servidor'')';
                    SQL.Add(' FROM RDB$DATABASE');
                    Open;
                  end;
              finally
                qUser.Free;
              end;
            end;
          
        except on ex : exception do
          begin
            MessageDlg('Problemas ao Conectar a Base de Dados ['  + Caminho + ']. Erro: ' + ex.Message, mtWarning, [mbOK], 0);
            Close;
          end;
        end;
      end;

    // PEDIDOS ONLINE
    Caminho    := ArqIni.ReadString  ('PEDIDOSONLINE', 'Caminho' ,    Caminho);
    Dialeto    := ArqIni.ReadInteger ('PEDIDOSONLINE', 'Dialeto' ,    Dialeto);
    Usuario    := ArqIni.ReadString  ('PEDIDOSONLINE', 'Usuario' ,    Usuario);
    Senha      := ArqIni.ReadString  ('PEDIDOSONLINE', 'Senha'   ,    Senha);
    Character  := ArqIni.ReadString  ('PEDIDOSONLINE', 'ChrSet'  ,    Character);
    AuditTrail := ArqIni.ReadString  ('PEDIDOSONLINE', 'AuditTrail' , AuditTrail);

    with IBDatabase3 do
      begin
        Connected    := False;
        DatabaseName := Caminho;

        Params.Clear;
        Params.Add('user_name=' + Usuario);
        Params.Add('password='  + senha); //Biblioteca.MyCrypt('D', senha));
        Params.Add('lc_ctype='  + Character);
        SQLDialect := Dialeto;

        try
          IBDatabase3.Connected := True;
          IBTransaction3.Active := True;
        except on ex : exception do
          begin
            MessageDlg('Problemas ao Conectar a Base de Dados ['  + Caminho + ']. Erro: ' + ex.Message, mtWarning, [mbOK], 0);
            Close;
          end;
        end;
      end;
  finally
    ArqIni.Free;
  end;
end;

function Tdm1.fEnviaEmailAcaoAtrasada(const AAssunto, ADestino,
  prAcaoID: String): Boolean;
var
  sHost                : String;
  iPort                : Integer;
  vEmail               : String;
  vSenhaEmail          : String;

  idMsg                : TIdMessage;
  IdText               : TIdText;
  idSMTP               : TIdSMTP;
  IdSSLIOHandlerSocket : TIdSSLIOHandlerSocketOpenSSL;

  vlQuerySIC           : TIBQuery;
begin
  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;

      Close;
      SQL.Text := 'select parametro, conteudo from tbparametros where parametro = ''EMAIL_ORCAMENTO_DE'' ';
      Open;
      vEmail := vlQuerySIC.FieldByName('CONTEUDO').AsString;

      Close;
      SQL.Text := 'select parametro, conteudo from tbparametros where parametro = ''EMAIL_ORCAMENTO_DE_S'' ';
      Open;
      vSenhaEmail := vlQuerySIC.FieldByName('CONTEUDO').AsString;
    end;

    sHost          :='smtp.farmace.com.br';
    iPort          :=465;

  try
    try
      with vlQuerySIC do
        begin
          Close;
          SQL.Text := 'select';
          SQL.Add(' c.numero, c.status, c.responsavel,');
          SQL.Add(' i.acao_tipo, i.acao, i.responsavel, i.prazo, i.departamento,');
          SQL.Add(' i.motivo, i.metodologia');
          SQL.Add(' from tbrnc_capa c');
          SQL.Add(' inner join tbrnc_capa_item i');
          SQL.Add(' on i.rnccapa_id = c.rnccapa_id and i.deletado = ''N'' ');
          SQL.Add(' where c.deletado = ''N'' ');
          SQL.Add(' and i.rnccapaitem_id = ''' + prAcaoID + ''' ');
          Open;
        end;

      //Configura os par�metros necess�rios para SSL
      IdSSLIOHandlerSocket                   := TIdSSLIOHandlerSocketOpenSSL.Create(Self);
      IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
      IdSSLIOHandlerSocket.SSLOptions.Mode  := sslmClient;

      //Vari�vel referente a mensagem
      idMsg                            := TIdMessage.Create(Self);
      idMsg.CharSet                    := 'utf-8';
      idMsg.Encoding                   := meMIME;
      idMsg.From.Name                  := 'CAPA';
      idMsg.From.Address               := vEmail;
      idMsg.Priority                   := mpNormal;
      idMsg.Subject                    := AAssunto;

      //Add Destinat�rio(s)
      idMsg.Recipients.Add;
      idMsg.Recipients.EMailAddresses := ADestino;

      //Vari�vel do texto
      IdText := TIdText.Create(idMsg.MessageParts);
      IdText.Body.Add('<html>');

      IdText.Body.Add('<head>');
      IdText.Body.Add('<link rel="stylesheet" type="text/css" '+
      'href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u">');
      IdText.Body.Add('</head>');

      IdText.Body.Add('<body  style="font-family: verdana">');
      idText.Body.Add('<img src="https://s3.amazonaws.com/cdn.freshdesk.com/data/helpdesk/attachments/production/12019185122/original/1Tsfmwb6Jl2oFV2n1VPPq95aaXgxdvM8TA.png?1495211856"/>');

      IdText.Body.Add('<h3><font color=''00A9C7''>');
      IdText.Body.Add('A��o Atrasada');
      IdText.Body.Add('</font></h3> <br>');

      IdText.Body.Add('<p>');
      IdText.Body.Add('<b>CAPA</b> <br> <br>');
      IdText.Body.Add('N�mero: ' + vlQuerySIC.FieldByName('ACAO_TIPO').AsString + '<br> ');
      IdText.Body.Add('Status: ' + vlQuerySIC.FieldByName('ACAO').AsString + '<br> ');
      IdText.Body.Add('Respons�vel: ' + vlQuerySIC.FieldByName('RESPONSAVEL').AsString + '<br> ');
      IdText.Body.Add('</p>');

      IdText.Body.Add('<hr>');

      IdText.Body.Add('<p>');
      IdText.Body.Add('<b>A��O</b> <br> <br>');
      IdText.Body.Add('A��o Tipo: ' + vlQuerySIC.FieldByName('ACAO_TIPO').AsString + '<br> ');
      IdText.Body.Add('A��o: ' + vlQuerySIC.FieldByName('ACAO').AsString + '<br> ');
      IdText.Body.Add('Respons�vel: ' + vlQuerySIC.FieldByName('RESPONSAVEL').AsString + '<br> ');
      IdText.Body.Add('Prazo: ' + vlQuerySIC.FieldByName('PRAZO').AsString + '<br> ');
      IdText.Body.Add('Departamento: ' + vlQuerySIC.FieldByName('DEPARTAMENTO').AsString + '<br> ');
      IdText.Body.Add('Motivo: ' + vlQuerySIC.FieldByName('MOTIVO').AsString + '<br> ');
      IdText.Body.Add('Metodologia: ' + vlQuerySIC.FieldByName('METODOLOGIA').AsString + '<br> ');
      IdText.Body.Add('</p>');

      IdText.Body.Add('</body>');
      IdText.Body.Add('</html>');
      IdText.ContentType := 'text/html; charset=iso-8859-1';

      //Prepara o Servidor
      IdSMTP                           := TIdSMTP.Create(Self);
      IdSMTP.IOHandler                 := IdSSLIOHandlerSocket;
      IdSMTP.UseTLS                    := utUseImplicitTLS;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Host                      := sHost;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Port                      := iPort;
      IdSMTP.Username                  := vEmail;
      IdSMTP.Password                  := vSenhaEmail;

      //Conecta e Autentica
      IdSMTP.Connect;
      IdSMTP.Authenticate;

      //Se a conex�o foi bem sucedida, envia a mensagem
      if IdSMTP.Connected then
      begin
        try
          IdSMTP.Send(idMsg);
        except on E:Exception do
          begin
            //showmessage('Erro ao tentar enviar: ' + E.Message);
          end;
        end;
      end;

      //Depois de tudo pronto, desconecta do servidor SMTP
      if IdSMTP.Connected then
        IdSMTP.Disconnect;

      Result := True;
    finally

      UnLoadOpenSSLLibrary;

      FreeAndNil(vlQuerySIC);
      FreeAndNil(idMsg);
      FreeAndNil(IdSSLIOHandlerSocket);
      FreeAndNil(idSMTP);
    end;
  except on e:Exception do
    begin
      Result := False;
    end;
  end;

end;

function Tdm1.fEnviaEmailCAPA(const AAssunto, ADestino,
  prCAPAID: String): Boolean;
var
  sHost                : String;
  iPort                : Integer;
  vEmail               : String;
  vSenhaEmail          : String;

  idMsg                : TIdMessage;
  IdText               : TIdText;
  idSMTP               : TIdSMTP;
  IdSSLIOHandlerSocket : TIdSSLIOHandlerSocketOpenSSL;

  vlQuerySIC           : TIBQuery;
begin
  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;

      Close;
      SQL.Text := 'select parametro, conteudo from tbparametros where parametro = ''EMAIL_ORCAMENTO_DE'' ';
      Open;
      vEmail := vlQuerySIC.FieldByName('CONTEUDO').AsString;

      Close;
      SQL.Text := 'select parametro, conteudo from tbparametros where parametro = ''EMAIL_ORCAMENTO_DE_S'' ';
      Open;
      vSenhaEmail := vlQuerySIC.FieldByName('CONTEUDO').AsString;
    end;

    sHost          :='smtp.farmace.com.br';
    iPort          :=465;

  try
    try
      with vlQuerySIC do
        begin
          Close;
          SQL.Text := 'select';
          SQL.Add(' c.rnccapa_id, c.numero, c.data, c.status, c.responsavel,');
          SQL.Add(' i.acao_tipo, i.acao, i.responsavel as responsavel_acao, i.prazo,');
          SQL.Add(' i.departamento, i.motivo, i.metodologia');
          SQL.Add(' from tbrnc_capa c left join tbrnc_capa_item i');
          SQL.Add(' on i.rnccapa_id = c.rnccapa_id and i.deletado = ''N'' ');
          SQL.Add(' where c.deletado = ''N'' ');
          SQL.Add(' and i.rnccapa_id = ''' + prCAPAID + ''' ');
          Open;
        end;

      //Configura os par�metros necess�rios para SSL
      IdSSLIOHandlerSocket                   := TIdSSLIOHandlerSocketOpenSSL.Create(Self);
      IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
      IdSSLIOHandlerSocket.SSLOptions.Mode  := sslmClient;

      //Vari�vel referente a mensagem
      idMsg                            := TIdMessage.Create(Self);
      idMsg.CharSet                    := 'utf-8';
      idMsg.Encoding                   := meMIME;
      idMsg.From.Name                  := 'SAC - FARMACE';
      idMsg.From.Address               := vEmail;
      idMsg.Priority                   := mpNormal;
      idMsg.Subject                    := AAssunto;

      //Add Destinat�rio(s)
      idMsg.Recipients.Add;
      idMsg.Recipients.EMailAddresses := ADestino;

      //Vari�vel do texto
      IdText := TIdText.Create(idMsg.MessageParts);
      IdText.Body.Add('<html>');

      IdText.Body.Add('<head>');
      IdText.Body.Add('<link rel="stylesheet" type="text/css" '+
      'href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u">');
      IdText.Body.Add('</head>');

      IdText.Body.Add('<body  style="font-family: verdana">');
      idText.Body.Add('<img src="https://s3.amazonaws.com/cdn.freshdesk.com/data/helpdesk/attachments/production/12019185122/original/1Tsfmwb6Jl2oFV2n1VPPq95aaXgxdvM8TA.png?1495211856"/>');

      IdText.Body.Add('<h3><font color=''00A9C7''>');
      IdText.Body.Add('A��o Atrasada');
      IdText.Body.Add('</font></h3> <br>');

      IdText.Body.Add('<p>');

      IdText.Body.Add('CAPA ID: ' + vlQuerySIC.FieldByName('RNCCAPA_ID').AsString + '<br> ');
      IdText.Body.Add('N�mero: ' + vlQuerySIC.FieldByName('NUMERO').AsString + '<br> ');
      IdText.Body.Add('Data: ' +  vlQuerySIC.FieldByName('DATA').AsString + '<br>');
      IdText.Body.Add('Status: ' +  vlQuerySIC.FieldByName('STATUS').AsString + '<br>');
      IdText.Body.Add('Respons�vel: ' +  vlQuerySIC.FieldByName('RESPONSAVEL').AsString + '<br>');

      IdText.Body.Add('</p>');

      IdText.Body.Add('<hr>');

      IdText.Body.Add('<div class="container">');
	    IdText.Body.Add('<table class="table table-sm" style="font-size: 11px; font-family: verdana;">');

		  IdText.Body.Add('<tr>');
			IdText.Body.Add('<thead>');
			IdText.Body.Add('<th scope="col" style="text-align: left;">Tipo A��o</th>');
			IdText.Body.Add('<th scope="col" style="text-align: left;">A��o</th>');
			IdText.Body.Add('<th scope="col" style="text-align: left;">Respons�vel</th>');
			IdText.Body.Add('<th scope="col" style="text-align: left;">Prazo</th>');
			IdText.Body.Add('<th scope="col" style="text-align: left;">Departamento</th>');
			IdText.Body.Add('<th scope="col" style="text-align: left;">Motivo</th>');
			IdText.Body.Add('<th scope="col" style="text-align: left;">Metodologia</th>');
			IdText.Body.Add('</thead>');
		  IdText.Body.Add('</tr>');

      vlQuerySIC.First;
      while not vlQuerySIC.Eof do
        begin
          IdText.Body.Add('<tr>');
          IdText.Body.Add('<td style="text-align: left;">' + vlQuerySIC.FieldByName('ACAO_TIPO').AsString    +'</td>');
          IdText.Body.Add('<td style="text-align: left;">' + Copy(vlQuerySIC.FieldByName('ACAO').AsString,1,15) +'</td>');
          IdText.Body.Add('<td style="text-align: left;">' + vlQuerySIC.FieldByName('RESPONSAVEL_ACAO').AsString +'</td>');
          IdText.Body.Add('<td style="text-align: left;">' + vlQuerySIC.FieldByName('PRAZO').AsString+'</td>');
          IdText.Body.Add('<td style="text-align: left;">' + vlQuerySIC.FieldByName('DEPARTAMENTO').AsString+'</td>');
          IdText.Body.Add('<td style="text-align: left;">' + Copy(vlQuerySIC.FieldByName('MOTIVO').AsString,1,15)+'</td>');
          IdText.Body.Add('<td style="text-align: left;">' + vlQuerySIC.FieldByName('METODOLOGIA').AsString+'</td>');

          IdText.Body.Add('</tr>');
          vlQuerySIC.Next;
        end;

      IdText.Body.Add('<tr>');
			IdText.Body.Add('<thead>');

	    IdText.Body.Add('</table>');
      IdText.Body.Add('</div>');



      IdText.Body.Add('</body>');
      IdText.Body.Add('</html>');
      IdText.ContentType := 'text/html; charset=iso-8859-1';

      //Prepara o Servidor
      IdSMTP                           := TIdSMTP.Create(Self);
      IdSMTP.IOHandler                 := IdSSLIOHandlerSocket;
      IdSMTP.UseTLS                    := utUseImplicitTLS;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Host                      := sHost;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Port                      := iPort;
      IdSMTP.Username                  := vEmail;
      IdSMTP.Password                  := vSenhaEmail;

      //Conecta e Autentica
      IdSMTP.Connect;
      IdSMTP.Authenticate;

      //Se a conex�o foi bem sucedida, envia a mensagem
      if IdSMTP.Connected then
      begin
        try
          IdSMTP.Send(idMsg);
        except on E:Exception do
          begin
            //showmessage('Erro ao tentar enviar: ' + E.Message);
          end;
        end;
      end;

      //Depois de tudo pronto, desconecta do servidor SMTP
      if IdSMTP.Connected then
        IdSMTP.Disconnect;

      Result := True;
    finally

      UnLoadOpenSSLLibrary;

      FreeAndNil(vlQuerySIC);
      FreeAndNil(idMsg);
      FreeAndNil(IdSSLIOHandlerSocket);
      FreeAndNil(idSMTP);
    end;
  except on e:Exception do
    begin
      Result := False;
    end;
  end;

end;

function Tdm1.fEnviaEmailPDIAmostra(const AAssunto, ADestino, prStatus,
  prAmostraID: String): Boolean;
var
  sHost                : String;
  iPort                : Integer;
  vEmail               : String;
  vSenhaEmail          : String;

  idMsg                : TIdMessage;
  IdText               : TIdText;
  idSMTP               : TIdSMTP;
  IdSSLIOHandlerSocket : TIdSSLIOHandlerSocketOpenSSL;

  vlQuerySIC           : TIBQuery;
begin
  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;

      Close;
      SQL.Text := 'select parametro, conteudo from tbparametros where parametro = ''EMAIL_ORCAMENTO_DE'' ';
      Open;
      vEmail := vlQuerySIC.FieldByName('CONTEUDO').AsString;

      Close;
      SQL.Text := 'select parametro, conteudo from tbparametros where parametro = ''EMAIL_ORCAMENTO_DE_S'' ';
      Open;
      vSenhaEmail := vlQuerySIC.FieldByName('CONTEUDO').AsString;
    end;

    sHost          :='smtp.farmace.com.br';
    iPort          :=465;

  try
    try
      with vlQuerySIC do
        begin
          Close;
          SQL.Text := 'select';
          SQL.Add(' a.erp_produto||''-''||a.produto as produto,');
          SQL.Add(' a.acondicionamento, a.lote, a.lote_fabricacao,');
          SQL.Add(' a.lote_validade, i.finalidade, i.estudo,');
          SQL.Add(' i.tempo_qtd||'' ''||i.tempo_tipo as tempo,');
          SQL.Add(' i.destino, i.quantidade_amostra, a.pdeiamostra_id');
          SQL.Add(' from tbpdei_amostra a');
          SQL.Add(' left join tbpdei_amostra_item i on i.pdeiamostra_id = a.pdeiamostra_id');

          if prStatus = 'Abortada' then
            begin
              SQL.Add(' and i.deletado = ''S'' ');
              SQL.Add(' where a.deletado = ''S'' ');
            end
          else
            begin
              SQL.Add(' and i.deletado = ''N'' ');
              SQL.Add(' where a.deletado = ''N'' ');
            end;

          SQL.Add(' and a.pdeiamostra_id = ''' + prAmostraID + ''' ');
          Open;
        end;

      //Configura os par�metros necess�rios para SSL
      IdSSLIOHandlerSocket                   := TIdSSLIOHandlerSocketOpenSSL.Create(Self);
      IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
      IdSSLIOHandlerSocket.SSLOptions.Mode  := sslmClient;

      //Vari�vel referente a mensagem
      idMsg                            := TIdMessage.Create(Self);
      idMsg.CharSet                    := 'utf-8';
      idMsg.Encoding                   := meMIME;
      idMsg.From.Name                  := 'ESTABILIDADE';
      idMsg.From.Address               := vEmail;
      idMsg.Priority                   := mpNormal;
      idMsg.Subject                    := AAssunto;

      //Add Destinat�rio(s)
      idMsg.Recipients.Add;
      idMsg.Recipients.EMailAddresses := ADestino;

      //Vari�vel do texto
      IdText := TIdText.Create(idMsg.MessageParts);
      IdText.Body.Add('<html>');

      IdText.Body.Add('<head>');
      IdText.Body.Add('<link rel="stylesheet" type="text/css" '+
      'href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u">');
      IdText.Body.Add('</head>');

      IdText.Body.Add('<body  style="font-family: verdana">');
      idText.Body.Add('<img src="https://s3.amazonaws.com/cdn.freshdesk.com/data/helpdesk/attachments/production/12019185122/original/1Tsfmwb6Jl2oFV2n1VPPq95aaXgxdvM8TA.png?1495211856"/>');

      IdText.Body.Add('<h3><font color=''00A9C7''>');
      IdText.Body.Add('Amostra ' + prStatus);
      IdText.Body.Add('</font></h3> <br>');

      IdText.Body.Add('<p>');

      IdText.Body.Add('ID: ' + vlQuerySIC.FieldByName('PDEIAMOSTRA_ID').AsString + '<br> ');
      IdText.Body.Add('Produdo: ' + vlQuerySIC.FieldByName('PRODUTO').AsString + '<br> ');
      IdText.Body.Add('Acondicionamento: ' +  vlQuerySIC.FieldByName('ACONDICIONAMENTO').AsString + '<br>');
      IdText.Body.Add('Lote: ' +  vlQuerySIC.FieldByName('LOTE').AsString + '<br>');
      IdText.Body.Add('Fabrica��o: ' +  vlQuerySIC.FieldByName('LOTE_FABRICACAO').AsString + '<br>');
      IdText.Body.Add('Validade: ' +  vlQuerySIC.FieldByName('LOTE_VALIDADE').AsString + '<br>');

      if prStatus = 'Abortada' then
        IdText.Body.Add('Justificativa:<br>' + vlQuerySIC.FieldByName('JUSTIFICATIVA_EXCLUSAO').AsString);

      IdText.Body.Add('</p>');

      IdText.Body.Add('<div class="container">');
	    IdText.Body.Add('<table class="table table-sm" style="font-size: 11px; font-family: verdana;">');

		  IdText.Body.Add('<tr>');
			IdText.Body.Add('<thead>');
			IdText.Body.Add('<th scope="col" style="text-align: left;">Finalidade</th>');
			IdText.Body.Add('<th scope="col" style="text-align: left;">Estudo</th>');
			IdText.Body.Add('<th scope="col" style="text-align: right;">Tempo</th>');
			IdText.Body.Add('<th scope="col" style="text-align: right;">Quantidade</th>');
			IdText.Body.Add('<th scope="col" style="text-align: right;">Destino</th>');
			IdText.Body.Add('</thead>');
		  IdText.Body.Add('</tr>');

      vlQuerySIC.First;
      while not vlQuerySIC.Eof do
        begin
          IdText.Body.Add('<tr>');
          IdText.Body.Add('<td style="text-align: left;">' + vlQuerySIC.FieldByName('FINALIDADE').AsString    +'</td>');
          IdText.Body.Add('<td style="text-align: left;">' + vlQuerySIC.FieldByName('ESTUDO').AsString +'</td>');
          IdText.Body.Add('<td style="text-align: right;">'+ vlQuerySIC.FieldByName('TEMPO').AsString +'</td>');
          IdText.Body.Add('<td style="text-align: right;">'+ vlQuerySIC.FieldByName('QUANTIDADE_AMOSTRA').AsString+'</td>');
          IdText.Body.Add('<td style="text-align: right;">'+ vlQuerySIC.FieldByName('DESTINO').AsString+'</td>');

          IdText.Body.Add('</tr>');
          vlQuerySIC.Next;
        end;

      IdText.Body.Add('<tr>');
			IdText.Body.Add('<thead>');
			IdText.Body.Add('<td scope="col" style="text-align: left;"></td>');
			IdText.Body.Add('<td scope="col" style="text-align: right;">Total dos Itens -></td>');

	    IdText.Body.Add('</table>');
      IdText.Body.Add('</div>');

      IdText.Body.Add('</body>');
      IdText.Body.Add('</html>');
      IdText.ContentType := 'text/html; charset=iso-8859-1';

      //Prepara o Servidor
      IdSMTP                           := TIdSMTP.Create(Self);
      IdSMTP.IOHandler                 := IdSSLIOHandlerSocket;
      IdSMTP.UseTLS                    := utUseImplicitTLS;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Host                      := sHost;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Port                      := iPort;
      IdSMTP.Username                  := vEmail;
      IdSMTP.Password                  := vSenhaEmail;

      //Conecta e Autentica
      IdSMTP.Connect;
      IdSMTP.Authenticate;

      //Se a conex�o foi bem sucedida, envia a mensagem
      if IdSMTP.Connected then
      begin
        try
          IdSMTP.Send(idMsg);
        except on E:Exception do
          begin
            //showmessage('Erro ao tentar enviar: ' + E.Message);
          end;
        end;
      end;

      //Depois de tudo pronto, desconecta do servidor SMTP
      if IdSMTP.Connected then
        IdSMTP.Disconnect;

      Result := True;
    finally

      UnLoadOpenSSLLibrary;

      FreeAndNil(vlQuerySIC);
      FreeAndNil(idMsg);
      FreeAndNil(IdSSLIOHandlerSocket);
      FreeAndNil(idSMTP);
    end;
  except on e:Exception do
    begin
      Result := False;
    end;
  end;
end;

function Tdm1.fEnviaEmailPDIEstudo(const AAssunto, ADestino, prStatus,
  prEstudoID: String): Boolean;
var
  sHost                : String;
  iPort                : Integer;
  vEmail               : String;
  vSenhaEmail          : String;

  idMsg                : TIdMessage;
  IdText               : TIdText;
  idSMTP               : TIdSMTP;
  IdSSLIOHandlerSocket : TIdSSLIOHandlerSocketOpenSSL;

  vlQuerySIC           : TIBQuery;
begin
  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;

      Close;
      SQL.Text := 'select parametro, conteudo from tbparametros where parametro = ''EMAIL_ORCAMENTO_DE'' ';
      Open;
      vEmail := vlQuerySIC.FieldByName('CONTEUDO').AsString;

      Close;
      SQL.Text := 'select parametro, conteudo from tbparametros where parametro = ''EMAIL_ORCAMENTO_DE_S'' ';
      Open;
      vSenhaEmail := vlQuerySIC.FieldByName('CONTEUDO').AsString;
    end;

    sHost          :='smtp.farmace.com.br';
    iPort          :=465;

  try
    try
      with vlQuerySIC do
        begin
          Close;
          SQL.Text := 'select';
          SQL.Add(' e.estudo_id, e.estudo, e.estudo_descricao,');
          SQL.Add(' e.justificativa_exclusao');
          SQL.Add(' from tbpdei_estudo e');

          if prStatus = 'Exclu�do' then
            SQL.Add(' where e.deletado = ''S'' ')
          else
            SQL.Add(' where e.deletado = ''N'' ');

          SQL.Add(' and e.estudo_id = ''' + prEstudoID + ''' ');
          Open;
        end;

      //Configura os par�metros necess�rios para SSL
      IdSSLIOHandlerSocket                   := TIdSSLIOHandlerSocketOpenSSL.Create(Self);
      IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
      IdSSLIOHandlerSocket.SSLOptions.Mode  := sslmClient;

      //Vari�vel referente a mensagem
      idMsg                            := TIdMessage.Create(Self);
      idMsg.CharSet                    := 'utf-8';
      idMsg.Encoding                   := meMIME;
      idMsg.From.Name                  := 'ESTABILIDADE';
      idMsg.From.Address               := vEmail;
      idMsg.Priority                   := mpNormal;
      idMsg.Subject                    := AAssunto;

      //Add Destinat�rio(s)
      idMsg.Recipients.Add;
      idMsg.Recipients.EMailAddresses := ADestino;

      //Vari�vel do texto
      IdText := TIdText.Create(idMsg.MessageParts);
      IdText.Body.Add('<html>');

      IdText.Body.Add('<head>');
      IdText.Body.Add('<link rel="stylesheet" type="text/css" '+
      'href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u">');
      IdText.Body.Add('</head>');

      IdText.Body.Add('<body  style="font-family: verdana">');
      idText.Body.Add('<img src="https://s3.amazonaws.com/cdn.freshdesk.com/data/helpdesk/attachments/production/12019185122/original/1Tsfmwb6Jl2oFV2n1VPPq95aaXgxdvM8TA.png?1495211856"/>');

      IdText.Body.Add('<h3><font color=''00A9C7''>');
      IdText.Body.Add('Estudo ' + prStatus);
      IdText.Body.Add('</font></h3> <br>');

      IdText.Body.Add('<p>');

      IdText.Body.Add('ID: ' + vlQuerySIC.FieldByName('ESTUDO_ID').AsString + '<br> ');
      IdText.Body.Add('Estudo: ' + vlQuerySIC.FieldByName('ESTUDO').AsString + '<br> ');
      IdText.Body.Add('Descri��o: ' +  vlQuerySIC.FieldByName('ESTUDO_DESCRICAO').AsString + '<br>');

      if prStatus = 'Exclu�do' then
        IdText.Body.Add('Justificativa:<br>' + vlQuerySIC.FieldByName('JUSTIFICATIVA_EXCLUSAO').AsString);

      IdText.Body.Add('</p>');


      IdText.Body.Add('</body>');
      IdText.Body.Add('</html>');
      IdText.ContentType := 'text/html; charset=iso-8859-1';

      //Prepara o Servidor
      IdSMTP                           := TIdSMTP.Create(Self);
      IdSMTP.IOHandler                 := IdSSLIOHandlerSocket;
      IdSMTP.UseTLS                    := utUseImplicitTLS;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Host                      := sHost;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Port                      := iPort;
      IdSMTP.Username                  := vEmail;
      IdSMTP.Password                  := vSenhaEmail;

      //Conecta e Autentica
      IdSMTP.Connect;
      IdSMTP.Authenticate;

      //Se a conex�o foi bem sucedida, envia a mensagem
      if IdSMTP.Connected then
      begin
        try
          IdSMTP.Send(idMsg);
        except on E:Exception do
          begin
            //showmessage('Erro ao tentar enviar: ' + E.Message);
          end;
        end;
      end;

      //Depois de tudo pronto, desconecta do servidor SMTP
      if IdSMTP.Connected then
        IdSMTP.Disconnect;

      Result := True;
    finally

      UnLoadOpenSSLLibrary;

      FreeAndNil(vlQuerySIC);
      FreeAndNil(idMsg);
      FreeAndNil(IdSSLIOHandlerSocket);
      FreeAndNil(idSMTP);
    end;
  except on e:Exception do
    begin
      Result := False;
    end;
  end;
end;

function Tdm1.fEnviaEmailPDIFinalidade(const AAssunto, ADestino, prStatus,
  prFinalidadeID: String): Boolean;
var
  sHost                : String;
  iPort                : Integer;
  vEmail               : String;
  vSenhaEmail          : String;

  idMsg                : TIdMessage;
  IdText               : TIdText;
  idSMTP               : TIdSMTP;
  IdSSLIOHandlerSocket : TIdSSLIOHandlerSocketOpenSSL;

  vlQuerySIC           : TIBQuery;
begin
  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;

      Close;
      SQL.Text := 'select parametro, conteudo from tbparametros where parametro = ''EMAIL_ORCAMENTO_DE'' ';
      Open;
      vEmail := vlQuerySIC.FieldByName('CONTEUDO').AsString;

      Close;
      SQL.Text := 'select parametro, conteudo from tbparametros where parametro = ''EMAIL_ORCAMENTO_DE_S'' ';
      Open;
      vSenhaEmail := vlQuerySIC.FieldByName('CONTEUDO').AsString;
    end;

    sHost          :='smtp.farmace.com.br';
    iPort          :=465;

  try
    try
      with vlQuerySIC do
        begin
          Close;
          SQL.Text := 'select';
          SQL.Add(' f.finalidade_id, f.finalidade, f.finalidade_descricao,');
          SQL.Add(' f.justificativa_exclusao');
          SQL.Add(' from tbpdei_finalidade f');

          if prStatus = 'Exclu�da' then
            SQL.Add(' where f.deletado = ''S'' ')
          else
            SQL.Add(' where f.deletado = ''N'' ');

          SQL.Add(' and f.finalidade_id = ''' + prFinalidadeID + ''' ');
          Open;
        end;

      //Configura os par�metros necess�rios para SSL
      IdSSLIOHandlerSocket                   := TIdSSLIOHandlerSocketOpenSSL.Create(Self);
      IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
      IdSSLIOHandlerSocket.SSLOptions.Mode  := sslmClient;

      //Vari�vel referente a mensagem
      idMsg                            := TIdMessage.Create(Self);
      idMsg.CharSet                    := 'utf-8';
      idMsg.Encoding                   := meMIME;
      idMsg.From.Name                  := 'ESTABILIDADE';
      idMsg.From.Address               := vEmail;
      idMsg.Priority                   := mpNormal;
      idMsg.Subject                    := AAssunto;

      //Add Destinat�rio(s)
      idMsg.Recipients.Add;
      idMsg.Recipients.EMailAddresses := ADestino;

      //Vari�vel do texto
      IdText := TIdText.Create(idMsg.MessageParts);
      IdText.Body.Add('<html>');

      IdText.Body.Add('<head>');
      IdText.Body.Add('<link rel="stylesheet" type="text/css" '+
      'href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u">');
      IdText.Body.Add('</head>');

      IdText.Body.Add('<body  style="font-family: verdana">');
      idText.Body.Add('<img src="https://s3.amazonaws.com/cdn.freshdesk.com/data/helpdesk/attachments/production/12019185122/original/1Tsfmwb6Jl2oFV2n1VPPq95aaXgxdvM8TA.png?1495211856"/>');

      IdText.Body.Add('<h3><font color=''00A9C7''>');
      IdText.Body.Add('Finalidade ' + prStatus);
      IdText.Body.Add('</font></h3> <br>');

      IdText.Body.Add('<p>');

      IdText.Body.Add('ID: ' + vlQuerySIC.FieldByName('FINALIDADE_ID').AsString + '<br> ');
      IdText.Body.Add('Finalidade: ' + vlQuerySIC.FieldByName('FINALIDADE').AsString + '<br> ');
      IdText.Body.Add('Descri��o: ' +  vlQuerySIC.FieldByName('FINALIDADE_DESCRICAO').AsString + '<br>');

      if prStatus = 'Exclu�da' then
        IdText.Body.Add('Justificativa:<br>' + vlQuerySIC.FieldByName('JUSTIFICATIVA_EXCLUSAO').AsString);

      IdText.Body.Add('</p>');


      IdText.Body.Add('</body>');
      IdText.Body.Add('</html>');
      IdText.ContentType := 'text/html; charset=iso-8859-1';

      //Prepara o Servidor
      IdSMTP                           := TIdSMTP.Create(Self);
      IdSMTP.IOHandler                 := IdSSLIOHandlerSocket;
      IdSMTP.UseTLS                    := utUseImplicitTLS;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Host                      := sHost;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Port                      := iPort;
      IdSMTP.Username                  := vEmail;
      IdSMTP.Password                  := vSenhaEmail;

      //Conecta e Autentica
      IdSMTP.Connect;
      IdSMTP.Authenticate;

      //Se a conex�o foi bem sucedida, envia a mensagem
      if IdSMTP.Connected then
      begin
        try
          IdSMTP.Send(idMsg);
        except on E:Exception do
          begin
            //showmessage('Erro ao tentar enviar: ' + E.Message);
          end;
        end;
      end;

      //Depois de tudo pronto, desconecta do servidor SMTP
      if IdSMTP.Connected then
        IdSMTP.Disconnect;

      Result := True;
    finally

      UnLoadOpenSSLLibrary;

      FreeAndNil(vlQuerySIC);
      FreeAndNil(idMsg);
      FreeAndNil(IdSSLIOHandlerSocket);
      FreeAndNil(idSMTP);
    end;
  except on e:Exception do
    begin
      Result := False;
    end;
  end;
end;

function Tdm1.fEnviaEmailRetem(const AAssunto, ADestino,
  AAnexo, prSQL: String): Boolean;
var
  sHost                : String;
  iPort                : Integer;
  vEmail               : String;
  vSenhaEmail          : String;

  idMsg                : TIdMessage;
  IdText               : TIdText;
  idSMTP               : TIdSMTP;
  IdSSLIOHandlerSocket : TIdSSLIOHandlerSocketOpenSSL;

  vlQuerySIC           : TIBQuery;
  vlQueryTOTVS         : TADOQuery;
begin
  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;

      Close;
      SQL.Text := 'select parametro, conteudo from tbparametros where parametro = ''EMAIL_ORCAMENTO_DE'' ';
      Open;
      vEmail := vlQuerySIC.FieldByName('CONTEUDO').AsString;

      Close;
      SQL.Text := 'select parametro, conteudo from tbparametros where parametro = ''EMAIL_ORCAMENTO_DE_S'' ';
      Open;
      vSenhaEmail := vlQuerySIC.FieldByName('CONTEUDO').AsString;
    end;

    sHost          :='smtp.farmace.com.br';
    iPort          :=465;

  try
    try

      //Configura os par�metros necess�rios para SSL
      IdSSLIOHandlerSocket                   := TIdSSLIOHandlerSocketOpenSSL.Create(Self);
      IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
      IdSSLIOHandlerSocket.SSLOptions.Mode  := sslmClient;

      //Vari�vel referente a mensagem
      idMsg                            := TIdMessage.Create(Self);
      idMsg.CharSet                    := 'utf-8';
      idMsg.Encoding                   := meMIME;
      idMsg.From.Name                  := 'SAC - FARMACE';
      idMsg.From.Address               := vEmail;
      idMsg.Priority                   := mpNormal;
      idMsg.Subject                    := AAssunto;

      //Add Destinat�rio(s)
      idMsg.Recipients.Add;
      idMsg.Recipients.EMailAddresses := ADestino;

      //Vari�vel do texto
      IdText := TIdText.Create(idMsg.MessageParts);
      IdText.Body.Add('<html>');

      IdText.Body.Add('<head>');
      IdText.Body.Add('<link rel="stylesheet" type="text/css" '+
      'href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u">');
      IdText.Body.Add('</head>');

      IdText.Body.Add('<body  style="font-family: verdana">');
      idText.Body.Add('<img src="https://s3.amazonaws.com/cdn.freshdesk.com/data/helpdesk/attachments/production/12019185122/original/1Tsfmwb6Jl2oFV2n1VPPq95aaXgxdvM8TA.png?1495211856"/>');

      IdText.Body.Add('<h3><font color=''00A9C7''>');
      IdText.Body.Add('Ret�m');
      IdText.Body.Add('</font></h3> <br>');

      IdText.Body.Add('<p> Teste');

      vlQueryTOTVS := TADOQuery.Create(Owner);

      with vlQueryTOTVS do
        begin
          //Connection := dmEstabilidade.ADOConnection1;
          Close;
          SQL.Text := prSQL;
          Open
        end;

      if not vlQueryTOTVS.IsEmpty then
        begin
          IdText.Body.Add('<table class="table table-sm" style="font-size: 11px; font-family: verdana;">');
          IdText.Body.Add('<tr>');
          IdText.Body.Add('<thead>');
          IdText.Body.Add('<th scope="col" style="text-align: left;">Data</th>');
          IdText.Body.Add('<th scope="col" style="text-align: left;">Temperatura</th>');
          IdText.Body.Add('<th scope="col" style="text-align: left;">Umidade</th>');
          IdText.Body.Add('</thead>');
          IdText.Body.Add('</tr>');

          vlQueryTOTVS.First;
          while not vlQueryTOTVS.Eof do
            begin
              IdText.Body.Add('<tr>');
              IdText.Body.Add('<td style="text-align: left;">' + Trim(vlQueryTOTVS.FieldByName('DATAHORA').AsString) +'</td>');
              IdText.Body.Add('<td style="text-align: left;">' + Trim(vlQueryTOTVS.FieldByName('TEMPERATURA').AsString) +'</td>');
              IdText.Body.Add('<td style="text-align: left;">' + Trim(vlQueryTOTVS.FieldByName('UMIDADE').AsString) +'</td>');
              IdText.Body.Add('</tr>');

              vlQueryTOTVS.Next;
            end;
          IdText.Body.Add('</table>');
        end;

      IdText.Body.Add('</p>');


      IdText.Body.Add('</body>');
      IdText.Body.Add('</html>');
      IdText.ContentType := 'text/html; charset=iso-8859-1';

      //Prepara o Servidor
      IdSMTP                           := TIdSMTP.Create(Self);
      IdSMTP.IOHandler                 := IdSSLIOHandlerSocket;
      IdSMTP.UseTLS                    := utUseImplicitTLS;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Host                      := sHost;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Port                      := iPort;
      IdSMTP.Username                  := vEmail;
      IdSMTP.Password                  := vSenhaEmail;

      //Conecta e Autentica
      IdSMTP.Connect;
      IdSMTP.Authenticate;

      if AAnexo <> EmptyStr then
        if FileExists(AAnexo) then
          TIdAttachmentFile.Create(idMsg.MessageParts, AAnexo);

      //Se a conex�o foi bem sucedida, envia a mensagem
      if IdSMTP.Connected then
      begin
        try
          IdSMTP.Send(idMsg);
        except on E:Exception do
          begin
            //showmessage('Erro ao tentar enviar: ' + E.Message);
          end;
        end;
      end;

      //Depois de tudo pronto, desconecta do servidor SMTP
      if IdSMTP.Connected then
        IdSMTP.Disconnect;

      Result := True;
    finally

      UnLoadOpenSSLLibrary;

      FreeAndNil(vlQuerySIC);
      FreeAndNil(vlQueryTOTVS);
      FreeAndNil(idMsg);
      FreeAndNil(IdSSLIOHandlerSocket);
      FreeAndNil(idSMTP);
    end;
  except on e:Exception do
    begin
      Result := False;
    end;
  end;
end;

function Tdm1.fEnviaEmailReuniao(const AAssunto, ADestino,
  prReuniaoID: String): Boolean;
var
  sHost                : String;
  iPort                : Integer;
  vEmail               : String;
  vSenhaEmail          : String;

  idMsg                : TIdMessage;
  IdText               : TIdText;
  idSMTP               : TIdSMTP;
  IdSSLIOHandlerSocket : TIdSSLIOHandlerSocketOpenSSL;

  vlQuerySIC           : TIBQuery;
begin
  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;

      Close;
      SQL.Text := 'select parametro, conteudo from tbparametros where parametro = ''EMAIL_ORCAMENTO_DE'' ';
      Open;
      vEmail := vlQuerySIC.FieldByName('CONTEUDO').AsString;

      Close;
      SQL.Text := 'select parametro, conteudo from tbparametros where parametro = ''EMAIL_ORCAMENTO_DE_S'' ';
      Open;
      vSenhaEmail := vlQuerySIC.FieldByName('CONTEUDO').AsString;
    end;

    sHost          :='smtp.farmace.com.br';
    iPort          :=465;

  try
    try
      with vlQuerySIC do
        begin
          Close;
          SQL.Text := 'select';
          SQL.Add(' r.reuniao_id, r.departamento, r.solicitante, r.pauta,');
          SQL.Add(' r.obs, r.data, r.hora,  r.criticidade, r.recurso,');
          SQL.Add(' r.reuniaolocal, c.contato, c.email');
          SQL.Add(' from tbreuniao r left join tbreuniao_contato c');
          SQL.Add(' on c.reuniao_id = r.reuniao_id and c.deletado = ''N'' ');
          SQL.Add(' where r.deletado = ''N'' ');
          SQL.Add(' and r.reuniao_id = ''' + prReuniaoID + ''' ');
          Open;
        end;

      //Configura os par�metros necess�rios para SSL
      IdSSLIOHandlerSocket                   := TIdSSLIOHandlerSocketOpenSSL.Create(Self);
      IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
      IdSSLIOHandlerSocket.SSLOptions.Mode  := sslmClient;

      //Vari�vel referente a mensagem
      idMsg                            := TIdMessage.Create(Self);
      idMsg.CharSet                    := 'utf-8';
      idMsg.Encoding                   := meMIME;
      idMsg.From.Name                  := 'SIC - Reuni�o [' + prReuniaoID + ']';
      idMsg.From.Address               := vEmail;
      idMsg.Priority                   := mpNormal;
      idMsg.Subject                    := AAssunto;

      //Add Destinat�rio(s)
      idMsg.Recipients.Add;
      idMsg.Recipients.EMailAddresses := ADestino;

      //Vari�vel do texto
      IdText := TIdText.Create(idMsg.MessageParts);
      IdText.Body.Add('<html>');

      IdText.Body.Add('<head>');
      IdText.Body.Add('<link rel="stylesheet" type="text/css" '+
      'href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u">');
      IdText.Body.Add('</head>');

      IdText.Body.Add('<body  style="font-family: verdana">');
      idText.Body.Add('<img src="https://s3.amazonaws.com/cdn.freshdesk.com/data/helpdesk/attachments/production/12019185122/original/1Tsfmwb6Jl2oFV2n1VPPq95aaXgxdvM8TA.png?1495211856"/>');

      IdText.Body.Add('<h3><font color=''00A9C7''>');
      IdText.Body.Add('Reuni�o');
      IdText.Body.Add('</font></h3> <br>');

      IdText.Body.Add('<p>');

      IdText.Body.Add('Ol�, tudo bem? <br>');
      IdText.Body.Add('Voc� est� convocado para a reuni�o detalhada abaixo, solicitada por ' + vlQuerySIC.FieldByName('SOLICITANTE').AsString + '.<br>');
      IdText.Body.Add('Contamos com sua indispens�vel presen�a. At� l�! <br><br><br>');
      IdText.Body.Add('</p>');

      IdText.Body.Add('<p>');

      IdText.Body.Add('<b>Departamento:</b> ' + vlQuerySIC.FieldByName('DEPARTAMENTO').AsString + '<br> ');
      IdText.Body.Add('<b>Solicitante:</b> '  + vlQuerySIC.FieldByName('SOLICITANTE').AsString + '<br> ');
      IdText.Body.Add('<b>Pauta:</b> '        + vlQuerySIC.FieldByName('PAUTA').AsString + '<br>');
      IdText.Body.Add('<b>Data:</b> '         + vlQuerySIC.FieldByName('DATA').AsString + ' �s '
                                              + vlQuerySIC.FieldByName('HORA').AsString + '<br>');
      IdText.Body.Add('<b>Local:</b> '        + vlQuerySIC.FieldByName('REUNIAOLOCAL').AsString + '<br>');
      IdText.Body.Add('<b>Criticidade:</b> '  + vlQuerySIC.FieldByName('CRITICIDADE').AsString + '<br>');
      IdText.Body.Add('<b>Recurso(s):</b> '   + vlQuerySIC.FieldByName('RECURSO').AsString + '<br><br>');

      IdText.Body.Add('<b>Observa��o:</b> <br>');
      IdText.Body.Add(vlQuerySIC.FieldByName('OBS').AsString + '<br>');

      IdText.Body.Add('</p>');

      IdText.Body.Add('<hr>');

      IdText.Body.Add('<p> <b>Envolvidos:</b> <br>');
      vlQuerySIC.First;
      while not vlQuerySIC.Eof do
        begin
          IdText.Body.Add(vlQuerySIC.FieldByName('CONTATO').AsString + ' - ' +
                          vlQuerySIC.FieldByName('EMAIL').AsString + '<br>');
          vlQuerySIC.Next;
        end;

      IdText.Body.Add('<p>');

      IdText.Body.Add('</body>');
      IdText.Body.Add('</html>');
      IdText.ContentType := 'text/html; charset=iso-8859-1';

      //Prepara o Servidor
      IdSMTP                           := TIdSMTP.Create(Self);
      IdSMTP.IOHandler                 := IdSSLIOHandlerSocket;
      IdSMTP.UseTLS                    := utUseImplicitTLS;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Host                      := sHost;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Port                      := iPort;
      IdSMTP.Username                  := vEmail;
      IdSMTP.Password                  := vSenhaEmail;

      //Conecta e Autentica
      IdSMTP.Connect;
      IdSMTP.Authenticate;

      //Se a conex�o foi bem sucedida, envia a mensagem
      if IdSMTP.Connected then
      begin
        try
          IdSMTP.Send(idMsg);
        except on E:Exception do
          begin
            //showmessage('Erro ao tentar enviar: ' + E.Message);
          end;
        end;
      end;

      //Depois de tudo pronto, desconecta do servidor SMTP
      if IdSMTP.Connected then
        IdSMTP.Disconnect;

      Result := True;
    finally

      UnLoadOpenSSLLibrary;

      FreeAndNil(vlQuerySIC);
      FreeAndNil(idMsg);
      FreeAndNil(IdSSLIOHandlerSocket);
      FreeAndNil(idSMTP);
    end;
  except on e:Exception do
    begin
      Result := False;
    end;
  end;

end;

function Tdm1.fEnviaEmailRNC(const AAssunto, ADestino, AAnexo,
  prRNCID: String; prCdsCampos : TClientDataSet): Boolean;
var
  sHost                : String;
  iPort                : Integer;
  vEmail               : String;
  vSenhaEmail          : String;

  idMsg                : TIdMessage;
  IdText               : TIdText;
  idSMTP               : TIdSMTP;
  IdSSLIOHandlerSocket : TIdSSLIOHandlerSocketOpenSSL;

  vlQuerySIC           : TIBQuery;
  vlReprovacao         : String;

  vlRichEdit           : TDBRichEdit;
  vlDataSouce          : TDataSource;
begin
  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;

      Close;
      SQL.Text := 'select parametro, conteudo from tbparametros where parametro = ''EMAIL_ORCAMENTO_DE'' ';
      Open;
      vEmail := vlQuerySIC.FieldByName('CONTEUDO').AsString;

      Close;
      SQL.Text := 'select parametro, conteudo from tbparametros where parametro = ''EMAIL_ORCAMENTO_DE_S'' ';
      Open;
      vSenhaEmail := vlQuerySIC.FieldByName('CONTEUDO').AsString;
    end;

//    sHost          :='smtp.farmace.com.br';
    iPort          :=465;
    //modificado
    sHost          :='smtplw.com.br';

  try
    try

      //Configura os par�metros necess�rios para SSL
      IdSSLIOHandlerSocket                   := TIdSSLIOHandlerSocketOpenSSL.Create(Self);
      IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
      IdSSLIOHandlerSocket.SSLOptions.Mode  := sslmClient;

      //Vari�vel referente a mensagem
      idMsg                            := TIdMessage.Create(Self);
      idMsg.CharSet                    := 'utf-8';
      idMsg.Encoding                   := meMIME;
      idMsg.From.Name                  := 'SICFAR';
      //idMsg.From.Address               := vEmail;
      //modificado
      idMsg.From.Address               := 'sicfar@farmace.com.br';
      idMsg.Priority                   := mpNormal;
      idMsg.Subject                    := AAssunto;

      //Add Destinat�rio(s)
      idMsg.Recipients.Add;
      idMsg.Recipients.EMailAddresses := ADestino;

      //Vari�vel do texto
      IdText := TIdText.Create(idMsg.MessageParts);
      IdText.Body.Add('<html>');

      IdText.Body.Add('<head>');
      IdText.Body.Add('<link rel="stylesheet" type="text/css" '+
      'href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u">');
      IdText.Body.Add('</head>');

      IdText.Body.Add('<body  style="font-family: verdana; width: 800px">');
      idText.Body.Add('<img src="https://s3.amazonaws.com/cdn.freshdesk.com/data/helpdesk/attachments/production/12019185122/original/1Tsfmwb6Jl2oFV2n1VPPq95aaXgxdvM8TA.png?1495211856"/>');

      with vlQuerySIC do
        begin
          Close;
          SQL.Text := 'select * from tbrnc where deletado = ''N'' ';
          SQL.Add(' and rnc_id = ''' + prRNCID + ''' ');
          Open;
        end;

      vlReprovacao := vlQuerySIC.FieldByName('JUSTIFICATIVA_REPROVACAO').AsString;

      IdText.Body.Add('<h3><font color=''00A9C7''>');
      IdText.Body.Add('RNC - [' + Trim(vlQuerySIC.FieldByName('NUMERO').AsString
         + '/' + Trim(vlQuerySIC.FieldByName('ANO').AsString)) + ']');
      IdText.Body.Add('</font></h3> <br>');

      IdText.Body.Add('<p>');
      IdText.Body.Add('<b>N�mero Original: </b>' + Trim(vlQuerySIC.FieldByName('CODIGO_ORI').AsString) + '<br><br>');
//      IdText.Body.Add('<b>N�mero Atual: </b>'    + Trim(vlQuerySIC.FieldByName('NUMERO').AsString) + '/' + Trim(vlQuerySIC.FieldByName('ANO').AsString) +'<br>');
      IdText.Body.Add('<b>Detectado por: </b>'   + Trim(vlQuerySIC.FieldByName('DETECTADO_POR').AsString) + '<br>');
      IdText.Body.Add('<b>Departamento: </b>'    + Trim(vlQuerySIC.FieldByName('DEPARTAMENTO').AsString) + '<br>');
      IdText.Body.Add('<b>Origem: </b>'          + Trim(vlQuerySIC.FieldByName('ORIGEM').AsString) + '<br>');
      IdText.Body.Add('<b>Tipo: </b>'            + Trim(vlQuerySIC.FieldByName('ORIGEM_TIPO').AsString) + '<br>');
      IdText.Body.Add('<b>Data: </b>'            + Trim(vlQuerySIC.FieldByName('DATA_ABERTURA').AsString) + '<br>');
      IdText.Body.Add('<b>Grupo: </b>'           + Trim(vlQuerySIC.FieldByName('GRUPO').AsString) + '<br>');
      IdText.Body.Add('<b>Equipamento: </b>'     + Trim(vlQuerySIC.FieldByName('EQUIPAMENTO').AsString) + '<br>');
      IdText.Body.Add('<b>TAG: </b>'             + Trim(vlQuerySIC.FieldByName('EQUIPAMENTO_TAG').AsString) + '<br>');

      IdText.Body.Add('<b>Reincidente: </b>'   + Trim(vlQuerySIC.FieldByName('REINCIDENTE').AsString) + '<br>');
      IdText.Body.Add('<b>Classifica��o: </b>' + Trim(vlQuerySIC.FieldByName('CLASSIFICACAO').AsString) + '<br>');
      IdText.Body.Add('<b>A��o: </b>'          + Trim(vlQuerySIC.FieldByName('ACAO').AsString) + '<br><br>');

      with vlQuerySIC do
        begin
          Close;
          SQL.Text := 'select * from tbrnc_lote';
          SQL.Add(' where deletado = ''N'' ');
          SQL.Add(' and rnc_id = ''' + prRNCID + ''' ');
          SQL.Add(' and erp_produto is not null');
          Open;
        end;

      if not vlQuerySIC.IsEmpty then
        begin
          IdText.Body.Add('<b>Lote(s): </b><br>');

          IdText.Body.Add('<table class="table table-sm" style="font-size: 11px; font-family: verdana;">');
          IdText.Body.Add('<tr>');
          IdText.Body.Add('<thead>');
          IdText.Body.Add('<th scope="col" style="text-align: left;" style=" width: 60px;">Produto</th>');
          IdText.Body.Add('<th scope="col" style="text-align: left;">Descri��o do Produto</th>');
          IdText.Body.Add('<th scope="col" style="text-align: left;"style=" width: 60px;">Lote</th>');
          //IdText.Body.Add('<th scope="col" style="text-align: left;"style=" width: 60px;">Cliente</th>');
          IdText.Body.Add('<th scope="col" style="text-align: left;">Nome do Cliente</th>');
          //IdText.Body.Add('<th scope="col" style="text-align: left;"style=" width: 80px;">Fornecedor</th>');
          IdText.Body.Add('<th scope="col" style="text-align: left;">Nome do Fornecedor</th>');
          IdText.Body.Add('</thead>');
          IdText.Body.Add('</tr>');

          vlQuerySIC.First;
          while not vlQuerySIC.Eof do
            begin
              IdText.Body.Add('<tr>');
              IdText.Body.Add('<td style="text-align: left;">' + Trim(vlQuerySIC.FieldByName('ERP_PRODUTO').AsString) +'</td>');
              IdText.Body.Add('<td style="text-align: left;">' + Trim(vlQuerySIC.FieldByName('PRODUTO').AsString) +'</td>');
              IdText.Body.Add('<td style="text-align: left;">' + Trim(vlQuerySIC.FieldByName('LOTE').AsString) +'</td>');
              //IdText.Body.Add('<td style="text-align: left;">' + Trim(DS_LOTEERP_CLIENTE.AsString) +'</td>');
              IdText.Body.Add('<td style="text-align: left;">' + Trim(vlQuerySIC.FieldByName('CLIENTE').AsString) +'</td>');
              //IdText.Body.Add('<td style="text-align: left;">' + Trim(DS_LOTEERP_FORNECEDOR.AsString) +'</td>');
              IdText.Body.Add('<td style="text-align: left;">' + Trim(vlQuerySIC.FieldByName('FORNECEDOR').AsString) +'</td>');
              IdText.Body.Add('</tr>');

              vlQuerySIC.Next;
            end;
          IdText.Body.Add('</table>');
        end;

      with vlQuerySIC do
        begin
          Close;
          SQL.Text := 'select * from tbrnc where deletado = ''N'' ';
          SQL.Add(' and rnc_id = ''' + prRNCID + ''' ');
          Open;
        end;

      vlDataSouce := TDataSource.Create(Owner);
      vlDataSouce.DataSet := vlQuerySIC;
      vlRichEdit := TDBRichEdit.Create(Self);
      vlRichEdit.Parent := Application.MainForm;
      vlRichEdit.DataSource := vlDataSouce;


   //   IdText.Body.Add('<b>Descri��o: </b><br>' + Trim(vlQuerySIC.FieldByName('DESCRICAO').AsString) + '<br><br>');
      vlRichEdit.DataField := 'DESCRICAO';
      IdText.Body.Add('<b>Descri��o: </b><br>' + Trim(vlRichEdit.Text) + '<br><br>');
      vlRichEdit.DataField := 'DISPOSICAO';
      IdText.Body.Add('<b>Disposi��o: </b><br>' + Trim(vlRichEdit.Text) + '<br><br>');
      vlRichEdit.DataField := 'INVESTIGACAO';
      IdText.Body.Add('<b>Investiga��o: </b><br>' + Trim(vlRichEdit.Text) + '<br><br>');

      FreeAndNil(vlDataSouce);
      FreeAndNil(vlRichEdit);

      with vlQuerySIC do
        begin
          Close;
          SQL.Text := 'select * from tbrnc_aprovacao';
          SQL.Add(' where deletado = ''N'' ');
          SQL.Add(' and rnc_id = ''' + prRNCID + ''' ');
          Open;
        end;

      IdText.Body.Add('<b>Aprovadores:</b> <br>');

      vlQuerySIC.First;
      while not vlQuerySIC.Eof do
        begin
          IdText.Body.Add(vlQuerySIC.FieldByName('USUARIO').AsString + '<br>');
          vlQuerySIC.Next;
        end;

      if vlReprovacao <> '' then
        begin
          IdText.Body.Add('<br><br>');
          IdText.Body.Add('<b>Justificativa da Reprova��o:</b> <br>');
          IdText.Body.Add(vlReprovacao);
        end;

      IdText.Body.Add('</p>');
      IdText.Body.Add('<a href="192.168.0.8:8077/?form=RNC_APROVACAO&id=' + prRNCID+'">Aprovar RNC </a>');

      if not prCDSCampos.IsEmpty then
        begin
          prCDSCampos.First;

          IdText.Body.Add('<br>');
          IdText.Body.Add('<hr>');
          IdText.Body.Add('<p> Altera��es - ' + Usuario + '</p>');
          IdText.Body.Add('<table class="table table-sm" style="font-size: 11px; font-family: verdana;">');
          IdText.Body.Add('<tr>');
          IdText.Body.Add('<thead>');
          IdText.Body.Add('<th scope="col" style="text-align: left; width: 10%;">Campo</th>');
          IdText.Body.Add('<th scope="col" style="text-align: left; width: 40%;">De</th>');
          IdText.Body.Add('<th scope="col" style="text-align: left; width: 40%;">Para</th>');
          IdText.Body.Add('<th scope="col" style="text-align: left; width: 10%;">Descri��o</th>');
          IdText.Body.Add('</thead>');
          IdText.Body.Add('</tr>');
          while not prCDSCampos.Eof do
            begin
              IdText.Body.Add('<tr>');
              IdText.Body.Add('<td style="text-align: left;">' + Trim(prCDSCampos.FieldByName('CAMPO').AsString) +'</td>');
              IdText.Body.Add('<td style="text-align: left;">' + Trim(prCDSCampos.FieldByName('DE').AsString) +'</td>');
              IdText.Body.Add('<td style="text-align: left;">' + Trim(prCDSCampos.FieldByName('PARA').AsString) +'</td>');
              IdText.Body.Add('<td style="text-align: left;">' + Trim(prCDSCampos.FieldByName('DESCRICAO').AsString) +'</td>');
              IdText.Body.Add('</tr>');

              prCDSCampos.Next;
            end;
          IdText.Body.Add('</table>');
        end;

      IdText.Body.Add('</body>');
      IdText.Body.Add('</html>');
      IdText.ContentType := 'text/html; charset=iso-8859-1';

      //Prepara o Servidor
      IdSMTP                           := TIdSMTP.Create(Self);
      IdSMTP.IOHandler                 := IdSSLIOHandlerSocket;
      IdSMTP.UseTLS                    := utUseImplicitTLS;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Host                      := sHost;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Port                      := iPort;
//      IdSMTP.Username                  := vEmail;
//      IdSMTP.Password                  := vSenhaEmail;
      //modificado
      IdSMTP.Username                  := 'farmace';
      IdSMTP.Password                  := 'pobhsxux2793';


      //Conecta e Autentica
      IdSMTP.Connect;
      IdSMTP.Authenticate;

      if AAnexo <> EmptyStr then
        if FileExists(AAnexo) then
          TIdAttachmentFile.Create(idMsg.MessageParts, AAnexo);

      //Se a conex�o foi bem sucedida, envia a mensagem
      if IdSMTP.Connected then
      begin
        try
          IdSMTP.Send(idMsg);
        except on E:Exception do
          begin
            //showmessage('Erro ao tentar enviar: ' + E.Message);
          end;
        end;
      end;

      //Depois de tudo pronto, desconecta do servidor SMTP
      if IdSMTP.Connected then
        IdSMTP.Disconnect;

      Result := True;
    finally

      UnLoadOpenSSLLibrary;

      FreeAndNil(vlQuerySIC);
      FreeAndNil(idMsg);
      FreeAndNil(IdSSLIOHandlerSocket);
      FreeAndNil(idSMTP);
    end;
  except on e:Exception do
    begin
      Result := False;
    end;
  end;
end;

function Tdm1.fEnviaEmailReuniaoDiaria(const AAssunto, ADestino, AAnexo: String;
  prQuery: TIBQuery): Boolean;
var
  sHost                : String;
  iPort                : Integer;
  vEmail               : String;
  vSenhaEmail          : String;

  idMsg                : TIdMessage;
  IdText               : TIdText;
  idSMTP               : TIdSMTP;
  IdSSLIOHandlerSocket : TIdSSLIOHandlerSocketOpenSSL;

  vlQuerySIC           : TIBQuery;

begin

  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;

      Close;
      SQL.Text := 'select parametro, conteudo from tbparametros where parametro = ''EMAIL_ORCAMENTO_DE'' ';
      Open;
      vEmail := vlQuerySIC.FieldByName('CONTEUDO').AsString;

      Close;
      SQL.Text := 'select parametro, conteudo from tbparametros where parametro = ''EMAIL_ORCAMENTO_DE_S'' ';
      Open;
      vSenhaEmail := vlQuerySIC.FieldByName('CONTEUDO').AsString;
    end;

    sHost          :='smtp.farmace.com.br';
    iPort          :=465;

  try
    try
      //Configura os par�metros necess�rios para SSL
      IdSSLIOHandlerSocket                   := TIdSSLIOHandlerSocketOpenSSL.Create(Self);
      IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
      IdSSLIOHandlerSocket.SSLOptions.Mode  := sslmClient;

      //Vari�vel referente a mensagem
      idMsg                            := TIdMessage.Create(Self);
      idMsg.CharSet                    := 'utf-8';
      idMsg.Encoding                   := meMIME;
      idMsg.From.Name                  := 'Reuni�o - FARMACE';
      idMsg.From.Address               := 'naoresponda@farmace.com.br';//vEmail ;
      idMsg.Priority                   := mpNormal;
      idMsg.Subject                    := AAssunto;

      //Add Destinat�rio(s)
      idMsg.Recipients.Add;
      idMsg.Recipients.EMailAddresses := ADestino;

      //Vari�vel do texto
      IdText := TIdText.Create(idMsg.MessageParts);
      IdText.Body.Add('<html>');

      IdText.Body.Add('<head>');
      //IdText.Body.Add('<link rel="stylesheet" type="text/css" '+
      //'href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u">');
      IdText.Body.Add('</head>');
      IdText.Body.Add('<body  style="font-family: verdana; width: 800px">');
      idText.Body.Add('<img src="https://s3.amazonaws.com/cdn.freshdesk.com/data/helpdesk/attachments/production/12019185122/original/1Tsfmwb6Jl2oFV2n1VPPq95aaXgxdvM8TA.png?1495211856"/>');
      IdText.Body.Add('<h3><font color=''00A9C7''>');
      IdText.Body.Add('');
      IdText.Body.Add('</font></h3> <br>');

      IdText.Body.Add('<p style="font-size: 12px;">');
      IdText.Body.Add('Ol�! Fique atento �s suas pr�ximas reuni�es, conforme detalhado abaixo:<br><br>');
    //  IdText.Body.Add(prParametros);
      IdText.Body.Add('</p>');

      IdText.Body.Add('<table border = 1 class="table table-sm" style="font-size: 11px; font-family: verdana; border-collapse: collapse;">');
      IdText.Body.Add('<tr>');
      IdText.Body.Add('<thead>');
      IdText.Body.Add('<th scope="col" style="text-align: left;">Reuniao ID</th>');
      IdText.Body.Add('<th scope="col" style="text-align: left;">Data Hora</th>');
      IdText.Body.Add('<th scope="col" style="text-align: left;">Pauta</th>');
      IdText.Body.Add('<th scope="col" style="text-align: left;">Solicitante</th>');
      IdText.Body.Add('<th scope="col" style="text-align: left;">Local</th>');
      IdText.Body.Add('<th scope="col" style="text-align: left;">Envolvidos</th>');
      IdText.Body.Add('</thead>');
      IdText.Body.Add('</tr>');

      prQuery.First;
      while not prQuery.Eof do
        begin
          with vlQuerySIC do
            begin
              Close;
              SQL.Text := 'select';
              SQL.Add(' r.reuniao_id, r.data, r.hora, r.solicitante,');
              SQL.Add(' r.pauta, r.reuniaolocal, r.obs, r.solicitante_email, ');
              SQL.Add(' c.contato, c.email');
              SQL.Add(' from tbreuniao r');
              SQL.Add(' left join tbreuniao_contato c on c.reuniao_id = r.reuniao_id and c.deletado = ''N'' ');
              SQL.Add(' where r.deletado = ''N'' ');
              SQL.Add(' and r.reuniao_id = ''' + prQuery.FieldByName('REUNIAO_ID').AsString + ''' ');
              Open;
            end;

          IdText.Body.Add('<tr>');
          IdText.Body.Add('<td style="text-align: left; width: 80px;">'  + vlQuerySIC.FieldByName('REUNIAO_ID').AsString + '</td>');
          IdText.Body.Add('<td style="text-align: left; width: 150px;">'  + vlQuerySIC.FieldByName('DATA').AsString + ' ' + vlQuerySIC.FieldByName('HORA').AsString +'</td>');
          IdText.Body.Add('<td style="text-align: left; width: 200px;">'  + vlQuerySIC.FieldByName('PAUTA').AsString + '</td>');
          IdText.Body.Add('<td style="text-align: left; width: 130px;">'  + vlQuerySIC.FieldByName('SOLICITANTE').AsString + '</td>');
          IdText.Body.Add('<td style="text-align: left; width: 130px;">'  + vlQuerySIC.FieldByName('REUNIAOLOCAL').AsString + '</td>');
          IdText.Body.Add('<td style="text-align: left; width: 350px;">');

          vlQuerySIC.First;
          while not vlQuerySIC.Eof do
            begin
              IdText.Body.Add(vlQuerySIC.FieldByName('CONTATO').AsString + '(' + vlQuerySIC.FieldByName('EMAIL').AsString + ')' + '<br>');
              vlQuerySIC.Next;
            end;

          IdText.Body.Add('</td>');
          IdText.Body.Add('</tr>');

          prQuery.Next;
        end;

      IdText.Body.Add('</table>');

      IdText.Body.Add('</body>');
      IdText.Body.Add('</html>');
      IdText.ContentType := 'text/html; charset=iso-8859-1';

      //Prepara o Servidor
      IdSMTP                           := TIdSMTP.Create(Self);
      IdSMTP.IOHandler                 := IdSSLIOHandlerSocket;
      IdSMTP.UseTLS                    := utUseImplicitTLS;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Host                      := sHost;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Port                      := iPort;
      IdSMTP.Username                  := vEmail;
      IdSMTP.Password                  := vSenhaEmail;

      //Conecta e Autentica
      IdSMTP.Connect;
      IdSMTP.Authenticate;

      if AAnexo <> EmptyStr then
        if FileExists(AAnexo) then
          TIdAttachmentFile.Create(idMsg.MessageParts, AAnexo);

      //Se a conex�o foi bem sucedida, envia a mensagem
      if IdSMTP.Connected then
      begin
        try
          IdSMTP.Send(idMsg);
        except on E:Exception do
          begin
            //showmessage('Erro ao tentar enviar: ' + E.Message);
          end;
        end;
      end;

      //Depois de tudo pronto, desconecta do servidor SMTP
      if IdSMTP.Connected then
        IdSMTP.Disconnect;

      Result := True;
    finally

      UnLoadOpenSSLLibrary;

      FreeAndNil(vlQuerySIC);
      FreeAndNil(idMsg);
      FreeAndNil(IdSSLIOHandlerSocket);
      FreeAndNil(idSMTP);
    end;
  except on e:Exception do
    begin
      Result := False;
    end;
  end;
end;

function Tdm1.fEnviarEmailValidadeLote(const AAssunto, ADestino,
  AAnexo, prParametros: String; prQuery : TADOQuery): Boolean;
var
  sHost                : String;
  iPort                : Integer;
  vEmail               : String;
  vSenhaEmail          : String;

  idMsg                : TIdMessage;
  IdText               : TIdText;
  idSMTP               : TIdSMTP;
  IdSSLIOHandlerSocket : TIdSSLIOHandlerSocketOpenSSL;

  vlQuerySIC           : TIBQuery;

begin

  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;

      Close;
      SQL.Text := 'select parametro, conteudo from tbparametros where parametro = ''EMAIL_ORCAMENTO_DE'' ';
      Open;
      vEmail := vlQuerySIC.FieldByName('CONTEUDO').AsString;

      Close;
      SQL.Text := 'select parametro, conteudo from tbparametros where parametro = ''EMAIL_ORCAMENTO_DE_S'' ';
      Open;
      vSenhaEmail := vlQuerySIC.FieldByName('CONTEUDO').AsString;
    end;

    sHost          :='smtp.farmace.com.br';
    iPort          :=465;

  try
    try
      //Configura os par�metros necess�rios para SSL
      IdSSLIOHandlerSocket                   := TIdSSLIOHandlerSocketOpenSSL.Create(Self);
      IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
      IdSSLIOHandlerSocket.SSLOptions.Mode  := sslmClient;

      //Vari�vel referente a mensagem
      idMsg                            := TIdMessage.Create(Self);
      idMsg.CharSet                    := 'utf-8';
      idMsg.Encoding                   := meMIME;
      idMsg.From.Name                  := 'Validade Lote - FARMACE';
      idMsg.From.Address               := vEmail;
      idMsg.Priority                   := mpNormal;
      idMsg.Subject                    := AAssunto;

      //Add Destinat�rio(s)
      idMsg.Recipients.Add;
      idMsg.Recipients.EMailAddresses := ADestino;

      //Vari�vel do texto
      IdText := TIdText.Create(idMsg.MessageParts);
      IdText.Body.Add('<html>');

      IdText.Body.Add('<head>');
      //IdText.Body.Add('<link rel="stylesheet" type="text/css" '+
      //'href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u">');
      IdText.Body.Add('</head>');
      IdText.Body.Add('<body  style="font-family: verdana; width: 800px">');
      idText.Body.Add('<img src="https://s3.amazonaws.com/cdn.freshdesk.com/data/helpdesk/attachments/production/12019185122/original/1Tsfmwb6Jl2oFV2n1VPPq95aaXgxdvM8TA.png?1495211856"/>');
      IdText.Body.Add('<h3><font color=''00A9C7''>');
      IdText.Body.Add('VALIDADE DOS LOTES');
      IdText.Body.Add('</font></h3> <br>');

      IdText.Body.Add('<p style="font-size: 12px;">');
      IdText.Body.Add('Ol�! Segue em anexo o relat�rio de Validade dos lotes de acordo com os par�metros abaixo:<br><br>');
      IdText.Body.Add(prParametros);
      IdText.Body.Add('</p>');

      IdText.Body.Add('<table class="table table-sm" style="font-size: 11px; font-family: verdana; border: 1px">');
      IdText.Body.Add('<tr>');
      IdText.Body.Add('<thead>');
      IdText.Body.Add('<th scope="col" style="text-align: left; width: 30px;">C�digo</th>');
      IdText.Body.Add('<th scope="col" style="text-align: left; width: 200px;">Produto</th>');
      IdText.Body.Add('<th scope="col" style="text-align: left; width: 40px;">UM</th>');
      IdText.Body.Add('<th scope="col" style="text-align: left; width: 60px;">Lote</th>');
      IdText.Body.Add('<th scope="col" style="text-align: left; width: 60px;">Fabrica��o</th>');
      IdText.Body.Add('<th scope="col" style="text-align: left; width: 60px;">Validade</th>');
      IdText.Body.Add('<th scope="col" style="text-align: left; width: 60px;">Local</th>');
      IdText.Body.Add('<th scope="col" style="text-align: left; width: 60px;">Estoque</th>');
      IdText.Body.Add('<th scope="col" style="text-align: left; width: 60px;">Saldo</th>');
      IdText.Body.Add('</thead>');
      IdText.Body.Add('</tr>');

      prQuery.First;
      while not prQuery.Eof do
        begin
          IdText.Body.Add('<tr>');
          IdText.Body.Add('<td style="text-align: left;">'  + prQuery.FieldByName('CODIGO').AsString + '</td>');
          IdText.Body.Add('<td style="text-align: left;">'  + prQuery.FieldByName('PRODUTO').AsString + '</td>');
          IdText.Body.Add('<td style="text-align: left;">'  + prQuery.FieldByName('UM').AsString + '</td>');
          IdText.Body.Add('<td style="text-align: left;">'  + prQuery.FieldByName('LOTE').AsString + '</td>');
          IdText.Body.Add('<td style="text-align: left;">'  + prQuery.FieldByName('FABRICACAO').AsString + '</td>');
          IdText.Body.Add('<td style="text-align: left;">'  + prQuery.FieldByName('VALIDADE').AsString + '</td>');
          IdText.Body.Add('<td style="text-align: left;">'  + prQuery.FieldByName('ARM').AsString + '</td>');
          IdText.Body.Add('<td style="text-align: left;">'  + prQuery.FieldByName('ESTOQUE').AsString + '</td>');
          IdText.Body.Add('<td style="text-align: right;">' + prQuery.FieldByName('SALDO').AsString + '</td>');
          IdText.Body.Add('</tr>');

          prQuery.Next;
        end;

      IdText.Body.Add('</table>');

      IdText.Body.Add('</body>');
      IdText.Body.Add('</html>');
      IdText.ContentType := 'text/html; charset=iso-8859-1';

      //Prepara o Servidor
      IdSMTP                           := TIdSMTP.Create(Self);
      IdSMTP.IOHandler                 := IdSSLIOHandlerSocket;
      IdSMTP.UseTLS                    := utUseImplicitTLS;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Host                      := sHost;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Port                      := iPort;
      IdSMTP.Username                  := vEmail;
      IdSMTP.Password                  := vSenhaEmail;

      //Conecta e Autentica
      IdSMTP.Connect;
      IdSMTP.Authenticate;

      if AAnexo <> EmptyStr then
        if FileExists(AAnexo) then
          TIdAttachmentFile.Create(idMsg.MessageParts, AAnexo);

      //Se a conex�o foi bem sucedida, envia a mensagem
      if IdSMTP.Connected then
      begin
        try
          IdSMTP.Send(idMsg);
        except on E:Exception do
          begin
            //showmessage('Erro ao tentar enviar: ' + E.Message);
          end;
        end;
      end;

      //Depois de tudo pronto, desconecta do servidor SMTP
      if IdSMTP.Connected then
        IdSMTP.Disconnect;

      Result := True;
    finally

      UnLoadOpenSSLLibrary;

      FreeAndNil(vlQuerySIC);
      FreeAndNil(idMsg);
      FreeAndNil(IdSSLIOHandlerSocket);
      FreeAndNil(idSMTP);
    end;
  except on e:Exception do
    begin
      Result := False;
    end;
  end;
end;

function Tdm1.fPerfilRotina(prUsuarioID, prRotina: string): Boolean;
var
  vlqPerfil : TIBQuery;
begin
  vlqPerfil := TIBQuery.Create(Owner);
  with vlqPerfil do
    begin
      Database    := IBDatabase1;
      Transaction := IBTransaction1;

      Close;
      SQL.Text := 'select';
      SQL.Add(' p.perfil_id,  p.rotina, u.usuario_id, p.acesso');
      SQL.Add(' from tbperfil_rotina p');
      SQL.Add(' inner join tbusuario u on u.perfil_id = p.perfil_id and u.deletado = ''N'' ');
      SQL.Add(' where p.deletado = ''N'' ');

      SQL.Add(' and u.usuario_id = ''' + prUsuarioID + ''' ');

      SQL.Add(' and p.rotina = ''' + prRotina + ''' ');

      Open;
    end;

  if vlqPerfil.FieldByName('ACESSO').AsString <> 'S' then
    Result := False
  else
    Result := True;

  FreeAndNil(vlqPerfil);
end;

function Tdm1.fRetornaCampoTabela(prCampo, prTabela, prCampoWhere,
  prValorWhere: String): String;
var
  vlQuerySIC : TIBQuery;
begin
  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;
      Close;
      SQL.Text := 'select ' + prCampo + ' from ' + prTabela;
      SQL.Add(' where deletado = ''N'' ');
      SQL.Add(' and ' + prCampoWhere + ' = ''' + prValorWhere + ''' ');
      Open;
    end;

  Result := vlQuerySIC.FieldByName(prCampo).AsString;

  FreeAndNil(vlQuerySIC);
end;

function Tdm1.fRetornaCampoUsuario(prUsuarioID, prCampo: string): String;
var
  vQuery: TIBQuery;
begin
  vQuery := TIBQuery.Create(Owner);
  with vQuery do
    begin
      Database    := IBDatabase1;
      Transaction := IBTransaction1;

      Close;
      SQL.Text := 'select ' + prCampo + ' from tbusuario where deletado = ''N''';
      SQL.Add(' and usuario_id = ''' + prUsuarioID + ''' ');
      Open;
    end;

  Result := Trim(vQuery.FieldByName(prCampo).AsString);

  FreeAndNil(vQuery);
end;

function Tdm1.fRetornaDepartamento(prDepartamentoID: String): String;
var
  vlQuerySIC : TIBQuery;
begin
  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;
      Close;
      SQL.Text := 'select departamento from tbdepartamento where deletado = ''N'' ';
      SQL.Add(' and departamento_id = ''' + prDepartamentoID + ''' ');
      Open;
    end;

  Result := Trim(vlQuerySIC.FieldByName('DEPARTAMENTO').AsString);

  FreeAndNil(vlQuerySIC);
end;

function Tdm1.fRetornaEquipe(prEquipeID: String): String;
var
  vlQuerySIC : TIBQuery;
begin
  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;
      Close;
      SQL.Text := 'select equipe from tbequipe where deletado = ''N'' ';
      SQL.Add(' and equipe_id = ''' + prEquipeID + ''' ');
      Open;
    end;

  Result := Trim(vlQuerySIC.FieldByName('EQUIPE').AsString);

  FreeAndNil(vlQuerySIC);
end;

function Tdm1.fRetornaEtiquetaAmostraImpressa(prAmostraID: String): Boolean;
var
  vlVolumes, vlImpressos : Integer;
begin
  with QR_AMOSTRA do
    begin
      Close;
      SQL.Text := 'select count(v.amostravolume_id) from tbamostra_volume v';
      SQL.Add(' where v.deletado = ''N'' ');
      SQL.Add(' and v.amostra_id = ''' + prAmostraID + ''' ');
      Open;
    end;
  vlVolumes := QR_AMOSTRA.FieldByName('COUNT').AsInteger;

  with QR_AMOSTRA do
    begin
      Close;
      SQL.Text := 'select count(v.amostravolume_id) from tbamostra_volume v';
      SQL.Add(' where v.deletado = ''N'' ');
      SQL.Add(' and v.amostra_id = ''' + prAmostraID + ''' ');
      SQL.Add(' and v.impresso = ''S'' ');
      Open;
    end;
  vlImpressos := QR_AMOSTRA.FieldByName('COUNT').AsInteger;

  if vlVolumes = vlImpressos then
    Result := True
  else
    Result := False;
end;

function Tdm1.fRetornaGrupoAtividade(prGrupoID: String): String;
var
  vlQuerySIC : TIBQuery;
begin
  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;
      Close;
      SQL.Text := 'select grupo from tbchamado_grupo where deletado = ''N'' ';
      SQL.Add(' and grupo_id = ''' + prGrupoID + ''' ');
      Open;
    end;

  Result := Trim(vlQuerySIC.FieldByName('GRUPO').AsString);

  FreeAndNil(vlQuerySIC);
end;

function Tdm1.fRetornaMaxPedido(prUsuarioID: String): Integer;
var
  qPedido : TIBQuery;
begin
  qPedido := TIBQuery.Create(Owner);
  with qPedido do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;
      Close;
      SQL.Text := 'select coalesce(max(substring(codigo from 7 for 12)),0) as maximo from tbpedido';
      SQl.Add(' where deletado = ''N'' ');
      SQL.Add(' and codigo like ''P0121%'' ');
      //SQL.Add(' and usuario_i = ''' + prUsuarioID + ''' ');
      Open;
    end;

  Result := qPedido.FieldByName('MAXIMO').AsInteger + 1;
  FreeAndNil(qPedido);
end;

function Tdm1.fRetornaSolicitante(prSolicitanteID: String): String;
var
  vlQuerySIC : TIBQuery;
begin
  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;
      Close;
      SQL.Text := 'select contato from tbcontato where deletado = ''N'' ';
      SQL.Add(' and contato_id = ''' + prSolicitanteID + ''' ');
      Open;
    end;

  Result := Trim(vlQuerySIC.FieldByName('CONTATO').AsString);

  FreeAndNil(vlQuerySIC);
end;

function Tdm1.fRetornaSolicitanteEmail(prSolicitanteID: String): String;
var
  vlQuerySIC : TIBQuery;
begin
  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;
      Close;
      SQL.Text := 'select email from tbcontato where deletado = ''N'' ';
      SQL.Add(' and contato_id = ''' + prSolicitanteID + ''' ');
      Open;
    end;

  Result := Trim(vlQuerySIC.FieldByName('EMAIL').AsString);

  FreeAndNil(vlQuerySIC);
end;

function Tdm1.fRetornaStatusCAPA(prCAPAID: String): String;
var
  vlQuerySIC : TIBQuery;
  vlStatus : String;
  vlContAberto : integer;
begin
  vlStatus := '';
  vlContAberto := 0;

  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;
      Close;
      SQL.Text := 'select * from tbrnc_capa_item where deletado = ''N'' ';
      SQL.Add(' and rnccapa_id = ''' + prCAPAID + ''' ');
      Open;
    end;

  if not vlQuerySIC.IsEmpty then
    begin
      vlQuerySIC.First;
      while not vlQuerySIC.Eof do
        begin
          if (((vlQuerySIC.FieldByName('REVISAO1_SATISFATORIO').AsString = 'SIM') and
              (vlQuerySIC.FieldByName('REVISAO2_SATISFATORIO').AsString = 'SIM' )and
              (vlQuerySIC.FieldByName('REVISAO3_SATISFATORIO').AsString = 'SIM') and
              (vlQuerySIC.FieldByName('REVISAO4_SATISFATORIO').AsString = 'SIM')) or
              (vlQuerySIC.FieldByName('REVISAO1_SATISFATORIO').AsString = 'N/A')) then
            vlStatus := 'Encerrado'
          else
            vlContAberto := vlContAberto + 1;
          vlQuerySIC.Next;
        end;

      if vlContAberto > 0 then
        vlStatus := 'Aberto';
    end
  else
    vlStatus := 'Aberto';

  FreeAndNil(vlQuerySIC);
  Result := vlStatus;
end;

function Tdm1.fRetornaTipoAtividade(prTipoID, prGrupoID: String): String;
var
  vlQuerySIC : TIBQuery;
begin
  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;
      Close;
      SQL.Text := 'select tipo from tbchamado_tipo where deletado = ''N'' ';
      SQL.Add(' and tipo_id = ''' + prTipoID + ''' ');

      if prGrupoID <> '' then
        SQL.Add(' and grupo_id = ''' + prGrupoID + ''' ');
      Open;
    end;

  Result := Trim(vlQuerySIC.FieldByName('TIPO').AsString);

  FreeAndNil(vlQuerySIC);
end;

procedure Tdm1.pAtualizaStatusEquipamentoIndividual(prEquipamentoID: String);
var
  vlQueryEquipamento, vlQueryUpdate : TIBQuery;
  vlStatus : String;
begin
  vlQueryEquipamento := TIBQuery.Create(Owner);
  with vlQueryEquipamento do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;
      Close;
      SQL.Text := 'select * from tbequipamento where deletado = ''N'' ' ;
      SQL.Add(' and equipamento_id = ''' + prEquipamentoID + ''' ');
      SQl.Add(' and desativado is null ');
      Open;
    end;

  if not vlQueryEquipamento.IsEmpty then
    begin
      if Trim(vlQueryEquipamento.FieldByName('NUMERO_CERTIFICADO').AsString) = '' then
        vlStatus := 'PENDENTE'
      else
        begin
          if Trim(vlQueryEquipamento.FieldByName('NUMERO_CERTIFICADO').AsString) = 'N�o se Aplica' then
            vlStatus := 'OK'
          else
            begin
              if vlQueryEquipamento.FieldByName('PROXIMA_CALIBRACAO').AsDateTime >= Date  then
                vlStatus := 'OK'
              else
                vlStatus := 'VENCIDO';
            end;
        end;

      vlQueryUpdate := TIBQuery.Create(Owner);
      with vlQueryUpdate do
        begin
          Database    := dm1.IBDatabase1;
          Transaction := dm1.IBTransaction1;
          Close;

          SQL.Text := 'update tbequipamento set';
          SQL.Add(' situacao = ''' + vlStatus + ''' ');
          SQL.Add(' where deletado = ''N'' ');
          SQL.Add(' and equipamento_id = ''' + prEquipamentoID + ''' ');

          ExecSQL;
          Transaction.CommitRetaining;
        end;
      FreeAndNil(vlQueryUpdate);
    end;

  FreeAndNil(vlQueryEquipamento);
end;

function Tdm1.fRetornaUsuario(prUsuarioID: String): String;
var
  vlQuerySIC : TIBQuery;
begin
  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;
      Close;
      SQL.Text := 'select nome from tbusuario where deletado = ''N'' ';
      SQL.Add(' and usuario_id = ''' + prUsuarioID + ''' ');
      Open;
    end;

  Result := Trim(vlQuerySIC.FieldByName('NOME').AsString);

  FreeAndNil(vlQuerySIC);
end;

function Tdm1.fRetornaUsuarioDepto(prUsuarioID: String): String;
var
  vlQuerySIC : TIBQuery;
begin
  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;

      Close;
      SQL.Text := 'select departamento_id, departamento from tbusuario';
      SQL.Add(' where deletado = ''N'' ');
      SQL.Add(' and usuario_id = ''' + prUsuarioID + ''' ');
      Open;
    end;

  if not vlQuerySIC.IsEmpty then
    Result := vlQuerySIC.FieldByName('DEPARTAMENTO_ID').AsString + ';' + vlQuerySIC.FieldByName('DEPARTAMENTO').AsString
  else
    Result := '';

  FreeAndNil(vlQuerySIC);
end;

function Tdm1.fRetornaUsuarioEmail(prUsuarioID: String): String;
var
  vlQuerySIC : TIBQuery;
begin
  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;
      Close;
      SQL.Text := 'select email from tbusuario where deletado = ''N'' ';
      SQL.Add(' and usuario_id = ''' + prUsuarioID + ''' ');
      Open;
    end;

  Result := Trim(vlQuerySIC.FieldByName('EMAIL').AsString);

  FreeAndNil(vlQuerySIC);
end;

procedure Tdm1.Get_Build_Info(var v1, v2, v3, v4: Word);
var
  ver_infosize,
  ver_valuesize,
  dummy          : DWord;
  ver_info       : Pointer;
  ver_value      : PVSFixedFileInfo;
begin
  ver_infosize := GetFileVersionInfoSize(PChar(ParamStr(0)), dummy);
  GetMem(ver_info, ver_infosize);
  GetFileVersionInfo(PChar(ParamStr(0)), 0, ver_infosize, ver_info);
  VerQueryValue(ver_info, '\', Pointer(ver_value), ver_valuesize);
  With ver_value^ do begin
    v1 := dwFileVersionMS shr 16;
    v2 := dwFileVersionMS and $FFFF;
    v3 := dwFileVersionLS shr 16;
    v4 := dwFileVersionLS and $FFFF;
  end;
  FreeMem(ver_info, ver_infosize);
end;

function Tdm1.Get_Versao: String;
var
  v1, v2, v3, v4 : Word;
begin
  Get_build_info(v1, v2, v3, v4);
  Result := IntToStr(v1) + '.' +
            IntToStr(v2) + '.' +
            IntToStr(v3) + '.' +
            IntToStr(v4);
end;

procedure Tdm1.IBDatabase1AfterConnect(Sender: TObject);
var
  qUser: TIBQuery;
begin
  qUser := TIBQuery.Create(self);
  try
    with qUser do
      begin
        Database    := dm1.IBDatabase1;
        Transaction := dm1.IBTransaction1;

        Close;
        SQL.Text := 'SELECT RDB$SET_CONTEXT(''USER_SESSION'',''USUARIOLOGADO'',''Servidor'')';
        SQL.Add(' FROM RDB$DATABASE');
        Open;
      end;
  finally
    qUser.Free;
  end;
end;

procedure Tdm1.pAtualizaStatusEquipamentos;
var
  vlQuerySIC : TIBQuery;
begin
  vlQuerySIC := TIBQuery.Create(Owner);

  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;
      Close;
      SQL.Text := 'update tbequipamento set';
      SQL.Add(' situacao = ''PENDENTE'' ');
      SQL.Add(' where deletado = ''N'' ');
      SQL.Add(' and numero_certificado is null');
      SQL.Add(' and desativado is null ');
      ExecSQL;
      Transaction.CommitRetaining;
    end;

  with vlQuerySIC do
    begin
      Close;
      SQL.Text := 'update tbequipamento set';
      SQL.Add(' situacao = ''OK'' ');
      SQL.Add(' where deletado = ''N'' ');
      SQL.Add(' and lower(numero_certificado) = ''n�o se aplica'' ');
      SQL.Add(' and desativado is null ');
      ExecSQL;
      Transaction.CommitRetaining;
    end;

  with vlQuerySIC do
    begin
      Close;
      SQL.Text := 'update tbequipamento set';
      SQL.Add(' situacao = ''OK'' ');
      SQL.Add(' where deletado = ''N'' ');
      SQL.Add(' and numero_certificado is not null');
      SQL.Add(' and proxima_calibracao >= ''' + FormatDateTime('DD.MM.YYYY', Date) + ''' ');
      SQL.Add(' and desativado is null ');
      ExecSQL;
      Transaction.CommitRetaining;
    end;

  with vlQuerySIC do
    begin
      Close;
      SQL.Text := 'update tbequipamento set';
      SQL.Add(' situacao = ''VENCIDO'' ');
      SQL.Add(' where deletado = ''N'' ');
      SQL.Add(' and numero_certificado is not null');
      SQL.Add(' and proxima_calibracao < ''' + FormatDateTime('DD.MM.YYYY', Date) + ''' ');
      SQL.Add(' and desativado is null ');
      ExecSQL;
      Transaction.CommitRetaining;
    end;

  FreeAndNil(vlQuerySIC);
end;

procedure Tdm1.pAtualizaStatusFrequenciaTreinamento(prTreinamentoID : String);
var
  vlQuerySIC : TIBQuery;
  vlTotalParticipantes, vlTotalFrequencia : Integer;
begin
  vlQuerySIC := TIBQuery.Create(Owner);

  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;
      Close;
      SQL.Text := 'select count(*) from tbtreinamento_item i';
      SQL.Add(' where i.deletado = ''N'' ');
      SQL.Add(' and i.treinamento_id = ''' + prTreinamentoID + ''' ');
      Open;
    end;

  vlTotalParticipantes := vlQuerySIC.FieldByName('COUNT').AsInteger;

  with vlQuerySIC do
    begin
      Close;
      SQL.Text := 'select count(*) from tbtreinamento_item i';
      SQL.Add(' where i.deletado = ''N'' ');
      SQL.Add(' and i.treinamento_id = ''' + prTreinamentoID + ''' ');
      SQL.Add(' and i.frequencia is not null');
      Open;
    end;

  vlTotalFrequencia := vlQuerySIC.FieldByName('COUNT').AsInteger;

  if not (vlTotalParticipantes = 0) then
    begin
      with vlQuerySIC do
        begin
          Close;
          SQL.Text := 'update tbtreinamento t set';

          if vlTotalParticipantes = vlTotalFrequencia then
            SQL.Add(' t.status_frequencia = ''OK'' ')
          else
            SQL.Add(' t.status_frequencia = ''Pendente'' ');

          SQL.Add(' where t.deletado = ''N'' ');
          SQL.Add(' and t.treinamento_id = ''' + prTreinamentoID + ''' ');
          ExecSQL;
          Transaction.CommitRetaining;
        end;
    end
  else
    begin
      with vlQuerySIC do
        begin
          Close;
          SQL.Text := 'update tbtreinamento t set';
          SQL.Add(' t.status_frequencia = ''Pendente'' ');
          SQL.Add(' where t.deletado = ''N'' ');
          SQL.Add(' and t.treinamento_id = ''' + prTreinamentoID + ''' ');
          ExecSQL;
          Transaction.CommitRetaining;
        end;
    end;

  FreeAndNil(vlQuerySIC);
end;

procedure Tdm1.pAtualizaStatusRealizadoTreinamento(prTreinamentoID : String);
var
  vlQuerySIC : TIBQuery;
begin
  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;
      Close;

      SQL.Text := 'update tbtreinamento t set';
      SQL.Add(' t.status_realizado = ''N�o Realizado'' ');
      SQL.Add(' where t.deletado = ''N'' ');

      if prTreinamentoID <> '' then
        SQL.Add(' and treinamento_id = ''' + prTreinamentoID + ''' ');

      SQL.Add(' and (current_date - t.data_prevista) > 10');
      SQL.Add(' and t.data is null');

      ExecSQL;
      Transaction.CommitRetaining;
    end;

  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;
      Close;

      SQL.Text := 'update tbtreinamento t set';
      SQL.Add(' t.status_realizado = ''N�o Realizado'' ');
      SQL.Add(' where t.deletado = ''N'' ');

      if prTreinamentoID <> '' then
        SQL.Add(' and treinamento_id = ''' + prTreinamentoID + ''' ');

      SQL.Add(' and t.data_prevista is null');
      SQL.Add(' and t.data is null');

      ExecSQL;
      Transaction.CommitRetaining;
    end;

  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;
      Close;

      SQL.Text := 'update tbtreinamento t set';
      SQL.Add(' t.status_realizado = ''Aguardando'' ');
      SQL.Add(' where t.deletado = ''N'' ');

      if prTreinamentoID <> '' then
        SQL.Add(' and treinamento_id = ''' + prTreinamentoID + ''' ');

      SQL.Add(' and (current_date - t.data_prevista) <= 10');
      SQL.Add(' and t.data is null');

      ExecSQL;
      Transaction.CommitRetaining;
    end;

  with vlQuerySIC do
    begin
      Close;

      SQL.Text := 'update tbtreinamento t set';
      SQL.Add(' t.status_realizado = ''Realizado'' ');
      SQL.Add(' where t.deletado = ''N'' ');

      if prTreinamentoID <> '' then
        SQL.Add(' and treinamento_id = ''' + prTreinamentoID + ''' ');

      SQL.Add(' and t.data is not null');

      ExecSQL;
      Transaction.CommitRetaining;
    end;

  FreeAndNil(vlQuerySIC);
end;

procedure Tdm1.pCapaIntegraAtividade(prTipo, prCapaID, prCapaItemId: String);
begin
end;

procedure Tdm1.pGeraAtividadeProgramada;
var
  vlQuerySIC, vlQueryUpdate, vlQueryAtividade : TIBQuery;
  x: integer;
  campo : string;
begin
  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;
      Close;
      SQL.Text := 'select conteudo from tbparametros';
      SQL.Add(' where parametro = ''ATIVIDADE_PROGRAMADA'' ');
      Open;
    end;

  if vlQuerySIC.FieldByName('CONTEUDO').AsDateTime < Date then
    begin
      vlQueryUpdate := TIBQuery.Create(Owner);
      with vlQueryUpdate do
        begin
          Database    := dm1.IBDatabase1;
          Transaction := dm1.IBTransaction1;
          Close;
          SQL.Text := 'update tbparametros set';
          SQL.Add(' conteudo = ''' + FormatDateTime('DD/MM/YYYY', Date) + ''' ');
          SQL.Add(' where parametro = ''ATIVIDADE_PROGRAMADA'' ');
          ExecSQL;
          Transaction.CommitRetaining;
        end;

      with vlQuerySIC do
        begin
          Close;
          SQL.Text := 'select * from tbchamado_programado p';
          SQL.Add(' where p.deletado = ''N'' ');
          SQL.Add(' and p.data = current_date');
          Open;
        end;

      if not vlQuerySIC.IsEmpty then
        begin
          vlQueryAtividade := TIBQuery.Create(Owner);
          with vlQueryAtividade do
            begin
              Database    := dm1.IBDatabase1;
              Transaction := dm1.IBTransaction1;
            end;

          with DS_CHAMADO do
            begin
              Close;
              SelectSQL.Text := 'select * from tbchamado where chamado_id = 0';
              Open;
            end;

          vlQuerySIC.First;
          while not vlQuerySIC.Eof do
            begin
              with vlQueryAtividade do
                begin
                  Close;
                  SQL.Text := 'select * from tbchamado';
                  SQL.Add(' where deletado = ''N'' ');
                  SQL.Add(' and chamado_id = ''' + vlQuerySIC.FieldByName('CHAMADO_ID').AsString + ''' ');
                  Open;
                end;

              try
                DS_CHAMADO.Insert;
                for x := 0 to Pred(vlQueryAtividade.Fields.Count) do
                  begin
                    campo := vlQueryAtividade.Fields[x].FieldName;

                    if campo <> 'CHAMADO_ID' then // O ID o banco gerar� o ID para o novo registro
                      DS_CHAMADO.FieldByName(campo).Value := vlQueryAtividade.FieldByName(campo).Value;
                  end;

                DS_CHAMADO.Post;
                DS_CHAMADO.Transaction.CommitRetaining;

                with vlQueryUpdate do
                  begin
                    Close;
                    SQL.Text := 'update tbchamado_programado set';
                    SQL.Add(' data = ''' + FormatDateTime('DD.MM.YYYY', Date + vlQuerySIC.FieldByName('PERIODO').AsInteger) + ''' ');
                    SQL.Add(' where deletado = ''N'' ');
                    SQL.Add(' and chamadoprogramado_id = ''' + vlQuerySIC.FieldByName('CHAMADOPROGRAMADO_ID').AsString + ''' ');
                    ExecSQL;
                    Transaction.CommitRetaining;
                  end;
              except on e: exception do
                begin
                  DS_CHAMADO.Transaction.RollbackRetaining;
                  Application.MessageBox(PChar('Erro ao salvar atividade programada' + e.Message),'Erro', MB_OK+MB_ICONERROR);
                end;
              end;

              vlQuerySIC.Next;
            end;

          FreeAndNil(vlQueryAtividade);
        end;

      FreeAndNil(vlQueryUpdate);
    end;

  FreeAndNil(vlQuerySIC);
end;

procedure Tdm1.pInsereAtividadeCMAcao(prCMID, prCMAcaoID: String);
var
  vlQueryCMAcao : TIBQuery;
begin
  vlQueryCMAcao := TIBQuery.Create(Owner);

  with vlQueryCMAcao do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;
      Close;
      SQL.Text := 'select * from tbcm_acao';
      SQL.Add(' where deletado = ''N'' ');
      SQL.Add(' and cm_id = ''' + prCMID + ''' ');
      SQL.Add(' and acao_id = ''' + prCMAcaoID + ''' ');
      Open;
    end;

  with DS_CHAMADO do
    begin
      Close;
      SelectSQL.Text := 'select * from tbchamado where deletado = ''N'' ';
      SelectSQL.Add(' and cm_id = ''' + prCMID + ''' ');
      SelectSQL.Add(' and cmacao_id = ''' + prCMAcaoID + ''' ');
      Open;
    end;

  try
    if DS_CHAMADO.IsEmpty then
      DS_CHAMADO.Insert
    else
      DS_CHAMADO.Edit;

    DS_CHAMADOCM_ID.AsString           := prCMID;
    DS_CHAMADOCMACAO_ID.AsString       := prCMAcaoID;
    DS_CHAMADOASSUNTO.AsString         := vlQueryCMAcao.FieldByName('ACAO').AsString;
    DS_CHAMADODESCRICAO.AsString       := vlQueryCMAcao.FieldByName('ACAO').AsString;
    DS_CHAMADODESCRICAO_LIMPO.AsString := vlQueryCMAcao.FieldByName('ACAO').AsString;
    DS_CHAMADOSUPORTE_ID.AsString      := vlQueryCMAcao.FieldByName('RESPONSAVEL_ID').AsString;
    DS_CHAMADOSUPORTE.AsString         := vlQueryCMAcao.FieldByName('RESPONSAVEL').AsString;
    DS_CHAMADOSUPORTE_EMAIL.AsString   := vlQueryCMAcao.FieldByName('RESPONSAVEL_EMAIL').AsString;
    DS_CHAMADODEPARTAMENTO_ID.AsString := vlQueryCMAcao.FieldByName('DEPARTAMENTO_ID').AsString;
    DS_CHAMADODEPARTAMENTO.AsString    := vlQueryCMAcao.FieldByName('DEPARTAMENTO').AsString;
    DS_CHAMADODATA.AsDateTime          := vlQueryCMAcao.FieldByName('DATA_PROGRAMADA').AsDateTime;
    DS_CHAMADOVENCIMENTO.AsDateTime    := vlQueryCMAcao.FieldByName('DATA_PROGRAMADA').AsDateTime;

    if vlQueryCMAcao.FieldByName('STATUS').AsString = 'OK' then
      DS_CHAMADOSTATUS.AsString := 'Fechado'
    else
      DS_CHAMADOSTATUS.AsString := 'Aberto';

    if Trim(vlQueryCMAcao.FieldByName('DATA_EXECUCAO').AsString) <> '' then
      DS_CHAMADOFECHAMENTO_DATA.AsDateTime := vlQueryCMAcao.FieldByName('DATA_EXECUCAO').AsDateTime;

    DS_CHAMADODATA_INC.AsDateTime    := vlQueryCMAcao.FieldByName('DATA_INC').AsDateTime;
    DS_CHAMADOUSUARIO_I.AsString     := vlQueryCMAcao.FieldByName('USUARIO_I').AsString;
    DS_CHAMADOUSUARIONOME_I.AsString := vlQueryCMAcao.FieldByName('USUARIONOME_I').AsString;

    DS_CHAMADODATA_ALT.AsDateTime    := vlQueryCMAcao.FieldByName('DATA_ALT').AsDateTime;
    DS_CHAMADOUSUARIO_A.AsString     := vlQueryCMAcao.FieldByName('USUARIO_A').AsString;
    DS_CHAMADOUSUARIONOME_A.AsString := vlQueryCMAcao.FieldByName('USUARIONOME_A').AsString;

    DS_CHAMADODATA_DEL.AsDateTime    := vlQueryCMAcao.FieldByName('DATA_DEL').AsDateTime;
    DS_CHAMADOUSUARIO_D.AsString     := vlQueryCMAcao.FieldByName('USUARIO_D').AsString;
    DS_CHAMADOUSUARIONOME_D.AsString := vlQueryCMAcao.FieldByName('USUARIONOME_D').AsString;

    DS_CHAMADODELETADO.AsString      := vlQueryCMAcao.FieldByName('DELETADO').AsString;

    DS_CHAMADO.Post;
    DS_CHAMADO.Transaction.CommitRetaining;
  except on e : exception do
    begin
      //ShowMessage(PChar('Erro ao salvar: ' + e.Message));
      DS_CHAMADO.Transaction.RollbackRetaining;
    end;
  end;


  FreeAndNil(vlQueryCMAcao);
end;

end.
