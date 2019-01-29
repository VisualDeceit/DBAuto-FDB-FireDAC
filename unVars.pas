unit unVars;
interface
uses DB;
type
  rasp=record      //расписание по станциям
  im: {array[1..18]of} string[9];  //имя
  kr: Longint;     //коорд
  kB: Smallint;    //начало-коорд
  kE: Smallint;    //конец-коорд
  pB: Byte;        //начало-пикет
  pE: Byte;        //конец-пикет
  pH: Byte;        //часы
  pM: Byte;        //минуты
  SM: Byte         //стоянка
end;
  ogran=record      //постоянные ограничения
  kB: Smallint;    //начало-коорд
  kE: Smallint;    //конец-коорд
  pB: Byte;        //начало-пикет
  pE: Byte;        //конец-пикет
  V: Smallint;         //стоянка
end;
  prep=record      //перпятстивия/светофоры
  kr: Longint;     //коорд
  tp: Byte;         //тип
end;
  sv=record      //перпятстивия/светофоры
  kr: Longint;     //коорд
  naz: string[4];         //тип
  vyel: Byte;       //скорость на желтый
end;
  snd=record      //звуки
  nm: Byte;    // номер
  fl: Byte;       // флаг  маски 0-не сказано, 1-сказано
end;
 smeshenie=record    //смещение
 name:string[25];    // имя
 sm:integer;         // величина
 pr_napr:byte;      // напраление
 end;
 TImportSt=record
   ind_st: Word;
   ind_in: Word;
   ind_out: Word;
 end;
  Tshift=record
  Name:string[25];
  Value:integer;
  Flag:Smallint;
  end;

var
 frsp,frsp_ch:file of rasp;               {файл расписаний}
 fogp:file of ogran;              {файл ограничений}
 fogV:file of ogran;              {файл ограничений временных}
 fprp:file of prep;               {файл препятствий}
 fsvt:file of sv;               {файл светофоров}
 fprf:file of Smallint;               {файл профиля}
 fshst:file of Tshift;          {файл смещения}
 f_data: textfile;
 clctime: TextFile;               // отладка
 pkmout: textfile;                // отладка
 model_t: textfile;               // отладка
 registr: textfile;
 rsp: array[1..100] of rasp;      {массив расписаний}
 rsp_sec:array[1..100] of integer;
 rsp_kt: array[1..100] of byte;
 ogP: array[1..800] of ogran;     {массив постоянных ограничений}
 ogV: array[1..800] of ogran;     {массив временных ограничений}
 prp: array[1..800] of prep;      {массив препятствий}
 prp_s: array[1..800] of byte;      {массив препятствий}
 svt: array[1..800] of sv;      {массив светофоров}
 prf:array[1..10000] of Smallint;
 shft: array[1..100] of Tshift;

 Tr_ID,TTable_ID,DIR_ID,St_ID:string;
 Way: byte;
 poz_lim:Integer;
 Bookmark: TBookmark;
 ST_sel: integer=-1;
 SVT_sel: Integer=-1;
 PLF_sel: Integer=-1;
 fl_st_sel:Boolean=False;
 Per_speed:Byte=120;
 St_Sort:string;
 fl_Koord_Sort:Boolean=False;
 fl_Shift:Boolean=False;
 Shift_source:Byte=0;
 const
   OBJ=1;
   SVET=2;

implementation

end.
 