unit unLimits;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, ExtCtrls, DBCtrls, Grids, DBGrids,
  DBGridEhGrouping, GridsEh, DBGridEh, Menus, StdCtrls,ShellAPI, ImgList,
  ComCtrls, ToolWin, ComObj, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh,
  EhLibVCL, DBAxisGridsEh, XMLIntf, XMLDoc, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.Phys.IBWrapper;

type
  TfmLimits = class(TForm)
    ToolBar5: TToolBar;
    FileCreate: TToolButton;
    ClearAll: TToolButton;
    DBG_Limits: TDBGridEh;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ExportToDB: TToolButton;
    pmImport: TPopupMenu;
    ImportFromDB: TMenuItem;
    ImportFromXLS: TMenuItem;
    ImportDialog: TOpenDialog;
    DS_LIM: TDataSource;
    FDQ_LIM: TFDQuery;
    FDUSQL_LIM: TFDUpdateSQL;
    FDT_WRITE_LIM: TFDTransaction;
    FDCmd: TFDCommand;
    DBNavigator1: TDBNavigator;
    FDQ_LIMID: TFDAutoIncField;
    FDQ_LIMBEG_KM: TIntegerField;
    FDQ_LIMBEG_PK: TIntegerField;
    FDQ_LIMEND_KM: TIntegerField;
    FDQ_LIMEND_PK: TIntegerField;
    FDQ_LIMSPEED: TSmallintField;
    FDQ_LIMNOTE: TStringField;
    FDQ_LIMDIR_KEY: TIntegerField;
    FDQ_LIMSHIFT_KEY: TIntegerField;
    FDQ_LIMLIN_KOORD: TLargeintField;
    FDQ_LIMLIN_BEG_KM: TLargeintField;
    FDQ_LIMLIN_BEG_PK: TLargeintField;
    FDQ_LIMLIN_END_KM: TLargeintField;
    FDQ_LIMLIN_END_PK: TLargeintField;
    procedure DBG_LimitsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure N1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FileCreateClick(Sender: TObject);
    procedure ClearAllClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBG_LimitsGetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure ToolButton2Click(Sender: TObject);
    procedure ExportToDBClick(Sender: TObject);
    procedure ImportFromDBClick(Sender: TObject);
    procedure ImportFromXLSClick(Sender: TObject);
    procedure FDQ_LIMAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmLimits: TfmLimits;

implementation

uses  unMain, unVars, unDirection, unShiftSet, unImport;

{$R *.dfm}

procedure TfmLimits.DBG_LimitsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  if fmMain.IBDS_Limits.FieldByName('Note').AsString='Перегон' then
  Canvas.Brush.Color:=clRed;
  DBG_Limits.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfmLimits.N1Click(Sender: TObject);
begin
 fmMain.IBDS_Limits.Insert; 
end;


procedure TfmLimits.FDQ_LIMAfterPost(DataSet: TDataSet);
begin
 if FDQ_LIM.UpdatesPending then
      begin
       //старт транзакции на запись
        FDT_WRITE_LIM.StartTransaction;
       //применяем изменения
       try
        if (FDQ_LIM.ApplyUpdates = 0) then
        begin
         //очищаем журнал
         FDQ_LIM.CommitUpdates;
         //завершаем транзакцию
         FDT_WRITE_LIM.Commit;
        end else
         raise Exception.Create('Ошибка при добавлении записи');
        except
          on E: Exception do
          begin
            if FDT_WRITE_LIM.Active then FDT_WRITE_LIM.Rollback;
            FDQ_LIM.CancelUpdates;
            FDQ_LIM.Refresh;
            Application.ShowException(E);
          end;
        end;
    end;
end;

procedure TfmLimits.FormClose(Sender: TObject; var Action: TCloseAction);
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
    LNode:=LNodeChild.ChildNodes.FindNode('Limits');
    LimSettings.width:=fmLimits.width;
    LimSettings.Height:=fmLimits.height;
    LimSettings.Left:=fmLimits.left;
    LimSettings.Top:=fmLimits.top;
    LNode.SetAttribute('visible',LimSettings.visible);
    LNode.SetAttribute('height', fmLimits.height);
    LNode.SetAttribute('width',  fmLimits.width);
    LNode.SetAttribute('left',   fmLimits.left);
    LNode.SetAttribute('top',    fmLimits.top);

    LDocument.SaveToFile(extractfilepath(application.ExeName)+'Setup.xml');
    LDocument.Active:=false;

    if FDQ_LIM.UpdatesPending then
      begin
       //старт транзакции на запись
        FDT_WRITE_LIM.StartTransaction;
       //применяем изменения
       try
        if (FDQ_LIM.ApplyUpdates = 0) then
        begin
         //очищаем журнал
         FDQ_LIM.CommitUpdates;
         //завершаем транзакцию
         FDT_WRITE_LIM.Commit;
        end else
         raise Exception.Create('Ошибка при добавлении записи');
        except
          on E: Exception do
          begin
            if FDT_WRITE_LIM.Active then FDT_WRITE_LIM.Rollback;
            FDQ_LIM.CancelUpdates;
            FDQ_LIM.Refresh;
            Application.ShowException(E);
          end;
        end;
    end;
    // закрываем набор данных
    FDQ_LIM.Close;
  finally

  end;
  Action:=caFree;
  fmMain.tbLimits.Down:=False;
end;


procedure TfmLimits.FileCreateClick(Sender: TObject);
var
  i:Word;
  r_count:word;
  dir:Byte;
  put:byte;
  file_name:string;
  str:string;
  deb_txt:TextFile;
  mes,SQL_Str :string;
label L1;
begin
 try
  DIR_ID:=fmMain.FDQ_DIR.FieldByName('ID').AsString;
  if  (FDQ_LIM.FieldByName('ID').Value=null)  then
  raise ENoDataException.Create('Нет данных для создания файла');
  //считываем данные во временный Датасет
  with fmMain.FDQ_TEMP do
  begin
   Close;
   SQL.Clear;
   SQL.LoadFromFile(SQL_DIR+'L_Select.sql');
   ParamByName('DIR_ID').AsInteger:=fmMain.FDQ_DIR.FieldByName('ID').Value;
   if not fl_Shift then  SQL.Add('ORDER BY L.beg_km, L.beg_pk') else SQL.Add('ORDER BY LIN_KOORD') ;
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
  //создаем папку для файла
   CreateFileDir(file_name, str, put);
  //заполняем массив из БД
   for i:=1 to r_count do
    begin
     if not fl_Shift then
     begin
       ogP[i].kB:=fmMain.FDQ_TEMP.FieldValues['beg_km'];
       ogP[i].pB:=fmMain.FDQ_TEMP.FieldValues['beg_pk'];
       ogP[i].kE:=fmMain.FDQ_TEMP.FieldValues['end_km'];
       ogP[i].pE:=fmMain.FDQ_TEMP.FieldValues['end_pk'];
       ogP[i].V:= fmMain.FDQ_TEMP.FieldValues['Speed'];
     end else
     begin
       ogP[i].kB:=fmMain.FDQ_TEMP.FieldValues['LIN_BEG_KM'];
       ogP[i].pB:=fmMain.FDQ_TEMP.FieldValues['LIN_BEG_PK'];
       ogP[i].kE:=fmMain.FDQ_TEMP.FieldValues['LIN_END_KM'];
       ogP[i].pE:=fmMain.FDQ_TEMP.FieldValues['LIN_END_PK'];
       ogP[i].V:=fmMain.FDQ_TEMP.FieldValues['Speed'];
     end;

     //проверка ограничений
     if i>1 then
     begin
        if  (ogP[i].kB*10+ogP[i].pB>=ogP[i-1].kE*10+ogP[i-1].pE+2) or
            (ogP[i].kB*10+ogP[i].pB<=ogP[i-1].kE*10+ogP[i-1].pE)
            then
        begin
         raise EDataErrorException.Create('Ошибка при создании файла.'+#13+'Проверьте корректность данных в строке '+ inttostr(i)+'.');
        end;
     end;
     if i<> r_count then fmMain.FDQ_TEMP.Next;
    end;
  // fmMain.IBTR_TEMP.Commit;
   if FileExists(str+'\'+file_name+'.ogr')=True then
   begin
     mes:='Папка уже содержит файл "'+file_name+'.ogr".'+#13+#13+
        'Заменить имеющийся файл'+#13+#13+
        '   '+IntToStr(GetFileSize(str+'\'+file_name+'.ogr'))+ ' Байт'+#13+
        '   Дата изменения: '+GetFileDate(str+'\'+file_name+'.ogr')+#13+#13+
        'новым файлом?';
    if Application.MessageBox(PWideChar(mes),
     'Подтверждение замены файла', MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES then
    begin
L1:
    assignfile(fogp,str+'\'+file_name+'.ogr');
     AssignFile(deb_txt,str+'\'+file_name+'.ogr.txt');
     rewrite(fogp);
     Rewrite(deb_txt);
      for i:=1 to r_count do
      begin
       write(fogp,ogP[i]);
       Writeln(deb_txt,ogP[i].kB:4,'  ',ogP[i].pB:2,'  ', ogP[i].kE:4,'  ',ogP[i].pE:2,'  ', ogP[i].V:3 );
      end;
     closefile(fogp);
     CloseFile(deb_txt);
     Application.MessageBox(PChar('Файл "'+file_name+'.ogr" успешно создан!'),
                                   'Редактор базы данных автоведения',
                                    MB_OK or MB_DEFBUTTON1 + MB_ICONINFORMATION + MB_TOPMOST);
    end;
   end else goto L1;
 except
   on E: ENoDataException do
         Application.ShowException(E);
   on E: EDataErrorException do
         Application.ShowException(E);
   on E: EIBNativeException do
         Application.MessageBox(PWideChar('Ошибка в SQL запросе файла '+#13+SQL_DIR+'LS_Select.sql: '+#13+E.Message),
                                'Редактор базы данных автоведения',
                                MB_OK + MB_ICONERROR);
   else
     Application.MessageBox('Неизвестная ошибка.',
                            'Редактор базы данных автоведения',
                            MB_OK + MB_ICONERROR);
 end;
end;

//очистка всей таблицы
procedure TfmLimits.ClearAllClick(Sender: TObject);
begin
  if Application.MessageBox('Вы дейтсвительно хотите полностью очистить таблицу ограничений?',
                            'Редактор базы данных автоведения',
                            MB_YESNO + MB_ICONWARNING + MB_TOPMOST) = IDYES then
  begin
     DIR_ID:=fmMain.FDQ_DIR.FieldByName('ID').AsString;
    with FDCmd do
    begin
       Close;
       CommandText.Clear;
       CommandText.Add('Delete FROM LIMITS  WHERE Dir_key='+DIR_ID);
       FDT_WRITE_LIM.StartTransaction;
       try
          Execute();
          FDT_WRITE_LIM.Commit;
          FDQ_LIM.Refresh;
       except
       on E: EFDDBEngineException do
          begin
            if FDT_WRITE_LIM.Active then FDT_WRITE_LIM.Rollback;
            Application.ShowException(E);
          end;
       end;
    end;

  end;
end;

procedure TfmLimits.FormDestroy(Sender: TObject);
begin
 fmLimits:=nil;
end;

procedure TfmLimits.DBG_LimitsGetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
 if fmMain.IBDS_Limits.FieldByName('Note').AsString='Перегон' then
  Background:=$00BFFFC1;
end;


procedure TfmLimits.ToolButton2Click(Sender: TObject);
begin
 Shift_source:=2;
 fmShiftSet.ShowModal;
end;

//экспорт таблицы в отдельную базу формата .*db
procedure TfmLimits.ExportToDBClick(Sender: TObject);
var
  i:Word;
  r_count:word;
  put:byte;
  file_name:string;
  str:string;
  deb_txt:TextFile;
  mes,SQL_Str :string;
  ExpTable: TTable;
begin
      (*
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
       with ExpTable do
       begin
        Active := False;
        DatabaseName := str+'\';
        TableType := ttParadox;
        TableName := fmMain.IBDS_Directions.FieldValues['FNAME']+'_p'+inttostr(put)+'_OGR';
         {Создаем поля:}
         with FieldDefs do begin
           Clear;
           with AddFieldDef do begin
               Name := 'Номер';
               DataType := ftWord;
           end; //with
           with AddFieldDef do begin
               Name := 'Название_станц';
               DataType := ftString;
               Size := 30;
           end; //with
           with AddFieldDef do begin
               Name := 'Нач_км';
               DataType := ftWord;
           end; //with
           with AddFieldDef do begin
               Name := 'Нач_пик';
               DataType := ftWord;
           end; //with
           with AddFieldDef do begin
               Name := 'Кон_км';
               DataType := ftWord;
           end; //with
           with AddFieldDef do begin
               Name := 'Кон_пик';
               DataType := ftWord;
           end; //with
           with AddFieldDef do begin
               Name := 'Огранич_км/ч';
               DataType := ftWord;
           end; //with
         end; //with

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
          SQL.LoadFromFile(SQL_DIR+'L_Select.sql');
          ParamByName('DIR_ID').AsInteger:=fmMain.IBDS_DirectionsID.Value;
          if not fl_Shift then  SQL.Add('ORDER BY L.beg_km, L.beg_pk') else SQL.Add('ORDER BY LIN_KOORD') ;
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
           last;
         end ;
         for i:=r_count downto 1  do
         begin
          ExpTable.Insert;
          if not fl_Shift then
          begin
            ExpTable.FieldValues['Нач_км']:=fmMain.IBQR_TEMP.FieldValues['beg_km'];
            ExpTable.FieldValues['Нач_пик']:=fmMain.IBQR_TEMP.FieldValues['beg_pk'];
            ExpTable.FieldValues['Кон_км']:=fmMain.IBQR_TEMP.FieldValues['end_km'];
            ExpTable.FieldValues['Кон_пик']:=fmMain.IBQR_TEMP.FieldValues['end_pk'];
            ExpTable.FieldValues['Огранич_км/ч']:=fmMain.IBQR_TEMP.FieldValues['Speed'];
          end else
          begin
            ExpTable.FieldValues['Нач_км']:=fmMain.IBQR_TEMP.FieldValues['LIN_BEG_KM'];
            ExpTable.FieldValues['Нач_пик']:=fmMain.IBQR_TEMP.FieldValues['LIN_BEG_PK'];
            ExpTable.FieldValues['Кон_км']:=fmMain.IBQR_TEMP.FieldValues['LIN_END_KM'];
            ExpTable.FieldValues['Кон_пик']:=fmMain.IBQR_TEMP.FieldValues['LIN_END_PK'];
          end;
          ExpTable.FieldValues['Номер']:=i;
          ExpTable.FieldValues['Огранич_км/ч']:=fmMain.IBQR_TEMP.FieldValues['Speed'];
          ExpTable.Post;
          if i<> 1 then fmMain.IBQR_TEMP.Prior;
         end;
         ExpTable.Close;
         ExpTable.Free;
         fmMain.IBTR_TEMP.Commit;
         Application.MessageBox(Pchar('Файл "'+ExpTable.TableName+'.db" успешно создан!'), 'Внимание!', MB_OK or MB_DEFBUTTON1 +
         MB_ICONINFORMATION + MB_TOPMOST);
      except
         if fmMain.IBTR_TEMP.intransaction then fmMain.IBTR_TEMP.Rollback;
          Application.MessageBox('Ошибка при создании файла!', 'Внимание!', MB_OK or MB_DEFBUTTON1 +
         MB_ICONSTOP + MB_TOPMOST);
      end;
   *)

  //создаем папку для файла
   CreateFileDir(file_name, str, put);
  //создаем таблицу paradox
  ExpTable:=TTable.Create(self);
  try
    with ExpTable do
    begin
     Active := False;
     DatabaseName := str+'\';
     TableType := ttParadox;
     TableName := 'ogran_'+inttostr(put)+'p';
      {Создаем поля:}
     with FieldDefs do begin
      Clear;
      with AddFieldDef do begin
          Name := 'Номер';
          DataType := ftWord;
      end; //with
      with AddFieldDef do begin
          Name := 'Название_станц';
          DataType := ftString;
          Size := 30;
      end; //with
      with AddFieldDef do begin
          Name := 'Нач_км';
          DataType := ftWord;
      end; //with
      with AddFieldDef do begin
          Name := 'Нач_пик';
          DataType := ftWord;
      end; //with
      with AddFieldDef do begin
          Name := 'Кон_км';
          DataType := ftWord;
      end; //with
      with AddFieldDef do begin
          Name := 'Кон_пик';
          DataType := ftWord;
      end; //with
      with AddFieldDef do begin
          Name := 'Огранич_км/ч';
          DataType := ftWord;
      end; //with
     end; //with
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
       SQL.LoadFromFile(SQL_DIR+'L_Select.sql');
       ParamByName('DIR_ID').AsInteger:=fmMain.FDQ_DIR.FieldByName('ID').Value;
       if not fl_Shift then  SQL.Add('ORDER BY L.beg_km, L.beg_pk') else SQL.Add('ORDER BY LIN_KOORD') ;
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
         ExpTable.FieldValues['Нач_км']:=fmMain.FDQ_TEMP.FieldValues['beg_km'];
         ExpTable.FieldValues['Нач_пик']:=fmMain.FDQ_TEMP.FieldValues['beg_pk'];
         ExpTable.FieldValues['Кон_км']:=fmMain.FDQ_TEMP.FieldValues['end_km'];
         ExpTable.FieldValues['Кон_пик']:=fmMain.FDQ_TEMP.FieldValues['end_pk'];
         ExpTable.FieldValues['Огранич_км/ч']:=fmMain.FDQ_TEMP.FieldValues['Speed'];
       end else
       begin
         ExpTable.FieldValues['Нач_км']:=fmMain.FDQ_TEMP.FieldValues['LIN_BEG_KM'];
         ExpTable.FieldValues['Нач_пик']:=fmMain.FDQ_TEMP.FieldValues['LIN_BEG_PK'];
         ExpTable.FieldValues['Кон_км']:=fmMain.FDQ_TEMP.FieldValues['LIN_END_KM'];
         ExpTable.FieldValues['Кон_пик']:=fmMain.FDQ_TEMP.FieldValues['LIN_END_PK'];
       end;
       ExpTable.FieldValues['Номер']:=i;
       ExpTable.FieldValues['Огранич_км/ч']:=fmMain.FDQ_TEMP.FieldValues['Speed'];
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

//Импорт  данных из таблицы DB
procedure TfmLimits.ImportFromDBClick(Sender: TObject);
var
i:word; s:string;
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
      CommandText.LoadFromFile(SQL_DIR+'L_Import.sql');
     end;

    while not qtimport.Eof do
      begin
        FDT_WRITE_LIM.StartTransaction;
        FDCmd.ParamByName('new_Dir_key').Value:=DIR_ID;
        FDCmd.ParamByName('new_BEG_KM').Value:=qtimport.FieldValues['Нач_км'];
        FDCmd.ParamByName('new_BEG_PK').Value:=qtimport.FieldValues['Нач_пик'];
        FDCmd.ParamByName('new_END_KM').Value:=qtimport.FieldValues['Кон_км'];
        FDCmd.ParamByName('new_END_PK').Value:=qtimport.FieldValues['Кон_пик'];
        FDCmd.ParamByName('new_SPEED').Value:=qtimport.FieldValues['Огранич_км/ч'];
        FDCmd.Execute();
        FDT_WRITE_LIM.Commit;
        qtimport.Next;
      end;
   except
    on E: Exception do
    begin
         if FDT_WRITE_LIM.Active then FDT_WRITE_LIM.Rollback;
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
   FDQ_LIM.Refresh;
 end;
end;

//импорт их xls
procedure TfmLimits.ImportFromXLSClick(Sender: TObject);
const
  xlCellTypeLastCell = $0000000B;
var
  XLApp, Sheet: OLEVariant;
  RangeMatrix: Variant;
  RangeMatrixFiltred: Variant;
  koord:LongInt;
  del:Integer;
  x, y, k, r, z: Integer;
  fl_add_filtr:Boolean;
  AGrid: TStringGrid;
  i,j:Integer;
  ind_beg,ind_end:Integer;
  Prep_key:Byte;
  tmp_koord,tmp_koord1,tmp_koord0:LongInt;
  tmp_pik,st_len:Word;
begin
if ImportDialog.Execute then
 begin
  // Create Excel-OLE Object
  XLApp := CreateOleObject('Excel.Application');
  AGrid:= TStringGrid.Create(Self);
  try
    // Hide Excel
    XLApp.Visible := False;
    // Open the Workbook
    XLApp.Workbooks.Open(ImportDialog.FileName);
    // Sheet := XLApp.Workbooks[1].WorkSheets[1];
    Sheet := XLApp.Workbooks[ExtractFileName(ImportDialog.FileName)].WorkSheets[1];
    // In order to know the dimension of the WorkSheet, i.e the number of rows
    // and the number of columns, we activate the last non-empty cell of it
    Sheet.Cells.SpecialCells(xlCellTypeLastCell, EmptyParam).Activate;
    // Get the value of the last row
    x := XLApp.ActiveCell.Row;
    // Get the value of the last column
    y := 4;//XLApp.ActiveCell.Column;
    // Set Stringgrid's row &col dimensions.
    AGrid.RowCount := x;
    AGrid.ColCount := y;
    // Assign the Variant associated with the WorkSheet to the Delphi Variant
    RangeMatrix := XLApp.Range['A1', XLApp.Cells.Item[X, Y]].value;
    //  Define the loop for filling in the TStringGrid
  //  fmImport.clbFilterObjects.Items.Add(AnsiLowerCase (RangeMatrix[2, 2]));     //[строка;столбец]
  //  fmImport.clbFilterPath.Items.Add(RangeMatrix[2, 3]);
    k := 1;
    repeat
      for r := 1 to y do
    //  if (R=2) and (K>1) then AGrid.Cells[(r - 0), (k - 1)] := AnsiLowerCase(RangeMatrix[K, R]) else
      AGrid.Cells[(r - 0), (k - 1)] := RangeMatrix[K, R];
      // добавляем фильтры  со второй строки, т.к. первая это заголовок
      { if K>1 then
      begin
       // по объектам
        fl_add_filtr:=true;
        for z:=0 to  fmImport.clbFilterObjects.Count-1 do
        if fmImport.clbFilterObjects.Items[z]=AnsiLowerCase (RangeMatrix[K, 2]) then fl_add_filtr:=False;
        if fl_add_filtr then fmImport.clbFilterObjects.Items.Add(AnsiLowerCase(RangeMatrix[k, 2]));  }
       {// по путям
        fl_add_filtr:=true;
        for z:=0 to  fmImport.clbFilterPath.Count-1 do
        if fmImport.clbFilterPath.Items[z]=RangeMatrix[K, 3] then fl_add_filtr:=False;
        if fl_add_filtr then fmImport.clbFilterPath.Items.Add(RangeMatrix[k, 3]);  
      end;                                                                         }
      Inc(k, 1);
      AGrid.RowCount := k + 1;
    until k > x;
    // Unassign the Delphi Variant Matrix
    RangeMatrix := Unassigned;
      try
       if (DIR_ID<>null) then
       begin
        for i:=0 to x-1 do
        begin
         begin
          tmp_koord:=StrToInt(AGrid.Cells[1,i]);
          tmp_koord1:=StrToInt(AGrid.Cells[2,i]);
          with fmMain.IBDS_Limits do
          begin
            Insert;
            FieldByName('BEG_KM').Value:=(tmp_koord div 1000)+1;
            tmp_pik:=(tmp_koord mod 1000) div 100;
            FieldByName('BEG_PK').Value:=tmp_pik+1;

            FieldByName('END_KM').Value:=(tmp_koord1 div 1000)+1;
            tmp_pik:=(tmp_koord1 mod 1000) div 100;
            FieldByName('END_PK').Value:=tmp_pik+1;
            FieldByName('Speed').Value:=AGrid.Cells[3,i];
            FieldByName('Note').Value:=AGrid.Cells[4,i];
            FieldByName('Shift_KEY').Value:=null;
            Post;
          end;
         end;
        end;
       end;
        Application.MessageBox('Данные успешно импортированы', 'Внимание!', MB_OK +
        MB_ICONINFORMATION + MB_TOPMOST);
      except
        Application.MessageBox('Ошибка при импорте данных', 'Внимание!', MB_OK +
          MB_ICONERROR + MB_TOPMOST);
      end;

  finally
    // Quit Excel
    if not VarIsEmpty(XLApp) then
    begin
      // XLApp.DisplayAlerts := False;
      XLApp.Quit;
      XLAPP := Unassigned;
      Sheet := Unassigned;
      AGrid.Destroy;
    end;
  end;
 end;

end;

end.


