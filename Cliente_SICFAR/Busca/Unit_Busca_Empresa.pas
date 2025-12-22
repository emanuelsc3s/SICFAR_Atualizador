unit Unit_Busca_Empresa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzPanel, RzStatus, ExtCtrls, DB, StdCtrls, Mask, RzEdit,
  RzBtnEdt, Grids, DBGrids, RzDBGrid, RzButton, RzRadChk, IBX.IBCustomDataSet,
  IBX.IBQuery;

type
  TForm_Busca_Empresa = class(TForm)
    Label_Procura: TLabel;
    EditBtn_Pesq: TRzButtonEdit;
    DataSource_EMP: TDataSource;
    RzStatusBar1: TRzStatusBar;
    RzStatusPane1: TRzStatusPane;
    pnlHeader: TRzPanel;
    CheckBox_SubT: TRzCheckBox;
    DBGrid1: TDBGrid;
    QR_EMPRESA: TIBQuery;
    QR_EMPRESAEMPRESA_ID: TSmallintField;
    QR_EMPRESARAZAO_SOCIAL: TIBStringField;
    QR_EMPRESANOME_FANTASIA: TIBStringField;
    QR_EMPRESAENDERECO: TIBStringField;
    QR_EMPRESABAIRRO: TIBStringField;
    QR_EMPRESACIDADE: TIBStringField;
    QR_EMPRESACEP: TIBStringField;
    QR_EMPRESAUF: TIBStringField;
    QR_EMPRESACNPJ: TIBStringField;
    QR_EMPRESACGF: TIBStringField;
    QR_EMPRESAEMAIL: TIBStringField;
    QR_EMPRESASITE: TIBStringField;
    QR_EMPRESAFONE_01: TIBStringField;
    QR_EMPRESAFONE_02: TIBStringField;
    QR_EMPRESAFONE_03: TIBStringField;
    QR_EMPRESAFONE_04: TIBStringField;
    QR_EMPRESADATACADASTRO: TDateField;
    QR_EMPRESALOGOMARCA: TBlobField;
    QR_EMPRESAOBS: TWideMemoField;
    QR_EMPRESAFUNDACAO: TDateField;
    QR_EMPRESAUSUARIO_ID: TSmallintField;
    QR_EMPRESADELETADO: TIBStringField;
    QR_EMPRESAVERSAO: TIBStringField;
    QR_EMPRESANIRE: TIntegerField;
    QR_EMPRESASCRIPT: TIBStringField;
    QR_EMPRESAARQUIVO_LICENCA: TIBStringField;
    QR_EMPRESACOD_AGENCIA: TIBStringField;
    QR_EMPRESACONTA_CORRENTE: TIBStringField;
    QR_EMPRESACARTEIRA: TIBStringField;
    QR_EMPRESAVAR_CARTEIRA: TIBStringField;
    QR_EMPRESACOD_CEDENTE: TIBStringField;
    QR_EMPRESAINICIO_NOSSONUMERO: TIBStringField;
    QR_EMPRESAFIM_NOSSONUMERO: TIBStringField;
    QR_EMPRESAACEITE: TIBStringField;
    QR_EMPRESAESPECIE_BOLETO: TIBStringField;
    QR_EMPRESAINSTRUCAO_CAIXA: TIBStringField;
    QR_EMPRESATAXA_MULTADIA: TFMTBCDField;
    QR_EMPRESADV_CONTACORRENTE: TIBStringField;
    QR_EMPRESAINCC: TFMTBCDField;
    QR_EMPRESAMULTAMES: TIBBCDField;
    QR_EMPRESAJUROSMES: TIBBCDField;
    QR_EMPRESADATA_ALT: TDateTimeField;
    QR_EMPRESADATA_INC: TDateTimeField;
    QR_EMPRESANUMERO: TIntegerField;
    QR_EMPRESACOMPLEMENTO: TIBStringField;
    QR_EMPRESACONTADOR: TIBStringField;
    QR_EMPRESAENDERECO_CONTADOR: TIBStringField;
    QR_EMPRESACPF_CONTADOR: TIBStringField;
    QR_EMPRESACRC: TIBStringField;
    QR_EMPRESACNPJ_CONTADOR: TIBStringField;
    QR_EMPRESACEP_CONTADOR: TIBStringField;
    QR_EMPRESANUMERO_CONTADOR: TIntegerField;
    QR_EMPRESACOMPLEMENTO_CONTADOR: TIBStringField;
    QR_EMPRESABAIRRO_CONTADOR: TIBStringField;
    QR_EMPRESAFONE_CONTADOR: TIBStringField;
    QR_EMPRESAFAX_CONTADOR: TIBStringField;
    QR_EMPRESAEMAIL_CONTADOR: TIBStringField;
    QR_EMPRESACONTADOR_CIDADE_ID: TIntegerField;
    QR_EMPRESACIDADE_CONTADOR: TIBStringField;
    QR_EMPRESACIDADE_IBGE_CONTADOR: TIntegerField;
    QR_EMPRESAUF_CONTADOR: TIBStringField;
    QR_EMPRESACPF_RFB: TIBStringField;
    QR_EMPRESAENDERECO_RFB: TIBStringField;
    QR_EMPRESABAIRRO_RFB: TIBStringField;
    QR_EMPRESACIDADE_RFB_ID: TIntegerField;
    QR_EMPRESACIDADE_ID: TIntegerField;
    QR_EMPRESACNAE: TIBStringField;
    QR_EMPRESACRT: TIBStringField;
    QR_EMPRESAOBS_NOTA: TIBStringField;
    QR_EMPRESADANFE_PATH: TIBStringField;
    QR_EMPRESAAMBIENTE_NFE: TIntegerField;
    QR_EMPRESALOTE_NFE: TIntegerField;
    QR_EMPRESASERIE_NFE: TIBStringField;
    QR_EMPRESALOTE_NFE_SCAN: TIntegerField;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure EditBtn_PesqButtonClick(Sender: TObject);
    procedure EditBtn_PesqChange(Sender: TObject);
    procedure EditBtn_PesqKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditBtn_PesqKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    Campo : String;    
  public
    { Public declarations }
  end;

var
  Form_Busca_Empresa: TForm_Busca_Empresa;

implementation

{$R *.dfm}

uses Biblioteca, Unit_dm1;

procedure TForm_Busca_Empresa.DBGrid1DblClick(Sender: TObject);
begin
  Close;
  ModalResult := mrOk;
end;

procedure TForm_Busca_Empresa.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then
    DBGrid1DblClick(Sender);
end;

procedure TForm_Busca_Empresa.DBGrid1TitleClick(Column: TColumn);
Var
  i : Integer;
begin
  for i := 1 to DBGrid1.Columns.Count -1 do
    DBGrid1.Columns[i].Title.Font.Color := clNavy;
  Application.ProcessMessages; // Considera o que acontecer no dbgrid durante a entrada nesta procedure

  QR_EMPRESA.SQL.Clear; // LIMPA A QUERY
  QR_EMPRESA.SQL.Text := 'SELECT * FROM TBEMPRESAS WHERE DELETADO=''N'' Order by ' + Column.FieldName;
  QR_EMPRESA.Open;

  Campo := Column.FieldName;
  Label_Procura.Caption := 'Pesquisando por: ' + Column.Title.Caption;
  DBGrid1.Columns[1].Title.Font.Color := clNavy;
  Column.Title.Font.color := clTeal;
  EditBtn_Pesq.SetFocus;
end;

procedure TForm_Busca_Empresa.EditBtn_PesqButtonClick(Sender: TObject);
begin
  QR_EMPRESA.Close;

  if (CheckBox_SubT.Checked = False) Then
    QR_EMPRESA.SQL.Text := 'SELECT * FROM TBEMPRESAS WHERE DELETADO = ''N'' AND '+Campo+ ' LIKE '''+EditBtn_Pesq.Text+'%'' ORDER BY ' + Campo
  else
    begin
      if (CheckBox_SubT.Checked) Then  // Sub-Texto
        QR_EMPRESA.SQL.Text := 'SELECT * FROM TBEMPRESAS WHERE DELETADO = ''N'' AND '+Campo+ ' LIKE ''%'+EditBtn_Pesq.Text+'%'' ORDER BY ' + Campo;
    end;
  QR_EMPRESA.Open;

  if QR_EMPRESA.RecordCount > 0 Then
    RzStatusPane1.Caption := 'A Pesquisa foi Concluída. Encontrado(s) (' + IntToStr(QR_EMPRESA.RecordCount) + ') resultado(s).'
  else
    RzStatusPane1.Caption := 'A pesquisa foi Concluída. Não há resultados a serem exibidos.';
end;

procedure TForm_Busca_Empresa.EditBtn_PesqChange(Sender: TObject);
begin
  if EditBtn_Pesq.Text <> '' then
    RzStatusPane1.Caption := 'Aguardando pesquisa...';

  EditBtn_Pesq.OnButtonClick(Sender);
end;

procedure TForm_Busca_Empresa.EditBtn_PesqKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DOWN then // Setas
    QR_EMPRESA.Next;

  if Key = VK_UP then
    QR_EMPRESA.Prior;
end;

procedure TForm_Busca_Empresa.FormCreate(Sender: TObject);
begin
  Campo := 'RAZAO_SOCIAL';

  QR_EMPRESA.Close;
  QR_EMPRESA.SQL.Text := 'SELECT * FROM TBEMPRESAS WHERE DELETADO = ''N'' ';
  QR_EMPRESA.Open;
end;

procedure TForm_Busca_Empresa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_NEXT then // PageDown
    EditBtn_Pesq.OnButtonClick(Sender);

  if key = VK_F2 then
    begin
      EditBtn_Pesq.SetFocus;
      EditBtn_Pesq.Clear;
    end;
end;

procedure TForm_Busca_Empresa.EditBtn_PesqKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key =#13 then
    DBGrid1.OnDblClick(Sender);
end;

end.
