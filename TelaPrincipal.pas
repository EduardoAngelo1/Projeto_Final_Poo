unit TelaPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids,
  Data.DB, Datasnap.DBClient, ContaBancaria, TelaModal;

type
  TfrmPrincipal = class(TForm)
    btnCriarConta: TButton;
    btnDepositar: TButton;
    btnSacar: TButton;
    btnExibirSaldo: TButton;
    memoMensagens: TMemo;
    grdContas: TDBGrid;
    dtsContas: TDataSource;
    cdsContas: TClientDataSet;
    pnlBotoes: TPanel;
    pnlGrid: TPanel;
    procedure btnCriarContaClick(Sender: TObject);
    procedure btnDepositarClick(Sender: TObject);
    procedure btnSacarClick(Sender: TObject);
    procedure btnExibirSaldoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dtsContasDataChange(Sender: TObject; Field: TField);
  private
    procedure ExibirMensagem(const Mensagem: string);
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  cdsContas.FieldDefs.Add('NumeroConta', ftString, 20);
  cdsContas.FieldDefs.Add('Titular', ftString, 50);
  cdsContas.FieldDefs.Add('Saldo', ftFloat);
  cdsContas.CreateDataSet;
end;

procedure TfrmPrincipal.btnCriarContaClick(Sender: TObject);
begin
  if TfrmModal.CriarConta(Self, cdsContas) then
    ExibirMensagem('Conta criada com sucesso!');
end;

procedure TfrmPrincipal.btnDepositarClick(Sender: TObject);
begin
  if cdsContas.IsEmpty then
  begin
    ExibirMensagem('Erro: Selecione uma conta!');
    Exit;
  end;
  
  if TfrmModal.Depositar(Self, cdsContas) then
    ExibirMensagem('Depósito realizado com sucesso!');
end;

procedure TfrmPrincipal.btnSacarClick(Sender: TObject);
begin
  if cdsContas.IsEmpty then
  begin
    ExibirMensagem('Erro: Selecione uma conta!');
    Exit;
  end;
  
  if TfrmModal.Sacar(Self, cdsContas) then
    ExibirMensagem('Saque realizado com sucesso!');
end;

procedure TfrmPrincipal.btnExibirSaldoClick(Sender: TObject);
begin
  if cdsContas.IsEmpty then
  begin
    ExibirMensagem('Erro: Selecione uma conta!');
    Exit;
  end;
  
  ExibirMensagem('Saldo atual: R$ ' + FormatFloat('#,##0.00', cdsContas.FieldByName('Saldo').AsFloat));
end;

procedure TfrmPrincipal.dtsContasDataChange(Sender: TObject; Field: TField);
begin
  btnDepositar.Enabled := not cdsContas.IsEmpty;
  btnSacar.Enabled := not cdsContas.IsEmpty;
  btnExibirSaldo.Enabled := not cdsContas.IsEmpty;
end;

procedure TfrmPrincipal.ExibirMensagem(const Mensagem: string);
begin
  memoMensagens.Lines.Add(TimeToStr(Now) + ' - ' + Mensagem);
end;



end.