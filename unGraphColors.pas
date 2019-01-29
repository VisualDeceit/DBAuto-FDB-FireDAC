unit unGraphColors;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, IniFiles, XMLIntf, XMLDoc, Vcl.ComCtrls;

type
  TfmGraphColors = class(TForm)
    lbl1: TLabel;
    dlgColor1: TColorDialog;
    pnl1: TPanel;
    lbl6: TLabel;
    pnl6: TPanel;
    GroupBox1: TGroupBox;
    pnl2: TPanel;
    pnl3: TPanel;
    lbl3: TLabel;
    lbl2: TLabel;
    Label1: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Label2: TLabel;
    Edit2: TEdit;
    UpDown2: TUpDown;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit3: TEdit;
    UpDown3: TUpDown;
    Edit4: TEdit;
    UpDown4: TUpDown;
    pnl4: TPanel;
    pnl5: TPanel;
    GroupBox3: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Edit5: TEdit;
    UpDown5: TUpDown;
    Edit6: TEdit;
    UpDown6: TUpDown;
    pnl7: TPanel;
    pnl8: TPanel;
    GroupBox4: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Edit7: TEdit;
    UpDown7: TUpDown;
    Edit8: TEdit;
    UpDown8: TUpDown;
    pnl9: TPanel;
    pnl10: TPanel;
    procedure pnl1Click(Sender: TObject);
    procedure pnl2Click(Sender: TObject);
    procedure pnl3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pnl4Click(Sender: TObject);
    procedure pnl5Click(Sender: TObject);
    procedure pnl6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pnl7Click(Sender: TObject);
    procedure pnl8Click(Sender: TObject);
    procedure pnl9Click(Sender: TObject);
    procedure pnl10Click(Sender: TObject);
    procedure UpDown1ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Integer; Direction: TUpDownDirection);
    procedure UpDown2ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Integer; Direction: TUpDownDirection);
    procedure UpDown3ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Integer; Direction: TUpDownDirection);
    procedure UpDown4ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Integer; Direction: TUpDownDirection);
    procedure UpDown5ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Integer; Direction: TUpDownDirection);
    procedure UpDown6ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Integer; Direction: TUpDownDirection);
    procedure UpDown7ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Integer; Direction: TUpDownDirection);
    procedure UpDown8ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Integer; Direction: TUpDownDirection);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmGraphColors: TfmGraphColors;

implementation

uses unMain, unGraph;

{$R *.dfm}

procedure TfmGraphColors.pnl1Click(Sender: TObject);
begin
 if dlgColor1.Execute then
 begin
   cl_BackGround:=dlgColor1.Color;
   fmGraph.PaintBox1.Repaint;
   pnl1.Color:=cl_BackGround;
 end;
end;

procedure TfmGraphColors.pnl2Click(Sender: TObject);
begin
 if dlgColor1.Execute then
 begin
   cl_Axis:=dlgColor1.Color;
   fmGraph.PaintBox1.Repaint;
   pnl2.Color:=cl_Axis;
 end;
end;

procedure TfmGraphColors.pnl3Click(Sender: TObject);
begin
 if dlgColor1.Execute then
 begin
   cl_AxisText:=dlgColor1.Color;
   fmGraph.PaintBox1.Repaint;
   pnl3.Color:=cl_AxisText;
 end;
end;

procedure TfmGraphColors.FormActivate(Sender: TObject);
begin
  edit1.Text:=inttostr(w_axis);
  edit2.Text:=inttostr(t_axis);
  edit3.Text:=inttostr(w_limit);
  edit4.Text:=inttostr(t_limit);
  edit5.Text:=inttostr(w_Station);
  edit6.Text:=inttostr(t_Station);
  edit7.Text:=inttostr(w_svet);
  edit8.Text:=inttostr(t_svet);
end;

procedure TfmGraphColors.FormClose(Sender: TObject;
  var Action: TCloseAction);
  var
      LDocument: IXMLDocument;
        LNodeRoot, LNodeChild, LNode: IXMLNode;
begin
  try
    LDocument := TXMLDocument.Create(nil);
    LDocument.LoadFromFile(extractfilepath(application.ExeName)+'Setup.xml');
    LDocument.Active:=true;
    LNodeRoot := LDocument.ChildNodes.FindNode('Setup');

    LNodeChild:= LNodeRoot.ChildNodes.FindNode('Graph');
    LNode:=LNodeChild.ChildNodes.FindNode('Background');
    LNode.SetAttribute('Color',cl_BackGround);

    LNode:=LNodeChild.ChildNodes.FindNode('Axis');
    LNode.SetAttribute('LineColor',cl_Axis);
    LNode.SetAttribute('LineWidth',w_Axis);
    LNode.SetAttribute('TextColor',cl_AxisText);
    LNode.SetAttribute('TextHeight',t_Axis);

    LNode:=LNodeChild.ChildNodes.FindNode('Limits');
    LNode.SetAttribute('LineColor',cl_Limit);
    LNode.SetAttribute('LineWidth',w_Limit);
    LNode.SetAttribute('TextColor',cl_LimitText);
    LNode.SetAttribute('TextHeight',t_Limit);

    LNode:=LNodeChild.ChildNodes.FindNode('Stations');
    LNode.SetAttribute('LineColor',cl_Station);
    LNode.SetAttribute('LineWidth',w_Station);
    LNode.SetAttribute('TextColor',cl_StationText);
    LNode.SetAttribute('TextHeight',t_Station);

    LNode:=LNodeChild.ChildNodes.FindNode('LightSignals');
    LNode.SetAttribute('LineColor',cl_svet);
    LNode.SetAttribute('TextColor',cl_svettext);
    LNode.SetAttribute('LineWidth',w_svet);
    LNode.SetAttribute('TextHeight',t_svet);

    LNode:=LNodeChild.ChildNodes.FindNode('Profil');
    LNode.SetAttribute('Color',cl_Uklon);

    LDocument.SaveToFile(extractfilepath(application.ExeName)+'Setup.xml');
    LDocument.Active:=false;
  finally

  end;
end;

procedure TfmGraphColors.pnl4Click(Sender: TObject);
begin
 if dlgColor1.Execute then
 begin
   cl_Limit:=dlgColor1.Color;
   fmGraph.PaintBox1.Repaint;
   pnl4.Color:=cl_Limit;
 end;
end;

procedure TfmGraphColors.pnl5Click(Sender: TObject);
begin
 if dlgColor1.Execute then
 begin
   cl_LimitText:=dlgColor1.Color;
   fmGraph.PaintBox1.Repaint;
   pnl5.Color:=cl_LimitText;
 end;
end;

procedure TfmGraphColors.pnl6Click(Sender: TObject);
begin
 if dlgColor1.Execute then
 begin
   cl_Uklon:=dlgColor1.Color;
   fmGraph.PaintBox1.Repaint;
   pnl6.Color:=cl_Uklon;
 end;
end;

procedure TfmGraphColors.FormCreate(Sender: TObject);
begin
   pnl1.Color:=cl_BackGround;

   pnl2.Color:=cl_Axis;
   pnl3.Color:=cl_AxisText;

   pnl4.Color:=cl_Limit;
   pnl5.Color:=cl_LimitText;


   pnl7.Color:=cl_Station;
   pnl8.Color:=cl_StationText;


   pnl6.Color:=cl_Uklon;

   pnl9.Color:=cl_svet;
   pnl10.Color:=cl_svettext;

end;

procedure TfmGraphColors.pnl7Click(Sender: TObject);
begin
 if dlgColor1.Execute then
 begin
   cl_Station:=dlgColor1.Color;
   fmGraph.PaintBox1.Repaint;
   pnl7.Color:=cl_Station;
 end;
end;

procedure TfmGraphColors.pnl8Click(Sender: TObject);
begin
 if dlgColor1.Execute then
 begin
   cl_StationText:=dlgColor1.Color;
   fmGraph.PaintBox1.Repaint;
   pnl8.Color:=cl_StationText;
 end;
end;

procedure TfmGraphColors.pnl9Click(Sender: TObject);
begin
 if dlgColor1.Execute then
 begin
   cl_svet:=dlgColor1.Color;
   fmGraph.PaintBox1.Repaint;
   pnl9.Color:=cl_svet;
 end;
end;

procedure TfmGraphColors.UpDown1ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Integer; Direction: TUpDownDirection);
begin
 if (NewValue<=UpDown1.Max) and (NewValue>=UpDown1.Min) then
 begin
   w_Axis:=NewValue;
   fmGraph.PaintBox1.Repaint;
 end;
end;

procedure TfmGraphColors.UpDown2ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Integer; Direction: TUpDownDirection);
begin
  if (NewValue<=UpDown2.Max) and (NewValue>=UpDown2.Min) then
 begin
   t_Axis:=NewValue;
   fmGraph.PaintBox1.Repaint;
 end;
end;

procedure TfmGraphColors.UpDown3ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Integer; Direction: TUpDownDirection);
begin
  if (NewValue<=UpDown3.Max) and (NewValue>=UpDown3.Min) then
 begin
   w_limit:=NewValue;
   fmGraph.PaintBox1.Repaint;
 end;
end;

procedure TfmGraphColors.UpDown4ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Integer; Direction: TUpDownDirection);
begin
  if (NewValue<=UpDown4.Max) and (NewValue>=UpDown4.Min) then
 begin
   t_limit:=NewValue;
   fmGraph.PaintBox1.Repaint;
 end;
end;

procedure TfmGraphColors.UpDown5ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Integer; Direction: TUpDownDirection);
begin
  if (NewValue<=UpDown5.Max) and (NewValue>=UpDown5.Min) then
 begin
   w_Station:=NewValue;
   fmGraph.PaintBox1.Repaint;
 end;
end;

procedure TfmGraphColors.UpDown6ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Integer; Direction: TUpDownDirection);
begin
  if (NewValue<=UpDown6.Max) and (NewValue>=UpDown6.Min) then
 begin
   t_Station:=NewValue;
   fmGraph.PaintBox1.Repaint;
 end;
end;

procedure TfmGraphColors.UpDown7ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Integer; Direction: TUpDownDirection);
begin
  if (NewValue<=UpDown7.Max) and (NewValue>=UpDown7.Min) then
 begin
   w_Svet:=NewValue;
   fmGraph.PaintBox1.Repaint;
 end;
end;

procedure TfmGraphColors.UpDown8ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Integer; Direction: TUpDownDirection);
begin
  if (NewValue<=UpDown8.Max) and (NewValue>=UpDown8.Min) then
 begin
   t_Svet:=NewValue;
   fmGraph.PaintBox1.Repaint;
 end;
end;

procedure TfmGraphColors.pnl10Click(Sender: TObject);
begin
 if dlgColor1.Execute then
 begin
   cl_svettext:=dlgColor1.Color;
   fmGraph.PaintBox1.Repaint;
   pnl10.Color:=cl_svettext;
 end;
end;

end.
