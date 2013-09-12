unit uGoodsEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uIEventFrame, VirtualTrees,
  Vcl.ExtCtrls, Vcl.Menus, Vcl.ActnList, JvExExtCtrls, JvNetscapeSplitter,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.ToolWin, Vcl.ActnMan,
  Vcl.ActnCtrls, uModel;

type
  TGoodsEditor = class(TFrame, IEventFrame)
    vtGoods: TVirtualStringTree;
    Panel1: TPanel;
    Panel2: TPanel;
    GoodsActionList: TActionList;
    PopupMenu1: TPopupMenu;
    JvNetscapeSplitter1: TJvNetscapeSplitter;
    acAdd: TAction;
    acSave: TAction;
    acDelete: TAction;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Panel3: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    acFind: TAction;
    acNext: TAction;
    acShowAll: TAction;
    acSort: TAction;
    acFliter: TAction;
    acColumns: TAction;
    Panel4: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
  private
    { Private declarations }
    fLoaded: Boolean;
    
    fGoods: TSQLGoods;
    
    procedure LoadGoods;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoOnHide(Sender: TObject);
    procedure DoOnShow(Sender: TObject);
    procedure DoOnResize(Sender: TObject);
  end;

implementation
uses
  uMain, uHelper;

{$R *.dfm}

{ TGoodsEditor }

constructor TGoodsEditor.Create(AOwner: TComponent);
begin
  inherited;
  FixVT(vtGoods);
end;

destructor TGoodsEditor.Destroy;
begin
  inherited;
end;

procedure TGoodsEditor.DoOnHide(Sender: TObject);
begin

end;

procedure TGoodsEditor.DoOnResize(Sender: TObject);
begin

end;

procedure TGoodsEditor.DoOnShow(Sender: TObject);
begin
  if not fLoaded then
  begin
    fLoaded := True;
    LoadGoods;
  end;
end;

//当商品表非常大的时候，需要对返回的结果做限制，用offset limit实现分页选择
//直接在条件语句中加入 where offset ? limit ?
//参考mORMot.pas中的 function TSQLRest.InternalListRecordsJSON(Table: TSQLRecordClass;
//function TSQLModelRecordProperties.SQLFromSelectWhere(const SQLSelect, SQLWhere: RawUTF8): RawUTF8;
//
//load goods 获取数据放在beforpaint中，并根据准备好的条件，例如显示的列、排序的字段、方向等将数据查询出来
//在get_gext中，将数据显示在virtualTreeView中
procedure TGoodsEditor.LoadGoods;
begin
  
end;

end.
