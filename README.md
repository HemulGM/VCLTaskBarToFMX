# VCLTaskBarToFMX
 
Example 
```Pascal
uses HGM.TaskBar;

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
  
  // call this, if you create buttons dynamicly (update added buttons)
  //FTaskBar.Initialize;
  //FTaskBar.ApplyButtonsChanges;
end;

procedure TForm3.FOnThumbClick(Sender: TObject; AButtonID: Integer);
begin
  ShowMessage(AButtonID.ToString);
end;
```
![HGMComponents](https://github.com/HemulGM/VCLTaskBarToFMX/blob/main/Media/screen1.png)
