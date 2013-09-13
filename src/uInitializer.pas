unit uInitializer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls, VirtualTrees, Vcl.ImgList, Vcl.Imaging.pngimage, uAccountEditor;

type
  TInitializerForm = class(TForm)
    pcInitial: TPageControl;
    tsAdminInfo: TTabSheet;
    tsAccountInfo: TTabSheet;
    tsGoodsCategoryInfo: TTabSheet;
    tsGoodsInfo: TTabSheet;
    Panel1: TPanel;
    btnPrev: TBitBtn;
    btnNext: TBitBtn;
    btnFinished: TBitBtn;
    tsStoreInfo: TTabSheet;
    ImageList1: TImageList;
    Image1: TImage;
    btnPreview: TBitBtn;
    eStoreName: TLabeledEdit;
    eStoreAddress: TLabeledEdit;
    eStorePhone: TLabeledEdit;
    eStoreEmail: TLabeledEdit;
    msgHint: TBalloonHint;
    eAdminUser: TLabeledEdit;
    eAdminPasswordConfirm: TLabeledEdit;
    eAdminPassword: TLabeledEdit;
    AccountEditorFrame1: TAccountEditorFrame;
    Label1: TLabel;
    cbStoreSize: TComboBox;
    procedure btnPrevClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnFinishedClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormHide(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure Initial;
    procedure Next;
    procedure Prev;
    procedure Finished;
    procedure ResetButtonStatus;
    function CheckValidate(TabIndex: Integer): Boolean;
    function GetErrorControlByIndex(TabIndex, AIndex: Integer): TWinControl;
    procedure SetErrorControlStatus(TabIndex, AIndex: Integer);
  public
    { Public declarations }
  end;

var
  InitializerForm: TInitializerForm;

implementation
uses
  uModel, uSingleton, uDataBase, SynCommons, uHelper;

{$R *.dfm}

procedure TInitializerForm.btnPrevClick(Sender: TObject);
begin
  Prev;
end;

procedure TInitializerForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //
  if Self.ModalResult <> mrOk then
    TContext.Instance.DataBase.RollBack(0);
  msgHint.HideHint;
end;

procedure TInitializerForm.FormCreate(Sender: TObject);
begin
  Initial;
  //btnPreview.Hint := '提示:|这是 Button1 的 Hint|0';
end;

procedure TInitializerForm.FormHide(Sender: TObject);
begin
  AccountEditorFrame1.DoOnHide(Sender);
end;

procedure TInitializerForm.FormResize(Sender: TObject);
begin
  AccountEditorFrame1.DoOnResize(Sender);
end;

procedure TInitializerForm.FormShow(Sender: TObject);
begin
  AccountEditorFrame1.DoOnShow(Sender);
end;

procedure TInitializerForm.btnNextClick(Sender: TObject);
begin
  Next;
end;

procedure TInitializerForm.btnPreviewClick(Sender: TObject);
var
  pt: TPoint;
begin
    msgHint.Title := '';
    msgHint.Description := 'Click this button to open';
    Pt.X := Self.Left;
    Pt.Y := Self.Top;
    msgHint.ShowHint(Self.ClientToScreen(Pt));
end;

procedure TInitializerForm.btnFinishedClick(Sender: TObject);
begin
  Finished;
end;

procedure TInitializerForm.ResetButtonStatus;
begin
  btnPrev.Enabled := pcInitial.TabIndex <> 0;
  btnNext.Enabled := pcInitial.TabIndex < (pcInitial.PageCount - 1);
  btnFinished.Enabled := pcInitial.TabIndex = (pcInitial.PageCount - 1);
end;

procedure TInitializerForm.Initial;
begin
  pcInitial.TabIndex := 0;
  ResetButtonStatus;
end;

procedure TInitializerForm.Next;
begin
  if CheckValidate(pcInitial.TabIndex) then
    pcInitial.TabIndex := pcInitial.TabIndex + 1;
  ResetButtonStatus;
end;

procedure TInitializerForm.Prev;
begin
  if CheckValidate(pcInitial.TabIndex) then
    pcInitial.TabIndex := pcInitial.TabIndex - 1;
  ResetButtonStatus;
end;

function TInitializerForm.CheckValidate(TabIndex: Integer): Boolean;
var
  store: TSQLStore;
  account: TSQLAccount;
  invalidFieldIndex: Integer;
  role: TSQLRole;
  accountRoleMap: TSQLAccountRoleMap;
  msg: string;
begin
  result := False;
  case TabIndex of
    0:  //store info
      begin
        //begin transaction
        TContext.Instance.DataBase.TransactionBegin(nil, 0);
        store := TSQLStore.Create;
        store.store_name := eStoreName.Text;
        store.address := eStoreAddress.Text;
        store.phone := eStorePhone.Text;
        store.email := eStoreEmail.Text;
        if cbStoreSize.ItemIndex > -1 then
          store.size := TStoreSize(cbStoreSize.ItemIndex);
        msg := store.Validate(TContext.Instance.DataBase, [0..MAX_SQLFIELDS-1], @invalidFieldIndex);
        if msg = '' then
        begin
          TContext.Instance.DataBase.Add(store, True);
          SetErrorControlStatus(0, -1);
          msgHint.HideHint;
          result := True;
        end
        else
        begin
          ShowMsgHint('', msg, GetErrorControlByIndex(0, invalidFieldIndex), msgHint);
          SetErrorControlStatus(0, invalidFieldIndex);
        end;
      end;
    1: //admin info
      begin
        account := TSQLAccount.Create;
        account.account_name := eAdminUser.Text;
        account.pwd := eAdminPassword.Text;
        if eAdminPassword.Text <> eAdminPasswordConfirm.Text then
        begin
          msg := '密码不一致';
          invalidFieldIndex := 3;
        end
        else
          msg := account.Validate(TContext.Instance.DataBase, [0..MAX_SQLFIELDS-1], @invalidFieldIndex);
        
        if msg = '' then
        begin
          //add admin role
          role := TSQLRole.Create;
          role.role_name := StringToUTF8(sAdminRoleName);
          role.info := StringToUTF8(sAdminRoleInfo);
          
          accountRoleMap := TSQLAccountRoleMap.Create;
          accountRoleMap.account := TSQLAccount(TContext.Instance.DataBase.Add(account, True));
          accountRoleMap.role := TSQLRole(TContext.Instance.DataBase.Add(role, True));
          TContext.Instance.DataBase.Add(accountRoleMap, True);
          
          //add default account to account editor
          AccountEditorFrame1.acAddAccount.Execute;
          
          SetErrorControlStatus(1, -1);
          msgHint.HideHint;
          result := True;
        end
        else
        begin
          ShowMsgHint('', msg, GetErrorControlByIndex(1, invalidFieldIndex), msgHint);
          SetErrorControlStatus(1, invalidFieldIndex);
        end;
        
      end;
    2: //account info
      begin
        //add default user according store size
        
        result := True;
      end;
    3: //goods category info
      begin
        result := True;
      end;
    4: //goods info
      begin
        result := True;
      end;
  end;
end;

procedure TInitializerForm.Finished;
begin
  if CheckValidate(pcInitial.TabIndex) then
  begin
    TContext.instance.DataBase.Commit(0);
    ModalResult := mrOk;
  end;
end;

function TInitializerForm.GetErrorControlByIndex(TabIndex, AIndex: Integer): TWinControl;
begin
  result := nil;
  if TabIndex = 0 then
  begin
    case AIndex of
      0: result := eStoreName;
      1: result := eStoreAddress;
      2: result := eStorePhone;
      3: result := eStoreEmail;
      4: result := cbStoreSize;
    end;
  end;
  if TabIndex = 1 then
  begin
    case AIndex of
      1: result := eAdminUser;
      2: result := eAdminPassword;
      3: result := eAdminPasswordConfirm;
    end;
  end;
end;

procedure TInitializerForm.SetErrorControlStatus(TabIndex, AIndex: Integer);
//var
//  control: TWinControl;
begin
//  control := GetErrorControlByIndex(AIndex);
//  if control = nil then
//
//  end
//  else
//  begin
//    //set border 1
//    //set background red
//    SetWindowTheme(control.Handle, 'Explorer', nil);
//    control.SetFocus;
//  end;
end;


end.
