unit unPrepinfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, DB, DBTables, Mask, Menus, Grids, DBGrids,
  ExtCtrls, DBGridEhGrouping, GridsEh, DBGridEh, ToolCtrlsEh, DBGridEhToolCtrls,
  DynVarsEh, EhLibVCL, DBAxisGridsEh;

type
  TfmPrepinfo = class(TForm)
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    Panel1: TPanel;
    DBG_PrepInfo: TDBGridEh;
    N2: TMenuItem;
    procedure DBG_PrepInfoDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh;
      State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPrepinfo: TfmPrepinfo;

implementation

uses unMain, unPrep, unVars;

{$R *.dfm}

procedure TfmPrepinfo.DBG_PrepInfoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
 DBG_Prepinfo.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

end.
