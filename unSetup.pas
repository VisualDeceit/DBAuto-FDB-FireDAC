unit unSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls,ShellAPI, ExtCtrls,IniFiles;

type
  TfmSetup = class(TForm)
    GroupBox1: TGroupBox;
    btReserv: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    RadioGroup1: TRadioGroup;
    procedure btBrowseClick(Sender: TObject);
    procedure btReservClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSetup: TfmSetup;
  procedure Reserv_DB;
implementation

uses unMain;

{$R *.dfm}
function DelDir(dir: string): Boolean;
var
  fos: TSHFileOpStruct;
begin
  ZeroMemory(@fos, SizeOf(fos));
  with fos do
  begin
    wFunc  := FO_DELETE;
    fFlags := FOF_SILENT or FOF_NOCONFIRMATION;
    pFrom  := PChar(dir + #0);
  end;
  Result := (0 = ShFileOperation(fos));
end;

procedure Reserv_DB;
var
 sr_source:TSearchRec;
 time:string;
 temp_count:Byte;
 temp_name:string;
 dat1,dat2:TDateTime;
begin
  reserv_path:=extractfilepath(application.ExeName)+'DB_Backup\';
  DateTimeToString(time,'hhnnss ddmmyyyy',Now);
  CreateDir(reserv_path+time);
  If FindFirst(extractfilepath(application.ExeName)+'DB\*.*',faanyfile,sr_source)=0 then
  repeat
    CopyFile(PChar(extractfilepath(application.ExeName)+'DB\'+sr_source.Name),PChar(reserv_path+time+'\'+sr_source.Name),False);
  until FindNext(sr_source) <> 0;
 temp_count:=0;
 If FindFirst(reserv_path+'\*',faDirectory,sr_source)=0 then
 repeat
    if (sr_source.Name <> '..') and (sr_source.Name <> '.') then inc(temp_count);
  until FindNext(sr_source) <> 0;

 while temp_count>reserv_count do
  begin
   dat2:=strtodate('31.12.2100');
   If FindFirst(reserv_path+'\*',faDirectory,sr_source)=0 then
   repeat
    begin
     dat1:=FileDateToDateTime(sr_source.time);
     if dat1<dat2 then
     begin
      temp_name:=sr_source.Name;
      dat2:=dat1;
     end;
    end;
   until FindNext(sr_source) <> 0;
   DelDir(reserv_path+temp_name);
   temp_count:=0;
   If FindFirst(reserv_path+'\*',faDirectory,sr_source)=0 then
   repeat
     if (sr_source.Name <> '..') and (sr_source.Name <> '.') then inc(temp_count);
   until FindNext(sr_source) <> 0;
  end;
 FindClose(sr_source);

end;

procedure TfmSetup.btBrowseClick(Sender: TObject);
begin
// AdvBrowseDirectory('Укажите папку для резервирования...','',reserv_path,False,False,true,true);
end;

procedure TfmSetup.btReservClick(Sender: TObject);
begin
  reserv_count:=StrToInt(fmSetup.Edit1.Text);
  Reserv_DB;

end;


procedure TfmSetup.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9',#8]) then key:=chr(0);
end;


procedure TfmSetup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 reserv_count:=StrToInt(Edit1.Text);
 reserv_mode:=RadioGroup1.ItemIndex;
 end;

procedure TfmSetup.FormCreate(Sender: TObject);
begin
  fmSetup.Edit1.Text:=IntToStr(reserv_count);
  RadioGroup1.ItemIndex:=reserv_mode;
end;

end.
