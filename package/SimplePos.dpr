program SimplePos;

uses
  Vcl.Forms,
  uInitializer in '..\src\uInitializer.pas' {InitializerForm},
  uMain in '..\src\uMain.pas' {MainForm},
  uLogin in '..\src\uLogin.pas' {LoginForm},
  uAccountEditor in '..\src\uAccountEditor.pas' {AccountEditorFrame: TFrame},
  uAccount in '..\src\uAccount.pas' {AccountForm},
  Vcl.Themes,
  Vcl.Styles,
  uModel in '..\src\uModel.pas',
  uCustomerBindingConverter in '..\src\uCustomerBindingConverter.pas',
  uDataBase in '..\src\uDataBase.pas',
  uHelper in '..\src\uHelper.pas',
  uIEventFrame in '..\src\uIEventFrame.pas',
  uSession in '..\src\uSession.pas',
  uSingleton in '..\src\uSingleton.pas',
  uValidator in '..\src\uValidator.pas',
  uGoodsEditor in '..\src\uGoodsEditor.pas' {GoodsEditor: TFrame},
  uGoods in '..\src\uGoods.pas' {GoodsForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TInitializerForm, InitializerForm);
  Application.CreateForm(TLoginForm, LoginForm);
  Application.CreateForm(TAccountForm, AccountForm);
  Application.CreateForm(TGoodsForm, GoodsForm);
  Application.Run;
end.
