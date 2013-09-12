object GoodsForm: TGoodsForm
  Left = 0
  Top = 0
  Caption = 'GoodsForm'
  ClientHeight = 343
  ClientWidth = 610
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
  inline GoodsEditor1: TGoodsEditor
    Left = 0
    Top = 0
    Width = 610
    Height = 343
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 610
    ExplicitHeight = 343
    inherited JvNetscapeSplitter1: TJvNetscapeSplitter
      Left = 514
      Height = 343
      ExplicitLeft = 410
      ExplicitHeight = 343
    end
    inherited Panel1: TPanel
      Width = 514
      Height = 343
      ExplicitWidth = 514
      ExplicitHeight = 343
      inherited vtGoods: TVirtualStringTree
        Width = 514
        Height = 279
        ExplicitTop = 22
        ExplicitWidth = 514
        ExplicitHeight = 279
      end
      inherited Panel3: TPanel
        Top = 301
        Width = 514
        ExplicitTop = 301
        ExplicitWidth = 514
      end
      inherited Panel4: TPanel
        Width = 514
        ExplicitWidth = 514
        inherited ToolBar1: TToolBar
          Left = 139
          ExplicitLeft = 139
          ExplicitWidth = 375
          ExplicitHeight = 22
        end
      end
    end
    inherited Panel2: TPanel
      Left = 524
      Height = 343
      ExplicitLeft = 524
      ExplicitHeight = 343
    end
    inherited PopupMenu1: TPopupMenu
      Left = 208
    end
  end
end
