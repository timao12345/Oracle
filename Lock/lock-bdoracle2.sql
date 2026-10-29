-- Verifica objetos invalidos --

SELECT OWNER, OBJECT_NAME, OBJECT_TYPE, STATUS FROM DBA_OBJECTS WHERE OWNER='PRODUCAO' AND STATUS='INVALID';


-- Verificar objetos lockados -- 

SELECT a.inst_id, a.XIDUSN,a.OBJECT_ID, c.object_name, a.SESSION_ID,b.serial#, a.ORACLE_USERNAME,a.OS_USER_NAME,a.PROCESS 
from gv$locked_object a, gv$session b, dba_objects c where a.session_id=b.sid and c.object_id=a.object_id;

SELECT 'alter system kill session ' || '''' || b.sid || ',' || b.serial# || ',@' || a.inst_id || '''' || ' immediate;' 
FROM gv$access A,gv$session B WHERE a.object = 'OLIMPO_BENEFICIO' AND A.SID=B.SID; 

SELECT A.INST_ID,A.SID,B.SERIAL# FROM gv$access A,gv$session B WHERE a.object = 'CAMPUS' AND A.SID=B.SID; 


-- Verifica e da o comando de alter system kill -- 

SELECT 'alter system kill session ' || '''' || b.sid || ',' || b.serial# || ',@' || a.inst_id || '''' || ' immediate;' 
FROM gV$LOCKED_OBJECT A , gV$SESSION B, DBA_OBJECTS C
WHERE B.SID = A.SESSION_ID AND A.OBJECT_ID = C.OBJECT_ID;



-- Verificar objeto lockado especificando o nome -- 

select
a.inst_id,
a.sid
, a.serial#
, a.username
, c.os_user_name
, a.program
, a.machine
, b.object_id
, substr(b.object_name,1,40) object_name
, DECODE(c.locked_mode,
1, 'No Lock',
2, 'Row Share',
3, 'Row Exclusive',
4, 'Shared Table',
5, 'Shared Row Exclusive',
6, 'Exclusive') locked_mode
from gv$session a
, dba_objects b
, gv$locked_object c
where a.sid = c.session_id
and b.object_id = c.object_id
and b.object_name='OLIMPO_BENEFICIO';

SELECT 'alter system kill session ' || '''' || a.sid || ',' || a.serial# || ',@' || a.inst_id || '''' || ' immediate;' 
from gv$session a
, dba_objects b
, gv$locked_object c
where a.sid = c.session_id
and b.object_id = c.object_id
and b.object_name='OLIMPO_BENEFICIO';




SELECT INST_ID, SUBSTR(C.OWNER,1,10) "OWNER", SUBSTR(C.OBJECT_NAME,1,30) "NOME OBJETO", SUBSTR(C.OBJECT_TYPE,1,20) "TIPO DE OBJETO", SUBSTR(B.SID,1,10) "SID", SUBSTR(B.SERIAL#,1,10) "SERIAL", 
SUBSTR(B.STATUS,1,20) "STATUS", SUBSTR(B.OSUSER,1,15) "OSUSER", SUBSTR(B.MACHINE,1,30) "MAQUINA" 
FROM V$LOCKED_OBJECT A , GV$SESSION B, DBA_OBJECTS C
WHERE B.SID = A.SESSION_ID AND A.OBJECT_ID = C.OBJECT_ID; 



 SID        SERIAL     
 ---------- ---------- 
 10193      26231      
 9309       24037      
 5092       58299      
 5092       58299      
 9309       24037      

 
 alter system kill session '5092,58299,@1' immediate;
 alter system kill session '10193,26231,@1' immediate;
 alter system kill session '9309,24037,@1' immediate;
 
 
 
 
 
 -- Identificar os locks --

SELECT substr(DECODE(request,0,'Bloqueador: ','Bloqueado: ')||sid,1,20) sessao,
         --id1, id2, lmode, request, type,
         inst_id instance
   FROM GV$LOCK
  WHERE (id1, id2, type) IN
     (SELECT id1, id2, type FROM GV$LOCK WHERE request>0)
      ORDER BY id1, request


-- Coletar a query que está sendo processado no momento que esteja travando o processo --

select SID,status,SQL_ADDRESS,USERNAME,MACHINE,EVENT,to_char(LOGON_TIME,'dd/mm/yyyy hh24:mi:ss') from v$session where  SID= ( bloqueador)


- Enviar a query causadora de locks  para grupo de dba da Kroton : ti.dba@kroton.com.br  e  para quem enviou e-mail solicitando a eliminação dos locks  com cópia para : juliana.leonel@kroton.com.br.

select sql_text from v$sql where sql_id='5x80bqtx8bckm';


-- Locks em RAC --

-- Identifica locks no RAC --

WITH
-- global lock view
gl AS (
select
inst_id || '-' || sid instsid, id1, id2,
ctime, lmode, block, request
from
gv$lock
-- where ctime > 600
),
-- joins the global lock view on itself to identify locks
l AS (
SELECT
l1.instsid holding_session,
l2.instsid waiting_session
FROM
gl l1,
gl l2
WHERE
l1.block > 0
AND l2.request > 0
AND l1.id1=l2.id1
AND l1.id2=l2.id2
),
-- result view (tree of locked sessions)
rs AS (
SELECT
lpad(' ',3*(level-1),' ') || waiting_session running_session
FROM (
-- first insert as in utllockt
(SELECT
'-' holding_session, holding_session waiting_session
FROM
l
MINUS
SELECT
'-', waiting_session
FROM
l
)
UNION ALL
-- second insert as in utllockt
SELECT
holding_session, waiting_session
FROM
l
)
CONNECT BY PRIOR
waiting_session = holding_session
START WITH
holding_session = '-'
),
-- useful session informations
s AS (
SELECT
       inst_id,
       schemaname,
       sid,
       serial#,
       machine, 
       osuser, 
       username, 
       terminal, 
       program,
       nvl(module,'-') as module,
       nvl(sql_id, '-') as sql_id, 
       nvl(prev_sql_id, '-') as prev_sql_id, 
       event, 
       wait_class
  FROM gv$session
)
-- final tree
SELECT
*
FROM
rs
JOIN
s ON ltrim(rs.running_session)=s.inst_id || '-' || s.sid;


-- Identifica se há locks ou não -- 
select *
  from gv$lock
where request > 0
     and type in (‘TX’,’TM’,’UL’)



 
 