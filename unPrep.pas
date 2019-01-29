unit unPrep;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, ExtCtrls, DBCtrls, Grids, DBGrids,
  DBGridEhGrouping, GridsEh, DBGridEh, Menus, StdCtrls,ShellAPI, ImgList,
  ComCtrls, ToolWin, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL,
  DBAxisGridsEh, XMLIntf, XMLDoc;

type
  TfmPrep = class(TForm)
    ToolBar3: TToolBar;
    ToolButton5: TToolButton;
    ToolButton14: TToolButton;
    DBG_Prep: TDBGridEh;
    pmPrep: TPopupMenu;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    procedure DBG_PrepDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton14Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPrep: TfmPrep;

implementation

uses  unMain, unVars, unPrepinfo;

{$R *.dfm}

procedure TfmPrep.DBG_PrepDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  DBG_Prep.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfmPrep.FormClose(Sender: TObject; var Action: TCloseAction);
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
    LNode:=LNodeChild.ChildNodes.FindNode('Objects');
    ObjSettings.width:=self.width;
    ObjSettings.Height:=self.height;
    ObjSettings.Left:=self.left;
    ObjSettings.Top:=self.top;
    LNode.SetAttribute('visible',ObjSettings.visible);
    LNode.SetAttribute('height', self.height);
    LNode.SetAttribute('width',  self.width);
    LNode.SetAttribute('left',   self.left);
    LNode.SetAttribute('top',    self.top);

    LDocument.SaveToFile(extractfilepath(application.ExeName)+'Setup.xml');
    LDocument.Active:=false;
  finally

  end;
 Action:=caFree;
 fmMain.tbPrep.Down:=False;
 if  fmMain.IBDS_objects.State in [dsEdit] then fmMain.IBDS_objects.Post;
end;

procedure TfmPrep.ToolButton5Click(Sender: TObject);
var
  i:word;
  r_count:word;
  dir:Byte;
  put:byte;
  file_name:string;
  str:string;
  deb_txt:TextFile;
  mes:string;
label L1;
begin
  try
    with fmMain.IBQR_TEMP do
    begin
     Close;
     SQL.Clear;
     SQL.LoadFromFile(SQL_DIR+'O_Select.sql');
     ParamByName('DIR_ID').AsInteger:=fmMain.IBDS_DirectionsID.Value;
     fmMain.IBTR_TEMP.StartTransaction;
     Open;
     Last;
     First;
     r_count:=RecordCount;
     if r_count=0 then
     begin
      Application.MessageBox('Данные для создания файла объектов пути остутствуют!','Ошибка', MB_OK+ MB_ICONSTOP + MB_TOPMOST);
      if fmMain.IBTR_TEMP.InTransaction then fmMain.IBTR_TEMP.Rollback;
      Exit;
      end;
    end ;

   dir:=fmMain.IBDS_Directions.FieldValues['Code'];
   put:=fmMain.IBDS_Directions.FieldValues['WAY'];
   file_name:='';
   if dir<10  then file_name:='0'+IntToStr(dir) else  file_name:=IntToStr(dir);
   file_name:=file_name+'p'+inttostr(put);
   str:=extractfilepath(application.ExeName)+'files\'+
                             IntToStr(fmMain.IBDS_Directions.FieldValues['Code'])+' '+
                             fmMain.IBDS_Directions.FieldValues['FName'];
   if not DirectoryExists(str) then  CreateDir(str);
   if FileExists(str+'\'+file_name+'.prp')=True then
   begin
     mes:='Папка уже содержит файл "'+file_name+'.prp".'+#13+#13+
        'Заменить имеющийся файл'+#13+#13+
        '   '+IntToStr(GetFileSize(str+'\'+file_name+'.prp'))+ ' Байт'+#13+
        '   Дата изменения: '+GetFileDate(str+'\'+file_name+'.prp')+#13+#13+
        'новым файлом?';
    if Application.MessageBox(PWideChar(mes),
     'Подтверждение замены файла', MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES then
    begin
L1:
     assignfile(fprp,str+'\'+file_name+'.prp');
     rewrite(fprp);
     AssignFile(deb_txt,str+'\'+file_name+'.prp.txt');
     Rewrite(deb_txt);
      for i:=1 to r_count do
      begin
       prp[i].kr:=fmMain.IBQR_TEMP.FieldValues['Koord'];
       prp[i].tp:=fmMain.IBQR_TEMP.FieldValues['CODE'];
       write(fprp,prp[i]);
       Writeln(deb_txt,prp[i].kr:9,'  ',prp[i].tp:2);
       if i<> r_count then fmMain.IBQR_TEMP.Next;
      end;
     closefile(fprp);
     CloseFile(deb_txt);
     fmMain.IBTR_TEMP.Commit;
      Application.MessageBox(PChar('Файл "'+file_name+'.prp" успешно создан!'), 'Внимание!', MB_OK +
      MB_ICONINFORMATION + MB_TOPMOST);
    end;
   end else goto L1;
 
 except
    if fmMain.IBTR_TEMP.InTransaction then fmMain.IBTR_TEMP.Rollback;
    Application.MessageBox('Ошибка при создании файла!', 'Внимание!', MB_OK or MB_DEFBUTTON1 +
    MB_ICONSTOP + MB_TOPMOST);
 end;


end;

procedure TfmPrep.ToolButton14Click(Sender: TObject);
begin
  if Application.MessageBox('Вы дейтсвительно хотите полностью очистить таблицу объектов пути?',
    'Очистка таблицы', MB_YESNO + MB_ICONWARNING + MB_TOPMOST) = IDYES then
  begin
    DIR_ID:=IntToStr(fmMain.IBDS_DirectionsID.Value);
      with fmMain.IBSQL do
      begin
       Close;
       SQL.Clear;
       SQL.Add('Delete FROM OBJECTS WHERE Dir_key='+DIR_ID);
       fmMain.IBTR_WRITE.StartTransaction;
       ExecQuery;
       fmMain.IBTR_WRITE.Commit;
       end;
     DS_Refresh(fmMain.IBDS_Objects);
  end;
end;

procedure TfmPrep.MenuItem3Click(Sender: TObject);
begin
  fmMain.IBDS_Objects.Insert;
end;

procedure TfmPrep.MenuItem4Click(Sender: TObject);
begin
  fmMain.IBDS_Objects.Delete; 
end;

procedure TfmPrep.FormDestroy(Sender: TObject);
begin
 fmPrep:=nil;
end;

//Импорт  данных из другой таблицы
var impDBpath,impDBname:string;
procedure TfmPrep.ToolButton1Click(Sender: TObject);
var
  i:word; s:string;
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
   fmMain.IBDS_Objects.DisableControls;

   while not qtimport.Eof do
   begin
    fmMain.IBDS_Objects.Insert;
    if qtimport.FieldValues['Tip']<>null then
    with fmMain.IBQR_TEMP do
    begin
     Close;
     SQL.Clear;
     SQL.Add('SELECT * FROM Objects_info WHERE CODE='+inttostr(qtimport.FieldValues['Tip']));
     fmMain.IBTR_TEMP.StartTransaction;
     Open;
    end else
    with fmMain.IBQR_TEMP do
    begin
     close;
     SQL.Clear;
     SQL.Add('SELECT * FROM Objects_info WHERE CODE_str= :PARAM');
     fmMain.IBTR_TEMP.StartTransaction;
     ParamByName('PARAM').AsString:=qtimport.FieldValues['Nazv'];
     Open;
    end;
    fmMain.IBDS_Objects.FieldByName('OBJ_KEY').Value:=fmMain.IBQR_TEMP.FieldValues['ID'];
    fmMain.IBDS_Objects.FieldByName('Koord').Value:=qtimport.FieldValues['Krd'];
    fmMain.IBDS_Objects.Post;
    fmMain.IBTR_TEMP.Commit;
    qtimport.Next;
   end;
   qtimport.Close;
   qtimport.free;
   fmMain.IBDS_Objects.EnableControls;
   DS_Refresh(fmMain.IBDS_Objects);
   except
     fmMain.IBDS_Objects.EnableControls;
     if qtimport.Active then
     begin
      qtimport.Close;
      qtimport.free;
      end;
     if  fmMain.IBTR_TEMP.InTransaction then  fmMain.IBTR_TEMP.Rollback;
     Application.MessageBox('Ошибка при импортировании данных.', 'Внимание!', MB_OK +
     MB_ICONSTOP + MB_TOPMOST);
    end;
 end;


end;

procedure TfmPrep.ToolButton2Click(Sender: TObject);
var
   r_count:word;
begin
  with fmMain.IBSQL do
  begin
   Close;
   SQL.Clear;
   SQL.LoadFromFile(SQL_DIR+'O_Copy.sql');
   fmMain.IBTR_WRITE.StartTransaction;
   ParamByName('DIR_ID').AsInteger:=fmMain.IBDS_DirectionsID.Value;
   ParamByName('VAR_CODE').AsInteger:=fmMain.IBDS_DirectionsCODE.Value;
    ExecQuery;
  // Open;
//   Last;
//   First;
 //  r_count:=RecordCount;
{   if r_count=0 then
   begin
    Application.MessageBox('Данные для создания файла светофров остутствуют!','Ошибка', MB_OK+ MB_ICONSTOP + MB_TOPMOST);
    if fmMain.IBTR_TEMP.InTransaction then fmMain.IBTR_TEMP.Rollback;
    Exit;
    end;  }
   fmMain.IBTR_WRITE.Commit;
  end ;
  DS_Refresh(fmMain.IBDS_Objects);
end;

end.
