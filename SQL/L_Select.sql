SELECT L.ID, L.Dir_KEY, L.beg_km, L.beg_pk, L.end_km, L.end_pk, L.Speed, L.Note, L.Shift_KEY,
(L.beg_km * 1000+ L.beg_pk*100)* SH.Flag+ SH.FValue AS  LIN_KOORD,
((L.beg_km * 1000 +  L.beg_pk * 100)*SH.Flag+ SH.FValue)/1000 AS  LIN_BEG_KM,
(((L.beg_km * 1000 +  L.beg_pk * 100)*SH.Flag+ SH.FValue) - (((L.beg_km*1000 +  L.beg_pk* 100)*SH.Flag+ SH.FValue)/1000)*1000)/100  AS LIN_BEG_PK,
((L.end_km * 1000 +  L.end_pk * 100)*SH.Flag+ SH.FValue)/1000  AS LIN_END_KM,
(((L.end_km * 1000 +  L.end_pk * 100)*SH.Flag+ SH.FValue) - (((L.end_km*1000 +  L.end_pk* 100)*SH.Flag+ SH.FValue)/1000)*1000)/100  AS LIN_END_PK
FROM  Limits L
LEFT OUTER JOIN Shift SH
ON  (L.Shift_KEY = Sh.ID)
WHERE  L.Dir_key= :DIR_ID