object Form_Busca_Empresa: TForm_Busca_Empresa
  Left = 189
  Top = 110
  ActiveControl = EditBtn_Pesq
  BorderStyle = bsDialog
  Caption = 'Empresas Cadastradas'
  ClientHeight = 360
  ClientWidth = 698
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  DesignSize = (
    698
    360)
  PixelsPerInch = 96
  TextHeight = 13
  object Label_Procura: TLabel
    Left = 7
    Top = 43
    Width = 136
    Height = 13
    Caption = 'Pesquisando por: Nome'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object EditBtn_Pesq: TRzButtonEdit
    Left = 7
    Top = 60
    Width = 342
    Height = 21
    Text = ''
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    FrameHotTrack = True
    FrameHotStyle = fsFlat
    FrameVisible = True
    ParentFont = False
    TabOrder = 0
    OnChange = EditBtn_PesqChange
    OnKeyDown = EditBtn_PesqKeyDown
    OnKeyPress = EditBtn_PesqKeyPress
    ButtonKind = bkFind
    AltBtnWidth = 15
    ButtonWidth = 15
    FlatButtons = True
    OnButtonClick = EditBtn_PesqButtonClick
  end
  object RzStatusBar1: TRzStatusBar
    Left = 0
    Top = 341
    Width = 698
    Height = 19
    BorderInner = fsNone
    BorderOuter = fsNone
    BorderSides = [sdLeft, sdTop, sdRight, sdBottom]
    BorderWidth = 0
    GradientColorStyle = gcsCustom
    TabOrder = 1
    VisualStyle = vsGradient
    ExplicitTop = 322
    ExplicitWidth = 595
    object RzStatusPane1: TRzStatusPane
      Left = 0
      Top = 0
      Width = 564
      Height = 19
      Align = alLeft
      Caption = 'Aguardando pesquisa...'
    end
  end
  object pnlHeader: TRzPanel
    Left = 0
    Top = 0
    Width = 698
    Height = 33
    Align = alTop
    Alignment = taRightJustify
    BorderOuter = fsFlat
    BorderSides = [sdBottom]
    Caption = 'Consulta Empresa'
    FlatColor = 10524310
    Font.Charset = ANSI_CHARSET
    Font.Color = 9856100
    Font.Height = -17
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    GradientColorStart = 11855600
    GradientColorStop = 9229030
    TextMargin = 4
    ParentFont = False
    TabOrder = 2
    VisualStyle = vsGradient
    WordWrap = False
    ExplicitWidth = 595
  end
  object CheckBox_SubT: TRzCheckBox
    Left = 438
    Top = 62
    Width = 78
    Height = 15
    Anchors = [akTop]
    Caption = '&Sub-Texto'
    FrameColor = 8409372
    HighlightColor = 2203937
    HotTrack = True
    State = cbUnchecked
    TabOrder = 3
    ExplicitLeft = 368
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 85
    Width = 669
    Height = 237
    DataSource = DataSource_EMP
    DrawingStyle = gdsGradient
    TabOrder = 4
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Verdana'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    OnKeyPress = DBGrid1KeyPress
    OnTitleClick = DBGrid1TitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'EMPRESA_ID'
        Title.Caption = 'Empresa'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = 8477714
        Title.Font.Height = -11
        Title.Font.Name = 'Verdana'
        Title.Font.Style = []
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RAZAO_SOCIAL'
        Title.Caption = 'Raz'#227'o Social'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = 8477714
        Title.Font.Height = -11
        Title.Font.Name = 'Verdana'
        Title.Font.Style = []
        Width = 557
        Visible = True
      end>
  end
  object DataSource_EMP: TDataSource
    DataSet = QR_EMPRESA
    Left = 144
    Top = 177
  end
  object QR_EMPRESA: TIBQuery
    Database = dm1.IBDatabase1
    Transaction = dm1.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from TBEMPRESAS WHERE DELETADO = '#39'N'#39)
    Left = 244
    Top = 176
    object QR_EMPRESAEMPRESA_ID: TSmallintField
      FieldName = 'EMPRESA_ID'
      Origin = '"TBEMPRESAS"."EMPRESA_ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QR_EMPRESARAZAO_SOCIAL: TIBStringField
      FieldName = 'RAZAO_SOCIAL'
      Origin = '"TBEMPRESAS"."RAZAO_SOCIAL"'
      Size = 60
    end
    object QR_EMPRESANOME_FANTASIA: TIBStringField
      FieldName = 'NOME_FANTASIA'
      Origin = '"TBEMPRESAS"."NOME_FANTASIA"'
      Size = 30
    end
    object QR_EMPRESAENDERECO: TIBStringField
      FieldName = 'ENDERECO'
      Origin = '"TBEMPRESAS"."ENDERECO"'
      Size = 60
    end
    object QR_EMPRESABAIRRO: TIBStringField
      FieldName = 'BAIRRO'
      Origin = '"TBEMPRESAS"."BAIRRO"'
      Size = 30
    end
    object QR_EMPRESACIDADE: TIBStringField
      FieldName = 'CIDADE'
      Origin = '"TBEMPRESAS"."CIDADE"'
      Size = 30
    end
    object QR_EMPRESACEP: TIBStringField
      FieldName = 'CEP'
      Origin = '"TBEMPRESAS"."CEP"'
    end
    object QR_EMPRESAUF: TIBStringField
      FieldName = 'UF'
      Origin = '"TBEMPRESAS"."UF"'
      FixedChar = True
      Size = 2
    end
    object QR_EMPRESACNPJ: TIBStringField
      FieldName = 'CNPJ'
      Origin = '"TBEMPRESAS"."CNPJ"'
    end
    object QR_EMPRESACGF: TIBStringField
      FieldName = 'CGF'
      Origin = '"TBEMPRESAS"."CGF"'
    end
    object QR_EMPRESAEMAIL: TIBStringField
      FieldName = 'EMAIL'
      Origin = '"TBEMPRESAS"."EMAIL"'
      Size = 40
    end
    object QR_EMPRESASITE: TIBStringField
      FieldName = 'SITE'
      Origin = '"TBEMPRESAS"."SITE"'
      Size = 40
    end
    object QR_EMPRESAFONE_01: TIBStringField
      FieldName = 'FONE_01'
      Origin = '"TBEMPRESAS"."FONE_01"'
    end
    object QR_EMPRESAFONE_02: TIBStringField
      FieldName = 'FONE_02'
      Origin = '"TBEMPRESAS"."FONE_02"'
    end
    object QR_EMPRESAFONE_03: TIBStringField
      FieldName = 'FONE_03'
      Origin = '"TBEMPRESAS"."FONE_03"'
    end
    object QR_EMPRESAFONE_04: TIBStringField
      FieldName = 'FONE_04'
      Origin = '"TBEMPRESAS"."FONE_04"'
    end
    object QR_EMPRESADATACADASTRO: TDateField
      FieldName = 'DATACADASTRO'
      Origin = '"TBEMPRESAS"."DATACADASTRO"'
    end
    object QR_EMPRESALOGOMARCA: TBlobField
      FieldName = 'LOGOMARCA'
      Origin = '"TBEMPRESAS"."LOGOMARCA"'
      ProviderFlags = [pfInUpdate]
      Size = 8
    end
    object QR_EMPRESAOBS: TWideMemoField
      FieldName = 'OBS'
      Origin = '"TBEMPRESAS"."OBS"'
      ProviderFlags = [pfInUpdate]
      BlobType = ftWideMemo
      Size = 8
    end
    object QR_EMPRESAFUNDACAO: TDateField
      FieldName = 'FUNDACAO'
      Origin = '"TBEMPRESAS"."FUNDACAO"'
    end
    object QR_EMPRESAUSUARIO_ID: TSmallintField
      FieldName = 'USUARIO_ID'
      Origin = '"TBEMPRESAS"."USUARIO_ID"'
    end
    object QR_EMPRESADELETADO: TIBStringField
      FieldName = 'DELETADO'
      Origin = '"TBEMPRESAS"."DELETADO"'
      FixedChar = True
      Size = 1
    end
    object QR_EMPRESAVERSAO: TIBStringField
      FieldName = 'VERSAO'
      Origin = '"TBEMPRESAS"."VERSAO"'
      Size = 10
    end
    object QR_EMPRESANIRE: TIntegerField
      FieldName = 'NIRE'
      Origin = '"TBEMPRESAS"."NIRE"'
    end
    object QR_EMPRESASCRIPT: TIBStringField
      FieldName = 'SCRIPT'
      Origin = '"TBEMPRESAS"."SCRIPT"'
      Size = 10
    end
    object QR_EMPRESAARQUIVO_LICENCA: TIBStringField
      FieldName = 'ARQUIVO_LICENCA'
      Origin = '"TBEMPRESAS"."ARQUIVO_LICENCA"'
      Size = 30
    end
    object QR_EMPRESACOD_AGENCIA: TIBStringField
      FieldName = 'COD_AGENCIA'
      Origin = '"TBEMPRESAS"."COD_AGENCIA"'
      Size = 10
    end
    object QR_EMPRESACONTA_CORRENTE: TIBStringField
      FieldName = 'CONTA_CORRENTE'
      Origin = '"TBEMPRESAS"."CONTA_CORRENTE"'
    end
    object QR_EMPRESACARTEIRA: TIBStringField
      FieldName = 'CARTEIRA'
      Origin = '"TBEMPRESAS"."CARTEIRA"'
      Size = 4
    end
    object QR_EMPRESAVAR_CARTEIRA: TIBStringField
      FieldName = 'VAR_CARTEIRA'
      Origin = '"TBEMPRESAS"."VAR_CARTEIRA"'
      Size = 4
    end
    object QR_EMPRESACOD_CEDENTE: TIBStringField
      FieldName = 'COD_CEDENTE'
      Origin = '"TBEMPRESAS"."COD_CEDENTE"'
    end
    object QR_EMPRESAINICIO_NOSSONUMERO: TIBStringField
      FieldName = 'INICIO_NOSSONUMERO'
      Origin = '"TBEMPRESAS"."INICIO_NOSSONUMERO"'
    end
    object QR_EMPRESAFIM_NOSSONUMERO: TIBStringField
      FieldName = 'FIM_NOSSONUMERO'
      Origin = '"TBEMPRESAS"."FIM_NOSSONUMERO"'
    end
    object QR_EMPRESAACEITE: TIBStringField
      FieldName = 'ACEITE'
      Origin = '"TBEMPRESAS"."ACEITE"'
      Size = 3
    end
    object QR_EMPRESAESPECIE_BOLETO: TIBStringField
      FieldName = 'ESPECIE_BOLETO'
      Origin = '"TBEMPRESAS"."ESPECIE_BOLETO"'
      Size = 3
    end
    object QR_EMPRESAINSTRUCAO_CAIXA: TIBStringField
      FieldName = 'INSTRUCAO_CAIXA'
      Origin = '"TBEMPRESAS"."INSTRUCAO_CAIXA"'
      Size = 255
    end
    object QR_EMPRESATAXA_MULTADIA: TFMTBCDField
      FieldName = 'TAXA_MULTADIA'
      Origin = '"TBEMPRESAS"."TAXA_MULTADIA"'
      Precision = 18
      Size = 5
    end
    object QR_EMPRESADV_CONTACORRENTE: TIBStringField
      FieldName = 'DV_CONTACORRENTE'
      Origin = '"TBEMPRESAS"."DV_CONTACORRENTE"'
      Size = 2
    end
    object QR_EMPRESAINCC: TFMTBCDField
      FieldName = 'INCC'
      Origin = '"TBEMPRESAS"."INCC"'
      Precision = 18
      Size = 5
    end
    object QR_EMPRESAMULTAMES: TIBBCDField
      FieldName = 'MULTAMES'
      Origin = '"TBEMPRESAS"."MULTAMES"'
      Precision = 18
      Size = 2
    end
    object QR_EMPRESAJUROSMES: TIBBCDField
      FieldName = 'JUROSMES'
      Origin = '"TBEMPRESAS"."JUROSMES"'
      Precision = 18
      Size = 2
    end
    object QR_EMPRESADATA_ALT: TDateTimeField
      FieldName = 'DATA_ALT'
      Origin = '"TBEMPRESAS"."DATA_ALT"'
    end
    object QR_EMPRESADATA_INC: TDateTimeField
      FieldName = 'DATA_INC'
      Origin = '"TBEMPRESAS"."DATA_INC"'
    end
    object QR_EMPRESANUMERO: TIntegerField
      FieldName = 'NUMERO'
      Origin = '"TBEMPRESAS"."NUMERO"'
    end
    object QR_EMPRESACOMPLEMENTO: TIBStringField
      FieldName = 'COMPLEMENTO'
      Origin = '"TBEMPRESAS"."COMPLEMENTO"'
      Size = 60
    end
    object QR_EMPRESACONTADOR: TIBStringField
      FieldName = 'CONTADOR'
      Origin = '"TBEMPRESAS"."CONTADOR"'
      Size = 100
    end
    object QR_EMPRESAENDERECO_CONTADOR: TIBStringField
      FieldName = 'ENDERECO_CONTADOR'
      Origin = '"TBEMPRESAS"."ENDERECO_CONTADOR"'
      Size = 60
    end
    object QR_EMPRESACPF_CONTADOR: TIBStringField
      FieldName = 'CPF_CONTADOR'
      Origin = '"TBEMPRESAS"."CPF_CONTADOR"'
    end
    object QR_EMPRESACRC: TIBStringField
      FieldName = 'CRC'
      Origin = '"TBEMPRESAS"."CRC"'
    end
    object QR_EMPRESACNPJ_CONTADOR: TIBStringField
      FieldName = 'CNPJ_CONTADOR'
      Origin = '"TBEMPRESAS"."CNPJ_CONTADOR"'
    end
    object QR_EMPRESACEP_CONTADOR: TIBStringField
      FieldName = 'CEP_CONTADOR'
      Origin = '"TBEMPRESAS"."CEP_CONTADOR"'
    end
    object QR_EMPRESANUMERO_CONTADOR: TIntegerField
      FieldName = 'NUMERO_CONTADOR'
      Origin = '"TBEMPRESAS"."NUMERO_CONTADOR"'
    end
    object QR_EMPRESACOMPLEMENTO_CONTADOR: TIBStringField
      FieldName = 'COMPLEMENTO_CONTADOR'
      Origin = '"TBEMPRESAS"."COMPLEMENTO_CONTADOR"'
      Size = 60
    end
    object QR_EMPRESABAIRRO_CONTADOR: TIBStringField
      FieldName = 'BAIRRO_CONTADOR'
      Origin = '"TBEMPRESAS"."BAIRRO_CONTADOR"'
      Size = 60
    end
    object QR_EMPRESAFONE_CONTADOR: TIBStringField
      FieldName = 'FONE_CONTADOR'
      Origin = '"TBEMPRESAS"."FONE_CONTADOR"'
    end
    object QR_EMPRESAFAX_CONTADOR: TIBStringField
      FieldName = 'FAX_CONTADOR'
      Origin = '"TBEMPRESAS"."FAX_CONTADOR"'
    end
    object QR_EMPRESAEMAIL_CONTADOR: TIBStringField
      FieldName = 'EMAIL_CONTADOR'
      Origin = '"TBEMPRESAS"."EMAIL_CONTADOR"'
      Size = 100
    end
    object QR_EMPRESACONTADOR_CIDADE_ID: TIntegerField
      FieldName = 'CONTADOR_CIDADE_ID'
      Origin = '"TBEMPRESAS"."CONTADOR_CIDADE_ID"'
    end
    object QR_EMPRESACIDADE_CONTADOR: TIBStringField
      FieldName = 'CIDADE_CONTADOR'
      Origin = '"TBEMPRESAS"."CIDADE_CONTADOR"'
      Size = 60
    end
    object QR_EMPRESACIDADE_IBGE_CONTADOR: TIntegerField
      FieldName = 'CIDADE_IBGE_CONTADOR'
      Origin = '"TBEMPRESAS"."CIDADE_IBGE_CONTADOR"'
    end
    object QR_EMPRESAUF_CONTADOR: TIBStringField
      FieldName = 'UF_CONTADOR'
      Origin = '"TBEMPRESAS"."UF_CONTADOR"'
      Size = 2
    end
    object QR_EMPRESACPF_RFB: TIBStringField
      FieldName = 'CPF_RFB'
      Origin = '"TBEMPRESAS"."CPF_RFB"'
    end
    object QR_EMPRESAENDERECO_RFB: TIBStringField
      FieldName = 'ENDERECO_RFB'
      Origin = '"TBEMPRESAS"."ENDERECO_RFB"'
      Size = 60
    end
    object QR_EMPRESABAIRRO_RFB: TIBStringField
      FieldName = 'BAIRRO_RFB'
      Origin = '"TBEMPRESAS"."BAIRRO_RFB"'
      Size = 40
    end
    object QR_EMPRESACIDADE_RFB_ID: TIntegerField
      FieldName = 'CIDADE_RFB_ID'
      Origin = '"TBEMPRESAS"."CIDADE_RFB_ID"'
    end
    object QR_EMPRESACIDADE_ID: TIntegerField
      FieldName = 'CIDADE_ID'
      Origin = '"TBEMPRESAS"."CIDADE_ID"'
    end
    object QR_EMPRESACNAE: TIBStringField
      FieldName = 'CNAE'
      Origin = '"TBEMPRESAS"."CNAE"'
    end
    object QR_EMPRESACRT: TIBStringField
      FieldName = 'CRT'
      Origin = '"TBEMPRESAS"."CRT"'
      Size = 10
    end
    object QR_EMPRESAOBS_NOTA: TIBStringField
      FieldName = 'OBS_NOTA'
      Origin = '"TBEMPRESAS"."OBS_NOTA"'
      Size = 500
    end
    object QR_EMPRESADANFE_PATH: TIBStringField
      FieldName = 'DANFE_PATH'
      Origin = '"TBEMPRESAS"."DANFE_PATH"'
      Size = 600
    end
    object QR_EMPRESAAMBIENTE_NFE: TIntegerField
      FieldName = 'AMBIENTE_NFE'
      Origin = '"TBEMPRESAS"."AMBIENTE_NFE"'
    end
    object QR_EMPRESALOTE_NFE: TIntegerField
      FieldName = 'LOTE_NFE'
      Origin = '"TBEMPRESAS"."LOTE_NFE"'
    end
    object QR_EMPRESASERIE_NFE: TIBStringField
      FieldName = 'SERIE_NFE'
      Origin = '"TBEMPRESAS"."SERIE_NFE"'
      Size = 3
    end
    object QR_EMPRESALOTE_NFE_SCAN: TIntegerField
      FieldName = 'LOTE_NFE_SCAN'
      Origin = '"TBEMPRESAS"."LOTE_NFE_SCAN"'
    end
  end
end
