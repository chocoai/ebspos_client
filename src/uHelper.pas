unit uHelper;

interface
uses
  Vcl.Controls, System.Classes, Vcl.Graphics, Types, VirtualTrees, System.SysUtils, Windows;

/// 是否初始化过 当数据库中门店信息为空视为没有初始化过
function AppInitialized: Boolean;
/// 显示错误提示 
function ShowMsgHint(Title, Msg: string; Control: TControl): TBalloonHint; overload;
procedure ShowMsgHint(Title, Msg: string; Control: TControl; Hint: TBalloonHint); overload;
procedure FixMainFormMenu;
procedure ClientRectToScreenRect(ClientRect: TRect; Parent: TControl; var ScreenRect: TRect);
function GetTextHeight(Font: TFont): Integer;
procedure FixVT(VT: TVirtualStringTree; MultiLineCount: Word=1);
function sstr(str: String; len: Integer) : String;
function KeyPressed(Code: Integer): Boolean;
procedure SelectNode(VT: TVirtualStringTree; idx: Int64; ParentNode: PVirtualNode=nil); overload;
procedure SelectNode(VT: TVirtualStringTree; Node: PVirtualNode); overload;
function FindNode(VT: TVirtualStringTree; idx: Int64; ParentNode: PVirtualNode): PVirtualNode;
implementation
uses
  uSingleton, uDataBase, uModel, uMain, Vcl.Menus, Vcl.ActnList;

function AppInitialized: Boolean;
begin
  result := TContext.Instance.DataBase.TableRowCount(TSQLStore) > 0;
end;

function ShowMsgHint(Title, Msg: string; Control: TControl): TBalloonHint;
var
  hint: TBalloonHint;
begin
  if Control = nil then
    Exit;
  hint := TBalloonHint.Create(Control.Parent);
  ShowMsgHint(Title, Msg, Control, hint);
  result := hint;
end;

procedure ShowMsgHint(Title, Msg: string; Control: TControl; Hint: TBalloonHint);
var
  rect, screenRect: TRect;
begin
  if Hint = nil then
    Exit;
  Hint.Title := Title;
  Hint.Description := Msg;
  rect := Control.BoundsRect;
  ClientRectToScreenRect(rect, Control.Parent, screenRect);
  Hint.ShowHint(screenRect);
end;

procedure FixMainFormMenu;
var
  i: Integer;
  function HasLeafMenuItem(MenuItem: TMenuItem): Boolean;
  var
    i: Integer;
    action: TAction;
  begin
    result := false;
    for I := 0 to MenuItem.Count - 1 do
    begin
      if Assigned(MenuItem.Items[i].Action) then
      begin
        if MenuItem.Items[i].Action is TAction then
        begin
          action := MenuItem.Items[i].Action as TAction;
          if action.Enabled or action.Visible then
          begin
            result := True;
            exit;
          end;
        end;
      end
      else
        result := HasLeafMenuItem(MenuItem.Items[i]);
    end;
  end;
begin
  //fix main menu
  for i := 0 to MainForm.MainFormMenu.Items.Count - 1 do
  begin
    if HasLeafMenuItem(MainForm.MainFormMenu.Items[i]) then
      MainForm.MainFormMenu.Items[i].Visible := True
    else
      MainForm.MainFormMenu.Items[i].Visible := False;
  end;
end;

procedure ClientRectToScreenRect(ClientRect: TRect; Parent: TControl; var ScreenRect: TRect);
var
  p1, p2: TPoint;
begin
  if Parent = nil then
  begin
    ScreenRect.TopLeft :=  ClientRect.TopLeft;
    ScreenRect.BottomRight := ClientRect.BottomRight;
    Exit;
  end;
  ScreenRect.TopLeft := Parent.ClientToScreen(ClientRect.TopLeft);
  ScreenRect.BottomRight := Parent.ClientToScreen(ClientRect.BottomRight);
end;

procedure FixVT(VT: TVirtualStringTree; MultiLineCount: Word=1);
var
  SingleLineHeight: Integer;
  Node: PVirtualNode;
begin
  // Resize hardcoded node height to work with different DPI settings
  VT.BeginUpdate;
  SingleLineHeight := GetTextHeight(VT.Font);
  VT.DefaultNodeHeight := SingleLineHeight * MultiLineCount + 5;
  // The header needs slightly more height than the normal nodes
  VT.Header.Height := Trunc(SingleLineHeight * 1.5);
  // Apply new height to multi line grid nodes
  Node := VT.GetFirstInitialized;
  while Assigned(Node) do begin
    VT.NodeHeight[Node] := VT.DefaultNodeHeight;
    VT.MultiLine[Node] := MultiLineCount > 1;
    Node := VT.GetNextInitialized(Node);
  end;
  VT.EndUpdate;
  // Disable hottracking in non-Vista mode, looks ugly in XP, but nice in Vista
  if (toUseExplorerTheme in VT.TreeOptions.PaintOptions) and (Win32MajorVersion >= 6) then
    VT.TreeOptions.PaintOptions := VT.TreeOptions.PaintOptions + [toHotTrack]
  else
    VT.TreeOptions.PaintOptions := VT.TreeOptions.PaintOptions - [toHotTrack];
  VT.OnGetHint := MainForm.AnyGridGetHint;
  VT.OnScroll := MainForm.AnyGridScroll;
  VT.OnMouseWheel := MainForm.AnyGridMouseWheel;
  VT.ShowHint := True;
  VT.HintMode := hmToolTip;
  // Apply case insensitive incremental search event
  if VT.IncrementalSearch <> isNone then
    VT.OnIncrementalSearch := Mainform.AnyGridIncrementalSearch;
  VT.OnStartOperation := Mainform.AnyGridStartOperation;
  VT.OnEndOperation := Mainform.AnyGridEndOperation;
end;

function GetTextHeight(Font: TFont): Integer;
var
  DC: HDC;
  SaveFont: HFont;
  SysMetrics, Metrics: TTextMetric;
begin
  // Code taken from StdCtrls.TCustomEdit.AdjustHeight
  DC := GetDC(0);
  GetTextMetrics(DC, SysMetrics);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  Result := Metrics.tmHeight;
end;

{***
  Shorten string to length len and append 3 dots

  @param string String to shorten
  @param integer Wished Length of string
  @return string
}
function sstr(str: String; len: Integer) : String;
begin
  if length(str) > len then
  begin
    str := copy(str, 0, len-1);
    str := str + '...';
  end;
  result := str;
end;

function KeyPressed(Code: Integer): Boolean;
var
  State: TKeyboardState;
begin
  // Checks whether a key is pressed, defined by virtual key code
  GetKeyboardState(State);
  Result := (State[Code] and 128) <> 0;
end;


procedure SelectNode(VT: TVirtualStringTree; idx: Int64; ParentNode: PVirtualNode=nil); overload;
var
  Node: PVirtualNode;
begin
  // Helper to focus and highlight a node by its index
  Node := FindNode(VT, idx, ParentNode);
  if Assigned(Node) then
    SelectNode(VT, Node);
end;

procedure SelectNode(VT: TVirtualStringTree; Node: PVirtualNode); overload;
var
  OldFocus: PVirtualNode;
begin
  if Node = VT.RootNode then
    Node := nil;
  OldFocus := VT.FocusedNode;
  VT.ClearSelection;
  VT.FocusedNode := Node;
  VT.Selected[Node] := True;
  VT.ScrollIntoView(Node, False);
  if (OldFocus = Node) and Assigned(VT.OnFocusChanged) then
    VT.OnFocusChanged(VT, Node, VT.Header.MainColumn);
end;

function FindNode(VT: TVirtualStringTree; idx: Int64; ParentNode: PVirtualNode): PVirtualNode;
var
  Node: PVirtualNode;
begin
  // Helper to find a node by its index
  Result := nil;
  if Assigned(ParentNode) then
    Node := VT.GetFirstChild(ParentNode)
  else
    Node := VT.GetFirst;
  while Assigned(Node) do begin
    // Note: Grid.RootNodeCount is unfortunately Cardinal, not UInt64.
    if Node.Index = idx then begin
      Result := Node;
      break;
    end;
    Node := VT.GetNextSibling(Node);
  end;
end;

end.
