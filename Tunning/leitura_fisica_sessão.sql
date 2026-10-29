-- Retorna sessão que está tendo o maior tempo em letura fisica I/o
SELECT sid, total_waits, time_waited
  FROM v$session_event
 WHERE event='db file sequential read'
  and total_waits>0
 ORDER BY 3,2
;

-- filtrar por sessão.
SELECT sid, total_waits, time_waited
  FROM v$session_event
 WHERE event='db file sequential read'
  and SID=28
 ORDER BY 3,2
;


-- Com essa informação será necessário verificar se a sessão está ativa e qual query está executando, e qual objeto está sofrendo mais I/0.

SELECT A.SQL_TEXT FROM V$SQLTEXT A, V$SESSION B WHERE A.ADDRESS = B.SQL_ADDRESS AND A.HASH_VALUE = B.SQL_HASH_VALUE AND B.SID = &SID ORDER BY PIECE;