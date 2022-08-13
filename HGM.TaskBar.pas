unit HGM.TaskBar;

interface

uses
  Vcl.Taskbar, Winapi.Windows, System.Classes, Winapi.Messages;

type
  TTaskbar = class(Vcl.Taskbar.TTaskbar)
  private
    FOldFMXWndProc: Winapi.Windows.TFNWndProc;
    FNewFMXWndProc: Pointer;
    FInited: Boolean;
    procedure WndProcHook;
    procedure CustomWndProc(var Msg: TMessage);
  protected
    function GetFormHandle: HWND; override;
  public
    procedure Initialize; override;
    constructor Create(AOwner: TComponent); override;
  end;

var
  RM_TaskbarCreated: DWORD;
  RM_TaskBarButtonCreated: DWORD;

implementation

uses
  FMX.Platform.Win;

{ TTaskbar }

constructor TTaskbar.Create(AOwner: TComponent);
begin
  FInited := False;
  inherited;
  WndProcHook;
end;

procedure TTaskbar.WndProcHook;
var
  FMXHandle: HWND;
begin
  FMXHandle := ApplicationHWND;
  FOldFMXWndProc := TFNWndProc(Winapi.Windows.GetWindowLong(FMXHandle, GWL_WNDPROC));
  FNewFMXWndProc := MakeObjectInstance(CustomWndProc);
  Winapi.Windows.SetWindowLong(FMXHandle, GWL_WNDPROC, NativeInt(FNewFMXWndProc));
end;

procedure TTaskbar.CustomWndProc(var Msg: TMessage);
begin
  case Msg.Msg of
    WM_COMMAND:
      DoThumbButtonNotify(TWMCommand(Msg).ItemID);
    WM_DWMSENDICONICTHUMBNAIL:
      DoThumbPreviewRequest(Msg.LParamLo, Msg.lParamHi);
    WM_DWMSENDICONICLIVEPREVIEWBITMAP:
      DoWindowPreviewRequest;
  else
    if Cardinal(Msg.Msg) = RM_TaskbarCreated then
    begin
      { Это, вероятно нахер не надо =)
      Perform(CM_WININICHANGE, 0, 0);
      Perform(CM_SYSCOLORCHANGE, 0, 0);
      Perform(CM_SYSFONTCHANGED, 0, 0);
      Perform(CM_PARENTCOLORCHANGED, 0, 0);
      Perform(CM_PARENTFONTCHANGED, 0, 0);
      Perform(CM_PARENTBIDIMODECHANGED, 0, 0);
      Perform(CM_PARENTDOUBLEBUFFEREDCHANGED, 0, 0);}
    end
    else if Cardinal(Msg.Msg) = RM_TaskBarButtonCreated then
    begin
      Initialize;
      CheckApplyChanges;
    end;
  end;

  Msg.Result := CallWindowProc(FOldFMXWndProc, ApplicationHWND, Msg.Msg, Msg.WParam, Msg.LParam);
end;

function TTaskbar.GetFormHandle: HWND;
begin
  if FInited then
    Result := ApplicationHWND
  else
    Result := 0;
end;

procedure TTaskbar.Initialize;
begin
  FInited := True;
  inherited;
end;

initialization
  RM_TaskBarCreated := RegisterWindowMessage('TaskbarCreated');
  RM_TaskBarButtonCreated := RegisterWindowMessage('TaskbarButtonCreated');

end.

