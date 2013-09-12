unit uTest;

interface

uses
  SynCommons, SynSQLite3Static, mORMot, mORMotSQLite3, uSingleton, System.Classes;


type

  TTestSingleton = class(TSynTestCase)
  published
    procedure TestSingleton;
  public
    constructor Create(Owner: TSynTests; const Ident: string = ''); override;
    
  end;
  
  TTestSuit = class(TSynTestsLogged)
  published
    procedure MyTestSuit;
  end;
  
  

implementation

procedure TTestSuit.MyTestSuit;
begin
  AddCase([TTestSingleton]);
end;

constructor TTestSingleton.Create(Owner: TSynTests; const Ident: string);
begin
  inherited;
end;

procedure TTestSingleton.TestSingleton;
var
  s1, s2, s3, s4: TObject;
  s5: TObject;
begin
  try
    s1 := TSingleton<TObject>.Create;
    Check(s1 <> nil);
    s2 := TSingleton<TObject>.Create;
  except on e: EInvalidOperation do
    Check(e is EInvalidOperation);
  end;
  
  Check(s2 = nil);
  s3 := TSingleton<TObject>.Instance;
  s4 := TSingleton<TObject>.Instance;
  Check(s3 = s4);
  Check(s1 = s3);
  try
    s5 := TSingleton<TObject>.Create;
  finally
    Check(s5 <> nil);
  end;
end;

end.
