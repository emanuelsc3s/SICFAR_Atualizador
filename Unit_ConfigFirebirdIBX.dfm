object Form_ConfigFirebirdIBX: TForm_ConfigFirebirdIBX
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Configura'#231#227'o de Conex'#227'o Firebird'
  ClientHeight = 380
  ClientWidth = 500
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 500
    Height = 60
    Align = alTop
    Color = 12373300
    ParentBackground = False
    TabOrder = 0
    object Label14: TLabel
      Left = 70
      Top = 8
      Width = 280
      Height = 24
      Caption = 'Configura'#231#227'o Firebird'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -20
      Font.Name = 'Trebuchet MS'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label15: TLabel
      Left = 70
      Top = 35
      Width = 200
      Height = 16
      Caption = 'Par'#226'metros de Conex'#227'o IBX'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
    end
    object Image1: TImage
      Left = 12
      Top = 6
      Width = 48
      Height = 48
      Stretch = True
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 70
    Width = 484
    Height = 250
    Caption = ' Par'#226'metros de Conex'#227'o '
    TabOrder = 1
    object LabelServidor: TLabel
      Left = 16
      Top = 28
      Width = 52
      Height = 13
      Caption = 'Servidor:'
    end
    object LabelPorta: TLabel
      Left = 330
      Top = 28
      Width = 35
      Height = 13
      Caption = 'Porta:'
    end
    object LabelCaminho: TLabel
      Left = 16
      Top = 72
      Width = 103
      Height = 13
      Caption = 'Caminho do Banco:'
    end
    object LabelUsuario: TLabel
      Left = 16
      Top = 116
      Width = 47
      Height = 13
      Caption = 'Usu'#225'rio:'
    end
    object LabelSenha: TLabel
      Left = 250
      Top = 116
      Width = 39
      Height = 13
      Caption = 'Senha:'
    end
    object LabelCharSet: TLabel
      Left = 16
      Top = 160
      Width = 77
      Height = 13
      Caption = 'Character Set:'
    end
    object LabelDialeto: TLabel
      Left = 250
      Top = 160
      Width = 70
      Height = 13
      Caption = 'Dialeto SQL:'
    end
    object EditServidor: TEdit
      Left = 16
      Top = 44
      Width = 300
      Height = 21
      TabOrder = 0
      Text = 'localhost'
    end
    object EditPorta: TEdit
      Left = 330
      Top = 44
      Width = 65
      Height = 21
      TabOrder = 1
      Text = '3050'
    end
    object EditCaminhoBanco: TEdit
      Left = 16
      Top = 88
      Width = 379
      Height = 21
      TabOrder = 2
    end
    object btnBrowse: TButton
      Left = 401
      Top = 86
      Width = 65
      Height = 25
      Caption = '...'
      TabOrder = 3
      OnClick = btnBrowseClick
    end
    object EditUsuario: TEdit
      Left = 16
      Top = 132
      Width = 218
      Height = 21
      TabOrder = 4
      Text = 'SYSDBA'
    end
    object EditSenha: TEdit
      Left = 250
      Top = 132
      Width = 216
      Height = 21
      PasswordChar = '*'
      TabOrder = 5
    end
    object ComboCharacterSet: TComboBox
      Left = 16
      Top = 176
      Width = 218
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 6
      Text = 'WIN1252'
      Items.Strings = (
        'WIN1252'
        'UTF8'
        'ISO8859_1'
        'NONE')
    end
    object ComboDialeto: TComboBox
      Left = 250
      Top = 176
      Width = 80
      Height = 21
      Style = csDropDownList
      ItemIndex = 1
      TabOrder = 7
      Text = '3'
      Items.Strings = (
        '1'
        '3')
    end
    object CheckBoxConexaoLocal: TCheckBox
      Left = 400
      Top = 47
      Width = 75
      Height = 17
      Caption = 'Local'
      TabOrder = 8
      OnClick = CheckBoxConexaoLocalClick
    end
  end
  object PanelBotoes: TPanel
    Left = 0
    Top = 330
    Width = 500
    Height = 50
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btnTestarConexao: TPanel
      Left = 8
      Top = 8
      Width = 130
      Height = 35
      Cursor = crHandPoint
      Caption = 'Testar Conex'#227'o'
      Color = clHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      OnClick = btnTestarConexaoClick
    end
    object btnSalvar: TPanel
      Left = 280
      Top = 8
      Width = 100
      Height = 35
      Cursor = crHandPoint
      Caption = 'Salvar'
      Color = clGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      OnClick = btnSalvarClick
    end
    object btnFechar: TPanel
      Left = 390
      Top = 8
      Width = 100
      Height = 35
      Cursor = crHandPoint
      Caption = 'Fechar'
      Color = clMaroon
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      OnClick = btnFecharClick
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.fdb'
    Filter = 'Firebird Database|*.fdb;*.gdb|Todos os Arquivos|*.*'
    Title = 'Selecione o arquivo de banco de dados Firebird'
    Left = 440
    Top = 16
  end
end
