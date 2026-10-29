--VERIFICAR SESS�ES LOCKADAS ORACLE        


--SINGLE INST
set pages 80
SELECT substr(DECODE(request,0,'Bloqueador: ','Bloqueado: ')||sid,1,20) sessao,
       id1, id2, lmode, request, type
FROM V$LOCK
WHERE (id1, id2, type) IN
   (SELECT id1, id2, type FROM V$LOCK WHERE request>0)
     ORDER BY id1, request;

--ORACLE RAC
--RODAR ESSA PARA VERIFICAR QUEM S�O OS BLOQUEADORES E OS BLOQUEADOS

set pages 500
set lines 180
col SESSAO for a30
SELECT inst_id,
	   substr(DECODE(request,0,'Bloqueador: ','Bloqueado: ')||sid,1,20) sessao,
       id1, id2, lmode, request, type
FROM GV$LOCK
WHERE (id1, id2, type) IN
   (SELECT id1, id2, type FROM GV$LOCK WHERE request>0)
     ORDER BY id1, request; 

/*
   INST_ID SESSAO                                ID1        ID2      LMODE    REQUEST TY
---------- ------------------------------ ---------- ---------- ---------- ---------- --
         1 Bloqueador: 2928                  5898246     125020          6          0 TX
         1 Bloqueado: 1015                   5898246     125020          0          6 TX
         1 Bloqueado: 1972                   5898246     125020          0          6 TX
         1 Bloqueado: 2020                   5898246     125020          0          6 TX
         1 Bloqueado: 3311                   5898246     125020          0          6 TX
         1 Bloqueado: 84                     5898246     125020          0          6 TX
         1 Bloqueador: 503                   7733271      37407          6          0 TX
         1 Bloqueado: 1473                   7733271      37407          0          4 TX
         1 Bloqueador: 1510                 13959180       2457          6          0 TX
         1 Bloqueado: 1497                  13959180       2457          0          6 TXX
*/
             
        
        
      
--RODAR PARA VERIFICAR QUAL O USU�RIO E QUAL A��O ESTA SENDO EFETUADA 
select a.username, a.sid, a.serial#, a.status,a.osuser,b.sql_id,b.sql_text from gv$session a, gv$sqltext b 
where a.SQL_HASH_VALUE=b.hash_value and status ='ACTIVE' and sid='2437' order by piece;


select a.username, a.sid, a.serial#, a.status,a.osuser,b.sql_id,b.sql_text from gv$session a, gv$sqltext b 
where a.SQL_HASH_VALUE=b.hash_value and sid='2437' order by piece;


select a.username, a.sid, a.serial#, a.status,a.osuser,b.sql_id,b.sql_text from v$session a, gv$sqltext b
where a.SQL_HASH_VALUE=b.hash_value and status ='ACTIVE' and sid='2437' order by piece;
         
 

 

--SESS�ES IDLE NO SERVIDOR 
select username, sid, serial#, wait_class, event from v$session;       
         
select username,status,wait_class,count(1) from gv$session group by username,status,wait_class order by username,status,wait_class ;

USERNAME             STATUS   WAIT_CLASS        COUNT(1)
-------------------- -------- --------------- ----------
DIGITAL_ADIQ         INACTIVE Idle                     7
PAYSTORE_ADIQ        INACTIVE Idle                    31
PAYSTORE_PHOEBUS     ACTIVE   Application              5
PAYSTORE_PHOEBUS     INACTIVE Idle                    70
PHAST_ADIQ           INACTIVE Idle                    41
PHAST_PHOEBUS        INACTIVE Idle                   140
PHDM_ADIQ            INACTIVE Idle                     5
PHDM_PHOEBUS         INACTIVE Idle                    18
SYS                  ACTIVE   Idle                     1
SYS                  ACTIVE   Network                  1
TEF_PHDM_PROD        INACTIVE Idle                     8
TEF_PROD             ACTIVE   Commit                   1
TEF_PROD             INACTIVE Idle                   195
UOLDIVEO_DBA         ACTIVE   Idle                     1
                     ACTIVE   Idle                    33
                     
select username, sid, serial#, wait_class, event from v$session where username='PAYSTORE_PHOEBUS' and wait_class='Idle'  



--VERIFICA O STATUS DAS SESS�ES DO USU�RIO

select username, sid, wait_class, event
from v$session where sid in(
2928,
1015,
1972,
2020,
3311,
84,
503, 
1473, 
1510,
1497
);


--GERAR COMANDO KILL PARA MATAR AS SESSÕES
select 'alter system kill session ''' || sid || ',' || serial# || ''' immediate;' 
from v$session where sid in(
2928,
1015,
1972,
2020,
3311,
84,
503, 
1473, 
1510,
1497
);

/*
'ALTERSYSTEMKILLSESSION'''||SID||','||SERIAL#||'''IMMEDIATE;'
------------------------------------------------------------------------------------------------------------------------
alter system kill session '84,27397' immediate;
alter system kill session '503,63427' immediate;
alter system kill session '1015,42835' immediate;
alter system kill session '1473,25451' immediate;
alter system kill session '1497,13629' immediate;
alter system kill session '1510,56555' immediate;
alter system kill session '1972,16989' immediate;
alter system kill session '2020,30617' immediate;
alter system kill session '2928,61811' immediate;
alter system kill session '3311,32649' immediate;
*/

select 'alter system kill session ''' || sid || ',' || serial# || ''' immediate;'
from v$session where username='PAYSTORE_PHOEBUS' and wait_class='Idle';