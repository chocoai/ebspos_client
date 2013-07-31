unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TMainForm = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  uAppSettings;

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  //initial settings
  AppSettings := TAppSettings.Create;
  
  //first run show initial form
  
  //Login
end;

end.
