SELECT LS.*, 
LS.KOORD * SH.Flag + SH.FValue AS  LIN_koord
FROM  LIGHT_SIGNALS LS
LEFT OUTER JOIN Shift SH
ON  (LS.Shift_KEY = Sh.ID)
WHERE  LS.Dir_key= :DIR_ID