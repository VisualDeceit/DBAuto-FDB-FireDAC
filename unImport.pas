unit unImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, CheckLst, ExtCtrls, ImgList, ComCtrls, ToolWin, ComObj,
  DBGridEhGrouping, GridsEh, DBGridEh, Menus, Math, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, EhLibVCL, DBAxisGridsEh;

type
  TfmImport = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    clbFilterObjects: TCheckListBox;
    GroupBox3: TGroupBox;
    clbFilterPath: TCheckListBox;
    Panel1: TPanel;
    StringGrid1: TStringGrid;
    ImportDialog: TOpenDialog;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Button1: TButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    PopupMenu2: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    GroupBox6: TGroupBox;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    Edit4: TEdit;
    PopupMenu3: TPopupMenu;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    PopupMenu4: TPopupMenu;
    N7: TMenuItem;
    N8: TMenuItem;
    ToolButton2: TToolButton;
    PopupMenu5: TPopupMenu;
    N9: TMenuItem;
    N10: TMenuItem;
    DBG_Dir: TDBGridEh;
    procedure SetFilter(Grid: TStringGrid; GridOut:TStringGrid;  FilterObject, filterPath: tChecklistBox);
    procedure clbFilterObjectsClick(Sender: TObject);
    procedure clbFilterPathClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure DBG_DirDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure Button1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure ToolButton3Click(Sender: TObject);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure StringGrid1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure N3DrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
      Selected: Boolean);
    procedure N7DrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
      Selected: Boolean);
    procedure N7MeasureItem(Sender: TObject; ACanvas: TCanvas; var Width,
      Height: Integer);
    procedure N5DrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
      Selected: Boolean);
    procedure ToolButton2Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmImport: TfmImport;
  FilterList,FilterList2 : TStringList;
  importGrid: TStringGrid;
  fl_change_clr:  Boolean=True;
  cell_clr: TColor;
  cell_old, cell_cur: LongInt;
  clr_arr: array[1..10000] of TColor;
  procedure FindArea;
implementation

uses unMain, unVars;

{$R *.dfm}

function Xls_To_StringGrid(AGrid: TStringGrid; AXLSFile: string; AType: byte): Boolean;
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
begin
  Result := False;
  // Create Excel-OLE Object
  XLApp := CreateOleObject('Excel.Application');
  try
    // Hide Excel
    XLApp.Visible := False;
    // Open the Workbook
    XLApp.Workbooks.Open(AXLSFile);
    // Sheet := XLApp.Workbooks[1].WorkSheets[1];
    Sheet := XLApp.Workbooks[ExtractFileName(AXLSFile)].WorkSheets[1];
    // In order to know the dimension of the WorkSheet, i.e the number of rows
    // and the number of columns, we activate the last non-empty cell of it
    Sheet.Cells.SpecialCells(xlCellTypeLastCell, EmptyParam).Activate;
    // Get the value of the last row
    x := XLApp.ActiveCell.Row;
    // Get the value of the last column
    y := 8;//XLApp.ActiveCell.Column;
    // Set Stringgrid's row &col dimensions.
    AGrid.RowCount := x;
    AGrid.ColCount := y+2;
    // Assign the Variant associated with the WorkSheet to the Delphi Variant
    RangeMatrix := XLApp.Range['A1', XLApp.Cells.Item[X, Y]].Value;
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
  finally
    // Quit Excel
    if not VarIsEmpty(XLApp) then
    begin
      // XLApp.DisplayAlerts := False;
      XLApp.Quit;
      XLAPP := Unassigned;
      Sheet := Unassigned;
      Result := True;
    end;
  end;
end;

procedure TfmImport.SetFilter(Grid: TStringGrid; GridOut:TStringGrid;  FilterObject, filterPath: tChecklistBox);
var
  i,j,Counter:Integer;
  fl_clear,fl_clear1,fl_clear2: byte;
  x, y, w: integer;
  s: string;
  MaxWidth: integer;
begin
  FilterList:=TStringList.Create;
  FilterList2:=TStringList.Create;
 
  for i:=0 to FilterObject.Items.Capacity-1 do
  if FilterObject.Checked[i]=true then
  FilterList.Add(FilterObject.Items[i]);

  for i:=0 to filterPath.Items.Capacity-1 do
  if filterPath.Checked[i]=true then
  FilterList2.Add(filterPath.Items[i]);

  GridOut.RowCount:=Grid.RowCount;
  GridOut.ColCount:=Grid.ColCount;

  for i:=0 to GridOut.RowCount do
  for j:=0 to GridOut.ColCount do GridOut.Cells[j,i]:=Grid.Cells[j,i];


  with GridOut do
  begin
    FixedRows:=1;
    FixedCols:=1;
    Counter:=FixedRows;

    for i := FixedRows to RowCount - 1 do
    begin
      fl_clear1:=1;
      for j:=0 to FilterList.Count-1 do
      if AnsiCompareText(Cells[2,i],FilterList.Strings[j])=0  then fl_clear1:=0;

      fl_clear2:=1;
      for j:=0 to FilterList2.Count-1 do
      if AnsiCompareText(Cells[3,i],FilterList2.Strings[j])=0  then fl_clear2:=0;

      fl_clear:=fl_clear1 or fl_clear2;

      if fl_clear=1 then
      begin
         Rows[I].Clear;
      end
      else
      begin
         if Counter <> i then
         begin
           Rows[Counter].Assign(Rows[i]);
           Rows[i].Clear;
         end;
         Inc(Counter);
      end;
    end;
    RowCount:=Counter;
    if RowCount<2 then RowCount:=2;
    FixedRows:=1;

    for i:=1 to RowCount-1 do    Cells[0,i]:=IntToStr(i);
  end;

  FilterList.Free;
  FilterList2.Free;

  //ClientHeight := DefaultRowHeight * RowCount + 5;
    with GridOut do
    begin
      for x := 0 to ColCount - 1 do
      begin
        MaxWidth := 0;
        for y := 0 to RowCount - 1 do
        begin
          w := Canvas.TextWidth(Cells[x,y]+' ');
          if w > MaxWidth then
            MaxWidth := w;
        end;
        ColWidths[x] := MaxWidth + 10;
      end;
     ColWidths[8]:=-1;
     ColWidths[9]:=-1;
    end;
 FindArea;
 ST_sel:=-1;
 fmImport.Edit2.Text:=inttostr(GridOut.RowCount-1);
end;

procedure TfmImport.clbFilterObjectsClick(Sender: TObject);
begin
 SetFilter(importGrid, StringGrid1, clbFilterObjects,clbFilterPath);
end;

procedure TfmImport.clbFilterPathClick(Sender: TObject);
begin
 SetFilter(importGrid, StringGrid1, clbFilterObjects,clbFilterPath);
end;

procedure TfmImport.ToolButton1Click(Sender: TObject);
begin
 if ImportDialog.Execute then
 begin
  if Xls_To_StringGrid(importGrid, ImportDialog.FileName, OBJ) then
   begin
    Application.MessageBox('Файл успешно загружен', 'Информация', MB_OK +
                           MB_ICONINFORMATION + MB_TOPMOST);
    clbFilterObjects.Enabled:=True;
    clbFilterPath.Enabled:=True;
   end
   else
  begin
   Application.MessageBox('Ошибка при загрузке файла', 'Ошибка', MB_OK +
                           MB_ICONERROR + MB_TOPMOST);
   clbFilterObjects.Enabled:=False;
   clbFilterPath.Enabled:=False;
  end;
 end;
 StringGrid1.Rows[0].Assign(importGrid.Rows[0]);
end;

procedure TfmImport.DBG_DirDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
 DBG_Dir.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

//Импорт данных
procedure TfmImport.Button1Click(Sender: TObject);
var
  i,j:Integer;
  ind_beg,ind_end:Integer;
  Prep_key:Byte;
  tmp_koord,tmp_koord1,tmp_koord0:LongInt;
  tmp_pik,st_len:Word;
begin
    (*
    try
       DIR_ID:=IntToStr(fmMain.IBDS_DirectionsID.Value);
       ind_beg:=StrToInt(Edit1.Text);
       ind_end:=StrToInt(Edit2.Text);
       if (DIR_ID<>null) then
       begin
         fmMain.IBDS_Light_Signals.DisableControls;
         fmMain.IBDS_Objects.DisableControls;
        for i:=ind_beg to ind_end do
        begin
        //если не выбран фильтр станций, то импортируем все объекты
         if (clbFilterObjects.Checked[7]=false) then
         begin
          if  (AnsiCompareText(StringGrid1.Cells[2,i],'светофор')=0) then
          begin
             with fmMain.IBSQL do
            begin
             Close;
             SQL.Clear;
             SQL.LoadFromFile(SQL_DIR+'LS_Import.sql');
             Params.ByName('FNAME').AsString:=Trim(StringGrid1.Cells[4,i]);
             Params.ByName('KOORD').AsInteger:=StrToInt(StringGrid1.Cells[1,i]);
             Params.ByName('DIR_KEY').AsInteger:=StrToInt(DIR_ID);
             if (pos('Ч',StringGrid1.Cells[4,i])<>0) or
                (pos('ч',StringGrid1.Cells[4,i])<>0) or
                (pos('Н',StringGrid1.Cells[4,i])<>0) or
                (pos('н',StringGrid1.Cells[4,i])<>0) then
             Params.ByName('SPEED').AsInteger:=StrToInt(Edit3.Text) else
             Params.ByName('SPEED').AsInteger:=StrToInt(Edit4.Text);
             fmMain.IBTR_WRITE.StartTransaction;
             ExecQuery;
             fmMain.IBTR_WRITE.Commit;
            end;

          end  else  //объекты пути
          if (AnsiCompareText(StringGrid1.Cells[2,i],'переезд')=0)   or
             (AnsiCompareText(StringGrid1.Cells[2,i],'платформа')=0) or
             (AnsiCompareText(StringGrid1.Cells[2,i],'мост')=0)      or
             (AnsiCompareText(StringGrid1.Cells[2,i],'туннель')=0)   then
           with fmMain.IBSQL do
            begin
             Close;
             SQL.Clear;
             SQL.LoadFromFile(SQL_DIR+'O_Import.sql');
             Params.ByName('KOORD').AsInteger:=StrToInt(StringGrid1.Cells[1,i]);
             Params.ByName('DIR_KEY').AsInteger:=StrToInt(DIR_ID);
             if  AnsiCompareText(StringGrid1.Cells[2,i],'мост')=0      then Prep_key:=7;
             if  AnsiCompareText(StringGrid1.Cells[2,i],'переезд')=0   then Prep_key:=1;
             if  AnsiCompareText(StringGrid1.Cells[2,i],'платформа')=0 then Prep_key:=6;
             if  AnsiCompareText(StringGrid1.Cells[2,i],'туннель')=0   then Prep_key:=8;
             Params.ByName('OBJ_KEY').AsInteger:=Prep_key;
             fmMain.IBTR_WRITE.StartTransaction;
             ExecQuery;
             fmMain.IBTR_WRITE.Commit;
            end;
         end
         else  //иначе импортируем только станции
         begin
          if (AnsiCompareText(StringGrid1.Cells[2,i],'станция')=0) or (AnsiCompareText(StringGrid1.Cells[2,i],'платформа*')=0) then
          with fmMain.IBSQL do
            begin
             Close;
             SQL.Clear;
             SQL.LoadFromFile(SQL_DIR+'S_Import.sql');
             Params.ByName('DIR_KEY').AsInteger:=StrToInt(DIR_ID);
             Params.ByName('FNAME').AsString:=Trim(StringGrid1.Cells[4,i]);

             if (StrToInt(StringGrid1.Cells[5,i]) mod 10)<>3 then
             Params.ByName('SPEED').AsInteger:=StrToInt(StringGrid1.Cells[5,i]) else
             Params.ByName('SPEED').AsInteger:=StrToInt(StringGrid1.Cells[5,i])-3;

             if (StringGrid1.Cells[8,i]<>'')  and (StringGrid1.Cells[9,i]<>'') then
            begin
              Params.ByName('KOORD').AsInteger:=Round(Abs(StrToInt(StringGrid1.Cells[1,strtoint(StringGrid1.Cells[8,i])])-
                                                    StrToInt(StringGrid1.Cells[1,strtoint(StringGrid1.Cells[9,i])]))/2+StrToInt(StringGrid1.Cells[1,strtoint(StringGrid1.Cells[8,i])]));

              tmp_koord:=StrToInt(StringGrid1.Cells[1,strtoint(StringGrid1.Cells[8,i])]);
              tmp_koord1:=StrToInt(StringGrid1.Cells[1,strtoint(StringGrid1.Cells[9,i])]);
              if tmp_koord>tmp_koord1 then begin tmp_koord0:=tmp_koord; tmp_koord:=tmp_koord1; tmp_koord1:=tmp_koord0; end;
              Params.ByName('BEG_KM').AsInteger:=(tmp_koord div 1000)+1;
              tmp_pik:=(tmp_koord mod 1000) div 100;
              Params.ByName('BEG_PK').AsInteger:=tmp_pik+1;

              Params.ByName('END_KM').AsInteger:=(tmp_koord1 div 1000)+1;
              tmp_pik:=(tmp_koord1 mod 1000) div 100;
              Params.ByName('END_PK').AsInteger:=tmp_pik+1;
            end
            else
            begin
              st_len:=strtoint(StringGrid1.Cells[7,i]);
              tmp_koord0:=StrToInt(StringGrid1.Cells[1,i]);
              if ((fmMain.IBDS_DirectionsWAY.Value=2)  and (fmMain.IBDS_DirectionsFLAG.Value=1)) or
                 ((fmMain.IBDS_DirectionsWAY.Value=1)  and (fmMain.IBDS_DirectionsFLAG.Value=0))
              then
              begin
                tmp_koord:=tmp_koord0;
                Params.ByName('BEG_KM').AsInteger:=(tmp_koord div 1000)+1;
                tmp_pik:=(tmp_koord mod 1000) div 100;
                Params.ByName('BEG_PK').AsInteger:=tmp_pik+1;

                tmp_koord1:=tmp_koord+st_len;
                Params.ByName('END_KM').AsInteger:=(tmp_koord1 div 1000)+1;
                tmp_pik:=(tmp_koord1 mod 1000) div 100;
                Params.ByName('END_PK').AsInteger:=tmp_pik+1;
              end else
              if ((fmMain.IBDS_DirectionsWAY.Value=1)  and (fmMain.IBDS_DirectionsFLAG.Value=1)) or
                 ((fmMain.IBDS_DirectionsWAY.Value=2)  and (fmMain.IBDS_DirectionsFLAG.Value=0))
              then
              begin
                tmp_koord1:=tmp_koord0;
                tmp_koord:=tmp_koord1-st_len;

                Params.ByName('BEG_KM').AsInteger:=(tmp_koord div 1000)+1;
                tmp_pik:=(tmp_koord mod 1000) div 100;
                Params.ByName('BEG_PK').AsInteger:=tmp_pik+1;


                Params.ByName('END_KM').AsInteger:=(tmp_koord1 div 1000)+1;
                tmp_pik:=(tmp_koord1 mod 1000) div 100;
                Params.ByName('END_PK').AsInteger:=tmp_pik+1;
              end ;
              Params.ByName('KOORD').AsInteger:=Round(Abs(tmp_koord1-tmp_koord)/2+tmp_koord);
    //          FieldByName('Koord').Value:=StrToInt(StringGrid1.Cells[1,i]);
            end;

             //Params.ByName('KOORD').AsInteger:=StrToInt(StringGrid1.Cells[1,i]);


             fmMain.IBTR_WRITE.StartTransaction;
             ExecQuery;
             fmMain.IBTR_WRITE.Commit;
          //  end;

          end;
         end;
        end;
        fmMain.IBDS_Light_Signals.EnableControls;
         fmMain.IBDS_Objects.EnableControls;
       end;
        Application.MessageBox('Данные успешно импортированы', 'Внимание!', MB_OK +
        MB_ICONINFORMATION + MB_TOPMOST);
      except
        Application.MessageBox('Ошибка при импорте данных', 'Внимание!', MB_OK +
          MB_ICONERROR + MB_TOPMOST);
      end;
  *)
end;

procedure TfmImport.N1Click(Sender: TObject);
var
  i:Byte;
begin
  for i:=0 to  clbFilterObjects.Count-1 do  clbFilterObjects.Checked[i]:=True;
  SetFilter(importGrid, StringGrid1, clbFilterObjects,clbFilterPath);

end;

procedure TfmImport.N2Click(Sender: TObject);
var
  i:Byte;
begin
    for i:=0 to  clbFilterObjects.Count-1 do  clbFilterObjects.Checked[i]:=false;
    SetFilter(importGrid, StringGrid1, clbFilterObjects,clbFilterPath);
end;

procedure TfmImport.MenuItem1Click(Sender: TObject);
var
  i:Byte;
begin
  for i:=0 to  clbFilterPath.Count-1 do  clbFilterPath.Checked[i]:=True;
  SetFilter(importGrid, StringGrid1, clbFilterObjects,clbFilterPath);
end;

procedure TfmImport.MenuItem2Click(Sender: TObject);
var
  i:Byte;
begin
    for i:=0 to  clbFilterPath.Count-1 do  clbFilterPath.Checked[i]:=false;
    SetFilter(importGrid, StringGrid1, clbFilterObjects,clbFilterPath);
end;

// определение участков (не точное)
procedure FindArea;
var
  i:Integer;
  del_old,del_cur: Integer;
  fl_i:integer;
begin
   cell_clr := RGB(RandomRange(200,256), RandomRange(200,256), RandomRange(200,256));
   clr_arr[1]:=cell_clr;
   if fmImport.StringGrid1.cells[1,1]='' then Exit;
   cell_old:=StrToInt(fmImport.StringGrid1.cells[1,1]);
   fl_change_clr:=False;
   fl_i:=0;
   for i:=2 to fmImport.StringGrid1.RowCount-1 do
   begin
     cell_cur:=StrToInt(fmImport.StringGrid1.cells[1,i]);
     if (i>2) and (i<fmImport.StringGrid1.RowCount-2) then
     begin
      del_old:=StrToInt(fmImport.StringGrid1.cells[1,i-1])-StrToInt(fmImport.StringGrid1.cells[1,i-2]);
      del_cur:=StrToInt(fmImport.StringGrid1.cells[1,i])-StrToInt(fmImport.StringGrid1.cells[1,i-1]);
     end;
     if  (Abs(cell_cur-cell_old)>20000) or
      //((cell_old=0) and (cell_cur=0))
     // ((Abs(cell_cur-cell_old)>10000) and (cell_cur=0))
      (((Sign(del_old)=1) and (Sign(del_cur)=-1)) or
      ((Sign(del_old)=-1) and (Sign(del_cur)=1)))
      then fl_change_clr:=True else fl_change_clr:=False;
     if (fl_change_clr) and (i>fl_i+2) then
     begin
       cell_clr := RGB(RandomRange(200,256), RandomRange(200,256), RandomRange(200,256));
       fl_change_clr:=False;
       fl_i:=i;
     end;
     clr_arr[i]:=cell_clr;

     cell_old:=cell_cur;
   end;
end;
var
 SelRow:Integer;
procedure TfmImport.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
  var
    FontColor : TColor; //Цвет шрифта.
    FontStyle : TFontStyles; //Стиль шрифта.
    BrColor : TColor; //Цвет кисти (цвет заливки).

begin

  with Sender as TStringGrid, Canvas do
  begin
    FontColor := Font.Color;
    FontStyle := Font.Style;
    BrColor := Brush.Color;
    Font.Size:=12;
    Font.Name:='Arial';
    if (ARow=0) or (ACol=0) then
    begin
      Brush.Color:=FixedColor;
      Font.Color:=clBlack;
    end
    else
    begin
    {  if gdSelected in State then begin //Если ячейка выделена.
        SelRow:=ARow;
        Font.Color := RGB(255, 255, 255); //Белый.
        Font.Style := Font.Style + [fsBold]; //Жирный шрифт.
        Brush.Color := RGB($66, $CC, 0); //Зелёный.
      end else   }
 {     if ARow mod 2 = 0 then begin //Нефиксированные строки с чётными индексами.
        Font.Color := RGB(0, 0, 0); //Чёрный.
        Brush.Color := RGB(255, 255, 255);//$00F5F5F5;  //Светло-жёлтый.
      end else
      begin //Нефиксированные строки с нечётными индексами.
        Font.Color := RGB(0, 0, 0); //Чёрный.
        Brush.Color := RGB(255, 255, 255); //Светло-синий.
      end;                                              }
      if ARow = ST_sel then begin
        Font.Color := RGB(0, 0, 0);
       // Font.Style := Font.Style + [fsBold];
        Brush.Color := $00AEF3A9;
      end else
      if ARow = SVT_sel then begin
        Font.Color := RGB(0, 0, 0);
       // Font.Style := Font.Style + [fsBold];
        Brush.Color := $00A4D8F7;
      end else
      begin
       Font.Color := RGB(0, 0, 0);
       if fmImport.ToolButton3.Down=true then
        Brush.Color :=  clr_arr[ARow] else
       if fmImport.ToolButton2.Down=True then
       begin
        if (AnsiCompareText(Cells[2,aRow],'станция')=0)   then  Brush.Color :=$00DCFADA else
        if (AnsiCompareText(Cells[2,aRow],'платформа')=0) or
           (AnsiCompareText(Cells[2,aRow],'платформа*')=0) then  Brush.Color :=$00FFD5D5 else
        if ((pos('Ч',Cells[4,aRow])<>0) or
           (pos('ч',Cells[4,aRow])<>0) or
           (pos('Н',Cells[4,aRow])<>0) or
           (pos('н',Cells[4,aRow])<>0)) and
           (AnsiCompareText(Cells[2,aRow],'светофор')=0) then  Brush.Color :=$00FCE3FD  else
        Brush.Color := RGB(255, 255, 255);
       end else
       Brush.Color := RGB(255, 255, 255);
      end;
    end  ;
    FillRect(Rect);
    if ARow=0 then
     DrawText(Handle, PChar(Cells[ACol, ARow]),Length(Cells[ACol, ARow]), Rect,DT_SINGLELINE OR DT_VCENTER OR DT_CENTER)
    else
    begin
     Rect.Left:=Rect.Left+5;
     DrawText(Handle, PChar(Cells[ACol, ARow]),Length(Cells[ACol, ARow]), Rect, DT_SINGLELINE OR DT_VCENTER OR DT_LEFT ) ;
    end;
    Font.Color := FontColor;
    Font.Style := FontStyle;
    Brush.Color := BrColor;
  end;

end;

procedure TfmImport.ToolButton3Click(Sender: TObject);
begin
 if ToolButton2.Down=True then ToolButton2.Down:=False;
 fmImport.StringGrid1.Repaint;
end;

procedure TfmImport.StringGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var C, R: Integer;
hint_txt:string;
begin
//  if Button=mbLeft then
  begin
   StringGrid1.MouseToCell(X, Y, C, R);
   if (C>= StringGrid1.FixedCols) and (R>= StringGrid1.FixedRows) then
   begin
    if  (AnsiCompareText(StringGrid1.Cells[2,R],'станция')=0) then
    begin
     ST_sel:=R;
     StringGrid1.PopupMenu:=PopupMenu4;
     if StringGrid1.Cells[8,ST_sel]='' then N7.Caption:= 'Входной не назначен' else
     N7.Caption:='Входной "'+ Trim(StringGrid1.Cells[4,strtoint(StringGrid1.Cells[8,ST_sel])])+'" '+StringGrid1.Cells[1,strtoint(StringGrid1.Cells[8,ST_sel])]+'м';
      if StringGrid1.Cells[9,ST_sel]='' then N8.Caption:='Выходной не назначен' else
     N8.Caption:='Выходной "'+ Trim(StringGrid1.Cells[4,strtoint(StringGrid1.Cells[9,ST_sel])])+'" '+StringGrid1.Cells[1,strtoint(StringGrid1.Cells[9,ST_sel])]+'м';

     StringGrid1.Repaint;
    end else
    if  (AnsiCompareText(StringGrid1.Cells[2,R],'светофор')=0) and (ST_sel<>-1) then
    begin
     SVT_sel:=R;
     StringGrid1.Repaint;
     StringGrid1.PopupMenu:=PopupMenu3;
     N3.Caption:=StringGrid1.Cells[4,ST_sel];
     end else
    if  (AnsiCompareText(StringGrid1.Cells[2,R],'платформа')=0) or (AnsiCompareText(StringGrid1.Cells[2,R],'платформа*')=0) then
     begin
       PLF_sel:=R;
       StringGrid1.Repaint;
       StringGrid1.PopupMenu:=PopupMenu5;
       IF StringGrid1.Cells[8,PLF_sel]='' then begin
        N9.Visible:=True;
        N10.Visible:=false; end else begin
        N9.Visible:=False;
        N10.Visible:=true; end;

     end else
    StringGrid1.PopupMenu:=nil;
   end;
   end;
end;

procedure TfmImport.N5Click(Sender: TObject);
begin
 StringGrid1.Cells[8,ST_sel]:=IntToStr(SVT_sel);//StringGrid1.Cells[1,SVT_sel];
end;

procedure TfmImport.N6Click(Sender: TObject);
begin
 StringGrid1.Cells[9,ST_sel]:=IntToStr(SVT_sel);//StringGrid1.Cells[1,SVT_sel];
end;

procedure TfmImport.StringGrid1ContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  StringGrid1.Repaint;
end;

procedure TfmImport.N3DrawItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; Selected: Boolean);
var
  mnu: TMenuitem;
begin
 mnu := Sender As TMenuitem;
  aCanvas.font.name := 'Arial';
  aCanvas.font.size := 12;
  If selected then begin
    aCanvas.font.color := clBlack;
    aCanvas.Font.Style:=[fsBold];
    aCanvas.brush.color := clBtnFace;;
  end
  else begin
    aCanvas.font.color := clBlack;
    aCanvas.Font.Style:=[fsBold];
    aCanvas.brush.color := clBtnFace;
  end;
  acanvas.brush.style := bsSolid;
  aCanvas.fillrect( aRect );
  DrawText(ACanvas.Handle, PChar(mnu.caption), Length(mnu.caption),
      ARect, DT_CENTER or DT_VCENTER);
end;

procedure TfmImport.N7DrawItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; Selected: Boolean);
var
  mnu: TMenuitem;
begin
 mnu := Sender As TMenuitem;
  aCanvas.font.name := 'Arial';
  aCanvas.font.size := 10;
  If selected then begin
    aCanvas.font.color := clBlack;
    aCanvas.brush.color := clBtnFace;;
  end
  else begin
    aCanvas.font.color := clBlack;
    aCanvas.brush.color := clBtnFace;
  end;
  aCanvas.brush.style := bsSolid;
  aCanvas.fillrect( aRect );
  acanvas.textrect( aRect, arect.left+4, arect.top+2, Trim(mnu.caption) );
//  DrawText(ACanvas.Handle, PChar(mnu.caption), Length(mnu.caption),
//      ARect, DT_LEFT{ or DT_VCENTER});
end;

procedure TfmImport.N7MeasureItem(Sender: TObject; ACanvas: TCanvas;
  var Width, Height: Integer);
begin
 aCanvas.font.name := 'Arial';
 aCanvas.font.size := 10;
 Width := aCanvas.TextWidth(TMenuItem(Sender).Caption) + 4;
 Height := aCanvas.TextHeight(TMenuItem(Sender).Caption) + 4;
end;

procedure TfmImport.N5DrawItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; Selected: Boolean);
var
  mnu: TMenuitem;
begin
 mnu := Sender As TMenuitem;
  aCanvas.font.name := 'Arial';
  aCanvas.font.size := 10;
  If selected then begin
    aCanvas.font.color := clWhite;
    aCanvas.brush.color := clBtnFace;
    ACanvas.Brush.Color:=clNavy;

  end
  else begin
    aCanvas.font.color := clBlack;
    aCanvas.brush.color := clBtnFace;
  end;
  aCanvas.brush.style := bsSolid;
  aCanvas.fillrect( aRect );
  acanvas.textrect( aRect, arect.left+4, arect.top+2, trim(mnu.caption) );
 // DrawText(ACanvas.Handle, PChar(mnu.caption), Length(mnu.caption),
//      ARect, DT_LEFT or DT_VCENTER);

end;

procedure TfmImport.ToolButton2Click(Sender: TObject);
begin
 if ToolButton3.Down=True then ToolButton3.Down:=False;
 fmImport.StringGrid1.Repaint;
end;

procedure TfmImport.N9Click(Sender: TObject);
begin
 StringGrid1.Cells[8,PLF_sel]:='*';
 StringGrid1.Cells[2,PLF_sel]:='платформа*';
end;

procedure TfmImport.N10Click(Sender: TObject);
begin
 StringGrid1.Cells[8,PLF_sel]:='';
 StringGrid1.Cells[2,PLF_sel]:='платформа';

end;

procedure TfmImport.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action:=caFree;
 fmMain.tbImport.Down:=False;
end;

procedure TfmImport.FormDestroy(Sender: TObject);
begin
  fmImport:=nil;
end;

end.
