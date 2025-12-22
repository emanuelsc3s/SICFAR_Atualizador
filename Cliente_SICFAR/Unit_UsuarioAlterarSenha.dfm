object Form_UsuarioAlterarSenha: TForm_UsuarioAlterarSenha
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Alterar Senha'
  ClientHeight = 105
  ClientWidth = 331
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 12
    Top = 7
    Width = 69
    Height = 13
    Caption = 'Nova Senha'
  end
  object Label3: TLabel
    Left = 12
    Top = 53
    Width = 131
    Height = 13
    Caption = 'Confirmar Nova Senha'
  end
  object Edit_NovaSenha: TEdit
    Left = 12
    Top = 26
    Width = 200
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
    OnExit = Edit_NovaSenhaExit
  end
  object Edit_CNovaSenha: TEdit
    Left = 12
    Top = 72
    Width = 200
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
    OnExit = Edit_CNovaSenhaExit
  end
  object btn_Salvar: TButton
    Left = 235
    Top = 70
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 2
    OnClick = btn_SalvarClick
  end
  object QR_LOGIN: TIBQuery
    Database = dm1.IBDatabase1
    Transaction = dm1.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from TBUSUARIO U'
      '  WHERE u.deletado = '#39'N'#39
      '  and NOME = :NOME'
      '  and SENHA = :SENHA')
    Left = 234
    Top = 17
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'NOME'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'SENHA'
        ParamType = ptUnknown
      end>
  end
  object DS_Login: TIBDataSet
    Database = dm1.IBDatabase1
    Transaction = dm1.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from TBUSUARIO'
      'where'
      '  USUARIO_ID = :OLD_USUARIO_ID')
    InsertSQL.Strings = (
      'insert into TBUSUARIO'
      '  (USUARIO_ID, EXPIRACAO, SENHA)'
      'values'
      '  (:USUARIO_ID, :EXPIRACAO, :SENHA)')
    RefreshSQL.Strings = (
      'Select '
      '  USUARIO_ID,'
      '  NOME,'
      '  SENHA,'
      '  PERFIL_ID,'
      '  DELETADO,'
      '  DATA_INC,'
      '  USUARIO_I,'
      '  USUARIONOME_I,'
      '  DATA_ALT,'
      '  USUARIO_A,'
      '  USUARIONOME_A,'
      '  DATA_DEL,'
      '  USUARIO_D,'
      '  USUARIONOME_D,'
      '  EMAIL,'
      '  RAMAL,'
      '  ERP_VENDEDOR,'
      '  ERP_REPRESENTANTE,'
      '  GRUPO_PRODUTO,'
      '  VENDEDOR_ID,'
      '  REPRESENTANTE_ID,'
      '  BANCOS,'
      '  DEPARTAMENTO_ID,'
      '  DEPARTAMENTO,'
      '  NOME_FANTASIA,'
      '  EXPIRACAO'
      'from TBUSUARIO '
      'where'
      '  USUARIO_ID = :USUARIO_ID')
    SelectSQL.Strings = (
      'SELECT USUARIO_ID, EXPIRACAO, SENHA from TBUSUARIO')
    ModifySQL.Strings = (
      'update TBUSUARIO'
      'set'
      '  USUARIO_ID = :USUARIO_ID,'
      '  EXPIRACAO = :EXPIRACAO,'
      '  SENHA = :SENHA'
      'where'
      '  USUARIO_ID = :OLD_USUARIO_ID')
    ParamCheck = True
    UniDirectional = False
    Left = 279
    Top = 6
    object DS_LoginUSUARIO_ID: TIntegerField
      FieldName = 'USUARIO_ID'
      Origin = '"TBUSUARIO"."USUARIO_ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object DS_LoginEXPIRACAO: TDateField
      FieldName = 'EXPIRACAO'
      Origin = '"TBUSUARIO"."EXPIRACAO"'
    end
    object DS_LoginSENHA: TIBStringField
      FieldName = 'SENHA'
      Origin = '"TBUSUARIO"."SENHA"'
      Size = 32
    end
  end
end
