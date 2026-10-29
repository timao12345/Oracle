-- localizando o caminho dos arquivos de trace e alert (a partir do 11G):
SELECT * FROM V$DIAG_INFO where name IN ('Diag Alert','Diag Trace');
   
-- lendo o alert log (a partir do 11G):
SELECT      ORIGINATING_TIMESTAMP, message_text 
FROM        X$DBGALERTEXT ORDER BY 1 DESC;

-- pesquisando erros no alert log:
SELECT      ORIGINATING_TIMESTAMP, message_text 
FROM        X$DBGALERTEXT 
WHERE       MESSAGE_TEXT LIKE '%ORA-%'
ORDER BY    1 DESC;
