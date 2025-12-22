unit Unit_dmProtheus;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB, frxClass,
  frxADOComponents;

type
  TdmProtheus = class(TDataModule)
    ADOConnection1: TADOConnection;
    frxADOComponents: TfrxADOComponents;
    procedure ADOConnection1BeforeConnect(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    function LerConexaoIni: String;
  public
    { Public declarations }
    function  fSQLJoinFaturamento : String;
    function  fSQLJoinPedidoVenda : String;
    function  fRetornaQtdPedidoTotvs(prRetorno,prLicitacao,prPedido,prProduto: string; prPreco: Double): Currency;
    function  fClientesBloqueados : string;
    function  fClientesInadimplentes(prDI, prDF: integer): string;
    function  fClientesDocumentacaoVencida(prDias: integer): string;
    function  fComissaoNF(prNF, prSerie : string): Currency;
    function  fComissaoPedido(prPedido: string): Currency;
    function  fComissaoRegraProdutoNF(prADOQuery: TADOQuery; prVendedor, prUF, prNF, prSerie, prGrupoProduto : string): Currency;
    function  fRetornaComissaoNF(prNF, prSerieNF: string; prValorNF: Currency; var vAliqComissao: Currency): Currency;
    function  fRetornaPrecoMedioLiquido(prQueryTOTVS: TADOQuery; prProduto: string; prDI, prDF: TDateTime): Double;
    function  fRetornaUltimoPrecoMedio(prQueryTOTVS: TADOQuery; prProduto: string): TDatetime;
    function  fRetornaEstoqueAtual(prProduto, prArmazem: string): Double;
    procedure pImportaClienteTOTVS(A1Cod, A1Vend, prTipo: string);
    function  fRetornaCampoTabela(prCampo, prTabela, prCampoWhere, prValorWhere: String): String;
  end;

var
  dmProtheus: TdmProtheus;
  vParametrosLinha, vParametros : string;
  vAplicacaoPrincipal : Boolean;
  vTipoClienteTOTVSid : string;

  // IDs das Tabelas Protheus
  vVend1, vTitulo, vTituloPrefixo, vTituloParcela : string;

  // R_E_C_N_O_ Protheus
  vRecnoSE3, vRecnoSE1, vRecnoSE5, vRecnoSF2 : string;

  // IDs do SIC
  vComissaoID : string;

  // Datas para Dashboard
  vDashBoardDI, vDashBoardDF : string;

  // Usado nos Avisos
  vClientesBloqueados, vClientesInativos90Dias : Boolean;
  vInadimplenciaInicio, vInadimplenciaFim, vClientesDiasDocumentacaoVencida : integer;

  vDI, vDF, vJaneiroDI, vJaneiroDF, vFevereiroDI, vFevereiroDF, vMarcoDI, vMarcoDF,
  vAbrilDI, vAbrilDF, vMaioDI, vMaioDF, vJunhoDI, vJunhoDF, vJulhoDI, vJulhoDF,
  vAgostoDI, vAgostoDF, vSetembroDI, vSetembroDF, vOutubroDI, vOutubroDF, vNovembroDI,
  vNovembroDF, vDezembroDI, vDezembroDF: String;

implementation

uses
  IBX.IBQuery, Unit_dm1, System.IniFiles, Vcl.Forms, Vcl.Dialogs, ACBrUtil, System.Math;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmProtheus }


procedure TdmProtheus.ADOConnection1BeforeConnect(Sender: TObject);
begin
//  ADOConnection1.Close;
//  ADOConnection1.ConnectionString := 'Provider=SQLOLEDB.1;Password=far1989!@#123;Persist Security Info=True;User ID=sa;Initial Catalog=TOTVS_PRODUCAO;Data Source=192.168.0.222;Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Workstation ID=SEATTLE-VIRTUAL;Use Encryption for Data=False;Tag with column collation when possible=False'
//
//  if not FileExists(ExtractFilePath(Application.ExeName)+'SQLSERVER.udl') then
//    begin
//      ShowMessage('Arquivo SQLSERVER.udl inexistente.');
//      Application.Terminate;
//    end
//  else
//    begin
//      ADOConnection1.ConnectionString := 'File Name=' + ExtractFilePath( Application.ExeName ) + 'SQLSERVER.udl';
////      ADOConnection1.Connected        := True;
//    end;
//
//  // Avisa quando os relatorios forem usados diretos na totvs pra fechar
//  vAplicacaoPrincipal := true;
end;

procedure TdmProtheus.DataModuleCreate(Sender: TObject);
begin
  ADOConnection1.Close;
  ADOConnection1.Connected        := True;
end;

function TdmProtheus.fClientesBloqueados: string;
var
  vlQueryTOTVS : TADOQuery;
begin
  vlQueryTOTVS                := TADOQuery.Create(Owner);
  with vlQueryTOTVS do
    begin
      Connection     := ADOConnection1;
      CommandTimeout := 200;

      Close;
      SQL.Text := 'SELECT COUNT(*) AS COUNT FROM SA1010 (NOLOCK) SA1';
      SQL.Add(' WHERE D_E_L_E_T_ <> ''*'' ');
      SQL.Add(' AND ((SA1.A1_YENTREG = '''') OR (SA1.A1_YENTREG = ''N''))');
      SQL.Add(' AND SA1.A1_MSBLQL = ''1'' ');

      Open;
    end;
  Result := vlQueryTOTVS.FieldByName('COUNT').AsString;

  FreeAndNil(vlQueryTOTVS);
end;

function TdmProtheus.fClientesDocumentacaoVencida(prDias: integer): string;
var
  vlQueryTOTVS : TADOQuery;
  vFiltro: TStringList;
  vlQtde : integer;
begin
  vlQueryTOTVS := TADOQuery.Create(Owner);
  with vlQueryTOTVS do
    begin
      Connection     := ADOConnection1;
      CommandTimeout := 200;

      vFiltro := TStringList.Create;
      vFiltro.Text := 'SELECT';
      vFiltro.Add(' SA1.A1_COD, SA1.A1_NOME, SA1.A1_MUN, SA1.A1_EST, SA1.A1_END,');
      vFiltro.Add(' SA1.A1_BAIRRO, SA1.A1_COMPLEM, SA1.A1_CEP, SA1.A1_CGC,');
      vFiltro.Add(' RTRIM(SA1.A1_DDD)+''-''+SA1.A1_TEL AS TELEFONE, SA1.A1_COMIS,');
      vFiltro.Add(' SA1.A1_VEND+''-''+SA3.A3_NOME AS VENDEDOR, SA1.A1_EMAIL,');
      vFiltro.Add(' CASE WHEN SA1.A1_ULTCOM <> '''' THEN CONVERT(VARCHAR,CAST(SA1.A1_ULTCOM AS DATETIME),103) END AS A1_ULTCOM,');
      vFiltro.Add(' SA1.A1_NROCOM,');
      vFiltro.Add(' CASE SA1.A1_PESSOA');
      vFiltro.Add(' WHEN ''F'' THEN ''Fisica'' ');
      vFiltro.Add(' WHEN ''J'' THEN ''Juridica'' ');
      vFiltro.Add(' END AS PESSOA,');
      vFiltro.Add(' CASE SA1.A1_TIPO');
      vFiltro.Add(' WHEN ''L'' THEN ''Produtor Rural'' ');
      vFiltro.Add(' WHEN ''F'' THEN ''Consumidor Final'' ');
      vFiltro.Add(' WHEN ''R'' THEN ''Revendedor'' ');
      vFiltro.Add(' WHEN ''S'' THEN ''ICMS Solidario'' ');
      vFiltro.Add(' WHEN ''X'' THEN ''Exportacao'' ');
      vFiltro.Add(' END AS TIPO,');
      vFiltro.Add(' CASE SA1.A1_GRPTRIB');
      vFiltro.Add(' WHEN ''001'' THEN ''DistribuidorRevendedor'' ');
      vFiltro.Add(' WHEN ''002'' THEN ''DistribuidorSolidario'' ');
      vFiltro.Add(' WHEN ''003'' THEN ''ConsumidorFinal'' ');
      vFiltro.Add(' WHEN ''004'' THEN ''DistribSolidRN'' ');
      vFiltro.Add(' WHEN ''005'' THEN ''DistribSuframa'' ');
      vFiltro.Add(' WHEN ''006'' THEN ''ConsFinalContrib'' ');
      vFiltro.Add(' END AS A1_GRPTRIB,');
      vFiltro.Add(' CASE SA1.A1_YTPCLI');
      vFiltro.Add(' WHEN ''1'' THEN ''Publico'' ');
      vFiltro.Add(' WHEN ''2'' THEN ''Privado'' ');
      vFiltro.Add(' WHEN ''3'' THEN ''Distribuidor'' ');
      vFiltro.Add(' WHEN ''4'' THEN ''Farmacias e Drogarias Privadas'' ');
      vFiltro.Add(' WHEN ''5'' THEN ''Demais Clientes'' ');
      vFiltro.Add(' END AS A1_YTPCLI');

      vFiltro.Add(' FROM SA1010 (NOLOCK) SA1');
      vFiltro.Add(' LEFT JOIN SA3010 (NOLOCK) SA3 ON SA3.A3_COD = SA1.A1_VEND AND SA3.D_E_L_E_T_ <> ''*'' ');
      vFiltro.Add(' WHERE SA1.D_E_L_E_T_ <> ''*'' ');
      vFiltro.Add(' AND ((SA1.A1_YENTREG = '''') OR (SA1.A1_YENTREG = ''N''))');
      vFiltro.Add(' AND SA1.A1_MSBLQL = ''2'' '); // Nao

      with vlQueryTOTVS do
      begin
        Close;
        SQL.Text := vFiltro.Text;

        SQL.Add(' AND SA1.A1_YALVARA < ''' + FormatDateTime('YYYYMMDD', Date-1-prDias) + ''' AND SA1.A1_YALVARA <> '''' ');

        SQL.Add(' UNION');

        SQL.Add(vFiltro.Text);

        SQL.Add(' AND SA1.A1_YALEST  < ''' + FormatDateTime('YYYYMMDD', Date-1-prDias) + ''' AND SA1.A1_YALEST  <> '''' ');

        SQL.Add(' UNION');

        SQL.Add(vFiltro.Text);

        SQL.Add(' AND SA1.A1_YALMUNI  < ''' + FormatDateTime('YYYYMMDD', Date-1-prDias) + ''' AND SA1.A1_YALMUNI  <> '''' ');

        SQL.Add(' UNION');

        SQL.Add(vFiltro.Text);

        SQL.Add(' AND SA1.A1_YCERFAR  < ''' + FormatDateTime('YYYYMMDD', Date-1-prDias) + ''' AND SA1.A1_YCERFAR  <> '''' ');

        SQL.Add(' UNION');

        SQL.Add(vFiltro.Text);

        SQL.Add(' AND SA1.A1_YCALVVS  < ''' + FormatDateTime('YYYYMMDD', Date-1-prDias) + ''' AND SA1.A1_YCALVVS  <> '''' ');

        SQL.Add(' UNION');

        SQL.Add(vFiltro.Text);

        SQL.Add(' AND SA1.A1_YCONTRS  < ''' + FormatDateTime('YYYYMMDD', Date-1-prDias) + ''' AND SA1.A1_YCONTRS  <> '''' ');

        SQL.Add(' UNION');

        SQL.Add(vFiltro.Text);

        SQL.Add(' AND SA1.A1_YULTADT  < ''' + FormatDateTime('YYYYMMDD', Date-1-prDias) + ''' AND SA1.A1_YULTADT  <> '''' ');

        SQL.Add(' UNION');

        SQL.Add(vFiltro.Text);

        SQL.Add(' AND SA1.A1_YFICHCA  < ''' + FormatDateTime('YYYYMMDD', Date-1-prDias) + ''' AND SA1.A1_YFICHCA  <> '''' ');

        SQL.Add(' UNION');

        SQL.Add(vFiltro.Text);

        SQL.Add(' AND SA1.A1_YSERASA  < ''' + FormatDateTime('YYYYMMDD', Date-1-prDias) + ''' AND SA1.A1_YSERASA  <> '''' ');

        // InputBox('SQL', 'Text', SQL.Text);

        Open;
      end;
    end;

  Result := FormatFloat('###,###,###,###', vlQueryTOTVS.RecordCount);

  FreeAndNil(vlQueryTOTVS);
end;

function TdmProtheus.fClientesInadimplentes(prDI, prDF : integer): string;
var
  vlQueryTOTVS : TADOQuery;
begin
  vlQueryTOTVS := TADOQuery.Create(Owner);
  with vlQueryTOTVS do
    begin
      Connection     := ADOConnection1;
      CommandTimeout := 200;

      Close;
      SQL.Text := 'SELECT';
      SQL.Add(' COUNT(DISTINCT SE1.E1_CLIENTE) AS COUNT');
      SQL.Add(' FROM SE1010 (NOLOCK) SE1');
      SQL.Add(' LEFT JOIN SA1010 (NOLOCK) SA1 ON SE1.E1_CLIENTE = SA1.A1_COD AND SE1.E1_LOJA = SA1.A1_LOJA AND SA1.D_E_L_E_T_ = '''' ');

      SQL.Add(' WHERE SE1.D_E_L_E_T_ = '''' ');

      SQL.Add(' AND SE1.E1_TIPO NOT IN (''NCC'',''RA'')');

      SQL.Add(' AND SE1.E1_SUSPENS <> ''S'' ');

      SQL.Add(' AND SE1.E1_SALDO > 0');

      SQL.Add(' AND DATEDIFF(DAY, CONVERT(DATETIME, SE1.E1_VENCREA, 112), GETDATE()) BETWEEN ''' + IntToStr(prDI) + ''' AND ''' + IntToStr(prDF) + ''' ');

//      InputBox('SQL', 'Text', SQL.Text);

      Open;
    end;

  Result := FormatFloat('###,###,###,###', vlQueryTOTVS.FieldByName('COUNT').AsInteger);

  FreeAndNil(vlQueryTOTVS);
end;

function TdmProtheus.fComissaoNF(prNF, prSerie: string): Currency;
var
  sCom, sValor, vComissao : Currency;
  qItemNF: TADOQuery;
begin
  sCom          := 0;
  sValor        := 0;

  qItemNF := TADOQuery.Create(Owner);
  with qItemNF do
    begin
      Connection     := dmProtheus.ADOConnection1;
      CommandTimeout := 200;

      // Carrega NF para calculo ponderado da comissao
      Close;
      SQL.Text := 'SELECT';
      SQL.Add(' SD2.D2_PEDIDO, SD2.D2_DOC, SD2.D2_SERIE, SD2.D2_CLIENTE,');
      SQL.Add(' SD2.D2_COMIS1, SD2.D2_VALBRUT, SD2.D2_COD, SD2.D2_TP, SD2.D2_GRUPO');
      SQL.Add(' FROM SD2010 (NOLOCK) SD2');
      SQL.Add(' WHERE SD2.D_E_L_E_T_ <> ''*'' ');

      SQL.Add(' AND SD2.D2_COMIS1 > 0');

      SQL.Add(' AND SD2.D2_DOC   = ''' + Trim(prNF) + ''' ');

      SQL.Add(' AND SD2.D2_SERIE = ''' + Trim(prSerie) + ''' ');

      SQL.Add(' ORDER BY SD2.D2_ITEM');
      Open;

      if not IsEmpty then
        begin
          First;
          while not Eof do
            begin
               vComissao        := qItemNF.FieldByName('D2_COMIS1').AsCurrency;

               sCom   := (sCom   + (qItemNF.FieldByName('D2_VALBRUT').AsCurrency * vComissao));
               sValor := (sValor +  qItemNF.FieldByName('D2_VALBRUT').AsCurrency);

              Next;
            end;

            if sCom > 0 then
              Result := SimpleRoundTo((sCom/sValor), -2)
            else
              Result := 0;
        end
      else  // Se NF nao existir na TOTVS
        Result := 0;
    end;
  FreeAndNil(qItemNF);
end;

function TdmProtheus.fComissaoPedido(prPedido: string): Currency;
var
  sCom, sValor, vComissao : Currency;
  vlComissaoPedido: TADOQuery;
begin
  sCom          := 0;
  sValor        := 0;

  vlComissaoPedido := TADOQuery.Create(Owner);
  with vlComissaoPedido do
    begin
      Connection     := dmProtheus.ADOConnection1;
      CommandTimeout := 200;

      // Carrega NF para calculo ponderado da comissao
      Close;
      SQL.Text := 'SELECT C6_NUM, C6_COMIS1, C6_QTDVEN, C6_PRCVEN, C6_VALOR FROM SC6010 SC6';
      SQL.Add(' WHERE SC6.D_E_L_E_T_ <> ''*'' ');

      SQL.Add(' AND SC6.C6_COMIS1 > 0');

      SQL.Add(' AND SC6.C6_NUM = ''' + Trim(prPedido) + ''' ');

      SQL.Add(' ORDER BY SC6.C6_ITEM');
      Open;

      if not IsEmpty then
        begin
          First;
          while not Eof do
            begin
               vComissao        := vlComissaoPedido.FieldByName('C6_COMIS1').AsCurrency;

               sCom   := (sCom   + (vlComissaoPedido.FieldByName('C6_VALOR').AsCurrency * vComissao));
               sValor := (sValor +  vlComissaoPedido.FieldByName('C6_VALOR').AsCurrency);

              Next;
            end;

            if sCom > 0 then
              Result := SimpleRoundTo((sCom/sValor), -2)
            else
              Result := 0;
        end
      else  // Se Pedido nao existir na TOTVS
        Result := 0;
    end;

  FreeAndNil(vlComissaoPedido);
end;

function TdmProtheus.fComissaoRegraProdutoNF(prADOQuery: TADOQuery; prVendedor,
  prUF, prNF, prSerie, prGrupoProduto: string): Currency;
var
  sCom, sValor, vComissao : Currency;
begin
  sCom          := 0;
  sValor        := 0;

  with prADOQuery do
    begin
      Connection     := dmProtheus.ADOConnection1;
      CommandTimeout := 999999;

      // Carrega NF para calculo ponderado da comissao
      Close;
      SQL.Text := 'SELECT';
      SQL.Add(' SD2.D2_PEDIDO, SD2.D2_DOC, SD2.D2_SERIE, SD2.D2_CLIENTE,');
      SQL.Add(' SD2.D2_COMIS1, SD2.D2_VALBRUT, SD2.D2_COD, SD2.D2_TP, SD2.D2_GRUPO');
      SQL.Add(' FROM SD2010 (NOLOCK) SD2');
      SQL.Add(' WHERE SD2.D_E_L_E_T_ <> ''*'' ');

      SQL.Add(' AND SD2.D2_COMIS1 > 0');

      SQL.Add(' AND SD2.D2_DOC   = ''' + Trim(prNF) + ''' ');

      SQL.Add(' AND SD2.D2_SERIE = ''' + Trim(prSerie) + ''' ');

      SQL.Add(' AND SD2.D2_GRUPO = ''' + Trim(prGrupoProduto) + ''' ');

      SQL.Add(' ORDER BY SD2.D2_ITEM');
      Open;

      if not IsEmpty then
        begin
          First;
          while not Eof do
            begin
               vComissao        := prADOQuery.FieldByName('D2_COMIS1').AsCurrency;

               sCom   := (sCom   + (prADOQuery.FieldByName('D2_VALBRUT').AsCurrency * vComissao));
               sValor := (sValor +  prADOQuery.FieldByName('D2_VALBRUT').AsCurrency);

              Next;
            end;

            if sCom > 0 then
              Result := SimpleRoundTo((sCom/sValor), -2)
            else
              Result := 0;
        end
      else  // Se NF nao existir na TOTVS
        Result := 0;
    end;
end;

function TdmProtheus.fRetornaComissaoNF(prNF, prSerieNF: string; prValorNF: Currency; var vAliqComissao: Currency): Currency;
Var
  sCom, sValor, vCom : Currency;
  vlComissao : TADOQuery;
begin
  // Comissao Pela Media Ponderada - 11/03/2020 as 20h06min
  // Fonte: http://www.brasilescola.com/matematica/media-ponderada.htm
  sCom   := 0;
  sValor := 0;

  vlComissao := TADOQuery.Create(Owner);
  with vlComissao do
    begin
      vlComissao.Connection     := dmProtheus.ADOConnection1;
      vlComissao.CommandTimeout := 999999;

      Close;
      SQL.Text := 'SELECT D2_DOC, (D2_VALBRUT-D2_ICMSRET) AS LIQUIDO, D2_COMIS1 FROM SD2010  WHERE D_E_L_E_T_ = '' '' ';
      SQL.Add(' AND D2_DOC   = ''' + prNF + ''' ');
      SQL.Add(' AND D2_SERIE = ''' + prSerieNF + ''' ');

      Open;
    end;

  vlComissao.First;
  while not vlComissao.Eof do
    begin
      sCom   := (sCom   + (vlComissao.FieldByName('LIQUIDO').AsCurrency * vlComissao.FieldByName('D2_COMIS1').AsCurrency));
      sValor := (sValor +  vlComissao.FieldByName('LIQUIDO').AsCurrency);

      vlComissao.Next;
    end;

   if sValor > 0 then
     vAliqComissao := SimpleRoundTo((sCom/sValor), -2);

   Result := SimpleRoundTo(((prValorNF * vAliqComissao) / 100),-2);

   FreeAndNil(vlComissao);
end;

function TdmProtheus.fRetornaEstoqueAtual(prProduto, prArmazem: string): Double;
var
  vlQuery: TADOQuery;
begin
  if ((Trim(UsuarioArmazens) <> '') or (Trim(prArmazem) <> '')) then
    begin
      vlQuery := TADOQuery.Create(self);
      with vlQuery do
        begin
          Connection     := dmProtheus.ADOConnection1;
          CommandTimeout := 999999;
          CacheSize      := 10;

          Close;
          SQL.Add('SELECT B2_COD, SUM(B2_QATU) AS SALDO');
          SQL.Add(' FROM SB2010');
          SQL.Add(' WHERE D_E_L_E_T_ = '''' ');
          SQL.Add(' AND B2_QATU > 0');

          if UsuarioArmazens <> '' then
            SQL.Add(' AND B2_LOCAL IN (' + UsuarioArmazens + ') ');

          if Trim(prArmazem) <> '' then
            SQL.Add(' AND B2_LOCAL = ''' + prArmazem + ''' ');

          if Trim(prProduto) <> '' then
            SQL.Add(' AND B2_COD = ''' + Trim(prProduto) + ''' ');

          SQL.Add(' GROUP BY B2_COD');

          Open;
        end;

      Result := vlQuery.FieldByName('SALDO').AsFloat;
    end
  else
    Result := 0;
end;

function TdmProtheus.fRetornaPrecoMedioLiquido(prQueryTOTVS: TADOQuery; prProduto: string; prDI, prDF: TDateTime): Double;
var
  lPrecoMedioVenda : Double;
begin
  with prQueryTOTVS do
    begin
      Connection     := dmProtheus.ADOConnection1;
      CommandTimeout := 999999;
      CacheSize      := 10;

      Close;
      SQL.Text := 'SELECT';
      SQL.Add(' SUM(SD2.D2_QUANT) AS D2_QUANT,');
      SQL.Add(' SUM(CASE WHEN D2_ICMSRET <> '''' THEN (SD2.D2_VALBRUT-SD2.D2_ICMSRET) ELSE CASE WHEN SD2.D2_TIPO IN (''I'',''P'') THEN 0 ELSE (SD2.D2_VALBRUT-SD2.D2_ICMSRET) END END) AS VR_LIQUID');

      SQL.Add(' FROM SD2010 (NOLOCK) SD2');
      SQL.Add(' WHERE SD2.D_E_L_E_T_ = '''' ');

      if Trim(prProduto) <> '' then
        SQL.Add(' AND SD2.D2_COD = ''' + Trim(prProduto) + ''' ');

      SQL.Add(' AND SD2.D2_EMISSAO BETWEEN ''' + FormatDateTime('YYYYMMDD', prDI) + ''' AND ''' + FormatDateTime('YYYYMMDD', prDF)+ ''' ');

      // InputBox('SQL', 'Text', SQL.Text);

      Open;
    end;

  if prQueryTOTVS.IsEmpty then
    Result := 0
  else
    begin
      if prQueryTOTVS.FieldByName('D2_QUANT').AsFloat > 0 then
        Result := (prQueryTOTVS.FieldByName('VR_LIQUID').AsFloat / prQueryTOTVS.FieldByName('D2_QUANT').AsFloat)
      else
        Result := 0;
    end;
end;

function TdmProtheus.fRetornaCampoTabela(prCampo, prTabela, prCampoWhere, prValorWhere: String): String;
var
  vlQuery : TADOQuery;
begin
  vlQuery := TADOQuery.Create(self);
  try
  with vlQuery do
    begin
      Connection     := ADOConnection1;
      CommandTimeout := 200;

      Close;
      SQL.Text := 'select ' + prCampo + ' from ' + prTabela;
      SQL.Add(' where D_E_L_E_T_ = '''' ');
      SQL.Add(' and ' + prCampoWhere + ' = ''' + prValorWhere + ''' ');

      Open;
    end;

    Result := vlQuery.FieldByName(prCampo).AsString;
  finally
    vlQuery.Free;
  end;
end;

function TdmProtheus.fRetornaQtdPedidoTotvs(prRetorno, prLicitacao, prPedido,
  prProduto: string; prPreco: Double): Currency;
var
  vlQueryTOTVS : TADOQuery;
  vlPreco : string;
begin
  vlQueryTOTVS := TADOQuery.Create(Owner);
  with vlQueryTOTVS do
    begin
      Connection     := ADOConnection1;
      CommandTimeout := 200;

      Close;
      SQL.Text := 'SELECT';
      SQL.Add(' SC6.C6_YSICLIC, SC6.C6_PRODUTO, SB1.B1_DESC, SC6.C6_PRCVEN,');
      SQL.Add(' SUM(COALESCE(SC6.C6_QTDVEN,0)) AS QTDE_PEDIDO,');
      SQL.Add(' SUM(COALESCE(SC6.C6_QTDENT,0)) AS QTDE_NF');
      SQL.Add(' FROM SC6010 (NOLOCK) SC6');
      SQL.Add(' LEFT JOIN SC5010 (NOLOCK) SC5 ON SC5.C5_NUM = SC6.C6_NUM AND SC5.D_E_L_E_T_ <> ''*'' ');
      SQL.Add(' LEFT JOIN SB1010 (NOLOCK) SB1 ON SB1.B1_COD = SC6.C6_PRODUTO AND SB1.D_E_L_E_T_ <> ''*'' ');
      SQL.Add(' WHERE SC6.D_E_L_E_T_ <> ''*'' ');
      SQL.Add(' AND SC6.C6_YSICLIC <> '''' ');

      if Trim(prLicitacao) <> '' then
        SQL.Add(' AND SC6.C6_YSICLIC   = ''' + Trim(prLicitacao) + ''' ');

      if Trim(prPedido) <> '' then
        SQL.Add(' AND SC6.C6_NUM     = ''' + Trim(prPedido) + ''' ');

      if Trim(prProduto) <> '' then
        SQL.Add(' AND SC6.C6_PRODUTO = ''' + Trim(prProduto) + ''' ');

      if prPreco > 0 then
        begin
          vlPreco := StringReplace(FloatToStr(prPreco), ',', '.', [rfReplaceAll]);
          SQL.Add(' AND SC6.C6_PRCVEN = ''' + vlPreco + ''' ');
        end;

      SQL.Add(' GROUP BY SC6.C6_YSICLIC, SC6.C6_PRODUTO, SB1.B1_DESC, SC6.C6_PRCVEN');
      SQL.Add(' ORDER BY 1');

      // InputBox('SQL', 'Text', SQL.Text);

      Open;
    end;

  if Trim(prRetorno) = 'Pedido' then
    Result := vlQueryTOTVS.FieldByName('QTDE_PEDIDO').AsCurrency;

  if Trim(prRetorno) = 'Faturado' then
    Result := vlQueryTOTVS.FieldByName('QTDE_NF').AsCurrency;
end;

function TdmProtheus.fRetornaUltimoPrecoMedio(prQueryTOTVS: TADOQuery; prProduto: string): TDatetime;
var
  lUltimaData: TDatetime;
begin
  with prQueryTOTVS do
    begin
      Connection     := dmProtheus.ADOConnection1;
      CommandTimeout := 999999;
      CacheSize      := 10;

      Close;
      SQL.Add('SELECT CONVERT(VARCHAR, CAST(MAX(D2_EMISSAO) AS DATETIME), 103)) AS EMISSAO FROM SD2010 WHERE D_E_L_E_T_ = '''' ');
      SQL.Add(' AND D2_COD = ''' + Trim(prProduto) + ''' ');
      Open;
    end;

//  lUltimaData := prQueryTOTVS.FieldByName().AsDateTime
//
//  if Trim() then

end;

function TdmProtheus.fSQLJoinFaturamento: String;
Var
  vlSQL : TStringList;
begin
  vlSQL := TStringList.Create;
  with vlSQL do
    begin
      Add(' FROM SD2010 (NOLOCK) SD2');
      Add(' LEFT JOIN SF2010 (NOLOCK) SF2 ON SD2.D2_DOC     = SF2.F2_DOC AND SD2.D2_SERIE       = SF2.F2_SERIE AND SF2.F2_FILIAL = SD2.D2_FILIAL AND SF2.D_E_L_E_T_ = '''' ');
      Add(' LEFT JOIN SC5010 (NOLOCK) SC5 ON SC5.C5_NUM     = SD2.D2_PEDIDO  AND SC5.C5_FILIAL  = SD2.D2_FILIAL AND SC5.D_E_L_E_T_ = '''' ');
      Add(' LEFT JOIN SA3010 (NOLOCK) SA3 ON SA3.A3_COD     = SF2.F2_VEND1   AND SA3.A3_FILIAL  = '''' AND SA3.D_E_L_E_T_ = '''' ');
      Add(' LEFT JOIN SB1010 (NOLOCK) SB1 ON SB1.B1_COD     = SD2.D2_COD     AND SB1.B1_FILIAL  = SD2.D2_FILIAL AND SB1.D_E_L_E_T_ = '''' ');
      Add(' LEFT JOIN SBM010 (NOLOCK) SBM ON SBM.BM_GRUPO   = SD2.D2_GRUPO   AND SBM.BM_FILIAL  = SD2.D2_FILIAL AND SBM.D_E_L_E_T_ = '''' ');
      Add(' LEFT JOIN SA1010 (NOLOCK) SA1 ON SA1.A1_COD     = SF2.F2_CLIENTE AND SA1.A1_FILIAL  = ''''   AND SA1.D_E_L_E_T_ = '''' ');
      Add(' LEFT JOIN ACY010 (NOLOCK) ACY ON ACY.ACY_GRPVEN = SA1.A1_GRPVEN  AND ACY.ACY_FILIAL = ''''   AND ACY.D_E_L_E_T_ = '''' ');
      Add(' LEFT JOIN YCR010 (NOLOCK) YCR ON YCR.YCR_COD    = SC5.C5_YCRCOD  AND YCR.YCR_FILIAL = ''''   AND YCR.D_E_L_E_T_ = '''' ');
      Add(' LEFT JOIN SX5010 (NOLOCK) SX5 ON SX5.X5_CHAVE   = SA1.A1_YGRUPO  AND SX5.X5_TABELA  = ''YY'' AND SX5.D_E_L_E_T_ = '''' ');
      Add('	LEFT JOIN SX5010 (NOLOCK) CP  ON CP.X5_CHAVE    = SC5.C5_YCLASPV AND CP.X5_TABELA   = ''CP'' AND CP.D_E_L_E_T_  = '''' ');
    end;

  Result := vlSQL.Text;
  FreeAndNil(vlSQL);
end;

function TdmProtheus.fSQLJoinPedidoVenda: String;
Var
  vlSQL : TStringList;
begin
  vlSQL := TStringList.Create;
  with vlSQL do
    begin
      Add(' FROM SC6010 (NOLOCK) SC6');
      Add(' LEFT JOIN SC5010 (NOLOCK) SC5 ON SC5.C5_NUM     = SC6.C6_NUM     AND SC5.C5_FILIAL  = SC6.C6_FILIAL AND SC5.D_E_L_E_T_ = '''' ');
      Add(' LEFT JOIN SA3010 (NOLOCK) SA3 ON SA3.A3_COD     = SC5.C5_VEND1   AND SA3.D_E_L_E_T_ = '''' ');
      Add(' LEFT JOIN SB1010 (NOLOCK) SB1 ON SB1.B1_COD     = SC6.C6_PRODUTO AND SB1.D_E_L_E_T_ = '''' AND SB1.B1_FILIAL   = SC5.C5_FILIAL');
      Add(' LEFT JOIN SBM010 (NOLOCK) SBM ON SBM.BM_GRUPO   = SB1.B1_GRUPO   AND SBM.D_E_L_E_T_ = '''' AND SBM.BM_FILIAL   = SC5.C5_FILIAL');
      Add(' LEFT JOIN SA1010 (NOLOCK) SA1 ON SA1.A1_COD     = SC5.C5_CLIENTE AND SA1.D_E_L_E_T_ = '''' AND SA1.A1_FILIAL   = '''' ');
      Add(' LEFT JOIN ACY010 (NOLOCK) ACY ON ACY.ACY_GRPVEN = SA1.A1_GRPVEN  AND ACY.D_E_L_E_T_ = '''' AND ACY.ACY_FILIAL  = '''' ');
      Add(' LEFT JOIN YCR010 (NOLOCK) YCR ON YCR.YCR_COD    = SC5.C5_YCRCOD  AND YCR.D_E_L_E_T_ = '''' AND YCR.YCR_FILIAL  = '''' ');
    end;

  Result := vlSQL.Text;
  FreeAndNil(vlSQL);
end;

function TdmProtheus.LerConexaoIni: String;
var
  ArqIni : tIniFile;
begin
  ArqIni := TIniFile.Create(ExtractFilePath(Application.ExeName)+ 'BaseSIC.ini');
  try
    Result := ArqIni.ReadString('PROTHEUS', 'Conexao', Result);
  finally
    ArqIni.Free;
  end;
end;

procedure TdmProtheus.pImportaClienteTOTVS(A1Cod, A1Vend, prTipo: string);
var
  vlQueryTOTVS : TADOQuery;
begin
//  vlQueryTOTVS := TADOQuery.Create(Owner);
//  with vlQueryTOTVS do
//    begin
//      Connection     := dmProtheus.ADOConnection1;
//      CommandTimeout := 200;
//
//      Close;
//      SQL.Text := 'SELECT * FROM SA1010 WHERE D_E_L_E_T_ <> ''*'' ';
//      SQL.Add(' AND A1_YCLIPRI = '''' '); // Nao é cadastro de Entrega
//
//      if Trim(A1Cod) <> '' then
//        SQL.Add(' AND A1_COD = ''' + Trim(A1Cod) + '''');
//
//      if Trim(A1Vend) <> '' then
//        SQL.Add(' AND A1_VEND1 = ''' + Trim(A1Vend) + '''');
//
//      Open;
//    end;
//
//  if not vlQueryTOTVS.IsEmpty then
//    begin
//      dm1.DS_PESSOAS.Close;
//      dm1.DS_PESSOAS.SelectSQL.Text := 'select * from tbpessoas where deletado = ''N'' and pessoa_id = 0';
//      dm1.DS_PESSOAS.Open;
//
//      vlQueryTOTVS.First;
//      while not vlQueryTOTVS.Eof do
//        begin
//          if prTipo = 'Incluir' then
//            dm1.DS_PESSOAS.Insert;
//
//          if prTipo = 'Alterar' then
//            dm1.DS_PESSOAS.Edit;
//
//          dm1.DS_PESSOASPESSOA_VR.AsString    := '';
//          dm1.DS_PESSOASEMPRESA_ID.AsString   := EmpresaID;
//          dm1.DS_PESSOASUSUARIO_ID.AsString   := UsuarioID;
//          dm1.DS_PESSOASNOME_PUPULAR.AsString := TiraAcentos(Trim(vlQueryTOTVS.FieldByName('A1_NREDUZ').AsString));
//          dm1.DS_PESSOASNOME.AsString         := TiraAcentos(Trim(vlQueryTOTVS.FieldByName('A1_NOME').AsString));
//          dm1.DS_PESSOASENDERECO.AsString     := Trim(vlQueryTOTVS.FieldByName('A1_END').AsString);
//          dm1.DS_PESSOASCOMPLEMENTO.AsString  := Trim(vlQueryTOTVS.FieldByName('A1_COMPLEM').AsString);
//          dm1.DS_PESSOASBAIRRO.AsString       := Trim(vlQueryTOTVS.FieldByName('A1_BAIRRO').AsString);
//          dm1.DS_PESSOASCIDADE.AsString       := Trim(vlQueryTOTVS.FieldByName('A1_MUN').AsString);
//          dm1.DS_PESSOASUF.AsString           := Trim(vlQueryTOTVS.FieldByName('A1_EST').AsString);
//          dm1.DS_PESSOASCEP.AsString          := OnlyNumber(Trim(vlQueryTOTVS.FieldByName('A1_CEP').AsString));
//          dm1.DS_PESSOASNASCIMENTO.AsString   := copy(Trim(vlQueryTOTVS.FieldByName('A1_DTNASC').AsString),7,2)+'/'+copy(Trim(vlQueryTOTVS.FieldByName('A1_DTNASC').AsString),5,2)+'/'+copy(Trim(vlQueryTOTVS.FieldByName('A1_DTNASC').AsString),1,4);
//          dm1.DS_PESSOASTIPO.AsString         := Trim(vlQueryTOTVS.FieldByName('A1_PESSOA').AsString);
//          dm1.DS_PESSOASCPF_CNPJ.AsString     := OnlyNumber(Trim(vlQueryTOTVS.FieldByName('A1_CGC').AsString));
//          dm1.DS_PESSOASRG_CGF.AsString       := Trim(vlQueryTOTVS.FieldByName('A1_PESSOA').AsString);
//
//          if Trim(vlQueryTOTVS.FieldByName('A1_PESSOA').AsString) = 'F' then
//            dm1.DS_PESSOASRG_CGF.AsString := OnlyNumber(Trim(vlQueryTOTVS.FieldByName('A1_PFISICA').AsString))
//          else
//            dm1.DS_PESSOASRG_CGF.AsString := OnlyNumber(Trim(vlQueryTOTVS.FieldByName('A1_INSCR').AsString));
//
//          dm1.DS_PESSOASCLASSES.AsString          := 'A;';
//          dm1.DS_PESSOASOBS.AsString              := Trim(vlQueryTOTVS.FieldByName('A1_YHISTOR').AsString);
//          dm1.DS_PESSOASLIMITE_CREDITO.AsCurrency := vlQueryTOTVS.FieldByName('A1_LC').AsCurrency;
//          dm1.DS_PESSOASFONE_01.AsString          := '('+OnlyNumber(Trim(vlQueryTOTVS.FieldByName('A1_DDD').AsString))+')'+OnlyNumber(Trim(vlQueryTOTVS.FieldByName('A1_TEL').AsString));
//          dm1.DS_PESSOASFONE_02.AsString          := '('+OnlyNumber(Trim(vlQueryTOTVS.FieldByName('A1_DDD').AsString))+')'+OnlyNumber(Trim(vlQueryTOTVS.FieldByName('A1_TELEX').AsString));
//          dm1.DS_PESSOASFONE_03.AsString          := '('+OnlyNumber(Trim(vlQueryTOTVS.FieldByName('A1_DDD').AsString))+')'+OnlyNumber(Trim(vlQueryTOTVS.FieldByName('A1_FAX').AsString));
//          dm1.DS_PESSOASCOMISSAO.AsCurrency       := vlQueryTOTVS.FieldByName('A1_COMIS').AsCurrency;
//          dm1.DS_PESSOASDATACADASTRO.AsDateTime   := Now;
//          dm1.DS_PESSOASCOB_ENDERECO.AsString     := Trim(vlQueryTOTVS.FieldByName('A1_ENDCOB').AsString);
//          dm1.DS_PESSOASCOB_BAIRRO.AsString       := Trim(vlQueryTOTVS.FieldByName('A1_YBAIRRO').AsString);
//          dm1.DS_PESSOASCOB_CIDADE.AsString       := Trim(vlQueryTOTVS.FieldByName('A1_YMUN').AsString);
//          dm1.DS_PESSOASCOB_UF.AsString           := Trim(vlQueryTOTVS.FieldByName('A1_YEST').AsString);
//          dm1.DS_PESSOASCOB_CEP.AsString          := OnlyNumber(Trim(vlQueryTOTVS.FieldByName('A1_YCEP').AsString));
//          dm1.DS_PESSOASSITUACAO.AsString         := 'Ativo';
//          dm1.DS_PESSOASDELETADO.AsString         := 'N';
//          dm1.DS_PESSOASDATA_INC.AsDateTime       := Now;
//          dm1.DS_PESSOASEMAIL.AsString            := Trim(vlQueryTOTVS.FieldByName('A1_EMAIL').AsString);
//          dm1.DS_PESSOASSITE.AsString             := Trim(vlQueryTOTVS.FieldByName('A1_HPAGE').AsString);
//          dm1.DS_PESSOASIDSOFT.AsString           := Trim(vlQueryTOTVS.FieldByName('A1_COD').AsString);
//          dm1.DS_PESSOASUSUARIO_ID.AsString       := UsuarioID;
//          dm1.DS_PESSOASUSUARIONOME_I.AsString    := Usuario;
//          dm1.DS_PESSOASERP_CODIGO.AsString       := OnlyNumber(Trim(vlQueryTOTVS.FieldByName('A1_COD').AsString));
//
//          dm1.DS_PESSOAS.Post;
//          dm1.DS_PESSOAS.Transaction.CommitRetaining;
//
//          vlQueryTOTVS.Next;
//        end;
//    end;
end;

end.
