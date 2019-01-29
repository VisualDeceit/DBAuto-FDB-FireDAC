unit unStations;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ExtCtrls, DBCtrls, DBGrids, DBTables, StdCtrls, Menus,
  DBGridEhGrouping, GridsEh, DBGridEh,ShellAPI, ImgList, ComCtrls, ToolWin,EhLibIBX,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL, DBAxisGridsEh, XMLIntf, XMLDoc,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, FireDAC.Comp.DataSet;

type
  TWmMoving = record
    Msg: Cardinal;
    fwSide: Cardinal;
    lpRect: PRect;
    Result: Integer;
  end;
type
  TfmStations = class(TForm)
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    DBG_Stations: TDBGridEh;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    PopupMenu2: TPopupMenu;
    N3: TMenuItem;
    db1: TMenuItem;
    DBNavigator1: TDBNavigator;
    DS_ST: TDataSource;
    FDQ_ST: TFDQuery;
    FDQ_STID: TFDAutoIncField;
    FDQ_STDIR_KEY: TIntegerField;
    FDQ_STSHIFT_KEY: TIntegerField;
    FDQ_STFNAME: TStringField;
    FDQ_STKOORD: TIntegerField;
    FDQ_STSPEED: TIntegerField;
    FDQ_STLIN_KOORD: TLargeintField;
    FDUSQL_ST: TFDUpdateSQL;
    FDT_WRITE_ST: TFDTransaction;
    FDCmd: TFDCommand;
    FDQ_STBEG_KM: TIntegerField;
    FDQ_STBEG_PK: TIntegerField;
    FDQ_STEND_KM: TIntegerField;
    FDQ_STEND_PK: TIntegerField;
    procedure DBG_StationsDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh;
      State: TGridDrawState);
    procedure N2Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure db1Click(Sender: TObject);
    procedure FDQ_STAfterPost(DataSet: TDataSet);
    procedure FDQ_STAfterDelete(DataSet: TDataSet);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  fmStations: TfmStations;


implementation

uses unMain, unVars, unStationExport, unShiftSet, unDirection;

{$R *.dfm}

//экспорт в таблицу *.DB
procedure TfmStations.db1Click(Sender: TObject);
var
  i:Word;
  r_count:word;
  dir:Byte;
  put:byte;
  file_name:string;
  str:string;
  deb_txt:TextFile;
  mes,SQL_Str :string;
  ExpTable: TTable;
begin
   dir:=fmMain.IBDS_Directions.FieldValues['Code'];
   put:=fmMain.IBDS_Directions.FieldValues['WAY'];
   file_name:='';
   if dir<10  then file_name:='0'+IntToStr(dir) else  file_name:=IntToStr(dir);
   file_name:=file_name+'p'+inttostr(put);
   str:=extractfilepath(application.ExeName)+'files\'+
                             IntToStr(fmMain.IBDS_Directions.FieldValues['Code'])+' '+
                             fmMain.IBDS_Directions.FieldValues['FName'];
  if not DirectoryExists(str) then  CreateDir(str);
  ExpTable:=TTable.Create(self);
  try
    with ExpTable do
    begin
     Active := False;
     DatabaseName := str+'\';
     TableType := ttParadox;
     TableName := fmMain.IBDS_Directions.FieldValues['FNAME']+'_p'+inttostr(put)+'_STC';
      {Создаем поля:}
      with FieldDefs do begin
        Clear;
        with AddFieldDef do begin
            Name := 'Nom';
            DataType := ftWord;
        end; 
        with AddFieldDef do begin
            Name := 'Ostan';
            DataType := ftWord;
        end; 
        with AddFieldDef do begin
            Name := 'Name';
            DataType := ftString;
            Size := 25;
        end; 
        with AddFieldDef do begin
            Name := 'Pyti';
            DataType := ftWord;
        end; 
        with AddFieldDef do begin
            Name := 'NachKM';
            DataType := ftWord;
        end; 
        with AddFieldDef do begin
            Name := 'NachPik';
            DataType := ftWord;
        end; 
        with AddFieldDef do begin
            Name := 'KonKM';
            DataType := ftWord;
        end; 
        with AddFieldDef do begin
            Name := 'KonPik';
            DataType := ftWord;
        end; 
        with AddFieldDef do begin
            Name := 'Ogr';
            DataType := ftWord;
        end;
      end; 
      //создаем таблицу:
     CreateTable;
      //и открываем ее:
     Open;
    end;
   try
      DIR_ID:=IntToStr(fmMain.IBDS_DirectionsID.Value);
      with fmMain.IBQR_TEMP do
      begin
       Close;
       SQL.Clear;
       SQL.LoadFromFile(SQL_DIR+'S_Select.sql');
       ParamByName('DIR_ID').AsInteger:=fmMain.IBDS_DirectionsID.Value;
       if not fl_Shift then  SQL.Add('ORDER BY KOORD') else SQL.Add('ORDER BY LIN_KOORD') ;
       fmMain.IBTR_TEMP.StartTransaction;
       Open;
       Last;
       First;
       r_count:=fmMain.IBQR_TEMP.RecordCount;
       if r_count=0 then
       begin
        Application.MessageBox('Данные для экспорта остутствуют!','Ошибка', MB_OK+ MB_ICONSTOP + MB_TOPMOST);
        if fmMain.IBTR_TEMP.InTransaction then fmMain.IBTR_TEMP.Commit;
        Exit;
        end;
       Last;
      end ;

      for i:=r_count downto 1  do
      begin
       ExpTable.Insert;
       if not fl_Shift then
       begin
         ExpTable.FieldValues['Ostan']:=fmMain.IBQR_TEMP.FieldValues['KOORD'];
         ExpTable.FieldValues['NachKM']:=fmMain.IBQR_TEMP.FieldValues['Beg_KM'];
         ExpTable.FieldValues['NachPik']:=fmMain.IBQR_TEMP.FieldValues['Beg_PK'];
         ExpTable.FieldValues['KonKM']:=fmMain.IBQR_TEMP.FieldValues['End_KM'];
         ExpTable.FieldValues['KonPik']:=fmMain.IBQR_TEMP.FieldValues['End_PK'];
       end else
       begin
         ExpTable.FieldValues['Нач_км']:=fmMain.IBQR_TEMP.FieldValues['LIN_BEG_KM'];
         ExpTable.FieldValues['Нач_пик']:=fmMain.IBQR_TEMP.FieldValues['LIN_BEG_PK'];
         ExpTable.FieldValues['Кон_км']:=fmMain.IBQR_TEMP.FieldValues['LIN_END_KM'];
         ExpTable.FieldValues['Кон_пик']:=fmMain.IBQR_TEMP.FieldValues['LIN_END_PK'];
       end;
       ExpTable.FieldValues['Nom']:=i;
       ExpTable.FieldValues['Name']:=fmMain.IBQR_TEMP.FieldValues['FName'];
       ExpTable.FieldValues['pyti']:=put;
       ExpTable.FieldValues['Ogr']:=fmMain.IBQR_TEMP.FieldValues['Speed'];
       ExpTable.Post;
       if i<> 1 then fmMain.IBQR_TEMP.Prior;
      end;
      fmMain.IBTR_TEMP.Commit;
      Application.MessageBox(Pchar('Файл "'+ExpTable.TableName+'.db" успешно создан!'), 'Внимание!', MB_OK or MB_DEFBUTTON1 +
      MB_ICONINFORMATION + MB_TOPMOST);
   except
      if fmMain.IBTR_TEMP.intransaction then fmMain.IBTR_TEMP.Rollback;
       Application.MessageBox('Ошибка при создании файла!', 'Внимание!', MB_OK or MB_DEFBUTTON1 +
      MB_ICONSTOP + MB_TOPMOST);
   end;
  finally
    ExpTable.Close;
    ExpTable.Free;
  end;

end;

procedure TfmStations.DBG_StationsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  DBG_Stations.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfmStations.N2Click(Sender: TObject);
begin
  if Application.MessageBox('Вы дейтсвительно хотите удалить станцию?'+#13+
     'Текущая станция будет удалена из всех расписаний.',
    'Предупреждение', MB_YESNO + + MB_ICONWARNING + MB_TOPMOST) = IDYES then
  begin
   St_ID:=IntToStr(fmMain.IBDS_StationsID.Value);
   with fmMain.IBSQL do
   begin
     close;
     SQL.Clear;
     SQL.Add('DELETE FROM TIME_TABLE WHERE STATION_key='+St_ID);
     fmMain.IBTR_WRITE.StartTransaction;
     ExecQuery;
     fmMain.IBTR_WRITE.Commit;
   end;
   fmMain.IBDS_Stations.Delete;
   //UpdateTransaction(fmMain.IBDS_Stations);
  end;
end;

//экспорт в таблицу органичений
procedure TfmStations.N3Click(Sender: TObject);
var
  i:Word;
  r_count:word;
  dir:Byte;
  put:byte;
  file_name:string;
  str:string;
  Bkm,Bpk,EKm,Epk:Word;
  SQL_Str:string;
  shift_key_old,shift_key:variant;
begin
 try
   if ((fmMain.IBDS_DirectionsWAY.Value=2)  and (fmMain.IBDS_DirectionsFLAG.Value=1)) or
   ((fmMain.IBDS_DirectionsWAY.Value=1)  and (fmMain.IBDS_DirectionsFLAG.Value=0)) then Way:=2 else Way:=1;

  DIR_ID:=IntToStr(fmMain.IBDS_DirectionsID.Value);
  //выбираем станции в отдельный Query
  with fmMain.IBQR_TEMP do
  begin
   Close;
   SQL.Clear;
   SQL.LoadFromFile(SQL_DIR+'S_Select.sql');
   ParamByName('DIR_ID').AsInteger:=fmMain.IBDS_DirectionsID.Value;
   fmMain.IBTR_TEMP.StartTransaction;
   Open;
   Last;
   First;
   shift_key:=fmMain.IBQR_TEMP.FieldValues['Shift_KEY'];
   shift_key_old:=shift_key;
   if recordcount=0 then
   begin
    Application.MessageBox('Данные для создания файла станций остутствуют!','Ошибка', MB_OK+ MB_ICONSTOP + MB_TOPMOST);
    if fmMain.IBTR_TEMP.InTransaction then fmMain.IBTR_TEMP.Rollback;
    Exit;
    end;
  end ;
   fmMain.IBDS_Limits.DisableControls;
   while not fmMain.IBQR_TEMP.Eof do
   begin
    fmMain.IBDS_Limits.Insert;
    //станцию
      fmMain.IBDS_Limits.FieldByName('Dir_key').Value:=DIR_ID;
      fmMain.IBDS_Limits.FieldByName('BEG_KM').Value:=fmMain.IBQR_TEMP.FieldValues['Beg_KM'];
      fmMain.IBDS_Limits.FieldByName('BEG_PK').Value:=fmMain.IBQR_TEMP.FieldValues['Beg_PK'];
      fmMain.IBDS_Limits.FieldByName('END_KM').Value:=fmMain.IBQR_TEMP.FieldValues['End_KM'];
      fmMain.IBDS_Limits.FieldByName('END_PK').Value:=fmMain.IBQR_TEMP.FieldValues['End_PK'];
      if fmMain.IBQR_TEMP.FieldValues['Speed']=null then
      fmMain.IBDS_Limits.FieldByName('Speed').Value:=60 else
      fmMain.IBDS_Limits.FieldByName('Speed').Value:=fmMain.IBQR_TEMP.FieldValues['Speed'];
      fmMain.IBDS_Limits.FieldByName('Note').Value:=fmMain.IBQR_TEMP.FieldValues['FName'];
      fmMain.IBDS_Limits.FieldByName('Shift_KEY').Value:=fmMain.IBQR_TEMP.FieldValues['Shift_KEY'];
      fmMain.IBDS_Limits.Post;

      Bkm:=fmMain.IBQR_TEMP.FieldValues['Beg_KM'];
      Bpk:=fmMain.IBQR_TEMP.FieldValues['Beg_PK'];
      EKm:=fmMain.IBQR_TEMP.FieldValues['End_KM'];
      Epk:=fmMain.IBQR_TEMP.FieldValues['End_PK'];

      shift_key_old:=fmMain.IBQR_TEMP.FieldValues['Shift_KEY'];
      if (fmMain.IBQR_TEMP.RecNo=r_count) then Break;
      fmMain.IBQR_TEMP.Next;
      shift_key:=fmMain.IBQR_TEMP.FieldValues['Shift_KEY'];

      //добавляем перегон
      if (shift_key_old=shift_key) then
      begin
        fmMain.IBDS_Limits.Insert;
        fmMain.IBDS_Limits.FieldByName('Dir_key').Value:=DIR_ID;
        if Bkm*10+Bpk<fmMain.IBQR_TEMP.FieldValues['Beg_KM']*10+fmMain.IBQR_TEMP.FieldValues['Beg_PK'] then
        begin
          if Epk+1>10 then begin Epk:=1; Inc(EKm) end else Inc(Epk);
          fmMain.IBDS_Limits.FieldByName('Beg_KM').Value:=EKm;
          fmMain.IBDS_Limits.FieldByName('Beg_PK').Value:=Epk;
          Bkm:=fmMain.IBQR_TEMP.FieldValues['Beg_KM'];
          Bpk:=fmMain.IBQR_TEMP.FieldValues['Beg_PK'];
          if Bpk-1<1 then begin Bpk:=10; Dec(Bkm);  end else Dec(Bpk);
          fmMain.IBDS_Limits.FieldByName('End_KM').Value:=Bkm;
          fmMain.IBDS_Limits.FieldByName('End_PK').Value:=Bpk;
        end else
        begin
          if Bpk-1<1 then begin Bpk:=10; Dec(Bkm);  end else Dec(Bpk);
          fmMain.IBDS_Limits.FieldByName('End_KM').Value:=Bkm;
          fmMain.IBDS_Limits.FieldByName('End_PK').Value:=Bpk;
          EKm:=fmMain.IBQR_TEMP.FieldValues['End_KM'];
          Epk:=fmMain.IBQR_TEMP.FieldValues['End_PK'];
          if Epk+1>10 then begin Epk:=1; Inc(EKm) end else Inc(Epk);
          fmMain.IBDS_Limits.FieldByName('Beg_KM').Value:=EKm;
          fmMain.IBDS_Limits.FieldByName('Beg_PK').Value:=Epk;
        end;
        fmMain.IBDS_Limits.FieldByName('Shift_KEY').Value:=fmMain.IBQR_TEMP.FieldValues['Shift_KEY'];
        fmMain.IBDS_Limits.FieldByName('Speed').Value:=Per_speed;
        fmMain.IBDS_Limits.FieldByName('Note').Value:='Перегон';
        fmMain.IBDS_Limits.Post;
      end;
   end;
    fmMain.IBTR_TEMP.Commit;
    fmMain.IBDS_Limits.EnableControls;
    Application.MessageBox('Данные экспортированны', 'Внимание!', MB_OK or MB_DEFBUTTON1 +
    MB_ICONINFORMATION + MB_TOPMOST);
  except
    if fmMain.IBTR_TEMP.InTransaction  then  fmMain.IBTR_TEMP.Rollback;
    if fmMain.IBTR_WRITE.InTransaction then  fmMain.IBTR_WRITE.Rollback;
    fmMain.IBDS_Limits.EnableControls;
    Application.MessageBox('Ошибка при экспорте данных!', 'Внимание!', MB_OK or MB_DEFBUTTON1 +
    MB_ICONSTOP + MB_TOPMOST);
 end;


end;

//полная очистка станций в направлении
procedure TfmStations.ToolButton2Click(Sender: TObject);
begin
  if Application.MessageBox('Вы дейтсвительно хотите полностью очистить таблицу станций?'+#13+
    'Все станции будут удалены из всех расписаний.',
    'Предупреждение', MB_YESNO + + MB_ICONWARNING + MB_TOPMOST) = IDYES then
  begin
    DIR_ID:=IntToStr(fmMain.IBDS_DirectionsID.Value);
    //выбираем станции в отдельный Query
    with fmMain.IBQR_TEMP do
    begin
     Close;
     SQL.Clear;
     SQL.LoadFromFile(SQL_DIR+'S_Select.sql');
     ParamByName('DIR_ID').AsInteger:=fmMain.IBDS_DirectionsID.Value;
     fmMain.IBTR_TEMP.StartTransaction;
     Open;
     First;
    end ;
    //ищем совпадение в таблице TIME_TABLE и удаляем ее от туда
    while not fmMain.IBQR_TEMP.Eof do
    begin
      St_ID:=IntToStr(fmMain.IBQR_TEMP.FieldValues['ID']);
      with fmMain.IBSQL do
      begin
       close;
       SQL.Clear;
       SQL.Add('DELETE FROM TIME_TABLE WHERE STATION_key='+St_ID);
       fmMain.IBTR_WRITE.StartTransaction;
       ExecQuery;
       fmMain.IBTR_WRITE.Commit;
      end;
     fmMain.IBQR_TEMP.Next;
    end;
    fmMain.IBTR_TEMP.Commit;
    //удалем все станции
 {   with fmMain.IBSQL do
    begin
      close;
      SQL.Clear;
      SQL.Add('DELETE FROM STATIONS WHERE DIR_KEY='+DIR_ID);
      fmMain.IBTR_WRITE.StartTransaction;
      ExecQuery;
      fmMain.IBTR_WRITE.Commit;
    end;   }
    //обновляем Dataset
    DS_Refresh(fmMain.IBDS_Stations);
  end;
end;


//правой клавишией
procedure TfmStations.ToolButton1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//  if Button=mbRight then fmstationExport.ShowModal;
end;

procedure TfmStations.FormDestroy(Sender: TObject);
begin
 fmStations:=nil;
end;

procedure TfmStations.FDQ_STAfterDelete(DataSet: TDataSet);
begin
if FDQ_ST.UpdatesPending then
      begin
       //старт транзакции на запись
        FDT_WRITE_ST.StartTransaction;
       //применяем изменения
       try
        if (FDQ_ST.ApplyUpdates = 0) then
        begin
         //очищаем журнал
         FDQ_ST.CommitUpdates;
         //замершаем транзакцию
         FDT_WRITE_ST.Commit;
        end else
         raise Exception.Create('Ошибка при удалении записи');
       except
          on E: Exception do
          begin
            if FDT_WRITE_ST.Active then FDT_WRITE_ST.Rollback;
            FDQ_ST.CommitUpdates;
            FDQ_ST.Refresh;
            Application.ShowException(E);
          end;
        end;
    end;
end;

procedure TfmStations.FDQ_STAfterPost(DataSet: TDataSet);
begin
if FDQ_ST.UpdatesPending then
      begin
       //старт транзакции на запись
        FDT_WRITE_ST.StartTransaction;
       //применяем изменения
       try
        if (FDQ_ST.ApplyUpdates = 0) then
        begin
         //очищаем журнал
         FDQ_ST.CommitUpdates;
         //замершаем транзакцию
         FDT_WRITE_ST.Commit;
         //обновляем верхний регистр
         DIR_ID:=fmDirection.FDQ_DIR.FieldByName('ID').AsString;
         with FDCmd do
          begin
             Close;
             CommandText.Clear;
             CommandText.Add('update Stations set FName = UPPER(FName) where Dir_key ='+DIR_ID);
             FDT_WRITE_ST.StartTransaction;
             Execute();
             FDT_WRITE_ST.Commit;
            // FDQ_ST.Refresh;
          end;
        end else
         raise Exception.Create('Ошибка при добавлении записи');
       except
          on E: Exception do
          begin
            if FDT_WRITE_ST.Active then FDT_WRITE_ST.Rollback;
            FDQ_ST.CommitUpdates;
            FDQ_ST.Refresh;
            Application.ShowException(E);
          end;
        end;
    end;
end;

procedure TfmStations.FormClose(Sender: TObject; var Action: TCloseAction);
var
      LDocument: IXMLDocument;
        LNodeRoot, LNodeChild, LNode: IXMLNode;
begin
  try
    LDocument := TXMLDocument.Create(nil);
    LDocument.LoadFromFile(extractfilepath(application.ExeName)+'Setup.xml');
    LDocument.Active:=true;
    LNodeRoot := LDocument.ChildNodes.FindNode('Setup');

    LNodeChild:= LNodeRoot.ChildNodes.FindNode('Windows');
    LNode:=LNodeChild.ChildNodes.FindNode('Stations');
    StSettings.width:=fmStations.width;
    StSettings.Height:=fmStations.height;
    StSettings.Left:=fmStations.left;
    StSettings.Top:=fmStations.top;
    LNode.SetAttribute('visible',StSettings.visible);
    LNode.SetAttribute('height', fmStations.height);
    LNode.SetAttribute('width',  fmStations.width);
    LNode.SetAttribute('left',   fmStations.left);
    LNode.SetAttribute('top',    fmStations.top);

    LDocument.SaveToFile(extractfilepath(application.ExeName)+'Setup.xml');
    LDocument.Active:=false;


    if FDQ_ST.UpdatesPending then
      begin
       //старт транзакции на запись
        FDT_WRITE_ST.StartTransaction;
       //применяем изменения
       try
        if (FDQ_ST.ApplyUpdates = 0) then
        begin
         //очищаем журнал
         FDQ_ST.CommitUpdates;
         //завершаем транзакцию
         FDT_WRITE_ST.Commit;
        end else
         raise Exception.Create('Ошибка при добавлении записи');
         except
          on E: Exception do
          begin
            if FDT_WRITE_ST.Active then FDT_WRITE_ST.Rollback;
            FDQ_ST.CommitUpdates;
            FDQ_ST.Refresh;
            Application.ShowException(E);
          end;
        end;
    end;
    // закрываем набор данных
    FDQ_ST.Close;
  finally

  end;


 Action := caFree;
 fmMain.tbStations.Down:=False;
 if fmMain.IBDS_Stations.State in [dsEdit] then  fmMain.IBDS_Stations.Post;

end;

//Импорт  данных из DB
var impDBpath,impDBname:string;
procedure TfmStations.ToolButton3Click(Sender: TObject);
var i:word; s, sql_STR :string;
 qtimport: TQuery;
begin
 DIR_ID:=IntToStr(fmMain.IBDS_DirectionsID.Value);
 if (fmMain.OpenDialog1.Execute) and (DIR_ID<>null) then
 begin
  //определение пути и имени импортируемой БД
  impDBpath:=fmMain.OpenDialog1.FileName;
  s:='';
  for i:=Length(impDBpath) downto 0 do
  if impDBpath[i]<>'\' then s:=s+impDBpath[i] else Break;
  Delete(impDBpath,Length(impDBpath)+1-Length(s),Length(s));
  delete(s,1,3);
  impDBname:='';
  for i:=Length(s) downto 1 do impDBname:=impDBname+s[i];
  //открытие импортируемой БД
  try
   qtimport:= TQuery.Create(self);
  with qtimport do
  begin
   Close;
   DatabaseName:=impDBpath;
   Active:=false;
   SQL.Clear;
   SQL.Add('SELECT *');
   SQL.Add('FROM "'+impDBname+'"');
   Active:=true;
  end;
   qtimport.First;
   fmMain.IBDS_Stations.DisableControls;
   while not qtimport.Eof do
   begin
    fmMain.IBDS_Stations.Insert;
    fmMain.IBDS_Stations.FieldByName('Dir_key').Value:=DIR_ID;
    fmMain.IBDS_Stations.FieldByName('Koord').Value:=qtimport.FieldValues['Ostan'];
    fmMain.IBDS_Stations.FieldByName('FName').Value:=AnsiUpperCase(qtimport.FieldValues['Name']);
    fmMain.IBDS_Stations.FieldByName('Beg_KM').Value:=qtimport.FieldValues['NachKM'];
    fmMain.IBDS_Stations.FieldByName('Beg_PK').Value:=qtimport.FieldValues['NachPik'];
    fmMain.IBDS_Stations.FieldByName('End_KM').Value:=qtimport.FieldValues['KonKM'];
    fmMain.IBDS_Stations.FieldByName('End_PK').Value:=qtimport.FieldValues['KonPik'];
    fmMain.IBDS_Stations.FieldByName('Speed').Value:=qtimport.FieldValues['Ogr'];
    fmMain.IBDS_Stations.Post;
    qtimport.Next;
   end;
   qtimport.Close;
   qtimport.free;
   fmMain.IBDS_Stations.EnableControls;
   except
    if qtimport.Active then
    begin
     qtimport.Close;
     qtimport.free;
    end;
    fmMain.IBDS_Stations.EnableControls;
    Application.MessageBox('Ошибка при импортировании данных.', 'Внимание!', MB_OK +
      MB_ICONSTOP + MB_TOPMOST);
    end;
 end;
end;

procedure TfmStations.ToolButton4Click(Sender: TObject);
begin
 Shift_source:=1;
 fmShiftSet.ShowModal;
end;



procedure TfmStations.N1Click(Sender: TObject);
begin
 fmMain.IBDS_Stations.Insert;
end;

end.



