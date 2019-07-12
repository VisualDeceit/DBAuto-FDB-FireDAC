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
    ExportToLimits: TMenuItem;
    ExportToDB: TMenuItem;
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
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure ExportToLimitsClick(Sender: TObject);
    procedure ExportToDBClick(Sender: TObject);
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

uses unMain, unVars, unStationExport, unShiftSet, unDirection, unLimits;

{$R *.dfm}

//экспорт в таблицу *.DB
procedure TfmStations.ExportToDBClick(Sender: TObject);
var
  i:Word;
  r_count:word;
  put:byte;
  file_name:string;
  str:string;
  deb_txt:TextFile;
  mes :string;
  ExpTable: TTable;
begin
  //создаем папку для файла
   CreateFileDir(file_name, str, put);

  ExpTable:=TTable.Create(self);
  try
    with ExpTable do
    begin
     Active := False;
     DatabaseName := str+'\';
     TableType := ttParadox;
     TableName := 'stanc_'+inttostr(put)+'p';
      {Создаем поля:}
      with FieldDefs do
      begin
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
    //создаем временный запрос
      with fmMain.FDQ_TEMP do
      begin
       Close;
       SQL.Clear;
       SQL.LoadFromFile(SQL_DIR+'S_Select.sql');
       ParamByName('DIR_ID').AsInteger:=fmMain.FDQ_DIR.FieldByName('ID').Value;
       if not fl_Shift then  SQL.Add('ORDER BY KOORD') else SQL.Add('ORDER BY LIN_KOORD') ;
       Open;
       r_count:=RecordCount;
       if r_count=0 then
       begin
        raise ENoDataException.Create('Нет данных для создания файла');
        if Active then close;
        SQL.Clear;
        Exit;
        end;
      end;

      fmMain.FDQ_TEMP.Last;

      for i:=r_count downto 1  do
      begin
       ExpTable.Insert;
       if not fl_Shift then
       begin
         ExpTable.FieldValues['Ostan']:=fmMain.FDQ_TEMP.FieldValues['KOORD'];
         ExpTable.FieldValues['NachKM']:=fmMain.FDQ_TEMP.FieldValues['Beg_KM'];
         ExpTable.FieldValues['NachPik']:=fmMain.FDQ_TEMP.FieldValues['Beg_PK'];
         ExpTable.FieldValues['KonKM']:=fmMain.FDQ_TEMP.FieldValues['End_KM'];
         ExpTable.FieldValues['KonPik']:=fmMain.FDQ_TEMP.FieldValues['End_PK'];
       end else
       begin
         ExpTable.FieldValues['Нач_км']:=fmMain.FDQ_TEMP.FieldValues['LIN_BEG_KM'];
         ExpTable.FieldValues['Нач_пик']:=fmMain.FDQ_TEMP.FieldValues['LIN_BEG_PK'];
         ExpTable.FieldValues['Кон_км']:=fmMain.FDQ_TEMP.FieldValues['LIN_END_KM'];
         ExpTable.FieldValues['Кон_пик']:=fmMain.FDQ_TEMP.FieldValues['LIN_END_PK'];
       end;
       ExpTable.FieldValues['Nom']:=i;
       ExpTable.FieldValues['Name']:=fmMain.FDQ_TEMP.FieldValues['FName'];
       ExpTable.FieldValues['pyti']:=put;
       ExpTable.FieldValues['Ogr']:=fmMain.FDQ_TEMP.FieldValues['Speed'];
       ExpTable.Post;
       if i<>1 then fmMain.FDQ_TEMP.Prior;
      end;
      Application.MessageBox(Pchar('Файл "'+ExpTable.TableName+'.db" успешно создан!'), 'Внимание!', MB_OK or MB_DEFBUTTON1 +
      MB_ICONINFORMATION + MB_TOPMOST);
   except
       on E: Exception do
       Application.MessageBox(PWideChar('Ошибка при создании файла:'+#13+#13+E.Message),
                            'Редактор базы данных автоведения',
                            MB_OK + MB_ICONERROR);

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
(*
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
*)
end;

//экспорт в таблицу органичений
procedure TfmStations.ExportToLimitsClick(Sender: TObject);
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
   if ((fmMain.FDQ_DIR.FieldByName('WAY').Value = 2 )  and (fmMain.FDQ_DIR.FieldByName('FLAG').Value=1)) or
   ((fmMain.FDQ_DIR.FieldByName('WAY').Value=1)  and (fmMain.FDQ_DIR.FieldByName('FLAG').Value=0)) then Way:=2 else Way:=1;

  DIR_ID:=fmMain.FDQ_DIR.FieldByName('ID').AsString;

  //создаем временный запрос
      with fmMain.FDQ_TEMP do
      begin
       Close;
       SQL.Clear;
       SQL.LoadFromFile(SQL_DIR+'S_Select.sql');
       ParamByName('DIR_ID').AsInteger:=fmMain.FDQ_DIR.FieldByName('ID').Value;
       if not fl_Shift then  SQL.Add('ORDER BY KOORD') else SQL.Add('ORDER BY LIN_KOORD') ;
       Open;
       r_count:=RecordCount;
       shift_key:=FieldValues['Shift_KEY'];
       shift_key_old:=shift_key;
       if r_count=0 then
       begin
        raise ENoDataException.Create('Данные для создания файла станций остутствуют!');
        if Active then close;
        SQL.Clear;
        Exit;
        end;
      end;

   while not fmMain.FDQ_TEMP.Eof do
   begin
      fmLimits.FDQ_LIM.Insert;
    //станцию
      fmLimits.FDQ_LIM.FieldByName('Dir_key').Value:=DIR_ID;
      fmLimits.FDQ_LIM.FieldByName('BEG_KM').Value:=fmMain.FDQ_TEMP.FieldValues['Beg_KM'];
      fmLimits.FDQ_LIM.FieldByName('BEG_PK').Value:=fmMain.FDQ_TEMP.FieldValues['Beg_PK'];
      fmLimits.FDQ_LIM.FieldByName('END_KM').Value:=fmMain.FDQ_TEMP.FieldValues['End_KM'];
      fmLimits.FDQ_LIM.FieldByName('END_PK').Value:=fmMain.FDQ_TEMP.FieldValues['End_PK'];
      if fmMain.FDQ_TEMP.FieldValues['Speed']=null then
      fmLimits.FDQ_LIM.FieldByName('Speed').Value:=60 else
      fmLimits.FDQ_LIM.FieldByName('Speed').Value:=fmMain.FDQ_TEMP.FieldValues['Speed'];
      fmLimits.FDQ_LIM.FieldByName('Note').Value:=fmMain.FDQ_TEMP.FieldValues['FName'];
      fmLimits.FDQ_LIM.FieldByName('Shift_KEY').Value:=fmMain.FDQ_TEMP.FieldValues['Shift_KEY'];
      fmLimits.FDQ_LIM.Post;

      Bkm:=fmMain.FDQ_TEMP.FieldValues['Beg_KM'];
      Bpk:=fmMain.FDQ_TEMP.FieldValues['Beg_PK'];
      EKm:=fmMain.FDQ_TEMP.FieldValues['End_KM'];
      Epk:=fmMain.FDQ_TEMP.FieldValues['End_PK'];

      shift_key_old:=fmMain.FDQ_TEMP.FieldValues['Shift_KEY'];
      if (fmMain.FDQ_TEMP.RecNo = r_count) then Break;
      fmMain.FDQ_TEMP.Next;
      shift_key:=fmMain.FDQ_TEMP.FieldValues['Shift_KEY'];

      //добавляем перегон
      if (shift_key_old=shift_key) then
      begin
        fmLimits.FDQ_LIM.Insert;
        fmLimits.FDQ_LIM.FieldByName('Dir_key').Value:=DIR_ID;
        if Bkm*10+Bpk<fmMain.FDQ_TEMP.FieldValues['Beg_KM']*10+fmMain.FDQ_TEMP.FieldValues['Beg_PK'] then
        begin
          if Epk+1>10 then begin Epk:=1; Inc(EKm) end else Inc(Epk);
          fmLimits.FDQ_LIM.FieldByName('Beg_KM').Value:=EKm;
          fmLimits.FDQ_LIM.FieldByName('Beg_PK').Value:=Epk;
          Bkm:=fmMain.FDQ_TEMP.FieldValues['Beg_KM'];
          Bpk:=fmMain.FDQ_TEMP.FieldValues['Beg_PK'];
          if Bpk-1<1 then begin Bpk:=10; Dec(Bkm);  end else Dec(Bpk);
          fmLimits.FDQ_LIM.FieldByName('End_KM').Value:=Bkm;
          fmLimits.FDQ_LIM.FieldByName('End_PK').Value:=Bpk;
        end else
        begin
          if Bpk-1<1 then begin Bpk:=10; Dec(Bkm);  end else Dec(Bpk);
          fmLimits.FDQ_LIM.FieldByName('End_KM').Value:=Bkm;
          fmLimits.FDQ_LIM.FieldByName('End_PK').Value:=Bpk;
          EKm:=fmMain.FDQ_TEMP.FieldValues['End_KM'];
          Epk:=fmMain.FDQ_TEMP.FieldValues['End_PK'];
          if Epk+1>10 then begin Epk:=1; Inc(EKm) end else Inc(Epk);
          fmLimits.FDQ_LIM.FieldByName('Beg_KM').Value:=EKm;
         fmLimits.FDQ_LIM.FieldByName('Beg_PK').Value:=Epk;
        end;
        fmLimits.FDQ_LIM.FieldByName('Shift_KEY').Value:=fmMain.FDQ_TEMP.FieldValues['Shift_KEY'];
        fmLimits.FDQ_LIM.FieldByName('Speed').Value:=Per_speed;
        fmLimits.FDQ_LIM.FieldByName('Note').Value:='Перегон';
        fmLimits.FDQ_LIM.Post;
      end;
   end;
    //fmMain.FDQ_TEMP.Commit;
   // fmMain.IBDS_Limits.EnableControls;
    Application.MessageBox('Данные экспортированны', 'Внимание!', MB_OK or MB_DEFBUTTON1 +
    MB_ICONINFORMATION + MB_TOPMOST);
  except
   // if fmMain.IBTR_TEMP.InTransaction  then  fmMain.IBTR_TEMP.Rollback;
   // if fmMain.IBTR_WRITE.InTransaction then  fmMain.IBTR_WRITE.Rollback;
   // fmMain.IBDS_Limits.EnableControls;
    Application.MessageBox('Ошибка при экспорте данных!', 'Внимание!', MB_OK or MB_DEFBUTTON1 +
    MB_ICONSTOP + MB_TOPMOST);
 end;


end;

//полная очистка станций в направлении
procedure TfmStations.ToolButton2Click(Sender: TObject);
begin

(*

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
*)
end;


//правой клавишией
procedure TfmStations.FormDestroy(Sender: TObject);
begin
 fmStations:=nil;
end;

//после удаления
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
            FDQ_ST.CancelUpdates;
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
         DIR_ID:=fmMain.FDQ_DIR.FieldByName('ID').AsString;
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
            FDQ_ST.CancelUpdates;
            FDQ_ST.Refresh;
            Application.ShowException(E);
          end;
        end;
    end;
end;

//закрытие формы
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
            FDQ_ST.CancelUpdates;
            FDQ_ST.Refresh;
            Application.ShowException(E);
          end;
        end;
    end;
    // закрываем набор данных
    FDQ_ST.Close;
  finally
  end;
 //отлипаем кнопку
 Action := caFree;
 fmMain.tbStations.Down:=False;
end;

//Импорт  данных из таблицы *.DB
procedure TfmStations.ToolButton3Click(Sender: TObject);
var
 qtimport: TQuery;
begin
DIR_ID:=fmMain.FDQ_DIR.FieldByName('ID').AsString;
 if (fmMain.OpenDialog1.Execute) and (DIR_ID<>null) then
 begin
  //открытие таблицы PARADOX
  qtimport := OpenParadoxDB(fmMain.OpenDialog1.FileName, self);
  if qtimport = nil then exit;
  qtimport.First;

  //импорт данных в таблицу
    try
    with FDCmd do
     begin
      Close;
      CommandText.Clear;
      CommandText.LoadFromFile(SQL_DIR+'S_Import.sql');
     end;

    while not qtimport.Eof do
      begin
        FDT_WRITE_ST.StartTransaction;
        FDCmd.ParamByName('new_Dir_key').Value:=DIR_ID;
        FDCmd.ParamByName('new_Koord').Value:=qtimport.FieldValues['Ostan'];
        FDCmd.ParamByName('new_FNAME').Value:=AnsiUpperCase(qtimport.FieldValues['Name']);
        FDCmd.ParamByName('new_SPEED').Value:=qtimport.FieldValues['Ogr'];
        FDCmd.ParamByName('new_BEG_KM').Value:=qtimport.FieldValues['NachKM'];
        FDCmd.ParamByName('new_BEG_PK').Value:=qtimport.FieldValues['NachPik'];
        FDCmd.ParamByName('new_END_KM').Value:=qtimport.FieldValues['KonKM'];
        FDCmd.ParamByName('new_END_PK').Value:=qtimport.FieldValues['KonPik'];
        FDCmd.Execute();
        FDT_WRITE_ST.Commit;
        qtimport.Next;
      end;
   except
    on E: Exception do
    begin
         if FDT_WRITE_ST.Active then FDT_WRITE_ST.Rollback;
         Application.MessageBox(PWideChar('Ошибка при импорте файла:'+#13+#13+E.Message),
                            'Редактор базы данных автоведения',
                            MB_OK + MB_ICONERROR);
     if qtimport.Active then  qtimport.Close;
     qtimport.free;
     exit;
    end;
   end;

   qtimport.Close;
   qtimport.free;
   FDQ_ST.Refresh;
 end;
end;

procedure TfmStations.ToolButton4Click(Sender: TObject);
begin
 Shift_source:=1;
 fmShiftSet.ShowModal;
end;



procedure TfmStations.N1Click(Sender: TObject);
begin
 //fmMain.IBDS_Stations.Insert;
end;

end.



