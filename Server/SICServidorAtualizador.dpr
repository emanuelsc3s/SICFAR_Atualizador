program SICServidorAtualizador;

uses
  Vcl.Forms,
  Unit_Server in 'Unit_Server.pas' {Form_PrincipalServer},
  Unit_dmProtheus in '..\Unit_dmProtheus.pas' {dmProtheus: TDataModule},
  Biblioteca in '..\Biblioteca.pas',
  Unit_dm1 in '..\Unit_dm1.pas' {dm1: TDataModule},
  Unit_ConfigFirebirdIBX in '..\Unit_ConfigFirebirdIBX.pas' {Form_ConfigFirebirdIBX};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm_PrincipalServer, Form_PrincipalServer);
  Application.CreateForm(Tdm1, dm1);
  Application.CreateForm(TForm_ConfigFirebirdIBX, Form_ConfigFirebirdIBX);
  Application.Run;
end.
