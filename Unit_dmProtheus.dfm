object dmProtheus: TdmProtheus
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 201
  Width = 268
  object ADOConnection1: TADOConnection
    CommandTimeout = 200
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=far1989!@#123;Persist Security Info' +
      '=True;User ID=sa;Initial Catalog=TOTVS_PRODUCAO;Data Source=192.' +
      '168.0.222;Use Procedure for Prepare=1;Auto Translate=True;Packet' +
      ' Size=4096;Workstation ID=SEATTLE-VIRTUAL;Use Encryption for Dat' +
      'a=False;Tag with column collation when possible=False'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    BeforeConnect = ADOConnection1BeforeConnect
    Left = 49
    Top = 16
  end
  object frxADOComponents: TfrxADOComponents
    DefaultDatabase = ADOConnection1
    Left = 50
    Top = 71
  end
end
