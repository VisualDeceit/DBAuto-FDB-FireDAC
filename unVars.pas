unit unVars;
interface
uses DB;
type
  rasp=record      //���������� �� ��������
  im: {array[1..18]of} string[9];  //���
  kr: Longint;     //�����
  kB: Smallint;    //������-�����
  kE: Smallint;    //�����-�����
  pB: Byte;        //������-�����
  pE: Byte;        //�����-�����
  pH: Byte;        //����
  pM: Byte;        //������
  SM: Byte         //�������
end;
  ogran=record      //���������� �����������
  kB: Smallint;    //������-�����
  kE: Smallint;    //�����-�����
  pB: Byte;        //������-�����
  pE: Byte;        //�����-�����
  V: Smallint;         //�������
end;
  prep=record      //������������/���������
  kr: Longint;     //�����
  tp: Byte;         //���
end;
  sv=record      //������������/���������
  kr: Longint;     //�����
  naz: string[4];         //���
  vyel: Byte;       //�������� �� ������
end;
  snd=record      //�����
  nm: Byte;    // �����
  fl: Byte;       // ����  ����� 0-�� �������, 1-�������
end;
 smeshenie=record    //��������
 name:string[25];    // ���
 sm:integer;         // ��������
 pr_napr:byte;      // ����������
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
 frsp,frsp_ch:file of rasp;               {���� ����������}
 fogp:file of ogran;              {���� �����������}
 fogV:file of ogran;              {���� ����������� ���������}
 fprp:file of prep;               {���� �����������}
 fsvt:file of sv;               {���� ����������}
 fprf:file of Smallint;               {���� �������}
 fshst:file of Tshift;          {���� ��������}
 f_data: textfile;
 clctime: TextFile;               // �������
 pkmout: textfile;                // �������
 model_t: textfile;               // �������
 registr: textfile;
 rsp: array[1..100] of rasp;      {������ ����������}
 rsp_sec:array[1..100] of integer;
 rsp_kt: array[1..100] of byte;
 ogP: array[1..800] of ogran;     {������ ���������� �����������}
 ogV: array[1..800] of ogran;     {������ ��������� �����������}
 prp: array[1..800] of prep;      {������ �����������}
 prp_s: array[1..800] of byte;      {������ �����������}
 svt: array[1..800] of sv;      {������ ����������}
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
 