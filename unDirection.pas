unit unDirection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, DB, DBTables, Mask, Menus, Grids, DBGrids,
  ExtCtrls, DBGridEhGrouping, GridsEh, DBGridEh, ToolCtrlsEh, DBGridEhToolCtrls,
  DynVarsEh, EhLibVCL, DBAxisGridsEh, XMLIntf, XMLDoc, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet;

type
  TfmDirection = class(TForm)
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    DBG_Direction: TDBGridEh;
    N3: TMenuItem;
    FDT_WRITE_DIR: TFDTransaction;
    FDQ_DIR: TFDQuery;
    FDUSQL_DIR: TFDUpdateSQL;
    DS_DIR: TDataSource;
    FDQ_DIRID: TFDAutoIncField;
    FDQ_DIRFNAME: TStringField;
    FDQ_DIRCODE: TIntegerField;
    FDQ_DIRWAY: TIntegerField;
    FDQ_DIRFLAG: TSmallintField;
    FDQ_DIRRAIL_KEY: TIntegerField;
    DBNavigator1: TDBNavigator;
    procedure DBG_DirectionDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh;
      State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure DBG_DirectionCellMouseClick(Grid: TCustomGridEh; Cell: TGridCoord;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
      var Processed: Boolean);
    procedure FDQ_DIRAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDirection: TfmDirection;

implementation

uses unMain, unVars, unShift;

{$R *.dfm}

procedure TfmDirection.DBG_DirectionCellMouseClick(Grid: TCustomGridEh;
  Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  var Processed: Boolean);
begin
 //fmMain.StatusBar1.Panels[5].Text:= fmMain.IBDS_Directions.fieldbyname('ID').AsString;
 //fmMain.DBLookupComboboxEh1.KeyValue:=fmMain.IBDS_Directions.fieldbyname('ID').AsVariant;

end;

procedure TfmDirection.DBG_DirectionDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
 DBG_Direction.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfmDirection.FDQ_DIRAfterPost(DataSet: TDataSet);
begin
    //есть изменения в очереди
    if FDQ_DIR.UpdatesPending then
    begin
     //старт транзакции на запись
      FDT_WRITE_DIR.StartTransaction;
     //применяем изменения
     try
      if (FDQ_DIR.ApplyUpdates = 0) then
      begin
       //очищаем журнал
       FDQ_DIR.CommitUpdates;
       //замершаем транзакцию
       FDT_WRITE_DIR.Commit;
      end else
       raise Exception.Create('Ошибка при добавлении записи');
       except
        on E: Exception do
        begin
          if FDT_WRITE_DIR.Active then FDT_WRITE_DIR.Rollback;
          FDQ_DIR.CommitUpdates;
          FDQ_DIR.Refresh;
          Application.ShowException(E);
        end;
      end;
    end;
end;

procedure TfmDirection.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
      LDocument: IXMLDocument;
        LNodeRoot, LNodeChild, LNode: IXMLNode;
begin
  try
    //сохраняем настройки формы
    LDocument := TXMLDocument.Create(nil);
    LDocument.LoadFromFile(extractfilepath(application.ExeName)+'Setup.xml');
    LDocument.Active:=true;
    LNodeRoot := LDocument.ChildNodes.FindNode('Setup');

    LNodeChild:= LNodeRoot.ChildNodes.FindNode('Windows');
    LNode:=LNodeChild.ChildNodes.FindNode('Directions');
    DirSettings.width:=fmDirection.width;
    DirSettings.Height:=fmDirection.height;
    DirSettings.Left:=fmDirection.left;
    DirSettings.Top:=fmDirection.top;
    LNode.SetAttribute('visible',DirSettings.visible);
    LNode.SetAttribute('height', fmDirection.height);
    LNode.SetAttribute('width',  fmDirection.width);
    LNode.SetAttribute('left',   fmDirection.left);
    LNode.SetAttribute('top',    fmDirection.top);

    LDocument.SaveToFile(extractfilepath(application.ExeName)+'Setup.xml');
    LDocument.Active:=false;
    if FDQ_DIR.UpdatesPending then
      begin
       //старт транзакции на запись
        FDT_WRITE_DIR.StartTransaction;
       //применяем изменения
       try
        if (FDQ_DIR.ApplyUpdates = 0) then
        begin
         //очищаем журнал
         FDQ_DIR.CommitUpdates;
         //замершаем транзакцию
         FDT_WRITE_DIR.Commit;
        end else
         raise Exception.Create('Ошибка при добавлении записи');
         except
          on E: Exception do
          begin
            if FDT_WRITE_DIR.Active then FDT_WRITE_DIR.Rollback;
            FDQ_DIR.CommitUpdates;
            FDQ_DIR.Refresh;
            Application.ShowException(E);
          end;
        end;
    end;
    // закрываем набор данных
    FDQ_DIR.Close;
  finally

  end;
  Action := caFree;
end;

procedure TfmDirection.N1Click(Sender: TObject);
begin
 fmMain.IBDS_Directions.Insert;
end;

procedure TfmDirection.N2Click(Sender: TObject);
var
  tr_id_temp:string;
begin
{ if   Application.MessageBox('Вы дейтсвительно хотите удалить текущее направление?',
   'Внимание!', MB_YESNO + MB_ICONQUESTION + MB_TOPMOST)=IDYES then
     begin
       DIR_ID:=IntToStr(fmMain.IBDS_DirectionsID.Value);
        with fmMain.IBSQL do
        begin
         Close;
         SQL.Clear;
         SQL.Add('Delete FROM STATIONS WHERE Dir_key='+DIR_ID);
         fmMain.IBTR_WRITE.StartTransaction;
         ExecQuery;
         fmMain.IBTR_WRITE.Commit;
         SQL.Clear;
         SQL.Add('Delete FROM LIMITS WHERE Dir_key='+DIR_ID);
         fmMain.IBTR_WRITE.StartTransaction;
         ExecQuery;
         fmMain.IBTR_WRITE.Commit;
         SQL.Clear;
         SQL.Add('Delete FROM LIGHT_SIGNALS WHERE Dir_key='+DIR_ID);
         fmMain.IBTR_WRITE.StartTransaction;
         ExecQuery;
         fmMain.IBTR_WRITE.Commit;
         SQL.Clear;
         SQL.Add('Delete FROM PROFILE WHERE Dir_key='+DIR_ID);
         fmMain.IBTR_WRITE.StartTransaction;
         ExecQuery;
         fmMain.IBTR_WRITE.Commit;
         SQL.Clear;
         SQL.Add('Delete FROM OBJECTS WHERE Dir_key='+DIR_ID);
         fmMain.IBTR_WRITE.StartTransaction;
         ExecQuery;
         fmMain.IBTR_WRITE.Commit;
        end;
        with fmMain.IBQR_TEMP do
        begin
           Close;
           SQL.Clear;
           SQL.Add('Select * FROM Trains WHERE Dir_key='+DIR_ID);
           fmMain.IBTR_TEMP.StartTransaction;
           Open;
           Last;
           First;
           while not Eof do
           begin
            tr_id_temp:=IntToStr(fmMain.IBQR_TEMP.FieldValues['ID']);
            with fmMain.IBSQL do
            begin
             SQL.Clear;
             SQL.Add('Delete FROM TimeTable WHERE Train_key='+tr_id_temp);
             fmMain.IBTR_WRITE.StartTransaction;
             ExecSQL;
             fmMain.IBTR_WRITE.Commit;
            end;
            Next;
           end;
           fmMain.IBTR_TEMP.Commit;
        end;
        with fmMain.IBSQL do
        begin
         Close;
         SQL.Clear;
         SQL.Add('Delete FROM TRAINS WHERE Dir_key='+DIR_ID);
         fmMain.IBTR_WRITE.StartTransaction;
         ExecQuery;
         fmMain.IBTR_WRITE.Commit;
        end;
        fmMain.IBDS_Directions.Delete;
     end;  }
  if MessageDlg('Are you sure you want to delete the item?',
                mtConfirmation,
                [mbYes, mbNo],
                0) = mrYes then
  begin
    FDT_WRITE_DIR.StartTransaction;
    try
      FDQ_DIR.Delete;
      FDT_WRITE_DIR.Commit;
    except
      on E: Exception do
      begin
        FDT_WRITE_DIR.Rollback;
        Application.ShowException(E);
      end;
    end;
  end;
end;

procedure TfmDirection.FormDestroy(Sender: TObject);
begin
  fmDirection:=nil;
end;

//Копирование участка
procedure TfmDirection.N3Click(Sender: TObject);
var Name_t,dir_t,way_t,flag_t:string;
var Dir_ID_temp:string;
begin
{ Dir_ID_temp:=fmMain.tDirections.FieldValues['Dir_ID'] ;
 Name_t:=fmMain.tDirections.FieldValues['Name'] ;
 Name_t:=Name_t+' (Копия)';
 dir_t:=fmMain.tDirections.FieldValues['Direction'];
 way_t:=fmMain.tDirections.FieldValues['Way'] ;
 flag_t:=fmMain.tDirections.FieldValues['Flag'] ;
 with fmMain.qtTemp do
 begin
   Close;
   Active:=False;
   SQL.Clear;
   SQL.Add('INSERT INTO Directions');
   SQL.Add('(Name, Direction, Way, Flag)');
 //  SQL.Add('select "'+Name_t+'", Direction, Way, Flag from Directions');
//   SQL.Add('WHERE DIR_ID=20');
   SQL.Add('VALUES ("'+Name_t+'",'+dir_t+','+way_t+','+flag_t+')');
   ExecSQL;
 end;             |}
 (*
 fmMain.tDirections.Last;
 DIR_ID:=IntToStr(fmMain.tDirections.FieldValues['Dir_ID']);

  with fmMain.qtTemp do
  begin
   close;
   Active:=false;
   SQL.Clear;
   SQL.Add('SELECT *');
   SQL.Add('FROM Stations');
   SQL.Add('WHERE Dir_key='+Dir_ID_temp);
   SQL.Add('ORDER BY Koord');
   Active:=true;
  end;

 while not fmMain.qtTemp.Eof do
 begin
  fmMain.qtStations.Insert;
  fmMain.qtStations.FieldByName('Dir_Key').Value:=DIR_ID;
  fmMain.qtStations.FieldByName('Name').Value:=fmMain.qtTemp.FieldValues['Name'];
  fmMain.qtStations.FieldByName('Koord').Value:=fmMain.qtTemp.FieldValues['Koord'];
  fmMain.qtStations.FieldByName('Beg_Km').Value:=fmMain.qtTemp.FieldValues['Beg_Km'];
  fmMain.qtStations.FieldByName('Beg_Pk').Value:=fmMain.qtTemp.FieldValues['Beg_Pk'];
  fmMain.qtStations.FieldByName('END_Km').Value:=fmMain.qtTemp.FieldValues['END_Km'];
  fmMain.qtStations.FieldByName('END_Pk').Value:=fmMain.qtTemp.FieldValues['END_Pk'];
  fmMain.qtStations.FieldByName('Speed').Value:=fmMain.qtTemp.FieldValues['Speed'];
  fmMain.qtStations.Post;
  fmMain.qtTemp.Next;
 end;

  with fmMain.qtTemp do
  begin
   close;
   Active:=false;
   SQL.Clear;
   SQL.Add('SELECT *');
   SQL.Add('FROM Limits');
   SQL.Add('WHERE Dir_key='+Dir_ID_temp);
   SQL.Add('ORDER BY Kbeg, Pbeg');
   Active:=true;
  end;

 while not fmMain.qtTemp.Eof do
 begin
  fmMain.qtLimits.Insert;
  fmMain.qtLimits.FieldByName('Dir_Key').Value:=DIR_ID;
  fmMain.qtLimits.FieldByName('KBeg').Value:=fmMain.qtTemp.FieldValues['KBeg'];
  fmMain.qtLimits.FieldByName('PBeg').Value:=fmMain.qtTemp.FieldValues['PBeg'];
  fmMain.qtLimits.FieldByName('Kend').Value:=fmMain.qtTemp.FieldValues['Kend'];
  fmMain.qtLimits.FieldByName('PEnd').Value:=fmMain.qtTemp.FieldValues['PEnd'];
  fmMain.qtLimits.FieldByName('Speed').Value:=fmMain.qtTemp.FieldValues['Speed'];
  fmMain.qtLimits.FieldByName('Note').Value:=fmMain.qtTemp.FieldValues['Note'];
  fmMain.qtLimits.Post;
  fmMain.qtTemp.Next;
 end;

  with fmMain.qtTemp do
  begin
   close;
   Active:=false;
   SQL.Clear;
   SQL.Add('SELECT *');
   SQL.Add('FROM PrepData');
   SQL.Add('WHERE Dir_key='+Dir_ID_temp);
   SQL.Add('ORDER BY Koord');
   Active:=true;
  end;

 while not fmMain.qtTemp.Eof do
 begin
  fmMain.qtPrepData.Insert;
  fmMain.qtPrepData.FieldByName('Dir_Key').Value:=DIR_ID;
  fmMain.qtPrepData.FieldByName('Prep_Key').Value:=fmMain.qtTemp.FieldValues['Prep_Key'];
  fmMain.qtPrepData.FieldByName('Koord').Value:=fmMain.qtTemp.FieldValues['Koord'];
  fmMain.qtPrepData.Post;
  fmMain.qtTemp.Next;
 end;

  with fmMain.qtTemp do
  begin
   close;
   Active:=false;
   SQL.Clear;
   SQL.Add('SELECT *');
   SQL.Add('FROM SVet');
   SQL.Add('WHERE Dir_key='+Dir_ID_temp);
   SQL.Add('ORDER BY Koord');
   Active:=true;
  end;

 while not fmMain.qtTemp.Eof do
 begin
  fmMain.qtSvet.Insert;
  fmMain.qtSvet.FieldByName('Dir_Key').Value:=DIR_ID;
  fmMain.qtSvet.FieldByName('Name').Value:=fmMain.qtTemp.FieldValues['Name'];
  fmMain.qtSvet.FieldByName('Koord').Value:=fmMain.qtTemp.FieldValues['Koord'];
  fmMain.qtSvet.FieldByName('Speed').Value:=fmMain.qtTemp.FieldValues['Speed'];
  fmMain.qtSvet.Post;
  fmMain.qtTemp.Next;
 end;

 fmMain.tDirections.Refresh;   *)
end;

end.
