object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Sistema de Conta Banc'#225'ria'
  ClientHeight = 500
  ClientWidth = 700
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBotoes: TPanel
    Left = 0
    Top = 0
    Width = 700
    Height = 60
    Align = alTop
    TabOrder = 0
    object btnCriarConta: TButton
      Left = 24
      Top = 20
      Width = 100
      Height = 25
      Caption = 'Criar Conta'
      TabOrder = 0
      OnClick = btnCriarContaClick
    end
    object btnDepositar: TButton
      Left = 130
      Top = 20
      Width = 100
      Height = 25
      Caption = 'Depositar'
      Enabled = False
      TabOrder = 1
      OnClick = btnDepositarClick
    end
    object btnSacar: TButton
      Left = 236
      Top = 20
      Width = 100
      Height = 25
      Caption = 'Sacar'
      Enabled = False
      TabOrder = 2
      OnClick = btnSacarClick
    end
    object btnExibirSaldo: TButton
      Left = 342
      Top = 20
      Width = 100
      Height = 25
      Caption = 'Exibir Saldo'
      Enabled = False
      TabOrder = 3
      OnClick = btnExibirSaldoClick
    end
  end
  object pnlGrid: TPanel
    Left = 0
    Top = 60
    Width = 700
    Height = 290
    Align = alClient
    TabOrder = 1
    object grdContas: TDBGrid
      Left = 1
      Top = 1
      Width = 698
      Height = 288
      Align = alClient
      DataSource = dtsContas
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'NumeroConta'
          Title.Caption = 'N'#250'mero da Conta'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Titular'
          Title.Caption = 'Titular'
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Saldo'
          Title.Caption = 'Saldo (R$)'
          Width = 100
          Visible = True
        end>
    end
  end
  object memoMensagens: TMemo
    Left = 0
    Top = 350
    Width = 700
    Height = 150
    Align = alBottom
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object dtsContas: TDataSource
    DataSet = cdsContas
    OnDataChange = dtsContasDataChange
    Left = 600
    Top = 200
  end
  object cdsContas: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 650
    Top = 200
  end
end