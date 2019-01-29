unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WinInet, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, StdCtrls, ShellApi, ComCtrls, IdAntiFreezeBase, IdAntiFreeze;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    IdHTTP1: TIdHTTP;
    Button1: TButton;
    ProgressBar1: TProgressBar;
    Label4: TLabel;
    Label5: TLabel;
    IdAntiFreeze1: TIdAntiFreeze;
    Memo1: TMemo;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure IdHTTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  dwConnectionTypes : DWORD;
  version: string;
  HTTP : TidHTTP;
  Stream:TMemoryStream;
  fl_size:int64;
  BytesToTransfer: Int64;
  server_name:string;
  function update_chek:boolean;
  function IsConnectedToInternet: Boolean;
  function CheckInternetConnection(Host: string='google.com'; Port: integer=80; Timeout: integer=1000): boolean;


implementation

uses  unMain;

{$R *.dfm}

function IsConnectedToInternet: Boolean;
begin
  dwConnectionTypes := INTERNET_CONNECTION_MODEM + INTERNET_CONNECTION_LAN + INTERNET_CONNECTION_PROXY;
  Result := InternetGetConnectedState (@dwConnectionTypes, 0);
end;

function CheckInternetConnection(Host: string='google.com'; Port: integer=80; Timeout: integer=1000): boolean;
  var TCP: TIdTCPClient;
begin
  TCP:=TIdTCPClient.Create(nil);
  try
    TCP.Host:=Host;
    TCP.Port:=Port;
    TCP.ConnectTimeout:=Timeout;
    try
      TCP.Connect;
      Result:=TCP.Connected;
    except
      Result:=false;
    end;
  finally
    TCP.Free;
  end;
end;

procedure TForm3.Button1Click(Sender: TObject);
var
 url,r:WideString;
 i,j:integer;
 temp:array[0..254]of char;
 LoginInfo:TStringList;
begin
  ProgressBar1.Position:=0;
  fl_size:=0 ;
  try
   GetTempPath(254,temp);
   try
    Stream:=TMemoryStream.Create;
    url:=server_name+'/update/DBAuto.ex_';
    for i:=1 to length(url) do
    begin
    if url[i]='.' then
    begin
    j:=i;
    end;
    end;
    r:=copy(url,j+1,length(url));
    IdHTTP1.Get(url,Stream);
    Stream.SaveToFile(ExtractFilePath(ParamStr(0))+'DBAuto.ex_');

    LoginInfo := TStringList.Create;
    sleep(1000);
    try // блок try..except для обработки исключений (ошибок)
      ChDir(ExtractFilePath(ParamStr(0)));
      LoginInfo.Clear;
      LoginInfo.add('@echo off');
      LoginInfo.add('del DBAuto.exe');
      LoginInfo.add('ren DBAuto.ex_ DBAuto.exe');
      LoginInfo.add('DBAuto.exe');
      LoginInfo.add('for /L %%b in (1,1,500) Do @Echo %%b >Nul');
      LoginInfo.add('del update.bat');
      LoginInfo.SaveToFile(ExtractFilePath(ParamStr(0))+'update.bat');


      // запускаем пакетный файл который был создан программой
      ShellExecute(0,'open',pchar(ExtractFilePath(ParamStr(0))+'update.bat'), nil,nil, SW_HIDE);

      // завершаем программу
      ExitProcess(0);
     except

     end;

     LoginInfo.Free;

   finally
    Stream.Free;
   end;
  except
    on e:Exception do
    begin
      Application.Messagebox('Ошибка при обновлении файла','Загрузка обновления..', MB_ICONERROR or mb_ok);
      Stream.Free;
    end;
  end;

  if progressbar1.position=progressbar1.max then begin
    Application.Messagebox('Загрузка обновления прошла успешно.','Загрузка обновления..', mb_iconinformation or mb_ok);
    //ShellExecute(Handle, 'open', 'Update.exe', nil, nil, SW_SHOWNORMAL);
  end;

end;

procedure TForm3.FormCreate(Sender: TObject);
var
 ver,ver_crop: widestring;
 ob: string;
  Razmer : int64;
begin
ProgressBar1.Position:=0;
label3.Caption:=GetMyVersion;
if CheckInternetConnection then
begin
  try
   Memo1.ScrollBars := ssVertical;
   //ob:=IdHTTP1.Get('http://vnikti-dbauto.ucoz.net/update/changelog.txt');
   ob:=IdHTTP1.Get(server_name+'/update/changelog.txt');
   Memo1.Lines.Add(StringReplace(ob, #$A, #$D#$A, [rfReplaceAll]));
   Memo1.SelStart:=0;
   Memo1.SelLength := 0;

   //ver:=IdHTTP1.Get('http://vnikti-dbauto.ucoz.net/update/version.txt');
   ver:=IdHTTP1.Get(server_name+'/update/version.txt');
   ver:=StringReplace(ver, #$A, '', [rfReplaceAll]) ;
   ver:=StringReplace(ver,  #$D#$A, '', [rfReplaceAll]) ;

   label2.Caption:=('Доступна версия: '+ver);
    if ver=label3.Caption then
     begin
       label5.Font.Color:=clGreen;
       label5.Caption:='Версия программы последняя. Обновление не требуется.';
       label5.Visible:=true;
       Label4.Visible:=false;
       button1.Enabled:=false;
     end
    else
     begin // качаем обновление

        label5.Visible:=true;
        button1.Enabled:=true;

        HTTP := TIdHTTP.Create(nil);
        HTTP.Head(server_name+'/update/DBAuto.ex_');
        Razmer := HTTP.Response.ContentLength; //размер файла
        HTTP.Free;
        Razmer := Round (Razmer / 1024);
        label4.Caption:='Размер обновления: '+(IntToStr (Razmer) + ' KB');

     end;
   except
    on e:Exception do
     //-//-//-//-//-//

  end;
 end;
end;

function update_chek:boolean;
var
 ver: widestring;
 url:string;
 HTTP: TIdHTTP;
begin
 try
  // ver:=form3.IdHTTP1.Get('http://vnikti-dbauto.ucoz.net/update/version.txt');
   url:= server_name+ '/update/version.txt'  ;
   HTTP := TIdHTTP.Create(nil);
   ver:=HTTP.Get(url);
   HTTP.Free;
   ver:=StringReplace(ver, #$A, '', [rfReplaceAll]) ;
   ver:=StringReplace(ver,  #$D#$A, '', [rfReplaceAll]) ;
   if ver=GetMyVersion then
     result:=false else result:=true;
   except
    result:=false;
     //-//-//-//-//-//
  end;
end;


procedure TForm3.IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
if BytesToTransfer>0 then
ProgressBar1.Position:=Round((AWorkCount / BytesToTransfer) * 100) ;
end;

procedure TForm3.IdHTTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
BytesToTransfer:=AWorkCountMax;
end;

end.
