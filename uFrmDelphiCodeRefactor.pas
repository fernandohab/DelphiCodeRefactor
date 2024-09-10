unit uFrmDelphiCodeRefactor;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ControlList,
  Vcl.StdCtrls,
  System.IOUtils,
  Vcl.ExtCtrls,
  FileCtrl,
  System.Generics.Collections,
  Data.DB,
  Datasnap.DBClient,
  Vcl.ComCtrls,
  Vcl.CheckLst;

type
  TRegExData = record
    OriginalText: string;
    ReplacementText: string;
  end;

  TRefactoringData = record
    Line: Integer;
    OriginalLineText: string;
    StrToReplace: string;
    ReplacementWord: string;
  end;

  TRefactoringFile = record
    FileId: Integer;
    FileName: string;
    FileChanges: TArray<TRefactoringData>;
  end;

  TListBox = class(Vcl.StdCtrls.TListBox)
  private
    FOnScroll: TNotifyEvent;
    FOnMouseWheelDown: TMouseWheelUpDownEvent;
    FOnMouseWheelUp: TMouseWheelUpDownEvent;
  protected
    procedure ListBoxScroll(var Message: TMessage); message WM_VSCROLL;
    function DoMouseWheel(_Shift: TShiftState; _WheelDelta: Integer; _MousePos: TPoint): Boolean; override;
  public
    property OnScroll: TNotifyEvent read FOnScroll write FOnScroll;
  end;

  TControlList = class(Vcl.ControlList.TControlList)
  private
    FOnScroll: TNotifyEvent;
    FOnMouseWheelDown: TMouseWheelUpDownEvent;
    FOnMouseWheelUp: TMouseWheelUpDownEvent;
  protected
    procedure ListBoxScroll(var Message: TMessage); message WM_VSCROLL;
    function DoMouseWheel(_Shift: TShiftState; _WheelDelta: Integer; _MousePos: TPoint): Boolean; override;
  public
    property OnScroll: TNotifyEvent read FOnScroll write FOnScroll;
  end;

  TCheckListBox = class(Vcl.CheckLst.TCheckListBox)
  private
    FOnScroll: TNotifyEvent;
    FOnMouseWheelDown: TMouseWheelUpDownEvent;
    FOnMouseWheelUp: TMouseWheelUpDownEvent;
  protected
    procedure ListBoxScroll(var Message: TMessage); message WM_VSCROLL;
    function DoMouseWheel(_Shift: TShiftState; _WheelDelta: Integer; _MousePos: TPoint): Boolean; override;
  public
    property OnScroll: TNotifyEvent read FOnScroll write FOnScroll;
  end;

  TuFrmPrincipal = class(TForm)
    btnParseFiles: TButton;
    lblOriginal: TLabel;
    lblSugestAtualizar: TLabel;
    edtCaminhoPasta: TEdit;
    lblPasta: TLabel;
    btnSelectFolder: TButton;
    btnApplyChanges: TButton;
    lblCaminhoModelos: TLabel;
    edtArqCSVRegEx: TEdit;
    btnSelectRegExFile: TButton;
    ctlSourceFiles: TControlList;
    lblArqAnalisar: TLabel;
    lblFontes: TLabel;
    ctlRegExFrom: TControlList;
    lblRegExDe: TLabel;
    ctlRegExTo: TControlList;
    lblRegExPara: TLabel;
    lblPalavrasAnalisar: TLabel;
    lblPalavrasAnalisarPara: TLabel;
    lblConfigsRegEx: TLabel;
    ckbRegExWholeWords: TCheckBox;
    ckbCaseSensitive: TCheckBox;
    lblCtlOriginalCount: TLabel;
    lblCtlOriginalCountValue: TLabel;
    lblctlModificadoCount: TLabel;
    lblctlModificadoCountValue: TLabel;
    clbToUpdate: TCheckListBox;
    lbOriginal: TListBox;
    cbbArquivosRefatorar: TComboBox;
    lblArqRefatorar: TLabel;
    ckbSelectAllToUpdate: TCheckBox;
    btnRegExHelp: TButton;
    btnHelp: TButton;
    procedure btnSelectFolderClick(Sender: TObject);
    procedure btnParseFilesClick(Sender: TObject);
    procedure edtArqCSVRegExClick(Sender: TObject);
    procedure btnSelectRegExFileClick(Sender: TObject);
    procedure ctlRegExFromBeforeDrawItem(AIndex: Integer;
      ACanvas: TCanvas; ARect: TRect; AState: TOwnerDrawState);
    procedure ctlRegExToBeforeDrawItem(AIndex: Integer; ACanvas: TCanvas;
      ARect: TRect; AState: TOwnerDrawState);
    procedure ctlRegExToItemClick(Sender: TObject);
    procedure ctlRegExFromItemClick(Sender: TObject);
    procedure ctlRegExDeItemScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure ctlRegExParaItemScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure ctlSourceFilesBeforeDrawItem(AIndex: Integer;
      ACanvas: TCanvas; ARect: TRect; AState: TOwnerDrawState);
    procedure btnApplyChangesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbbArquivosRefatorarChange(Sender: TObject);
    procedure lbOriginalClick(Sender: TObject);
    procedure clbToUpdateClick(Sender: TObject);
    procedure DoScrollLbOriginal(Sender: TObject);
    procedure DoScrollClbAtualizar(Sender: TObject);
    procedure DoScrollCtlRegExDe(Sender: TObject);
    procedure DoScrollCtlRegExPara(Sender: TObject);
    procedure ckbSelectAllToUpdateClick(Sender: TObject);
    procedure edtCaminhoPastaClick(Sender: TObject);
    procedure clbToUpdateKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnRegExHelpClick(Sender: TObject);
    procedure clbToUpdateKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbOriginalKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    SelectedDirectory: TArray<string>;
    RegExWords: TArray<TRegExData>;
    SourceFilesInSelectedFolder: TArray<string>;
    RefactoringData: TArray<TRefactoringFile>;
    FullLengthOfRefactoringData: Integer;
    AIndexctlOriginalCount: Integer;
    function SelectSourceCodeDirectory: Boolean;
    function SelectRegExFileDlg: string;
    function LengthOfRefactoringSubArrays: Integer;
    function GetFullLengthOfRefactoringData: Integer;
    procedure DisplaySourceFiles;
    procedure DisplayRegExWords;
    procedure LoadSelectedRegExFile(aFileName: string);
    procedure LoadSourceFilesHits;
    procedure RegExFileSelector;
    procedure LoadSourceFilesFromFolder;
    procedure SetDevFolderDefaults;
    procedure SetSourceFilesDir;
    procedure AnalyzeSourceAndRegExFiles;
    procedure LoadFileByID(aFileID: Integer);
  public
    { Public declarations }
  end;

var
  uFrmPrincipal: TuFrmPrincipal;

implementation

{$R *.dfm}
uses
  System.RTTI,
  System.StrUtils,
  System.RegularExpressions,
  Math;

function TuFrmPrincipal.LengthOfRefactoringSubArrays: Integer;
var
  I: Integer;
begin
  Result := 0;
  try
    for I := 0 to Pred(Length(RefactoringData)) do
      Result := Length(RefactoringData[I].FileChanges);
  except
    Result := 0;
  end;
end;

procedure TuFrmPrincipal.LoadFileByID(aFileID: Integer);
var
  J: Integer;
  OriginalContent: string;
begin
  lbOriginal.Items.Clear;
  clbToUpdate.Items.Clear;
  for J := 0 to Pred(Length(RefactoringData[aFileID].FileChanges)) do
  begin
    lbOriginal.Items.Add('Line ' + RefactoringData[aFileID].FileChanges[J].Line.ToString + ' - ' + RefactoringData[aFileID].FileChanges[J].OriginalLineText);
    if ckbCaseSensitive.Checked then
      clbToUpdate.Items.Add('Line ' + RefactoringData[aFileID].FileChanges[J].Line.ToString + ' - ' +
                       StringReplace(RefactoringData[aFileID].FileChanges[J].OriginalLineText, RefactoringData[aFileID].FileChanges[J].StrToReplace,
                                     RefactoringData[aFileID].FileChanges[J].ReplacementWord, [rfReplaceAll]))
    else
      clbToUpdate.Items.Add('Line ' + RefactoringData[aFileID].FileChanges[J].Line.ToString + ' - ' +
                       StringReplace(RefactoringData[aFileID].FileChanges[J].OriginalLineText, RefactoringData[aFileID].FileChanges[J].StrToReplace,
                                     RefactoringData[aFileID].FileChanges[J].ReplacementWord, [rfReplaceAll, rfIgnoreCase]));
  end;
  if lbOriginal.Items.Count > 0 then
    lblCtlOriginalCountValue.Caption := lbOriginal.Items.Count.ToString;
  if clbToUpdate.Items.Count > 0 then
    lblctlModificadoCountValue.Caption := clbToUpdate.Items.Count.ToString;
end;

procedure TuFrmPrincipal.LoadSelectedRegExFile(aFileName: string);
var
  Lines: TArray<String>;
  TempArray: TArray<TRegExData>;
  Line,
  TempStr: string;
  I,
  CommaPos,
  FileLineCount,
  DelCount,
  _vIndex: Integer;
begin
  DelCount := 0;
  RegExWords := Nil;
  if not FileExists(aFileName) then
  begin
    ShowMessage('Select a CSV RegEx model. Click help button for tips.');
    Exit;
  end;
  Lines := TArray.Concat<String>([Lines, TFile.ReadAllLines(aFileName)]);
  FileLineCount := Length(Lines);
  SetLength(RegExWords, FileLineCount);
  for I := 0 to Pred(FileLineCount) do
  begin
    CommaPos := 0;
    CommaPos := Pos(',', Lines[I]);
    _vIndex := I - DelCount;
    if (CommaPos > 0) and (Lines[I].Length > 2) then
    begin
      RegExWords[_vIndex].OriginalText := Copy(Lines[I], 0, CommaPos-1);
      RegExWords[_vIndex].ReplacementText := Copy(Lines[I], CommaPos+1, Lines[I].Length);
    end
    else if (CommaPos = 0) and (Lines[I].Length > 3) then
    begin
      RegExWords[_vIndex].OriginalText := Lines[I];
      RegExWords[_vIndex].ReplacementText := Lines[I];
    end
    else
    begin
      Delete(RegExWords, I, 1);
      DelCount := DelCount + 1;
    end;
  end;
  if DelCount > 0 then
  begin
    while RegExWords[Length(RegExWords)-1].OriginalText = '' do
      SetLength(RegExWords, Length(RegExWords)-1);
  end;
end;

procedure TuFrmPrincipal.DisplayRegExWords;
begin
  ctlRegExFrom.Enabled := False;
  ctlRegExTo.Enabled := False;
  LoadSelectedRegExFile(edtArqCSVRegEx.Text);
  ctlRegExFrom.ItemCount := Length(RegExWords);
  ctlRegExTo.ItemCount := Length(RegExWords);
  ctlRegExFrom.Enabled := True;
  ctlRegExTo.Enabled := True;
end;

function TuFrmPrincipal.SelectRegExFileDlg: string;
var
  dlg: TOpenDialog;
begin
  Result := '';
  dlg := TOpenDialog.Create(nil);
  try
    dlg.InitialDir := 'E:\Projects\Delphi\DelphiCodeRefactor\Models';
    dlg.Filter := 'Text Files|*.txt|CSV Files|*.csv';
    if dlg.Execute then
    begin
      Result := dlg.FileName;
    end;
  finally
    dlg.Free;
  end;
end;

procedure TuFrmPrincipal.LoadSourceFilesFromFolder;
begin
  SourceFilesInSelectedFolder := TDirectory.GetFiles(SelectedDirectory[0], '*.pas');
end;

procedure TuFrmPrincipal.LoadSourceFilesHits;
var
  _FileName,
  Line,
  _TextToReplace: string;
  Lines: TArray<string>;
  I,
  FileLineNumber,
  FileNum,
  LineNum,
  DelLineCount,
  LineMatchNumber,
  _vIndex,
  AnalysingFileLinesCount: Integer;
begin
  FileNum := 0;
  DelLineCount := 0;
  for _FileName in SourceFilesInSelectedFolder do
  begin
    Lines := Nil;
    Lines := TArray.Concat<String>([Lines, TFile.ReadAllLines(_FileName)]);
    AnalysingFileLinesCount := Length(Lines);
    SetLength(RefactoringData, Length(SourceFilesInSelectedFolder));
    SetLength(RefactoringData[FileNum].FileChanges, 0);
    FileLineNumber := 0;
    LineMatchNumber := 0;
    for Line in Lines do
    begin
      var LenX := Pred(Length(RegExWords));
      for I := 0 to LenX do
      begin
        if TRegEx.Match(Line, '\b' + RegExWords[I].OriginalText + '\b', [roIgnoreCase]).Success then
        begin
          SetLength(RefactoringData[FileNum].FileChanges, Length(RefactoringData[FileNum].FileChanges)+1);
          LineNum := FileLineNumber - DelLineCount;
          RefactoringData[FileNum].FileId := FileNum;
          RefactoringData[FileNum].FileName := _FileName;
          RefactoringData[FileNum].FileChanges[LineMatchNumber].Line := FileLineNumber;
          RefactoringData[FileNum].FileChanges[LineMatchNumber].OriginalLineText := Line;
          //_TextToReplace := StringReplace(Line, '\b' + RegExWords[I].OriginalText + '\b', '\b' + RegExWords[I].StrToReplace + '\b', [rfReplaceAll, rfIgnoreCase]);;
          RefactoringData[FileNum].FileChanges[LineMatchNumber].StrToReplace := RegExWords[I].OriginalText;
          RefactoringData[FileNum].FileChanges[LineMatchNumber].ReplacementWord := RegExWords[I].ReplacementText;
          Inc(LineMatchNumber);
        end
        else
        begin
          //Delete(RefactoringData[FileNum].FileChanges, FileLineNumber, 1);
          DelLineCount := DelLineCount + 1;
        end;
      end;
      Inc(FileLineNumber);
    end;
//    if DelLineCount > 0 then
//    begin
//      while RefactoringData[Length(RefactoringData)-1].FileName = '' do
//        SetLength(RefactoringData, Length(RefactoringData)-1);
//    end;
    Inc(FileNum);
    if DelLineCount = AnalysingFileLinesCount then
      Delete(RefactoringData, FileNum, 1);
  end;
end;

procedure TuFrmPrincipal.AnalyzeSourceAndRegExFiles;
var
  I: Integer;
  ContentToAdd: string;
begin
  cbbArquivosRefatorar.Items.Clear;
  for I := 0 to Pred(Length(RefactoringData)) do
  begin
    var Splitt: TArray<string> := SplitString(RefactoringData[I].FileName, '\');
    ContentToAdd := '\' + Splitt[Length(Splitt)-2] + '\' + Splitt[Length(Splitt)-1];
    cbbArquivosRefatorar.Items.Add(ContentToAdd);
  end; 
  if cbbArquivosRefatorar.Items.Count > 0 then
  begin
    cbbArquivosRefatorar.ItemIndex := 0;
    LoadFileByID(cbbArquivosRefatorar.ItemIndex);
  end;
end;

procedure TuFrmPrincipal.cbbArquivosRefatorarChange(Sender: TObject);
begin
  LoadFileByID(cbbArquivosRefatorar.ItemIndex);
end;

procedure TuFrmPrincipal.ckbSelectAllToUpdateClick(Sender: TObject);
begin
  clbToUpdate.CheckAll(cbUnchecked, True, False);
  if ckbSelectAllToUpdate.Checked then
    clbToUpdate.CheckAll(cbChecked, True, False);
end;

procedure TuFrmPrincipal.clbToUpdateClick(Sender: TObject);
begin
  lbOriginal.ItemIndex := clbToUpdate.ItemIndex;
  //Color := TColor(clbToUpdate.Items.Objects[clbToUpdate.ItemIndex]);
  //clbToUpdate.Items.Strings[0].Format()
  TRttiContext.Create.GetType(TControlList).GetField('FScrollPos').SetValue(lbOriginal, TRttiContext.Create.GetType(TControlList).GetField('FScrollPos').GetValue(Sender).AsInteger);
end;

procedure TuFrmPrincipal.clbToUpdateKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if ((Key = Ord('A')) and (ssCtrl in Shift)) then
  begin
    ckbSelectAllToUpdate.Checked := not ckbSelectAllToUpdate.Checked;
  end;
end;

procedure TuFrmPrincipal.clbToUpdateKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  TRttiContext.Create.GetType(TControlList).GetField('FScrollPos').SetValue(lbOriginal, TRttiContext.Create.GetType(TControlList).GetField('FScrollPos').GetValue(Sender).AsInteger);
end;

procedure TuFrmPrincipal.ctlSourceFilesBeforeDrawItem(AIndex: Integer;
  ACanvas: TCanvas; ARect: TRect; AState: TOwnerDrawState);
begin
  if Length(SourceFilesInSelectedFolder) >= AIndex then
  begin
    var Splitt: TArray<string> := SplitString(SourceFilesInSelectedFolder[AIndex], '\');
    lblArqAnalisar.Caption := '\' + Splitt[Length(Splitt)-2] + '\' + Splitt[Length(Splitt)-1];
  end;
end;

procedure TuFrmPrincipal.ctlRegExFromBeforeDrawItem(AIndex: Integer;
  ACanvas: TCanvas; ARect: TRect; AState: TOwnerDrawState);
begin
  lblRegExDe.Caption := RegExWords[AIndex].OriginalText;
end;

procedure TuFrmPrincipal.ctlRegExFromItemClick(Sender: TObject);
var
  XPos: Integer;
begin
  ctlRegExTo.ItemIndex := ctlRegExFrom.ItemIndex;
  TRttiContext.Create.GetType(TControlList).GetField('FScrollPos').SetValue(ctlRegExTo, TRttiContext.Create.GetType(TControlList).GetField('FScrollPos').GetValue(Sender).AsInteger);
end;

procedure TuFrmPrincipal.ctlRegExDeItemScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  ctlRegExTo.ItemIndex := ctlRegExFrom.ItemIndex;
  TRttiContext.Create.GetType(TControlList).GetField('FScrollPos').SetValue(ctlRegExTo, TRttiContext.Create.GetType(TControlList).GetField('FScrollPos').GetValue(Sender).AsInteger);
end;

procedure TuFrmPrincipal.ctlRegExToBeforeDrawItem(AIndex: Integer;
  ACanvas: TCanvas; ARect: TRect; AState: TOwnerDrawState);
begin
  lblRegExPara.Caption := RegExWords[AIndex].ReplacementText;
end;

procedure TuFrmPrincipal.ctlRegExToItemClick(Sender: TObject);
begin
  ctlRegExFrom.ItemIndex := ctlRegExTo.ItemIndex;
  TRttiContext.Create.GetType(TControlList).GetField('FScrollPos').SetValue(ctlRegExFrom, TRttiContext.Create.GetType(TControlList).GetField('FScrollPos').GetValue(Sender).AsInteger);
end;

procedure TuFrmPrincipal.ctlRegExParaItemScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  ctlRegExFrom.ItemIndex := ctlRegExTo.ItemIndex;
  TRttiContext.Create.GetType(TControlList).GetField('FScrollPos').SetValue(ctlRegExFrom, TRttiContext.Create.GetType(TControlList).GetField('FScrollPos').GetValue(Sender).AsInteger);
end;

procedure TuFrmPrincipal.btnParseFilesClick(Sender: TObject);
begin
  if (Length(SourceFilesInSelectedFolder) < 1) then
  begin
    ShowMessage('There are no source code files in the selected folder.');
    Exit;
  end;
  if (Length(edtArqCSVRegEx.Text) = 0) then
  begin
    ShowMessage('Please select a RegEx template file.');
    Exit;
  end
  else if Length(RegExWords) < 1 then
  begin
    ShowMessage('There are no compatible RegEx templates in the selected file.');
    Exit;
  end;
  //AnalyzeFiles;
  LoadSourceFilesHits;
  AnalyzeSourceAndRegExFiles;
end;

procedure TuFrmPrincipal.btnRegExHelpClick(Sender: TObject);
begin
  ShowMessage('Select a 2 columns CSV file.' + sLineBreak +
              'The first column should contain the original word.' + sLineBreak +
              'The second column should contain the new word' + sLineBreak +
              'Ex: ' + sLineBreak +
              'SHoWmeSSAgE,ShowMessage');
end;

procedure TuFrmPrincipal.btnApplyChangesClick(Sender: TObject);
begin
  ShowMessage('Under development... Msg: Confirm update?');
  // to do
end;

procedure TuFrmPrincipal.btnSelectFolderClick(Sender: TObject);
begin
  SetSourceFilesDir;
end;

procedure TuFrmPrincipal.SetDevFolderDefaults;
begin
  SetLength(SelectedDirectory, 1);
  SelectedDirectory[0] := 'E:\Projects\Delphi\DelphiCodeRefactor\SampleCode';
  edtCaminhoPasta.Text := SelectedDirectory[0];
  DisplaySourceFiles;
  edtArqCSVRegEx.Text := 'E:\Projects\Delphi\DelphiCodeRefactor\Models\WordsReplace.txt';
  DisplayRegExWords;
end;

procedure TuFrmPrincipal.RegExFileSelector;
begin
  edtArqCSVRegEx.Text := SelectRegExFileDlg;
  DisplayRegExWords;
end;

procedure TuFrmPrincipal.SetSourceFilesDir;
begin
  if SelectSourceCodeDirectory then
  begin
    DisplaySourceFiles;
  end;
end;

procedure TuFrmPrincipal.btnSelectRegExFileClick(Sender: TObject);
begin
  RegExFileSelector;
end;

procedure TuFrmPrincipal.edtArqCSVRegExClick(Sender: TObject);
begin
  RegExFileSelector;
end;

procedure TuFrmPrincipal.edtCaminhoPastaClick(Sender: TObject);
begin
  SetSourceFilesDir;
end;

procedure TuFrmPrincipal.FormShow(Sender: TObject);
begin
  lbOriginal.OnScroll := DoScrollLbOriginal;
  clbToUpdate.OnScroll := DoScrollClbAtualizar;
  ctlRegExFrom.OnScroll := DoScrollCtlRegExDe;
  ctlRegExTo.OnScroll := DoScrollCtlRegExPara;
  SetDevFolderDefaults;
end;

function TuFrmPrincipal.GetFullLengthOfRefactoringData: Integer;
begin
  Result := 0;
  try
    FullLengthOfRefactoringData := LengthOfRefactoringSubArrays + Length(RefactoringData);
    Result := FullLengthOfRefactoringData;
  except
    on E: Exception do
    begin
      Result := 0; 
      ShowMessage('Failed GetFullLengthOfRefactoringData');
    end;
  end;
end;

procedure TuFrmPrincipal.lbOriginalClick(Sender: TObject);
begin
  clbToUpdate.ItemIndex := lbOriginal.ItemIndex;
  TRttiContext.Create.GetType(TControlList).GetField('FScrollPos').SetValue(clbToUpdate, TRttiContext.Create.GetType(TControlList).GetField('FScrollPos').GetValue(Sender).AsInteger);
end;

procedure TuFrmPrincipal.lbOriginalKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  clbToUpdate.ItemIndex := lbOriginal.ItemIndex;
  TRttiContext.Create.GetType(TControlList).GetField('FScrollPos').SetValue(clbToUpdate, TRttiContext.Create.GetType(TControlList).GetField('FScrollPos').GetValue(Sender).AsInteger);
end;

procedure TuFrmPrincipal.DisplaySourceFiles;
begin
  ctlSourceFiles.Enabled := False;
  edtCaminhoPasta.Text := '';
  LoadSourceFilesFromFolder;
  ctlSourceFiles.ItemCount := Length(SourceFilesInSelectedFolder);
  ctlSourceFiles.Enabled := True;
  edtCaminhoPasta.Text := SelectedDirectory[0];
end;

procedure TuFrmPrincipal.DoScrollClbAtualizar(Sender: TObject);
begin
  if (clbToUpdate.TopIndex > clbToUpdate.ItemIndex) then
    clbToUpdate.ItemIndex := clbToUpdate.TopIndex;
  lbOriginal.TopIndex := clbToUpdate.TopIndex;
end;

procedure TuFrmPrincipal.DoScrollCtlRegExDe(Sender: TObject);
begin
  ctlRegExTo.ItemIndex := ctlRegExFrom.ItemIndex;
end;

procedure TuFrmPrincipal.DoScrollCtlRegExPara(Sender: TObject);
begin
  ctlRegExFrom.ItemIndex := ctlRegExTo.ItemIndex;
end;

procedure TuFrmPrincipal.DoScrollLbOriginal(Sender: TObject);
begin
  clbToUpdate.TopIndex := lbOriginal.TopIndex;
  clbToUpdate.ItemIndex := clbToUpdate.TopIndex;
  //TRttiContext.Create.GetType(TControlList).GetField('FScrollPos').SetValue(clbToUpdate, TRttiContext.Create.GetType(TControlList).GetField('FScrollPos').GetValue(Sender).AsInteger);
end;

function TuFrmPrincipal.SelectSourceCodeDirectory: Boolean;
begin
  Result := SelectDirectory('E:\Projects\Delphi\DelphiCodeRefactor\SampleCode', SelectedDirectory, [], 'Select a path', 'Path:','Confirm');
end;

{ TListBox }

function TListBox.DoMouseWheel(_Shift: TShiftState; _WheelDelta: Integer; _MousePos: TPoint): Boolean;
var
  Idx: Integer;
begin
  // calculate the index of the item to select
  Idx := ItemIndex - Sign(_WheelDelta);
  if Idx >= Items.Count then
    Idx := Items.Count
  else if Idx < 0 then
    Idx := 0;
  // select it
  ItemIndex := Idx;
  // and simulate a mouse click on it so the selected table gets displayed
  Self.Click;

  // tell the caller that the event has been handled
  Result := True;
end;

procedure TListBox.ListBoxScroll(var Message: TMessage);
begin
  inherited;
  if Assigned(FOnScroll) then
    FOnScroll(Self);
end;

{ TCheckListBox }

function TCheckListBox.DoMouseWheel(_Shift: TShiftState;
  _WheelDelta: Integer; _MousePos: TPoint): Boolean;
var
  Idx: Integer;
begin
  // calculate the index of the item to select
  Idx := ItemIndex - Sign(_WheelDelta);
  if Idx >= Items.Count then
    Idx := Items.Count
  else if Idx < 0 then
    Idx := 0;
  // select it
  ItemIndex := Idx;
  // and simulate a mouse click on it so the selected table gets displayed
  Self.Click;

  // tell the caller that the event has been handled
  Result := True;
end;

procedure TCheckListBox.ListBoxScroll(var Message: TMessage);
begin
  inherited;
  if Assigned(FOnScroll) then
    FOnScroll(Self);
end;

{ TControlList }

function TControlList.DoMouseWheel(_Shift: TShiftState;
  _WheelDelta: Integer; _MousePos: TPoint): Boolean;
var
  Idx: Integer;
begin
  // calculate the index of the item to select
  Idx := ItemIndex - Sign(_WheelDelta);
  if Idx >= ItemCount then
    Idx := ItemCount
  else if Idx < 0 then
    Idx := 0;
  // select it
  ItemIndex := Idx;
  // and simulate a mouse click on it so the selected table gets displayed
  Self.Click;

  // tell the caller that the event has been handled
  Result := True;
end;

procedure TControlList.ListBoxScroll(var Message: TMessage);
begin
  inherited;
  if Assigned(FOnScroll) then
    FOnScroll(Self);
end;

end.
