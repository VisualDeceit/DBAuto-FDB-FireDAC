unit unStationExport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfmstationExport = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmstationExport: TfmstationExport;

implementation

uses unStations, unVars, unMain;

{$R *.dfm}

procedure TfmstationExport.Button1Click(Sender: TObject);
begin
  if Edit1.Text<>'' then begin
   Per_speed:=StrToInt(Edit1.Text);
   Close;
  end
end;

procedure TfmstationExport.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9',#8]) then key:=chr(0);
end;

end.
