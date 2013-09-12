object AccountForm: TAccountForm
  Left = 0
  Top = 0
  Caption = 'AccountForm'
  ClientHeight = 375
  ClientWidth = 765
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnHide = FormHide
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inline AccountEditorFrame1: TAccountEditorFrame
    Left = 0
    Top = 0
    Width = 765
    Height = 375
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 765
    ExplicitHeight = 375
    inherited Panel2: TPanel
      Top = 331
      Width = 765
      ExplicitTop = 331
      ExplicitWidth = 765
    end
    inherited Panel3: TPanel
      Width = 765
      Height = 331
      ExplicitWidth = 765
      ExplicitHeight = 331
      inherited pLeft: TPanel
        Height = 331
        ExplicitHeight = 331
        inherited vtAccount: TVirtualStringTree
          Height = 331
          ExplicitHeight = 331
        end
      end
      inherited Panel1: TPanel
        Width = 492
        Height = 331
        ExplicitWidth = 492
        ExplicitHeight = 331
        inherited PageControl1: TPageControl
          Width = 492
          Height = 331
          ExplicitWidth = 492
          ExplicitHeight = 331
          inherited tsRole: TTabSheet
            ExplicitWidth = 484
            ExplicitHeight = 303
          end
        end
      end
    end
  end
end
