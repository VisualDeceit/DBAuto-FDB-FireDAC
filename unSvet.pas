unit unSvet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, ExtCtrls, DBCtrls, Grids, DBGrids,
  DBGridEhGrouping, GridsEh, DBGridEh, Menus, StdCtrls,ShellAPI, ImgList,
  ComCtrls, ToolWin, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL,
  DBAxisGridsEh, XMLIntf, XMLDoc, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,FireDAC.Phys.IBWrapper;

type
  TfmSvet = class(TForm)
    pmSvet: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    ToolBar4: TToolBar;
    ToolButton6: TToolButton;
    DBG_Svet: TDBGridEh;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    DBNavigator1: TDBNavigator;
    DS_SV: TDataSource;
    FDQ_SV: TFDQuery;
    FDUSQL_SV: TFDUpdateSQL;
    FDT_WRITE_SV: TFDTransaction;
    FDQ_SVID: TFDAutoIncField;
    FDQ_SVDIR_KEY: TIntegerField;
    FDQ_SVSHIFT_KEY: TIntegerField;
    FDQ_SVFNAME: TStringField;
    FDQ_SVKOORD: TIntegerField;
    FDQ_SVSPEED: TIntegerField;
    FDQ_SVLIN_KOORD: TLargeintField;
    FDCmd: TFDCommand;
    procedure DBG_SvetDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton6Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure FDQ_SVAfterPost(DataSet: TDataSet);
    procedure FDQ_SVAfterDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSvet: TfmSvet;

implementation

uses  unMain, unVars, unDirection;

{$R *.dfm}

procedure TfmSvet.DBG_SvetDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  DBG_Svet.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfmSvet.FDQ_SVAfterDelete(DataSet: TDataSet);
begin
 if FDQ_SV.UpdatesPending then
      begin
       //старт транзакции на запись
        FDT_WRITE_SV.StartTransaction;
       //применяем изменения
       try
        if (FDQ_SV.ApplyUpdates = 0) then
        begin
         //очищаем журнал
         FDQ_SV.CommitUpdates;
         //завершаем транзакцию
         FDT_WRITE_SV.Commit;
        end else
         raise Exception.Create('Ошибка при удалении записи');
        except
          on E: Exception do
          begin
            if FDT_WRITE_SV.Active then FDT_WRITE_SV.Rollback;
            FDQ_SV.CommitUpdates;
            FDQ_SV.Refresh;
            Application.ShowException(E);
          end;
        end;
    end;
end;

procedure TfmSvet.FDQ_SVAfterPost(DataSet: TDataSet);
begin
 if FDQ_SV.UpdatesPending then
      begin
       //старт транзакции на запись
        FDT_WRITE_SV.StartTransaction;
       //применяем изменения
       try
        if (FDQ_SV.ApplyUpdates = 0) then
        begin
         //очищаем журнал
         FDQ_SV.CommitUpdates;
         //завершаем транзакцию
         FDT_WRITE_SV.Commit;
        end else
         raise Exception.Create('Ошибка при добавлении записи');
        except
          on E: Exception do
          begin
            if FDT_WRITE_SV.Active then FDT_WRITE_SV.Rollback;
            FDQ_SV.CommitUpdates;
            FDQ_SV.Refresh;
            Application.ShowException(E);
          end;
        end;
    end;
end;

procedure TfmSvet.FormClose(Sender: TObject; var Action: TCloseAction);
var
      LDocument: IXMLDocument;
        LNodeRoot, LNodeChild, LNode: IXMLNode;
begin
  try
    //сохраняем положение окна в файл настроек
    LDocument := TXMLDocument.Create(nil);
    LDocument.LoadFromFile(extractfilepath(application.ExeName)+'Setup.xml');
    LDocument.Active:=true;
    LNodeRoot := LDocument.ChildNodes.FindNode('Setup');

    LNodeChild:= LNodeRoot.ChildNodes.FindNode('Windows');
    LNode:=LNodeChild.ChildNodes.FindNode('Signals');
    SigSettings.width:=self.width;
    SigSettings.Height:=self.height;
    SigSettings.Left:=self.left;
    SigSettings.Top:=self.top;
    LNode.SetAttribute('visible',SigSettings.visible);
    LNode.SetAttribute('height', self.height);
    LNode.SetAttribute('width',  self.width);
    LNode.SetAttribute('left',   self.left);
    LNode.SetAttribute('top',    self.top);

    LDocument.SaveToFile(extractfilepath(application.ExeName)+'Setup.xml');
    LDocument.Active:=false;

    if FDQ_SV.UpdatesPending then
    begin
       //старт транзакции на запись
        FDT_WRITE_SV.StartTransaction;
       //применяем изменения
       try
        if (FDQ_SV.ApplyUpdates = 0) then
        begin
         //очищаем журнал
         FDQ_SV.CommitUpdates;
         //завершаем транзакцию
         FDT_WRITE_SV.Commit;
        end else
         raise Exception.Create('Ошибка при добавлении записи');
        except
          on E: Exception do
          begin
            if FDT_WRITE_SV.Active then FDT_WRITE_SV.Rollback;
            FDQ_SV.CommitUpdates;
            FDQ_SV.Refresh;
            Application.ShowException(E);
          end;
        end;
    end;
    // закрываем набор данных
    FDQ_SV.Close;
  finally
  end;
 Action:=caFree;
 fmMain.tbSvet.Down:=False;
end;

//создание файла
 procedure TfmSvet.ToolButton6Click(Sender: TObject);
var
  i:word;
  r_count:word;
  dir:Byte;
  put:byte;
  file_name:string;
  str:string;
  deb_txt:TextFile;
  mes,SQL_Str:string;
label L1;
begin
 try
  DIR_ID:=fmDirection.FDQ_DIR.FieldByName('ID').AsString;
  if  (FDQ_SV.FieldByName('ID').Value=null)  then
  raise ENoDataException.Create('Нет данных для создания файла');
  //считываем данные во временный Датасет
  with fmMain.FDQ_TEMP do
  begin
   Close;
   SQL.Clear;
   SQL.LoadFromFile(SQL_DIR+'LS_Select.sql');
   ParamByName('DIR_ID').AsInteger:=fmDirection.FDQ_DIR.FieldByName('ID').Value;
   if not fl_Shift then  SQL.Add('ORDER BY LS.KOORD') else SQL.Add('ORDER BY LIN_KOORD') ;
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
   //создаем папку для файлов
   dir:=fmDirection.FDQ_DIR.FieldByName('Code').Value;
   put:=fmDirection.FDQ_DIR.FieldByName('WAY').Value;
   file_name:='';
   if dir<10  then file_name:='0'+IntToStr(dir) else  file_name:=IntToStr(dir);
   file_name:=file_name+'p'+inttostr(put);
   str:=extractfilepath(application.ExeName)+'files\'+
                             fmDirection.FDQ_DIR.FieldByName('Code').AsString+' '+
                             fmDirection.FDQ_DIR.FieldByName('FName').AsString;
   if not DirectoryExists(str) then  CreateDir(str);
   if FileExists(str+'\'+file_name+'.svt')=True then
   begin
     mes:='Папка уже содержит файл "'+file_name+'.svt".'+#13+#13+
        'Заменить имеющийся файл'+#13+#13+
        '   '+IntToStr(GetFileSize(str+'\'+file_name+'.svt'))+ ' Байт'+#13+
        '   Дата создания: '+GetFileDate(str+'\'+file_name+'.svt')+#13+#13+
        'новым файлом?';
    if Application.MessageBox(PWideChar(mes),
     'Подтверждение замены файла', MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES then
    begin
L1:
     assignfile(fsvt,str+'\'+file_name+'.svt');
     assignFile(deb_txt,str+'\'+file_name+'.svt.txt');
     Rewrite(fsvt);
     Rewrite(deb_txt);
     //создаем файл
      for i:=1 to r_count do
      begin
       //проверка корректности ввода
       if (fmMain.FDQ_TEMP.FieldByName('KOORD').Value=null) or
          (fmMain.FDQ_TEMP.FieldByName('FNAME').Value='') or
          (fmMain.FDQ_TEMP.FieldByName('SPEED').Value=null) or
          (fmMain.FDQ_TEMP.FieldByName('SPEED').Value=0) then
          begin
            Closefile(fsvt); Deletefile(str+'\'+file_name+'.svt');
            CloseFile(deb_txt); Deletefile(str+'\'+file_name+'.svt.txt');
            raise EDataErrorException.Create('Ошибка при создании файла.'+#13+'Проверьте корректность данных в строке '+ inttostr(i)+'.');
          end;

        if not fl_Shift then
          svt[i].kr:=fmMain.FDQ_TEMP.FieldByName('KOORD').AsInteger
        else
          svt[i].kr:=fmMain.FDQ_TEMP.FieldByName('LIN_KOORD').AsInteger;
       svt[i].naz:=fmMain.FDQ_TEMP.FieldByName('FNAME').AsString;
       svt[i].vyel:=fmMain.FDQ_TEMP.FieldByName('SPEED').AsInteger;
       write(fsvt,svt[i]);
       Writeln(deb_txt, svt[i].kr:9,'  ',svt[i].naz:5,'  ', svt[i].vyel:2);
       if i<> r_count then fmMain.FDQ_TEMP.Next;
      end;
     closefile(fsvt);
     CloseFile(deb_txt);
      Application.MessageBox(PChar('Файл "'+file_name+'.svt" успешно создан!'),
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

procedure TfmSvet.FormDestroy(Sender: TObject);
begin
 fmSvet:=nil;
end;

//Импорт  данных из другой таблицы *.DB
var impDBpath,impDBname:string;
procedure TfmSvet.ToolButton1Click(Sender: TObject);
var
  i:word; s:string;
   qtimport: TQuery;
begin
 DIR_ID:=fmDirection.FDQ_DIR.FieldByName('ID').AsString;
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
  except
   on E: Exception do
     begin
     if qtimport.Active then  qtimport.Close;
     qtimport.free;
     Application.MessageBox(PWideChar('Ошибка при открытии файла *.DB:'+#13+#13+E.Message),
                                'Редактор базы данных автоведения',
                                MB_OK + MB_ICONERROR);
     exit;
    end;
   end;

  qtimport.First;
  //импорт данных в таблицу
    with FDCmd do
    begin
     Close;
     CommandText.Clear;
     CommandText.Add('INSERT INTO LIGHT_SIGNALS (Dir_key, Koord, FName, Speed)');
     CommandText.Add('VALUES (:new_Dir_key, :new_Koord, :new_FName, :new_Speed)');
    end;
    while not qtimport.Eof do
    begin
      try
        FDT_WRITE_SV.StartTransaction;
        FDCmd.ParamByName('new_Dir_key').Value:=DIR_ID;
        FDCmd.ParamByName('new_Koord').Value:=qtimport.FieldValues['Координата'];
        FDCmd.ParamByName('new_FName').Value:=qtimport.FieldValues['Назв_свет'];
        FDCmd.ParamByName('new_Speed').Value:=qtimport.FieldValues['Скор на желт'];
        FDCmd.Execute();
        FDT_WRITE_SV.Commit;
        qtimport.Next;
      except
        on E: Exception do
        begin
             if FDT_WRITE_SV.Active then FDT_WRITE_SV.Rollback;
             Application.MessageBox(PWideChar('Ошибка при импорте файла:'+#13+#13+E.Message),
                                'Редактор базы данных автоведения',
                                MB_OK + MB_ICONERROR);
         if qtimport.Active then  qtimport.Close;
         qtimport.free;
         exit;
        end;
      end;
    end;
   qtimport.Close;
   qtimport.free;
   FDQ_SV.Refresh;
 end;
end;

//очистка всей таблицы
procedure TfmSvet.ToolButton2Click(Sender: TObject);
begin
  if Application.MessageBox('Вы дейтсвительно хотите полностью очистить таблицу светофоров?',
                            'Редактор базы данных автоведения',
                            MB_YESNO + MB_ICONWARNING + MB_TOPMOST) = IDYES then
  begin
     DIR_ID:=fmDirection.FDQ_DIR.FieldByName('ID').AsString;
    with FDCmd do
    begin
       Close;
       CommandText.Clear;
       CommandText.Add('Delete FROM LIGHT_SIGNALS WHERE Dir_key='+DIR_ID);
       FDT_WRITE_SV.StartTransaction;
       try
          Execute();
          FDT_WRITE_SV.Commit;
          FDQ_SV.Refresh;
       except
       on E: EFDDBEngineException do
          begin
            if FDT_WRITE_SV.Active then FDT_WRITE_SV.Rollback;
            Application.ShowException(E);
          end;
       end;
    end;

  end;
end;

end.
