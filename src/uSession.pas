unit uSession;

interface
uses
  uModel, System.SysUtils, System.Types, System.Classes, uSingleton;
type
  TSession = class
  private
    fAccount: TSQLAccount;
    fRole: TSQLRole;
    fIsAdmin: Boolean;
    
    function GetIsAdmin: Boolean;
    procedure GetActionList;
  public
    destructor Destroy; override;
    function Login(user, password: string): Boolean;
    procedure Logout;
    
    property IsAdmin: Boolean read fIsAdmin;
    property Account: TSQLAccount read fAccount;
    property Role: TSQLRole read fRole;
  end;
  
  TUserSession = class(TSingleton<TSession>)
  end;
    
  
implementation
uses
  uDataBase, SynCommons, uMain, Vcl.ActnList, uHelper;

destructor TSession.Destroy;
begin
  if Assigned(fAccount) then
    FreeAndNil(fAccount);
  if Assigned(fRole) then
    FreeAndNil(fRole);
end;

function TSession.Login(user, password: string): Boolean;
var
  msg: string;
begin
  //
  result := False;
  fAccount := TSQLAccount.Create(TContext.Instance.DataBase, 'account_name=?', [StringToUTF8(user)]);
  try
    if (fAccount.ID > 0) and (fAccount.pwd = password)  then
    begin
      result := True;
      //set is admin or not
      fIsAdmin := GetIsAdmin;
      //set current user right
      if not fIsAdmin then
        GetActionList;
    end;
  finally
    //FreeAndNil(fAccount);
  end;
end;

function TSession.GetIsAdmin: Boolean;
var
  accountRoleMap: TSQLAccountRoleMap;
  //role: TSQLRole;
begin
  accountRoleMap := TSQLAccountRoleMap.Create(TContext.Instance.DataBase, 'account=?', [Int64ToUtf8(account.ID)]);
  try
    fRole := TSQLRole.Create(TContext.Instance.DataBase, accountRoleMap.role);
  finally
    FreeAndNil(accountRoleMap);
  end;
  result := fRole.IsAdmin;
end;

procedure TSession.GetActionList;
var
  role: TSQLRole;
  roleActionMap: TSQLRoleActionMap;
  i: Integer;
  action: TAction;

  function FindActionRight(actionCaption: RawUtf8): TActionRight;
  begin
    result := TActionRight.arNone;
    roleActionMap.FillRewind;
    while roleActionMap.FillOne do
    begin
      if roleActionMap.action = actionCaption then
        result := roleActionMap.right;
    end;
  end;
begin
  roleActionMap := TSQLRoleActionMap.CreateAndFillPrepare(TContext.Instance.DataBase, 'role=?', [Int64ToUtf8(fRole.ID)]);
  if roleActionMap = nil then
    exit;
  try
    for i := 0 to MainForm.MainActionList.ActionCount - 1 do
    begin
      if MainForm.MainActionList.Actions[i] is TAction then
      begin
        action := MainForm.MainActionList.Actions[i] as TAction;
        if action = nil then
          continue;
        case FindActionRight(StringToUtf8(action.Caption)) of
          TActionRight.arNone:
            begin
              action.Enabled := False;
              action.Visible := False
            end;
          TActionRight.arEnabled:
            begin
              action.Enabled := True;
              action.Visible := True;
            end;
          TActionRight.arVisible:
            begin
              action.Enabled := False;
              action.Visible := True;
            end;
        end;
      end;
    end;
    FixMainFormMenu;
 finally
    FreeAndNil(roleActionMap);
  end;
end;

procedure TSession.Logout;
begin
  if Assigned(fAccount) then
    FreeAndNil(fAccount);
  if Assigned(fRole) then
    FreeAndNil(fRole);
end;


end.
