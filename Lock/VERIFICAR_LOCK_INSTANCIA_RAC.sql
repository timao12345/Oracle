--VERIFICAR LOCK
Select a1.sid, 'Esta bloqueando ', a2.sid
From v$lock a1, v$lock a2 Where a1.block = 1 And a2.request > 0 And a1.id1=a2.id1 And a1.id2=a2.id2

--SINGLE INST
set pages 80
SELECT substr(DECODE(request,0,'Bloqueador: ','Bloqueado: ')||sid,1,20) sessao,id1, id2, lmode, request, type
FROM V$LOCK WHERE (id1, id2, type) IN (SELECT id1, id2, type FROM V$LOCK WHERE request>0) ORDER BY id1, request;

--ORACLE RAC
--RODAR ESSA PARA VERIFICAR QUEM S�O OS BLOQUEADORES E OS BLOQUEADOS

set pages 500
set lines 180
col SESSAO for a30
SELECT inst_id,substr(DECODE(request,0,'Bloqueador: ','Bloqueado: ')||sid,1,20) sessao,id1, id2, lmode, request, type
FROM GV$LOCK WHERE (id1, id2, type) IN (SELECT id1, id2, type FROM GV$LOCK WHERE request>0) ORDER BY id1, request; 

/*

   INST_ID|SESSAO                        |       ID1|       ID2|     LMODE|   REQUEST|TY
----------|------------------------------|----------|----------|----------|----------|--
         1|Bloqueador: 1891              |   4587538|    383417|         6|         0|TX
         2|Bloqueado: 454                |   4587538|    383417|         0|         6|TX
         1|Bloqueador: 1017              |  14090255|     55317|         6|         0|TX
         1|Bloqueado: 479                |  14090255|     55317|         0|         6|TX
         2|Bloqueado: 1587               |  14090255|     55317|         0|         6|TX
         2|Bloqueado: 2178               |  14090255|     55317|         0|         6|TX
         2|Bloqueado: 600                |  14090255|     55317|         0|         6|TX


*/


     
--RODAR PARA VERIFICAR O QUAL O USU�RIO E O QUE QUAL A��O ESTA SENDO EFETUADA 
select a.username, a.sid, a.serial#, a.status,a.osuser,b.sql_id,b.sql_text from gv$session a, gv$sqltext b 
where a.SQL_HASH_VALUE=b.hash_value and status ='ACTIVE' and sid='1564';


/*
USERNAME       |   SID| SERIAL#|STATUS    |OSUSER              |SQL_ID       |SQL_TEXT
---------------|------|--------|----------|--------------------|-------------|----------------------------------------------------------------
ODB            |  1891|   15967|ACTIVE    |diogo.santos        |96hsx7msb8cp6|UPDATE "DEFECT_REPORT" SET "STATUS" = :1, "DEFECT_DESCRIPTION" =

*/



select a.username, a.sid, a.serial#, a.status,a.osuser,b.sql_id,b.sql_text from gv$session a, gv$sqltext b 
where a.SQL_HASH_VALUE=b.hash_value and sid='1137' and status like 'ACTIVE';


--MATAR AS SESS�ES BLOQUEADAS

SYS@PHORA2> SYS@PHORA2>   2    3    4    5  WHERE (id1, id2, type) IN
   (SELECT id1, id2, type FROM GV$LOCK WHERE request>0)
     ORDER BY id1, request;  6    7

   INST_ID SESSAO                                ID1        ID2      LMODE    REQUEST TY
---------- ------------------------------ ---------- ---------- ---------- ---------- --
         1 Bloqueador: 2493                   166648          0          3          0 TM
         1 Bloqueado: 1546                    166648          0          0          5 TM

SYS@PHORA2> select sid, serial#, username from v$session where sid in (2493,1546);

       SID    SERIAL# USERNAME
---------- ---------- ------------------------------
      1546       8593 PERFSTAT
      2493       4803 M4U_PROD

      
       -- alter system kill session 'SID,SERIAL' immediate;
      
SYS@PHORA2> alter system kill session '1546,8593' immediate;
alter system kill session '1546,8593' immediate
*
ERROR at line 1:
ORA-00031: session marked for kill  --Quando ser� executado o rollback da execu��o que estava sendo efetuada.


·         ORA-00600  (erros internos)
·         ORA-01578  (erros de corrupção nos blocos)
·         ORA-00060  (erros de “deadlocks”)


select blocking_session, sid, serial#, wait_class, seconds_in_wait
from v$session
where blocking_session is not NULL
order by blocking_session;





select c.owner, c.object_name, c.object_type,b.sid, b.serial#, b.status, b.osuser, b.machine
from v$locked_object a , v$session b, dba_objects c
where b.sid = a.session_id and a.object_id = c.object_id