object dm1: Tdm1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 572
  Width = 745
  object IBTransaction1: TIBTransaction
    DefaultDatabase = IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 88
    Top = 456
  end
  object IBDatabase1: TIBDatabase
    DatabaseName = 'C:\C3S\SICFAR\Dados\SICFAR.FDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=WIN1252')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    ServerType = 'IBServer'
    AfterConnect = IBDatabase1AfterConnect
    Left = 88
    Top = 408
  end
  object DataSource1: TDataSource
    Left = 72
    Top = 200
  end
  object DataSourceDepartamentos: TDataSource
    DataSet = QueryDepartamentos
    Left = 368
    Top = 56
  end
  object QueryStatus: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT STATUS, COUNT (STATUS) as QUANTIDADE FROM TBCHAMADOS GROU' +
        'P BY STATUS HAVING COUNT (STATUS) > 0')
    Left = 248
    Top = 112
  end
  object DataSourceStatus: TDataSource
    DataSet = QueryStatus
    Left = 368
    Top = 112
  end
  object QueryTipo: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT TIPO, COUNT (TIPO) as QUANTIDADE FROM TBCHAMADOS GROUP BY' +
        ' TIPO HAVING COUNT(TIPO)>0')
    Left = 248
    Top = 168
  end
  object DataSourceTipo: TDataSource
    DataSet = QueryTipo
    Left = 368
    Top = 168
  end
  object QuerySuporte: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT SUPORTE, COUNT (SUPORTE) as QUANTIDADE FROM TBCHAMADOS GR' +
        'OUP BY SUPORTE HAVING COUNT (SUPORTE)>0')
    Left = 248
    Top = 224
  end
  object DataSourceSuporte: TDataSource
    DataSet = QuerySuporte
    Left = 368
    Top = 224
  end
  object QueryGrupo: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT GRUPO, COUNT (GRUPO) as QUANTIDADE FROM TBCHAMADOS GROUP ' +
        'BY GRUPO HAVING COUNT (GRUPO) > 0')
    Left = 248
    Top = 280
  end
  object DataSourceGrupo: TDataSource
    DataSet = QueryGrupo
    Left = 368
    Top = 280
  end
  object QueryDepartamentos: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT DEPARTAMENTO, COUNT (DEPARTAMENTO) as QUANTIDADE FROM TBC' +
        'HAMADOS GROUP BY DEPARTAMENTO HAVING COUNT (DEPARTAMENTO)>0')
    Left = 248
    Top = 56
  end
  object QueryDetalhesChamado: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from TBDETALHESCHAMADO')
    Left = 72
    Top = 256
  end
  object DS_DetalhesChamado: TIBDataSet
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from TBDETALHESCHAMADO'
      'where'
      '  ID = :OLD_ID')
    InsertSQL.Strings = (
      'insert into TBDETALHESCHAMADO'
      '  (ID, ID_CHAMADO, ANOTACAO)'
      'values'
      '  (:ID, :ID_CHAMADO, :ANOTACAO)')
    RefreshSQL.Strings = (
      'Select '
      '  ID,'
      '  ID_CHAMADO,'
      '  ANOTACAO'
      'from TBDETALHESCHAMADO '
      'where'
      '  ID = :ID')
    SelectSQL.Strings = (
      'select * from TBDETALHESCHAMADO')
    ModifySQL.Strings = (
      'update TBDETALHESCHAMADO'
      'set'
      '  ID = :ID,'
      '  ID_CHAMADO = :ID_CHAMADO,'
      '  ANOTACAO = :ANOTACAO'
      'where'
      '  ID = :OLD_ID')
    ParamCheck = True
    UniDirectional = False
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_TBDETALHESCHAMADO_ID'
    Left = 72
    Top = 304
    object DS_DetalhesChamadoID_CHAMADO: TIntegerField
      FieldName = 'ID_CHAMADO'
      Origin = '"TBDETALHESCHAMADO"."ID_CHAMADO"'
      Required = True
    end
    object DS_DetalhesChamadoANOTACAO: TWideMemoField
      FieldName = 'ANOTACAO'
      Origin = '"TBDETALHESCHAMADO"."ANOTACAO"'
      ProviderFlags = [pfInUpdate]
      Required = True
      BlobType = ftWideMemo
      Size = 8
    end
    object DS_DetalhesChamadoID: TIntegerField
      FieldName = 'ID'
      Origin = '"TBDETALHESCHAMADO"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
  end
  object dtsChamados: TDataSource
    Left = 168
    Top = 168
  end
  object QueryChamados: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from TBCHAMADOS')
    Left = 168
    Top = 112
  end
  object DS_Interacao: TIBDataSet
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from TBINTERACAO'
      'where'
      '  ID_CHAMADO = :OLD_ID_CHAMADO')
    InsertSQL.Strings = (
      'insert into TBINTERACAO'
      '  (ID_CHAMADO, INTERACAO)'
      'values'
      '  (:ID_CHAMADO, :INTERACAO)')
    RefreshSQL.Strings = (
      'Select '
      '  ID_CHAMADO,'
      '  INTERACAO'
      'from TBINTERACAO '
      'where'
      '  ID_CHAMADO = :ID_CHAMADO')
    SelectSQL.Strings = (
      'select * from TBINTERACAO')
    ModifySQL.Strings = (
      'update TBINTERACAO'
      'set'
      '  ID_CHAMADO = :ID_CHAMADO,'
      '  INTERACAO = :INTERACAO'
      'where'
      '  ID_CHAMADO = :OLD_ID_CHAMADO')
    ParamCheck = True
    UniDirectional = False
    Left = 544
    Top = 120
    object DS_InteracaoID_CHAMADO: TIntegerField
      FieldName = 'ID_CHAMADO'
      Origin = '"TBINTERACAO"."ID_CHAMADO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object DS_InteracaoINTERACAO: TDateTimeField
      FieldName = 'INTERACAO'
      Origin = '"TBINTERACAO"."INTERACAO"'
    end
  end
  object QR_TEMP: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 544
    Top = 232
  end
  object Perfil: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 544
    Top = 176
  end
  object QR_AMOSTRA: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 544
    Top = 288
  end
  object QR_BUSCA: TIBQuery
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 168
    Top = 280
  end
  object cdsCampos: TClientDataSet
    PersistDataPacket.Data = {
      820000009619E0BD01000000180000000400000000000300000082000543414D
      504F0100490000000100055749445448020002001E0002444502004900000001
      0005574944544802000200E80304504152410200490000000100055749445448
      02000200E8030944455343524943414F02004900000001000557494454480200
      0200E8030000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 544
    Top = 69
    object cdsCamposCAMPO: TStringField
      FieldName = 'CAMPO'
      Size = 30
    end
    object cdsCamposDE: TStringField
      FieldName = 'DE'
      Size = 1000
    end
    object cdsCamposPARA: TStringField
      FieldName = 'PARA'
      Size = 1000
    end
    object cdsCamposDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 1000
    end
  end
  object DS_CHAMADO: TIBDataSet
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from tbchamado'
      'where'
      '  CHAMADO_ID = :OLD_CHAMADO_ID')
    InsertSQL.Strings = (
      'insert into tbchamado'
      
        '  (CHAMADO_ID, DATA, SOLICITANTE_ID, SOLICITANTE, ASSUNTO, DEPAR' +
        'TAMENTO_ID, '
      
        '   DEPARTAMENTO, TIPO_ID, TIPO, STATUS, PRIORIDADE, GRUPO_ID, GR' +
        'UPO, ANALISTA_ID, '
      
        '   ANALISTA, SUPORTE, SUPORTE_ID, DESCRICAO, USUARIO_I, USUARION' +
        'OME_I, '
      
        '   DATA_INC, USUARIO_A, USUARIONOME_A, DATA_ALT, USUARIO_D, USUA' +
        'RIONOME_D, '
      
        '   DATA_DEL, EMPRESA_ID, DELETADO, DE, PARA, LOTE, PRODUTO_ID, E' +
        'RP_PRODUTO, '
      
        '   PRODUTO, MOTORISTA_ID, MOTORISTA, SUPORTE_EMAIL, PESSOA_ID, E' +
        'RP_CLIENTE, '
      
        '   CLIENTE, CLI_ENDERECO, CLI_BAIRRO, CLI_CIDADE, CLI_CEP, CLI_U' +
        'F, CLI_COMPLEMENTO, '
      
        '   CLI_TELEFONE, CLI_TIPO, CLI_CPFCNPJ, CLI_IE, VENCIMENTO, PROT' +
        'OCOLO, '
      
        '   FECHAMENTO_DATA, FECHAMENTO_HORA, NUMERO, RETORNO_DATA, RETOR' +
        'NO_HORA, '
      
        '   REGISTRO, FECHAMENTO_USUARIO, PROJETO_ID, PROJETO, PROJETOITE' +
        'M_ID, CUSTO, '
      
        '   INICIO_HORA, INICIO_DATA, FECHAMENTO_STATUS, DEMANDA_ID, DEMA' +
        'NDA, CLIENTE_DEPARTAMENTO_ID, '
      
        '   CLIENTE_DEPARTAMENTO, EQUIPAMENTO_ID, EQUIPAMENTO, EQUIPAMENT' +
        'O_TAG, '
      '   CAPA_ID, CAPAITEM_ID, OBRIGA_ANEXO)'
      'values'
      
        '  (:CHAMADO_ID, :DATA, :SOLICITANTE_ID, :SOLICITANTE, :ASSUNTO, ' +
        ':DEPARTAMENTO_ID, '
      
        '   :DEPARTAMENTO, :TIPO_ID, :TIPO, :STATUS, :PRIORIDADE, :GRUPO_' +
        'ID, :GRUPO, '
      
        '   :ANALISTA_ID, :ANALISTA, :SUPORTE, :SUPORTE_ID, :DESCRICAO, :' +
        'USUARIO_I, '
      
        '   :USUARIONOME_I, :DATA_INC, :USUARIO_A, :USUARIONOME_A, :DATA_' +
        'ALT, :USUARIO_D, '
      
        '   :USUARIONOME_D, :DATA_DEL, :EMPRESA_ID, :DELETADO, :DE, :PARA' +
        ', :LOTE, '
      
        '   :PRODUTO_ID, :ERP_PRODUTO, :PRODUTO, :MOTORISTA_ID, :MOTORIST' +
        'A, :SUPORTE_EMAIL, '
      
        '   :PESSOA_ID, :ERP_CLIENTE, :CLIENTE, :CLI_ENDERECO, :CLI_BAIRR' +
        'O, :CLI_CIDADE, '
      
        '   :CLI_CEP, :CLI_UF, :CLI_COMPLEMENTO, :CLI_TELEFONE, :CLI_TIPO' +
        ', :CLI_CPFCNPJ, '
      
        '   :CLI_IE, :VENCIMENTO, :PROTOCOLO, :FECHAMENTO_DATA, :FECHAMEN' +
        'TO_HORA, '
      
        '   :NUMERO, :RETORNO_DATA, :RETORNO_HORA, :REGISTRO, :FECHAMENTO' +
        '_USUARIO, '
      
        '   :PROJETO_ID, :PROJETO, :PROJETOITEM_ID, :CUSTO, :INICIO_HORA,' +
        ' :INICIO_DATA, '
      
        '   :FECHAMENTO_STATUS, :DEMANDA_ID, :DEMANDA, :CLIENTE_DEPARTAME' +
        'NTO_ID, '
      
        '   :CLIENTE_DEPARTAMENTO, :EQUIPAMENTO_ID, :EQUIPAMENTO, :EQUIPA' +
        'MENTO_TAG, '
      '   :CAPA_ID, :CAPAITEM_ID, :OBRIGA_ANEXO)')
    RefreshSQL.Strings = (
      'Select *'
      'from tbchamado '
      'where'
      '  CHAMADO_ID = :CHAMADO_ID')
    SelectSQL.Strings = (
      'select * from tbchamado where deletado = '#39'N'#39)
    ModifySQL.Strings = (
      'update tbchamado'
      'set'
      '  CHAMADO_ID = :CHAMADO_ID,'
      '  DATA = :DATA,'
      '  SOLICITANTE_ID = :SOLICITANTE_ID,'
      '  SOLICITANTE = :SOLICITANTE,'
      '  ASSUNTO = :ASSUNTO,'
      '  DEPARTAMENTO_ID = :DEPARTAMENTO_ID,'
      '  DEPARTAMENTO = :DEPARTAMENTO,'
      '  TIPO_ID = :TIPO_ID,'
      '  TIPO = :TIPO,'
      '  STATUS = :STATUS,'
      '  PRIORIDADE = :PRIORIDADE,'
      '  GRUPO_ID = :GRUPO_ID,'
      '  GRUPO = :GRUPO,'
      '  ANALISTA_ID = :ANALISTA_ID,'
      '  ANALISTA = :ANALISTA,'
      '  SUPORTE = :SUPORTE,'
      '  SUPORTE_ID = :SUPORTE_ID,'
      '  DESCRICAO = :DESCRICAO,'
      '  USUARIO_I = :USUARIO_I,'
      '  USUARIONOME_I = :USUARIONOME_I,'
      '  DATA_INC = :DATA_INC,'
      '  USUARIO_A = :USUARIO_A,'
      '  USUARIONOME_A = :USUARIONOME_A,'
      '  DATA_ALT = :DATA_ALT,'
      '  USUARIO_D = :USUARIO_D,'
      '  USUARIONOME_D = :USUARIONOME_D,'
      '  DATA_DEL = :DATA_DEL,'
      '  EMPRESA_ID = :EMPRESA_ID,'
      '  DELETADO = :DELETADO,'
      '  DE = :DE,'
      '  PARA = :PARA,'
      '  LOTE = :LOTE,'
      '  PRODUTO_ID = :PRODUTO_ID,'
      '  ERP_PRODUTO = :ERP_PRODUTO,'
      '  PRODUTO = :PRODUTO,'
      '  MOTORISTA_ID = :MOTORISTA_ID,'
      '  MOTORISTA = :MOTORISTA,'
      '  SUPORTE_EMAIL = :SUPORTE_EMAIL,'
      '  PESSOA_ID = :PESSOA_ID,'
      '  ERP_CLIENTE = :ERP_CLIENTE,'
      '  CLIENTE = :CLIENTE,'
      '  CLI_ENDERECO = :CLI_ENDERECO,'
      '  CLI_BAIRRO = :CLI_BAIRRO,'
      '  CLI_CIDADE = :CLI_CIDADE,'
      '  CLI_CEP = :CLI_CEP,'
      '  CLI_UF = :CLI_UF,'
      '  CLI_COMPLEMENTO = :CLI_COMPLEMENTO,'
      '  CLI_TELEFONE = :CLI_TELEFONE,'
      '  CLI_TIPO = :CLI_TIPO,'
      '  CLI_CPFCNPJ = :CLI_CPFCNPJ,'
      '  CLI_IE = :CLI_IE,'
      '  VENCIMENTO = :VENCIMENTO,'
      '  PROTOCOLO = :PROTOCOLO,'
      '  FECHAMENTO_DATA = :FECHAMENTO_DATA,'
      '  FECHAMENTO_HORA = :FECHAMENTO_HORA,'
      '  NUMERO = :NUMERO,'
      '  RETORNO_DATA = :RETORNO_DATA,'
      '  RETORNO_HORA = :RETORNO_HORA,'
      '  REGISTRO = :REGISTRO,'
      '  FECHAMENTO_USUARIO = :FECHAMENTO_USUARIO,'
      '  PROJETO_ID = :PROJETO_ID,'
      '  PROJETO = :PROJETO,'
      '  PROJETOITEM_ID = :PROJETOITEM_ID,'
      '  CUSTO = :CUSTO,'
      '  INICIO_HORA = :INICIO_HORA,'
      '  INICIO_DATA = :INICIO_DATA,'
      '  FECHAMENTO_STATUS = :FECHAMENTO_STATUS,'
      '  DEMANDA_ID = :DEMANDA_ID,'
      '  DEMANDA = :DEMANDA,'
      '  CLIENTE_DEPARTAMENTO_ID = :CLIENTE_DEPARTAMENTO_ID,'
      '  CLIENTE_DEPARTAMENTO = :CLIENTE_DEPARTAMENTO,'
      '  EQUIPAMENTO_ID = :EQUIPAMENTO_ID,'
      '  EQUIPAMENTO = :EQUIPAMENTO,'
      '  EQUIPAMENTO_TAG = :EQUIPAMENTO_TAG,'
      '  CAPA_ID = :CAPA_ID,'
      '  CAPAITEM_ID = :CAPAITEM_ID,'
      '  OBRIGA_ANEXO = :OBRIGA_ANEXO'
      'where'
      '  CHAMADO_ID = :OLD_CHAMADO_ID')
    ParamCheck = True
    UniDirectional = False
    GeneratorField.Field = 'CHAMADO_ID'
    GeneratorField.Generator = 'GEN_TBCHAMADO'
    Left = 68
    Top = 152
    object DS_CHAMADOCHAMADO_ID: TIntegerField
      FieldName = 'CHAMADO_ID'
      Origin = '"TBCHAMADO"."CHAMADO_ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object DS_CHAMADODATA: TDateField
      FieldName = 'DATA'
      Origin = '"TBCHAMADO"."DATA"'
    end
    object DS_CHAMADOSOLICITANTE_ID: TIntegerField
      FieldName = 'SOLICITANTE_ID'
      Origin = '"TBCHAMADO"."SOLICITANTE_ID"'
    end
    object DS_CHAMADOSOLICITANTE: TIBStringField
      FieldName = 'SOLICITANTE'
      Origin = '"TBCHAMADO"."SOLICITANTE"'
      Size = 80
    end
    object DS_CHAMADOASSUNTO: TIBStringField
      FieldName = 'ASSUNTO'
      Origin = '"TBCHAMADO"."ASSUNTO"'
      Size = 1000
    end
    object DS_CHAMADODEPARTAMENTO_ID: TIntegerField
      FieldName = 'DEPARTAMENTO_ID'
      Origin = '"TBCHAMADO"."DEPARTAMENTO_ID"'
    end
    object DS_CHAMADODEPARTAMENTO: TIBStringField
      FieldName = 'DEPARTAMENTO'
      Origin = '"TBCHAMADO"."DEPARTAMENTO"'
      Size = 30
    end
    object DS_CHAMADOTIPO_ID: TIntegerField
      FieldName = 'TIPO_ID'
      Origin = '"TBCHAMADO"."TIPO_ID"'
    end
    object DS_CHAMADOTIPO: TIBStringField
      FieldName = 'TIPO'
      Origin = '"TBCHAMADO"."TIPO"'
      Size = 40
    end
    object DS_CHAMADOSTATUS: TIBStringField
      FieldName = 'STATUS'
      Origin = '"TBCHAMADO"."STATUS"'
      Size = 10
    end
    object DS_CHAMADOPRIORIDADE: TIBStringField
      FieldName = 'PRIORIDADE'
      Origin = '"TBCHAMADO"."PRIORIDADE"'
      Size = 10
    end
    object DS_CHAMADOGRUPO_ID: TIntegerField
      FieldName = 'GRUPO_ID'
      Origin = '"TBCHAMADO"."GRUPO_ID"'
    end
    object DS_CHAMADOGRUPO: TIBStringField
      FieldName = 'GRUPO'
      Origin = '"TBCHAMADO"."GRUPO"'
      Size = 40
    end
    object DS_CHAMADOANALISTA_ID: TIntegerField
      FieldName = 'ANALISTA_ID'
      Origin = '"TBCHAMADO"."ANALISTA_ID"'
    end
    object DS_CHAMADOANALISTA: TIBStringField
      FieldName = 'ANALISTA'
      Origin = '"TBCHAMADO"."ANALISTA"'
      Size = 30
    end
    object DS_CHAMADOSUPORTE: TIBStringField
      FieldName = 'SUPORTE'
      Origin = '"TBCHAMADO"."SUPORTE"'
      Size = 30
    end
    object DS_CHAMADOSUPORTE_ID: TIntegerField
      FieldName = 'SUPORTE_ID'
      Origin = '"TBCHAMADO"."SUPORTE_ID"'
    end
    object DS_CHAMADODESCRICAO: TWideMemoField
      FieldName = 'DESCRICAO'
      Origin = '"TBCHAMADO"."DESCRICAO"'
      ProviderFlags = [pfInUpdate]
      BlobType = ftWideMemo
      Size = 8
    end
    object DS_CHAMADOUSUARIO_I: TIntegerField
      FieldName = 'USUARIO_I'
      Origin = '"TBCHAMADO"."USUARIO_I"'
    end
    object DS_CHAMADOUSUARIONOME_I: TIBStringField
      FieldName = 'USUARIONOME_I'
      Origin = '"TBCHAMADO"."USUARIONOME_I"'
      Size = 30
    end
    object DS_CHAMADODATA_INC: TDateTimeField
      FieldName = 'DATA_INC'
      Origin = '"TBCHAMADO"."DATA_INC"'
    end
    object DS_CHAMADOUSUARIO_A: TIntegerField
      FieldName = 'USUARIO_A'
      Origin = '"TBCHAMADO"."USUARIO_A"'
    end
    object DS_CHAMADOUSUARIONOME_A: TIBStringField
      FieldName = 'USUARIONOME_A'
      Origin = '"TBCHAMADO"."USUARIONOME_A"'
      Size = 30
    end
    object DS_CHAMADODATA_ALT: TDateTimeField
      FieldName = 'DATA_ALT'
      Origin = '"TBCHAMADO"."DATA_ALT"'
    end
    object DS_CHAMADOUSUARIO_D: TIntegerField
      FieldName = 'USUARIO_D'
      Origin = '"TBCHAMADO"."USUARIO_D"'
    end
    object DS_CHAMADOUSUARIONOME_D: TIBStringField
      FieldName = 'USUARIONOME_D'
      Origin = '"TBCHAMADO"."USUARIONOME_D"'
      Size = 30
    end
    object DS_CHAMADODATA_DEL: TDateTimeField
      FieldName = 'DATA_DEL'
      Origin = '"TBCHAMADO"."DATA_DEL"'
    end
    object DS_CHAMADOEMPRESA_ID: TIntegerField
      FieldName = 'EMPRESA_ID'
      Origin = '"TBCHAMADO"."EMPRESA_ID"'
    end
    object DS_CHAMADODELETADO: TIBStringField
      FieldName = 'DELETADO'
      Origin = '"TBCHAMADO"."DELETADO"'
      FixedChar = True
      Size = 1
    end
    object DS_CHAMADODE: TIBStringField
      FieldName = 'DE'
      Origin = '"TBCHAMADO"."DE"'
      Size = 3000
    end
    object DS_CHAMADOPARA: TIBStringField
      FieldName = 'PARA'
      Origin = '"TBCHAMADO"."PARA"'
      Size = 3000
    end
    object DS_CHAMADOLOTE: TIBStringField
      FieldName = 'LOTE'
      Origin = '"TBCHAMADO"."LOTE"'
    end
    object DS_CHAMADOPRODUTO_ID: TIntegerField
      FieldName = 'PRODUTO_ID'
      Origin = '"TBCHAMADO"."PRODUTO_ID"'
    end
    object DS_CHAMADOERP_PRODUTO: TIBStringField
      FieldName = 'ERP_PRODUTO'
      Origin = '"TBCHAMADO"."ERP_PRODUTO"'
      Size = 10
    end
    object DS_CHAMADOPRODUTO: TIBStringField
      FieldName = 'PRODUTO'
      Origin = '"TBCHAMADO"."PRODUTO"'
      Size = 100
    end
    object DS_CHAMADOMOTORISTA_ID: TIntegerField
      FieldName = 'MOTORISTA_ID'
      Origin = '"TBCHAMADO"."MOTORISTA_ID"'
    end
    object DS_CHAMADOMOTORISTA: TIBStringField
      FieldName = 'MOTORISTA'
      Origin = '"TBCHAMADO"."MOTORISTA"'
      Size = 80
    end
    object DS_CHAMADOSUPORTE_EMAIL: TIBStringField
      FieldName = 'SUPORTE_EMAIL'
      Origin = '"TBCHAMADO"."SUPORTE_EMAIL"'
      Size = 100
    end
    object DS_CHAMADOPESSOA_ID: TIntegerField
      FieldName = 'PESSOA_ID'
      Origin = '"TBCHAMADO"."PESSOA_ID"'
    end
    object DS_CHAMADOERP_CLIENTE: TIBStringField
      FieldName = 'ERP_CLIENTE'
      Origin = '"TBCHAMADO"."ERP_CLIENTE"'
      Size = 10
    end
    object DS_CHAMADOCLIENTE: TIBStringField
      FieldName = 'CLIENTE'
      Origin = '"TBCHAMADO"."CLIENTE"'
      Size = 80
    end
    object DS_CHAMADOCLI_ENDERECO: TIBStringField
      FieldName = 'CLI_ENDERECO'
      Origin = '"TBCHAMADO"."CLI_ENDERECO"'
      Size = 80
    end
    object DS_CHAMADOCLI_BAIRRO: TIBStringField
      FieldName = 'CLI_BAIRRO'
      Origin = '"TBCHAMADO"."CLI_BAIRRO"'
      Size = 40
    end
    object DS_CHAMADOCLI_CIDADE: TIBStringField
      FieldName = 'CLI_CIDADE'
      Origin = '"TBCHAMADO"."CLI_CIDADE"'
      Size = 40
    end
    object DS_CHAMADOCLI_CEP: TIBStringField
      FieldName = 'CLI_CEP'
      Origin = '"TBCHAMADO"."CLI_CEP"'
      Size = 10
    end
    object DS_CHAMADOCLI_UF: TIBStringField
      FieldName = 'CLI_UF'
      Origin = '"TBCHAMADO"."CLI_UF"'
      Size = 2
    end
    object DS_CHAMADOCLI_COMPLEMENTO: TIBStringField
      FieldName = 'CLI_COMPLEMENTO'
      Origin = '"TBCHAMADO"."CLI_COMPLEMENTO"'
      Size = 60
    end
    object DS_CHAMADOCLI_TELEFONE: TIBStringField
      FieldName = 'CLI_TELEFONE'
      Origin = '"TBCHAMADO"."CLI_TELEFONE"'
      Size = 14
    end
    object DS_CHAMADOCLI_TIPO: TIBStringField
      FieldName = 'CLI_TIPO'
      Origin = '"TBCHAMADO"."CLI_TIPO"'
      Size = 30
    end
    object DS_CHAMADOCLI_CPFCNPJ: TIBStringField
      FieldName = 'CLI_CPFCNPJ'
      Origin = '"TBCHAMADO"."CLI_CPFCNPJ"'
      Size = 18
    end
    object DS_CHAMADOCLI_IE: TIBStringField
      FieldName = 'CLI_IE'
      Origin = '"TBCHAMADO"."CLI_IE"'
      Size = 18
    end
    object DS_CHAMADOVENCIMENTO: TDateField
      FieldName = 'VENCIMENTO'
      Origin = '"TBCHAMADO"."VENCIMENTO"'
    end
    object DS_CHAMADOPROTOCOLO: TIBStringField
      FieldName = 'PROTOCOLO'
      Origin = '"TBCHAMADO"."PROTOCOLO"'
    end
    object DS_CHAMADOFECHAMENTO_DATA: TDateField
      FieldName = 'FECHAMENTO_DATA'
      Origin = '"TBCHAMADO"."FECHAMENTO_DATA"'
    end
    object DS_CHAMADOFECHAMENTO_HORA: TTimeField
      FieldName = 'FECHAMENTO_HORA'
      Origin = '"TBCHAMADO"."FECHAMENTO_HORA"'
    end
    object DS_CHAMADONUMERO: TIBStringField
      FieldName = 'NUMERO'
      Origin = '"TBCHAMADO"."NUMERO"'
      Size = 10
    end
    object DS_CHAMADORETORNO_DATA: TDateField
      FieldName = 'RETORNO_DATA'
      Origin = '"TBCHAMADO"."RETORNO_DATA"'
    end
    object DS_CHAMADORETORNO_HORA: TTimeField
      FieldName = 'RETORNO_HORA'
      Origin = '"TBCHAMADO"."RETORNO_HORA"'
    end
    object DS_CHAMADOREGISTRO: TIBStringField
      FieldName = 'REGISTRO'
      Origin = '"TBCHAMADO"."REGISTRO"'
    end
    object DS_CHAMADOFECHAMENTO_USUARIO: TIBStringField
      FieldName = 'FECHAMENTO_USUARIO'
      Origin = '"TBCHAMADO"."FECHAMENTO_USUARIO"'
      Size = 50
    end
    object DS_CHAMADOPROJETO_ID: TIntegerField
      FieldName = 'PROJETO_ID'
      Origin = '"TBCHAMADO"."PROJETO_ID"'
    end
    object DS_CHAMADOPROJETOITEM_ID: TIntegerField
      FieldName = 'PROJETOITEM_ID'
      Origin = '"TBCHAMADO"."PROJETOITEM_ID"'
    end
    object DS_CHAMADOPROJETO: TIBStringField
      FieldName = 'PROJETO'
      Origin = '"TBCHAMADO"."PROJETO"'
      Size = 100
    end
    object DS_CHAMADOCUSTO: TIBBCDField
      FieldName = 'CUSTO'
      Origin = '"TBCHAMADO"."CUSTO"'
      Precision = 18
      Size = 2
    end
    object DS_CHAMADODEMANDA_ID: TIntegerField
      FieldName = 'DEMANDA_ID'
      Origin = '"TBCHAMADO"."DEMANDA_ID"'
    end
    object DS_CHAMADODEMANDA: TIBStringField
      FieldName = 'DEMANDA'
      Origin = '"TBCHAMADO"."DEMANDA"'
      Size = 40
    end
    object DS_CHAMADOINICIO_HORA: TTimeField
      FieldName = 'INICIO_HORA'
      Origin = '"TBCHAMADO"."INICIO_HORA"'
    end
    object DS_CHAMADOINICIO_DATA: TDateField
      FieldName = 'INICIO_DATA'
      Origin = '"TBCHAMADO"."INICIO_DATA"'
    end
    object DS_CHAMADOFECHAMENTO_STATUS: TIBStringField
      FieldName = 'FECHAMENTO_STATUS'
      Origin = '"TBCHAMADO"."FECHAMENTO_STATUS"'
    end
    object DS_CHAMADOCLIENTE_DEPARTAMENTO_ID: TIntegerField
      FieldName = 'CLIENTE_DEPARTAMENTO_ID'
      Origin = '"TBCHAMADO"."CLIENTE_DEPARTAMENTO_ID"'
    end
    object DS_CHAMADOCLIENTE_DEPARTAMENTO: TIBStringField
      FieldName = 'CLIENTE_DEPARTAMENTO'
      Origin = '"TBCHAMADO"."CLIENTE_DEPARTAMENTO"'
      Size = 40
    end
    object DS_CHAMADOEQUIPAMENTO_ID: TIntegerField
      FieldName = 'EQUIPAMENTO_ID'
      Origin = '"TBCHAMADO"."EQUIPAMENTO_ID"'
    end
    object DS_CHAMADOEQUIPAMENTO: TIBStringField
      FieldName = 'EQUIPAMENTO'
      Origin = '"TBCHAMADO"."EQUIPAMENTO"'
      Size = 60
    end
    object DS_CHAMADOEQUIPAMENTO_TAG: TIBStringField
      FieldName = 'EQUIPAMENTO_TAG'
      Origin = '"TBCHAMADO"."EQUIPAMENTO_TAG"'
      Size = 35
    end
    object DS_CHAMADOCAPA_ID: TIntegerField
      FieldName = 'CAPA_ID'
      Origin = '"TBCHAMADO"."CAPA_ID"'
    end
    object DS_CHAMADOCAPAITEM_ID: TIntegerField
      FieldName = 'CAPAITEM_ID'
      Origin = '"TBCHAMADO"."CAPAITEM_ID"'
    end
    object DS_CHAMADOOBRIGA_ANEXO: TIBStringField
      FieldName = 'OBRIGA_ANEXO'
      Origin = '"TBCHAMADO"."OBRIGA_ANEXO"'
      FixedChar = True
      Size = 1
    end
    object DS_CHAMADOEQUIPE_ID: TIntegerField
      FieldName = 'EQUIPE_ID'
      Origin = '"TBCHAMADO"."EQUIPE_ID"'
    end
    object DS_CHAMADOEQUIPE: TIBStringField
      FieldName = 'EQUIPE'
      Origin = '"TBCHAMADO"."EQUIPE"'
      Size = 50
    end
    object DS_CHAMADODESCRICAO_LIMPO: TWideMemoField
      FieldName = 'DESCRICAO_LIMPO'
      Origin = '"TBCHAMADO"."DESCRICAO_LIMPO"'
      ProviderFlags = [pfInUpdate]
      BlobType = ftWideMemo
      Size = 8
    end
    object DS_CHAMADOCM_ID: TIntegerField
      FieldName = 'CM_ID'
      Origin = '"TBCHAMADO"."CM_ID"'
    end
    object DS_CHAMADOCMACAO_ID: TIntegerField
      FieldName = 'CMACAO_ID'
      Origin = '"TBCHAMADO"."CMACAO_ID"'
    end
    object DS_CHAMADODATAWARE: TIBStringField
      FieldName = 'DATAWARE'
      Origin = '"TBCHAMADO"."DATAWARE"'
      Size = 2
    end
  end
  object IBDatabase3: TIBDatabase
    DatabaseName = '191.252.156.233/3050:C:\PedidosOnline\Dados\PEDIDOSONLINE.FDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=win1252')
    LoginPrompt = False
    DefaultTransaction = IBTransaction3
    ServerType = 'IBServer'
    Left = 184
    Top = 408
  end
  object IBTransaction3: TIBTransaction
    DefaultDatabase = IBDatabase3
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 184
    Top = 456
  end
  object DS_ACESSO: TIBDataSet
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from TBACESSO'
      'where'
      '  ACESSO_ID = :OLD_ACESSO_ID')
    InsertSQL.Strings = (
      'insert into TBACESSO'
      
        '  (ACESSO_ID, DATA, USUARIO_ID, USUARIO, LOCAL, TIPO, ATIVIDADE,' +
        ' ONLINE, '
      '   IP, COMPUTADOR, VERSAO, CONEXAO)'
      'values'
      
        '  (:ACESSO_ID, :DATA, :USUARIO_ID, :USUARIO, :LOCAL, :TIPO, :ATI' +
        'VIDADE, '
      '   :ONLINE, :IP, :COMPUTADOR, :VERSAO, :CONEXAO)')
    RefreshSQL.Strings = (
      'Select '
      '  ACESSO_ID,'
      '  DATA,'
      '  USUARIO_ID,'
      '  USUARIO,'
      '  LOCAL,'
      '  TIPO,'
      '  ATIVIDADE,'
      '  ONLINE,'
      '  IP,'
      '  COMPUTADOR,'
      '  VERSAO,'
      '  CONEXAO'
      'from TBACESSO '
      'where'
      '  ACESSO_ID = :ACESSO_ID')
    SelectSQL.Strings = (
      'select * from TBACESSO')
    ModifySQL.Strings = (
      'update TBACESSO'
      'set'
      '  ACESSO_ID = :ACESSO_ID,'
      '  DATA = :DATA,'
      '  USUARIO_ID = :USUARIO_ID,'
      '  USUARIO = :USUARIO,'
      '  LOCAL = :LOCAL,'
      '  TIPO = :TIPO,'
      '  ATIVIDADE = :ATIVIDADE,'
      '  ONLINE = :ONLINE,'
      '  IP = :IP,'
      '  COMPUTADOR = :COMPUTADOR,'
      '  VERSAO = :VERSAO,'
      '  CONEXAO = :CONEXAO'
      'where'
      '  ACESSO_ID = :OLD_ACESSO_ID')
    ParamCheck = True
    UniDirectional = False
    GeneratorField.Field = 'ACESSO_ID'
    GeneratorField.Generator = 'GEN_TBACESSO'
    Left = 600
    Top = 456
    object DS_ACESSOACESSO_ID: TIntegerField
      FieldName = 'ACESSO_ID'
      Origin = '"TBACESSO"."ACESSO_ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object DS_ACESSODATA: TDateTimeField
      FieldName = 'DATA'
      Origin = '"TBACESSO"."DATA"'
    end
    object DS_ACESSOUSUARIO_ID: TIntegerField
      FieldName = 'USUARIO_ID'
      Origin = '"TBACESSO"."USUARIO_ID"'
    end
    object DS_ACESSOUSUARIO: TIBStringField
      FieldName = 'USUARIO'
      Origin = '"TBACESSO"."USUARIO"'
      Size = 30
    end
    object DS_ACESSOLOCAL: TIBStringField
      FieldName = 'LOCAL'
      Origin = '"TBACESSO"."LOCAL"'
      Size = 30
    end
    object DS_ACESSOTIPO: TIBStringField
      FieldName = 'TIPO'
      Origin = '"TBACESSO"."TIPO"'
      Size = 30
    end
    object DS_ACESSOATIVIDADE: TIBStringField
      FieldName = 'ATIVIDADE'
      Origin = '"TBACESSO"."ATIVIDADE"'
      Size = 300
    end
    object DS_ACESSOONLINE: TIBStringField
      FieldName = 'ONLINE'
      Origin = '"TBACESSO"."ONLINE"'
      FixedChar = True
      Size = 1
    end
    object DS_ACESSOIP: TIBStringField
      FieldName = 'IP'
      Origin = '"TBACESSO"."IP"'
      Size = 15
    end
    object DS_ACESSOCOMPUTADOR: TIBStringField
      FieldName = 'COMPUTADOR'
      Origin = '"TBACESSO"."COMPUTADOR"'
      Size = 30
    end
    object DS_ACESSOVERSAO: TIBStringField
      FieldName = 'VERSAO'
      Origin = '"TBACESSO"."VERSAO"'
    end
    object DS_ACESSOCONEXAO: TLargeintField
      FieldName = 'CONEXAO'
      Origin = '"TBACESSO"."CONEXAO"'
    end
  end
  object IBDatabaseCloudSICFAR: TIBDatabase
    DatabaseName = '191.252.156.233/3050:C:\PedidosOnline\Dados\SICFAR.fdb'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=WIN1252')
    LoginPrompt = False
    DefaultTransaction = IBTransactionCloudSICFAR
    ServerType = 'IBServer'
    Left = 296
    Top = 408
  end
  object IBTransactionCloudSICFAR: TIBTransaction
    DefaultDatabase = IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 296
    Top = 456
  end
end
