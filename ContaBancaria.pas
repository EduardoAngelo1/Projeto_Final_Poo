unit ContaBancaria;

interface

type
  TContaBancaria = class
  private
    FNumeroConta: string;
    FTitular: string;
    FSaldo: Double;
  public
    constructor Create;
    
    property NumeroConta: string read FNumeroConta write FNumeroConta;
    property Titular: string read FTitular write FTitular;
    property Saldo: Double read FSaldo;
    
    procedure Depositar(valor: Double);
    function Sacar(valor: Double): Boolean;
    function ExibirSaldo: Double;
  end;

implementation

constructor TContaBancaria.Create;
begin
  inherited Create;
  FSaldo := 0.00;
end;

procedure TContaBancaria.Depositar(valor: Double);
begin
  if valor > 0 then
    FSaldo := FSaldo + valor;
end;

function TContaBancaria.Sacar(valor: Double): Boolean;
begin
  Result := False;
  if (valor > 0) and (valor <= FSaldo) then
  begin
    FSaldo := FSaldo - valor;
    Result := True;
  end;
end;

function TContaBancaria.ExibirSaldo: Double;
begin
  Result := FSaldo;
end;

end.