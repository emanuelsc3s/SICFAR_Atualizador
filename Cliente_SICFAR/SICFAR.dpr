program SICFAR;

uses
  Vcl.Forms,
  Unit_Atualizador in 'Unit_Atualizador.pas' {Form_Atualizador},
  Biblioteca in 'C:\C3S\SICFAR\Biblioteca.pas',
  Unit_DM1 in 'C:\C3S\SICFAR\Unit_DM1.pas' {dm1: TDataModule},
  Unit_Principal in 'Unit_Principal.pas' {Form_Principal},
  Unit_Busca_Empresa in 'Busca\Unit_Busca_Empresa.pas' {Form_Busca_Empresa},
  Unit_dmProtheus in 'C:\C3S\SICFAR\Unit_dmProtheus.pas' {dmProtheus: TDataModule},
  Unit_UsuarioAlterarSenha in 'Unit_UsuarioAlterarSenha.pas' {Form_UsuarioAlterarSenha},
  Unit_Login in 'Unit_Login.pas' {Form_Login},
  Unit_dmEstabilidade in 'C:\C3S\SICFAR\Unit_dmEstabilidade.pas' {dmEstabilidade: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm1, dm1);
  Application.CreateForm(TForm_Login, Form_Login);
  Application.CreateForm(TForm_Principal, Form_Principal);
  Application.CreateForm(TForm_Atualizador, Form_Atualizador);
  Application.CreateForm(TForm_Principal, Form_Principal);
  Application.CreateForm(TForm_Busca_Empresa, Form_Busca_Empresa);
  Application.CreateForm(TdmProtheus, dmProtheus);
  Application.CreateForm(TForm_UsuarioAlterarSenha, Form_UsuarioAlterarSenha);
  Application.CreateForm(TForm_Login, Form_Login);
  Application.CreateForm(TdmEstabilidade, dmEstabilidade);
  Application.Run;
end.
