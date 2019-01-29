SELECT T.*, S.koord, S.FNAME, 
(S.Koord * SH.Flag+ SH.FValue) AS  LIN_KOORD
FROM  Time_table T 
LEFT OUTER JOIN Stations S 
ON  (T.STATION_KEY = S.ID) 
LEFT OUTER JOIN Shift SH 
ON  (S.Shift_KEY = Sh.ID)
WHERE T.TRAIN_KEY = :Tr_ID
