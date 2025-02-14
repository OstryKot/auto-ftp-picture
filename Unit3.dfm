object Form3: TForm3
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Auto Get Picture'
  ClientHeight = 516
  ClientWidth = 666
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object Image1: TImage
    Left = 8
    Top = 8
    Width = 654
    Height = 500
  end
  object Button1: TButton
    Left = 587
    Top = 483
    Width = 75
    Height = 25
    Caption = 'Get Now'
    TabOrder = 0
    OnClick = Button1Click
  end
  object IdFTP1: TIdFTP
    ConnectTimeout = 0
    TransferType = ftBinary
    NATKeepAlive.UseKeepAlive = False
    NATKeepAlive.IdleTimeMS = 0
    NATKeepAlive.IntervalMS = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 16
    Top = 8
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 16
    Top = 64
  end
end
