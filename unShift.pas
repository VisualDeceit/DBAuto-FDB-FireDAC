unit unShift;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, DB, DBTables, Mask, Menus, Grids, DBGrids,
  ExtCtrls, DBGridEhGrouping, GridsEh, DBGridEh, ComCtrls, ToolWin, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, EhLibVCL, DBAxisGridsEh;

type
  TfmShift = class(TForm)
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    DBG_Shift: TDBGridEh;
    N3: TMenuItem;
    ToolBar5: TToolBar;
    ToolButton12: TToolButton;
    Label1: TLabel;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    procedure DBG_ShiftDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh;
      State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure ToolButton12Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmShift: TfmShift;

implementation

uses unMain, unVars, unDirection;

{$R *.dfm}

procedure TfmShift.DBG_ShiftDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
 DBG_Shift.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfmShift.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  fmMain.tbShift.Down:=False;
end;

procedure TfmShift.FormDestroy(Sender: TObject);
begin
  fmShift:=nil;
end;


procedure TfmShift.ToolButton12Click(Sender: TObject);
var
  i:Word;
  r_count:word;
  dir:Byte;
  put:byte;
  file_name:string;
  str:string;
  deb_txt:TextFile;
  mes:string;
label L1;
begin
{ try
  if fmMain.tShift.FieldValues['Shift_ID']<>null then
  with fmMain.qtSave do
  begin
   close;
   Active:=false;
   SQL.Clear;
   SQL.Add('SELECT *');
   SQL.Add('FROM Shift');
   SQL.Add('WHERE Dir_key='+DIR_ID);
  // SQL.Add('ORDER BY Kbeg, Pbeg');
   Active:=true;
   First;
   r_count:=RecordCount;

   if r_count=0 then Exit;

   dir:=fmMain.tDirections.FieldValues['Direction'];
   put:=fmMain.tDirections.FieldValues['Way'];
   file_name:='';
   if dir<10  then file_name:='0'+IntToStr(dir) else  file_name:=IntToStr(dir);
   str:=extractfilepath(application.ExeName)+'\files\'+
                             IntToStr(fmMain.tDirections.FieldValues['Direction'])+' '+
                             fmMain.tDirections.FieldValues['Name'];
   if not DirectoryExists(str) then  CreateDir(str);
    for i:=1 to r_count do
    begin
     shft[i].Name:=FieldValues['Shift_Name'];
     shft[i].Value:=FieldValues['Shift_Value'];
     shft[i].Flag:=FieldValues['Shift_flag'];
     if i<> r_count then Next;
    end;
    
   if FileExists(str+'\'+file_name+'.sm')=True then
   begin
     mes:='Папка уже содержит файл "'+file_name+'.ogr".'+#13+#13+
        'Заменить имеющийся файл'+#13+#13+
        '   '+IntToStr(GetFileSize(str+'\'+file_name+'.sm'))+ ' Байт'+#13+
        '   Дата изменения: '+GetFileDate(str+'\'+file_name+'.sm')+#13+#13+
        'новым файлом?';
    if Application.MessageBox(PAnsiChar(mes),
     'Подтверждение замены файла', MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES then
    begin
L1:
    assignfile(fshst,str+'\'+file_name+'.sm');
     AssignFile(deb_txt,str+'\'+file_name+'.sm.txt');
     rewrite(fshst);
     Rewrite(deb_txt);
      for i:=1 to r_count do
      begin
       write(fshst,shft[i]);
       Writeln(deb_txt,shft[i].Name:25,'  ',shft[i].Value:9,'  ', shft[i].Flag:2);
      end;
     closefile(fshst);
     CloseFile(deb_txt);
      Application.MessageBox('Файл успешно создан!', 'Внимание!', MB_OK or MB_DEFBUTTON1 +
      MB_ICONINFORMATION + MB_TOPMOST);
    end;
   end else goto L1;
  end;
 except
    Application.MessageBox('Ошибка при создании файла!', 'Внимание!', MB_OK or MB_DEFBUTTON1 +
    MB_ICONSTOP + MB_TOPMOST);
 end;

     }
end;

procedure TfmShift.ToolButton2Click(Sender: TObject);
begin
  if Application.MessageBox('Вы дейтсвительно хотите полностью очистить таблицу участков?',
    'Очистка таблицы', MB_YESNO + MB_ICONWARNING + MB_TOPMOST) = IDYES then
  begin
        with fmMain.IBSQL do
        begin
         Close;
         SQL.Clear;
         SQL.Add('Delete FROM SHIFT WHERE Dir_key='+DIR_ID);
         fmMain.IBTR_WRITE.StartTransaction;
         ExecQuery;
         fmMain.IBTR_WRITE.Commit;
        end;
      // DS_Refresh(fmMain.);
  end;
end;

end.

