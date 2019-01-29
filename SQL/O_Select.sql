SELECT O.*,OI.*,
(O.Koord * SH.Flag+ SH.FValue) AS  LIN_KOORD
FROM  Objects O
LEFT OUTER JOIN Objects_INFO OI
ON  (O.OBJ_KEY = OI.ID)
LEFT OUTER JOIN Shift SH
ON  (O.Shift_KEY = Sh.ID)
WHERE O.DIR_KEY = :DIR_ID
ORDER BY O.KOORD