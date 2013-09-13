unit uDataBase;

interface
uses
  SynCommons, mORMot, SynSQLite3Static, mORMotSQLite3, uSingleton;

type
  TORMContext = class
  private
    FDataBase: TSQLRest;
    FModel: TSQLModel;
  public
    procedure AfterConstruction; override;
    constructor Create;
    property DataBase: TSQLRest read FDataBase write FDataBase;
    property Model: TSQLModel read FModel write FModel;
  end;
  
  TContext = class(TSingleton<TORMContext>)
  end;
  
  {$I const.inc}
  
implementation
uses
  uModel;

constructor TORMContext.Create;
begin
  
end;

procedure TORMContext.AfterConstruction;
begin
  FModel := CreateModel;
  FDataBase := TSQLRestServerDB.Create(FModel, DataBaseFileName);
  TSQLRestServerDB(FDataBase).CreateMissingTables(0);
end;



end.
