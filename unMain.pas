unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, DBCtrls, DB, DBTables, StdCtrls, DBGrids, jpeg,
  ExtCtrls, ADODB,ShlObj, ActiveX, ImgList, IniFiles,ShellAPI,
  DBGridEhGrouping, GridsEh, DBGridEh, ComCtrls, ToolWin,ComObj,
  MemTableDataEh, DataDriverEh, MemTableEh, StdActns,
  ActnList, Mask, DBCtrlsEh, DBLookupEh, IBCustomDataSet, IBQuery,
  IBDatabase, PrnDbgeh, IBSQL, IBScript, IBUpdateSQL, IBUpdateSQLW,
  System.Actions, System.ImageList, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, XMLIntf, XMLDoc, WinSock, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.VCLUI.Error, FireDAC.Comp.UI,
  FireDAC.FMXUI.Error, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TfmMain = class (TForm)
    ImageList1: TImageList;
    TimerReserv: TTimer;
    StatusBar1: TStatusBar;
    ActionList1: TActionList;
    FileNew1: TAction;
    FileOpen1: TAction;
    FileClose1: TWindowClose;
    FileSave1: TAction;
    FileSaveAs1: TAction;
    FileExit1: TAction;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    WindowCascade1: TWindowCascade;
    WindowTileHorizontal1: TWindowTileHorizontal;
    WindowTileVertical1: TWindowTileVertical;
    WindowMinimizeAll1: TWindowMinimizeAll;
    WindowArrangeAll1: TWindowArrange;
    HelpAbout1: TAction;
    ImageList2: TImageList;
    WindowClose1: TWindowClose;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    tbDirections: TToolButton;
    ToolButton1: TToolButton;
    tbStations: TToolButton;
    tbTimetable: TToolButton;
    tbLimits: TToolButton;
    tbSvet: TToolButton;
    tbPrep: TToolButton;
    tbImport: TToolButton;
    tbFolder: TToolButton;
    ToolButton9: TToolButton;
    tbRefresh: TToolButton;
    OpenDialog1: TOpenDialog;
    ToolBar2: TToolBar;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    WindowCloseAll: TAction;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    tbGraph: TToolButton;
    ToolButton8: TToolButton;
    tbShift: TToolButton;
    ToolButton11: TToolButton;
    tbProf: TToolButton;
    IBDB_Main: TIBDatabase;
    dsDirections: TDataSource;
    IBSQL: TIBSQL;
    btn1: TToolButton;
    IBDS_Limits: TIBDataSet;
    dsLimits: TDataSource;
    ibqrySAVE: TIBQuery;
    IBDS_Trains: TIBDataSet;
    dsTrains: TDataSource;
    IBDS_TrainsID: TIntegerField;
    IBDS_TrainsDIR_KEY: TIntegerField;
    IBDS_TrainsNUMBER: TIntegerField;
    IBDS_LimitsID: TIntegerField;
    IBDS_LimitsBEG_KM: TIntegerField;
    IBDS_LimitsBEG_PK: TIntegerField;
    IBDS_LimitsEND_KM: TIntegerField;
    IBDS_LimitsEND_PK: TIntegerField;
    IBDS_LimitsSPEED: TSmallintField;
    IBDS_LimitsNOTE: TIBStringField;
    IBDS_LimitsDIR_KEY: TIntegerField;
    IBDS_LimitsSHIFT_KEY: TIntegerField;
    IBDS_LimitsLIN_KOORD: TLargeintField;
    IBDS_LimitsLIN_BEG_KM: TLargeintField;
    IBDS_LimitsLIN_BEG_PK: TLargeintField;
    IBDS_LimitsLIN_END_KM: TLargeintField;
    IBDS_LimitsLIN_END_PK: TLargeintField;
    IBDS_TIME_TABLE: TIBDataSet;
    dsTime_Table: TDataSource;
    IBDS_TIME_TABLEID: TIntegerField;
    IBDS_TIME_TABLETRAIN_KEY: TIntegerField;
    IBDS_TIME_TABLESTATION_KEY: TIntegerField;
    IBDS_TIME_TABLEHOURS: TIntegerField;
    IBDS_TIME_TABLEMINUTS: TIntegerField;
    IBDS_TIME_TABLESTOP: TIntegerField;
    IBDS_TIME_TABLEKOORD: TIntegerField;
    IBDS_TIME_TABLELIN_KOORD: TLargeintField;
    IBQR_TEMP2: TIBQuery;
    IBTR_WRITE: TIBTransaction;
    IBTR_READ: TIBTransaction;
    IBDS_Directions: TIBDataSet;
    IBDS_DirectionsID: TIntegerField;
    IBDS_DirectionsFNAME: TIBStringField;
    IBDS_DirectionsCODE: TIntegerField;
    IBDS_DirectionsWAY: TIntegerField;
    IBDS_DirectionsFLAG: TSmallintField;
    IBQR_TEMP: TIBQuery;
    IBTR_TEMP: TIBTransaction;
    Refresh: TAction;
    IBDS_Objects: TIBDataSet;
    dsObjects: TDataSource;
    IBDS_ObjectsID: TIntegerField;
    IBDS_ObjectsDIR_KEY: TIntegerField;
    IBDS_ObjectsOBJ_KEY: TIntegerField;
    IBDS_ObjectsKOORD: TIntegerField;
    IBDS_ObjectsSHIFT_KEY: TIntegerField;
    IBDS_ObjectsLIN_KOORD: TLargeintField;
    IBDS_OBJECTS_INFO: TIBDataSet;
    dsObjects_Info: TDataSource;
    IBDS_OBJECTS_INFOID: TIntegerField;
    IBDS_OBJECTS_INFOCODE: TIntegerField;
    IBDS_OBJECTS_INFOFNAME: TIBStringField;
    IBDS_OBJECTS_INFOCODE_STR: TIBStringField;
    IBDS_ObjectsOBJ_NAME: TStringField;
    IBDS_ObjectsID1: TIntegerField;
    IBDS_ObjectsCODE: TIntegerField;
    IBDS_ObjectsFNAME: TIBStringField;
    IBDS_ObjectsCODE_STR: TIBStringField;
    IBUPD_Directions: TIBUpdateSQLW;
    IBUPD_Limits: TIBUpdateSQLW;
    IBUPD_Trains: TIBUpdateSQLW;
    IBUPD_Time_Table: TIBUpdateSQLW;
    IBUPD_Objects: TIBUpdateSQLW;
    TrayIcon1: TTrayIcon;
    IBDS_prof: TIBDataSet;
    IBUPD_PROF: TIBUpdateSQLW;
    ds_Prof: TDataSource;
    IBDS_profID: TIntegerField;
    IBDS_profDIR_KEY: TIntegerField;
    IBDS_profFVALUE: TIntegerField;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    IBDS_profNUMBER: TIntegerField;
    IBDS_DirectionsRAIL_KEY: TIntegerField;
    IBDS_RailWay: TIBDataSet;
    IBDS_RailWayID: TIntegerField;
    IBDS_RailWayFNAME: TIBStringField;
    IBDS_DirectionsRAIL_NAME: TStringField;
    FDC_Base: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDT_READ: TFDTransaction;
    FDQ_TEMP: TFDQuery;
    dsStations: TDataSource;
    IBDS_Stations: TIBDataSet;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    IntegerField5: TIntegerField;
    SmallintField1: TSmallintField;
    IBStringField1: TIBStringField;
    IntegerField6: TIntegerField;
    IntegerField7: TIntegerField;
    LargeintField1: TLargeintField;
    LargeintField2: TLargeintField;
    LargeintField3: TLargeintField;
    LargeintField4: TLargeintField;
    LargeintField5: TLargeintField;
    IBDS_Light_Signals: TIBDataSet;
    IntegerField8: TIntegerField;
    IntegerField9: TIntegerField;
    IntegerField10: TIntegerField;
    IntegerField11: TIntegerField;
    IntegerField12: TIntegerField;
    SmallintField2: TSmallintField;
    IBStringField2: TIBStringField;
    IntegerField13: TIntegerField;
    IntegerField14: TIntegerField;
    LargeintField6: TLargeintField;
    LargeintField7: TLargeintField;
    LargeintField8: TLargeintField;
    LargeintField9: TLargeintField;
    LargeintField10: TLargeintField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure tbDirectionsClick(Sender: TObject);
    procedure tbImportClick(Sender: TObject);
    procedure tbFolderClick(Sender: TObject);
    procedure tbRefreshClick(Sender: TObject);
    procedure tbStationsClick(Sender: TObject);
    procedure tbTimetableClick(Sender: TObject);
    procedure tbLimitsClick(Sender: TObject);
    procedure tbPrepClick(Sender: TObject);
    procedure tbSvetClick(Sender: TObject);
    procedure WindowCloseAllExecute(Sender: TObject);
    procedure WindowCloseAllUpdate(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure tbGraphClick(Sender: TObject);
    procedure tbShiftClick(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure tbProfClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure IBDS_LimitsBeforePost(DataSet: TDataSet);
    procedure IBDS_Light_SignalsBeforePost(DataSet: TDataSet);
    procedure IBDS_StationsBeforePost(DataSet: TDataSet);
    procedure IBDS_TrainsBeforePost(DataSet: TDataSet);
    procedure IBDS_TIME_TABLEBeforePost(DataSet: TDataSet);
    procedure IBDS_StationsAfterPost(DataSet: TDataSet);
    procedure IBDS_DirectionsAfterPost(DataSet: TDataSet);
    procedure IBDS_ObjectsBeforePost(DataSet: TDataSet);
    procedure dsDirectionsDataChange(Sender: TObject; Field: TField);
    procedure N1Click(Sender: TObject);
    procedure IBDS_profBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


type
 WindSettings = record
   visible:boolean;
   height:word ;
   width:word ;
   left:integer ;
   top:integer ;
 end;

type
  ENoDataException=class(Exception);
  EDataErrorException=class(Exception);

var
  fmMain: TfmMain;
  Draging: Boolean;
  X0, Y0: integer;
  SQL_DIR:string;
  reserv_path: string;
  reserv_mode: Byte;
  reserv_time: Byte;
  reserv_count: Byte;
  cl_BackGround:TColor;
  cl_Axis:TColor;
  cl_AxisText:TColor;
  cl_Limit:TColor;
  cl_LimitText:TColor;
  cl_Uklon:TColor;
  cl_Station:TColor;
  cl_StationText:TColor;
  cl_svet,cl_svettext: TColor;
  w_Axis:byte=1;
  t_Axis:byte=14;
  w_limit:byte=1;
  t_limit:byte=14;
  w_station:byte=1;
  t_station:byte=14;
  w_svet:byte=1;
  t_svet:byte=14;
  //настройки для окон
  DirSettings,StSettings,TTSettings,LimSettings,SigSettings,ObjSettings, ProfSettings:   WindSettings;

 function AdvBrowseDirectory(sCaption: String; wsRoot: WideString; var sDirectory: String; bEditBox: Boolean = False; bShowFiles: Boolean = False; bAllowCreateDirs: Boolean = True; bRootIsMyComp: Boolean = False): Boolean;
 function GetFileDate(TheFileName: string): string;
 function GetFileSize(FileName: String): Integer;
 function GetMyVersion:string;
 procedure DS_Refresh(ADS: TDataSet; const AShowHourGlass: Boolean = True);
 procedure DS_Refresh_All;
 procedure Init;
 function OpenParadoxDB(impDBpath: string; form: TComponent): TQuery;
 procedure CreateFileDir(var file_name, file_path:String);


implementation

uses unDirection, unStations, unLimits, unTrains, unTimeTable, unVars,
  unPrep, unAbout, unSvet, unProf, unSetup, unImport,
  unShift, Unit3, unUpdate, unGraph;

function GetCompName(const IPAddr: String): String;
 var
  WSAData: TWSAData;
  SocketAddr: TSockAddr;
  HostEnt: PHostEnt;
   Err: Integer;
begin
try
  Result := '';
  Err:=WSAStartup($0101, WSAData);
  if Err<>0 then
     begin
       ShowMessage(SysErrorMessage(GetLastError));
       exit;
     end;

  SocketAddr.sin_addr.S_addr := inet_addr(PAnsiChar(AnsiString(IPAddr)));
  HostEnt := gethostbyaddr(@SocketAddr.sin_addr.S_addr, 4, AF_INET);
  if HostEnt <> nil then
    Result := string(HostEnt^.h_name)
  else
    Result := '';
  finally
    WSACleanup;
  end;

end;

// открытие БД PARADOX для импорта
function OpenParadoxDB(impDBpath: string; form: TComponent): TQuery;
var
  i:word; s: string;
  impDBname:string;
begin

  //определение пути и имени импортируемой БД
  s:='';
  for i:=Length(impDBpath) downto 0 do
  if impDBpath[i]<>'\' then s:=s+impDBpath[i] else Break;
  Delete(impDBpath,Length(impDBpath)+1-Length(s),Length(s));
  delete(s,1,3);
  impDBname:='';
  for i:=Length(s) downto 1 do impDBname:=impDBname+s[i];

  //открытие импортируемой БД
  try
   result:= TQuery.Create(form);
    with result do
    begin
     Close;
     DatabaseName:=impDBpath;
     Active:=false;
     SQL.Clear;
     SQL.Add('SELECT *');
     SQL.Add('FROM "'+impDBname+'"');
     Active:=true;
    end;
  except
   on E: Exception do
     begin
     if result.Active then  result.Close;
     result.Destroy;
     Application.MessageBox(PWideChar('Ошибка при открытии файла '+impDBname+'.DB:'+#13+#13+E.Message),
                                'Редактор базы данных автоведения',
                                MB_OK + MB_ICONERROR);
     result:= nil;
     exit;
    end;
   end;
end;

//создание папки для файла и возврат имени папки и пути
procedure CreateFileDir(var file_name, file_path:String);
var
 dir, put: word;
begin
   dir:=fmDirection.FDQ_DIR.FieldByName('Code').Value;
   put:=fmDirection.FDQ_DIR.FieldByName('WAY').Value;
   file_name:='';
   if dir<10  then file_name:='0'+IntToStr(dir) else  file_name:=IntToStr(dir);
   file_name:=file_name+'p'+inttostr(put);
   file_path:=extractfilepath(application.ExeName)+'files\'+
                             fmDirection.FDQ_DIR.FieldByName('Code').AsString+' '+
                             fmDirection.FDQ_DIR.FieldByName('FName').AsString;
   if not DirectoryExists(file_path) then  CreateDir(file_path);
end;


// инициализация программы
procedure Init;
var
FD_Protocol, FB_Server, FB_Path:string;
  str:string;
  err_code:Byte;
LDocument: IXMLDocument;
LNodeRoot, LNodeChild, LNode: IXMLNode;
i: word;
begin
   //читаем файл настроек
    try
      LDocument := TXMLDocument.Create(nil);
      LDocument.LoadFromFile(extractfilepath(application.ExeName)+'Setup.xml');
      LNodeRoot := LDocument.ChildNodes.FindNode('Setup');
      if (LNodeRoot <> nil) then
       begin
        for i := 0 to LNodeRoot.ChildNodes.Count - 1 do
        begin
          LNodeChild := LNodeRoot.ChildNodes.Get(I);
         if LNodeChild.NodeName='Graph' then
          begin
           LNode:= LNodeChild.ChildNodes.Nodes['Background'];
           if LNode.HasAttribute('Color') then cl_BackGround := LNode.Attributes['Color'];

            LNode:= LNodeChild.ChildNodes.Nodes['Profil'];
           if LNode.HasAttribute('Color') then cl_Uklon := LNode.Attributes['Color'];

           LNode:= LNodeChild.ChildNodes.Nodes['Axis'];
           if LNode.HasAttribute('TextHeight') then t_Axis := LNode.Attributes['TextHeight'];
           if LNode.HasAttribute('TextColor') then  cl_AxisText := LNode.Attributes['TextColor'];
           if LNode.HasAttribute('LineWidth') then  w_Axis := LNode.Attributes['LineWidth'];
           if LNode.HasAttribute('LineColor') then  cl_Axis := LNode.Attributes['LineColor'];

           LNode:= LNodeChild.ChildNodes.Nodes['Limits'];
           if LNode.HasAttribute('TextHeight') then   t_Limit := LNode.Attributes['TextHeight'];
           if LNode.HasAttribute('TextColor') then    cl_LimitText := LNode.Attributes['TextColor'];
           if LNode.HasAttribute('LineWidth') then    w_Limit := LNode.Attributes['LineWidth'];
           if LNode.HasAttribute('LineColor') then    cl_Limit := LNode.Attributes['LineColor'];

           LNode:= LNodeChild.ChildNodes.Nodes['Stations'];
           if LNode.HasAttribute('TextHeight') then   t_station := LNode.Attributes['TextHeight'];
           if LNode.HasAttribute('TextColor') then    cl_StationText := LNode.Attributes['TextColor'];
           if LNode.HasAttribute('LineWidth') then    w_station := LNode.Attributes['LineWidth'];
           if LNode.HasAttribute('LineColor') then    cl_Station := LNode.Attributes['LineColor'];

           LNode:= LNodeChild.ChildNodes.Nodes['LightSignals'];
           if LNode.HasAttribute('TextHeight') then   t_svet := LNode.Attributes['TextHeight'];
           if LNode.HasAttribute('TextColor') then    cl_svettext := LNode.Attributes['TextColor'];
           if LNode.HasAttribute('LineWidth') then    w_svet := LNode.Attributes['LineWidth'];
           if LNode.HasAttribute('LineColor') then    cl_svet := LNode.Attributes['LineColor'];
          end;

           if LNodeChild.NodeName='FB' then
          begin
           LNode:= LNodeChild.ChildNodes.Nodes['Connection'];
           if LNode.HasAttribute('Protocol') then FD_Protocol := LNode.Attributes['Protocol'];
           if LNode.HasAttribute('Server') then FB_Server := LNode.Attributes['Server'];
           if LNode.HasAttribute('Path') then FB_Path := LNode.Attributes['Path'];
          end;

            if LNodeChild.NodeName='Update' then
          begin
           LNode:= LNodeChild.ChildNodes.Nodes['Host'];
           if LNode.HasAttribute('Name') then server_name := LNode.Attributes['Name'];
          end;

             if LNodeChild.NodeName='Windows' then
          begin
           LNode:= LNodeChild.ChildNodes.Nodes['Directions'];
           if LNode.HasAttribute('visible') then DirSettings.visible   := LNode.Attributes['visible'];
           if LNode.HasAttribute('height')  then DirSettings.height    := LNode.Attributes['height'];
           if LNode.HasAttribute('width')   then DirSettings.width     := LNode.Attributes['width'];
           if LNode.HasAttribute('left')    then DirSettings.left      := LNode.Attributes['left'];
           if LNode.HasAttribute('top')     then DirSettings.top       := LNode.Attributes['top'];

           LNode:= LNodeChild.ChildNodes.Nodes['Stations'];
           if LNode.HasAttribute('visible') then StSettings.visible   := LNode.Attributes['visible'];
           if LNode.HasAttribute('height')  then StSettings.height    := LNode.Attributes['height'];
           if LNode.HasAttribute('width')   then StSettings.width     := LNode.Attributes['width'];
           if LNode.HasAttribute('left')    then StSettings.left      := LNode.Attributes['left'];
           if LNode.HasAttribute('top')     then StSettings.top       := LNode.Attributes['top'];

           LNode:= LNodeChild.ChildNodes.Nodes['TimeTable'];
           if LNode.HasAttribute('visible') then TTSettings.visible   := LNode.Attributes['visible'];
           if LNode.HasAttribute('height')  then TTSettings.height    := LNode.Attributes['height'];
           if LNode.HasAttribute('width')   then TTSettings.width     := LNode.Attributes['width'];
           if LNode.HasAttribute('left')    then TTSettings.left      := LNode.Attributes['left'];
           if LNode.HasAttribute('top')     then TTSettings.top       := LNode.Attributes['top'];

            LNode:= LNodeChild.ChildNodes.Nodes['Limits'];
           if LNode.HasAttribute('visible') then LimSettings.visible   := LNode.Attributes['visible'];
           if LNode.HasAttribute('height')  then LimSettings.height    := LNode.Attributes['height'];
           if LNode.HasAttribute('width')   then LimSettings.width     := LNode.Attributes['width'];
           if LNode.HasAttribute('left')    then LimSettings.left      := LNode.Attributes['left'];
           if LNode.HasAttribute('top')     then LimSettings.top       := LNode.Attributes['top'];

            LNode:= LNodeChild.ChildNodes.Nodes['Objects'];
           if LNode.HasAttribute('visible') then ObjSettings.visible   := LNode.Attributes['visible'];
           if LNode.HasAttribute('height')  then ObjSettings.height    := LNode.Attributes['height'];
           if LNode.HasAttribute('width')   then ObjSettings.width     := LNode.Attributes['width'];
           if LNode.HasAttribute('left')    then ObjSettings.left      := LNode.Attributes['left'];
           if LNode.HasAttribute('top')     then ObjSettings.top       := LNode.Attributes['top'];

           LNode:= LNodeChild.ChildNodes.Nodes['Signals'];
           if LNode.HasAttribute('visible') then SigSettings.visible   := LNode.Attributes['visible'];
           if LNode.HasAttribute('height')  then SigSettings.height    := LNode.Attributes['height'];
           if LNode.HasAttribute('width')   then SigSettings.width     := LNode.Attributes['width'];
           if LNode.HasAttribute('left')    then SigSettings.left      := LNode.Attributes['left'];
           if LNode.HasAttribute('top')     then SigSettings.top       := LNode.Attributes['top'];

           LNode:= LNodeChild.ChildNodes.Nodes['Profile'];
           if LNode.HasAttribute('visible') then ProfSettings.visible   := LNode.Attributes['visible'];
           if LNode.HasAttribute('height')  then ProfSettings.height    := LNode.Attributes['height'];
           if LNode.HasAttribute('width')   then ProfSettings.width     := LNode.Attributes['width'];
           if LNode.HasAttribute('left')    then ProfSettings.left      := LNode.Attributes['left'];
           if LNode.HasAttribute('top')     then ProfSettings.top       := LNode.Attributes['top'];

          end;
           LDocument.Active:=false;
        end;
      end;
    except
      Application.MessageBox(Pchar('Ошибка при чтении файла настроек:'+#13+extractfilepath(application.ExeName)+'Setup.xml'), 'Ошибка', MB_OK
      + MB_ICONSTOP + MB_TOPMOST);

    end;  
  try
    //конфигурируем параметры БД
    fmMain.FDPhysFBDriverLink1.VendorLib:= extractfilepath(application.ExeName)+'fbclient\fbclient.dll';
    with fmMain.FDC_Base.Params do begin
      Clear;
      Add('User_Name=sysdba');
      Add('Password=masterkey');
      Add('Database='+FB_Path+'BASE.FDB');
      Add('Protocol='+FD_Protocol);
      Add('Server='+FB_Server);
      Add('DriverID=FB');
    end;
    fmMain.FDC_Base.Connected:=true;
    fmMain.FDT_READ.Options.AutoStart:=false;
    fmMain.FDT_READ.StartTransaction;

   importGrid:=TStringGrid.Create(fmMain);

    fmMain.StatusBar1.Panels[1].Text:= GetCompName(FB_Server)+' '+FB_Path+'BASE.FDB';
  except
    Application.MessageBox('Ошибка при открытии базы данных.', 'Внимание!', MB_OK
    + MB_ICONSTOP + MB_TOPMOST);
    Application.Terminate;
  end;

  SQL_DIR:=extractfilepath(application.ExeName)+'SQL\';

  fmMain.TrayIcon1.Visible := True;
  fmMain.TrayIcon1.Animate := True;
  fmMain.TrayIcon1.ShowBalloonHint;

  GetMyVersion;

  if CheckInternetConnection then
   begin
     if (update_check<>'')  then
         fmMain.TrayIcon1.BalloonHint:='Доступна новая версия программы для обновления';
   end
  else  fmMain.TrayIcon1.BalloonHint:='Нет соединения с интернетом';

  //папки для работы с PARADOX
   if not DirectoryExists( ExtractFilePath(ParamStr(0))+ 'NET') then
        CreateDir(PChar(ExtractFilePath(ParamStr(0))+ 'NET'));
   Session.NetFileDir := ExtractFilePath(ParamStr(0)) + 'NET';

end;

procedure DS_Refresh(ADS: TDataSet;const AShowHourGlass: Boolean = True);
var
   FID: Variant;
begin
   ADS.DisableControls;
   if AShowHourGlass then Screen.Cursor := crHourGlass;
   try
     FID := ADS.fieldbyname('ID').AsVariant;
     if ADS.Active then ADS.Close;
     ADS.Open;
     ADS.Locate('ID', FID, []);
   finally
     ADS.EnableControls;
     if AShowHourGlass then Screen.Cursor := crDefault;
   end;
end;

//Обновление таблиц
procedure DS_Refresh_All;
var
  r_count:Byte;
  SQL_str:string;
begin
  with fmMain do
  begin
   if IBDS_Directions.State in [dsEdit]         then  IBDS_Directions.Post;
   if  IBDS_Limits.State in [dsEdit]            then  IBDS_Limits.Post;
   if  IBDS_Trains.State in [dsEdit]            then  IBDS_Trains.Post;
   if  IBDS_TIME_TABLE.State in [dsEdit]        then  IBDS_TIME_TABLE.Post;
   if  IBDS_prof.State in [dsEdit]              then  IBDS_prof.Post;


   if ((fmMain.IBDS_DirectionsWAY.Value=2)  and (fmMain.IBDS_DirectionsFLAG.Value=1)) or
   ((fmMain.IBDS_DirectionsWAY.Value=1)  and (fmMain.IBDS_DirectionsFLAG.Value=0)) then Way:=2 else Way:=1;

   if Way=2 then fmMain.IBDS_TIME_TABLE.SelectSQL.Strings[fmMain.IBDS_TIME_TABLE.SelectSQL.count-1]:='ORDER BY S.KOORD' else
                 fmMain.IBDS_TIME_TABLE.SelectSQL.Strings[fmMain.IBDS_TIME_TABLE.SelectSQL.count-1]:='ORDER BY S.KOORD DESC';

  // DS_Refresh(IBDS_Stations);
   DS_Refresh(IBDS_Trains);
   DS_Refresh(IBDS_TIME_TABLE);
   DS_Refresh(IBDS_Limits);
  // DS_Refresh(IBDS_Light_Signals);
   DS_Refresh(IBDS_Objects);
   DS_Refresh(IBDS_prof);
   DS_Refresh(IBDS_Directions);

   //if IBDS_DirectionsID.Value=null then Exit;
  // DIR_ID:=IntToStr(IBDS_DirectionsID.Value);
//   ibds_time_tableST_name.RefreshLookupList;
   FillData4Graph;
   if fmGraph<>nil then fmGraph.PaintBox1.Repaint;
  // IBDS_Directions.AfterScroll:=IBDS_DirectionsAfterScroll;
  end;
end;



procedure import_convert;
begin
{  with fmMain.qtTemp do
  begin
   Close;
   Active:=false;
   SQL.Clear;
   SQL.Add('Select * FROM Directions');
   SQL.Add('Order by Direction');
   Active:=true;
   First;
  end;
  while not fmMain.qtTemp.Eof do
  begin
    fmMain.IBDS_Directions.Insert;
    fmMain.IBDS_Directions.FieldByName('ID').Value:=fmMain.qtTemp.FieldValues['Dir_ID'];
    fmMain.IBDS_Directions.FieldByName('FNAME').Value:=fmMain.qtTemp.FieldValues['NAme'];
    fmMain.IBDS_Directions.FieldByName('CODE').Value:=fmMain.qtTemp.FieldValues['Direction'];
    fmMain.IBDS_Directions.FieldByName('WAY').Value:=fmMain.qtTemp.FieldValues['Way'];
    if fmMain.qtTemp.FieldValues['Flag']=True then
    fmMain.IBDS_Directions.FieldByName('FLAG').Value:=1 else    fmMain.IBDS_Directions.FieldByName('FLAG').Value:=0;
    fmMain.IBDS_Directions.Post;
    fmMain.qtTemp.Next;
  end;     }
{  with fmMain.qtTemp do
  begin
   Close;
   Active:=false;
   SQL.Clear;
   SQL.Add('Select * FROM Limits');
   Active:=true;
   First;
  end;
  while not fmMain.qtTemp.Eof do
  begin
    fmMain.IBDS_Limits.Insert;
    fmMain.IBDS_Limits.FieldByName('BEG_KM').Value:=fmMain.qtTemp.FieldValues['KBeg'];
    fmMain.IBDS_Limits.FieldByName('BEG_PK').Value:=fmMain.qtTemp.FieldValues['PBeg'];
    fmMain.IBDS_Limits.FieldByName('END_KM').Value:=fmMain.qtTemp.FieldValues['KEnd'];
    fmMain.IBDS_Limits.FieldByName('END_PK').Value:=fmMain.qtTemp.FieldValues['PEnd'];
    fmMain.IBDS_Limits.FieldByName('SPEED').Value:=fmMain.qtTemp.FieldValues['SPEED'];
    fmMain.IBDS_Limits.FieldByName('NOTE').Value:=fmMain.qtTemp.FieldValues['NOTE'];
    fmMain.IBDS_LimitsDIR_KEY.Value:=fmMain.qtTemp.FieldValues['DIR_KEY'];
    fmMain.IBDS_Limits.FieldByName('SHIFT_KEY').Value:=fmMain.qtTemp.FieldValues['SHIFT_KEY'];
    fmMain.IBDS_Limits.Post;
    fmMain.qtTemp.Next;
  end;  }
{  with fmMain.qtTemp do
  begin
   Close;
   Active:=false;
   SQL.Clear;
   SQL.Add('Select * FROM Svet');
   Active:=true;
   First;
  end;
  while not fmMain.qtTemp.Eof do
  with fmMain.IBDS_Light_Signals do
  begin
    Insert;
    FieldByName('FNAME').Value:=fmMain.qtTemp.FieldValues['Name'];
    FieldByName('Koord').Value:=fmMain.qtTemp.FieldValues['Koord'];
    FieldByName('Speed').Value:=fmMain.qtTemp.FieldValues['Speed'];
    FieldByName('DIR_KEY').Value:=fmMain.qtTemp.FieldValues['DIR_KEY'];
   // FieldByName('SHIFT_KEY').Value:=fmMain.qtTemp.FieldValues['SHIFT_KEY'];
    Post;
    fmMain.qtTemp.Next;
  end;     }
{  with fmMain.qtTemp do
  begin
   Close;
   Active:=false;
   SQL.Clear;
   SQL.Add('Select * FROM STATIONS');
   Active:=true;
   First;
  end;
  while not fmMain.qtTemp.Eof do
  with fmMain.IBDS_Stations do
  begin
    Insert;
    FieldByName('ID').Value:=fmMain.qtTemp.FieldValues['ST_ID'];
    FieldByName('FNAME').Value:=fmMain.qtTemp.FieldValues['Name'];
    FieldByName('Koord').Value:=fmMain.qtTemp.FieldValues['Koord'];
    FieldByName('BEG_KM').Value:=fmMain.qtTemp.FieldValues['BEG_KM'];
    FieldByName('BEG_PK').Value:=fmMain.qtTemp.FieldValues['BEG_PK'];
    FieldByName('END_KM').Value:=fmMain.qtTemp.FieldValues['END_KM'];
    FieldByName('END_PK').Value:=fmMain.qtTemp.FieldValues['END_PK'];
    FieldByName('SPEED').Value:=fmMain.qtTemp.FieldValues['SPEED'];
    FieldByName('DIR_KEY').Value:=fmMain.qtTemp.FieldValues['DIR_KEY'];
    FieldByName('SHIFT_KEY').Value:=fmMain.qtTemp.FieldValues['SHIFT_KEY'];
    Post;
    fmMain.qtTemp.Next;
  end;  }
{ with fmMain.qtTemp do
  begin
   Close;
   Active:=false;
   SQL.Clear;
   SQL.Add('Select * FROM TRAINS');
   Active:=true;
  // First;
  end;
  while not fmMain.qtTemp.Eof do
  with fmMain.IBDS_Trains do
  begin
    Insert;
    FieldByName('ID').Value:=fmMain.qtTemp.FieldValues['train_ID'];
    FieldByName('Number').Value:=fmMain.qtTemp.FieldValues['Number'];
    FieldByName('DIR_KEY').Value:=fmMain.qtTemp.FieldValues['DIR_KEY'];
    Post;
    fmMain.qtTemp.Next;
  end;       }
{ with fmMain.qtTemp do
  begin
   Close;
   Active:=false;
   SQL.Clear;
   SQL.Add('Select * FROM TIMETABLE');
   Active:=true;
  // First;
  end;
  while not fmMain.qtTemp.Eof do
  with fmMain.IBDS_TIME_TABLE do
  begin
    Insert;
    FieldByName('ID').Value:=fmMain.qtTemp.FieldValues['TT_ID'];
    FieldByName('TRAIN_KEY').Value:=fmMain.qtTemp.FieldValues['Train_KEY'];
    FieldByName('STATION_KEY').Value:=fmMain.qtTemp.FieldValues['ST_KEY'];
    FieldByName('HOURS').Value:=fmMain.qtTemp.FieldValues['HOURS'];
    FieldByName('MINUTS').Value:=fmMain.qtTemp.FieldValues['MINUTS'];
    FieldByName('STOP').Value:=fmMain.qtTemp.FieldValues['STOP'];
    Post;
    fmMain.qtTemp.Next;
  end;
 DS_Refresh_All;   }
end;

procedure Tfmmain.CreateParams(var Params: TCreateParams);
const
   CS_DROPSHADOW = $00020000;
begin
   inherited;
   Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;
end;

procedure TfmMain.dsDirectionsDataChange(Sender: TObject; Field: TField);
begin
 {заплатка от бага отображения lookup поля станций и автоматическая сортировка
  в зависимости от номера пути и "признака правильности"}

 if DIR_ID=fmMain.IBDS_DirectionsID.value.ToString then  exit else
 DIR_ID:=fmMain.IBDS_DirectionsID.value.ToString;


  if ((fmMain.IBDS_DirectionsWAY.Value=2)  and (fmMain.IBDS_DirectionsFLAG.Value=1)) or
 ((fmMain.IBDS_DirectionsWAY.Value=1)  and (fmMain.IBDS_DirectionsFLAG.Value=0)) then Way:=2 else Way:=1;

 if Way=2 then fmMain.IBDS_TIME_TABLE.SelectSQL.Strings[fmMain.IBDS_TIME_TABLE.SelectSQL.count-1]:='ORDER BY S.KOORD' else
               fmMain.IBDS_TIME_TABLE.SelectSQL.Strings[fmMain.IBDS_TIME_TABLE.SelectSQL.count-1]:='ORDER BY S.KOORD DESC';
 DS_Refresh(IBDS_TIME_TABLE);
 DS_Refresh(IBDS_Trains);
 FillData4Graph;
 if fmGraph<>nil then fmGraph.PaintBox1.Repaint;
  //StatusBar1.Panels[1].Text:=IntToStr(fmMain.ibds_DirectionsWAY.Value);
end;

function AdvBrowseDirectory(sCaption: String; wsRoot: WideString; var sDirectory: String; bEditBox: Boolean = False; bShowFiles: Boolean = False; bAllowCreateDirs: Boolean = True; bRootIsMyComp: Boolean = False): Boolean;

  // callback функция, которая вызывается при инициализации диалога
  // или когда создается новая папка

  function SelectDirCB(Wnd: HWND; uMsg: UINT; lParam, lpData: lParam): Integer; stdcall;
	//var
		//PathName: array[0..MAX_PATH] of Char;
  begin
    case uMsg of
      BFFM_INITIALIZED: SendMessage(Wnd, BFFM_SETSELECTION, Ord(True), Integer(lpData));
      // включите этот код, если хотите реагировать на выбор новой папки
      {BFFM_SELCHANGED: 
      begin
        SHGetPathFromIDList(PItemIDList(lParam), @PathName); 
        // папка "PathName" была выбрана
      end;}
     end;
     Result := 0;
   end;
var
  WindowList: Pointer;
  BrowseInfo: TBrowseInfo;
  Buffer: PChar;
  RootItemIDList, ItemIDList: PItemIDList;
  ShellMalloc: IMalloc;
  IDesktopFolder: IShellFolder;
  Eaten, Flags: LongWord;

const
  BIF_USENEWUI = $0040;
  BIF_NOCREATEDIRS = $0200;

begin
  Result := False;
  if not DirectoryExists(sDirectory) then sDirectory := '';
  FillChar(BrowseInfo, SizeOf(BrowseInfo), 0);
  if (ShGetMalloc(ShellMalloc) = S_OK) and (ShellMalloc <> nil) then
  begin
    Buffer := ShellMalloc.Alloc(MAX_PATH);
    try
      RootItemIDList := nil;
      if wsRoot <> '' then
      begin
        SHGetDesktopFolder(IDesktopFolder);
        IDesktopFolder.ParseDisplayName(Application.Handle, nil,
        POleStr(wsRoot), Eaten, RootItemIDList, Flags);
			end
			else
			begin

				if bRootIsMyComp then
					SHGetSpecialFolderLocation(0, CSIDL_DRIVES, RootItemIDList);

			end;
      OleInitialize(nil);
      with BrowseInfo do
      begin
        hwndOwner := Application.Handle;
				pidlRoot := RootItemIDList;
        pszDisplayName := Buffer;
				lpszTitle := PChar(sCaption);
        // определяет то, как диалог будет появляться:
        ulFlags :=
          BIF_RETURNONLYFSDIRS or
          BIF_USENEWUI or
					BIF_EDITBOX * Ord(bEditBox) or
					BIF_BROWSEINCLUDEFILES * Ord(bShowFiles) or
					BIF_NOCREATEDIRS * Ord(not bAllowCreateDirs);
        lpfn    := @SelectDirCB;
        if sDirectory <> '' then lParam := Integer(PChar(sDirectory));
      end;
      WindowList := DisableTaskWindows(0);
      try
        ItemIDList := ShBrowseForFolder(BrowseInfo);
      finally
        EnableTaskWindows(WindowList);
      end;
      Result := ItemIDList <> nil;
      if Result then
      begin
        ShGetPathFromIDList(ItemIDList, Buffer);
        ShellMalloc.Free(ItemIDList);
        sDirectory := Buffer;
      end;
    finally
      ShellMalloc.Free(Buffer);
    end;
  end;
end;

function GetMyVersion:string;
type
  TVerInfo=packed record
    Nevazhno: array[0..47] of byte;
    Minor,Major,Build,Release: word;
  end;
var
  s:TResourceStream;
  v:TVerInfo;
  f:TextFile;
begin
  result:='';
  try
    s:=TResourceStream.Create(HInstance,'#1',RT_VERSION);
    if s.Size>0 then begin
      s.Read(v,SizeOf(v));
      result:=IntToStr(v.Major)+'.'+IntToStr(v.Minor)+'.'+
              IntToStr(v.Release)+'.'+IntToStr(v.Build);
    end;
  s.Free;
    AssignFile(f, 'version.txt');
    rewrite(f);
    Writeln(f, result);
    Flush(f);
    CloseFile(f);

  except; end;
end;


{$R *.dfm}

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
i:integer;
begin
//завершаем транзакцию для чтения
 if FDT_READ.Active then FDT_READ.Commit;

{ IBTR_READ.Commit;
 IBDB_Main.CloseDataSets;
 IBDB_Main.Connected:=False;  }
 importGrid.Free;
 TrayIcon1.Visible := false;
 for i:= 0 to MdiChildCount - 1 do
  MDIChildren[i].Close;
// if reserv_mode=1 then Reserv_DB;
end;

procedure TfmMain.tbDirectionsClick(Sender: TObject);
begin
 if tbDirections.Down=true then  begin
 if fmDirection=nil
 then
  begin
       fmDirection := TfmDirection.Create(Application);
       fmDirection.Width:=DirSettings.width;
       fmDirection.Height:=DirSettings.Height;
       fmDirection.Left:=DirSettings.Left;
       fmDirection.Top:=DirSettings.Top;
        //открываем набор данных
        fmDirection.FDQ_DIR.Open;
  end;
 end   else fmDirection.Close;
end;

procedure TfmMain.tbFolderClick(Sender: TObject);
var
  str:string;
begin
 str:=extractfilepath(application.ExeName)+'files\'+
                             fmDirection.FDQ_DIR.FieldByName('Code').AsString+' '+
                             fmDirection.FDQ_DIR.FieldByName('FName').AsString;
 if not DirectoryExists(str) then  CreateDir(str);
 ShellExecute(0, 'open', PWideChar(str), nil, nil, SW_SHOWNORMAL);
end;

procedure TfmMain.tbRefreshClick(Sender: TObject);
begin
 DS_Refresh_All;
end;

procedure TfmMain.tbStationsClick(Sender: TObject);
begin
  if tbStations.Down=true then  begin
  if fmStations = nil
    then
    begin
      fmStations := TfmStations.Create(Application);
      fmStations.Width:=StSettings.width;
      fmStations.Height:=StSettings.Height;
      fmStations.Left:=StSettings.Left;
      fmStations.Top:=StSettings.Top;
      //открываем набор данных
       fmStations.FDQ_ST.Open;
    end;
   // else fmStations.BringToFront;
  end else  fmStations.Close;
end;

procedure TfmMain.tbTimetableClick(Sender: TObject);
begin
  if tbTimetable.Down=True then begin
  if fmTimeTable = nil
    then
    begin
       fmTimeTable := TfmTimeTable.Create(Application);
      fmTimeTable.Width:=TTSettings.width;
      fmTimeTable.Height:=TTSettings.Height;
      fmTimeTable.Left:=TTSettings.Left;
      fmTimeTable.Top:=TTSettings.Top;
    end;
   // else fmTimeTable.BringToFront;
  end else fmTimeTable.Close;

 if ((fmMain.IBDS_DirectionsWAY.Value=2)  and (fmMain.IBDS_DirectionsFLAG.Value=1)) or
 ((fmMain.IBDS_DirectionsWAY.Value=1)  and (fmMain.IBDS_DirectionsFLAG.Value=0)) then Way:=2 else Way:=1;

 if Way=2 then fmMain.IBDS_TIME_TABLE.SelectSQL.Strings[fmMain.IBDS_TIME_TABLE.SelectSQL.count-1]:='ORDER BY S.KOORD' else
               fmMain.IBDS_TIME_TABLE.SelectSQL.Strings[fmMain.IBDS_TIME_TABLE.SelectSQL.count-1]:='ORDER BY S.KOORD DESC';
 DS_Refresh(IBDS_TIME_TABLE);
 DS_Refresh(IBDS_Trains);
end;

procedure TfmMain.tbLimitsClick(Sender: TObject);
begin
  if tbLimits.Down=True then begin
  if fmLimits = nil
    then
    begin
      fmLimits := TfmLimits.Create(Application);
      fmLimits.Width:=LimSettings.width;
      fmLimits.Height:=LimSettings.Height;
      fmLimits.Left:=LimSettings.Left;
      fmLimits.Top:=LimSettings.Top;
     //открываем набор данных
     fmLimits.FDQ_LIM.Open;
    end;
  end else fmLimits.Close;
end;

procedure TfmMain.tbPrepClick(Sender: TObject);
begin
  if tbPrep.Down=True then  begin
  if fmPrep = nil
    then
    begin
      fmPrep := TfmPrep.Create(Application);
      fmPrep.Width:=ObjSettings.width;
      fmPrep.Height:=ObjSettings.Height;
      fmPrep.Left:=ObjSettings.Left;
      fmPrep.Top:=ObjSettings.Top;
    end;
//  else fmPrep.BringToFront;
  end else fmPrep.Close;
end;

procedure TfmMain.tbSvetClick(Sender: TObject);
begin
  if tbSvet.Down=True then  begin
  if fmSvet = nil
    then
    begin
      fmSvet := TfmSvet.Create(Application);
      fmSvet.Width:=SigSettings.width;
      fmSvet.Height:=SigSettings.Height;
      fmSvet.Left:=SigSettings.Left;
      fmSvet.Top:=SigSettings.Top;
      //открываем набор данных
       fmSvet.FDQ_SV.Open;
    end;
  end else fmSvet.Close;
end;

procedure TfmMain.tbImportClick(Sender: TObject);
begin
  if tbImport.Down=True then begin
  if fmImport = nil
    then fmImport := TfmImport.Create(Application)
  //  else fmImport.BringToFront;
  end else fmImport.Close;
end;

function GetFileDate(TheFileName: string): string;
var
  FHandle: integer;
begin
  FHandle := FileOpen(TheFileName, 0);
  result := FormatDateTime('dd.mm.yyyy (hh:nn:ss)',FileDateToDateTime(FileGetDate(FHandle)));
  FileClose(FHandle);
end;

function GetFileSize(FileName: String): Integer;
var
  FS: TFileStream;
begin
  try
    FS := TFileStream.Create(Filename, fmOpenRead);
  except
    Result := -1;
  end;
  if Result <> -1 then Result := FS.Size;
  FS.Free;
end;

procedure TfmMain.WindowCloseAllExecute(Sender: TObject);
var i: integer;
begin
for i:= 0 to MdiChildCount - 1 do
  MDIChildren[i].Close;
end;

procedure TfmMain.WindowCloseAllUpdate(Sender: TObject);
var i: integer;
 flag:Boolean;
begin
  flag:=False;
  for i:= 0 to MdiChildCount - 1 do begin flag:=True; Break; end;
  if not flag then fmMain.ToolButton6.Enabled:=False else fmMain.ToolButton6.Enabled:=True;
end;

procedure TfmMain.ToolButton7Click(Sender: TObject);
begin
 fmSetup.ShowModal;
end;

procedure TfmMain.tbGraphClick(Sender: TObject);
var
  LDocument: IXMLDocument;
  LNodeElement, NodeCData, NodeText,LNode: IXMLNode;
  i:word;
   val:string;
begin
   //write
  (*
  LDocument := TXMLDocument.Create(nil);
  LDocument.Active := false;
  with    LDocument do
  begin
   Active := true;
   Version := '1.0';
   Encoding := 'UTF-8';
   options := Options + [doNodeAutoIndent]
  end;
  LDocument.DocumentElement := LDocument.CreateNode('Setup', ntElement, '');
  LNodeElement:= LDocument.DocumentElement.ChildNodes.Nodes['Reservation'] ;
  NodeText:= LNodeElement.AddChild('Mode', 1);
  NodeText.Attributes['Value'] := '0';
  NodeText.Attributes['Count'] := '0';
  LNodeElement := LDocument.DocumentElement.ChildNodes.Nodes['Graph'];
  NodeText:= LNodeElement.AddChild('Background', 1);
  NodeText.Attributes['Color'] := '0';
  NodeText:= LNodeElement.AddChild('Axis', 2);
  NodeText.Attributes['LineColor'] := '16777215';
  NodeText.Attributes['LineWidth'] := '1';
  NodeText.Attributes['TextColor'] := '16777215';
  NodeText.Attributes['TextHeight'] := '14';
  NodeText:= LNodeElement.AddChild('Limits', 3);
  NodeText.Attributes['LineColor'] := '255';
  NodeText.Attributes['TextColor'] := '255';
  NodeText.Attributes['TextHeight'] := '14';
  NodeText.Attributes['LineWidth'] := '1';
  NodeText:= LNodeElement.AddChild('Profil', 4);
  NodeText.Attributes['Color'] := '1072988';
  NodeText:= LNodeElement.AddChild('Stations', 5);
  NodeText.Attributes['LineColor'] := '16776960';
  NodeText.Attributes['TextColor'] := '16776960';
  NodeText.Attributes['TextHeight'] := '14';
  NodeText.Attributes['LineWidth'] := '1';
  NodeText:= LNodeElement.AddChild('LightSignals', 6);
  NodeText.Attributes['LineColor'] := '16776960';
  NodeText.Attributes['TextColor'] := '16776960';
  NodeText.Attributes['TextHeight'] := '14';
  NodeText.Attributes['LineWidth'] := '1';
  LNodeElement := LDocument.DocumentElement.ChildNodes.Nodes['Base'];
  NodeText:= LNodeElement.AddChild('Path', 1);
  NodeText.Attributes['Name'] := 'localhost:D:\base\';
  LNodeElement := LDocument.DocumentElement.ChildNodes.Nodes['Update'];
  NodeText:= LNodeElement.AddChild('Host', 1);
  NodeText.Attributes['Name'] := 'http://vnikti-dbauto.ru';

  LDocument.SaveToFile('tst.xml');

 //read
 LDocument := TXMLDocument.Create(nil);
  LDocument.LoadFromFile('tst.xml'); { File should exist. }

  { Find a specific node. }
  LNodeElement := LDocument.ChildNodes.FindNode('Setup');
  if (LNodeElement <> nil) then
  begin
    { Get a specific attribute.
    if (LNodeElement.HasAttribute(CAttrName)) then
    begin
      LAttrValue := LNodeElement.Attributes[CAttrName];
      Writeln('Attribute value: ' + LAttrValue);
    end;
        }
    { Traverse child nodes. }
    for I := 0 to LNodeElement.ChildNodes.Count - 1 do
    begin
      LNode := LNodeElement.ChildNodes.Get(I);
      { Display node name. }
    //  Writeln(sLineBreak + 'Node name: ' + LNode.NodeName);
      if LNode.NodeName='Graph' then
      begin
       NodeText:= LNode.ChildNodes.Nodes['Axis'];
       if NodeText.HasAttribute('LineColor') then
       val := NodeText.Attributes['LineColor'];

      end;
      LDocument.Active:=false;

      { Check whether the node type is Text
      if LNode.NodeType = ntText then
      begin
        Writeln(HTAB + 'This is a node of type Text. The text is: ' + LNode.Text);
      end;                                      . }
      { Check whether the node is text element.
      if LNode.IsTextElement then
      begin
        Writeln(HTAB + 'This is a text element. The text is: ' + LNode.Text);
      end;                                  }
    end;
  end;

                        *)

//fmMain.StatusBar1.Panels[5].Text:= GetVerProg;
  if tbGraph.Down=True then  begin
  if fmGraph = nil
    then
    begin
      fmGraph := TfmGraph.Create(Application);
     end;
//  else fmPrep.BringToFront;
  end else fmGraph.Close;

end;


procedure TfmMain.tbShiftClick(Sender: TObject);
begin
  if tbShift.Down=True then  begin
  if fmshift = nil
    then fmshift := Tfmshift.Create(Application)
//  else fmPrep.BringToFront;
  end else fmshift.Close;
end;

procedure TfmMain.ToolButton11Click(Sender: TObject);
begin
 fmAbout.Show;
end;

procedure TfmMain.tbProfClick(Sender: TObject);
begin
  if tbProf.Down=True then  begin
  if fmProf = nil
    then
    begin
         fmProf := TfmProf.Create(Application);
          fmProf.Width:=ProfSettings.width;
          fmProf.Height:=ProfSettings.Height;
          fmProf.Left:=ProfSettings.Left;
          fmProf.Top:=ProfSettings.Top;
    end;
  end else fmProf.Close;
end;

procedure TfmMain.btn1Click(Sender: TObject);
begin
 //import_convert;
end;

procedure TfmMain.IBDS_LimitsBeforePost(DataSet: TDataSet);
begin
 //fmMain.IBDS_LimitsDIR_KEY.Value:=fmMain.IBDS_Directionsid.Value;
end;

procedure TfmMain.IBDS_Light_SignalsBeforePost(DataSet: TDataSet);
begin
 //fmMain.IBDS_Light_SignalsDIR_KEY.Value:=fmMain.IBDS_Directionsid.Value;
end;

procedure TfmMain.IBDS_StationsBeforePost(DataSet: TDataSet);
begin
 //fmMain.IBDS_StationsDIR_KEY.Value:=fmMain.IBDS_Directionsid.Value;
end;

procedure TfmMain.IBDS_TrainsBeforePost(DataSet: TDataSet);
begin
 //fmMain.IBDS_TrainsDIR_KEY.Value:=fmMain.IBDS_Directionsid.Value;
end;

procedure TfmMain.N1Click(Sender: TObject);
begin
 Form3.Show;
end;

procedure TfmMain.IBDS_TIME_TABLEBeforePost(DataSet: TDataSet);
begin
 //fmMain.IBDS_TIME_TABLETRAIN_KEY.Value:=fmMain.IBDS_TrainsID.Value;
end;


procedure TfmMain.IBDS_StationsAfterPost(DataSet: TDataSet);
begin
 DIR_ID:=IntToStr(fmMain.IBDS_DirectionsID.Value);
 //верхний регистр названий станций
 with IBSQL do
 begin
  Close; SQL.Clear;
  SQL.Add('update Stations set FName = UPPER(FName) where Dir_key ='+DIR_ID);
  IBTR_WRITE.StartTransaction;
  ExecQuery;
  IBTR_WRITE.Commit;
 end;
 //обновляем Dataset
 DS_Refresh(DataSet);
end;

procedure TfmMain.IBDS_DirectionsAfterPost(DataSet: TDataSet);
begin
 //обновляем Dataset
 DS_Refresh(DataSet);
end;

procedure TfmMain.IBDS_ObjectsBeforePost(DataSet: TDataSet);
begin
 fmMain.IBDS_ObjectsDIR_KEY.Value:=fmMain.IBDS_Directionsid.Value;
end;

procedure TfmMain.IBDS_profBeforePost(DataSet: TDataSet);
begin
fmMain.IBDS_profDIR_KEY.Value:=fmMain.IBDS_Directionsid.Value;
end;

end.



