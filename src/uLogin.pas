unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TLoginForm = class(TForm)
    eLoginName: TLabeledEdit;
    eLoginPassword: TLabeledEdit;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    msgHint: TBalloonHint;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure eLoginPasswordKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    fErrorTimes: Integer;
  public
    { Public declarations }
  end;
  
const MaxErrorCount = 3;

resourcestring
  sLoginError = '用户名或是密码错误';
  sLoginRetryCount = '还能尝试%d次';
  sLoginMaxError = '已经达到最大重试次数';

var
  LoginForm: TLoginForm;

implementation
uses
  uModel, uDataBase, uHelper, SynCommons, uSession;

{$R *.dfm}

procedure TLoginForm.btnOKClick(Sender: TObject);
var
  user, password: string;
  msg: string;
begin
  //
  user := eLoginName.Text;
  password := eLoginPassword.Text;
  if not TUserSession.Instance.Login(user, password) then
  begin
    if (fErrorTimes >= MaxErrorCount - 1) then
    begin
      ModalResult := mrCancel;
      Exit;
    end;
    Inc(fErrorTimes);
    msg := sLoginError + ', ' + Format(sLoginRetryCount, [MaxErrorCount- fErrorTimes]);
    ShowMsgHint('', msg, eLoginName, msgHint);
    eLoginName.SetFocus;
  end
  else
  begin
    ModalResult := mrOk;
  end;
end;

procedure TLoginForm.eLoginPasswordKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btnOKClick(nil);
end;

procedure TLoginForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //
  msgHint.HideHint;
end;

procedure TLoginForm.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;


end.
