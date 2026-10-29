-- Verifica o SQL_TEXT pelo SQL_ID
UNDEF SQL_ID
SELECT * FROM dba_hist_sqltext WHERE SQL_ID='&&SQL_ID';