unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Vcl.ActnList,
  Vcl.ImgList, Vcl.StdCtrls, VirtualTrees, Vcl.ToolWin, Vcl.ActnMan,
  Vcl.ActnCtrls, Vcl.ComCtrls;

type
  ///main pk from
  TMainForm = class(TForm)
    MainFormMenu: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N30: TMenuItem;
    N32: TMenuItem;
    N34: TMenuItem;
    N35: TMenuItem;
    N36: TMenuItem;
    MainActionList: TActionList;
    actGoodsCategory: TAction;
    acRights: TAction;
    acGoods: TAction;
    acAccounts: TAction;
    acPrintReceipt: TAction;
    acInitializer: TAction;
    acPurchaseOrder: TAction;
    acPurchaseStockIn: TAction;
    acPurchasePayment: TAction;
    acPurchaseOrderQuery: TAction;
    acPurchaseStockInQuery: TAction;
    acPurchasePaymentQuery: TAction;
    acRetail: TAction;
    acRetailQuery: TAction;
    acRetailOn: TAction;
    acRetailOff: TAction;
    acPromotion: TAction;
    acMembership: TAction;
    N37: TMenuItem;
    N38: TMenuItem;
    N39: TMenuItem;
    N4: TMenuItem;
    N41: TMenuItem;
    N42: TMenuItem;
    N43: TMenuItem;
    N44: TMenuItem;
    N45: TMenuItem;
    N46: TMenuItem;
    N47: TMenuItem;
    N19: TMenuItem;
    N48: TMenuItem;
    N49: TMenuItem;
    N31: TMenuItem;
    N50: TMenuItem;
    N33: TMenuItem;
    N51: TMenuItem;
    N52: TMenuItem;
    N53: TMenuItem;
    N54: TMenuItem;
    N55: TMenuItem;
    N56: TMenuItem;
    N57: TMenuItem;
    N58: TMenuItem;
    N59: TMenuItem;
    N60: TMenuItem;
    Excel1: TMenuItem;
    Excel2: TMenuItem;
    acGoodsBrand: TAction;
    acGoodsUnit: TAction;
    acGoodsColor: TAction;
    acGoodsSize: TAction;
    acGoodsDistributor: TAction;
    acCheckin: TAction;
    acExcelImport: TAction;
    acExcelOutput: TAction;
    N40: TMenuItem;
    N61: TMenuItem;
    N62: TMenuItem;
    N63: TMenuItem;
    N64: TMenuItem;
    N65: TMenuItem;
    N66: TMenuItem;
    ImageListMain: TImageList;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure actGoodsCategoryExecute(Sender: TObject);
    procedure MainActionListExecute(Action: TBasicAction; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure acRightsExecute(Sender: TObject);
    procedure acInitializerExecute(Sender: TObject);
    procedure acGoodsBrandExecute(Sender: TObject);
    procedure acGoodsUnitExecute(Sender: TObject);
    procedure acGoodsColorExecute(Sender: TObject);
    procedure acGoodsSizeExecute(Sender: TObject);
    procedure acGoodsDistributorExecute(Sender: TObject);
    procedure acGoodsExecute(Sender: TObject);
    procedure acPurchaseOrderExecute(Sender: TObject);
    procedure acPurchaseStockInExecute(Sender: TObject);
    procedure acPurchasePaymentExecute(Sender: TObject);
    procedure acPurchaseOrderQueryExecute(Sender: TObject);
    procedure acAccountsExecute(Sender: TObject);
    procedure acMembershipLevelExecute(Sender: TObject);
    procedure acPrintReceiptExecute(Sender: TObject);
    procedure acPurchaseStockInQueryExecute(Sender: TObject);
    procedure acPurchasePaymentQueryExecute(Sender: TObject);
    procedure acRetailExecute(Sender: TObject);
    procedure acRetailQueryExecute(Sender: TObject);
    procedure acRetailOnExecute(Sender: TObject);
    procedure acRetailOffExecute(Sender: TObject);
    procedure acPromotionExecute(Sender: TObject);
    procedure acCheckinExecute(Sender: TObject);
    procedure acExcelImportExecute(Sender: TObject);
    procedure acExcelOutputExecute(Sender: TObject);
    procedure acWholesaleOrderExecute(Sender: TObject);
    procedure acWholesaleStockOutExecute(Sender: TObject);
    procedure acWholesaleCollectionExecute(Sender: TObject);
    procedure acWholesaleOrderQueryExecute(Sender: TObject);
    procedure acWholesaleCollectionQueryExecute(Sender: TObject);
    procedure acWholesaleStockOutQueryExecute(Sender: TObject);
    procedure acWholesaleReturnExecute(Sender: TObject);
    procedure acRetailReturnExecute(Sender: TObject);
    procedure acPurchaseReturnExecute(Sender: TObject);
    procedure acWholesaleReturnQueryExecute(Sender: TObject);
    procedure acRetailReturnQueryExecute(Sender: TObject);
    procedure acPurchaseReturnQueryExecute(Sender: TObject);
    procedure acAdvSMSExecute(Sender: TObject);
    procedure acAdvPhoneExecute(Sender: TObject);
    procedure acAdvWeiboExecute(Sender: TObject);
    procedure acAdvWeixinExecute(Sender: TObject);
    procedure acAdvEmailExecute(Sender: TObject);
    procedure acMemberShipExecute(Sender: TObject);
    procedure acMemberShipQueryExecute(Sender: TObject);
    procedure acStockTakingBillExecute(Sender: TObject);
    procedure acStockTakingExecute(Sender: TObject);
    procedure acStockTakingAdjustExecute(Sender: TObject);
    procedure acStockInExecute(Sender: TObject);
    procedure acStockOutExecute(Sender: TObject);
    procedure acStockTransferExecute(Sender: TObject);
    procedure acStockQueryExecute(Sender: TObject);
  private
    { Private declarations }
    procedure Set_i18n;
    procedure Login;
    procedure Initialize;
    procedure ShowInitializerForm;

  public
    { Public declarations }
    procedure AnyGridGetHint(Sender: TBaseVirtualTree; Node:PVirtualNode; Column: TColumnIndex;
                             var LineBreakStyle:TVTTooltipLineBreakStyle; var HintText: String);
    procedure AnyGridScroll(Sender: TBaseVirtualTree; DeltaX, DeltaY: Integer);
    procedure AnyGridMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer;
                                MousePos: TPoint; var Handled: Boolean);
    procedure AnyGridIncrementalSearch(Sender: TBaseVirtualTree; Node: PVirtualNode;
                                       const SearchText: String; var Result: Integer);
    procedure AnyGridEndOperation(Sender: TBaseVirtualTree;
      OperationKind: TVTOperationKind);
    procedure AnyGridStartOperation(Sender: TBaseVirtualTree;
      OperationKind: TVTOperationKind);
  end;

var
  MainForm: TMainForm;

implementation

uses
  uHelper, uInitializer, mORMoti18n, uSingleton, uDataBase, uLogin, uAccount,
  uGoods;

{$R *.dfm}

procedure TMainForm.acAccountsExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acAdvEmailExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acAdvPhoneExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acAdvSMSExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acAdvWeiboExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acAdvWeixinExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acCheckinExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acExcelImportExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acExcelOutputExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acGoodsBrandExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acGoodsColorExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acGoodsDistributorExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acGoodsExecute(Sender: TObject);
begin
  GoodsForm.Show;
end;

procedure TMainForm.acGoodsSizeExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acGoodsUnitExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acInitializerExecute(Sender: TObject);
begin
  ShowInitializerForm;
end;

procedure TMainForm.acMemberShipExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acMembershipLevelExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acMemberShipQueryExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acPrintReceiptExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acPromotionExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acPurchaseOrderExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acPurchaseOrderQueryExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acPurchasePaymentExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acPurchasePaymentQueryExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acPurchaseReturnExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acPurchaseReturnQueryExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acPurchaseStockInExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acPurchaseStockInQueryExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acRetailExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acRetailOffExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acRetailOnExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acRetailQueryExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acRetailReturnExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acRetailReturnQueryExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acRightsExecute(Sender: TObject);
begin
  //角色编辑 角色对应权限编辑 用户对应那个角色编辑
  AccountForm.Show;
end;

procedure TMainForm.acStockInExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acStockOutExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acStockQueryExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acStockTakingAdjustExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acStockTakingBillExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acStockTakingExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acStockTransferExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.actGoodsCategoryExecute(Sender: TObject);
begin
//todo goods categories manager

end;

procedure TMainForm.acWholesaleCollectionExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acWholesaleCollectionQueryExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acWholesaleOrderExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acWholesaleOrderQueryExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acWholesaleReturnExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acWholesaleReturnQueryExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acWholesaleStockOutExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.acWholesaleStockOutQueryExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.MainActionListExecute(Action: TBasicAction;
  var Handled: Boolean);
begin
//todo add access right check

end;

procedure TMainForm.FormCreate(Sender: TObject);

begin
  //

end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  Set_i18n;
  Initialize;
  Login;
end;

procedure TMainForm.Set_i18n;
begin
  {$ifdef EXTRACTALLRESOURCES}
  ExtractAllResources(
    //first, all enumerations to be translated
    [],
    //then  som class instances (including  the TSQLModel will handle all TSQLRecord)
    [TContext.Instance.Model],
    // some custom classes or captions
    [],[]);
  {$else}
  i18nLanguageToRegistry(lngChinese);
  {$endif}
end;

procedure TMainForm.Login;
begin
  //show login form
  if LoginForm.ShowModal <>  mrOk then
  begin
    Application.Terminate;    
  end;
end;

procedure TMainForm.Initialize;
begin
  //first run show initial form
  if not AppInitialized then
  begin
    ShowInitializerForm;
  end;
end;

procedure TMainForm.AnyGridGetHint(Sender: TBaseVirtualTree; Node:
    PVirtualNode; Column: TColumnIndex; var LineBreakStyle:
    TVTTooltipLineBreakStyle; var HintText: String);
var
  r : TRect;
  DisplayedWidth,
  NeededWidth : Integer;
  Tree: TVirtualStringTree;
begin
  // Disable tooltips on Wine, as they prevent users from clicking + editing clipped cells
  Tree := TVirtualStringTree(Sender);
  HintText := Tree.Text[Node, Column];
  HintText := sstr(HintText, SIZE_KB);
  LineBreakStyle := hlbForceMultiLine;
  // Check if the list has shortened the text
  r := Tree.GetDisplayRect(Node, Column, True);
  DisplayedWidth := r.Right-r.Left;
  NeededWidth := Canvas.TextWidth(HintText) + Tree.TextMargin*2;
  // Disable displaying hint if text is displayed completely in list
  if NeededWidth <= DisplayedWidth then
    HintText := '';
end;

procedure TMainForm.AnyGridScroll(Sender: TBaseVirtualTree; DeltaX, DeltaY: Integer);
begin
  // A tree gets scrolled only when the mouse is over it - see FormMouseWheel
  // Our home brewn cell editors do not reposition when the underlying tree scrolls.
  // To avoid confusion, terminate editors then.
  if Sender.IsEditing and (DeltaX=0) then
    Sender.EndEditNode;
end;

procedure TMainForm.AnyGridMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer;
  MousePos: TPoint; var Handled: Boolean);
var
  VT: TVirtualStringTree;
  Node: PVirtualNode;
begin
  // Advance to next or previous grid node on Shift+MouseWheel
  if KeyPressed(VK_SHIFT) then begin
    VT := Sender as TVirtualStringTree;
    if Assigned(VT.FocusedNode) then begin
      if WheelDelta > 0 then
        Node := VT.FocusedNode.PrevSibling
      else
        Node := VT.FocusedNode.NextSibling;
      if Assigned(Node) then begin
        SelectNode(VT, Node);
        Handled := True;
      end;
    end;
  end;
end;


procedure TMainForm.AnyGridIncrementalSearch(Sender: TBaseVirtualTree; Node: PVirtualNode;
  const SearchText: String; var Result: Integer);
var
  CellText: String;
  VT: TVirtualStringTree;
begin
  // Override VT's default incremental search behaviour. Make it case insensitive.
  VT := Sender as TVirtualStringTree;
  if VT.FocusedColumn = NoColumn then
    Exit;
  CellText := VT.Text[Node, VT.FocusedColumn];
  Result := StrLIComp(PChar(CellText), PChar(SearchText), Length(SearchText));
end;


procedure TMainForm.AnyGridStartOperation(Sender: TBaseVirtualTree; OperationKind: TVTOperationKind);
begin
  // Display status message on long running sort operations
//  if OperationKind = okSortTree then begin
//    ShowStatusMsg(_('Sorting grid nodes ...'));
//    FOperatingGrid := Sender;
//    OperationRunning(True);
//  end;
end;

procedure TMainForm.ShowInitializerForm;
begin
  InitializerForm := TInitializerForm.Create(self);
  InitializerForm.ShowModal;
  FreeAndNil(InitializerForm);
end;

procedure TMainForm.AnyGridEndOperation(Sender: TBaseVirtualTree; OperationKind: TVTOperationKind);
begin
  // Reset status message after long running operations
//  if OperationKind = okSortTree then begin
//    ShowStatusMsg;
//    FOperatingGrid := nil;
//    OperationRunning(False);
//  end;
end;

end.
