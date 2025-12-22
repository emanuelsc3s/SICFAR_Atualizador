unit Unit_Client;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdAntiFreezeBase,
  Vcl.IdAntiFreeze, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  Vcl.ExtCtrls, Vcl.ComCtrls, RzPrgres;

type
  TForm_Atualizador = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Cliente: TIdTCPClient;
    Memo1: TMemo;
    IdAntiFreeze1: TIdAntiFreeze;
    ProgressBar1: TProgressBar;
    procedure ClienteWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure ClienteWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure ClienteWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Procedure AdicionaLog(Linha:String);
    Procedure InicializarAtualizacao;

    function GetBuildInfo(prog: String): String;
  public
    { Public declarations }
  end;

var
  Form_Atualizador: TForm_Atualizador;
  Atualizado : Boolean;
  Caminho, NovoArquivo : String;
  versao_local, versao_servidor : String;
  TamanhoArquivos : integer;

implementation

uses
  System.IniFiles, Winapi.ShellAPI, IBX.IBQuery, Unit_DM1;

{$R *.dfm}

{ TForm_Atualizador }

procedure TForm_Atualizador.AdicionaLog(Linha: String);
begin
  Memo1.Lines.add( DateToStr(now)+' '+ TimeToStr(Now) + ' :: ' + Linha );
  Application.ProcessMessages;
end;

procedure TForm_Atualizador.ClienteWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  //ProgressBar1.Position := ProgressBar1.Position + AWorkCount;
  TamanhoArquivos := AWorkCount;
end;

procedure TForm_Atualizador.ClienteWorkBegin(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  AdicionaLog('Baixando arquivo. Tamanho'+inttostr(AWorkCountMax div 1024)+'KB');
end;

procedure TForm_Atualizador.ClienteWorkEnd(ASender: TObject;
  AWorkMode: TWorkMode);
begin
  ProgressBar1.Position := ProgressBar1.Position + TamanhoArquivos;
end;

procedure TForm_Atualizador.FormShow(Sender: TObject);
var
  ArqIni : TIniFile;
  Porta : Integer;
  Host : String;
  vlQuerySIC : TIBQuery;
  vlVersaoEXE, vlVersaoBanco : String;
  Sistema : String;
begin
  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;
    end;

  vlVersaoEXE := dm1.Get_Versao;

  //Carrega conteúdo da TBPARAMETROS--------------------------------------
  with vlQuerySIC do
    begin
      Close;
      SQL.Text := 'select conteudo from tbparametros where parametro = ''ATUALIZADOR_HOST'' ';
      Open;
    end;
  Cliente.Host := vlQuerySIC.FieldByName('CONTEUDO').AsString;

  with vlQuerySIC do
    begin
      Close;
      SQL.Text := 'select conteudo from tbparametros where parametro = ''ATUALIZADOR_PORTA'' ';
      Open;
    end;
  Cliente.Port := vlQuerySIC.FieldByName('CONTEUDO').AsInteger;

  with vlQuerySIC do
    begin
      Close;
      SQL.Text := 'select conteudo from tbparametros where parametro = ''ATUALIZADOR_CAMINHO'' ';
      Open;
    end;
  Caminho := vlQuerySIC.FieldByName('CONTEUDO').AsString;

  with vlQuerySIC do
    begin
      Close;
      SQL.Text := 'select conteudo from tbparametros where parametro = ''ATUALIZADOR_NOVO_ARQ'' ';
      Open;
    end;
  NovoArquivo := vlQuerySIC.FieldByName('CONTEUDO').AsString;

  //----------------------------------------------------------------
  with vlQuerySIC do
    begin
      Close;
      SQL.Text := 'select versao from tbusuario';
      SQL.Add(' where deletado = ''N'' ');
      SQL.Add(' and usuario_id = ''' + '144' + ''' ');
      Open;
    end;

  vlVersaoBanco := vlQuerySIC.FieldByName('VERSAO').AsString;

  if vlVersaoEXE <> vlVersaoBanco then
    begin
      InicializarAtualizacao;
      with vlQuerySIC do
        begin
          Close;

          SQL.Text := 'update tbusuario set';
          SQL.Add(' versao = ''' + vlVersaoBanco + ''' ');
          SQL.Add(' where deletado = ''N'' ');

          ExecSQL;
          Transaction.CommitRetaining;
        end;
    end;

  FreeAndNil(vlQuerySIC);
end;

function TForm_Atualizador.GetBuildInfo(prog: String): String;
var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
  V1, V2, V3, V4: Word;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(prog),Dummy);
  GetMem(VerInfo,VerInfoSize);
  GetFileVersionInfo(PChar(prog),0,VerInfoSize,VerInfo);
  VerQueryValue(VerInfo,'',Pointer(VerValue),VerValueSize);

  with VerValue^ do
    begin
      V1 := dwFileVersionMS shr 16;
      V2 := dwFileVersionMS and $FFFF;
      V3 := dwFileVersionLS shr 16;
      V4 := dwFileVersionLS and $FFFF;
    end;
  FreeMem(VerInfo,VerInfoSize);
  result := Copy(IntToStr(100 + v1),3,2) + '.' + Copy(IntToStr(100 + V2),3,2) + '.' + Copy(IntToStr(100 + V3),3,2) + '.' + Copy(IntToStr(100 + V4),3,2);
end;

procedure TForm_Atualizador.InicializarAtualizacao;
var
  StreamArquivo, StreamGet : TMemoryStream;
  Versoes : TStrings;
  I : Integer;
  Arquivo, Versao: String;
  Sistema : String;
begin
  Sistema := ExtractFileName(Application.ExeName);
  ShowMessage(Sistema);
  Exit;
  AdicionaLog('Iniciando Atualização');
  try
    AdicionaLog('Tentando Conexão com:'+Cliente.Host);
    Cliente.Connect; //Tenta se conectar
    AdicionaLog('Conexão estabelecida com sucesso');
    ProgressBar1.Max := StrToInt(Cliente.IOHandler.ReadLn);
  except on e: Exception do
    begin
      AdicionaLog('Falha ao se conectar com o servidor de atualização.');
      AdicionaLog('ERRO: "'+e.Message+'"');
      Atualizado:=True;
      Exit;
    end;
  end;

  AdicionaLog('Requisitando arquivo ao servidor...');

  with Cliente do
    begin
      Versoes:= TStringList.Create;
      StreamArquivo:= TMemoryStream.Create;
      IOHandler.WriteLn(Sistema + 'arquivos '); //manda o comando para o servidor. (deixe um espaço após o texto.)

      StreamArquivo.size:=StrToInt( IOHandler.ReadLn ); //Lê o tamanho que o servidor enviou.
      IOHandler.ReadStream(StreamArquivo, StreamArquivo.size, False); //Lê a stream que o servidor enviou.
      StreamArquivo.Position:=0; //manda a memória do Stream para o início

      If StreamArquivo.Memory = nil then
        begin //se estiver zerado deu erro.
          AdicionaLog('Falha ao transferir a lista de versões.');
          //HabilitaCampos;
          Exit;
        end;

      Versoes.LoadFromStream(StreamArquivo); //Faz as linhas de versões lerem
      AdicionaLog('Lista de versões transferida com sucesso.');
    end;

  AdicionaLog('Verificando Versões...');

  StreamGet := TMemoryStream.Create;
  for I:= 0 to Versoes.Count-1 do
    begin
      Arquivo := copy(Versoes.Strings[I], 1, pos('=',Versoes.Strings[I])-1);
      Versao  := copy(Versoes.Strings[I], pos('=',Versoes.Strings[I])+1, length(Versoes.Strings[I]));

      if FileExists(Caminho + Arquivo) then
        AdicionaLog('Versão '+DateTimeToStr(FileDateToDateTime(FileAge(Caminho+Arquivo)))+' do Arquivo:"'+Arquivo+'"'+' será atualizada para: '+versao);

      AdicionaLog('Requisitando arquivo ao servidor...');

      with Cliente do
        begin
          IOHandler.WriteLn('get '+Arquivo);
          StreamGet.size:=StrToInt( IOHandler.ReadLn ); //Lê o tamanho que o servidor enviou.
          IOHandler.ReadStream(StreamGet, StreamGet.size, False); //Lê a stream que o servidor enviou.
          StreamGet.Position:=0; //manda a memória do Stream para o início

          if Arquivo = Sistema then
            begin
              RenameFile(Sistema, Copy(Sistema, 1, pos('.',Sistema)-1) +  '-'+dm1.Get_Versao+'.exe');
              StreamGet.SaveToFile(Caminho + Sistema);
            end
          else
            StreamGet.SaveToFile(Caminho + Arquivo);

          AdicionaLog('Download do arquivo: '+Arquivo+' Concluído.');
        end;
    end;

  AdicionaLog('Atualização Terminada.');
  StreamArquivo.Free;
  StreamGet.Free;
  ShellExecute(0,Nil,PChar(GetCurrentDir + '\' + Sistema),'', Nil, SW_SHOWNORMAL);
  Application.Terminate;
end;

end.
