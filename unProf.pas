unit unProf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, ExtCtrls, DBCtrls, Grids, DBGrids,
  DBGridEhGrouping, GridsEh, DBGridEh, Menus, StdCtrls,ShellAPI, ImgList,
  ComCtrls, ToolWin, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL,
  DBAxisGridsEh,ComObj, XMLIntf, XMLDoc;

type
  TfmProf = class(TForm)
    pmTable: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    DBG_Prof: TDBGridEh;
    ToolBar5: TToolBar;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ImportDialog: TOpenDialog;
    procedure DBG_ProfDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure N2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ToolButton13Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmProf: TfmProf;

implementation

uses  unMain, unVars, unDirection, unProgressBar, unProfImportFormat;

{$R *.dfm}

procedure TfmProf.DBG_ProfDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  DBG_Prof.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfmProf.N2Click(Sender: TObject);
var num,num1,i:integer;
begin
fmMain.IBDS_prof.DisableControls;
fmMain.IBDS_prof.Delete;
fmMain.IBDS_prof.EnableControls;
{  if fmMain.qtProf.RecordCount>0 then
 begin
   num:=fmMain.qtProf.FieldValues['Number'];
   num1:=fmMain.qtProf.RecNo;
   fmMain.qtProf.Delete;
   fmMain.qtProf.ApplyUpdates;
   fmMain.qtProf.CommitUpdates;
   while not fmMain.qtProf.Eof do
   begin
    fmMain.qtProf.Edit;
    fmMain.qtProf.FieldByName('Number').Value:=num;
    num:=num+1;
    fmMain.qtProf.Next;
   end;
   fmMain.qtProf.RecNo:=num1;
   with fmMain.qtProf do
    begin
     close;
     Active:=false;
     SQL.Clear;
     SQL.Add('SELECT *');
     SQL.Add('FROM prof');
     SQL.Add('WHERE Dir_key='+DIR_ID);
     SQL.Add('ORDER BY Number');
     Active:=true;
    end;
 end;     }
end;

procedure TfmProf.FormClose(Sender: TObject; var Action: TCloseAction);
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
    LNode:=LNodeChild.ChildNodes.FindNode('Profile');
    ProfSettings.width:=fmProf.width;
    ProfSettings.Height:=fmProf.height;
    ProfSettings.Left:=fmProf.left;
    ProfSettings.Top:=fmProf.top;
    LNode.SetAttribute('visible',ProfSettings.visible);
    LNode.SetAttribute('height', fmProf.height);
    LNode.SetAttribute('width',  fmProf.width);
    LNode.SetAttribute('left',   fmProf.left);
    LNode.SetAttribute('top',    fmProf.top);

    LDocument.SaveToFile(extractfilepath(application.ExeName)+'Setup.xml');
    LDocument.Active:=false;
  finally

  end;

  Action:=caFree;
  fmMain.tbProf.Down:=False;
  if  fmMain.IBDS_prof.State in [dsEdit] then fmMain.IBDS_prof.Post;
end;

//Импорт  данных из другой таблицы
var impDBpath,impDBname:string;
procedure TfmProf.ToolButton4Click(Sender: TObject);
var i:word; s:string;
begin
{ DIR_ID:=IntToStr(fmMain.IBDS_DirectionsID.Value);
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
  with fmMain.qtimport do
  begin
   Close;
   DatabaseName:=impDBpath;
   Active:=false;
   SQL.Clear;
   SQL.Add('SELECT *');
   SQL.Add('FROM '+impDBname);
   SQL.Add('ORDER BY Номер');
   Active:=true;
  end;

   //обновление таблицы
    with fmMain.qtProf do
    begin
     close;
     Active:=false;
     SQL.Clear;
     SQL.Add('SELECT *');
     SQL.Add('FROM Prof');
     SQL.Add('WHERE Dir_key='+DIR_ID);
     SQL.Add('ORDER BY Number');
     Active:=true;
    end;

    frmProgress:=TfrmProgress.Create(Self);
    frmProgress.ProgressBar1.Max:=fmMain.qtimport.RecordCount;;
    frmProgress.Show;
    frmProgress.Update;

    fmMain.qtimport.First;
    fmMain.qtProf.Last;
   while not fmMain.qtimport.Eof do
   begin
    with fmMain.qtTemp do
    begin
     SQL.Clear;
     SQL.Add('INSERT INTO Prof');
     SQL.Add('(Dir_key, Uklon, Km, Pk, Number)');
     SQL.Add('VALUES ('+DIR_ID+','+inttostr(fmMain.qtimport.FieldValues['Уклон'])+','+inttostr(fmMain.qtimport.FieldValues['Км'])+','+inttostr(fmMain.qtimport.FieldValues['Пик'])+','+inttostr(fmMain.qtimport.FieldValues['Номер'])+')');
     ExecSQL;
     frmProgress.ProgressBar1.StepIt;
    end;

    fmMain.qtimport.Next;
   end;
   fmMain.qtimport.Close;
   frmProgress.Free;
   //обновление таблицы
    with fmMain.qtProf do
    begin
     close;
     Active:=false;
     SQL.Clear;
     SQL.Add('SELECT *');
     SQL.Add('FROM Prof');
     SQL.Add('WHERE Dir_key='+DIR_ID);
     SQL.Add('ORDER BY Number');
     Active:=true;
    end;
   except
    Application.MessageBox('Ошибка при импортировании данных.', 'Внимание!', MB_OK +
      MB_ICONSTOP + MB_TOPMOST);
    end;
 end;    }
end;

procedure TfmProf.ToolButton1Click(Sender: TObject);
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
    with fmMain.IBQR_TEMP do
    begin
     Close;
     SQL.Clear;
     SQL.LoadFromFile(SQL_DIR+'PF_Select.sql');
     ParamByName('DIR_ID').AsInteger:=fmMain.IBDS_DirectionsID.Value;
    // if not fl_Shift then  SQL.Add('ORDER BY L.beg_km, L.beg_pk') else SQL.Add('ORDER BY LIN_KOORD') ;
     fmMain.IBTR_TEMP.StartTransaction;
     Open;
     Last;
     First;
     r_count:=fmMain.IBQR_TEMP.RecordCount;
     if r_count=0 then
     begin
      Application.MessageBox('Данные для создания файла профиля остутствуют!','Ошибка', MB_OK+ MB_ICONSTOP + MB_TOPMOST);
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

    for i:=1 to r_count do
    begin
     prf[i]:=fmMain.IBQR_TEMP.FieldValues['FValue'];
     if i<> r_count then fmMain.IBQR_TEMP.Next;;
    end;

   fmMain.IBTR_TEMP.Commit;
   if FileExists(str+'\'+file_name+'.prf')=True then
   begin
     mes:='Папка уже содержит файл "'+file_name+'.prf".'+#13+#13+
        'Заменить имеющийся файл'+#13+#13+
        '   '+IntToStr(GetFileSize(str+'\'+file_name+'.prf'))+ ' Байт'+#13+
        '   Дата изменения: '+GetFileDate(str+'\'+file_name+'.prf')+#13+#13+
        'новым файлом?';
    if Application.MessageBox(PWideChar(mes),
     'Подтверждение замены файла', MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES then
    begin
L1:
     assignfile(fprf,str+'\'+file_name+'.prf');
     AssignFile(deb_txt,str+'\'+file_name+'.prf.txt');
     rewrite(fprf);
     Rewrite(deb_txt);
      for i:=1 to r_count do
      begin
       write(fprf,prf[i]);
       Writeln(deb_txt,i:4,'  ',prf[i]:3);
      end;
     closefile(fprf);
     CloseFile(deb_txt);
      Application.MessageBox(PChar('Файл "'+file_name+'.prf" успешно создан!'), 'Внимание!', MB_OK or MB_DEFBUTTON1 +
      MB_ICONINFORMATION + MB_TOPMOST);
    end;
   end else goto L1;

 except
    Application.MessageBox('Ошибка при создании файла!', 'Внимание!', MB_OK or MB_DEFBUTTON1 +
    MB_ICONSTOP + MB_TOPMOST);
 end;
end;

procedure TfmProf.ToolButton3Click(Sender: TObject);
var
   r_count:word;
begin
  with fmMain.IBSQL do
  begin
   Close;
   SQL.Clear;
   SQL.LoadFromFile(SQL_DIR+'PF_invert.sql');
   fmMain.IBTR_WRITE.StartTransaction;
   ParamByName('DIR_ID').AsInteger:=fmMain.IBDS_DirectionsID.Value;
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
  DS_Refresh(fmMain.IBDS_prof);
end;


// инверсия профиля для противоположного пути
procedure TfmProf.ToolButton8Click(Sender: TObject);
var Dir_ID_temp,Direct,puti:string;
begin
(*  if Application.MessageBox('Вы действительно хотите инвертировать и добавить '
    + #13#10 + 'данные для другого пути?', 'Внимание!', MB_YESNO +
    MB_ICONQUESTION + MB_TOPMOST) = IDYES then
  begin
    try
     Direct:=IntToStr(fmMain.tDirections.FieldValues['Direction']);
     puti:=IntToStr(fmMain.tDirections.FieldValues['Way']);

      with fmMain.qtTemp do
      begin
       close;
       Active:=false;
       SQL.Clear;
       SQL.Add('SELECT *');
       SQL.Add('FROM Directions');
       SQL.Add('WHERE (Direction='+Direct+') AND (Way<>'+puti+')');
       Active:=true;
      end;

      Dir_ID_temp:=IntToStr(fmMain.qtTemp.FieldValues['Dir_ID']);
      Dir_ID:=IntToStr(fmMain.tDirections.FieldValues['Dir_ID']);

      with fmMain.qtTemp do
      begin
       close;
       Active:=false;
       SQL.Clear;
       SQL.Add('SELECT *');
       SQL.Add('FROM Prof');
       SQL.Add('WHERE Dir_key='+Dir_ID);
       Active:=true;
      end;

      fmMain.qtTemp.First;
      fmMain.qtProf.Last;

     while not fmMain.qtTemp.Eof do
     begin
      fmMain.qtProf.Insert;
      fmMain.qtProf.FieldByName('Dir_key').Value:=Dir_ID_temp;{fmMain.qtTemp.FieldValues['train_key']; }
      fmMain.qtProf.FieldByName('Uklon').Value:=fmMain.qtTemp.FieldValues['Uklon']*(-1);
      fmMain.qtProf.FieldByName('Km').Value:=fmMain.qtTemp.FieldValues['Km'];
      fmMain.qtProf.FieldByName('Pk').Value:=fmMain.qtTemp.FieldValues['Pk'];
      fmMain.qtProf.FieldByName('Number').Value:=fmMain.qtTemp.FieldValues['Number'];

      fmMain.qtProf.Post;
      fmMain.qtTemp.Next;
     end;
      except
      Application.MessageBox('Ошибка при инвертировании данных.', 'Внимание!',
        MB_OK + MB_ICONSTOP + MB_TOPMOST);
      end;
  end;
         *)

end;

procedure TfmProf.FormDestroy(Sender: TObject);
begin
 fmProf:=nil;
end;

procedure TfmProf.ToolButton13Click(Sender: TObject);
begin
if Application.MessageBox('Вы дейтсвительно хотите полностью очистить таблицу профиля?',
    'Очистка таблицы', MB_YESNO + MB_ICONWARNING + MB_TOPMOST) = IDYES then
  begin
    DIR_ID:=IntToStr(fmMain.IBDS_DirectionsID.Value);
      with fmMain.IBSQL do
      begin
       Close;
       SQL.Clear;
       SQL.Add('Delete FROM PROFILE WHERE Dir_key='+DIR_ID);
       fmMain.IBTR_WRITE.StartTransaction;
       ExecQuery;
       fmMain.IBTR_WRITE.Commit;
       end;
     DS_Refresh(fmMain.IBDS_prof);
  end;
end;

procedure TfmProf.ToolButton2Click(Sender: TObject);
begin
 fmProfImportFormat.ShowModal;
end;


end.
