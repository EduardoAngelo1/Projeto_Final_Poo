object frmModal: TfrmModal
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Opera'#231#227'o Banc'#225'ria'
  ClientHeight = 250
  ClientWidth = 350
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 13
  object lblNumeroConta: TLabel
    Left = 24
    Top = 24
    Width = 88
    Height = 13
    Caption = 'N'#250'mero da Conta:'
  end
  object lblTitular: TLabel
    Left = 24
    Top = 67
    Width = 79
    Height = 13
    Caption = 'Nome do Titular:'
  end
  object lblSaldo: TLabel
    Left = 24
    Top = 110
    Width = 58
    Height = 13
    Caption = 'Saldo Atual:'
  end
  object lblValor: TLabel
    Left = 24
    Top = 153
    Width = 28
    Height = 13
    Caption = 'Valor:'
  end
  object edtNumeroConta: TEdit
    Left = 24
    Top = 40
    Width = 200
    Height = 21
    TabOrder = 0
  end
  object edtTitular: TEdit
    Left = 24
    Top = 83
    Width = 300
    Height = 21
    TabOrder = 1
  end
  object edtSaldo: TEdit
    Left = 24
    Top = 126
    Width = 150
    Height = 21
    TabOrder = 2
  end
  object edtValor: TEdit
    Left = 24
    Top = 169
    Width = 150
    Height = 21
    TabOrder = 3
  end
  object btnConfirmar: TButton
    Left = 169
    Top = 210
    Width = 75
    Height = 25
    Caption = 'Confirmar'
    Default = True
    TabOrder = 4
    OnClick = btnConfirmarClick
  end
  object btnCancelar: TButton
    Left = 250
    Top = 210
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancelar'
    TabOrder = 5
    OnClick = btnCancelarClick
  end
end
