-- lock table
set pagesize 1000;
set lines 900;
set numwidth 7;
col WAIT-User format a20;
col HOLD-User format a20;
col WAIT-Prog format a26;
col HOLD-Program format a26;
col WSid format 9999;
col HSid format 999999;
col WInst format 9;
col HInst format 9;
col WPid format a10;
col HPid format a10;
col HOLD-Object format a30;
SELECT w.sid "WSid",
S1.inst_id "WInst",
P1.spid "WPid",
s1.osuser "WAIT-User",
s1.program "WAIT-Prog",
h.sid "HSid",
S2.inst_id "HInst",
P2.spid "HPid",
s2.osuser "HOLD-User",
s2.program "HOLD-Program",
o.name "HOLD-Object"
FROM sys.gv_$process  P1,
sys.gv_$process  P2,
sys.gv_$session  S1,
sys.gv_$session  S2,
sys.gv_$lock     w,
sys.gv_$lock     h,
sys.obj$         o
WHERE w.LMODE = 0 AND h.request = 0 AND s1.row_wait_obj# = o.obj#
AND w.type(+) = h.type AND w.id1(+) = h.id1 AND w.id2(+) = h.id2
AND w.sid = S1.sid AND h.sid = S2.sid AND S1.paddr = P1.addr(+)
AND S2.paddr = P2.addr(+) AND S1.inst_id = w.inst_id
AND S2.inst_id = h.inst_id
ORDER BY w.ctime DESC;


-- lock session
set lines 750 pages 1000
col username for a20
col osuser for a20
col WAIT_CLASS for a20
col MACHINE for a15
select INST_ID,username,osuser,blocking_session as Bloqueador,BLOCKING_INSTANCE, sid, serial#, MACHINE,wait_class,SQL_ID,seconds_in_wait,status 
from gv$session where blocking_session is not NULL order by seconds_in_wait;

-- Verifica a sessão bloqueadora a partir do resultado da query acima
select INST_ID,username,osuser,blocking_session as Bloqueador, sid, serial#,MACHINE, wait_class,SQL_ID,seconds_in_wait, (last_call_et / 60) "Min_Active",status from gv$session where sid= 81;

select INST_ID,username,osuser,blocking_session as Bloqueador, sid, serial#,MACHINE, wait_class,SQL_ID,seconds_in_wait, (last_call_et / 60) "Min_Active",status 
from gv$session where username LIKE 'KIPREVWEB%'
order by "Min_Active";


select 'alter system kill session '||'''' || a.sid||','||a.serial#||',@' || a.inst_id ||''''||' immediate;'
from gv$session a 
WHERE A.USERNAME ='TER04913' 
and a.status='INACTIVE';

-- script que traz sessões inativas igual do scheduer de 5 minutos
set serverout on
select 'alter system kill session '|| ''''|| sid || ',' || serial#||',' || '@'||INST_ID|| ''''||' immediate;'
serial#
from gv$session
where type !='BACKGROUND'
and sql_id is null
and status='INACTIVE'
and SECONDS_IN_WAIT > 300
and username not in ('LUCAS','PETERSON','KIPREVWEB','ADAIL','OPS$KPV','DOUGLASREIS','KIPREVWEBMSG','USRGIA','SYS','SYSTEM','REPORT_SERVER','APLKPVEUL','SYSRAC','KPVEUL','KIPREV','DBSNMP','USR_MONITOR','SYSMAN','USR_DSTAGE','SYSESTUDO',
'USR_SQLLINK','USR_REPLICA_NEW','USR_REPLICA_02','USR_REPLICA_03','USR_REPLICA','USR_REPLICA_CDC_TESTE','SYSRAC');

select 'alter system kill session '||'''' || a.sid||','||a.serial#||''''||' immediate;'
from gv$session a 
WHERE  a.username not in ('LUCAS','PETERSON','KIPREVWEB','ADAIL','OPS$KPV','DOUGLASREIS','KIPREVWEBMSG','USRGIA','SYS','SYSTEM','REPORT_SERVER','APLKPVEUL','SYSRAC','KPVEUL','KIPREV','DBSNMP','USR_MONITOR','SYSMAN','USR_DSTAGE','SYSESTUDO',
'USR_SQLLINK','USR_REPLICA_NEW','USR_REPLICA_02','USR_REPLICA_03','USR_REPLICA','USR_REPLICA_CDC_TESTE','SYSRAC');
and a.type !='BACKGROUND';
and a.last_call_et > 3600;

set lines 900 pages 10000
col machine for a15
col SQL_PROFILE for a15
col SQL_PLAN_BASELINE for a15
col PROGRAM for a10
col username for a15
col SQL_FULLTEXT for a50
SELECT
s.inst_id,
s.sid,
s.serial#,
to_char(s.sql_exec_start,'dd/mm/yyyy hh24:mi:ss') sql_exec_start,
--s.sql_hash_value,
s.sql_id,
sq.executions,
--sq.plan_hash_value,
to_char(s.logon_time,'dd/mm/yyyy hh24:mi:ss') logon_time,
--s.machine,
s.username,
--s.program,
--sq.SQL_PLAN_BASELINE,
--sq.SQL_PROFILE,
substr(sq.sql_fulltext,1,50) sql_fulltext
FROM
gv$session s,gv$sql sq
WHERE s.sql_id = sq.sql_id
AND s.inst_id = sq.inst_id
AND s.sql_child_number = sq.child_number
AND s.USERNAME='PRODUCAO'
AND sq.SQL_TEXT like '%df.TABLESPACE_NAMEM%'
--AND s.inst_id = 1
--AND s.sid = 650
--AND s.sql_id='4gdcp42cxy217'
/


-- Verifica lock 
set lines 200;
col sid format 9999;
--col serial# format a5;
col spid format a12;
col status format a8;
col username format a10;
col osuser format a15;
col machine format a25;
col program format a15;
col logon_time format a20;
col id format 99;
column event format a40;
SELECT  /*+ RULE */ p.inst_id as id, l.SID, s.serial# serial, p.spid, s.username, s.status,
s.osuser, s.machine, s.program, l.type, l.lmode, l.request,
to_char(s.logon_time,'dd/mm/yyyy hh24:mm:ss') LOGON_TIME, SQL_ID
FROM gv$lock l, gv$session s, gv$process p
WHERE s.inst_id = l.inst_id
and s.inst_id = p.inst_id
AND s.SID = l.SID
and s.PADDR = p.addr
AND (l.id1, l.id2, l.TYPE) IN (SELECT id1, id2, TYPE
FROM gv$lock
WHERE request > 0)
ORDER BY ctime asc;

-- retorna Lock com dados da sessão bloqueadora e bloqueadas
SELECT DISTINCT(
'Status: ' || s.status || CHR(10) ||
'SID : ' || l.sid || CHR(10) ||
'SPID : ' || p.spid || CHR(10) ||
'Usuario : ' || s.osuser || ' / ' || s.username ||CHR(10) ||
'Maquina : ' || s.machine || CHR(10) ||
'Programa : ' || s.program || CHR(10) ||
'Logon Time : ' || to_char(s.logon_time,'DD/MM/YYYY HH24:MI:SS') ||CHR(10) ||
'SQL ID : ' || q.sql_id || CHR(10) ||
'SQL TEXT : ' || q.sql_text) as "Sessoes_Bloqueadoras"
FROM gv$session s
,gv$process p
,gv$sql q
,gv$lock l
WHERE s.inst_id = l.inst_id
and s.inst_id = p.inst_id
AND s.SID = l.SID
and s.PADDR = p.addr
and s.sql_id = q.sql_id(+)
and (l.id1, l.id2, l.TYPE) IN (SELECT id1, id2, TYPE
FROM gv$lock
WHERE request > 0);

--lock object
set pagesize 5555
set linesize 600
col USER for a60
col OBJECT_NAME for a35
SELECT A.USERNAME || CONCAT(' - ' || A.SID, ',' || A.SERIAL#) || CONCAT(' - ', A.OSUSER) || ' ' || A.STATUS "USER", 
DECODE(XIDUSN, 0, 'WAITING', 'BLOCKING') "TRANSACTION STATUS", 
C.OBJECT_NAME, C.OBJECT_TYPE 
FROM GV$SESSION A, GV$LOCKED_OBJECT B, DBA_OBJECTS C 
WHERE A.SID = B.SESSION_ID AND B.OBJECT_ID = C.OBJECT_ID 
AND A.SID=1393
ORDER BY 2
/
-- lock object
col owner for a15
col OBJECT for a35
col type for a7
col username for a15
col MACHINE for a20
SELECT A.*, B.USERNAME, B.MACHINE, B.STATUS,B.sql_id
FROM V$ACCESS A
INNER JOIN V$SESSION B ON A.SID=B.SID
WHERE A.TYPE='TABLE'
AND A.OBJECT='PCK_DB_FO_SIDE_TRANSAC_WS'
/

-- lock wait
undef object
SELECT A.USERNAME || CONCAT(' - ' || A.SID, ',' || A.SERIAL#) || CONCAT(' - ', A.OSUSER) || ' ' || A.STATUS "USER", 
DECODE(XIDUSN, 0, 'WAITING', 'BLOCKING') "TRANSACTION STATUS", 
C.OBJECT_NAME, C.OBJECT_TYPE 
FROM V$SESSION A, V$LOCKED_OBJECT B, DBA_OBJECTS C 
WHERE A.SID = B.SESSION_ID AND 
B.OBJECT_ID = C.OBJECT_ID 
and xidusn =0
ORDER BY 2
/

-- contenção de lock
select
    sid,
    sql_text
from
    v$session s,
    v$sql q
where
    sid in
    (select
       sid
    from
       v$session
   where
       state in ('WAITING')
   and
       wait_class != 'Idle'
   --and event='enq: TX - row lock contention'
   and
      (q.sql_id = s.sql_id or q.sql_id = s.prev_sql_id));

-- Mostra o status do bloqueio apontando a sessão responsavél
select distinct s1.username || '@' || s1.machine || ' ( INST=' || s1.inst_id || ' SID=' || s1.sid || ' ) is blocking '
|| s2.username || '@' || s2.machine || ' ( INST=' || s1.inst_id || ' SID=' || s2.sid || ' ) ' AS blocking_status
from gv$lock l1, gv$session s1, gv$lock l2, gv$session s2
where s1.sid=l1.sid and s2.sid=l2.sid and l1.BLOCK=1 and l2.request > 0
and l1.id1 = l2.id1 and l2.id2 = l2.id2 and l1.inst_id = s1.inst_id;

-- Matar sessões
SELECT 'alter system kill session ' || '''' || a.sid || ',' || a.serial# || ',@' || a.inst_id || '''' || ' immediate;'
FROM     gv$session a,gv$sort_usage b
WHERE   a.sql_id='2tun9z939faku'
  a.saddr = b.session_addr and a.status='INACTIVE' 
/

-- linha bloqueada.
lines 200
col object_name for a30
select o.object_name,
s.row_wait_obj#,
s.row_wait_file#,
s.row_wait_block#,
s.row_wait_row#,
dbms_rowid.rowid_create (1, s.ROW_WAIT_OBJ#, s.ROW_WAIT_FILE#, s.ROW_WAIT_BLOCK#, s.ROW_WAIT_ROW#) as "ROWID"
from v$session s, dba_objects o 
where s.sid=&SID and ROW_WAIT_OBJ# = o.OBJECT_ID;

select owner, object_name, object_type from dba_objects where object_name='TB_CUSTO_PRODUTO_RD';

-- coleta a tabela e rowid da linha acima
select * from USER$ where rowid='AAD7MbAABAAAQ4sAAA';

-- verifica causador do lock
set serverout on
break on username skip 1
declare
  sess varchar2(20);
  sessinfo varchar2(50);
begin
  for i in
    (with lk as 
      (select blocking_instance||'.'||blocking_session blocker, inst_id||'.'||sid waiter
       from gv$session 
       where blocking_instance is not null 
       and blocking_session is not null)
     select distinct blocker from lk where blocker not in (select waiter from lk)
    )
  loop
    select regexp_substr(i.blocker,'[0-9]+$')||','||serial# ||',@' || regexp_substr(i.blocker,'[0-9]+'),
      substr(username||' - '||program,1,50) into sess, sessinfo
    from gv$session where inst_id = regexp_substr(i.blocker,'[0-9]+') and sid = regexp_substr(i.blocker,'[0-9]+$');
    dbms_output.put_line( 'alter system kill session ''' || sess || ''' immediate;');

  end loop;
end;
/


-- verifica sessão responsavel pelo lock (Holder) e a bloqueada/Aguardando (Waiter)
SELECT   inst_id,  DECODE (request, 0, 'Holder: ', 'Waiter: ') || SID sess,
         id1,
         id2,
         lmode,
         DECODE (lmode,
                 0, 'None',
                 1, 'Null',
                 2, 'Row Share',
                 3, 'Row Exclusive',
                 4, 'Share',
                 5, 'Sh/Row Exclusive',
                 6, 'Exclusive'
                ) dslmode,
         request,
         DECODE (request,
                 0, 'None',
                 1, 'Null',
                 2, 'Row Share',
                 3, 'Row Exclusive',
                 4, 'Share',
                 5, 'Sh/Row Exclusive',
                 6, 'Exclusive'
                ) dsrequest,
         TYPE
    FROM gv$lock
   WHERE (id1, id2, TYPE) IN (SELECT id1,
                                     id2,
                                     TYPE
                                FROM gv$lock a
                               WHERE a.request > 0)
ORDER BY id1,
         request
/

--
SELECT
        c.sid,
        substr(object_name,1,20) OBJECT,
        c.username,
        substr(c.program,length(c.program)-20,length(c.program)) image,
        DECODE(b.type,
                'MR', 'Media Recovery',
                'RT', 'Redo Thread',
                'UN', 'User Name',
                'TX', 'Transaction',
                'TM', 'DML',
                'UL', 'PL/SQL User Lock',
                'DX', 'Distributed Xaction',
                'CF', 'Control File',
                'IS', 'Instance State',
                'FS', 'File Set',
                'IR', 'Instance Recovery',
                'ST', 'Disk Space Transaction',
                'TS', 'Temp Segment',
                'IV', 'Library Cache Invalidation',
                'LS', 'Log Start or Switch',
                'RW', 'Row Wait',
                'SQ', 'Sequence Number',
                'TE', 'Extend Table',
                'TT', 'Temp Table',
                b.type) lock_type,
        DECODE(b.lmode,
                0, 'None',                /* Mon Lock equivalent */
                1, 'Null',                /* NOT */
                2, 'Row-SELECT (SS)',     /* LIKE */
                3, 'Row-X (SX)',          /* R */
                4, 'Share',               /* SELECT */
                5, 'SELECT/Row-X (SSX)',  /* C */
                6, 'Exclusive',           /* X */
                to_char(b.lmode)) mode_held,
         DECODE(b.request,
                0, 'None',                /* Mon Lock equivalent */
                1, 'Null',                /* NOT */
                2, 'Row-SELECT (SS)',     /* LIKE */
                3, 'Row-X (SX)',          /* R */
                4, 'Share',               /* SELECT */
                5, 'SELECT/Row-X (SSX)',  /* C */
                6, 'Exclusive',           /* X */
                to_char(b.request)) mode_requested
FROM sys.dba_objects a, sys.v_$lock b, sys.v_$session c WHERE
a.object_id = b.id1 AND b.sid = c.sid AND OWNER NOT IN ('SYS','SYSTEM');

