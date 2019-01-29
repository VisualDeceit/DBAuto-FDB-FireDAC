unit unGraph;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExtCtrls, StdCtrls, Math,Contnrs,
  Menus, ComCtrls, ToolWin, ActiveX, IGDIPlus, VCL.IGDIPlusExt, System.Types;

type
{  TMyStreamAdapter = class(TStreamAdapter)
  public
    function Stat(out statstg: TStatStg; grfStatFlag: Longint): HResult; override; stdcall;
  end;   }

  TfmGraph = class(TForm)
    ToolBar1: TToolBar;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    ScrollBox1: TScrollBox;
    PopupMenu1: TPopupMenu;
    PaintBox1: TPaintBox;
    Timer1: TTimer;
    btn1: TToolButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure ScrollBox1CanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure btn1Click(Sender: TObject);

  private
    { Private declarations }
     procedure MouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
     procedure MouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
  public
    { Public declarations }
     procedure Init;
     procedure Calc;
     procedure DrawAxis;
     procedure DrawObjects;

  end;

  TStation = class
  private
    procedure Paint;
  public
    Rect  : TIGPRectF;
    Koord : LongInt;
    Name  : string[9];
    Select: Boolean;
  end;

  TSvet = class
  private
    procedure Paint;
  protected
  public
    Rect  : TIGPRectF;
    Koord : LongInt;
    Name  : string[9];
    Select: Boolean;
  end;

   TObj = class
  private
    procedure Paint;
  protected

  public
    Rect  : TIGPRectF;
    Koord : LongInt;
    FType : byte;
    //Name  : string[9];
    Select: Boolean;
  end;

  TLimit = class
  private
    procedure Paint;
  public
   P1    : TPointF;
   P2    : TPointF;
   P0  : TPointF;
   Speed : Byte;
   Select: Boolean;
  end;


  TSationList = class(TObjectList)
  private
    Active: Boolean;
    Ind: Integer;
    function GetItems(Index: Integer): TStation;
    procedure SetItems(Index: Integer; const Value: TStation);
  public
    property Items[Index: Integer]: TStation read GetItems write SetItems; default;

  end;

  TSvetList = class(TObjectList)
  private
    Active: Boolean;
    Ind: Integer;
    function GetItems(Index: Integer): TSvet;
    procedure SetItems(Index: Integer; const Value: TSvet);
  public
    property Items[Index: Integer]: TSvet read GetItems write SetItems; default;
  end;

  TObjList = class(TObjectList)
  private
    Active: Boolean;
    Ind: Integer;
    function GetItems(Index: Integer): TObj;
    procedure SetItems(Index: Integer; const Value: TObj);
  public
    property Items[Index: Integer]: TObj read GetItems write SetItems; default;
  end;

  TLimitList =  class(TObjectList)
  private
     Active_Hor, Active_Ver, Active_Div: Boolean;
    Ind: Integer;
    function GetItems(Index: Integer): TLimit;
    procedure SetItems(Index: Integer; const Value: TLimit);
  public
    property Items[Index: Integer]: TLimit read GetItems write SetItems; default;
  end;

  TUKRec= record
   P: TPointF;
   Value: Real;
  end;

  type

  TUklon = array of TUKRec;

  var
    fmGraph: TfmGraph;
    axis_x0,axis_xp,
    axis_x_len,
    axis_y0,axis_y_len,
    axis_UK_len,axis_UK0,
    axis_x_font :real;
    CPtKoord : TPointF;
    div_x,div_y,div_UK,del_pk,del_pk_px:real;
    div_x_km,div_y_v,div_x_pk:real;
    del_km:SmallInt;
    del_500_m:SmallInt;
    draw_koord:Integer;
    Beg_Coord,End_Coord,Del_Coord:Integer;
    px_1km, px_1m, px_1km4, px_1uk: Real;
    del_x:Real;
    Scroll: Integer;
    Zoom:Real=0.1;
    km:integer;
    StationList: TSationList;    //станции
    SvetList: TSvetList;
    ObjList: TObjList;
    LimitList: TLimitList;
    Uk: TUklon;
    procedure FillData4Graph;
    procedure Sum_Limits;
const
    V_lim=140;
    Zone=0.7;
    station_size=32;
implementation
uses unMain, unLimits, unVars, unGraphColors;
var
    gpDrawer    : IGPGraphics;
    gpPen       : TIGPPen;
    gpBrush     : IGPSolidBrush;
    gpFontFml   : TIGPFontFamily;
    gpFont      : TIGPFont;
    gpSFormat   : TIGPStringFormat;
    gpImage     : TIGPImage;
    FBGBitmap   : TBitmap;
    gpMouse     : TPointF;




{$R *.dfm}

procedure Sum_Limits;
var
  SQL_Str:string;
  _Lim_ID, _Dir_KEY, _KBeg, _PBeg, _KEnd, _PEnd, _Speed, _Note, _Shift_KEY: Integer;
  i:Integer;
begin
 with fmMain.IBDS_Limits do
  begin
  { close;
   Active:=false;
   SQL.Clear;
    SQL_Str:='SELECT L.Lim_ID, L.Dir_KEY, L.KBeg, L.PBeg, L.KEnd, L.PEnd, L.Speed, L.Note, L.Shift_KEY,'+
             '(L.KBeg*1000+ L.pBeg*100)* SH.Shift_Flag+ SH.Shift_Value AS  Sort_koord'+#13+
             'FROM  Limits L'+#13+
             'LEFT OUTER JOIN Shift SH'+#13+
             'ON  (L.Shift_KEY = Sh.Shift_ID)'+#13+
             'WHERE  L.Dir_key='+DIR_ID;
    SQL.Add(SQL_Str);
    if not fl_Shift then  SQL.Add('ORDER BY Kbeg, Pbeg') else SQL.Add('ORDER BY Sort_koord') ;
   Active:=true;          }
   DisableControls;
   last;
   first;
   if FieldByName('BEG_KM').Value=null then Exit;
   First;
   for i:=1 to RecordCount-1 do
   begin
     _Kbeg:=FieldValues['BEG_KM'];
     _PBeg:=FieldValues['BEG_PK'];
     _PEnd:=FieldValues['END_PK'];
     _KEnd:=FieldValues['END_KM'];
     _Speed:=FieldValues['Speed'];
     Next;
     if _Speed=FieldValues['Speed'] then
     begin
       Edit;
       FieldValues['BEG_KM']:=_Kbeg;
       FieldValues['BEG_PK']:=_PBeg;
       Post;
       Prior;
       Delete
     {  _Lim_ID:=FieldByName('Lim_ID').Value;
        with fmMain.qtDelete do
        begin
         close;
         Active:=false;
         SQL.Clear;
         SQL.Add('Delete FROM Limits');
         SQL.Add('WHERE Lim_ID='+Dir_ID);
         ExecSQL;
        end;  }
     end;
   end;
   EnableControls;
  end;

end;

procedure FillData4Graph;
var
  SQL_Str:string;
  i:Integer;
  gpRect:TIGPRectF;
  gpSize:TIGPSizeF;
  Station:TStation;
  Svet: TSvet;
  Limit: TLimit;
  Obj: TObj;
  tmp:TPointF;
  sclx: Real;
  out_width,out_height: Integer;
begin
 //**************************ОГРАНИЧЕНИЯ****************************************
(* with fmMain.qtTemp do
  begin
   close;
   Active:=false;
   SQL.Clear;
    SQL_Str:='SELECT L.Lim_ID, L.Dir_KEY, L.KBeg, L.PBeg, L.KEnd, L.PEnd, L.Speed, L.Note, L.Shift_KEY,'+
             '(L.KBeg*1000+ L.pBeg*100)* SH.Shift_Flag+ SH.Shift_Value AS  Sort_koord'+#13+
             'FROM  Limits L'+#13+
             'LEFT OUTER JOIN Shift SH'+#13+
             'ON  (L.Shift_KEY = Sh.Shift_ID)'+#13+
             'WHERE  L.Dir_key='+DIR_ID;
    SQL.Add(SQL_Str);
    if not fl_Shift then  SQL.Add('ORDER BY Kbeg, Pbeg') else SQL.Add('ORDER BY Sort_koord') ;
   Active:=true;
  end;     *)

  if fmMain.IBDS_Limits.FieldByName('BEG_KM').Value=null then
  begin
    if LimitList<>nil then
    begin
      LimitList.OwnsObjects:=False;
      FreeAndNil(LimitList);
    end;
   if StationList<>nil then
    begin
     StationList.OwnsObjects:=False;
     FreeAndNil(StationList);
    end;
   if SvetList<>nil then
    begin
     SvetList.OwnsObjects:=False;
     FreeAndNil(SvetList);
    end;
   if ObjList<>nil then
    begin
     ObjList.OwnsObjects:=False;
     FreeAndNil(ObjList);
    end;
    SetLength(uk,0);
    Beg_Coord:=1; End_Coord:=1;del_km:=1;
     if FBGBitmap<>nil then
    Del_Coord:=FBGBitmap.Width*10;
    Exit;
  end;

 //вычисление длины оси Х
 fmMain.IBDS_Limits.DisableControls;
 fmMain.IBDS_Limits.First;
 Beg_Coord:=(fmMain.IBDS_Limits.FieldByName('BEG_KM').Value-1)*1000+((fmMain.IBDS_Limits.FieldByName('BEG_PK').Value-1)*100);
 fmMain.IBDS_Limits.Last;
 End_Coord:=(fmMain.IBDS_Limits.FieldByName('END_KM').Value-1)*1000+(fmMain.IBDS_Limits.FieldByName('END_PK').Value*100);
 Del_Coord:=Abs(Beg_Coord-end_coord);
 fmMain.IBDS_Limits.EnableControls;

 // координата оси X,Y
 axis_x0:=ROUND(400*Zone);
 axis_xp:=Round(axis_x0+5+10+(400-axis_x0-5-10)/2);
 axis_y0:=50;

 if  Way=2 then  del_km:=1000-(Beg_Coord mod 1000)  // метров до целого км
  else           del_km:=1000+(End_Coord mod 1000);  // метров до целого км

 if (Beg_Coord mod 100)=0  then  del_pk:=0
                           else  del_pk:=(100-(Beg_Coord mod 100));

 px_1km:=Zoom*1000;     //пикселей в одном км  div_x
 px_1m:=Zoom*1;         //пикселей в 1 м  div_x_km

 px_1km4:=(axis_x0-400*0.1)/V_lim;

 px_1uk:=((400-axis_x0-5-10)/2)/150;

 if LimitList=nil then
  begin
   LimitList := TLimitList.Create;
  end
   else
  begin
    LimitList.OwnsObjects:=False;
    FreeAndNil(LimitList);
    LimitList := TLimitList.Create;
  end;
   fmMain.IBDS_Limits.DisableControls;
 fmMain.IBDS_Limits.last;
  fmMain.IBDS_Limits.First;
 tmp.X:=0; tmp.Y:=0;
 for i:=0 to  fmMain.IBDS_Limits.RecordCount-1 do
 begin
  Limit:=TLimit.Create;
  with Limit do
   begin
    P0:=tmp;
   if Way=2 then
      P1:= TPointF.Create(axis_y0+((fmMain.IBDS_Limits.FieldByName('BEG_KM').Value-1)*1000+((fmMain.IBDS_Limits.FieldByName('BEG_PK').Value-1)*100)-beg_coord)*px_1m,
                          axis_x0-fmMain.IBDS_Limits.FieldByName('Speed').Value*px_1km4) else
      P2:= TPointF.Create(axis_y0+(End_Coord-(fmMain.IBDS_Limits.FieldByName('BEG_KM').Value-1)*1000-((fmMain.IBDS_Limits.FieldByName('BEG_PK').Value-1)*100))*px_1m,
                          axis_x0-fmMain.IBDS_Limits.FieldByName('Speed').Value*px_1km4);
   if Way=2 then
      P2:= TPointF.Create(axis_y0+((fmMain.IBDS_Limits.FieldByName('END_KM').Value-1)*1000+(fmMain.IBDS_Limits.FieldByName('END_PK').Value*100)-beg_coord)*px_1m,
                          axis_x0-fmMain.IBDS_Limits.FieldByName('Speed').Value*px_1km4) else
      P1:= TPointF.Create(axis_y0+(End_Coord-(fmMain.IBDS_Limits.FieldByName('END_KM').Value-1)*1000-(fmMain.IBDS_Limits.FieldByName('END_PK').Value*100))*px_1m,
                          axis_x0-fmMain.IBDS_Limits.FieldByName('Speed').Value*px_1km4);
    Speed:=fmMain.IBDS_Limits.FieldByName('Speed').Value;
    if way=2 then tmp:=P2 else tmp:=P1;
   end;
   LimitList.Add(Limit);
   fmMain.IBDS_Limits.Next;
 end;
  fmMain.IBDS_Limits.EnableControls;
 (*

 with fmMain.qtTemp do
  begin
   close;
   Active:=false;
   SQL.Clear;
    SQL_Str:='SELECT S.St_ID,S.St_ID,S.Dir_KEY,S.Name,S.Koord,S.Beg_KM,S.Beg_PK,'+
             'S.End_KM,S.End_PK,S.Speed,S.Shift_KEY,'+
             '(S.Koord * SH.Shift_Flag+ SH.Shift_Value) AS  LIN_KOORD'+#13+
           //  '(S.Beg_KM * 1000+ SH.Shift_Flag+ SH.Shift_Value)/1000 AS  LIN_Beg_KM,'+
           //  '((S.Beg_KM*1000 +  S.Beg_pk* 100)*SH.Shift_Flag+ SH.Shift_Value)/1000 AS  LIN_BEG_KM,'+
           //  '(((S.Beg_KM*1000 +  S.Beg_pk* 100)*SH.Shift_Flag+ SH.Shift_Value) - (((S.Beg_KM*1000 +  S.Beg_pk* 100)*SH.Shift_Flag+ SH.Shift_Value)/1000)*1000)/100  AS LIN_BEG_PK,' +
           //  '((S.END_KM*1000 +  S.END_pk* 100)*SH.Shift_Flag+ SH.Shift_Value)/1000  AS LIN_END_KM,'+
           //  '(((S.END_KM*1000 +  S.END_pk* 100)*SH.Shift_Flag+ SH.Shift_Value) - (((S.END_KM*1000 +  S.END_pk* 100)*SH.Shift_Flag+ SH.Shift_Value)/1000)*1000)/100  AS LIN_END_PK'+#13+
             'FROM  Stations S'+#13+
             'LEFT OUTER JOIN Shift SH'+#13+
             'ON  (S.Shift_KEY = Sh.Shift_ID)'+#13+
             'WHERE  S.Dir_key='+DIR_ID;
     SQL.Add(SQL_Str);
   //if St_Sort='' then
    SQL.Add('ORDER BY Koord');// else SQL.Add(St_Sort);
   Active:=true;
  end;
             *)
 if fmMain.IBDS_Stations.FieldByName('Koord').Value<>null then
 begin
   //Заполнение списка станций для отрисовки
   if StationList=nil then StationList := TSationList.Create else
    begin
    StationList.OwnsObjects:=False;
    FreeAndNil(StationList);
    StationList := TSationList.Create;
   end;
  // gpImage.FromFile('Station.gif')
  // gpFontFml := TGPFontFamily.Create('Arial');
  // gpSFormat:=TGPStringFormat.Create;
  // gpFont := TGPFont.Create(gpFontFml,14,FontStyleRegular,UnitPixel);
   fmMain.IBDS_Stations.DisableControls;
   fmMain.IBDS_Stations.last;
   fmMain.IBDS_Stations.First;
//   gpImage:=TGPImage.Create(extractfilepath(application.ExeName)+'Station.gif');
   gpSize.Width:=32;
   gpSize.Height:=32;
//   FreeAndNil(gpImage);
  //масштаб
//  sclx:=station_size/gpSize.Width;
  out_height:=round(gpSize.Height);
  out_width:=Round(gpSize.Width);
  gpRect.Width:=out_width;
  gpRect.Height:=out_height;
   for i:=0 to fmMain.IBDS_Stations.RecordCount-1 do
   begin

    if Way=2 then
      CPtKoord:= TPointF.Create(axis_y0+(fmMain.IBDS_Stations.FieldByName('Koord').Value-beg_coord)*px_1m-gpRect.Width/2,
                                axis_x0-gpRect.Height)else
      CPtKoord:= TPointF.Create(axis_y0+(End_Coord-fmMain.IBDS_Stations.FieldByName('Koord').Value)*px_1m-gpRect.Width/2,
                                axis_x0-gpRect.Height);
    Station:=TStation.Create;
    with Station do
     begin
     // Rect.Width:=gpImage.GetWidth;
    //  Rect.Height:=gpImage.GetHeight;
      Rect.Position:=CPtKoord;
      Rect.Size:=gpRect.Size;
      Koord:=fmMain.IBDS_Stations.FieldByName('Koord').Value;
      Name:=fmMain.IBDS_Stations.FieldByName('FName').Value;
     end;
     StationList.Add(Station);
     fmMain.IBDS_Stations.Next;
   end;
   fmMain.IBDS_Stations.EnableControls;
 end else
 begin
   if StationList<>nil then
    begin
     StationList.OwnsObjects:=False;
     FreeAndNil(StationList);
    end;
 end;
         (*
  with fmMain.qtTemp do
  begin
   close;
   Active:=false;
   SQL.Clear;
   SQL.Add('SELECT *');
   SQL.Add('FROM Svet');
   SQL.Add('WHERE Dir_key='+DIR_ID);
   SQL.Add('ORDER BY Koord');
   Active:=true;
  end;
       *)
 if fmMain.IBDS_Light_Signals.FieldByName('Koord').Value<>null then
 begin
   //Заполнение списка светофров для отрисовки
   if SvetList=nil then SvetList := TSvetList.Create else
    begin
      SvetList.OwnsObjects:=False;
      FreeAndNil(SvetList);
      SvetList := TSvetList.Create;
    end;
    // gpImage.FromFile('Station.gif')
    // gpFontFml := TGPFontFamily.Create('Arial');
    // gpSFormat:=TGPStringFormat.Create;
    // gpFont := TGPFont.Create(gpFontFml,14,FontStyleRegular,UnitPixel);
   fmMain.IBDS_Light_Signals.DisableControls;
   fmMain.IBDS_Light_Signals.Last;
   fmMain.IBDS_Light_Signals.First;
   for i:=0 to fmMain.IBDS_Light_Signals.RecordCount-1 do
   begin
    if (fmMain.IBDS_Light_Signals.FieldByName('Koord').Value=null) or
       (fmMain.IBDS_Light_Signals.FieldByName('FName').Value=null) then break;

    gpSize.Width:=32;//gpImage.GetWidth;
    gpSize.Height:=32;//gpImage.GetHeight;
    if Way=2 then
      CPtKoord:= TPointF.Create(axis_y0+(fmMain.IBDS_Light_Signals.FieldByName('Koord').Value-beg_coord)*px_1m-gpSize.Width/2,axis_x0-gpSize.Height)else
      CPtKoord:= TPointF.Create(axis_y0+(End_Coord-fmMain.IBDS_Light_Signals.FieldByName('Koord').Value)*px_1m-gpSize.Width/2,axis_x0-gpSize.Height);
    Svet:=TSvet.Create;
    with Svet do
     begin
     // Rect.Width:=gpImage.GetWidth;
    //  Rect.Height:=gpImage.GetHeight;
      Rect.Position:=CPtKoord;
      Rect.Size:=gpSize;
      Koord:=fmMain.IBDS_Light_Signals.FieldByName('Koord').Value;
      Name:=fmMain.IBDS_Light_Signals.FieldByName('FName').Value;
     end;
     SvetList.Add(Svet);
     fmMain.IBDS_Light_Signals.Next;
   end;
 end else
 begin
  if SvetList<>nil then
  begin
    SvetList.OwnsObjects:=False;
    FreeAndNil(SvetList);
  end;
 end;
 fmMain.IBDS_Light_Signals.EnableControls;

 if fmMain.IBDS_Objects.FieldByName('Koord').Value<>null then
 begin
   //Заполнение списка объетов для отрисовки
   if ObjList=nil then ObjList := TObjList.Create else
    begin
      ObjList.OwnsObjects:=False;
      FreeAndNil(ObjList);
      ObjList := TObjList.Create;
    end;
    // gpImage.FromFile('Station.gif')
    // gpFontFml := TGPFontFamily.Create('Arial');
    // gpSFormat:=TGPStringFormat.Create;
    // gpFont := TGPFont.Create(gpFontFml,14,FontStyleRegular,UnitPixel);
   fmMain.IBDS_Objects.DisableControls;
   fmMain.IBDS_Objects.Last;
   fmMain.IBDS_Objects.First;
   for i:=0 to fmMain.IBDS_Objects.RecordCount-1 do
   begin
    gpSize.Width:=32;//gpImage.GetWidth;
    gpSize.Height:=32;//gpImage.GetHeight;
    if (fmMain.IBDS_Objects.FieldByName('Koord').value=null) or
       (fmMain.IBDS_Objects.FieldByName('Obj_key').value=null) then break;

    if Way=2 then
      CPtKoord:= TPointF.Create(axis_y0+(fmMain.IBDS_Objects.FieldByName('Koord').Value-beg_coord)*px_1m-gpSize.Width/2,axis_x0+10+1+t_Axis)else
      CPtKoord:= TPointF.Create(axis_y0+(End_Coord-fmMain.IBDS_Objects.FieldByName('Koord').Value)*px_1m-gpSize.Width/2,axis_x0+10+1+t_Axis);
    Obj:=TObj.Create;
    with Obj do
     begin
     // Rect.Width:=gpImage.GetWidth;
    //  Rect.Height:=gpImage.GetHeight;
      Rect.Position:=CPtKoord;
      Rect.Size:=gpSize;
      Koord:=fmMain.IBDS_Objects.FieldByName('Koord').Value;
      FType:=fmMain.IBDS_Objects.FieldByName('Obj_key').Value;
     end;
     ObjList.Add(Obj);
     fmMain.IBDS_Objects.Next;
   end;
 end else
 begin
  if ObjList<>nil then
  begin
    ObjList.OwnsObjects:=False;
    FreeAndNil(ObjList);
  end;
 end;
 fmMain.IBDS_Objects.EnableControls;

 //***профиль***
  with fmMain.IBDS_prof do
  begin
  { close;
   Active:=false;
   SQL.Clear;
   SQL.Add('SELECT *');
   SQL.Add('FROM Prof');
   SQL.Add('WHERE Dir_key='+DIR_ID);
   if way=2 then SQL.Add('ORDER BY Number') else SQL.Add('ORDER BY Number DESC');
   Active:=true;     }
   if FieldByName('FValue').Value<>null then
    begin
     DisableControls;
     last;
     first;
     SetLength(uk,RecordCount);
     //First;
     if way=2 then
      for i:=0 to RecordCount-1 do
      begin
        Uk[i].P.X:=axis_y0+((i+0)*100)*px_1m;
        Uk[i].P.Y:=axis_xp-FieldByName('FValue').Value*px_1uk;
        Uk[i].Value:=FieldByName('FValue').Value/10;
        Next;
      end;
      if way=1 then
      for i:=RecordCount-1 downto 0 do
      begin
        Uk[i].P.X:=axis_y0+((i+0)*100)*px_1m;
        Uk[i].P.Y:=axis_xp-FieldByName('FValue').Value*px_1uk;
        Uk[i].Value:=FieldByName('FValue').Value/10;
        Next;
      end;
    end else SetLength(uk,0);
    EnableControls;
  end;
end;

procedure TfmGraph.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
  fmMain.tbGraph.Down:=False;
end;

procedure TfmGraph.FormDestroy(Sender: TObject);
begin
 fmGraph:=nil;
 freeandnil(FBGBitmap);
end;

{ TSationList }

function TSationList.GetItems(Index: Integer): TStation;
begin
  Result := TStation(inherited GetItem(Index));
end;


procedure TSationList.SetItems(Index: Integer; const Value: TStation);
begin
  inherited SetItem(Index, Value);
end;

{ TStation }

procedure TStation.Paint;
var
  koord_txt:string;
   Rect_sm  : TIGPRectF;
  gpPath:TIGPGraphicsPath;
  cl_temp_text,cl_temp:TColor;
begin
  if not Select then   cl_temp:=cl_Station
                else   cl_temp:=clLime;
  Rect_sm:=Rect;
  Rect_sm.X:=Rect_sm.X-scroll+8;
 // gpPen.SetColor(ARGBfromColor(cl_temp));
 // gpBrush.SetColor(ARGBfromColor(cl_temp));
  Rect_sm.Width := 16; Rect_sm.Height := 16;

  gpDrawer.DrawEllipseF(TIGPPen.Create(MakeColor(255,cl_temp),w_station),
                       Rect_sm);
  gpDrawer.FillPieF(TIGPSolidBrush.Create( MakeColor( 255, cl_temp )),
                    Rect_sm,
                    90,
                    180);
  gpDrawer.DrawLineF(TIGPPen.Create(MakeColor(255,cl_temp),w_station),
                     Rect_sm.X+8,
                     Rect_sm.Y,
                     Rect_sm.x+8,
                     axis_x0);

  if not Select then   cl_temp_text:=cl_StationText
                else   cl_temp_text:=clLime;
  //gpBrush.SetColor(ARGBfromColor(cl_temp_text));
  gpDrawer.ResetTransform;
  gpDrawer.TranslateTransform(Rect.x+rect.Width/2-scroll,Rect.y-5);
  gpDrawer.RotateTransform(-90) ;
  if Select then
  begin
    if way=2 then
      koord_txt:='['+IntToStr(Round((gpMouse.X+(StationList.Items[StationList.Ind].Rect.Width/2-del_x)-axis_y0+beg_coord*px_1m)/px_1m))+' м]' else
      koord_txt:='['+IntToStr(Round((-1*gpMouse.X-(StationList.Items[StationList.Ind].Rect.Width/2-del_x)+axis_y0+end_coord*px_1m)/px_1m))+' м]';
      end else  koord_txt:='';

    gpSFormat:=TIGPStringFormat.Create;
    gpSFormat.SetAlignment(StringAlignmentNear);

    gpDrawer.DrawStringF(Name,
                         TIGPFont.Create(TIGPFontFamily.Create('Arial'),t_station,[],UnitPixel),
                         TPointF.Create(0,-7) ,
                         gpSFormat,
                         TIGPSolidBrush.Create( MakeColor( 255, cl_temp_text ))); //название
 // gpDrawer.DrawStringF(Name,-1, gpFont, GPPointFMake(0,-7) ,gpSFormat, gpBrush); //название

  gpDrawer.ResetTransform;
 // gpDrawer.TranslateTransform(gpMouse.X-scroll,gpMouse.Y);
 // gpSFormat.SetAlignment(StringAlignmentNear);
 if Select then
 begin
   gpSFormat:=TIGPStringFormat.Create;
   gpSFormat.SetAlignment(StringAlignmentNear);
   gpDrawer.TranslateTransform(gpMouse.X-scroll,gpMouse.Y);
   gpDrawer.DrawStringF(koord_txt,
                        TIGPFont.Create(TIGPFontFamily.Create('Arial'),t_station,[],UnitPixel),
                        TPointF.Create(15,-5) ,
                        gpSFormat,
                        TIGPSolidBrush.Create( MakeColor( 255, cl_temp_text ))); //название
  gpDrawer.ResetTransform;
  end;
  //gpDrawer.Free;
 // gpFont.Free;
end;

procedure TfmGraph.Calc;
begin
  Scroll:=ScrollBox1.HorzScrollBar.Position-3;
  StatusBar1.Panels[6].Text:=inttostr(Scroll);
  PaintBox1.Width:=Round(axis_y0+Del_Coord*Zoom+20);

{  //длина оси X,Y
  axis_x_len:=Width-2-axis_y0;
  axis_y_len:=axis_x0-Height*0.1;
                                 }

  if  Way=2 then
   del_km:=1000-(Beg_Coord mod 1000)  // метров до целого км
  else
   del_km:=(End_Coord mod 1000);  // метров до целого км

  if (Beg_Coord mod 100)=0
  then  del_pk:=0
  else  del_pk:=(100-(Beg_Coord mod 100));

  del_pk_px:=del_pk*px_1m;
{
//  if FEvenWay then
   del_500_m:=500-(PLinCoord^ mod 1000);  // метров до 500
//  else
//    del_500_m:=(PCoord^ mod 1000);  // метров до 500

  div_y:=axis_y_len/(FTicksY.Count+1);
  div_y_v:=div_y/10;    }
end;

procedure TfmGraph.DrawAxis;
var
  i,j:Integer;
  ipen: IGPPen;
begin
 // gpPen.SetColorProp(MakeColor(255,cl_Axis));
//  gpPen.SetWidthProp(1);
  //ось Х
  gpDrawer.DrawLineF(TIGPPen.Create(MakeColor(255,cl_Axis), w_Axis),
                     axis_y0-scroll,
                     axis_x0,
                     PaintBox1.Width-2-20-scroll,
                     axis_x0);
  // профиль
 { gpDrawer.DrawLineF(TIGPPen.Create(MakeColor(255,cl_Axis), 1),
                    axis_y0-scroll,
                    axis_xp,
                    PaintBox1.Width-2-20-scroll,
                    axis_xp);   }

  //Y
 // gpDrawer.DrawLine(gpPen,axis_y0,axis_x0,axis_y0,round(PaintBox1.Height*0.1));

{  //визир
  gpPen.SetColor(ARGBfromColor(FSight.Color));
  gpPen.SetDashStyle(FSight.Style);
  gpPen.SetWidth(FSight.Width);

  gpDrawer.DrawLine(gpPen,axis_y0+div_x_km*FSight.Position,axis_UK0,
                          axis_y0+div_x_km*FSight.Position, axis_x0-PVoE^[PLinCoord^ div 100-PInd_sm^]*div_y_v+1);

//  gpDrawer.DrawLine(gpPen,axis_y0+div_x_km*FSight.Position-(PCarCount^*FCarLengthValue*FCarLengthFactor+FLocoLengthValue)*div_x_km,axis_UK0,
//                          axis_y0+div_x_km*FSight.Position-(PCarCount^*FCarLengthValue*FCarLengthFactor+FLocoLengthValue)*div_x_km, axis_x0-PVoE^[PLinCoord^ div 100-ceil((PCarCount^*FCarLengthValue*FCarLengthFactor+FLocoLengthValue)/100)-PInd_sm^]*div_y_v+1);

                                                                                     }
 //  gpSFormat.SetAlignment(StringAlignmentCenter);
//  gpFont := TGPFont.Create(gpFontFml,15,FontStyleRegular,UnitPixel);

 // gpPen.SetWidthProp(1);
 // gpPen.SetDashStyleProp(DashStyleSolid);
 // gpPen.SetColor(ColorRefToARGB(cl_Axis));
 // gpBrush.SetColor(ColorRefToARGB(cl_AxisText));
  for i:=0 to (Del_Coord div 1000) do
  begin
   //Км столбы
   if px_1m*del_km+axis_y0+i*px_1km>PaintBox1.Width-2-20 then break;
  // CPtKoord.:= GPPointFMake(px_1m*del_km+axis_y0+i*px_1km-scroll, axis_x0+10+1);
   CPtKoord.X:= px_1m*del_km+axis_y0+i*px_1km-scroll;
   CPtKoord.Y:= axis_x0+10+1;
   gpDrawer.DrawLineF(TIGPPen.Create(MakeColor(255,cl_Axis), w_Axis),
                      px_1m*del_km+axis_y0+i*px_1km-scroll,axis_x0,
                      px_1m*del_km+axis_y0+i*px_1km-scroll,axis_x0+10);
   gpSFormat:=TIGPStringFormat.Create;
   gpSFormat.SetAlignment(StringAlignmentCenter)  ;
 if  Way=2 then
   begin
    gpDrawer.DrawStringF(format('%d',[(Beg_Coord+del_km+i*1000)div 1000]),
    TIGPFont.Create(TIGPFontFamily.Create('Arial'),t_Axis,[],UnitPixel),
                    CPtKoord,
                    gpSFormat,
                    TIGPSolidBrush.Create(MakeColor( 255, cl_AxisText )));
   end
   else
   begin
    gpDrawer.DrawStringF(format('%d',[(End_Coord-del_km-i*1000)div 1000]),
                         TIGPFont.Create(TIGPFontFamily.Create('Arial'),t_Axis,[],UnitPixel),
                         CPtKoord,
                         gpSFormat,
                         TIGPSolidBrush.Create( MakeColor( 255, cl_AxisText )));
   end;

   //пикеты
   for j:=1 to 9 do
   begin
 //   gpPen.SetWidth(1);
 //   gpPen.SetDashStyle(DashStyleSolid);
 //   gpPen.SetWidth(1);
    gpDrawer.DrawLineF(TIGPPen.Create(MakeColor(255,cl_Axis), w_Axis),
                      (px_1m*del_km+axis_y0+i*px_1km)+(px_1km/(10))*j-scroll,axis_x0,
                      (px_1m*del_km+axis_y0+i*px_1km)+(px_1km/(10))*j-scroll,axis_x0+5);
   end;

   if i=0 then for j:=1 to 9 do
   begin
    if ((px_1m*del_km+axis_y0+i*px_1km)-(px_1km/(10))*j)<axis_y0 then Break;
    gpDrawer.DrawLineF(TIGPPen.Create(MakeColor(255,cl_Axis), w_Axis),
                       (px_1m*del_km+axis_y0+i*px_1km)-(px_1km/(10))*j-scroll,axis_x0,
                       (px_1m*del_km+axis_y0+i*px_1km)-(px_1km/(10))*j-scroll,axis_x0+5);
   end;
  end;
end;

procedure TfmGraph.Init;
begin
  //FBGBitmap.Width:=PaintBox1.Width;
 // FBGBitmap.Height:=PaintBox1.Height;
  FBGBitmap.Width:=Width;
  FBGBitmap.Height:=Height;
  gpDrawer := TIGPGraphics.Create(FBGBitmap.Canvas.Handle);
 // gpDrawer := TGPGraphics.Create(PaintBox1.Canvas.Handle);
  gpDrawer.SetCompositingQuality(CompositingQualityHighSpeed);
  gpDrawer.SetSmoothingMode(SmoothingModeAntiAlias);
 // gpFontFml := TIGPFontFamily.Create('Arial');
 // gpFont := TIGPFont.Create(gpFontFml,14,[],UnitPixel);
 // gpSFormat:=TIGPStringFormat.Create;
  //gpPen:=TIGPPen.Create(ColorRefToARGB(clWhite),1);
 // gpBrush:=TIGPSolidBrush.Create(ColorRefToARGB(clWhite));
  //gpImage:=TGPImage.Create('');
  gpDrawer.Clear(MakeColor(255,cl_BackGround));
//gpDrawer.Clear(aclred);
end;

procedure TfmGraph.PaintBox1Paint(Sender: TObject);
begin
  Calc;
  Init;
  DrawAxis;
  DrawObjects;
  bitblt(PaintBox1.Canvas.Handle,{Scroll}ScrollBox1.HorzScrollBar.Position-3,0, Width, Height, FBGBitmap.Canvas.Handle , 0,0, srccopy);
 // gpFont.Free;
 // gpFontFml.Free;
 // gpSFormat.Free;
  //gpPen.Free;
  //gpBrush.Free;
  //gpImage.Free;
   //gpDrawer.free;
  // gpDrawer.
end;

procedure TfmGraph.FormCreate(Sender: TObject);
begin
  PaintBox1.Parent.DoubleBuffered:=true;
  PaintBox1.ControlStyle:=PaintBox1.ControlStyle+[csOpaque];
  ScrollBox1.Parent.DoubleBuffered:=true;
  DoubleBuffered:=true;
  FBGBitmap:=TBitmap.Create;
  FBGBitmap.HandleType:=bmDIB;
end;

procedure TfmGraph.DrawObjects;
var
  i:word;
  gpRect,rec1,rec2:TIGPRectF;
  gpSize:TIGPSizeF;
  len:Integer;
  tsize:TIGPRectF;
  Ttext:string;
  out_width, out_height: Integer;
  sclx:extended;
  ZN: SmallInt;
  i_beg:Integer;
  SQL_Str:string;
begin
 if Way=2 then   zn:=1 else zn:=-1;
 //ограничения
   if LimitList<>nil then
   for i:=0 to LimitList.Count-1 do
   begin
   // if (LimitList.Items[i].bg.x>ScrollBox1.HorzScrollBar.Position) and
    //if (LimitList.Items[i].P1.X<Scroll) then
    LimitList.Items[i].Paint;
   end;
  //станция
  if StationList<>nil then
   for i:=0 to StationList.Count-1 do
   begin
    if (StationList.Items[i].Rect.X>Scroll) and
       (StationList.Items[i].Rect.X<Scroll+Width-StationList.Items[i].Rect.Width) then
    StationList.items[i].Paint;
   end;

    //светофоры
      if SvetList<>nil then
      for i:=0 to SvetList.Count-1 do
      begin
       if (SvetList.Items[i].Rect.X>Scroll) and
          (SvetList.Items[i].Rect.X<Scroll+Width-SvetList.Items[i].Rect.Width) then
       SvetList.items[i].Paint;
      end;




   if Uk<>nil then
   begin
   // gpPen.SetColor(ColorRefToARGB(clYellow));
   // gpPen.SetWidth(1);
  //  gpBrush.SetColor(ColorRefToARGB(cl_Uklon));
    for i:=0 to Length(uk)-1 do
    begin
     //if i>0 then
    // gpDrawer.DrawLine(gpPen,uk[i].X-scroll, uk[i].Y,uk[i].X-scroll+100*px_1m, uk[i].Y);
    if (uk[i].P.Y-axis_xp)>=0 then
     gpDrawer.FillRectangleF(TIGPSolidBrush.Create( MakeColor( 255, cl_Uklon )),
                             uk[i].P.X-scroll,
                             axis_xp,
                             100*px_1m,
                             abs(uk[i].P.Y-axis_xp)) else
     gpDrawer.FillRectangleF(TIGPSolidBrush.Create( MakeColor( 255, cl_Uklon )),
                             uk[i].P.X-scroll,
                             axis_xp-abs(uk[i].P.Y-axis_xp),
                             100*px_1m,
                             abs(uk[i].P.Y-axis_xp)) ;

    end;
   end;
  //gpPen.SetColor(ColorRefToARGB(cl_Axis));
 // gpPen.SetWidth(1);
  gpDrawer.DrawLineF(TIGPPen.Create(MakeColor(255,cl_Axis), 1),
                     axis_y0-scroll,
                     axis_xp,
                     PaintBox1.Width-2-20-scroll,
                     axis_xp);



      //объекты
      if ObjList<>nil then
      for i:=0 to ObjList.Count-1 do
      begin
       if (ObjList.Items[i].Rect.X>Scroll) and
          (ObjList.Items[i].Rect.X<Scroll+Width-ObjList.Items[i].Rect.Width) then
       ObjList.items[i].Paint;
      end;
{ TMyStreamAdapter }

{function TMyStreamAdapter.Stat(out statstg: TStatStg;
  grfStatFlag: Integer): HResult;
begin
  Result := inherited Stat(statstg, grfStatFlag);
  statstg.pwcsName := nil;
end;       }
end;

procedure TfmGraph.FormActivate(Sender: TObject);
begin
//  Calc;
//  FillData4Graph;
end;

procedure TfmGraph.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i: Integer;
  km:Integer;
  _Lim_ID, _Dir_KEY, _KBeg, _PBeg, _KEnd, _PEnd, _Speed, _Note, _Shift_KEY: string;
  SQL_Str:string;
begin
 if StationList<>nil then
 if StationList.Active then
 begin
  fmMain.IBDS_Stations.Edit;
  if way=2 then
     fmMain.IBDS_Stations.FieldByName('Koord').Value:=Round((gpMouse.X+(StationList.Items[StationList.Ind].Rect.Width/2-del_x)-axis_y0+beg_coord*px_1m)/px_1m) else
    fmMain.IBDS_Stations.FieldByName('Koord').Value:=Round((-1*gpMouse.X-(StationList.Items[StationList.Ind].Rect.Width/2-del_x)+axis_y0+end_coord*px_1m)/px_1m);
   fmMain.IBDS_Stations.Edit;
  StationList.Items[StationList.Ind].Select:=False;
  //FillData4Graph;
  PaintBox1.Repaint;
  //fmMain.TableUpdate;
  StationList.Active:=False;
 end;

 if SvetList<>nil then
 if SvetList.Active then
 begin
  fmMain.IBDS_Light_Signals.Edit;
  if way=2 then
    fmMain.IBDS_Light_Signals.FieldByName('Koord').Value:=Round((gpMouse.X+(SvetList.Items[SvetList.Ind].Rect.Width/2-del_x)-axis_y0+beg_coord*px_1m)/px_1m) else
    fmMain.IBDS_Light_Signals.FieldByName('Koord').Value:=Round((-1*gpMouse.X-(SvetList.Items[SvetList.Ind].Rect.Width/2-del_x)+axis_y0+end_coord*px_1m)/px_1m);
  fmMain.IBDS_Light_Signals.Post;
  SvetList.Items[SvetList.Ind].Select:=False;
  PaintBox1.Repaint;
 // fmMain.TableUpdate;
  SvetList.Active:=False;
 end;

 if LimitList<>nil then
 if LimitList.Active_Hor then
 begin

    fmMain.IBDS_Limits.Edit;
    if (Round((-gpMouse.Y+axis_x0+del_x)/px_1km4) mod 5)=0 then
      fmMain.IBDS_Limits.FieldByName('Speed').Value:=Round((-gpMouse.Y+axis_x0+del_x)/px_1km4) else

    if (Round((-gpMouse.Y+axis_x0+del_x)/px_1km4) mod 10)<5 then
     fmMain.IBDS_Limits.FieldByName('Speed').Value:=Round((-gpMouse.Y+axis_x0+del_x)/px_1km4)-Round((-gpMouse.Y+axis_x0+del_x)/px_1km4) mod 10 else
     fmMain.IBDS_Limits.FieldByName('Speed').Value:=5+Round((-gpMouse.Y+axis_x0+del_x)/px_1km4)-Round((-gpMouse.Y+axis_x0+del_x)/px_1km4) mod 10;

    fmMain.IBDS_Limits.Post;
    LimitList.Items[LimitList.Ind].Select:=False;
   Sum_Limits;
 {  with fmMain.IBDS_Limits do
    begin
     close;
     Active:=false;
     SQL.Clear;
     SQL_Str:='SELECT L.Lim_ID, L.Dir_KEY, L.KBeg, L.PBeg, L.KEnd, L.PEnd, L.Speed, L.Note, L.Shift_KEY,'+
               '(L.KBeg*1000+ L.pBeg*100)* SH.Shift_Flag+ SH.Shift_Value AS  Sort_koord'+#13+
               'FROM  Limits L'+#13+
               'LEFT OUTER JOIN Shift SH'+#13+
               'ON  (L.Shift_KEY = Sh.Shift_ID)'+#13+
               'WHERE  L.Dir_key='+DIR_ID;
      SQL.Add(SQL_Str);
      if not fl_Shift then  SQL.Add('ORDER BY Kbeg, Pbeg') else SQL.Add('ORDER BY Sort_koord') ;
     Active:=true;
    end; }
  fmMain.IBDS_Limits.RecNo:=LimitList.Ind+1;
  FillData4Graph;
  PaintBox1.Repaint;
   LimitList.Active_Hor:=False;
 end;

 if LimitList<>nil then
 if LimitList.Active_Div then
 begin
    if Button=mbRight then
  begin
   _Lim_ID:= fmMain.IBDS_Limits.FieldByName('ID').Value;
   _Dir_KEY:=fmMain.IBDS_Limits.FieldValues['Dir_KEY'] ;
   _Kbeg:=fmMain.IBDS_Limits.FieldValues['BEG_KM'] ;
   _PBeg:=fmMain.IBDS_Limits.FieldValues['BEG_PK'];
   _PEnd:=fmMain.IBDS_Limits.FieldValues['END_PK'] ;
   _KEnd:=fmMain.IBDS_Limits.FieldValues['END_KM'] ;
   _Speed:=fmMain.IBDS_Limits.FieldValues['Speed'] ;
    if fmMain.IBDS_Limits.FieldValues['Note']=null then _Note:='NULL' else
   _Note:=fmMain.IBDS_Limits.FieldValues['Note'] ;
    if fmMain.IBDS_Limits.FieldValues['Shift_KEY']=null then _Shift_KEY:='NULL' else
   _Shift_KEY:=fmMain.IBDS_Limits.FieldValues['Shift_KEY'] ;

   with fmMain.IBSQL do
   begin
     Close;
     SQL.Clear;
     SQL.Add('INSERT INTO Limits');
     SQL.Add('(Dir_KEY, BEG_KM, BEG_PK, END_KM, END_PK, Speed, Note, Shift_KEY)');
     SQL.Add('VALUES ('+_Dir_KEY+','+_Kbeg+','+_PBeg+','+_KEnd+','+_PEnd+','+_Speed+','+_Note+','+_Shift_KEY+')');
     fmMain.IBTR_WRITE.StartTransaction;
     ExecQuery;
     fmMain.IBTR_WRITE.Commit;
   end;
  end;
   DS_Refresh(fmMain.IBDS_Limits);
{ with fmMain.qtLimits do
  begin
   close;
   Active:=false;
   SQL.Clear;
   SQL_Str:='SELECT L.Lim_ID, L.Dir_KEY, L.KBeg, L.PBeg, L.KEnd, L.PEnd, L.Speed, L.Note, L.Shift_KEY,'+
             '(L.KBeg*1000+ L.pBeg*100)* SH.Shift_Flag+ SH.Shift_Value AS  Sort_koord'+#13+
             'FROM  Limits L'+#13+
             'LEFT OUTER JOIN Shift SH'+#13+
             'ON  (L.Shift_KEY = Sh.Shift_ID)'+#13+
             'WHERE  L.Dir_key='+DIR_ID;
    SQL.Add(SQL_Str);
    if not fl_Shift then  SQL.Add('ORDER BY Kbeg, Pbeg') else SQL.Add('ORDER BY Sort_koord') ;
   Active:=true;
  end;
         }
  fmMain.IBDS_Limits.RecNo:=LimitList.Ind+1;
  fmMain.IBDS_Limits.Edit;
  if Way=2 then
  begin
  km:=Round((gpMouse.X-axis_y0-del_x+beg_coord*px_1m)/px_1m);
   If ((km mod 1000) div 100 )=0 then
  begin
   fmMain.IBDS_Limits.FieldByName('END_PK').Value:=10;
   fmMain.IBDS_Limits.FieldByName('END_KM').Value:=((km+1000)div 1000)-1;
  end else
  begin
   fmMain.IBDS_Limits.FieldByName('END_PK').Value:=(km mod 1000) div 100;
   fmMain.IBDS_Limits.FieldByName('END_KM').Value:=(km+1000)div 1000;
  end;
  end else
  begin
   km:=Round((-gpMouse.X+axis_y0-del_x+end_coord*px_1m)/px_1m);
    If ((km mod 1000) div 100 )=0 then
    begin
     fmMain.IBDS_Limits.FieldByName('END_PK').Value:=10;
     fmMain.IBDS_Limits.FieldByName('END_KM').Value:=((km+1000)div 1000)-1;
    end else
    begin
     fmMain.IBDS_Limits.FieldByName('END_PK').Value:=(km mod 1000) div 100;
     fmMain.IBDS_Limits.FieldByName('END_KM').Value:=(km+1000)div 1000;
    end;
  end;
  fmMain.IBDS_Limits.Post;
  fmMain.IBDS_Limits.Next;
  fmMain.IBDS_Limits.Edit;
  fmMain.IBDS_Limits.FieldByName('BEG_KM').Value:=(km+1000)div 1000;
  fmMain.IBDS_Limits.FieldByName('BEG_PK').Value:=(km mod 1000) div 100 +1;
  fmMain.IBDS_Limits.Post;

{ with fmMain.qtLimits do
  begin
   close;
   Active:=false;
   SQL.Clear;
   SQL_Str:='SELECT L.Lim_ID, L.Dir_KEY, L.KBeg, L.PBeg, L.KEnd, L.PEnd, L.Speed, L.Note, L.Shift_KEY,'+
             '(L.KBeg*1000+ L.pBeg*100)* SH.Shift_Flag+ SH.Shift_Value AS  Sort_koord'+#13+
             'FROM  Limits L'+#13+
             'LEFT OUTER JOIN Shift SH'+#13+
             'ON  (L.Shift_KEY = Sh.Shift_ID)'+#13+
             'WHERE  L.Dir_key='+DIR_ID;
    SQL.Add(SQL_Str);
    if not fl_Shift then  SQL.Add('ORDER BY Kbeg, Pbeg') else SQL.Add('ORDER BY Sort_koord') ;
   Active:=true;
  end;     }
  DS_Refresh(fmMain.IBDS_Limits);
  fmMain.IBDS_Limits.RecNo:=LimitList.Ind+1;
  FillData4Graph;
  PaintBox1.Repaint;
  LimitList.Active_Div:=False;
 end;
 //изменение границ ограничений
 if LimitList<>nil then
 if LimitList.Active_Ver then
 begin
  if Way=2 then
  begin
   fmMain.IBDS_Limits.Edit;
   km:=Round((gpMouse.X-axis_y0-del_x+beg_coord*px_1m)/px_1m);

   fmMain.IBDS_Limits.FieldByName('BEG_KM').Value:=(km+1000)div 1000;
   fmMain.IBDS_Limits.FieldByName('BEG_PK').Value:=(km mod 1000) div 100 +1;

    fmMain.IBDS_Limits.Post;
    fmMain.IBDS_Limits.Prior;
    fmMain.IBDS_Limits.Edit;
    If ((km mod 1000) div 100 )=0 then
    begin
     fmMain.IBDS_Limits.FieldByName('END_PK').Value:=10;
     fmMain.IBDS_Limits.FieldByName('END_KM').Value:=((km+1000)div 1000)-1;
    end else
    begin
     fmMain.IBDS_Limits.FieldByName('END_PK').Value:=(km mod 1000) div 100;
     fmMain.IBDS_Limits.FieldByName('END_KM').Value:=(km+1000)div 1000;
    end;
    fmMain.IBDS_Limits.Post;
  end else
  begin
   fmMain.IBDS_Limits.Edit;
   km:=Round((-gpMouse.X+axis_y0-del_x+end_coord*px_1m)/px_1m);
   fmMain.IBDS_Limits.FieldByName('BEG_KM').Value:=(km+1000)div 1000;
   fmMain.IBDS_Limits.FieldByName('BEG_PK').Value:=(km mod 1000) div 100 +1;

    fmMain.IBDS_Limits.Post;
    fmMain.IBDS_Limits.Prior;
    fmMain.IBDS_Limits.Edit;
    If ((km mod 1000) div 100 )=0 then
    begin
     fmMain.IBDS_Limits.FieldByName('END_PK').Value:=10;
     fmMain.IBDS_Limits.FieldByName('END_KM').Value:=((km+1000)div 1000)-1;
    end else
    begin
     fmMain.IBDS_Limits.FieldByName('END_PK').Value:=(km mod 1000) div 100;
     fmMain.IBDS_Limits.FieldByName('END_KM').Value:=(km+1000)div 1000;
    end;
    fmMain.IBDS_Limits.Post;
  end;

  LimitList.Items[LimitList.Ind].Select:=False;
{ with fmMain.qtLimits do
  begin
   close;
   Active:=false;
   SQL.Clear;
   SQL_Str:='SELECT L.Lim_ID, L.Dir_KEY, L.KBeg, L.PBeg, L.KEnd, L.PEnd, L.Speed, L.Note, L.Shift_KEY,'+
             '(L.KBeg*1000+ L.pBeg*100)* SH.Shift_Flag+ SH.Shift_Value AS  Sort_koord'+#13+
             'FROM  Limits L'+#13+
             'LEFT OUTER JOIN Shift SH'+#13+
             'ON  (L.Shift_KEY = Sh.Shift_ID)'+#13+
             'WHERE  L.Dir_key='+DIR_ID;
    SQL.Add(SQL_Str);
    if not fl_Shift then  SQL.Add('ORDER BY Kbeg, Pbeg') else SQL.Add('ORDER BY Sort_koord') ;
   Active:=true;
  end;    }
  fmMain.IBDS_Limits.RecNo:=LimitList.Ind+1;
  FillData4Graph;
  PaintBox1.Repaint;
  LimitList.Active_Ver:=False;
 end;
end;

procedure TfmGraph.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  km1,pk1:Integer;
  MousePos: TPoint;
begin
  gpMouse.X:=X;
  gpMouse.Y:=y;
  StatusBar1.Panels.Items[0].Text:='X: '+floatToStr( gpMouse.X)+'; '+'Y: '+floatToStr( gpMouse.Y);
  if Way=2 then
    km:=Trunc((gpMouse.X-axis_y0+beg_coord*px_1m)/px_1m) else
    km:=Trunc((-1*gpMouse.X+axis_y0+end_coord*px_1m)/px_1m);
  StatusBar1.Panels.Items[1].Text:=FloatToStrf(km,ffFixed,8,0)+' м';
  StatusBar1.Panels.Items[2].Text:= IntToStr((km+1000)div 1000)+' км '+floattostr((km mod 1000) div 100 +1)+' пк';
    GetCursorPos(MousePos);   {получение координат мыши}
  StatusBar1.Panels.Items[5].Text:= IntToStr(MousePos.x);

  if ((km-Beg_Coord)div 100>=0) and ((End_Coord-km)div 100<length(uk)) and (Uk<>nil) and (((km-Beg_Coord>0) and (way=2)) or ((End_Coord-km>0)and (way<>2))) then
  begin
   if Way=2 then
    StatusBar1.Panels.Items[3].Text:= FloatToStr(Uk[(km-Beg_Coord)div 100].Value)+' ‰'
   else
    StatusBar1.Panels.Items[3].Text:= FloatToStr(Uk[(End_Coord-km)div 100].Value)+' ‰';
  end;

   if StationList<>nil then
   if StationList.Active then
   begin
        StationList.Items[StationList.Ind].Rect.X:=gpMouse.X-del_x;
     //   StationList.Items[StationList.Ind].Rect.X:=StationList.Items[StationList.Ind].Rect.Position.X;
        PaintBox1.Repaint;
   end;
   if SvetList<>nil then 
   if SvetList.Active then
   begin
        SvetList.Items[SvetList.Ind].Rect.X:=gpMouse.X-del_x;
       // SvetList.Items[SvetList.Ind].Rect.X:=SvetList.Items[SvetList.Ind].Rect.Position.X;
        PaintBox1.Repaint;
   end;
   if LimitList<>nil then
   if LimitList.Active_Hor then
   begin
        LimitList.Items[LimitList.Ind].P1.Y:=gpMouse.Y-del_x;
        LimitList.Items[LimitList.Ind].P2.Y:= LimitList.Items[LimitList.Ind].P1.Y ;
        if LimitList.Count>LimitList.Ind+1 then
        LimitList.Items[LimitList.Ind+1].P0.Y:= LimitList.Items[LimitList.Ind].P1.Y ;
        PaintBox1.Repaint;
   end;
   if LimitList<>nil then
   if LimitList.Active_Ver then
   begin
        if Way=2 then
        begin
          LimitList.Items[LimitList.Ind].P1.X:=gpMouse.X-del_x;
          LimitList.Items[LimitList.Ind].P0.X:= LimitList.Items[LimitList.Ind].P1.X ;
          LimitList.Items[LimitList.Ind-1].P2.X:= LimitList.Items[LimitList.Ind].P1.X;
        end else
        begin
          LimitList.Items[LimitList.Ind].P2.X:=gpMouse.X-del_x;
          LimitList.Items[LimitList.Ind].P0.X:= LimitList.Items[LimitList.Ind].P2.X ;
          LimitList.Items[LimitList.Ind-1].P1.X:= LimitList.Items[LimitList.Ind].P2.X;
        end;
        PaintBox1.Repaint;
   end;
end;

procedure TfmGraph.PaintBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var i:Integer;
begin
  {курсор находится на объекте или нет}
  if  StationList<>nil then
  for i:=0 to StationList.Count-1 do
  if (gpMouse.X>=StationList.Items[i].Rect.X) and
     (gpMouse.X<=StationList.Items[i].Rect.X+StationList.Items[i].Rect.Width) and
     (gpMouse.Y>=StationList.Items[i].Rect.Y) and
     (gpMouse.Y<=StationList.Items[i].Rect.Y+StationList.Items[i].Rect.Height) then
  begin
     StationList.Active:=True;
     StatusBar1.Panels.Items[0].Text:=IntToStr(i+1);
     fmMain.IBDS_Stations.RecNo:=i+1;
     StationList.Ind:=i;
     StationList.Items[StationList.Ind].Select:=True;
     del_x:=gpMouse.X-StationList.Items[StationList.Ind].Rect.X;
     PaintBox1.Repaint;
     Exit;
  end
  else
  begin
   StationList.Active:=False;
  end;
  {курсор находится на объекте или нет}
  if SvetList<>nil then
  for i:=0 to SvetList.Count-1 do
  if (gpMouse.X>=SvetList.Items[i].Rect.X) and
     (gpMouse.X<=SvetList.Items[i].Rect.X+SvetList.Items[i].Rect.Width) and
     (gpMouse.Y>=SvetList.Items[i].Rect.Y) and
     (gpMouse.Y<=SvetList.Items[i].Rect.Y+SvetList.Items[i].Rect.Height) then
  begin
     SvetList.Active:=True;
     fmMain.IBDS_Light_Signals.RecNo:=i+1;
     SvetList.Ind:=i;
     SvetList.Items[SvetList.Ind].Select:=True;
     del_x:=gpMouse.X-SvetList.Items[SvetList.Ind].Rect.X;
     PaintBox1.Repaint;
     Exit;
  end
  else
  begin
   SvetList.Active:=False;
  end;

  {курсор находится на объекте или нет}
  if LimitList<>nil then
  for i:=0 to limitlist.Count-1 do
  if (gpMouse.X>=limitlist.Items[i].P1.X) and
     (gpMouse.X<=limitlist.Items[i].P2.X) then
  begin
     if (gpMouse.Y>=limitlist.Items[i].P1.Y-5) and
        (gpMouse.Y<=limitlist.Items[i].P1.Y+5) then
        begin
         if Button=mbLeft then
           limitlist.Active_Hor:=True else
           LimitList.Active_Div:=true;
           fmMain.IBDS_Limits.RecNo:=i+1;
           LimitList.Ind:=i;
           LimitList.Items[LimitList.Ind].Select:=True;
           del_x:=gpMouse.Y-LimitList.Items[LimitList.Ind].P1.Y;
           PaintBox1.Repaint;
           Exit;
        end;
  end
  else
  begin
   limitlist.Active_Hor:=False;
   LimitList.Active_Div:=False;

  end;

  if LimitList<>nil then
  for i:=0 to limitlist.Count-1 do
  if ((gpMouse.Y>=limitlist.Items[i].P1.Y) and
     (gpMouse.Y<=limitlist.Items[i].P0.Y)) or
     ((gpMouse.Y>=limitlist.Items[i].P0.Y) and
     (gpMouse.Y<=limitlist.Items[i].P1.Y))
      then
  begin
     if (gpMouse.X>=limitlist.Items[i].P0.X-5) and
        (gpMouse.X<=limitlist.Items[i].P0.X+5) then
        begin
         if Button=mbLeft then
         begin
           limitlist.Active_Ver:=True;
           fmMain.IBDS_Limits.RecNo:=i+1;
           LimitList.Ind:=i;
           LimitList.Items[LimitList.Ind].Select:=True;
           del_x:=gpMouse.X-LimitList.Items[LimitList.Ind].P0.X;
           PaintBox1.Repaint;
           Exit;
         end;
        end;
  end
  else
  begin
   limitlist.Active_Ver:=False;
  end;
end;

{ TSvetList }

function TSvetList.GetItems(Index: Integer): TSvet;
begin
  Result := TSvet(inherited GetItem(Index));
end;

procedure TSvetList.SetItems(Index: Integer; const Value: TSvet);
begin
  inherited SetItem(Index, Value);
end;

procedure TSvet.Paint;
var
  koord_txt:string;
  rect_sm:TIGPRectF;
  gpPath:TIGPGraphicsPath;
  cl_temp_text,cl_temp:TColor;
begin
  if not Select then   cl_temp:=cl_svet
                else   cl_temp:=clLime;
 // gpPen.SetColor(ColorRefToARGB(cl_temp));
  Rect_sm:=Rect;
 // Rect_sm.Location.X:=Rect_sm.Location.X-scroll;
  Rect_sm.X:=Rect_sm.X-scroll;

 gpPath := TIGPGraphicsPath.Create;
 gpPath.Reset;
 gpPath.StartFigure();
 gpPath.AddArcF(Rect_sm.X+10,Rect_sm.Y, 12, 10, 0, -180);
 gpPath.AddArcF(Rect_sm.X+10,Rect_sm.Y+10, 12, 10, 180, -180);
 gpPath.CloseFigure();
 gpDrawer.DrawPath(TIGPPen.Create(MakeColor(255,cl_temp),w_svet), gpPath);
 gpDrawer.DrawLineF(TIGPPen.Create(MakeColor(255,cl_temp),w_svet),Rect_sm.X+6+10,Rect_sm.Y+10+10,Rect_sm.x+6+10,axis_x0);
 gpDrawer.DrawEllipseF(TIGPPen.Create(MakeColor(255,cl_temp),w_svet),Rect_sm.X+2.5+10,Rect_sm.Y+2, 7,7 );
 gpDrawer.DrawEllipseF(TIGPPen.Create(MakeColor(255,cl_temp),w_svet),Rect_sm.X+2.5+10,Rect_sm.Y+11, 7,7 );
// gpPen.SetColor(ARGBfromColor(clLime));   //debug
// gpDrawer.DrawRectangle(gpPen,rect_sm);    //debug

  if not Select then   cl_temp_text:=cl_svettext
                else   cl_temp_text:=clLime;
 // gpBrush.SetColor(ColorRefToARGB(cl_temp_text));
 // gpSFormat:=TIGPStringFormat.Create;
 // gpSFormat.SetAlignment(StringAlignmentCenter)  ;
  gpDrawer.ResetTransform;
  if Length(Name)<3 then
  begin
   gpSFormat:=TIGPStringFormat.Create;
    gpSFormat.SetAlignment(StringAlignmentCenter);
    gpDrawer.TranslateTransform(Rect.x+rect.Width/2-scroll,Rect.y-20);

    gpDrawer.DrawStringF(Name,
                         TIGPFont.Create(TIGPFontFamily.Create('Arial'),t_svet,[],UnitPixel),
                         TPointF.Create(0,0) ,
                         gpSFormat,
                         TIGPSolidBrush.Create( MakeColor( 255, cl_temp_text ))); //название

  end else
  begin
    gpSFormat:=TIGPStringFormat.Create;
    gpSFormat.SetAlignment(StringAlignmentNear);
    gpDrawer.TranslateTransform(Rect.x+rect.Width/2-scroll,Rect.y-5);
    gpDrawer.RotateTransform(-90) ;
    gpDrawer.DrawStringF(Name,
                         TIGPFont.Create(TIGPFontFamily.Create('Arial'),t_svet,[],UnitPixel),
                         TPointF.Create(0,-7) ,
                         gpSFormat,
                         TIGPSolidBrush.Create( MakeColor( 255, cl_temp_text ))); //название
  end ;
  gpDrawer.ResetTransform;
    if way=2 then
      koord_txt:='['+IntToStr(Round((gpMouse.X+(SvetList.Items[SvetList.Ind].Rect.Width/2-del_x)-axis_y0+beg_coord*px_1m)/px_1m))+' м]' else
      koord_txt:='['+IntToStr(Round((-1*gpMouse.X-(SvetList.Items[SvetList.Ind].Rect.Width/2-del_x)+axis_y0+end_coord*px_1m)/px_1m))+' м]';
    //gpDrawer.TranslateTransform(gpMouse.X -scroll,gpMouse.Y);
  // gpSFormat.SetAlignment(StringAlignmentNear);
  if Select then
  begin
   gpSFormat:=TIGPStringFormat.Create;
   gpSFormat.SetAlignment(StringAlignmentNear);
   gpDrawer.TranslateTransform(gpMouse.X -scroll,gpMouse.Y);
   gpDrawer.DrawStringF(koord_txt,
                        TIGPFont.Create(TIGPFontFamily.Create('Arial'),t_svet,[],UnitPixel),
                        TPointF.Create(15,-5) ,
                        gpSFormat,
                        TIGPSolidBrush.Create( MakeColor( 255, cl_temp_text ))); //координата
   gpDrawer.ResetTransform;
  end;
  //gpDrawer.Free;
 // gpFont.Free;

end;

procedure TfmGraph.MouseEnter(var Msg: TMessage);
begin
   Timer1.Enabled:=False;
end;

procedure TfmGraph.MouseLeave(var Msg: TMessage);
begin
{   if (SvetList.Active) or (StationList.Active) then
   begin
    // Timer1.Enabled:=True;
   end;   }

end;

procedure TfmGraph.Timer1Timer(Sender: TObject);
begin
{  if gpMouse.X<ScrollBox1.HorzScrollBar.Position then
   ScrollBox1.HorzScrollBar.Position:=ScrollBox1.HorzScrollBar.Position-50 else
   ScrollBox1.HorzScrollBar.Position:=ScrollBox1.HorzScrollBar.Position+50;

   PaintBox1.Repaint; }

end;

procedure TfmGraph.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
  old_km:Real;
  MausePos: TPoint;
  shift1:TShiftState;
begin
if (Zoom<=1.0) then
begin
  old_km:=km;
  Zoom:=zoom+0.05;
  //FillData4Graph;
  //PaintBox1.Repaint;
  PaintBox1.Width:=Round(axis_y0+Del_Coord*Zoom+20);
  GetCursorPos(MausePos);   {получение координат мыши}
  if  gpMouse.X>round(Width/2)+round(axis_y0) then
  begin
    ScrollBox1.HorzScrollBar.Position:=Round(old_km*Zoom+axis_y0{-beg_coord*px_1m-Width/2});
    Scroll:=ScrollBox1.HorzScrollBar.Position;
    MausePos.X:=round(fmGraph.Left+Width/2);
    MausePos.X:=Round(fmGraph.Left+old_km*Zoom+axis_y0-beg_coord*px_1m-Scroll);
   // SetCursorPos(MausePos.x,MausePos.y);
  end;
  FillData4Graph;
  PaintBox1.Repaint;
  StatusBar1.Panels.Items[4].Text:='1:'+inttostr(Round(zoom*1000));
 end;
end;

procedure TfmGraph.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
  old_km:Real;
MausePos: TPoint;
 begin
 if (Zoom>=0.09) then
 begin
  Zoom:=zoom-0.05;
  old_km:=km-axis_y0*px_1m;
  PaintBox1.Repaint;
  GetCursorPos(MausePos);   {получение координат мыши}
  if  gpMouse.X>round(Width/2)+round(axis_y0) then
  begin
    ScrollBox1.HorzScrollBar.Position:=round(old_km*Zoom-Width/2-axis_y0*px_1m);
    Scroll:=ScrollBox1.HorzScrollBar.Position;
    MausePos.X:=fmGraph.Left+round(Width/2)+round(axis_y0);
    SetCursorPos(MausePos.x,MausePos.y);
  end;
  FillData4Graph;
  PaintBox1.Repaint;
  StatusBar1.Panels.Items[4].Text:='1:'+inttostr(Round(zoom*1000));
 end;
end;

procedure TfmGraph.ScrollBox1CanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
 //PaintBox1.Repaint;
end;


{ TLimitList }

function TLimitList.GetItems(Index: Integer): TLimit;
begin
  Result := TLimit(inherited GetItem(Index));
end;

procedure TLimitList.SetItems(Index: Integer; const Value: TLimit);
begin
  inherited SetItem(Index, Value);
end;

{ TLimit }

procedure TLimit.Paint;
var
  spd_:Integer;
  P0_sm,P1_sm,P2_sm:TPointF;
begin

 // gpPen.SetColor(ColorRefToARGB(cl_Limit));
 // gpBrush.SetColor(ColorRefToARGB(cl_LimitText));
 // gpPen.SetWidth(1);


  P0_sm:=P0; P0_sm.X:=P0_sm.X-scroll;
  P1_sm:=P1; P1_sm.X:=P1_sm.X-scroll;
  P2_sm:=P2; P2_sm.X:=P2_sm.X-scroll;

  gpDrawer.DrawLineF(TIGPPen.Create(MakeColor(255,cl_Limit),w_limit),P1_sm, P2_sm);
  if (P0_sm.X<>0) and (P0_sm.Y<>0) then
  begin
  if Way=2 then gpDrawer.DrawLineF(TIGPPen.Create(MakeColor(255,cl_Limit), w_limit),
                                   P0_sm,
                                   P1_sm) else
                gpDrawer.DrawLineF(TIGPPen.Create(MakeColor(255,cl_Limit), w_limit),
                                   P0_sm,
                                   P2_sm);
  end;
  if (Round((-P1_sm.Y+axis_x0+del_x)/px_1km4) mod 5)=0 then
   spd_:=Round((-P1_sm.Y++axis_x0+del_x)/px_1km4) else

  if (Round((-P1_sm.Y++axis_x0+del_x)/px_1km4) mod 10)<5 then
  spd_:=Round((-P1_sm.Y++axis_x0+del_x)/px_1km4)-Round((-P1_sm.Y++axis_x0+del_x)/px_1km4) mod 10 else
   spd_:=5+Round((-P1_sm.Y++axis_x0+del_x)/px_1km4)-Round((-P1_sm.Y++axis_x0+del_x)/px_1km4) mod 10;

 gpDrawer.ResetTransform;
 gpSFormat:=TIGPStringFormat.Create;
 gpSFormat.SetAlignment(StringAlignmentCenter)  ;
 //gpSFormat.SetAlignment(StringAlignmentCenter);
 gpDrawer.TranslateTransform(P1_sm.X+(P2_sm.x-P1_sm.x)/2,P1_sm.y);
 gpDrawer.DrawStringF(IntToStr(Round((-P1_sm.Y++axis_x0)/px_1km4)),
                      TIGPFont.Create(TIGPFontFamily.Create('Arial'),t_limit,[],UnitPixel),
                      TPointF.Create(0,-20) ,
                      gpSFormat,
                      TIGPSolidBrush.Create( MakeColor ( 255, cl_LimitText ))); //название
 gpDrawer.ResetTransform;
 //  gpDrawer.RotateTransform(-90) ;
{ if Select then
 begin
 gpSFormat:=TIGPStringFormat.Create;
 gpSFormat.SetAlignment(StringAlignmentCenter)  ;
 gpDrawer.DrawStringF(IntToStr(Round((-gpMouse.Y+axis_x0+del_x)/px_1km4))+' км/ч',
                      TIGPFont.Create(TIGPFontFamily.Create('Arial'),14,[],UnitPixel),
                      TPointF.Create(gpMouse.x-scroll,gpMouse.y-gpfont.GetHeight(gpDrawer)),
                      gpSFormat,
                      TIGPSolidBrush.Create( MakeColor ( 255, cl_LimitText ))); //название
 end;    }
end;

procedure TfmGraph.btn1Click(Sender: TObject);
begin
 fmGraphcolors.ShowModal;
end;

{ TObjList }

function TObjList.GetItems(Index: Integer): TObj;
begin
    Result := TObj(inherited GetItem(Index));
end;

procedure TObjList.SetItems(Index: Integer; const Value: TObj);
begin
  inherited SetItem(Index, Value);
end;

{ TObj }

procedure TObj.Paint;
var
  koord_txt:string;
  rect_sm:TIGPRectF;
  gpPath:TIGPGraphicsPath;
  cl_temp_text,cl_temp:TColor;
  f_size: TIGPSizeF;
begin
  if not Select then   cl_temp:=cl_svet
                else   cl_temp:=clLime;
 // gpPen.SetColor(ColorRefToARGB(cl_temp));
  Rect_sm:=Rect;
 // Rect_sm.Location.X:=Rect_sm.Location.X-scroll;
  Rect_sm.X:=Rect_sm.X-scroll;

   if not Select then   cl_temp_text:=cl_svettext
                else   cl_temp_text:=clLime;
 if FType=7 then  //мост
 begin
    gpSFormat:=TIGPStringFormat.Create;
    gpSFormat.SetAlignment(StringAlignmentCenter);
  //  gpDrawer.DrawLineF(TIGPPen.Create(MakeColor(255,cl_temp_text),1),Rect_sm.X+6+10,Rect_sm.Y+rect.Height/2,Rect_sm.x+6+10,axis_x0);
    f_size:=   gpDrawer.MeasureStringF('М',
                                        TIGPFont.Create(TIGPFontFamily.Create('Arial'),20{t_svet},[],UnitPixel),
                                        gpSFormat);

    gpDrawer.TranslateTransform(Rect.x+Rect.Width/2-scroll+1,Rect.y+Rect.Height/2-f_size.Height/2);
    gpSFormat:=TIGPStringFormat.Create;
    gpSFormat.SetAlignment(StringAlignmentCenter);
    gpDrawer.DrawStringF('М',
                         TIGPFont.Create(TIGPFontFamily.Create('Arial'),20{t_svet},[],UnitPixel),
                         TPointF.Create(0,0) ,
                         gpSFormat,
                         TIGPSolidBrush.Create( MakeColor( 255, $00CEC280 ))); //название
    gpDrawer.ResetTransform;
    gpDrawer.DrawRectangleF(TIGPPen.Create(MakeColor(255,$00CEC280),1),Rect_sm);
 end;

 if FType=4 then  //КТСМ
 begin
    gpSFormat:=TIGPStringFormat.Create;
    gpSFormat.SetAlignment(StringAlignmentCenter);
   // gpDrawer.DrawLineF(TIGPPen.Create(MakeColor(255,cl_temp_text),1),Rect_sm.X+6+10,Rect_sm.Y+rect.Height/2,Rect_sm.x+6+10,axis_x0);
    f_size:=   gpDrawer.MeasureStringF('t°',
                                        TIGPFont.Create(TIGPFontFamily.Create('Arial'),20{t_svet},[],UnitPixel),
                                        gpSFormat);

    gpDrawer.TranslateTransform(Rect.x+Rect.Width/2-scroll+1,Rect.y+Rect.Height/2-f_size.Height/2);
    gpSFormat:=TIGPStringFormat.Create;
    gpSFormat.SetAlignment(StringAlignmentCenter);
    gpDrawer.DrawStringF('t°',
                         TIGPFont.Create(TIGPFontFamily.Create('Arial'),20{t_svet},[],UnitPixel),
                         TPointF.Create(0,0) ,
                         gpSFormat,
                         TIGPSolidBrush.Create( MakeColor( 255, $00CEC280 ))); //название
     gpDrawer.ResetTransform;
     gpDrawer.DrawRectangleF(TIGPPen.Create(MakeColor(255,$00CEC280),1),Rect_sm);
 end;

  if (FType=9) or (FType=10) then  //мост
 begin
    gpSFormat:=TIGPStringFormat.Create;
    gpSFormat.SetAlignment(StringAlignmentCenter);
  //  gpDrawer.DrawLineF(TIGPPen.Create(MakeColor(255,cl_temp_text),1),Rect_sm.X+6+10,Rect_sm.Y+rect.Height/2,Rect_sm.x+6+10,axis_x0);
    f_size:=   gpDrawer.MeasureStringF('НТ',
                                        TIGPFont.Create(TIGPFontFamily.Create('Arial'),20{t_svet},[],UnitPixel),
                                        gpSFormat);

    gpDrawer.TranslateTransform(Rect.x+Rect.Width/2-scroll+1,Rect.y+Rect.Height/2-f_size.Height/2);
    gpSFormat:=TIGPStringFormat.Create;
    gpSFormat.SetAlignment(StringAlignmentCenter);
    gpDrawer.DrawStringF('НТ',
                         TIGPFont.Create(TIGPFontFamily.Create('Arial'),20{t_svet},[],UnitPixel),
                         TPointF.Create(0,0) ,
                         gpSFormat,
                         TIGPSolidBrush.Create( MakeColor( 255, $00CEC280 ))); //название
    gpDrawer.ResetTransform;
    gpDrawer.DrawRectangleF(TIGPPen.Create(MakeColor(255,$00CEC280),1),Rect_sm);
 end;

   if (FType=1) or (FType=2) then  //мост
 begin
    gpSFormat:=TIGPStringFormat.Create;
    gpSFormat.SetAlignment(StringAlignmentCenter);
  //  gpDrawer.DrawLineF(TIGPPen.Create(MakeColor(255,cl_temp_text),1),Rect_sm.X+6+10,Rect_sm.Y+rect.Height/2,Rect_sm.x+6+10,axis_x0);
    f_size:=   gpDrawer.MeasureStringF('ПЕР',
                                        TIGPFont.Create(TIGPFontFamily.Create('Arial'),20{t_svet},[],UnitPixel),
                                        gpSFormat);

    gpDrawer.TranslateTransform(Rect.x+Rect.Width/2-scroll+1,Rect.y+Rect.Height/2-f_size.Height/2);
    gpSFormat:=TIGPStringFormat.Create;
    gpSFormat.SetAlignment(StringAlignmentCenter);
    gpDrawer.DrawStringF('ПЕР',
                         TIGPFont.Create(TIGPFontFamily.Create('Arial'),20{t_svet},[],UnitPixel),
                         TPointF.Create(0,0) ,
                         gpSFormat,
                         TIGPSolidBrush.Create( MakeColor( 255, $00CEC280 ))); //название
    gpDrawer.ResetTransform;
    gpDrawer.DrawRectangleF(TIGPPen.Create(MakeColor(255,$00CEC280),1),Rect_sm);
 end;
   if (FType=3)  then  //мост
 begin
    gpSFormat:=TIGPStringFormat.Create;
    gpSFormat.SetAlignment(StringAlignmentCenter);
  //  gpDrawer.DrawLineF(TIGPPen.Create(MakeColor(255,cl_temp_text),1),Rect_sm.X+6+10,Rect_sm.Y+rect.Height/2,Rect_sm.x+6+10,axis_x0);
    f_size:=   gpDrawer.MeasureStringF('ПУТ',
                                        TIGPFont.Create(TIGPFontFamily.Create('Arial'),20{t_svet},[],UnitPixel),
                                        gpSFormat);

    gpDrawer.TranslateTransform(Rect.x+Rect.Width/2-scroll+1,Rect.y+Rect.Height/2-f_size.Height/2);
    gpSFormat:=TIGPStringFormat.Create;
    gpSFormat.SetAlignment(StringAlignmentCenter);
    gpDrawer.DrawStringF('ПУТ',
                         TIGPFont.Create(TIGPFontFamily.Create('Arial'),20{t_svet},[],UnitPixel),
                         TPointF.Create(0,0) ,
                         gpSFormat,
                         TIGPSolidBrush.Create( MakeColor( 255, $00CEC280 ))); //название
    gpDrawer.ResetTransform;
    gpDrawer.DrawRectangleF(TIGPPen.Create(MakeColor(255,$00CEC280),1),Rect_sm);
 end;

  if (FType=11)  then  //мост
 begin
    gpSFormat:=TIGPStringFormat.Create;
    gpSFormat.SetAlignment(StringAlignmentCenter);
  //  gpDrawer.DrawLineF(TIGPPen.Create(MakeColor(255,cl_temp_text),1),Rect_sm.X+6+10,Rect_sm.Y+rect.Height/2,Rect_sm.x+6+10,axis_x0);
    f_size:=   gpDrawer.MeasureStringF('ГАЗ',
                                        TIGPFont.Create(TIGPFontFamily.Create('Arial'),20{t_svet},[],UnitPixel),
                                        gpSFormat);

    gpDrawer.TranslateTransform(Rect.x+Rect.Width/2-scroll+1,Rect.y+Rect.Height/2-f_size.Height/2);
    gpSFormat:=TIGPStringFormat.Create;
    gpSFormat.SetAlignment(StringAlignmentCenter);
    gpDrawer.DrawStringF('ГАЗ',
                         TIGPFont.Create(TIGPFontFamily.Create('Arial'),20{t_svet},[],UnitPixel),
                         TPointF.Create(0,0) ,
                         gpSFormat,
                         TIGPSolidBrush.Create( MakeColor( 255, $00CEC280 ))); //название
    gpDrawer.ResetTransform;
    gpDrawer.DrawRectangleF(TIGPPen.Create(MakeColor(255,$00CEC280),1),Rect_sm);
 end;
(*
 gpPath := TIGPGraphicsPath.Create;
 gpPath.Reset;
 gpPath.StartFigure();
 gpPath.AddArcF(Rect_sm.X+10,Rect_sm.Y, 12, 10, 0, -180);
 gpPath.AddArcF(Rect_sm.X+10,Rect_sm.Y+10, 12, 10, 180, -180);
 gpPath.CloseFigure();
 gpDrawer.DrawPath(TIGPPen.Create(MakeColor(255,cl_temp),w_svet), gpPath);
 gpDrawer.DrawLineF(TIGPPen.Create(MakeColor(255,cl_temp),w_svet),Rect_sm.X+6+10,Rect_sm.Y+10+10,Rect_sm.x+6+10,axis_x0);
 gpDrawer.DrawEllipseF(TIGPPen.Create(MakeColor(255,cl_temp),w_svet),Rect_sm.X+2.5+10,Rect_sm.Y+2, 7,7 );
 gpDrawer.DrawEllipseF(TIGPPen.Create(MakeColor(255,cl_temp),w_svet),Rect_sm.X+2.5+10,Rect_sm.Y+11, 7,7 );
// gpPen.SetColor(ARGBfromColor(clLime));   //debug
// gpDrawer.DrawRectangle(gpPen,rect_sm);    //debug

  if not Select then   cl_temp_text:=cl_svettext
                else   cl_temp_text:=clLime;
 // gpBrush.SetColor(ColorRefToARGB(cl_temp_text));
 // gpSFormat:=TIGPStringFormat.Create;
 // gpSFormat.SetAlignment(StringAlignmentCenter)  ;
  gpDrawer.ResetTransform;
  if Length(Name)<3 then
  begin
   gpSFormat:=TIGPStringFormat.Create;
    gpSFormat.SetAlignment(StringAlignmentCenter);
    gpDrawer.TranslateTransform(Rect.x+rect.Width/2-scroll,Rect.y-20);

    gpDrawer.DrawStringF(Name,
                         TIGPFont.Create(TIGPFontFamily.Create('Arial'),t_svet,[],UnitPixel),
                         TPointF.Create(0,0) ,
                         gpSFormat,
                         TIGPSolidBrush.Create( MakeColor( 255, cl_temp_text ))); //название

  end else
  begin
    gpSFormat:=TIGPStringFormat.Create;
    gpSFormat.SetAlignment(StringAlignmentNear);
    gpDrawer.TranslateTransform(Rect.x+rect.Width/2-scroll,Rect.y-5);
    gpDrawer.RotateTransform(-90) ;
    gpDrawer.DrawStringF(Name,
                         TIGPFont.Create(TIGPFontFamily.Create('Arial'),t_svet,[],UnitPixel),
                         TPointF.Create(0,-7) ,
                         gpSFormat,
                         TIGPSolidBrush.Create( MakeColor( 255, cl_temp_text ))); //название
  end ;
  gpDrawer.ResetTransform;
    if way=2 then
      koord_txt:='['+IntToStr(Round((gpMouse.X+(SvetList.Items[SvetList.Ind].Rect.Width/2-del_x)-axis_y0+beg_coord*px_1m)/px_1m))+' м]' else
      koord_txt:='['+IntToStr(Round((-1*gpMouse.X-(SvetList.Items[SvetList.Ind].Rect.Width/2-del_x)+axis_y0+end_coord*px_1m)/px_1m))+' м]';
    //gpDrawer.TranslateTransform(gpMouse.X -scroll,gpMouse.Y);
  // gpSFormat.SetAlignment(StringAlignmentNear);
  if Select then
  begin
   gpSFormat:=TIGPStringFormat.Create;
   gpSFormat.SetAlignment(StringAlignmentNear);
   gpDrawer.TranslateTransform(gpMouse.X -scroll,gpMouse.Y);
   gpDrawer.DrawStringF(koord_txt,
                        TIGPFont.Create(TIGPFontFamily.Create('Arial'),t_svet,[],UnitPixel),
                        TPointF.Create(15,-5) ,
                        gpSFormat,
                        TIGPSolidBrush.Create( MakeColor( 255, cl_temp_text ))); //координата
   gpDrawer.ResetTransform;
  end;
  //gpDrawer.Free;
 // gpFont.Free;
           *)

end;

end.
