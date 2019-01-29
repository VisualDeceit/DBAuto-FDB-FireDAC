unit unTimeTable;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ExtCtrls, DBCtrls, DBGrids, DBTables, StdCtrls, Menus,
  DBGridEhGrouping, GridsEh, DBGridEh,ShellAPI, ImgList, ComCtrls, ToolWin,EhLibIBX,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL, DBAxisGridsEh, XMLIntf, XMLDoc;

type
  TfmTimeTable = class(TForm)
    DBG_TrainNo: TDBGridEh;
    DBG_TimeTable: TDBGridEh;
    Splitter1: TSplitter;
    ToolBar2: TToolBar;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    pmTrainEdit: TPopupMenu;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    pmTrainCopy: TPopupMenu;
    N4: TMenuItem;
    N5: TMenuItem;
    pmTrainCreate: TPopupMenu;
    N6: TMenuItem;
    N7: TMenuItem;
    pmTimeTableEdit: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    ToolButton1: TToolButton;
    pmImport: TPopupMenu;
    DB1: TMenuItem;
    N2: TMenuItem;
    procedure N1Click(Sender: TObject);
    procedure DBG_TimeTableDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh;
      State: TGridDrawState);
    procedure N2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure DBG_TrainNoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DB1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTimeTable: TfmTimeTable;
  Tr_ID_old:integer;
  procedure CopyTrain(flag:Boolean);
implementation

uses unLimits, unMain, unVars, unDirection, unTrains, unStations;

{$R *.dfm}

procedure TfmTimeTable.DBG_TimeTableDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  DBG_TimeTable.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfmTimeTable.N2Click(Sender: TObject);
begin

end;

//Импорт расписания из БД без станций
var impDBpath,impDBname:string;
procedure TfmTimeTable.N1Click(Sender: TObject);
var
Tr_ID_temp:string;
r_count:integer;
i:word; s:string;
Err_Code: Byte;
Err_str: string;
qtimport: TQuery;
begin
 try
  Err_Code:=0;
  if (fmMain.OpenDialog1.Execute) and (DIR_ID<>null) then
  begin
    with fmMain.IBSQL do
    begin
     Close;
     SQL.Clear;
     SQL.LoadFromFile(SQL_DIR+'TR_Insert.sql');
     Params.ByName('DIR_ID').AsInteger:=fmMain.IBDS_DirectionsID.Value;
     fmMain.IBTR_WRITE.StartTransaction;
     ExecQuery;
     fmMain.IBTR_WRITE.Commit;
     SQL.Clear;
     SQL.Add('SELECT GEN_ID(GEN_TRAINS_ID, 0) FROM RDB$DATABASE');
     fmMain.IBTR_WRITE.StartTransaction;
     ExecQuery;
     fmMain.IBTR_WRITE.Commit;
    end;
    Tr_ID:=IntToStr(fmMain.IBSQL.Fields[0].Value);

    //определение пути и имени импортируемой БД
    impDBpath:=fmMain.OpenDialog1.FileName;
    s:='';
    for i:=Length(impDBpath) downto 0 do
    if impDBpath[i]<>'\' then s:=s+impDBpath[i] else Break;
    Delete(impDBpath,Length(impDBpath)+1-Length(s),Length(s));
    delete(s,1,3);
    impDBname:='';
    for i:=Length(s) downto 1 do impDBname:=impDBname+s[i];

    qtimport:= TQuery.Create(self);
    //открытие импортируемой БД
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
    fmMain.IBDS_TIME_TABLE.DisableControls;
    while not qtimport.Eof do
    begin
     Err_Code:=2;
      with fmMain.IBSQL do
      begin
       Close;
       SQL.Clear;
       SQL.LoadFromFile(SQL_DIR+'TT_Import.sql');
       Params.ByName('TprCh').AsInteger:=qtimport.FieldValues['TprCh'];
       Params.ByName('TprMin').AsInteger:=qtimport.FieldValues['TprMin'];
       Params.ByName('TstMin').AsInteger:=qtimport.FieldValues['TstMin'];
       Params.ByName('Tr_ID').AsInteger:=StrToInt(Tr_ID);
       fmMain.IBTR_WRITE.StartTransaction;
       ExecQuery;
       fmMain.IBTR_WRITE.Commit;
      end;
      qtimport.Next;
    end;
    fmMain.IBDS_TIME_TABLE.EnableControls;
    qtimport.Close;
    qtimport.free;
    DS_Refresh_All;
    Application.MessageBox('Расписание успешно импортировано!', 'Внимание!', MB_OK or MB_DEFBUTTON1 +
    MB_ICONINFORMATION + MB_TOPMOST);
   end;
  except
    fmMain.IBDS_TIME_TABLE.EnableControls;
    case Err_Code of
      0: err_str:='';
      1: err_str:='Невозможно открыть файл!';
      2: err_str:='Неверный формат файла!';
    end;
     if qtimport.Active then
     begin
      qtimport.Close;
      qtimport.free;
     end;
    Application.MessageBox(PWideChar('Ошибка импортирования.'+' '+err_str), 'Ошибка', MB_OK
  + MB_ICONSTOP + MB_TOPMOST);
 end;
end;

procedure TfmTimeTable.FormClose(Sender: TObject;
  var Action: TCloseAction);
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
    LNode:=LNodeChild.ChildNodes.FindNode('TimeTable');
    TTSettings.width:=fmTimeTable.width;
    TTSettings.Height:=fmTimeTable.height;
    TTSettings.Left:=fmTimeTable.left;
    TTSettings.Top:=fmTimeTable.top;
    LNode.SetAttribute('visible',TTSettings.visible);
    LNode.SetAttribute('height', TTSettings.height);
    LNode.SetAttribute('width',  TTSettings.width);
    LNode.SetAttribute('left',   TTSettings.left);
    LNode.SetAttribute('top',    TTSettings.top);

    LDocument.SaveToFile(extractfilepath(application.ExeName)+'Setup.xml');
    LDocument.Active:=false;
  finally

  end;
 Action:=caFree;
 fmMain.tbTimetable.Down:=False;
 if  fmMain.IBDS_Trains.State in [dsEdit] then  fmMain.IBDS_Trains.Post;
 if  fmMain.IBDS_TIME_TABLE.State in [dsEdit] then  fmMain.IBDS_TIME_TABLE.Post;
end;

procedure TfmTimeTable.MenuItem1Click(Sender: TObject);
begin
 fmMain.IBDS_TIME_TABLE.Insert;
end;

procedure TfmTimeTable.MenuItem2Click(Sender: TObject);
begin
 fmMain.IBDS_TIME_TABLE.Delete;
end;

procedure TfmTimeTable.N4Click(Sender: TObject);
begin
 CopyTrain(False);
end;

procedure TfmTimeTable.N5Click(Sender: TObject);
begin
 CopyTrain(true);
end;

//создание одного файла расписания
procedure TfmTimeTable.N6Click(Sender: TObject);
var
  i:word;
  r_count:word;
  dir:Byte;
  num:Word;
  file_name:string;
  str:string;
  deb_txt:TextFile;
  mes:string;
  SQL_Str:string;
  arr_koord:array[1..100] of Integer;
label L1;
begin
 DIR_ID:=IntToStr(fmMain.IBDS_DirectionsID.Value);
 Tr_ID:=IntToStr(fmMain.IBDS_TrainsID.Value);
 if fmMain.IBTR_TEMP.InTransaction then fmMain.IBTR_TEMP.Commit;
 try
  with fmMain.IBQR_TEMP do
  begin
   Close;
   SQL.Clear;
   SQL.LoadFromFile(SQL_DIR+'TT_Select.sql');
   ParamByName('Tr_ID').AsInteger:=fmMain.IBDS_TrainsID.Value;
   if  not fl_Shift then
   begin
    if Way=2 then  SQL.Add('ORDER BY S.Koord') else SQL.Add('ORDER BY S.Koord DESC');
   end else
   begin
    if Way=2 then  SQL.Add('ORDER BY LIN_KOORD') else SQL.Add('ORDER BY LIN_KOORD DESC');
   end;
   fmMain.IBTR_TEMP.StartTransaction;
   Open;
   Last;
   First;
   r_count:=fmMain.IBQR_TEMP.RecordCount;
   if r_count=0 then
   begin
     Application.MessageBox('Невозможно создать файл расписания. Отсутствуют станции!','Ошибка', MB_OK+ MB_ICONSTOP + MB_TOPMOST);
     if fmMain.IBTR_TEMP.InTransaction then fmMain.IBTR_TEMP.Rollback;
     Exit;
   end;
  end ;
   dir:=fmMain.IBDS_Directions.FieldValues['Code'];
   num:=fmMain.IBDS_TrainsNUMBER.Value;
   file_name:='';
   if dir<10  then file_name:='0'+IntToStr(dir) else  file_name:=IntToStr(dir);
   if num<10  then file_name:=file_name+'00'+inttostr(num) else
   if num<100 then file_name:=file_name+'0'+inttostr(num) else
                   file_name:=file_name+inttostr(num);
   str:=extractfilepath(application.ExeName)+'files\'+
                             IntToStr(fmMain.IBDS_Directions.FieldValues['Code'])+' '+
                             fmMain.IBDS_Directions.FieldValues['FName'];
  if not DirectoryExists(str) then  CreateDir(str);
   for i:=1 to r_count do
    begin
      if fmMain.IBQR_TEMP.FieldValues['FNAME']=null then
      begin
       Application.MessageBox('Невозможно создать файл расписания. Укажите все станции','Ошибка', MB_OK+ MB_ICONSTOP + MB_TOPMOST);
       if fmMain.IBTR_TEMP.InTransaction then fmMain.IBTR_TEMP.Rollback;
       Exit;
      end;
     rsp[i].im:=fmMain.IBQR_TEMP.FieldValues['Fname'];
     if not fl_Shift then rsp[i].kr:=fmMain.IBQR_TEMP.FieldValues['koord'] else rsp[i].kr:=fmMain.IBQR_TEMP.FieldValues['LIN_KOORD'];
     rsp[i].pH:=fmMain.IBQR_TEMP.FieldValues['Hours'];
     rsp[i].pM:=fmMain.IBQR_TEMP.FieldValues['Minuts'];
     if fmMain.IBQR_TEMP.FieldValues['Stop']<>null then rsp[i].SM:=fmMain.IBQR_TEMP.FieldValues['Stop']
                                  else rsp[i].SM:=0;
     //проверка расписания
     if i>1 then
     begin
        if { ( (rsp[i-1].pH<>23) and ((rsp[i].pH<>0) or (rsp[i].pH<>1)) ) and
            ( (rsp[i].pH*60+rsp[i].pM<=rsp[i-1].pH*60+rsp[i-1].pM+rsp[i-1].SM) ) or }
       { (((rsp[i].pH<>0) or ((rsp[i].pH=0) and ((rsp[i-1].pH=0)))) and (rsp[i].pH*60+rsp[i].pM<=rsp[i-1].pH*60+rsp[i-1].pM+rsp[i-1].SM))  or
        ((((rsp[i].pH=0) and (rsp[i-1].pH<>0)) or ((rsp[i].pH=1) and (rsp[i-1].pH<>1))) and ((rsp[i].pH+24)*60+rsp[i].pM<=rsp[i-1].pH*60+rsp[i-1].pM+rsp[i-1].SM))  }
        ((rsp[i].pH<rsp[i-1].pH)  and  ((rsp[i].pH+24)*60+rsp[i].pM<=rsp[i-1].pH*60+rsp[i-1].pM+rsp[i-1].SM)) or
        ((rsp[i].pH>=rsp[i-1].pH) and  (rsp[i].pH*60+rsp[i].pM<=rsp[i-1].pH*60+rsp[i-1].pM+rsp[i-1].SM))
            then
        begin
         Application.MessageBox(PChar('Невозможно создать файл расписания. Ошибка в строке № '+inttostr(i)+'.'), 'Ошибка', MB_OK
          + MB_ICONSTOP + MB_TOPMOST);
         if fmMain.IBTR_TEMP.InTransaction then fmMain.IBTR_TEMP.Rollback;
         exit;
        end;
     end;
     if i<> r_count then fmMain.IBQR_TEMP.Next;
    end;
    fmMain.IBTR_TEMP.Commit;
   if FileExists(str+'\'+file_name+'.rsp')=True then
   begin
     mes:='Папка уже содержит файл "'+file_name+'.rsp".'+#13+#13+
        'Заменить имеющийся файл'+#13+#13+
        '   '+IntToStr(GetFileSize(str+'\'+file_name+'.rsp'))+ ' Байт'+#13+
        '   Дата изменения: '+GetFileDate(str+'\'+file_name+'.rsp')+#13+#13+
        'новым файлом?';
    if Application.MessageBox(PWideChar(mes),
     'Подтверждение замены файла', MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES then
    begin
L1:
      assignfile(frsp,str+'\'+file_name+'.rsp');
      rewrite(frsp);
      assignFile(deb_txt,str+'\'+file_name+'.rsp.txt');
      Rewrite(deb_txt);
      for i:=1 to r_count do
      begin
       write(frsp,rsp[i]);
       Writeln(deb_txt, rsp[i].im:20,'  ',rsp[i].kr:9,'  ', rsp[i].pH:2,'  ', rsp[i].pM:2,'  ', rsp[i].SM:2);
      end;
      closefile(frsp);
     closefile(deb_txt);
      Application.MessageBox(PChar('Файл "'+file_name+'.rsp" успешно создан!'), 'Внимание!', MB_OK or MB_DEFBUTTON1 +
      MB_ICONINFORMATION + MB_TOPMOST);
    end;
   end else goto L1;
  except
    if fmMain.IBTR_TEMP.InTransaction then fmMain.IBTR_TEMP.Rollback;
    Application.MessageBox('Невозможно создать файл расписания!', 'Ошибка', MB_OK
  + MB_ICONSTOP + MB_TOPMOST);
  end;
end;

//создать все файлы расписаний сразу
procedure TfmTimeTable.N7Click(Sender: TObject);
var
  i,j:word;
  r_count,r_count_all:word;
  dir:Byte;
  num:Word;
  file_name:string;
  str:string;
  deb_txt:TextFile;
  mes:string;
  SQL_STR:string;
label L1, L2;
begin
try
 DIR_ID:=IntToStr(fmMain.IBDS_DirectionsID.Value);
 if fmMain.IBTR_TEMP.InTransaction then fmMain.IBTR_TEMP.Commit;
 with fmMain.IBQR_TEMP2 do
 begin
   Close;
   SQL.Clear;
   SQL.LoadFromFile(SQL_DIR+'TR_Select.sql');
   ParamByName('DIR_ID').AsInteger:=fmMain.IBDS_DirectionsID.Value;
   fmMain.IBTR_TEMP.StartTransaction;
   Open;
   Last;
   First;
   r_count_all:=RecordCount;
   if r_count_all=0 then
   begin
     Application.MessageBox('Невозможно создать файлы расписаний. Отсутствуют поезд!','Ошибка', MB_OK+ MB_ICONSTOP + MB_TOPMOST);
     if fmMain.IBTR_TEMP.InTransaction then fmMain.IBTR_TEMP.Rollback;
     Exit;
   end;
 end;
 for j:=1 to r_count_all do
 begin
  with fmMain.IBQR_TEMP do
  begin
   Close;
   SQL.Clear;
   SQL.LoadFromFile(SQL_DIR+'TT_Select.sql');
   ParamByName('Tr_ID').AsInteger:=fmMain.IBQR_TEMP2.FieldValues['ID'];
   if  not fl_Shift then
   begin
    if Way=2 then  SQL.Add('ORDER BY S.Koord') else SQL.Add('ORDER BY S.Koord DESC');
   end
   else
   begin
    if Way=2 then  SQL.Add('ORDER BY LIN_KOORD') else SQL.Add('ORDER BY LIN_KOORD DESC');
   end;
   Open;
   Last;
   First;
   r_count:=RecordCount;
   if r_count=0 then
    begin
      Application.MessageBox(PChar('Невозможно создать файл расписания № '+inttostr(fmMain.IBQR_TEMP2.FieldValues['number'])+'. Отсутствуют станции!'), 'Ошибка', MB_OK
      + MB_ICONSTOP + MB_TOPMOST);
L2:     if j<> r_count_all then fmMain.IBQR_TEMP2.Next;
       Continue;
    end;
    dir:=fmMain.IBDS_Directions.FieldValues['Code'];
    num:=fmMain.IBQR_TEMP2.FieldValues['number'];
     file_name:='';
     if dir<10  then file_name:='0'+IntToStr(dir) else  file_name:=IntToStr(dir);
     if num<10  then file_name:=file_name+'00'+inttostr(num) else
     if num<100 then file_name:=file_name+'0'+inttostr(num) else
                     file_name:=file_name+inttostr(num);
     str:=extractfilepath(application.ExeName)+'files\'+
                               IntToStr(fmMain.IBDS_Directions.FieldValues['Code'])+' '+
                               fmMain.IBDS_Directions.FieldValues['FName'];
     if not DirectoryExists(str) then  CreateDir(str);
      for i:=1 to r_count do
      begin
        if fmMain.IBQR_TEMP.FieldValues['fname']=null then
        begin
           Application.MessageBox(PChar('Невозможно создать файл расписания № '+inttostr(num)+'.'+#13+'Укажите все станции'), 'Ошибка', MB_OK
            + MB_ICONSTOP + MB_TOPMOST);
           goto L2;
        end;
       rsp[i].im:=fmMain.IBQR_TEMP.FieldValues['fname'];
       if not fl_Shift then rsp[i].kr:=fmMain.IBQR_TEMP.FieldValues['koord'] else rsp[i].kr:=fmMain.IBQR_TEMP.FieldValues['LIN_KOORD'];
       rsp[i].pH:=fmMain.IBQR_TEMP.FieldValues['Hours'];
       rsp[i].pM:=fmMain.IBQR_TEMP.FieldValues['Minuts'];
       if fmMain.IBQR_TEMP.FieldValues['Stop']<>null then rsp[i].SM:=fmMain.IBQR_TEMP.FieldValues['Stop']
                                    else rsp[i].SM:=0;
       //проверка расписания
       if i>1 then
       begin
          if { ( (rsp[i-1].pH<>23) and ((rsp[i].pH<>0) or (rsp[i].pH<>1)) ) and
              ( (rsp[i].pH*60+rsp[i].pM<=rsp[i-1].pH*60+rsp[i-1].pM+rsp[i-1].SM) )    }
       { (((rsp[i].pH<>0) or ((rsp[i].pH=0) and ((rsp[i-1].pH=0)))) and (rsp[i].pH*60+rsp[i].pM<=rsp[i-1].pH*60+rsp[i-1].pM+rsp[i-1].SM))  or
        ((rsp[i].pH=0) and (rsp[i-1].pH<>0) and ((rsp[i].pH+24)*60+rsp[i].pM<=rsp[i-1].pH*60+rsp[i-1].pM+rsp[i-1].SM))      }
        ((rsp[i].pH<rsp[i-1].pH)  and  ((rsp[i].pH+24)*60+rsp[i].pM<=rsp[i-1].pH*60+rsp[i-1].pM+rsp[i-1].SM)) or
        ((rsp[i].pH>=rsp[i-1].pH) and  (rsp[i].pH*60+rsp[i].pM<=rsp[i-1].pH*60+rsp[i-1].pM+rsp[i-1].SM))
              then
          begin
          Application.MessageBox(PChar('Невозможно создать файл расписания № '+inttostr(num)+'.'+#13+'Ошибка в строке № '+inttostr(i)+'.'), 'Ошибка', MB_OK
            + MB_ICONSTOP + MB_TOPMOST);
           goto L2;
          end;
       end;
       if i<> r_count then fmMain.IBQR_TEMP.Next;
      end;
       if FileExists(str+'\'+file_name+'.rsp')=True then
       begin
         mes:='Папка уже содержит файл "'+file_name+'.rsp".'+#13+#13+
            'Заменить имеющийся файл'+#13+#13+
            '   '+IntToStr(GetFileSize(str+'\'+file_name+'.rsp'))+ ' Байт'+#13+
            '   Дата изменения: '+GetFileDate(str+'\'+file_name+'.rsp')+#13+#13+
            'новым файлом?';
        if Application.MessageBox(PWideChar(mes),
         'Подтверждение замены файла', MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES then
        begin
  L1:
          assignfile(frsp,str+'\'+file_name+'.rsp');
          rewrite(frsp);
          assignFile(deb_txt,str+'\'+file_name+'.rsp.txt');
          Rewrite(deb_txt);
          for i:=1 to r_count do
          begin
           write(frsp,rsp[i]);
           Writeln(deb_txt, rsp[i].im:20,'  ',rsp[i].kr:9,'  ', rsp[i].pH:2,'  ', rsp[i].pM:2,'  ', rsp[i].SM:2);
          end;
         closefile(frsp);
         CloseFile(deb_txt);
         Application.MessageBox(PChar('Файл "'+file_name+'.rsp" успешно создан!'), 'Внимание!', MB_OK or MB_DEFBUTTON1 +
         MB_ICONINFORMATION + MB_TOPMOST);
        end;
       end else goto L1;
  end;
  if j<> r_count_all then fmMain.IBQR_TEMP2.Next;
 end;
  fmMain.IBTR_TEMP.Commit;
 except
  if fmMain.IBTR_TEMP.InTransaction then fmMain.IBTR_TEMP.Rollback;
  Application.MessageBox('Невозможно создать файлы расписания!', 'Ошибка', MB_OK
  + MB_ICONSTOP + MB_TOPMOST);
 end;
end;

//копирование расписания
procedure CopyTrain(flag:Boolean);
var
sql_txt:string;
sql_list:TStringList;
sql_ind:Byte;
begin
  DIR_ID:=IntToStr(fmMain.IBDS_DirectionsID.Value);
  Tr_ID_old:=fmMain.IBDS_TrainsID.Value;
  try
    with fmMain.IBSQL do
    begin
     Close;
     SQL.Clear;
     SQL.LoadFromFile(SQL_DIR+'TR_Insert.sql');
     Params.ByName('DIR_ID').AsInteger:=fmMain.IBDS_DirectionsID.Value;
     fmMain.IBTR_WRITE.StartTransaction;
     ExecQuery;
     fmMain.IBTR_WRITE.Commit;
     SQL.Clear;
     SQL.Add('SELECT GEN_ID(GEN_TRAINS_ID, 0) FROM RDB$DATABASE');
     fmMain.IBTR_WRITE.StartTransaction;
     ExecQuery;
     fmMain.IBTR_WRITE.Commit;
    end;
    Tr_ID:=IntToStr(fmMain.IBSQL.Fields[0].Value);
    with fmMain.IBSQL do
    begin
      close;
      ParamCheck:=False;
      SQL.Clear;
      SQL.LoadFromFile(SQL_DIR+'TT_copy_begin.sql');
      fmMain.IBTR_WRITE.StartTransaction;
      ExecQuery;
      fmMain.IBTR_WRITE.Commit;
      ParamCheck:=True;
    end;

    sql_list:=TStringList.Create;
    if not flag then
    sql_list.LoadFromFile(SQL_DIR+'TT_Copy_var1.sql') else
    sql_list.LoadFromFile(SQL_DIR+'TT_Copy_var2.sql');
    with fmMain.IBSQL do
    begin
      Close;
      for sql_ind:=0 to sql_list.Count-1 do
      begin
        SQL.Clear;
        SQL.Add(sql_list.Strings[sql_ind]);
        fmMain.IBTR_WRITE.StartTransaction;
        if sql_ind=0 then  ParamByName('TR_ID1').AsInteger:=Tr_ID_old;
        if sql_ind=2 then  ParamByName('TR_ID2').AsInteger:=StrToInt(Tr_ID);
        ExecQuery;
        fmMain.IBTR_WRITE.Commit;
      end
    end;
    sql_list.Free;
    with fmMain.IBSQL do
    begin
      Close;
      ParamCheck:=False;
      SQL.Clear;
      SQL.LoadFromFile(SQL_DIR+'TT_Copy_end.sql');
      fmMain.IBTR_WRITE.StartTransaction;
      ExecQuery;
      fmMain.IBTR_WRITE.Commit;
      ParamCheck:=True;
    end;  
    DS_Refresh_All;
  except
    if   fmMain.IBTR_WRITE.InTransaction then  fmMain.IBTR_WRITE.Rollback;
    DS_Refresh_All;
  end;
end;

procedure TfmTimeTable.N8Click(Sender: TObject);
begin
 fmMain.IBDS_Trains.Insert;
end;

procedure TfmTimeTable.FormDestroy(Sender: TObject);
begin
 fmTimeTable:=nil;
end;

procedure TfmTimeTable.N9Click(Sender: TObject);
begin
  if Application.MessageBox('Вы дейтсвительно хотите удалить расписание?',
    'Удаление расписания', MB_YESNO + MB_ICONWARNING + MB_TOPMOST) = IDYES then
   begin
    Tr_ID:=IntToStr(fmMain.IBDS_TrainsID.Value);
    with fmMain.IBSQL do
    begin
      close;
      SQL.Clear;
      SQL.Add('DELETE FROM TIME_TABLE WHERE TRAIN_KEY='+Tr_ID);
      fmMain.IBTR_WRITE.StartTransaction;
      ExecQuery;
      fmMain.IBTR_WRITE.Commit;
    end;
    fmMain.IBDS_Trains.Delete;
   end;
end;

procedure TfmTimeTable.DBG_TrainNoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
 DBG_TrainNo.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

//Импорт станций в расписание из таблицы станций
procedure TfmTimeTable.DB1Click(Sender: TObject);
var
Tr_ID_temp:string;
r_count:integer;
 SQL_str:string;
begin
 try
  with fmMain.IBSQL do
  begin
   Close;
   SQL.Clear;
   SQL.LoadFromFile(SQL_DIR+'TR_Insert.sql');
   Params.ByName('DIR_ID').AsInteger:=fmMain.IBDS_DirectionsID.Value;
   fmMain.IBTR_WRITE.StartTransaction;
   ExecQuery;
   fmMain.IBTR_WRITE.Commit;
   SQL.Clear;
   SQL.Add('SELECT GEN_ID(GEN_TRAINS_ID, 0) FROM RDB$DATABASE');
   fmMain.IBTR_WRITE.StartTransaction;
   ExecQuery;
   fmMain.IBTR_WRITE.Commit;
  end;
  Tr_ID:=IntToStr(fmMain.IBSQL.Fields[0].Value);

  if fmMain.IBTR_TEMP.InTransaction then fmMain.IBTR_TEMP.Commit;
  with fmMain.IBQR_TEMP do
  begin
   Close;
   SQL.Clear;
   SQL.LoadFromFile(SQL_DIR+'S_Select.sql');
   ParamByName('DIR_ID').AsInteger:=fmMain.IBDS_DirectionsID.Value;
   if  not fl_Shift then
   begin
    if Way=2 then  SQL.Add('ORDER BY S.Koord') else SQL.Add('ORDER BY S.Koord DESC');
   end else
   begin
    if Way=2 then  SQL.Add('ORDER BY LIN_KOORD') else SQL.Add('ORDER BY LIN_KOORD DESC');
   end;
   fmMain.IBTR_TEMP.StartTransaction;
   Open;
   Last;
   First;
   if RecordCount=0 then
   begin
     Application.MessageBox('Невозможно импортировать. Отсутствуют станции!','Ошибка', MB_OK+ MB_ICONSTOP + MB_TOPMOST);
     if fmMain.IBTR_TEMP.InTransaction then fmMain.IBTR_TEMP.Rollback;
     Exit;
   end;
  end ;
  fmMain.IBDS_TIME_TABLE.DisableControls;
  while not fmMain.IBQR_TEMP.Eof do
  begin
     with fmMain.IBSQL do
      begin
       Close;
       SQL.Clear;
       SQL.LoadFromFile(SQL_DIR+'TT_Import2.sql');
       Params.ByName('St_ID').AsInteger:=fmMain.IBQR_TEMP.FieldValues['ID'];
       Params.ByName('Tr_ID').AsInteger:=StrToInt(Tr_ID);
       fmMain.IBTR_WRITE.StartTransaction;
       ExecQuery;
       fmMain.IBTR_WRITE.Commit;
      end;
   fmMain.IBQR_TEMP.Next;
  end;
   fmMain.IBDS_TIME_TABLE.EnableControls;
   DS_Refresh_All;
   Application.MessageBox('Станции успешно импортированы!', 'Внимание!', MB_OK or MB_DEFBUTTON1 +
   MB_ICONINFORMATION + MB_TOPMOST);
  except
    fmMain.IBDS_TIME_TABLE.EnableControls;
    if fmMain.IBTR_TEMP.InTransaction then fmMain.IBTR_TEMP.Rollback;
    Application.MessageBox('Ошибка импортирования.', 'Ошибка', MB_OK
  + MB_ICONSTOP + MB_TOPMOST);
 end;
end;

end.



