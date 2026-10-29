-- fuzzy (Consistência - O "difusa": coluna irá sempre ler "NÃO" a menos que o arquivo de dados não é consistente, então a coluna difusa vai ler 'YES'. Um arquivo inconsistente em v $ datafile_header indica um arquivo na necessidade de recuperação)

PROMPT CHECK HEADER ALL DATAFILES

SET LINES 400 PAGES 900
COL ERROR FOR A20
COL NAME FOR A60
COL CHECKPOINT_CHANGE# FOR 999999999999999999999999
SELECT 
	FILE#,
	NAME, 
	FUZZY, 
	STATUS, 
	ERROR, 
	RECOVER, 
	TABLESPACE_NAME,
	CHECKPOINT_CHANGE#, 
	TO_CHAR(CHECKPOINT_TIME,'DD-MM-RRRR HH24:MI:SS') AS CHECKPOINT_TIME
FROM 
	V$DATAFILE_HEADER;