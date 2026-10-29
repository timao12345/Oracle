--Verificar ultimas querys executadas
SELECT * FROM V$SQLAREA;

-- OBS: Utilziar parametro ROWNUM , essa view de sistema possui muitas colunas
SELECT * FROM v$sqlarea where ROWNUM < 10



select SQL_TEXT,PLSQL_EXEC_TIME,USER_IO_WAIT_TIME,USERS_OPENING,SQL_ID,CPU_TIME,OBJECT_STATUS,ACTION 
from v$sqlarea where rownum <2 order by SQL_TEXT asc; 



SELECT * FROM v$sqltext where rownum <2; 

SELECT * FROM v$sqlarea; 

SELECT * FROM v$sql; 

select SQL_TEXT,ROWS_PROCESSED,USERS_EXECUTING,CPU_TIME,SQLTYPE from v$sql where SQL_ID='aj6myrj6hs00g';



--Retorna ultima query executada pelo usuario atual
SELECT c.sql_text sqltext 
FROM v$session a, v$sql c
WHERE a.SID = (SELECT sid FROM V$SESSION WHERE audsid = SYS_CONTEXT('userenv', 'sessionid')) AND a.PREV_HASH_VALUE = c.HASH_VALUE;



col osuser for a20
col machine for a20
col username for a20
select s.STATUS,s.inst_id,s.SID, s.serial#, s.USERNAME, s.osuser, s.MACHINE,s.SQL_HASH_VALUE, s.sql_id, p.PID, p.SPID
from gv$process p, gv$session s
where s.PADDR = p.ADDR and s.type != 'BACKGROUND' and s.sid=532 order by status;


select sql_text, object_status, first_load_time, username, sid, lockwait 
from v$session ses, v$sql sql
where ses.sql_id = sql.sql_id



-- 
SELECT SID,
SERIAL#,
START_TIME,
((SOFAR/TOTALWORK)*100),'%',
MESSAGE 
FROM GV$SESSION_LONGOPSp 
where TIME_REMAINING > 0 ORDER BY start_time;


--Retorna as tabelas que estão sendo utilizadas
SELECT b.session_id AS sid,
       NVL(b.oracle_username, '(oracle)') AS username,
       a.owner AS object_owner,
       a.object_name,
       Decode(b.locked_mode, 0, 'None',
                             1, 'Null (NULL)',
                             2, 'Row-S (SS)',
                             3, 'Row-X (SX)',
                             4, 'Share (S)',
                             5, 'S/Row-X (SSX)',
                             6, 'Exclusive (X)',
                             b.locked_mode) locked_mode,
       b.os_user_name
FROM   dba_objects a,
       gv$locked_object b
WHERE  a.object_id = b.object_id
ORDER BY 1, 2, 3, 4;