program Cliente;

uses
  Vcl.Forms,
  Unit_Client in 'Unit_Client.pas' {Form_Atualizador},
  Unit_DM1 in 'C:\C3S\SICFAR\Unit_DM1.pas' {dm1: TDataModule},
  Unit_dmEstabilidade in 'C:\C3S\SICFAR\Unit_dmEstabilidade.pas' {dmEstabilidade: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm1, dm1);
  Application.CreateForm(TForm_Atualizador, Form_Atualizador);
  Application.CreateForm(TdmEstabilidade, dmEstabilidade);
  Application.Run;
end.
