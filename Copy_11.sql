INSERT INTO TEMP SELECT * FROM TIME_TABLE WHERE TRAIN_KEY = :TR_ID_OLD;
update TEMP set ID = NULL;
update TEMP set TRAIN_KEY = :TR_ID;
INSERT INTO TIME_TABLE SELECT * FROM TEMP;