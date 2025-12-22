object Form_Atualizador: TForm_Atualizador
  Left = 0
  Top = 0
  Caption = 'Atualizador'
  ClientHeight = 381
  ClientWidth = 738
  Color = clBtnFace
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
    Left = 0
    Top = 0
    Width = 738
    Height = 340
    Align = alClient
    TabOrder = 0
    object Memo1: TMemo
      Left = 1
      Top = 1
      Width = 736
      Height = 338
      Align = alClient
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 340
    Width = 738
    Height = 41
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      738
      41)
    object ProgressBar1: TProgressBar
      Left = 7
      Top = 5
      Width = 724
      Height = 30
      Anchors = [akLeft, akTop, akRight, akBottom]
      BarColor = clMenuHighlight
      TabOrder = 0
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
  object IdIPWatch1: TIdIPWatch
    Active = True
    HistoryFilename = 'iphist.dat'
    Left = 568
    Top = 232
  end
end
