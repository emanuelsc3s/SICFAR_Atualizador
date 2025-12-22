
unit Unit_Atualizador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdAntiFreezeBase,
  Vcl.IdAntiFreeze, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  Vcl.ExtCtrls, Vcl.ComCtrls, RzPrgres, IdIPWatch;

type
  TForm_Atualizador = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Cliente: TIdTCPClient;
    Memo1: TMemo;
    ProgressBar1: TProgressBar;
    Timer1: TTimer;
    IdIPWatch1: TIdIPWatch;
    procedure ClienteWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure ClienteWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure ClienteWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Procedure AdicionaLog(Linha:String);
    Procedure InicializarAtualizacao;

    function GetBuildInfo(prog: String): String;
    function Get_Versao_Atualizada: String;

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
begin
  Timer1.Enabled := True;
end;

function TForm_Atualizador.GetBuildInfo(prog: String): String;
var
  ver_infosize,
  ver_valuesize,
  dummy          : DWord;
  ver_info       : Pointer;
  ver_value      : PVSFixedFileInfo;
  v1, v2, v3, v4 : Word;
begin
  ver_infosize := GetFileVersionInfoSize(pchar(prog), dummy);
  GetMem(ver_info, ver_infosize);
  GetFileVersionInfo(PChar(prog), 0, ver_infosize, ver_info);
  VerQueryValue(ver_info, '\', Pointer(ver_value), ver_valuesize);
  With ver_value^ do begin
    v1 := dwFileVersionMS shr 16;
    v2 := dwFileVersionMS and $FFFF;
    v3 := dwFileVersionLS shr 16;
    v4 := dwFileVersionLS and $FFFF;
  end;
  FreeMem(ver_info, ver_infosize);

  Result := IntToStr(v1) + '.' +
            IntToStr(v2) + '.' +
            IntToStr(v3) + '.' +
            IntToStr(v4);
end;

function TForm_Atualizador.Get_Versao_Atualizada: String;
var
  v1, v2, v3, v4 : Word;
begin
  //Getbuildinfo(v1, v2, v3, v4, PChar(GetCurrentDir+'\SICFAR.exe'));
  Result := IntToStr(v1) + '.' +
            IntToStr(v2) + '.' +
            IntToStr(v3) + '.' +
            IntToStr(v4);
end;

procedure TForm_Atualizador.InicializarAtualizacao;
var
  StreamArquivo, StreamGet : TMemoryStream;
  Versoes : TStrings;
  I : Integer;
  Arquivo, Versao: String;
  vlQuerySIC : TIBQuery;
  vlVersaoSICFAR: String;
  StreamString : String;
  Sistema : String;
begin
  Sistema := ExtractFileName(Application.ExeName);
  AdicionaLog('Iniciando Atualização');
  try
    AdicionaLog('Tentando Conexão com:'+Cliente.Host);
    Cliente.Connect; //Tenta se conectar
    Cliente.IOHandler.WriteLn(Usuario);
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
      IOHandler.WriteLn(Sistema +'_' + 'arquivos#'); //manda o comando para o servidor. (deixe um espaço após o texto.)

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
          IOHandler.WriteLn(Sistema +'_' +'get#'+Arquivo);
          StreamGet.size:=StrToInt( IOHandler.ReadLn ); //Lê o tamanho que o servidor enviou.
          IOHandler.ReadStream(StreamGet, StreamGet.size, False); //Lê a stream que o servidor enviou.
          StreamGet.Position:=0; //manda a memória do Stream para o início

          if Arquivo = Sistema then
            begin
              RenameFile(Sistema, Copy(Sistema, 1, pos('.',Sistema)-1) +  '-'+dm1.Get_Versao+'.exe');
              StreamGet.SaveToFile(Caminho + Sistema);
              vlVersaoSICFAR := Versao;
            end
          else
            begin
              if not DirectoryExists(Caminho + copy(Arquivo, 1, pos('\',Arquivo)-1)) then
                ForceDirectories(Caminho + copy(Arquivo, 1, pos('\',Arquivo)-1));
              StreamGet.SaveToFile(Caminho + Arquivo);
            end;

          AdicionaLog('Download do arquivo: '+Arquivo+' Concluído.');
        end;
    end;

  AdicionaLog('Atualização Terminada.');

  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;
    end;

      {Close;
      SQL.Text := 'select versao from tbusuario';
      SQL.Add(' where deletado = ''N'' ');
      SQL.Add(' and usuario_id = ''' + UsuarioID + ''' ');
      Open;
    end;

  vlVersaoBanco := vlQuerySIC.FieldByName('VERSAO').AsString; }

  with vlQuerySIC do
    begin

      SQL.Text := 'update tbusuario set';
      //SQL.Add(' versao = ''' + vlVersaoBanco + ''' ');
      SQL.Add(' versao = ''' + vlVersaoSICFAR + ''' ');
      SQL.Add(' where deletado = ''N'' ');

      ExecSQL;
      Transaction.CommitRetaining;
    end;

  FreeAndNil(vlQuerySIC);

  StreamArquivo.Free;
  StreamGet.Free;
  ShellExecute(0,Nil,PChar(GetCurrentDir+'\' + Sistema),'', Nil, SW_SHOWNORMAL);
  Application.Terminate;
end;

procedure TForm_Atualizador.Timer1Timer(Sender: TObject);
var
  ArqIni : TIniFile;
  Porta : Integer;
  Host : String;
  vlQuerySIC : TIBQuery;
begin
  Timer1.Enabled := False;
  vlQuerySIC := TIBQuery.Create(Owner);
  with vlQuerySIC do
    begin
      Database    := dm1.IBDatabase1;
      Transaction := dm1.IBTransaction1;
    end;

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
  //Caminho := vlQuerySIC.FieldByName('CONTEUDO').AsString;
  Caminho := ExtractFilePath(Application.ExeName);

  with vlQuerySIC do
    begin
      Close;
      SQL.Text := 'select conteudo from tbparametros where parametro = ''ATUALIZADOR_NOVO_ARQ'' ';
      Open;
    end;
  NovoArquivo := vlQuerySIC.FieldByName('CONTEUDO').AsString;

  if not DirectoryExists(Caminho) then
    ForceDirectories(Caminho);

  //----------------------------------------------------------------
  InicializarAtualizacao;
  FreeAndNil(vlQuerySIC);
end;

end.
