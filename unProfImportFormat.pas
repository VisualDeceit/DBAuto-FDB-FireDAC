unit unProfImportFormat;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls,ComObj, Vcl.ComCtrls;

type
  TfmProfImportFormat = class(TForm)
    Image1: TImage;
    RadioButton1: TRadioButton;
    Button1: TButton;
    LabeledEdit1: TLabeledEdit;
    ProgressBar1: TProgressBar;
    Image2: TImage;
    RadioButton2: TRadioButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmProfImportFormat: TfmProfImportFormat;

implementation

{$R *.dfm}

uses unMain, unProf, unVars;

procedure TfmProfImportFormat.Button1Click(Sender: TObject);
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
    i,j:Integer;
  beg_km, beg_pk, end_km, end_pk:LongInt;
  value:integer;
  znak:string;
  beg_ROW:word;
  Import_Formt:byte;
begin
 beg_ROW:=strtoint(LabeledEdit1.Text) ;
 if RadioButton1.Checked then Import_Formt:=1;
 if RadioButton2.Checked then Import_Formt:=2;

 //fmProfImportFormat.Close;

if fmProf.ImportDialog.Execute then
 begin
  // Create Excel-OLE Object
  XLApp := CreateOleObject('Excel.Application');
  try
    // Hide Excel
    XLApp.Visible := False;
    // Open the Workbook
    XLApp.Workbooks.Open(fmProf.ImportDialog.FileName);
    // Sheet := XLApp.Workbooks[1].WorkSheets[1];
    Sheet := XLApp.Workbooks[ExtractFileName(fmProf.ImportDialog.FileName)].WorkSheets[1];
    // In order to know the dimension of the WorkSheet, i.e the number of rows
    // and the number of columns, we activate the last non-empty cell of it
    Sheet.Cells.SpecialCells(xlCellTypeLastCell, EmptyParam).Activate;
    // Get the value of the last row
    x := XLApp.ActiveCell.Row;
    // Get the value of the last column
    y := XLApp.ActiveCell.Column;
    // Set Stringgrid's row &col dimensions.
    // Assign the Variant associated with the WorkSheet to the Delphi Variant
    RangeMatrix := XLApp.Range['A1', XLApp.Cells.Item[X, Y]].value;

    ProgressBar1.Min:=beg_ROW;
    ProgressBar1.Max:=x-1;
    ProgressBar1.Update;

    //для первого варианта
    if Import_Formt=1 then
      try
       if (DIR_ID<>null) then
       begin
        for i:=beg_ROW to x-1 do
         begin
          beg_km:=RangeMatrix[i,1];
          beg_pk:=round(RangeMatrix[i,2]/100);
          end_km:=RangeMatrix[i,3];
          end_pk:=round(RangeMatrix[i,4]/100);
          znak:= RangeMatrix[i,5];
          value:=trunc(RangeMatrix[i,6]*10);

          if (znak='с') or (znak='С') or (znak='c') or (znak='C')  then value:=value*-1;

          for j := beg_km*10+beg_pk to end_km*10+end_pk-1 do
          begin
            with fmMain.IBDS_prof do
            begin
              Insert;
              FieldByName('FValue').Value:=value;
              FieldByName('NUMBER').Value:=j;

              Post;
            end;
          end;
           ProgressBar1.Position:=i;
         end;
       end;
        Application.MessageBox('Данные успешно импортированы', 'Внимание!', MB_OK +
        MB_ICONINFORMATION + MB_TOPMOST);
      except
        Application.MessageBox('Ошибка при импорте данных', 'Внимание!', MB_OK +
          MB_ICONERROR + MB_TOPMOST);
      end;
      //для второго варианта
      if Import_Formt=2 then
      try
       if (DIR_ID<>null) then
       begin
          for i:=beg_ROW to x-1 do
          begin
            with fmMain.IBDS_prof do
            begin
              Insert;
              FieldByName('FValue').Value:=RangeMatrix[i,1];
              FieldByName('NUMBER').Value:=i;
              Post;
            end;
             ProgressBar1.Position:=i;
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
      XLApp.Quit;
      XLAPP := Unassigned;
      Sheet := Unassigned;
      RangeMatrix := Unassigned;
    end;
  end;
 end;

end;

end.
