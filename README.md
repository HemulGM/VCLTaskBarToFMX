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
  FTaskBar.TaskBarButtons.BeginUpdate; //important
  try
   with FTaskBar.TaskBarButtons.Add do
   begin
     Icon.LoadFromFile('image.ico');
     Hint := '123';
   end;
  finally
    FTaskBar.TaskBarButtons.EndUpdate;
  end;
  
  // call this, if you create buttons dynamicly
  FTaskBar.Initialize;
  FTaskBar.ApplyButtonsChanges;
end;

procedure TForm3.FOnThumbClick(Sender: TObject; AButtonID: Integer);
begin
  ShowMessage(AButtonID.ToString);
end;
```
