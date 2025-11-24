program SistemaContaBancaria;

uses
  Vcl.Forms,
  TelaPrincipal in 'TelaPrincipal.pas' {frmPrincipal},
  ContaBancaria in 'ContaBancaria.pas',
  TelaModal in 'TelaModal.pas' {frmModal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.