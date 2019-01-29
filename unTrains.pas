unit unTrains;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
   DB, DBTables, ExtCtrls, DBCtrls, Grids, DBGrids,
  DBGridEhGrouping, GridsEh, DBGridEh, Menus,Dialogs, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, EhLibVCL, DBAxisGridsEh;

type
  TfmTrains = class(TForm)
    Panel1: TPanel;
    DBG_Trains: TDBGridEh;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure DBG_TrainsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTrains: TfmTrains;

implementation

uses unMain, unVars;

{$R *.dfm}

procedure TfmTrains.DBG_TrainsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
 DBG_Trains.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfmTrains.FormCreate(Sender: TObject);
begin
 with Panel1 do
 begin
  Left:=4;
  top:=4;
  Width:=fmTrains.ClientWidth-8;
  Height:=fmTrains.ClientHeight-8
 end;
 with DBG_Trains do
 begin
  Left:=4;
  top:=4;
  Width:=Panel1.Width-8;
  Height:=Panel1.Height-8
 end;
end;

procedure TfmTrains.FormResize(Sender: TObject);
begin
 with Panel1 do
 begin
  Left:=4;
  top:=4;
  Width:=fmTrains.ClientWidth-8;
  Height:=fmTrains.ClientHeight-8
 end;
 with DBG_Trains do
 begin
  Left:=4;
  top:=4;
  Width:=Panel1.Width-8;
  Height:=Panel1.Height-8
 end;
end;

end.
