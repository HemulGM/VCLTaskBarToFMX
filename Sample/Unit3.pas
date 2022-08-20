unit Unit3;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, HGM.TaskBar;

type
  TForm3 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    FTaskBar: TTaskbar;
    procedure FOnThumbClick(Sender: TObject; AButtonID: Integer);
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses
  System.Win.TaskbarCore;

{$R *.fmx}

procedure TForm3.FormCreate(Sender: TObject);
begin
  FTaskBar := TTaskbar.Create(Self);
  FTaskBar.OnThumbButtonClick := FOnThumbClick;
  FTaskBar.ProgressState := TTaskBarProgressState.Normal;
  FTaskBar.ProgressMaxValue := 100;
  FTaskBar.ProgressValue := 32;
  FTaskBar.TaskBarButtons.BeginUpdate; //important (lock of update for buttons)
  try
    with FTaskBar.TaskBarButtons.Add do
    begin
      Icon.LoadFromFile('image.ico');
      Hint := '123';
    end;
  finally
    FTaskBar.TaskBarButtons.EndUpdate;
  end;
end;

procedure TForm3.FOnThumbClick(Sender: TObject; AButtonID: Integer);
begin
  ShowMessage(AButtonID.ToString);
end;

end.

