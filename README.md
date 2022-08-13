# VCLTaskBarToFMX
 
Example 
```Pascal
uses HGM.TaskBar, Vcl.Graphics;

procedure TForm3.FormCreate(Sender: TObject);
begin
  FTaskBar := TTaskbar.Create(Self);
  FTaskBar.OnThumbButtonClick := FOnThumbClick;
  FTaskBar.ProgressState := TTaskBarProgressState.Normal;
  FTaskBar.ProgressMaxValue := 100;
  FTaskBar.ProgressValue := 32;
  with FTaskBar.TaskBarButtons.Add do
  begin
    Icon := TIcon.Create;
    Icon.LoadFromFile('image.ico');
    Hint := '123';
  end;
end;

procedure TForm3.FOnThumbClick(Sender: TObject; AButtonID: Integer);
begin
  ShowMessage(AButtonID.ToString);
end;
```
