unit currEdit;
{
TCurrEdit:  This is an usefull CLX component based on an Edit
            control for Currency ($-CA$H-$) input coded
            in Delphi 7.0. It should also work in Kylix X.
            Be free to Update, modify or distribute it
            (Please, dont remove the credits  :-) ) and
            to send me your updates or changes... I'll be
            more happy.....

Use:        Only set the Intdigits property and the
            DecimalDigits property, IE: if you want
            that the user inputs money of the style "3.59"
            then set IntDigits to 1 and DecimalDigits to 2
            Easy yahh??
            ok, yo can also read the value of the input via
            the Text property (as string) or via the Value
            property (as Float).

Author:   Matias Surdi  (Matiass@interlap.com.ar)
Created: 21/11/2002
Version: 1.1
License: you can freely use and distribute the included code
         for any purpouse, but you cannot remove this copyright
         notice. Send me any comment and update, they are really
         appreciated.
Contact: matiass@interlap.com.ar

Enjoy it!

(if someone wants to do a nice, sweet and friendly icon, and if
wants to sendme it... i will be happy..happy..happy..happy..)


ChangeLog:  *21/11/2002 - Released V 1.00

            *24/11/2002 - Added Regional Decimal separator support ( "." and ",")


}

interface

uses
  SysUtils, Classes, Controls, StdCtrls, dialogs, strUtils, windows;

type
  TcurrEdit = class(TEdit)
  private
    FDecimalDigits: Integer;
    FIntDigits: Integer;
    FPrefix:string;
    fSufix:string;
    FValue:currency;
    fMultiple: Currency;
    procedure UptText;
    procedure SetDecimalDigits(const Value: Integer);
    procedure SetintDigits(const Value: Integer);
    procedure SetValue(newvalue:Currency);
    procedure SetMultiple(value: Currency);
    function GetValue: currency;

    { Private declarations }
  protected
    procedure Loaded;override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState);override;
    procedure doEnter;override;
    procedure doExit;override;
    procedure Click;override;
    procedure Change;override;
    { Protected declarations }
  public
    constructor Create(Aowner: Tcomponent);override;
    procedure Clear;override;
    { Public declarations }
  published
    property IntDigits:integer read FintDigits write SetIntDigits;
    property DecimalDigits: Integer read FDecimalDigits write SetDecimalDigits;    { Published declarations }
    property Multiple: Currency read fMultiple write SetMultiple;
    property Value : currency read GetValue write SetValue;
    property Prefix:string read fPrefix write fPrefix;
    property Sufix:string read fSufix write fSufix;
  end;

procedure Register;

implementation
procedure Register;
begin
  RegisterComponents('ByosoftVCL', [TcurrEdit]);
end;

constructor tcurredit.create(Aowner:tcomponent);
begin
  inherited Create(Aowner);
  //Alignment:=taRightJustify;
  Prefix:='';
  Sufix:='';
  fMultiple := 1;
  AutoSelect:=True;
end;

procedure TcurrEdit.Loaded;
begin
  inherited;
  upttext;
end;

procedure TcurrEdit.clear;
begin
  Fvalue := 0;
  UptText;
end;

procedure TCurrEdit.SetValue(newvalue:currency);
begin
  fValue := newvalue;
  text := currtostr(fvalue);
  doexit;
end;

procedure TCurrEdit.uptText;
begin
  Text := prefix + '0' + FormatSettings.DecimalSeparator;
  while length(text) - 2 - length(prefix) < DecimalDigits do
    Text := Text + '0';
  Text := Text + Sufix;
end;

procedure TcurrEdit.SetDecimalDigits(const Value: Integer);
begin
  FDecimalDigits := Value;
  UptText;
end;


procedure TcurrEdit.SetIntDigits(const Value: Integer);
begin
  FintDigits := Value;
  UptText;
end;


procedure TCurrEdit.click;
begin
  inherited;
  DoEnter;
end;


procedure TcurrEdit.doEnter;
begin
  inherited;
  if (leftstr(text, length(prefix)) = prefix) and (rightstr(text, length(sufix)) = sufix) then
    text := rightstr(leftstr(Text,length(text) - length(sufix)), length(text) - length(prefix));
  text := format('%'+inttostr(IntDigits) + '.' + inttostr(DecimalDigits) + 'f',[fvalue * fMultiple]);
  SelStart := 0;
  SelLength := length(Text);
end;


procedure TcurrEdit.doExit;
begin
  inherited;
  text := format('%' + inttostr(IntDigits) + '.'+inttostr(DecimalDigits) + 'f',[fvalue * fMultiple]);
  text := prefix + text+sufix;
end;

function TcurrEdit.GetValue: currency;
begin
  Result := fValue;
end;

procedure TCurrEdit.KeyPress(var Key: Char);
begin
  inherited;
  if not (ord(key)in [8, ord(FormatSettings.DecimalSeparator),44,46,48..57]) then
  begin
    key:=chr(0);
    exit;
  end;

  if ord(key) in [ord(FormatSettings.DecimalSeparator),44,46] then
  begin
    if (pos(key, Text)<>0) and (pos(key, SelText)=0) then key:=chr(0)
    else key:= FormatSettings.DecimalSeparator;
  end;

end;

procedure tCurrEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if key=VK_RETURN then doExit;
  inherited;
end;

procedure tCurrEdit.Change;
begin
  inherited;
  if not focused then exit;
  if ((leftstr(text, length(Prefix)) = prefix) and (prefix<>'')) or ((rightstr(text, length(Sufix)) = Sufix) and (sufix<>'')) then exit;

  if (trim(text)<>'') and (trim(text)<> FormatSettings.DecimalSeparator) then
    Fvalue := strtocurr(text) / fMultiple
  else Fvalue := 0;
end;

procedure TCurrEdit.SetMultiple(value: Currency);
begin
  fMultiple := value;
//  doExit;
end;

end.
