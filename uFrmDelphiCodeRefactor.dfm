object uFrmPrincipal: TuFrmPrincipal
  Left = 763
  Top = 305
  Caption = 'DelphiCodeRefactor'
  ClientHeight = 912
  ClientWidth = 1197
  Color = clBtnFace
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  OnShow = FormShow
  TextHeight = 15
  object lblOriginal: TLabel
    Left = 40
    Top = 482
    Width = 37
    Height = 15
    Caption = 'Found:'
  end
  object lblSugestAtualizar: TLabel
    Left = 573
    Top = 482
    Width = 49
    Height = 15
    Caption = 'Changes:'
  end
  object lblPasta: TLabel
    Left = 36
    Top = 22
    Width = 73
    Height = 15
    Caption = 'Source folder:'
  end
  object lblCaminhoModelos: TLabel
    Left = 564
    Top = 22
    Width = 96
    Height = 15
    Caption = 'RegEx CSV model:'
  end
  object lblFontes: TLabel
    Left = 36
    Top = 81
    Width = 63
    Height = 15
    Caption = 'Source files:'
  end
  object lblCSVSearch: TLabel
    Left = 565
    Top = 81
    Width = 48
    Height = 15
    Caption = 'Find this:'
  end
  object lblCSVReplace: TLabel
    Left = 820
    Top = 81
    Width = 58
    Height = 15
    Caption = 'Replace to:'
  end
  object lblConfigsRegEx: TLabel
    Left = 1071
    Top = 158
    Width = 79
    Height = 15
    Caption = 'RegEx Configs:'
  end
  object lblCtlOriginalCount: TLabel
    Left = 425
    Top = 879
    Width = 55
    Height = 15
    Caption = 'Lines Qty: '
  end
  object lblCtlOriginalCountValue: TLabel
    Left = 501
    Top = 879
    Width = 3
    Height = 15
  end
  object lblctlModificadoCount: TLabel
    Left = 564
    Top = 877
    Width = 25
    Height = 15
    Caption = 'Qty: '
  end
  object lblctlModificadoCountValue: TLabel
    Left = 609
    Top = 879
    Width = 3
    Height = 15
  end
  object lblArqRefatorar: TLabel
    Left = 40
    Top = 449
    Width = 24
    Height = 15
    Caption = 'File: '
  end
  object btnParseFiles: TButton
    Left = 1071
    Top = 106
    Width = 110
    Height = 36
    Caption = 'Parse Files'
    TabOrder = 0
    OnClick = btnParseFilesClick
  end
  object edtCaminhoPasta: TEdit
    Left = 32
    Top = 40
    Width = 505
    Height = 23
    HelpType = htKeyword
    HelpKeyword = 'Click to select a folder'
    TabOrder = 1
    TextHint = 'Click to select a folder'
    OnClick = edtCaminhoPastaClick
  end
  object btnSelectFolder: TButton
    Left = 425
    Top = 69
    Width = 112
    Height = 23
    Caption = 'Select Folder'
    TabOrder = 2
    OnClick = btnSelectFolderClick
  end
  object btnApplyChanges: TButton
    Left = 1071
    Top = 556
    Width = 110
    Height = 31
    Caption = 'Apply'
    TabOrder = 3
    OnClick = btnApplyChangesClick
  end
  object edtArqCSVRegEx: TEdit
    Left = 561
    Top = 40
    Width = 504
    Height = 23
    HelpType = htKeyword
    HelpKeyword = 'Click to select a file'
    TabOrder = 4
    TextHint = 'Click to select a file'
    OnClick = edtArqCSVRegExClick
  end
  object btnSelectRegExFile: TButton
    Left = 951
    Top = 69
    Width = 114
    Height = 23
    Caption = 'Select File'
    TabOrder = 5
    OnClick = btnSelectRegExFileClick
  end
  object ctlSourceFiles: TControlList
    Left = 32
    Top = 102
    Width = 505
    Height = 332
    ItemHeight = 22
    ItemMargins.Left = 0
    ItemMargins.Top = 0
    ItemMargins.Right = 0
    ItemMargins.Bottom = 0
    ParentColor = False
    TabOrder = 6
    OnBeforeDrawItem = ctlSourceFilesBeforeDrawItem
    object lblArqAnalisar: TLabel
      Left = 9
      Top = 3
      Width = 3
      Height = 15
    end
  end
  object ctlRegExFrom: TControlList
    Left = 561
    Top = 102
    Width = 249
    Height = 332
    ItemHeight = 22
    ItemMargins.Left = 0
    ItemMargins.Top = 0
    ItemMargins.Right = 0
    ItemMargins.Bottom = 0
    ParentColor = False
    TabOrder = 7
    OnBeforeDrawItem = ctlRegExFromBeforeDrawItem
    OnItemClick = ctlRegExFromItemClick
    object lblRegExDe: TLabel
      Left = 9
      Top = 3
      Width = 3
      Height = 15
    end
  end
  object ctlRegExTo: TControlList
    Left = 816
    Top = 102
    Width = 249
    Height = 332
    ItemHeight = 22
    ItemMargins.Left = 0
    ItemMargins.Top = 0
    ItemMargins.Right = 0
    ItemMargins.Bottom = 0
    ParentColor = False
    TabOrder = 8
    OnBeforeDrawItem = ctlRegExToBeforeDrawItem
    OnItemClick = ctlRegExToItemClick
    object lblRegExPara: TLabel
      Left = 9
      Top = 3
      Width = 3
      Height = 15
    end
  end
  object ckbRegExWholeWords: TCheckBox
    Left = 1071
    Top = 179
    Width = 97
    Height = 17
    Caption = 'Whole Words'
    Checked = True
    Enabled = False
    State = cbChecked
    TabOrder = 9
  end
  object ckbCaseSensitive: TCheckBox
    Left = 1071
    Top = 203
    Width = 113
    Height = 17
    Caption = 'Case Sensitive'
    TabOrder = 10
  end
  object clbCodeChanges: TCheckListBox
    Left = 565
    Top = 503
    Width = 500
    Height = 370
    BevelInner = bvLowered
    Ctl3D = True
    ItemHeight = 15
    ParentCtl3D = False
    Style = lbOwnerDrawFixed
    TabOrder = 11
    OnClick = clbCodeChangesClick
    OnKeyDown = clbCodeChangesKeyDown
    OnKeyUp = clbCodeChangesKeyUp
  end
  object lbCurrentCode: TListBox
    Left = 32
    Top = 503
    Width = 505
    Height = 370
    ItemHeight = 15
    TabOrder = 12
    OnClick = lbCurrentCodeClick
    OnKeyUp = lbCurrentCodeKeyUp
  end
  object cbbArquivosRefatorar: TComboBox
    Left = 70
    Top = 445
    Width = 987
    Height = 23
    Style = csDropDownList
    DropDownCount = 10
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
    OnChange = cbbArquivosRefatorarChange
  end
  object ckbSelectAllToUpdate: TCheckBox
    Left = 1071
    Top = 505
    Width = 97
    Height = 17
    Caption = 'Select &All'
    TabOrder = 14
    OnClick = ckbSelectAllToUpdateClick
  end
  object btnRegExHelp: TButton
    Left = 671
    Top = 21
    Width = 16
    Height = 16
    Caption = '?'
    TabOrder = 15
    OnClick = btnRegExHelpClick
  end
  object btnHelp: TButton
    Left = 1173
    Top = 8
    Width = 16
    Height = 16
    Caption = '?'
    TabOrder = 16
    OnClick = btnHelpClick
  end
  object ckbMakeBackup: TCheckBox
    Left = 1071
    Top = 530
    Width = 97
    Height = 17
    Caption = 'Make Backup'
    Checked = True
    State = cbChecked
    TabOrder = 17
    OnClick = ckbSelectAllToUpdateClick
  end
end
