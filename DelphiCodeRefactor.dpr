program DelphiCodeRefactor;

uses
  Vcl.Forms,
  uFrmDelphiCodeRefactor in 'uFrmDelphiCodeRefactor.pas' {uFrmPrincipal},
  CSVParser in 'CSVParser.pas',
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10');
  Application.CreateForm(TuFrmPrincipal, uFrmPrincipal);
  Application.Run;
end.