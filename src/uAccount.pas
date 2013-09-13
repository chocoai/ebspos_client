unit uAccount;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uAccountEditor;

type
  TAccountForm = class(TForm)
    AccountEditorFrame1: TAccountEditorFrame;
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AccountForm: TAccountForm;

implementation
uses
  uIEventFrame;

{$R *.dfm}

procedure TAccountForm.FormHide(Sender: TObject);
begin
  AccountEditorFrame1.DoOnHide(Sender);
end;

procedure TAccountForm.FormResize(Sender: TObject);
begin
  AccountEditorFrame1.DoOnResize(Sender);
end;

procedure TAccountForm.FormShow(Sender: TObject);
begin
  AccountEditorFrame1.DoOnShow(Sender);
end;

end.
