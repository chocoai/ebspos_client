object GoodsEditor: TGoodsEditor
  Left = 0
  Top = 0
  Width = 741
  Height = 386
  TabOrder = 0
  object JvNetscapeSplitter1: TJvNetscapeSplitter
    Left = 645
    Top = 0
    Height = 386
    Align = alRight
    MinSize = 1
    Maximized = False
    Minimized = False
    ButtonCursor = crDefault
    ExplicitLeft = 8
    ExplicitTop = 144
    ExplicitHeight = 100
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 645
    Height = 386
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object vtGoods: TVirtualStringTree
      Left = 0
      Top = 22
      Width = 645
      Height = 322
      Align = alClient
      Header.AutoSizeIndex = 0
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      Header.MainColumn = -1
      PopupMenu = PopupMenu1
      TabOrder = 0
      ExplicitTop = 35
      ExplicitHeight = 309
      Columns = <>
    end
    object Panel3: TPanel
      Left = 0
      Top = 344
      Width = 645
      Height = 42
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object BitBtn1: TBitBtn
        Left = 16
        Top = 6
        Width = 75
        Height = 25
        Action = acAdd
        Caption = #26032#22686
        TabOrder = 0
      end
      object BitBtn2: TBitBtn
        Left = 97
        Top = 6
        Width = 75
        Height = 25
        Action = acSave
        Caption = #20445#23384
        TabOrder = 1
      end
      object BitBtn3: TBitBtn
        Left = 178
        Top = 6
        Width = 75
        Height = 25
        Action = acDelete
        Caption = #21024#38500
        TabOrder = 2
      end
    end
    object Panel4: TPanel
      Left = 0
      Top = 0
      Width = 645
      Height = 22
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object ToolBar1: TToolBar
        Left = 270
        Top = 0
        Width = 375
        Height = 22
        Align = alRight
        AutoSize = True
        ButtonWidth = 75
        Caption = 'ToolBar1'
        Images = MainForm.ImageListMain
        List = True
        ShowCaptions = True
        TabOrder = 0
        ExplicitLeft = 0
        ExplicitWidth = 75
        ExplicitHeight = 645
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Action = acNext
          Style = tbsTextButton
        end
        object ToolButton2: TToolButton
          Left = 75
          Top = 0
          Action = acShowAll
          Style = tbsTextButton
        end
        object ToolButton3: TToolButton
          Left = 150
          Top = 0
          Action = acSort
          Style = tbsTextButton
        end
        object ToolButton4: TToolButton
          Left = 225
          Top = 0
          Action = acColumns
          Style = tbsTextButton
        end
        object ToolButton5: TToolButton
          Left = 300
          Top = 0
          Action = acFliter
          Style = tbsTextButton
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 655
    Top = 0
    Width = 86
    Height = 386
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
  end
  object GoodsActionList: TActionList
    Left = 472
    Top = 48
    object acAdd: TAction
      Caption = #26032#22686
    end
    object acSave: TAction
      Caption = #20445#23384
    end
    object acDelete: TAction
      Caption = #21024#38500
    end
    object acFind: TAction
      Caption = #26597#25214
    end
    object acNext: TAction
      Caption = #19979#19968#39029
      ImageIndex = 8
    end
    object acShowAll: TAction
      Caption = #26174#31034#20840#37096
      ImageIndex = 9
    end
    object acSort: TAction
      Caption = #25490#24207
      ImageIndex = 10
    end
    object acColumns: TAction
      Caption = #26174#31034#21015
      ImageIndex = 11
    end
    object acFliter: TAction
      Caption = #36807#28388
      ImageIndex = 12
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 568
    Top = 48
    object N1: TMenuItem
      Action = acAdd
    end
    object N2: TMenuItem
      Action = acSave
    end
    object N3: TMenuItem
      Action = acDelete
    end
  end
end
