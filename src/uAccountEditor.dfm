object AccountEditorFrame: TAccountEditorFrame
  Left = 0
  Top = 0
  Width = 776
  Height = 362
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object Panel2: TPanel
    Left = 0
    Top = 318
    Width = 776
    Height = 44
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnAddAccount: TBitBtn
      Left = 15
      Top = 6
      Width = 75
      Height = 25
      Action = acAddAccount
      Caption = #26032#22686#29992#25143
      TabOrder = 0
    end
    object btnSave: TBitBtn
      Left = 177
      Top = 6
      Width = 75
      Height = 25
      Action = acSave
      Caption = #20445#23384
      TabOrder = 1
    end
    object btnDelete: TBitBtn
      Left = 258
      Top = 6
      Width = 75
      Height = 25
      Action = acDelete
      Caption = #21024#38500
      TabOrder = 2
    end
    object btnAddRole: TBitBtn
      Left = 96
      Top = 6
      Width = 75
      Height = 25
      Action = acAddRole
      Caption = #26032#22686#35282#33394
      TabOrder = 3
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 776
    Height = 318
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object pLeft: TPanel
      Left = 0
      Top = 0
      Width = 273
      Height = 318
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object vtAccount: TVirtualStringTree
        Left = 0
        Top = 0
        Width = 273
        Height = 318
        Hint = 'test'
        Align = alClient
        Header.AutoSizeIndex = 0
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'Tahoma'
        Header.Font.Style = []
        Header.Options = [hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
        HintAnimation = hatFade
        HintMode = hmHint
        ParentShowHint = False
        PopupMenu = PopupMenu1
        ShowHint = True
        TabOrder = 0
        OnFocusChanged = vtAccountFocusChanged
        OnFocusChanging = vtAccountFocusChanging
        OnFreeNode = vtAccountFreeNode
        OnGetText = vtAccountGetText
        OnGetHint = vtAccountGetHint
        OnGetNodeDataSize = vtAccountGetNodeDataSize
        OnInitChildren = vtAccountInitChildren
        OnInitNode = vtAccountInitNode
        Columns = <
          item
            Position = 0
            Width = 100
            WideText = 'user_name'
          end
          item
            Position = 1
            Width = 80
            WideText = 'gender'
          end
          item
            Position = 2
            Width = 80
            WideText = 'age'
          end>
      end
    end
    object Panel1: TPanel
      Left = 273
      Top = 0
      Width = 503
      Height = 318
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object PageControl1: TPageControl
        Left = 0
        Top = 0
        Width = 503
        Height = 318
        ActivePage = tsAccount
        Align = alClient
        TabOrder = 0
        object tsAccount: TTabSheet
          Caption = #29992#25143
          object GroupBox1: TGroupBox
            Left = 16
            Top = 12
            Width = 433
            Height = 229
            Caption = #29992#25143#32534#36753
            TabOrder = 0
            object Label1: TLabel
              Left = 237
              Top = 30
              Width = 36
              Height = 13
              Caption = #24615#21035#65306
            end
            object Label4: TLabel
              Left = 237
              Top = 57
              Width = 36
              Height = 13
              Caption = #29983#26085#65306
            end
            object Label5: TLabel
              Left = 13
              Top = 94
              Width = 60
              Height = 13
              Caption = #20837#32844#26085#26399#65306
            end
            object Label6: TLabel
              Left = 25
              Top = 138
              Width = 48
              Height = 13
              Caption = #26376#24037#36164#65306
            end
            object Label7: TLabel
              Left = 213
              Top = 138
              Width = 60
              Height = 13
              Caption = #25552#25104#27604#20363#65306
            end
            object eAccountName: TLabeledEdit
              Left = 79
              Top = 27
              Width = 111
              Height = 21
              EditLabel.Width = 48
              EditLabel.Height = 13
              EditLabel.Caption = #29992#25143#21517#65306
              LabelPosition = lpLeft
              TabOrder = 0
              OnChange = AnyControlChange
            end
            object ePassword: TLabeledEdit
              Left = 79
              Top = 54
              Width = 111
              Height = 21
              EditLabel.Width = 36
              EditLabel.Height = 13
              EditLabel.Caption = #23494#30721#65306
              LabelPosition = lpLeft
              PasswordChar = '*'
              TabOrder = 1
              OnChange = AnyControlChange
            end
            object eAge: TLabeledEdit
              Left = 279
              Top = 81
              Width = 111
              Height = 21
              EditLabel.Width = 36
              EditLabel.Height = 13
              EditLabel.Caption = #24180#40836#65306
              LabelPosition = lpLeft
              ReadOnly = True
              TabOrder = 2
              OnChange = AnyControlChange
            end
            object eEducation: TLabeledEdit
              Left = 279
              Top = 108
              Width = 111
              Height = 21
              EditLabel.Width = 36
              EditLabel.Height = 13
              EditLabel.Caption = #23398#21382#65306
              LabelPosition = lpLeft
              TabOrder = 3
              OnChange = AnyControlChange
            end
            object cbGender: TComboBox
              Left = 279
              Top = 27
              Width = 111
              Height = 21
              TabOrder = 4
              OnChange = AnyControlChange
              Items.Strings = (
                ''
                #30007
                #22899)
            end
            object ePhone: TLabeledEdit
              Left = 79
              Top = 162
              Width = 111
              Height = 21
              EditLabel.Width = 60
              EditLabel.Height = 13
              EditLabel.Caption = #30005#35805#21495#30721#65306
              LabelPosition = lpLeft
              TabOrder = 5
              OnChange = AnyControlChange
            end
            object eAddress: TLabeledEdit
              Left = 79
              Top = 189
              Width = 311
              Height = 21
              EditLabel.Width = 36
              EditLabel.Height = 13
              EditLabel.Caption = #22320#22336#65306
              LabelPosition = lpLeft
              TabOrder = 6
              OnChange = AnyControlChange
            end
            object eEmail: TLabeledEdit
              Left = 279
              Top = 162
              Width = 111
              Height = 21
              EditLabel.Width = 60
              EditLabel.Height = 13
              EditLabel.Caption = #30005#23376#37038#20214#65306
              LabelPosition = lpLeft
              TabOrder = 7
              OnChange = AnyControlChange
            end
            object dtpEntryDate: TDateTimePicker
              Left = 79
              Top = 81
              Width = 111
              Height = 21
              Date = 41515.712625138890000000
              Time = 41515.712625138890000000
              TabOrder = 8
              OnChange = AnyControlChange
            end
          end
          object dtpBirthday: TDateTimePicker
            Left = 295
            Top = 66
            Width = 111
            Height = 21
            Date = 41515.712625138890000000
            Time = 41515.712625138890000000
            TabOrder = 1
            OnChange = dtpBirthdayChange
          end
          object eSalary: TcurrEdit
            Left = 95
            Top = 147
            Width = 111
            Height = 21
            Alignment = taRightJustify
            TabOrder = 2
            Text = #65509'0.'
            OnChange = AnyControlChange
            IntDigits = 0
            DecimalDigits = 0
            Multiple = 1.000000000000000000
            Prefix = #65509
          end
          object eRoyaltyRate: TcurrEdit
            Left = 295
            Top = 147
            Width = 111
            Height = 21
            Alignment = taRightJustify
            TabOrder = 3
            Text = '0.00%'
            OnChange = AnyControlChange
            IntDigits = 0
            DecimalDigits = 2
            Multiple = 100.000000000000000000
            Sufix = '%'
          end
          object cbInservice: TCheckBox
            Left = 95
            Top = 124
            Width = 111
            Height = 17
            BiDiMode = bdLeftToRight
            Caption = #26159#21542#22312#32844
            ParentBiDiMode = False
            TabOrder = 4
          end
        end
        object tsRole: TTabSheet
          Caption = #35282#33394
          ImageIndex = 1
          object Label2: TLabel
            Left = 20
            Top = 127
            Width = 48
            Height = 13
            Caption = #32534#36753#26435#38480
          end
          object GroupBox2: TGroupBox
            Left = 16
            Top = 15
            Width = 433
            Height = 106
            Caption = #35282#33394#32534#36753
            TabOrder = 0
            object Label3: TLabel
              Left = 55
              Top = 52
              Width = 60
              Height = 13
              Caption = #35282#33394#35828#26126#65306
            end
            object eRoleName: TLabeledEdit
              Left = 119
              Top = 22
              Width = 210
              Height = 21
              EditLabel.Width = 48
              EditLabel.Height = 13
              EditLabel.Caption = #35282#33394#21517#65306
              LabelPosition = lpLeft
              TabOrder = 0
              OnChange = AnyControlChange
            end
            object eRoleInfo: TMemo
              Left = 119
              Top = 49
              Width = 210
              Height = 40
              Lines.Strings = (
                '')
              TabOrder = 1
              OnChange = AnyControlChange
            end
          end
          object pcRights: TPageControl
            Left = 16
            Top = 150
            Width = 433
            Height = 134
            TabOrder = 1
          end
          object CheckBox1: TCheckBox
            Left = 135
            Top = 127
            Width = 97
            Height = 17
            Action = acCancelRight
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
          end
          object CheckBox2: TCheckBox
            Left = 248
            Top = 127
            Width = 97
            Height = 17
            Action = acGrayRight
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
          end
          object CheckBox3: TCheckBox
            Left = 351
            Top = 127
            Width = 97
            Height = 17
            Action = acHaveRight
            Checked = True
            ParentShowHint = False
            ShowHint = True
            State = cbChecked
            TabOrder = 4
          end
        end
      end
    end
  end
  object AccountBindScope: TBindScope
    AutoActivate = False
    Left = 56
    Top = 56
  end
  object RoleBindScope: TBindScope
    AutoActivate = False
    Left = 56
    Top = 104
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    UseAppManager = True
    Left = 104
    Top = 56
  end
  object ActionList1: TActionList
    Left = 104
    Top = 104
    object acAddAccount: TAction
      Category = 'Account'
      Caption = #26032#22686#29992#25143
      OnExecute = acAddAccountExecute
    end
    object acAddRole: TAction
      Category = 'Account'
      Caption = #26032#22686#35282#33394
      OnExecute = acAddRoleExecute
    end
    object acSave: TAction
      Category = 'Account'
      Caption = #20445#23384
      OnExecute = acSaveExecute
    end
    object acDelete: TAction
      Category = 'Account'
      Caption = #21024#38500
      OnExecute = acDeleteExecute
    end
    object acSelectAllRight: TAction
      Category = 'Right'
      Caption = #20840#36873
      OnExecute = acSelectAllRightExecute
    end
    object acCancelRight: TAction
      Category = 'Right'
      Caption = #21462#28040#26435#38480
      OnExecute = acCancelRightExecute
    end
    object acGrayRight: TAction
      Category = 'Right'
      Caption = #26435#38480#20165#21487#35265
      OnExecute = acGrayRightExecute
    end
    object acHaveRight: TAction
      Category = 'Right'
      Caption = #33719#21462#26435#38480
      OnExecute = acHaveRightExecute
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 48
    Top = 168
    object N1: TMenuItem
      Action = acAddAccount
    end
    object N2: TMenuItem
      Action = acAddRole
    end
    object N4: TMenuItem
      Action = acSave
    end
    object N3: TMenuItem
      Action = acDelete
    end
  end
  object msgHint: TBalloonHint
    Delay = 0
    Left = 176
    Top = 56
  end
  object PopupMenu2: TPopupMenu
    Left = 184
    Top = 176
    object N5: TMenuItem
      Action = acSelectAllRight
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object N6: TMenuItem
      Action = acCancelRight
    end
    object N7: TMenuItem
      Action = acGrayRight
    end
    object N8: TMenuItem
      Action = acHaveRight
    end
  end
end
