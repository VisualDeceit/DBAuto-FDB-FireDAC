unit unAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfmAbout = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Bevel1: TBevel;
    Label2: TLabel;
    Bevel2: TBevel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAbout: TfmAbout;

implementation

uses unMain;

{$R *.dfm}

procedure TfmAbout.FormCreate(Sender: TObject);
begin
 Label3.Caption:= Label3.Caption+GetMyVersion;
end;

end.
