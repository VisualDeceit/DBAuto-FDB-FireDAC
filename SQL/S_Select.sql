SELECT S.*,
(S.Koord * SH.Flag+ SH.FValue) AS  LIN_KOORD
FROM  Stations S
LEFT OUTER JOIN Shift SH
ON  (S.Shift_KEY = Sh.ID)
WHERE  S.Dir_key = :DIR_ID
