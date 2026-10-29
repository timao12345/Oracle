----------------------------------------------------------------------------------------
-- ANDAMENTO DA ATIVIDADE
----------------------------------------------------------------------------------------

set linesize 200
col username format a15
col terminal format a15

SELECT b.username,  b.terminal, b.sid, b.serial#,status, TO_CHAR(a.START_TIME,'DD-MON-YY HH:MI:SS') INICIO, (a.SOFAR/decode(a.TOTALWORK,0,1,a.TOTALWORK))*100 PERCENTUAL_FEITO , a.OPNAME
FROM V$SESSION_LONGOPS a, v$session b 
where a.totalwork > 0 and 
      b.sid = a.sid and 
      (a.SOFAR/decode(a.TOTALWORK,0,1,a.TOTALWORK))*100 < 100;

