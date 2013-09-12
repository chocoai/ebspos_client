object LoginForm: TLoginForm
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'LoginForm'
  ClientHeight = 173
  ClientWidth = 438
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object eLoginName: TLabeledEdit
    Left = 144
    Top = 32
    Width = 247
    Height = 21
    EditLabel.Width = 108
    EditLabel.Height = 13
    EditLabel.Caption = #35831#36755#20837#30331#20837#29992#25143#21517#65306
    LabelPosition = lpLeft
    TabOrder = 0
  end
  object eLoginPassword: TLabeledEdit
    Left = 144
    Top = 80
    Width = 247
    Height = 21
    EditLabel.Width = 96
    EditLabel.Height = 13
    EditLabel.Caption = #35831#36755#20837#30331#20837#23494#30721#65306
    LabelPosition = lpLeft
    PasswordChar = '*'
    TabOrder = 1
    OnKeyUp = eLoginPasswordKeyUp
  end
  object btnOK: TBitBtn
    Left = 220
    Top = 128
    Width = 75
    Height = 25
    Caption = #30331#20837
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    Left = 316
    Top = 128
    Width = 75
    Height = 25
    Caption = #21462#28040
    TabOrder = 3
    OnClick = btnCancelClick
  end
  object msgHint: TBalloonHint
    Delay = 0
    Left = 48
    Top = 136
  end
end
