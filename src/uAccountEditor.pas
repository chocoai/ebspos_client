unit uAccountEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids,
  SynCommons, mORMot, VirtualTrees, Vcl.ExtCtrls,
  mORMotSQLite3, uModel, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.CheckLst, uIEventFrame,
  Vcl.Mask,
  System.Rtti,
  // LiveBinding units
  System.Bindings.Helper,     // Contains TBindings class
  Data.Bind.EngExt,
  Vcl.Bind.DBEngExt,
  Data.Bind.Components,
  uCustomerBindingConverter,
  System.Bindings.Outputs, currEdit, Vcl.ActnList, Vcl.Menus;
  
type
  TAccountEditorFrame = class(TFrame, IEventFrame)
    pLeft: TPanel;
    Panel1: TPanel;
    vtAccount: TVirtualStringTree;
    PageControl1: TPageControl;
    tsAccount: TTabSheet;
    tsRole: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    eAccountName: TLabeledEdit;
    ePassword: TLabeledEdit;
    eAge: TLabeledEdit;
    eEducation: TLabeledEdit;
    cbGender: TComboBox;
    ePhone: TLabeledEdit;
    eAddress: TLabeledEdit;
    eEmail: TLabeledEdit;
    AccountBindScope: TBindScope;
    RoleBindScope: TBindScope;
    dtpBirthday: TDateTimePicker;
    dtpEntryDate: TDateTimePicker;
    eSalary: TcurrEdit;
    eRoyaltyRate: TcurrEdit;
    BindingsList1: TBindingsList;
    cbInservice: TCheckBox;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    eRoleName: TLabeledEdit;
    eRoleInfo: TMemo;
    Panel2: TPanel;
    Panel3: TPanel;
    btnAddAccount: TBitBtn;
    btnSave: TBitBtn;
    btnDelete: TBitBtn;
    ActionList1: TActionList;
    acAddAccount: TAction;
    acAddRole: TAction;
    acSave: TAction;
    acDelete: TAction;
    PopupMenu1: TPopupMenu;
    btnAddRole: TBitBtn;
    msgHint: TBalloonHint;
    pcRights: TPageControl;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    PopupMenu2: TPopupMenu;
    acSelectAllRight: TAction;
    acCancelRight: TAction;
    acGrayRight: TAction;
    acHaveRight: TAction;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    procedure vtAccountFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtAccountFocusChanging(Sender: TBaseVirtualTree; OldNode,
      NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
      var Allowed: Boolean);
    procedure vtAccountFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtAccountGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure vtAccountGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: String);
    procedure vtAccountInitChildren(Sender: TBaseVirtualTree;
      Node: PVirtualNode; var ChildCount: Cardinal);
    procedure vtAccountInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtAccountGetHint(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var LineBreakStyle: TVTTooltipLineBreakStyle;
      var HintText: string);
    procedure AnyControlChange(Sender: TObject);
    procedure dtpBirthdayChange(Sender: TObject);
    procedure acAddAccountExecute(Sender: TObject);
    procedure acAddRoleExecute(Sender: TObject);
    procedure acSaveExecute(Sender: TObject);
    procedure acDeleteExecute(Sender: TObject);
    procedure acCancelRightExecute(Sender: TObject);
    procedure acGrayRightExecute(Sender: TObject);
    procedure acHaveRightExecute(Sender: TObject);
    procedure acSelectAllRightExecute(Sender: TObject);
    procedure acUnSelectAllRightExecute(Sender: TObject);
  private
    { Private declarations }
    fOnShow: TNotifyEvent;
    fOnHide: TNotifyEvent;

    fLoaded: Boolean;
    fModified: Boolean;
    
    fRole: TSQLRole;
    
    fCurrentAccount: TSQLAccount;
    fCurrentRole: TSQLRole;
    
    procedure DoOnGridDblClick(Sender: TObject);
    
    procedure ShowAllAccount;
    
    procedure InitControl;
    //live binding
    procedure InitBinding;
    procedure InitAccountBinding;
    procedure InitRoleBinding;
    
    procedure LoadAccount(account: TSQLAccount);
    procedure SaveAccount(account: TSQLAccount; RoleID: Integer);
    procedure DeleteAccount(account: TSQLAccount);
    procedure LoadRole(role: TSQLRole);
    procedure SaveRole(role: TSQLRole);
    procedure DeleteRole(role: TSQLRole);
    procedure LoadRights(role: TSQLRole);
    procedure SaveRights(role: TSQLRole);
    function CheckRightsModified: Boolean;
    
    procedure SelectAndFocus(node: PVirtualNode);
    function GetErrorControlByIndex_Account(invalidFieldIndex: Integer): TWinControl;
    function GetErrorControlByIndex_Role(invalidFieldIndex: Integer): TWinControl;
    procedure InitRights;
    procedure DoOnListBoxClick(Sender: TObject);
    procedure SetSelectedCheckBoxState(state: TCheckBoxState);
    procedure SetActionState;
  protected
  published
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoOnShow(Sender: TObject);
    procedure DoOnHide(Sender: TObject);
    procedure DoOnResize(Sender: TObject);
  end;
  
  TAccountTreeData = record
    Role: TSQLRole;
    Account: TSQLAccount;
  end;
  
  PAccountTreeData = ^TAccountTreeData;
  
implementation
uses
  uDataBase, SynDBSQLite3, mORMoti18n, uHelper, StrUtils, uSession, uMain;

{$R *.dfm}


constructor TAccountEditorFrame.Create(AOwner: TComponent);
begin
  inherited;
  InitControl;
  InitBinding;
end;

destructor TAccountEditorFrame.Destroy;
begin
  if Assigned(fRole) then
    FreeAndNil(fRole);
  if Assigned(fCurrentAccount) then
    FreeAndNil(fCurrentAccount);
  if Assigned(fCurrentRole) then
    FreeAndNil(fCurrentRole);
  inherited;
end;

procedure TAccountEditorFrame.DoOnShow(Sender: TObject);
begin
  if not fLoaded then
  begin
    fLoaded := true;
    ShowAllAccount;
    
    CheckBox1.State := TCheckBoxState.cbUnchecked;
    CheckBox2.State := TCheckBoxState.cbGrayed;
    CheckBox3.State := TCheckBoxState.cbChecked;
  end;
end;

procedure TAccountEditorFrame.dtpBirthdayChange(Sender: TObject);
var
  nodeData: PAccountTreeData;
begin
  AnyControlChange(Sender);
  //refresh age
  nodeData := vtAccount.GetNodeData(vtAccount.FocusedNode);
  if Assigned(nodeData) and Assigned(nodeData.Account) then
  begin
    AccountBindScope.DataObject := fCurrentAccount;
  end;
end;

procedure TAccountEditorFrame.InitControl;
begin
  InitRights;
end;

procedure TAccountEditorFrame.acAddAccountExecute(Sender: TObject);
var
  nodeData, parentData, newData: PAccountTreeData;
  account: TSQLAccount;
  child: PVirtualNode;
  t: TTimeLog;
begin
  //create new account or role
  nodeData := vtAccount.GetNodeData(vtAccount.FocusedNode);
  if Assigned(nodeData) then
  begin
    if Assigned(nodeData.Account) then
    begin
      //add account
      child := vtAccount.AddChild(vtAccount.FocusedNode.Parent, nil);
    end
    else if Assigned(nodeData.Role) then
    begin
      //add account to sub
      child := vtAccount.AddChild(vtAccount.FocusedNode, nil);
    end
    else
      Exit;

    account := TSQLAccount.Create;
    account.ID := 0;
    account.account_name := StringToUTF8('未命名');
    Iso8601(t).FromNow;
    account.birthday := t;
    account.entry_date := t;
    newData := vtAccount.GetNodeData(child);
    newData.Account := account;
    newData.Role := nil;
    SelectAndFocus(child);
    fModified := True;
    vtAccount.InvalidateNode(child);
    SetActionState;
    PageControl1.ActivePageIndex := 0;
  end;
end;

procedure TAccountEditorFrame.acAddRoleExecute(Sender: TObject);
var
  newData: PAccountTreeData;
  account: TSQLAccount;
  role: TSQLRole;
  child: PVirtualNode;
begin
  //add role
  role := TSQLRole.Create;
  role.ID := 0;
  role.role_name := StringToUTF8('未命名');
  child := vtAccount.AddChild(vtAccount.RootNode, nil);
  newData := vtAccount.GetNodeData(child);
  newData.Role := role;
  newData.Account := nil;
  SelectAndFocus(child);
  fModified := True;
  SetActionState;
  vtAccount.InvalidateNode(child);
  PageControl1.ActivePageIndex := 1;
end;

procedure TAccountEditorFrame.acDeleteExecute(Sender: TObject);
var
  nodeData: PAccountTreeData;
begin
  //
  nodeData := vtAccount.GetNodeData(vtAccount.FocusedNode);
  if Assigned(nodeData) then
  begin
    if Assigned(nodeData.Account) then
    begin
      if (nodeData.Account.ID > 0) and (MessageDlg('确实要删除该账户吗？',  mtConfirmation, [mbYes, mbNo], 0) = mrNo) then
        Exit;
      DeleteAccount(nodeData.Account);
      fModified := False;
    end;

    if Assigned(nodeData.Role) then
    begin
      if (nodeData.Role.ID > 0) and (MessageDlg('确实要删除该权限及所有属于该权限的用户吗？', mtConfirmation, [mbYes, mbNo], 0) = mrNo) then
        Exit;
      DeleteRole(nodeData.Role);
      fModified := False;
    end;
    SetActionState;
  end;
end;

procedure TAccountEditorFrame.acCancelRightExecute(Sender: TObject);
begin
  CheckBox1.State := TCheckBoxState.cbUnchecked;
  SetSelectedCheckBoxState(TCheckBoxState.cbUnchecked);
end;

procedure TAccountEditorFrame.acGrayRightExecute(Sender: TObject);
begin
  CheckBox2.State := TCheckBoxState.cbGrayed;
  SetSelectedCheckBoxState(TCheckBoxState.cbGrayed);
end;

procedure TAccountEditorFrame.acHaveRightExecute(Sender: TObject);
begin
  CheckBox3.State := TCheckBoxState.cbChecked;
  SetSelectedCheckBoxState(TCheckBoxState.cbChecked);
end;

procedure TAccountEditorFrame.acSaveExecute(Sender: TObject);
var
  nodeData, parentData: PAccountTreeData;
begin
  //
  msgHint.HideHint;
  nodeData := vtAccount.GetNodeData(vtAccount.FocusedNode);
  if Assigned(nodeData) then
  begin
    if Assigned(nodeData.Account) and fModified then
    begin
      parentData := vtAccount.GetNodeDAta(vtAccount.FocusedNode.Parent);
      SaveAccount(nodeData.Account, parentData.Role.ID);
      fModified := False;
      vtAccount.InvalidateNode(vtAccount.FocusedNode);
    end;

    if Assigned(nodeData.Role) and fModified then
    begin
      SaveRole(nodeData.Role);
      SaveRights(nodeData.Role);
      fModified := False;
      vtAccount.InvalidateNode(vtAccount.FocusedNode);
    end;
    SetActionState;
  end;
end;

procedure TAccountEditorFrame.acSelectAllRightExecute(Sender: TObject);
var
  checkListBox: TCheckListBox;
begin
  checkListBox := pcRights.ActivePage.Controls[0] as TCheckListBox;
  if checkListBox <> nil then
    checkListBox.SelectAll;
end;

procedure TAccountEditorFrame.acUnSelectAllRightExecute(Sender: TObject);
var
  checkListBox: TCheckListBox;
  i: Integer;
begin
  checkListBox := pcRights.ActivePage.Controls[0] as TCheckListBox;
  if checkListBox <> nil then
  for I := 0 to checkListBox.Count - 1 do
    checkListBox.Selected[i] := False;
end;

procedure TAccountEditorFrame.AnyControlChange(Sender: TObject);
var
  nodeData: PAccountTreeData;
begin
//
  if not fLoaded then
    Exit;
  if Assigned(BindingsList1) then
    BindingsList1.Notify(Sender, '');
  
  //check if account if modified
  nodeData := vtAccount.GetNodeData(vtAccount.FocusedNode);
  if Assigned(nodeData) then
  begin
    if Assigned(nodeData.Account) then
    begin
      if nodeData.Account.ID = 0 then //append new
        fModified := True
      else
        fModified := not nodeData.Account.SameValues(fCurrentAccount);
    end;
    if Assigned(nodeData.Role) then
    begin
      if nodeData.Role.ID = 0 then //append new
        fModified := True
      else
        fModified := not nodeDAta.Role.SameValues(fCurrentRole);
    end;
    vtAccount.InvalidateNode(vtAccount.FocusedNode);
    SetActionState;
  end;
end;

procedure TAccountEditorFrame.DoOnHide(Sender: TObject);
begin
  msgHint.HideHint;
end;

procedure TAccountEditorFrame.DoOnGridDblClick(Sender: TObject);
begin
  
end;

procedure TAccountEditorFrame.ShowAllAccount;
var
  nodeData: PAccountTreeData;
  child: PVirtualNode;
  accountRoleMap: TSQLAccountRoleMap;
begin
  FixVT(vtAccount);
  fRole := TSQLRole.CreateAndFillPrepare(TContext.Instance.DataBase, '', []);

  while fRole.FillOne do
  begin
    child := vtAccount.AddChild(nil);
    nodeData := vtAccount.GetNodeData(child);
    if Assigned(nodeData) then
    begin
      nodeData.Role := TSQLRole(fRole.CreateCopy);
      if Assigned(nodeData.Role) and (nodeData.Role.ID > 0) then
      begin
        accountRoleMap := TSQLAccountRoleMap.CreateAndFillPrepare(TContext.Instance.DataBase, 'role=?', [Int64ToUtf8(nodeData.Role.ID)]);
        if accountRoleMap.FillTable.RowCount > 0 then
          vtAccount.HasChildren[child] := True;
        FreeAndNil(accountRoleMap);
      end;
      if TUserSession.Instance.Role.ID = nodeData.Role.ID then
        vtAccount.Expanded[child] := True;
    end;
  end;
end;

procedure TAccountEditorFrame.vtAccountFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
var
  nodeData: PAccountTreeData;
begin
  nodeData := vtAccount.GetNodeData(Node);
  if Assigned(nodeData) then
  begin
    if Assigned(nodeData.Account) then
    begin
      LoadAccount(nodeData.Account);
    end;
    if Assigned(nodeData.Role) then
    begin
      LoadRole(nodeData.Role);
      //load role rights
      LoadRights(nodeData.Role);
    end;
  end;
end;

procedure TAccountEditorFrame.vtAccountFocusChanging(Sender: TBaseVirtualTree; OldNode,
  NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
  var Allowed: Boolean);
var
  nodeData: PAccountTreeData;
begin
  // Check if some editor has unsaved changes
  if Assigned(NewNode) and Assigned(OldNode) and (NewNode <> OldNode) then
  begin
    nodeData := vtAccount.GetNodeData(OldNode);
    if fModified then
    begin
      if MessageDlg('数据已经修改，是否先保存已经修改的数据', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        acSaveExecute(btnSave);
        Allowed := True;
        fModified := False;
        SetActionState;
      end
      else
      begin
        Allowed := False;
        SelectAndFocus(OldNode);
      end;
    end;
  end;
end;

procedure TAccountEditorFrame.vtAccountFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  nodeData: PAccountTreeData;
begin
  nodeData := vtAccount.GetNodeData(Node);
  if Assigned(nodeData) then
  begin
    if Assigned(nodeData.Role) then
      FreeAndNil(nodeData.Role);
    if Assigned(nodeData.Account) then
      FreeAndNil(nodeData.Account);
  end;
end;


{**
  Set text of a treenode before it gets displayed or fetched in any way
}
procedure TAccountEditorFrame.vtAccountGetText(Sender: TBaseVirtualTree; Node:
    PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: String);
var
  nodeData: PAccountTreeData;
begin
  nodeData := Sender.GetNodeData(Node);
  if Assigned(nodeData) then
  begin
    if Assigned(nodeData.Role) then
    begin
      case Column of
        0: begin
             CellText := nodeData.Role.role_name;
             if fModified and (Node = vtAccount.FocusedNode) then
               CellText := nodeData.Role.role_name + ' *';
           end;
      else
        CellText := '';
      end;
    end;
    if Assigned(nodeData.Account) then
    begin
      case Column of
        0: begin
             CellText := nodeData.Account.account_name;
             if fModified and (Node = vtAccount.FocusedNode) then
               CellText := nodeData.Account.account_name + ' *';
             
        end;
        1: CellText := cbGender.Items[Ord(nodeData.Account.gender)];
        2: CellText := StrUtils.IfThen(nodeData.Account.age > 0, IntToStr(nodeData.Account.age), '');
      end;
    end
  end;
end;

{**
  Set icon of a treenode before it gets displayed
}
procedure TAccountEditorFrame.vtAccountGetHint(Sender: TBaseVirtualTree;
                                               Node: PVirtualNode; Column: TColumnIndex;
                                               var LineBreakStyle: TVTTooltipLineBreakStyle; var HintText: string);
var
  nodeData: PAccountTreeData;
begin
  //
  nodeData := vtAccount.GetNodeData(Node);
  if Assigned(nodeData) then
  begin
    if Assigned(nodeData.Role) then
      HintText := nodeData.Role.info;
    
  end;
end;

procedure TAccountEditorFrame.vtAccountGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
begin
  // Set pointer size of bound TAccountTreeData
  NodeDataSize := SizeOf(TAccountTreeData);
end;

{**
  Set childcount of an expanding treenode
}
procedure TAccountEditorFrame.vtAccountInitChildren(Sender: TBaseVirtualTree; Node: PVirtualNode; var ChildCount: Cardinal);
var
  nodeData, newData: PAccountTreeData;
  accountRoleMap: TSQLAccountRoleMap;
  child: PVirtualNode;
begin
  nodeData := Sender.GetNodeData(Node);
  if Assigned(nodeData) then
  begin
    if Assigned(nodeData.Role) and (nodeData.Role.ID > 0) then
    begin
      accountRoleMap := TSQLAccountRoleMap.CreateAndFillPrepare(TContext.Instance.DataBase, 'role=?', [Int64ToUtf8(nodeData.Role.ID)]);
      ChildCount := accountRoleMap.FillTable.RowCount;
      //insert child account
      while accountRoleMap.FillOne do
      begin
        child := vtAccount.AddChild(Node, nil);
        newData := vtAccount.GetNodeData(child);
        newData.Role := nil;
        newData.Account := TSQLAccount.Create(TContext.Instance.DataBase, accountRoleMap.account);        
        if newData.Account.ID = TUserSession.Instance.Account.ID then
        begin
          //vtAccount.ReinitNode(child, True);
          SelectAndFocus(child);
        end;
      end;
      FreeAndNil(accountRoleMap);
    end;
  end;
end;


{**
  Set initial options of a treenode and bind DBobject to node which holds the relevant
  connection object, probably its database and probably its table/view/... specific properties
}
procedure TAccountEditorFrame.vtAccountInitNode(Sender: TBaseVirtualTree; ParentNode, Node:
    PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  nodeData, parentData: PAccountTreeData;
  roleCopy: TSQLRole;
  accountRoleMap: TSQLAccountRoleMap;
  account: TSQLAccount;
begin

end;


procedure TAccountEditorFrame.InitAccountBinding;
begin
  // Create a binding expression.
  //account_name
  with TBindExpression.Create(self) do
  begin
    ControlComponent := eAccountName;
    ControlExpression := 'Text';   // The Text property of eAccountName
    SourceComponent := AccountBindScope;
    SourceExpression := 'account_name';    // ... is bound to the Name property of TSQLAccount
    Direction := TExpressionDirection.dirBidirectional;
    BindingsList := BindingsList1;
  end;
  
  //pwd
  with TBindExpression.Create(self) do
  begin
    ControlComponent := ePassword;
    ControlExpression := 'Text';
    SourceComponent := AccountBindScope;
    SourceExpression := 'pwd';
    Direction := TExpressionDirection.dirBidirectional;
    BindingsList := BindingsList1;
  end;
  //age
  with TBindExpression.Create(self) do
  begin
    ControlComponent := eAge;
    ControlExpression := 'Text';
    SourceComponent := AccountBindScope;
    SourceExpression := 'age';
    Direction := TExpressionDirection.dirSourceToControl;
    BindingsList := BindingsList1;
  end;
  //gender
  with TBindExpression.Create(self) do
  begin
    ControlComponent := cbGender;
    ControlExpression := 'ItemIndex';
    SourceComponent := AccountBindScope;
    SourceExpression := 'gender';
    Direction := TExpressionDirection.dirBidirectional;
    BindingsList := BindingsList1;
  end;
  //education
  with TBindExpression.Create(self) do
  begin
    ControlComponent := eEducation;
    ControlExpression := 'Text';
    SourceComponent := AccountBindScope;
    SourceExpression := 'edu_bg';
    Direction := TExpressionDirection.dirBidirectional;
    BindingsList := BindingsList1;
  end;
  //birthday
  with TBindExpression.Create(self) do
  begin
    ControlComponent := dtpBirthday;
    ControlExpression := 'Date';
    SourceComponent := AccountBindScope;
    SourceExpression := 'birthday';
    Direction := TExpressionDirection.dirBidirectional;
    BindingsList := BindingsList1;
  end;
  //entry_date
  with TBindExpression.Create(self) do
  begin
    ControlComponent := dtpEntryDate;
    ControlExpression := 'Date';
    SourceComponent := AccountBindScope;
    SourceExpression := 'entry_date';
    Direction := TExpressionDirection.dirBidirectional;
    BindingsList := BindingsList1;
  end;
  //phone
  with TBindExpression.Create(self) do
  begin
    ControlComponent := ePhone;
    ControlExpression := 'Text';
    SourceComponent := AccountBindScope;
    SourceExpression := 'phone_no';
    Direction := TExpressionDirection.dirBidirectional;
    BindingsList := BindingsList1;
  end;
  //address
  with TBindExpression.Create(self) do
  begin
    ControlComponent := eAddress;
    ControlExpression := 'Text';
    SourceComponent := AccountBindScope;
    SourceExpression := 'address';
    Direction := TExpressionDirection.dirBidirectional;
    BindingsList := BindingsList1;
  end;
  //salary
  with TBindExpression.Create(self) do
  begin
    ControlComponent := eSalary;
    ControlExpression := 'Value';
    SourceComponent := AccountBindScope;
    SourceExpression := 'salary';
    Direction := TExpressionDirection.dirBidirectional;
    BindingsList := BindingsList1;
  end;
  //email
  with TBindExpression.Create(self) do
  begin
    ControlComponent := eEmail;
    ControlExpression := 'Text';
    SourceComponent := AccountBindScope;
    SourceExpression := 'email';
    Direction := TExpressionDirection.dirBidirectional;
    BindingsList := BindingsList1;
  end;
  //royalty_rate
  with TBindExpression.Create(self) do
  begin
    ControlComponent := eRoyaltyRate;
    ControlExpression := 'Value';
    SourceComponent := AccountBindScope;
    SourceExpression := 'royalty_rate';
    Direction := TExpressionDirection.dirBidirectional;
    BindingsList := BindingsList1;
  end;
  //inservice
  with TBindExpression.Create(self) do
  begin
    ControlComponent := cbInservice;
    ControlExpression := 'Checked';
    SourceComponent := AccountBindScope;
    SourceExpression := 'inservice';
    Direction := TExpressionDirection.dirBidirectional;
    BindingsList := BindingsList1;
  end;
end;

procedure TAccountEditorFrame.InitRoleBinding;
begin
  //role_name
  with TBindExpression.Create(self) do
  begin
    ControlComponent := eRoleName;
    ControlExpression := 'Text';
    SourceComponent := RoleBindScope;
    SourceExpression := 'role_name';
    Direction := TExpressionDirection.dirBidirectional;
    BindingsList := BindingsList1;
  end;
  //info
  with TBindExpression.Create(self) do
  begin
    ControlComponent := eRoleInfo;
    ControlExpression := 'Lines.Text';
    SourceComponent := RoleBindScope;
    SourceExpression := 'info';
    Direction := TExpressionDirection.dirBidirectional;
    BindingsList := BindingsList1;
  end;
end;


procedure TAccountEditorFrame.LoadAccount(account: TSQLAccount);
begin
  if Assigned(account) then
  begin
    if fCurrentAccount = nil then
      fCurrentAccount := TSQLAccount(account.CreateCopy)
    else
      fCurrentAccount.FillFrom(account);
    if not AccountBindScope.AutoActivate then
      AccountBindScope.AutoActivate := True;
    AccountBindScope.DataObject := fCurrentAccount;
    PageControl1.ActivePageIndex := 0;
  end
end;

procedure TAccountEditorFrame.SaveAccount(account: TSQLAccount; RoleID: Integer);
var
  accountRoleMap: TSQLAccountRoleMap;
  id: Integer;
  msg: string;
  invalidFieldIndex: Integer;
begin
  if Assigned(account) and Assigned(fCurrentAccount) then
  begin
    //validate
    msg := fCurrentAccount.Validate(TContext.Instance.DataBase, [0..MAX_SQLFIELDS-1], @invalidFieldIndex);
    if msg <> '' then
    begin
      ShowMsgHint('', msg, GetErrorControlByIndex_Account(invalidFieldIndex), msgHint);
      exit;
    end;
    //save to database
    if account.ID = 0 then //append new
    begin
      //insert accoutRoleMap
      TContext.Instance.DataBase.TransactionBegin(nil, 0);
      try
        accountRoleMap := TSQLAccountRoleMap.Create;
        id := TContext.Instance.DataBase.Add(fCurrentAccount, True);
        accountRoleMap.account := TSQLAccount(id);
        accountRoleMap.role := TSQLRole(RoleID);
        TContext.Instance.DataBase.Add(accountRoleMap, True);
        TContext.Instance.DataBase.Commit(0);
        fCurrentAccount.ID := id;
        account.ID := id;        
      except
        TContext.Instance.DataBase.RollBack(0);
      end;
    end
    else
      TContext.Instance.DataBase.Update(fCurrentAccount);
    //save back to account
    account.FillFrom(fCurrentAccount);
  end;
end;

procedure TAccountEditorFrame.LoadRole(role: TSQLRole);
begin
  if Assigned(role) then
  begin
    if fCurrentRole = nil then
      fCurrentRole := TSQLRole(role.CreateCopy)
    else
      fCurrentRole.FillFrom(role);
    if not RoleBindScope.AutoActivate then
      RoleBindScope.AutoActivate := True;
    RoleBindScope.DataObject := fCurrentRole;
    PageControl1.ActivePageIndex := 1;
  end;
end;

procedure TAccountEditorFrame.SaveRole(role: TSQLRole);
var
  id: Integer;
  msg: string;
  invalidFieldIndex: Integer;
begin
  //save role
  if Assigned(role) and Assigned(fCurrentRole) then
  begin
    //validate
    msg := fCurrentRole.Validate(TContext.Instance.DataBase, [0..MAX_SQLFIELDS-1], @invalidFieldIndex);
    if msg <> ''  then
    begin
      ShowMsgHint('', msg, GetErrorControlByIndex_Role(invalidFieldIndex), msgHint);
      exit;
    end;
    //save to database
    if role.ID = 0 then //append new
    begin
      id := TContext.Instance.DataBase.Add(fCurrentRole, True);
      role.ID := id;
      fCurrentRole.ID := id;
    end
    else
      TContext.Instance.DataBase.Update(fCurrentRole);
    //save back to role
    role.FillFrom(fCurrentRole);
  end;
end;

procedure TAccountEditorFrame.DeleteAccount(account: TSQLAccount);
begin
  if Assigned(account) then
  begin
    if account.ID > 0  then
    begin
      //remove from database
      TContext.Instance.Database.TransactionBegin(nil, 0);
      try
        TContext.Instance.DataBase.Delete(TSQLAccountRoleMap, 'account=?', [Int64ToUtf8(account.ID)]);
        TContext.Instance.DataBase.Delete(TSQLAccount, account.ID);
        TContext.Instance.DataBase.Commit(0);
      except
        TContext.Instance.DataBase.RollBack(0);
      end;
    end;
    vtAccount.DeleteNode(vtAccount.FocusedNode);
  end;
end;

procedure TAccountEditorFrame.DeleteRole(role: TSQLRole);
var
  accountIDs: TIntegerDynArray;
  accountRoleMap: TSQLAccountRoleMap;
begin
    if Assigned(role) then
  begin
    if role.ID > 0  then
    begin
      accountRoleMap := TSQLAccountRoleMap.CreateAndFillPrepare(TContext.Instance.DataBase, 'role=?', [Int64ToUtf8(role.ID)]);
      //remove from database
      TContext.Instance.Database.TransactionBegin(nil, 0);
      try
        while accountRoleMap.FillOne do
        begin
          TContext.Instance.DataBase.Delete(TSQLAccount, accountRoleMap.account.ID);
        end;
        TContext.Instance.DataBase.Delete(TSQLAccountRoleMap, 'role=?', [Int64ToUtf8(role.ID)]);
        TContext.Instance.DataBase.Delete(TSQLRole, role.ID);
        TContext.Instance.DataBase.Commit(0);
      except
        TContext.Instance.DataBase.RollBack(0);
      end;
      FreeAndNil(accountRoleMap);
    end;
    vtAccount.DeleteNode(vtAccount.FocusedNode);
  end;
end;


procedure TAccountEditorFrame.InitBinding;
begin
  InitAccountBinding;
  initRoleBinding;
end;

procedure TAccountEditorFrame.SelectAndFocus(node: PVirtualNode);
begin
  vtAccount.Selected[node] := True;
  vtAccount.FocusedNode := node;
  if Assigned(Parent) and Parent.Visible and not vtAccount.Focused then
  begin
      vtAccount.SetFocus;
  end;
end;

function TAccountEditorFrame.GetErrorControlByIndex_Account(invalidFieldIndex: Integer): TWinControl;
begin
  case invalidFieldIndex of
    0: result := eAccountName;
    1: result := ePassword;
  end;
end;

function TAccountEditorFrame.GetErrorControlByIndex_Role(invalidFieldIndex: Integer): TWinControl;
begin
  case invalidFieldIndex of
    0: result := eRoleName;
  end;
end;

procedure TAccountEditorFrame.DoOnResize(Sender: TObject);
begin
  
end;

procedure TAccountEditorFrame.SetSelectedCheckBoxState(state: TCheckBoxState);
var
  i: Integer;
  checkListBox: TCheckListBox;
begin
  //avoid admin
  if Assigned(fCurrentRole) and fCurrentRole.IsAdmin then
    Exit;  
  if pcRights.ActivePage.Controls[0] is TCheckListBox then
  begin
    checkListBox := TCheckListBox(pcRights.ActivePage.Controls[0]);
    for I := 0 to checkListBox.Count - 1 do
    begin
      if checkListBox.Selected[i] then
        checkListBox.State[i] := state;
    end;
    
    fModified := CheckRightsModified;
    SetActionState;
    vtAccount.InvalidateNode(vtAccount.FocusedNode);
  end;
end;

procedure TAccountEditorFrame.InitRights;
var
  action: TContainedAction;
  checkListBox: TCheckListBox;
  tabsheetName: string;
  page: TTabSheet;
  i: Integer;
  category: string;
begin
  //clear all tab
  for i := pcRights.PageCount - 1 downto 0 do
  begin
    page := pcRights.Pages[i];
    page.Parent := nil;
    FreeAndNil(page);
  end;
  //load all rights by main actionlist
  for i := 0 to MainForm.MainActionList.ActionCount - 1 do
  begin
    action := MainForm.MainActionList.Actions[i];
    category := action.Category;
    tabsheetName := 'ts' + category;
    //find page
    page := pcRights.FindChildControl(tabsheetName) as TTabSheet;
    if page = nil then
    begin
      //add new tab sheet
      page := TTabSheet.Create(pcRights);
      page.Caption := _(category);
      page.Name := tabsheetName;
      page.PageControl := pcRights;
      //add checklistbox
      checkListBox := TCheckListBox.Create(page);
      checkListBox.Columns := 2;
      checkListBox.Parent := page;
      checkListBox.Align := TAlign.alClient;
    end
    else
      checkListBox := page.Controls[0] as TCheckListBox;
    //add item to checkListBox
    if action is TAction then
    begin
      checkListBox.Items.Add(TAction(action).Caption);
    end;
    checkListBox.OnClick := DoOnListBoxClick;
    checkListBox.MultiSelect := True;
    checkListBox.BorderStyle := bsNone;
    checkListBox.PopupMenu := PopupMenu2;
  end;
end;

procedure TAccountEditorFrame.LoadRights(role: TSQLRole);
var
  roleActionMap: TSQLRoleActionMap;
  I: Integer;
  checkListBox: TCheckListBox;
  j: Integer;
begin
  if role = nil then
    exit;
  //set current role action
  //admin has all rights
  for I := 0 to pcRights.PageCount - 1 do
  begin
    checkListBox := pcRights.Pages[i].Controls[0] as TCheckListBox;
    if role.IsAdmin then
      checkListBox.CheckAll(TCheckBoxState.cbChecked, True, False)
    else
      checkListBox.CheckAll(TCheckBoxState.cbUnChecked, True, False);
  end;
  
  if role.IsAdmin then
    exit;

  roleActionMap := TSQLRoleActionMap.CreateAndFillPrepare(TContext.Instance.DataBase, 'role=?', [Int64ToUtf8(role.ID)]);
  while roleActionMap.FillOne do
  begin
    for I := 0 to pcRights.PageCount - 1 do
    begin
      checkListBox := pcRights.Pages[i].Controls[0] as TCheckListBox;
      for j := 0 to checkListBox.Count - 1 do
      begin
        if roleActionMap.action = checkListBox.Items[j] then
        begin
          case roleActionMap.right of
            arVisible: checkListBox.State[j] := TCheckBoxState.cbGrayed;
            arEnabled: checkListBox.State[j] := TCheckBoxState.cbChecked;
          else
            checkListBox.State[j] := TCheckBoxState.cbUnChecked;
          end;
        end;
      end;
    end;
  end;
  FreeAndNil(roleActionMap);
end;

procedure TAccountEditorFrame.DoOnListBoxClick(Sender: TObject);
var
  checkListBox: TCheckListBox;
  State : TKeyboardState;
begin
  if Sender is TCheckListBox then
  begin
    checkListBox := Sender as TCheckListBox;
    //avoid multiselect click
    GetKeyboardState(State) ;
    if ((State[vk_Control] And 128) = 0) and ((State[vk_Shift] And 128) = 0) then
    begin
      if Assigned(fCurrentRole) and fCurrentRole.IsAdmin then
        checkListBox.State[checkListBox.ItemIndex] := TCheckBoxState.cbChecked
      else
        checkListBox.State[checkListBox.ItemIndex] :=  TCheckBoxState((Ord(checkListBox.State[checkListBox.ItemIndex]) + 1) mod 3);
    end;
    fModified := CheckRightsModified;
    SetActionState;
    vtAccount.InvalidateNode(vtAccount.FocusedNode);
  end;
end;

procedure TAccountEditorFrame.SaveRights(role: TSQLRole);
var
  roleActionMap: TSQLRoleActionMap;
  checkListBox: TCheckListBox;
  i, j: Integer;
begin
  if fCurrentRole = nil then
    exit;
  
  for i := 0 to pcRights.PageCount - 1 do
  begin
    checkListBox := pcRights.Pages[i].Controls[0] as TCheckListBox;
    for j := 0 to checkListBox.Count - 1 do
    begin        
      roleActionMap := TSQLRoleActionMap.Create(TContext.Instance.DataBase, 'action=? and role=?', [checkListBox.Items[j], Int64ToUtf8(fCurrentRole.ID)]);
      if roleActionMap = nil then
        continue;
      if (roleActionMap.ID = 0) and (checkListBox.State[j] <> TCheckBoxState.cbUnChecked) then
      begin
        //add
        //roleActionMap := TSQLRoleActionMap.Create;
        roleActionMap.role := TSQLRole(fCurrentRole.ID);
        roleActionMap.action := checkListBox.Items[j];
        roleActionMap.right := TActionRight(Ord(checkListBox.State[j]));
        TContext.Instance.DataBase.Add(roleActionMap, True);
      end
      else if (roleActionMap.ID > 0) and (checkListBox.State[j] = TCheckBoxState.cbUnChecked) then
      begin
        //delete
        TContext.Instance.DataBase.Delete(TSQLRoleActionMap, roleActionMap.ID);
      end
      else if (roleActionMap.ID > 0) and (Ord(roleActionMap.right) <> Ord(checkListBox.State[j])) then
      begin
        //updata
        roleActionMap.right := TActionRight(Ord(checkListBox.State[j]));
        TContext.Instance.DataBase.Update(roleActionMap);
      end;
  
      if Assigned(roleActionMap) then 
        FreeAndNil(roleActionMap);
    end;
  end;
end;

function TAccountEditorFrame.CheckRightsModified: Boolean;
var
  roleActionMap: TSQLRoleActionMap;
  i, j: Integer;
  checkListBox: TCheckListBox;
  
  function CheckActionRightModified(actionCaption: string; state: TCheckBoxState) :Boolean;
  begin
    roleActionMap.FillRewind;
    while roleActionMap.FillOne do
    begin
      if roleActionMap.action = actionCaption then
      begin
        result := Ord(roleActionMap.right) <> Ord(state);
        Exit;
      end;
    end;
    result := state <> TCheckBoxState.cbUnChecked;
  end;
  
begin
  result := False;
  if fCurrentRole = nil then
    exit;
  if fCurrentRole.IsAdmin then
    exit;
  roleActionMap := TSQLRoleActionMap.CreateAndFillPrepare(TContext.Instance.DataBase, 'role=?', [Int64ToUtf8(fCurrentRole.ID)]);
  try
    for i := 0 to pcRights.PageCount - 1 do
    begin
      checkListBox := pcRights.Pages[i].Controls[0] as TCheckListBox;
      for j := 0 to checkListBox.Count - 1 do
      begin
        if CheckActionRightModified(checkListBox.Items[j], Checklistbox.State[j]) then
        begin
          result := True;
          break;
        end;
      end;
    end;
  finally
    FreeAndNil(roleActionMap);
  end;
end;

procedure TAccountEditorFrame.SetActionState;
begin
  acSave.Enabled := fModified;
  acDelete.Enabled := vtAccount.FocusedNode <> nil;
end;


end.
