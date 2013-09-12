unit uGoods;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uGoodsEditor, Vcl.Menus;

type
  TGoodsForm = class(TForm)
    GoodsEditor1: TGoodsEditor;
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GoodsForm: TGoodsForm;

implementation

{$R *.dfm}

procedure TGoodsForm.FormHide(Sender: TObject);
begin
//
  GoodsEditor1.DoOnHide(Sender);
end;

procedure TGoodsForm.FormResize(Sender: TObject);
begin
//
  GoodsEditor1.DoOnResize(Sender);
end;

procedure TGoodsForm.FormShow(Sender: TObject);
begin
//
  GoodsEditor1.DoOnShow(Sender);
end;

end.
