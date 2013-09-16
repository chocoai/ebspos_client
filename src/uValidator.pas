unit uValidator;

interface
uses
  SynCommons, uSingleton;
type
  TPkValidateNotEmpty = class(TSynValidate)
  protected
    //set parameter
    procedure SetParameters(Value: RawUTF8); override;
  public
    function  Process(aFieldIndex: Integer; const Value: RawUTF8; var ErrorMsg: string): boolean; override;
  end;
  
  TPkValidatePassWord = class(TSingleton<TSynValidatePassWord>)
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;
  
resourcestring
  sCanNotBeEmpty = '²»ÄÜÎª¿Õ';
implementation

procedure TPkValidateNotEmpty.SetParameters(Value: RawUTF8);
begin
  
end;

function TPkValidateNotEmpty.Process(aFieldIndex: Integer; const Value: RawUTF8; var ErrorMsg: string): boolean;
begin
  result := True;
  if Trim(Value) = '' then
  begin
    result := False;
    ErrorMsg := sCanNotBeEmpty;
  end;  
end;


procedure TPkValidatePassWord.AfterConstruction;
begin
//  Instance.MinLength := 5;
//  Instance.MaxLength := 10;
//  Instance.MinAlphaCount := 1;
//  Instance.MinDigitCount := 1;
//  Instance.MinPunctCount := 1;
//  Instance.MinLowerCount := 1;
//  Instance.MinUpperCount := 1;
//  Instance.MaxSpaceCount := 0;
end;

procedure TPkValidatePassWord.BeforeDestruction;
begin
end;

end.
