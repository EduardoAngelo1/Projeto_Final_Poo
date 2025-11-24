unit TelaModal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Datasnap.DBClient;

type
  TTipoOperacao = (toCriarConta, toDepositar, toSacar);

  TfrmModal = class(TForm)
    edtNumeroConta: TEdit;
    edtTitular: TEdit;
    edtSaldo: TEdit;
    edtValor: TEdit;
    lblNumeroConta: TLabel;
    lblTitular: TLabel;
    lblSaldo: TLabel;
    lblValor: TLabel;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    FTipoOperacao: TTipoOperacao;
    FDataSet: TClientDataSet;
  public
    class function CriarConta(AOwner: TComponent; ADataSet: TClientDataSet): Boolean;
    class function Depositar(AOwner: TComponent; ADataSet: TClientDataSet): Boolean;
    class function Sacar(AOwner: TComponent; ADataSet: TClientDataSet): Boolean;
  end;

implementation

{$R *.dfm}

uses ContaBancaria;

class function TfrmModal.CriarConta(AOwner: TComponent; ADataSet: TClientDataSet): Boolean;
var
  Modal: TfrmModal;
begin
  Modal := TfrmModal.Create(AOwner);
  try
    Modal.FTipoOperacao := toCriarConta;
    Modal.FDataSet := ADataSet;
    Modal.Caption := 'Criar Conta';
    Modal.edtSaldo.Enabled := False;
    Modal.edtSaldo.Text := 'R$ 0,00';
    Modal.edtValor.Visible := False;
    Modal.lblValor.Visible := False;
    Result := Modal.ShowModal = mrOk;
  finally
    Modal.Free;
  end;
end;

class function TfrmModal.Depositar(AOwner: TComponent; ADataSet: TClientDataSet): Boolean;
var
  Modal: TfrmModal;
begin
  Modal := TfrmModal.Create(AOwner);
  try
    Modal.FTipoOperacao := toDepositar;
    Modal.FDataSet := ADataSet;
    Modal.Caption := 'Depositar';
    Modal.edtNumeroConta.Text := ADataSet.FieldByName('NumeroConta').AsString;
    Modal.edtTitular.Text := ADataSet.FieldByName('Titular').AsString;
    Modal.edtSaldo.Text := 'R$ ' + FormatFloat('#,##0.00', ADataSet.FieldByName('Saldo').AsFloat);
    Modal.edtNumeroConta.Enabled := False;
    Modal.edtTitular.Enabled := False;
    Modal.edtSaldo.Enabled := False;
    Result := Modal.ShowModal = mrOk;
  finally
    Modal.Free;
  end;
end;

class function TfrmModal.Sacar(AOwner: TComponent; ADataSet: TClientDataSet): Boolean;
var
  Modal: TfrmModal;
begin
  Modal := TfrmModal.Create(AOwner);
  try
    Modal.FTipoOperacao := toSacar;
    Modal.FDataSet := ADataSet;
    Modal.Caption := 'Sacar';
    Modal.edtNumeroConta.Text := ADataSet.FieldByName('NumeroConta').AsString;
    Modal.edtTitular.Text := ADataSet.FieldByName('Titular').AsString;
    Modal.edtSaldo.Text := 'R$ ' + FormatFloat('#,##0.00', ADataSet.FieldByName('Saldo').AsFloat);
    Modal.edtNumeroConta.Enabled := False;
    Modal.edtTitular.Enabled := False;
    Modal.edtSaldo.Enabled := False;
    Result := Modal.ShowModal = mrOk;
  finally
    Modal.Free;
  end;
end;

procedure TfrmModal.btnConfirmarClick(Sender: TObject);
var
  Valor: Double;
  Conta: TContaBancaria;
begin
  case FTipoOperacao of
    toCriarConta:
    begin
      if Trim(edtNumeroConta.Text) = '' then
      begin
        ShowMessage('Erro: Informe o número da conta!');
        Exit;
      end;
      
      if Trim(edtTitular.Text) = '' then
      begin
        ShowMessage('Erro: Informe o nome do titular!');
        Exit;
      end;
      
      if FDataSet.Locate('NumeroConta', edtNumeroConta.Text, []) then
      begin
        ShowMessage('Erro: Conta já existe!');
        Exit;
      end;
      
      FDataSet.Append;
      FDataSet.FieldByName('NumeroConta').AsString := edtNumeroConta.Text;
      FDataSet.FieldByName('Titular').AsString := edtTitular.Text;
      FDataSet.FieldByName('Saldo').AsFloat := 0.00;
      FDataSet.Post;
    end;
    
    toDepositar, toSacar:
    begin
      try
        Valor := StrToFloat(StringReplace(edtValor.Text, ',', '.', [rfReplaceAll]));
      except
        ShowMessage('Erro: Valor invalido!');
        Exit;
      end;
      
      if Valor <= 0 then
      begin
        ShowMessage('Erro: Valor deve ser maior que zero!');
        Exit;
      end;
      
      Conta := TContaBancaria.Create;
      try
        Conta.NumeroConta := FDataSet.FieldByName('NumeroConta').AsString;
        Conta.Titular := FDataSet.FieldByName('Titular').AsString;
        Conta.Depositar(FDataSet.FieldByName('Saldo').AsFloat);
        
        if FTipoOperacao = toDepositar then
        begin
          Conta.Depositar(Valor);
          FDataSet.Edit;
          FDataSet.FieldByName('Saldo').AsFloat := Conta.Saldo;
          FDataSet.Post;
        end
        else if FTipoOperacao = toSacar then
        begin
          if not Conta.Sacar(Valor) then
          begin
            ShowMessage('Erro: Saldo insuficiente!');
            Exit;
          end;
          FDataSet.Edit;
          FDataSet.FieldByName('Saldo').AsFloat := Conta.Saldo;
          FDataSet.Post;
        end;
      finally
        Conta.Free;
      end;
    end;
  end;
  
  ModalResult := mrOk;
end;

procedure TfrmModal.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.