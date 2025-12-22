object Form_Atualizador: TForm_Atualizador
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'SIC - Atualizador de Vers'#227'o'
  ClientHeight = 381
  ClientWidth = 796
  Color = 12477460
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 10
    Top = 92
    Width = 776
    Height = 279
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      776
      279)
    object Memo1: TMemo
      Left = 8
      Top = 8
      Width = 759
      Height = 238
      ReadOnly = True
      TabOrder = 0
    end
    object ProgressBar1: TProgressBar
      Left = 8
      Top = 253
      Width = 758
      Height = 17
      Anchors = [akLeft, akTop, akRight, akBottom]
      BarColor = clMenuHighlight
      TabOrder = 1
    end
  end
  object RzPanel2: TRzPanel
    Left = 0
    Top = 0
    Width = 796
    Height = 86
    Align = alTop
    BorderOuter = fsNone
    Color = 12477460
    Font.Charset = ANSI_CHARSET
    Font.Color = 11498243
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    GradientColorStyle = gcsCustom
    GradientColorStop = 16444647
    ParentFont = False
    TabOrder = 1
    VisualStyle = vsClassic
    object Label10: TLabel
      Left = 37
      Top = 13
      Width = 437
      Height = 29
      Caption = 'SIC - Atualiza'#231#227'o de Vers'#227'o, aguarde...'
      Color = clWindow
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -24
      Font.Name = 'Trebuchet MS'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object Label12: TLabel
      Left = 37
      Top = 44
      Width = 383
      Height = 36
      Caption = 
        'Aguarde, estamos trabalhando duro para melhorarmos sempre...'#13'N'#227'o' +
        ' Desligue o computador nem for'#231'e a finaliza'#231#227'o do sistema...'
      Color = clWindow
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
  end
  object Cliente: TIdTCPClient
    OnWork = ClienteWork
    OnWorkBegin = ClienteWorkBegin
    OnWorkEnd = ClienteWorkEnd
    ConnectTimeout = 0
    Host = '192.168.0.8'
    IPVersion = Id_IPv4
    Port = 34005
    ReadTimeout = -1
    Left = 648
    Top = 24
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = Timer1Timer
    Left = 592
    Top = 24
  end
end
