unit unShiftSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEh, StdCtrls, Mask, DBCtrlsEh, DBLookupEh, DBTables, DB;

type
  TfmShiftSet = class(TForm)
    DBLookupComboboxEh1: TDBLookupComboboxEh;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmShiftSet: TfmShiftSet;

implementation

uses unMain, unVars;

{$R *.dfm}

procedure TfmShiftSet.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9',#8]) then key:=chr(0);
end;

procedure TfmShiftSet.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9',#8]) then key:=chr(0);
end;

procedure TfmShiftSet.Button1Click(Sender: TObject);
var
  i:Word;
  sql_str:string;
   Temp_Query: Tdataset;
begin
{ with fmMain.qtTemp do
 begin
  Close;
  Active:=false;
  SQL.Clear;
  sql_str:=
       'UPDATE Stations'+#13+
       'SET Shift_key='+inttostr(fmMain.tShift.FieldValues['Shift_ID'])+#13+
       'WHERE  (Dir_key='+DIR_ID+')'+ 'and ST_ID IN (SELECT ST_ID FROM stations'+#13+
       'ROWS 2 to 4)';
  SQL.Add(sql_str);
//  SQL.Add('Order by Koord');
 // SQL.Add('LIMIT 3');
  ExecSQL;
 end;
 DS_Refresh_All;      }
{ case Shift_source of
  1: Temp_Query:=fmMain.IBDS_Stations;
  2: Temp_Query:=fmMain.IBDS_Limits;
 end;

 Temp_Query.RecNo:=StrToInt(Edit1.Text);
 for i:=StrToInt(Edit1.Text) to  StrToInt(Edit2.Text) do
 begin
  Temp_Query.Edit;
  Temp_Query.FieldByName('Shift_key').Value:=fmMain.tShift.FieldValues['Shift_ID'];
  Temp_Query.Post;
  Temp_Query.Next;
 end;
 Edit1.Text:=IntToStr(StrToInt(Edit2.Text)+1);    }
end;


procedure TfmShiftSet.Button2Click(Sender: TObject);
var
  i:Word;
  sql_str,str_source:string;
begin
{  case Shift_source of
    1: str_source:='Stations';
    2: str_source:='Limits';
  end;
 with fmMain.qtTemp do
 begin
  Close;
  Active:=false;
  SQL.Clear;
  sql_str:=
       'UPDATE '+str_source+#13+
       'SET Shift_key= NULL '+#13+
       'WHERE  Dir_key='+DIR_ID;
    //   'LIMIT '+Edit1.Text;//+','+Edit2.Text;
  SQL.Add(sql_str);
  ExecSQL;
 end;
 DS_Refresh_All;
         }

end;

procedure TfmShiftSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 DS_Refresh_All;
end;

end.


