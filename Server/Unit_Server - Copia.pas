unit Unit_Server;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdContext, Vcl.StdCtrls,
  IdAntiFreezeBase, Vcl.IdAntiFreeze, IdBaseComponent, IdComponent,
  IdCustomTCPServer, IdTCPServer, Vcl.ComCtrls, IdThreadComponent,
  System.ImageList, Vcl.ImgList, RzPanel, RzButton, Vcl.ExtCtrls, winsock,
  Vcl.Grids, System.Win.ScktComp, ShellAPI;

type
  TForm_PrincipalServer = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    RzToolbar2: TRzToolbar;
    btn_Ativar: TRzToolButton;
    RzSpacer1: TRzSpacer;
    btn_Desativar: TRzToolButton;
    RzSpacer2: TRzSpacer;
    btn_Salvar: TRzToolButton;
    GroupBox1: TGroupBox;
    Memo_Arquivos: TMemo;
    GroupBox2: TGroupBox;
    Memo_Log: TMemo;
    Servidor: TIdTCPServer;
    IdAntiFreeze1: TIdAntiFreeze;
    imageCad: TImageList;
    Timer1: TTimer;
    SaveDialog1: TSaveDialog;
    RzToolbar1: TRzToolbar;
    btn_Fechar: TRzToolButton;
    Timer_Monitor: TTimer;
    StringGrid1: TStringGrid;
    ServerSocket: TServerSocket;
    procedure ServidorExecute(AContext: TIdContext);
    procedure ServidorConnect(AContext: TIdContext);
    procedure FormCreate(Sender: TObject);
    procedure btn_AtivarClick(Sender: TObject);
    procedure btn_DesativarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure btn_SalvarClick(Sender: TObject);
    procedure btn_FecharClick(Sender: TObject);
    procedure Timer_MonitorTimer(Sender: TObject);
    procedure ServerSocketClientError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure pListaArquivos;
    procedure pCarregaParametrosServidor;
    procedure pLimpaLista(Grid: TStringGrid);
    procedure pIniciaMonitor;
    function GetBuildInfo(prog: String): String;
  public
    { Public declarations }
  end;

var
  Form_PrincipalServer: TForm_PrincipalServer;
  Caminho : String;
  TamanhoArquivos : integer;
  vlData : TDateTime;
  IndexConexao: integer;
  ConexaoCliente : Integer;
  AcessoID_Cliente : String;

implementation

uses
  System.IniFiles, IBX.IBQuery, Unit_DM1;

{$R *.dfm}

procedure TForm_PrincipalServer.btn_AtivarClick(Sender: TObject);
begin
  try
    pCarregaParametrosServidor;
    pListaArquivos;
    Memo_Arquivos.Lines.SaveToFile(GetCurrentDir+'\arquivos_comp.txt');
    Servidor.Active       := True;
    timer1.Enabled        := True;
    btn_Ativar.Enabled    := False;
    btn_Desativar.Enabled := True;

  except on E:Exception do
    begin
      ShowMessage('Erro na Clonagem: ' + E.Message);
   // Application.MessageBox('Erro ao ativar o servidor de atualização','Erro',MB_OK+MB_ICONERROR);
    end;
  end;
end;

procedure TForm_PrincipalServer.btn_DesativarClick(Sender: TObject);
begin
  try
    Servidor.Active := False;
    btn_Ativar.Enabled    := True;
    btn_Desativar.Enabled := False;
    timer1.Enabled := False;
    Memo_Log.Clear;
    Memo_Arquivos.Clear;
  except
    Application.MessageBox('Erro ao desativar o servidor de atualização','Erro',MB_OK+MB_ICONERROR);
  end;
end;

procedure TForm_PrincipalServer.btn_FecharClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja realmente fechar o atualizador?','',MB_YESNO+MB_ICONQUESTION) = mrYes then
    Application.Terminate;
end;

procedure TForm_PrincipalServer.btn_SalvarClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
    begin
      try
        Memo_Log.Lines.SaveToFile(SaveDialog1.FileName);
        Application.MessageBox('Arquivo salvo com sucesso', 'Informação', MB_OK+MB_ICONINFORMATION);
      except
        Application.MessageBox('Erro ao salvar arquivo', 'Erro', MB_OK+MB_ICONERROR);
      end;
    end;
end;

procedure TForm_PrincipalServer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Application.MessageBox('Deseja realmente fechar o atualizador?','',MB_YESNO+MB_ICONQUESTION) = mrYes then
    Application.Terminate;
end;

procedure TForm_PrincipalServer.FormCreate(Sender: TObject);
begin
  btn_Desativar.Enabled := False;
  vlData := Date;
  IndexConexao := -1;
  pIniciaMonitor;
end;

procedure TForm_PrincipalServer.FormShow(Sender: TObject);
begin
  btn_AtivarClick(Sender);
end;

function TForm_PrincipalServer.GetBuildInfo(prog: String): String;
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

procedure TForm_PrincipalServer.pCarregaParametrosServidor;
var
  Porta : Integer;
  IP : String;
  ArqIni : TIniFile;
begin
  ArqIni := TIniFile.Create(GetCurrentDir + '\BaseSIC.Ini');
  Try
    Caminho := ArqIni.ReadString  ('ATUALIZADOR', 'Caminho' , Caminho);
    Porta   := ArqIni.ReadInteger ('ATUALIZADOR', 'Porta' , Porta);
    IP      := ArqIni.ReadString  ('ATUALIZADOR', 'IP' , IP);
  Finally
    ArqIni.Free;
  end;

  Servidor.DefaultPort := Porta;
end;

procedure TForm_PrincipalServer.pIniciaMonitor;
var
  Porta : Integer;
  ArqIni : TIniFile;
begin
  ArqIni := TIniFile.Create(GetCurrentDir + '\BaseSIC.Ini');
  Try
    Porta   := ArqIni.ReadInteger ('MONITOR', 'Porta' , Porta);
  Finally
    ArqIni.Free;
  end;

  ServerSocket.Port := Porta;
  ServerSocket.Active := True;
  Timer_Monitor.Enabled := true;
end;

procedure TForm_PrincipalServer.pLimpaLista(Grid: TStringGrid);
var
  lin, col: integer;
begin
  for lin := 1 to Grid.RowCount - 1 do
    begin
      for col := 0 to Grid.ColCount - 1 do
        begin
          Grid.Cells[col, lin] := '';
        end;
    end;
  with StringGrid1 do
    begin
      Cells[0,0] := 'CONEXÃO';
      Cells[1,0] := 'COMPUTADOR';
      Cells[2,0] := 'IP';
      Cells[3,0] := 'USUÁRIO';
      Cells[4,0] := 'ACESSO';
    end;
end;

procedure TForm_PrincipalServer.pListaArquivos;
var
  SR: TSearchRec;
  I: integer;
  J: integer;
begin
  DeleteFile('arquivos.txt');
  Memo_Arquivos.Clear;
  TamanhoArquivos := 0;

  I := FindFirst(Caminho+'*.*', faAnyFile, SR);
  while I = 0 do
    begin
      if ((sr.Name <> '.') and (sr.Name <> '..')) then
        begin
          if sr.Name = 'SICFAR.exe' then
            Memo_Arquivos.Lines.Add(sr.Name+'='+GetBuildInfo(Caminho+sr.Name))
          else
            Memo_Arquivos.Lines.Add(sr.Name+'=123');
          TamanhoArquivos := TamanhoArquivos + sr.Size;
        end;

      I := FindNext(SR);
    end;

  Memo_Arquivos.Lines.SaveToFile(GetCurrentDir + '\arquivos.txt');
end;

procedure TForm_PrincipalServer.ServerSocketClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
   ShellExecute(0,Nil,PChar(GetCurrentDir+'\SICServidorAtualizador.exe'),'', Nil, SW_SHOWNORMAL);
   Application.Terminate;

{  if ((ErrorCode = 10053) or (ErrorCode = 10054)) then
    begin
      Memo_Log.Lines.Add('IP: ' + Socket.RemoteAddress +
                         ' | Computador: ' + Socket.RemoteHost +
                         ' | Erro: ' + IntToStr(ErrorCode));
      ErrorCode := 0;
      ServerSocket.Active := False;
      ServerSocket.Active := True;
    end;}
end;

procedure TForm_PrincipalServer.ServidorConnect(AContext: TIdContext);
var
  Computador : String;
begin
  Computador := AContext.Connection.IOHandler.ReadLn;
  Memo_Log.Lines.Add('--------------------------------------------------------------------------------------------------------');
  Memo_Log.Lines.Add('Usuário: ' + Computador
    + ' || IP: ' + AContext.Connection.Socket.Binding.PeerIP
    + ' || Conectado em ' + FormatDateTime('DD/MM/YYYY HH:MM:SS', Now));
  AContext.Connection.IOHandler.WriteLn(IntToStr(TamanhoArquivos));
end;

procedure TForm_PrincipalServer.ServidorExecute(AContext: TIdContext);
var
  Comando, Parametro, Linha, IP, Computador: string;
  Stream: TMemoryStream;
  i : integer;
  s : string;
begin
  //Procesando os comandos
  Linha:= AContext.Connection.IOHandler.ReadLn; //Lê a linha enviada.
  IP:= AContext.Connection.socket.Binding.PeerIP;
  Comando    := copy(Linha,1, pos(' ',Linha)-1);
  Parametro  := copy(Linha, Pos(' ',Linha)+1,  length(Linha));

  if Comando = 'arquivos' then
    begin
      //Envia para o cliente, o aquivo de versões
      try
        Memo_Log.Lines.Add({IP + ' :: }'Requisição de atualização de arquivos em '
          + FormatDateTime('DD/MM/YYYY HH:MM:SS', Now));
        Memo_Log.Lines.Add(#13);
        Stream:= TMemoryStream.Create;
        //Memo2.Lines.SaveToStream(Stream);
        Stream.LoadFromFile(GetCurrentDir + '\arquivos.txt');
        AContext.Connection.IOHandler.WriteLn(inttostr(Stream.Size)); //Envia o tamanho do arquivo
        Acontext.Connection.IOHandler.Write(Stream);
      finally
        Stream.Free;
      end;
    end
  else
    if Comando = 'get' then
      begin
        //Envia para o cliente, o aquivo que ele pediu.
        try
          Memo_Log.Lines.Add({IP + ' :: }'Requisição do arquivo "' + Parametro + '" em '
            + FormatDateTime('DD/MM/YYYY HH:MM:SS', Now));
          Stream:= TMemoryStream.Create;
          Stream.LoadFromFile(Caminho + Parametro);
          AContext.Connection.IOHandler.WriteLn(inttostr(Stream.Size)); //Envia o tamanho do arquivo
          Acontext.Connection.IOHandler.Write(Stream);
        finally
          Stream.Free;
        end;
      end;
end;

procedure TForm_PrincipalServer.Timer1Timer(Sender: TObject);
var
  arquivo, arquivo_comp : TStringList;
  i, j : integer;
  nome1, nome2, data1, data2 : String;
  aux : integer;
begin
  if Memo_Log.Lines.Text <> '' then
    begin
      if vlData <> Date then
        begin
          Memo_Log.Lines.SaveToFile(GetCurrentDir+'\Log\Log Atualização - '+ FormatDateTime('DD-MM-YYYY',vlData)+'.txt');
          vlData := Date;
          Memo_Log.Clear;
        end;
    end;

  pListaArquivos;
  arquivo := TStringList.Create;
  arquivo_comp := TStringList.Create;

  arquivo.LoadFromFile(GetCurrentDir+'\arquivos.txt');
  arquivo_comp.LoadFromFile(GetCurrentDir+'\arquivos_comp.txt');

  aux := 0;

  for i := 0 to arquivo.Count -1 do
    begin
      data1 := Copy(arquivo[i], pos('=', arquivo[i])+1, length(arquivo[i]) );
      nome1 := Copy(arquivo[i], 1, pos('=', arquivo[i])-1);
      for j := 0 to arquivo_comp.Count -1 do
        begin
          data2 := Copy(arquivo_comp[j], pos('=', arquivo_comp[j])+1, length(arquivo_comp[j]) );
          nome2 := Copy(arquivo_comp[j], 1, pos('=', arquivo_comp[j])-1);

          if nome1 = nome2 then
            begin
              aux := 1;
              if data1 <> data2 then
                begin
                  Memo_Log.Lines.Add('--------------------------------------------------------------------------------------------------------');
                  Memo_Log.Lines.Add(nome1 + ' foi alterado em ' + FormatDateTime('DD/MM/YYYY HH:MM:SS', Now));
                end;
            end;
        end;

      if aux = 0 then
        begin
          Memo_Log.Lines.Add('--------------------------------------------------------------------------------------------------------');
          Memo_Log.Lines.Add(nome1 + ' foi inserido em ' + FormatDateTime('DD/MM/YYYY HH:MM:SS', Now));
        end;

      aux := 0;
    end;

  for i := 0 to arquivo_comp.Count -1 do
    begin
      nome1 := Copy(arquivo_comp[i], 1, pos('=', arquivo_comp[i])-1);
      for j := 0 to arquivo.Count -1 do
        begin
          nome2 := Copy(arquivo[j], 1, pos('=', arquivo[j])-1);
          if nome1 = nome2 then
            aux := 1;
        end;
      if aux = 0 then
        begin
          Memo_Log.Lines.Add('--------------------------------------------------------------------------------------------------------');
          Memo_Log.Lines.Add(nome1 + ' foi removido em ' + FormatDateTime('DD/MM/YYYY HH:MM:SS', Now))
        end
      else
        aux:=0;
    end;

  DeleteFile('arquivos_comp.txt');
  Memo_Arquivos.Lines.SaveToFile(GetCurrentDir+'\arquivos_comp.txt');
end;

procedure TForm_PrincipalServer.Timer_MonitorTimer(Sender: TObject);
var
  Index : Integer; Item : TListItem;
  usuario, texto, acesso : string;
begin
  Timer1.Enabled := False;
  pLimpaLista(StringGrid1);

  StringGrid1.RowCount := ServerSocket.Socket.ActiveConnections + 1;
  for Index := 0 to ServerSocket.Socket.ActiveConnections -1 do
    begin
      //Application.ProcessMessages;
      try
        with StringGrid1 do
          begin
            texto   := ServerSocket.Socket.Connections[Index].ReceiveText;
            usuario := copy(texto, 1, pos('|', texto) -1);
            acesso  := copy(texto, pos('|', texto) +1, length(texto));
            Cells[0,(index+1)] := IntToStr(Index);
            Cells[1,(index+1)] := ServerSocket.Socket.Connections[Index].RemoteHost;
            Cells[2,(index+1)] := ServerSocket.Socket.Connections[Index].RemoteAddress;
            Cells[3,(index+1)] := usuario;
            Cells[4,(index+1)] := acesso;
          end;
      except on E:Exception do
        begin
          //Memo_Log.Lines.Add(ServerSocket.Socket.Connections[Index].RemoteAddress + ': ' + E.Message);
          Memo_Log.Lines.Add(E.Message);
        end;
      end;
    end;
  Timer_Monitor.Enabled := True;
end;

end.
