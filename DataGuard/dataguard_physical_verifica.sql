set lines 550
col message for a80
col timestamp for a20
col MESSAGE for a100
SELECT INST_ID,ERROR_CODE, SEVERITY, MESSAGE,TO_cHAR(TIMESTAMP, 'DD-MON-RR HH24:MI:SS') TIMESTAMP
FROM GV$DATAGUARD_STATUS
WHERE CALLOUT='YES'
AND TIMESTAMP > SYSDATE-1;

col message format a65
select to_char(timestamp,'DD/MM/YYYY HH24:MI:SS'), message from v$dataguard_status;

-- Parametro que é responsável por criar os datafiles automaticos
alter system set standby_file_management = AUTO scope=both sid='*';
alter system set standby_file_management = MANUAL scope=both sid='*';

-- stop archive replication
alter database recover managed standby database cancel;

-- start archive replication
alter database recover managed standby database disconnect from session;
alter database recover managed standby database disconnect ;

alter database recover managed standby database using current logfile disconnect from session;

-- active dataguard ativar
alter database recover managed standby database using current logfile disconnect;
alter database open read only;

select con_id, cdb, name, open_mode from v$database;


set lines 180 pages 10000
col message for a100
select to_char(TIMESTAMP,'dd/mm/yyyy-hh24:mi') "DATE", MESSAGE 
from V$DATAGUARD_STATUS where TIMESTAMP>sysdate-2/24;

SELECT * FROM gv$session s, gv$access a
WHERE a.object like '%+RECOC%'
AND s.sid = a.sid;

SELECT * FROM gv$session s, gv$access a
where s.sid = a.sid;

-- verifica diferença (GAP) (visevel somente no DR)
SELECT
   ARCH.THREAD# "Thread",
   ARCH.SEQUENCE# "Ultima Sequencia Recebida",
   APPL.SEQUENCE# "Ultima Sequencia Aplicada",
   (ARCH.SEQUENCE# - APPL.SEQUENCE# )"Diferenca" 
FROM
   (SELECT THREAD#, SEQUENCE# 
    FROM V$ARCHIVED_LOG 
    WHERE (THREAD#,FIRST_TIME)
         IN 
         (SELECT THREAD#, MAX(FIRST_TIME) 
          FROM V$ARCHIVED_LOG 
          GROUP BY THREAD# )
   ) ARCH, (
      SELECT THREAD#, SEQUENCE# 
      FROM V$LOG_HISTORY 
      WHERE ( THREAD#,FIRST_TIME)
         IN 
         (SELECT THREAD#,MAX(FIRST_TIME) 
          FROM V$LOG_HISTORY 
          GROUP BY THREAD#)
   ) APPL 
WHERE ARCH.THREAD# = APPL.THREAD# 
ORDER BY 1;


-- Verifica GAP
set lines 900
SELECT TO_CHAR(A.NEXT_TIME, 'DD/MM/YY HH24:MI:SS') "Last Applied",
A.SEQUENCE# "# Applied",
TO_CHAR(B.NEXT_TIME, 'DD/MM/YY HH24:MI:SS') "Last Received",
B.SEQUENCE# "# Received",
B.SEQUENCE# - A.SEQUENCE# "# Diff",
ROUND(B.NEXT_TIME - A.NEXT_TIME) TIME_IN_DAYS,
ROUND((B.NEXT_TIME - A.NEXT_TIME) * 24) TIME_IN_HOURS,
ROUND((B.NEXT_TIME - A.NEXT_TIME) * 24, 2) * 60 TIME_IN_MINUTES,
ROUND((B.NEXT_TIME - A.NEXT_TIME) * 24, 2) * 3600 TIME_IN_SECONDS
FROM V$ARCHIVED_LOG A, V$ARCHIVED_LOG B
WHERE A.SEQUENCE# =
(SELECT MAX(SEQUENCE#) FROM V$ARCHIVED_LOG WHERE APPLIED = 'YES')
AND B.SEQUENCE# = (SELECT MAX(SEQUENCE#) FROM V$ARCHIVED_LOG);

-- Archivelog difference: Run this on the primary database. (not for real-time apply):
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS';
BREAK ON REPORT
COMPUTE SUM LABEL TOTAL OF arc_diff ON REPORT
select a.thread#,
b.last_seq,
a.applied_seq,
a.last_app_timestamp,
b.last_seq - a.applied_seq arc_diff
from ( select thread#,max (sequence#) applied_seq, max (next_time) last_app_timestamp from v$archived_log where applied = 'YES' group by thread#) a,
( select thread#, max (sequence#) last_seq from v$archived_log group by thread#) b
where a.thread# = b.thread#;

select NAME, VALUE from V$DATAGUARD_STATS;


SET LINES 800
SET PAGESIZE 10000
BREAK ON REPORT
COMPUTE SUM LABEL TOTAL OF GAP ON REPORT
select primary.thread#,
      primary.maxsequence primaryseq,
      standby.maxsequence standbyseq,
      primary.maxsequence - standby.maxsequence gap
from ( select thread#, max(sequence#) maxsequence
      from v$archived_log
      where archived = 'YES'
        and resetlogs_change# = ( select d.resetlogs_change# from v$database d )
      group by thread# order by thread# ) primary,
    ( select thread#, max(sequence#) maxsequence
      from v$archived_log
      where applied = 'YES'
        and resetlogs_change# = ( select d.resetlogs_change# from v$database d )
      group by thread# order by thread# ) standby
where primary.thread# = standby.thread#;

select
'Thread=>'||a.thread# ||' Service Destination=> '||(select  distinct DESTINATION from V$ARCHIVE_DEST_STATUS where DEST_ID =a.DEST_ID AND TYPE<>'DOWNSTREAM') DESTINATION,DEST_ID,
(select max (sequence#) from v$archived_log where archived='YES' and thread#=a.thread#) archived,max (a.sequence#) applied,
(select max (sequence#) from v$archived_log where archived='YES' and thread#=a.thread#)-max (a.sequence#) gap,
(select DECODE(database_role, 'SNAPSHOT STANDBY', 1, 'LOGICAL STANDBY', 2, 'PHYSICAL STANDBY', 3, 'PRIMARY', 4, 'FAR SYNC', 5, 0) AS ROLE FROM v$database) AS GAP_DATABASE_ROLE
from v$archived_log a
where a.applied='YES'
and (select  distinct DESTINATION from V$ARCHIVE_DEST_STATUS where DEST_ID =a.DEST_ID and SRL='YES' 
AND TYPE<> 'DOWNSTREAM'
) is not null
and DEST_ID <> 1
group by a.thread#, DEST_ID
order by DEST_ID,a.thread#;

-- conta GAP resumido no total
select sum (x.arc_diff + y.arc_diff) as GAP from
(select b.last_seq - a.applied_seq arc_diff
from ( select thread#, max (sequence#) applied_seq from gv$archived_log where applied = 'YES' group by thread#) a,
     ( select thread#, max (sequence#) last_seq from gv$archived_log group by thread#) b
where a.thread# = b.thread# and a.thread#=1) x ,
(select b.last_seq - a.applied_seq arc_diff
from ( select thread#, max (sequence#) applied_seq from gv$archived_log where applied = 'YES' group by thread#) a,
     ( select thread#, max (sequence#) last_seq from gv$archived_log group by thread#) b
where a.thread# = b.thread# and a.thread#=2) y ;

SELECT
  MAX(ROUND((b.last_gen_time - a.last_app_time) * 24 * 60, 2)) AS "Maior GAP em Minutos"
FROM
  (SELECT thread#, MAX(next_time) last_app_time FROM v$archived_log WHERE applied = 'YES' GROUP BY thread#) a,
  (SELECT thread#, MAX(next_time) last_gen_time FROM v$archived_log GROUP BY thread#) b
WHERE a.thread# = b.thread#;

-- verifica gap detalhado por thread
set lines 1000 pages 1000
SELECT
  a.thread#,
  a.applied_seq AS "Ultima Sequencia Aplicada",
  TO_CHAR(a.last_app_time, 'YYYY-MM-DD HH24:MI:SS') AS "Data Ultimo Aplicado",
  b.last_seq AS "Ultima Sequencia Gerada",
  TO_CHAR(b.last_gen_time, 'YYYY-MM-DD HH24:MI:SS') AS "Data Ultimo Gerado",
  ROUND((b.last_gen_time - a.last_app_time) * 24 * 60, 2) AS "GAP em Minutos"
FROM
  (SELECT thread#, MAX(sequence#) applied_seq, MAX(next_time) last_app_time
     FROM v$archived_log WHERE applied = 'YES' GROUP BY thread#) a,
  (SELECT thread#, MAX(sequence#) last_seq, MAX(next_time) last_gen_time
     FROM v$archived_log GROUP BY thread#) b
WHERE a.thread# = b.thread#
ORDER BY a.thread#;


alter session set nls_date_format = 'DD-MON-YYYY HH24:MI:SS';
SELECT DEST_ID,THREAD#, SEQUENCE#, NAME,FIRST_TIME, NEXT_TIME, ARCHIVED, DELETED, APPLIED, BACKUP_COUNT
FROM GV$ARCHIVED_LOG
WHERE first_time > SYSDATE -1 and DEST_ID=2
ORDER  BY 3 ASC;

SELECT
  CASE
    WHEN MAX(next_time) < SYSDATE - (15/1440)
      THEN 1 -- ALERTA: Não aplicou archive nos últimos 15 minutos
    ELSE 0 -- OK: Aplicou archive nos últimos 15 minutos
  END AS DG_GAP_STATUS
FROM v$archived_log
WHERE applied = 'YES';


--Verificar tipo de dataguard
select log_mode,open_mode,database_role from v$database;

--Verificar o backgroud process, process MRP0 deve está em execução, em caso de Exdata / RAC, olhar sempre em qual nó está rodando o MRP
alter database recover managed standby database disconnect from session;
SELECT PROCESS, STATUS, THREAD#, SEQUENCE#, BLOCK#, BLOCKS FROM gV$MANAGED_STANDBY;

SELECT INST_ID,PROCESS, STATUS, THREAD#, SEQUENCE#, BLOCK#, BLOCKS FROM GV$MANAGED_STANDBY
where PROCESS like '%MRP%';

SELECT INST_ID, PROCESS, STATUS, THREAD#, SEQUENCE#, BLOCK#, BLOCKS,decode(nvl(BLOCKS,0), 0, 0, round((BLOCK#/BLOCKS)*100,2)) PERC
FROM GV$MANAGED_STANDBY
WHERE PROCESS = 'MRP0';

-- no stby
ALTER SYSTEM SET FAL_SERVER='ECCPRD' SCOPE=BOTH;
ALTER SYSTEM SET FAL_CLIENT='ECCSTBY' SCOPE=BOTH;
-- PRIMARY
ALTER SYSTEM SET FAL_SERVER='ECCSTBY' SCOPE=BOTH;
ALTER SYSTEM SET FAL_CLIENT='ECC' SCOPE=BOTH;

col dest_name for a20
col status for a15
set lines 160
set pages 300
select dest_id, dest_name, status, database_mode, error, SYNCHRONIZED, GAP_STATUS from v$archive_dest_status;

--where database_mode ='UNKNOWN';


select NAME, VALUE, DATUM_TIME from V$DATAGUARD_STATS;

-- checkpoint time dos datafiles se tiver FUZZY yes está faltando archives
ALTER SESSION SET NLS_DATE_FORMAT="YYYY-MM-DD HH24:MI:SS";
SET lines 1000 PAGES 1000
COL FILE# FOR 99999
COL CHECKPOINT_CHANGE# FOR 9999999999999999999999999
COL FUZZY FOR A5
col NAME for a70
col ERROR for a5
SELECT FILE#,NAME,STATUS,CHECKPOINT_TIME,CHECKPOINT_CHANGE#,ERROR,RECOVER,FUZZY FROM V$DATAFILE_HEADER order by FUZZY asc;


-- Restaurar archive log para um caminho especifico a partir da fita
run {
 allocate channel c1 type 'sbt_tape';
 send 'NB_ORA_CLIENT=FMP-ORA-WU01.servicos,NB_ORA_SERV=ipbtbms1,NB_ORA_POLICY=TB_WES_D_OR_D_DIA_23_01';
 SET ARCHIVELOG DESTINATION TO '/replicacao/CHANGEBK/archives';
 restore archivelog from logseq=39313 until logseq=39354 thread 1;
 restore archivelog from logseq=39944 until logseq=39986 thread 2;
release channel c1;
}


run {
ALLOCATE CHANNEL ch1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch2 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch3 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch4 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch5 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch6 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch7 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch8 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch9 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch10 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
restore archivelog from logseq=546 until logseq=759 thread 1;
restore archivelog from logseq=594 until logseq=830 thread 2;
release channel c1;
}


run {
ALLOCATE CHANNEL ch1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch2 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch3 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch4 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch5 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch6 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch7 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch8 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch9 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch10 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
restore archivelog from logseq=3755 until logseq=3773 thread 1;
}


-- verifica Archives que já foram aplicados mas não foram deletados
SELECT THREAD#, SEQUENCE#, FIRST_TIME, NEXT_TIME, ARCHIVED, DELETED, APPLIED
FROM V$ARCHIVED_LOG 
WHERE first_time > SYSDATE -1
AND DELETED='NO'
ORDER  BY first_time ASC;
and APPLIED='YES'


SELECT THREAD#, SEQUENCE#, FIRST_TIME, NEXT_TIME, ARCHIVED, DELETED, APPLIED
FROM V$ARCHIVED_LOG 
WHERE first_time > SYSDATE -1
and SEQUENCE#=540792; 





select sum (x.arc_diff + y.arc_diff) as GAP from
(select b.last_seq - a.applied_seq arc_diff
from ( select thread#, max (sequence#) applied_seq from v$archived_log where applied = 'YES' group by thread#) a,
     ( select thread#, max (sequence#) last_seq from v$archived_log group by thread#) b
where a.thread# = b.thread# and a.thread#=1) x ,
(select b.last_seq - a.applied_seq arc_diff
from ( select thread#, max (sequence#) applied_seq from v$archived_log where applied = 'YES' group by thread#) a,
     ( select thread#, max (sequence#) last_seq from v$archived_log group by thread#) b
where a.thread# = b.thread# and a.thread#=2) y ;


--[Thred 1 - Dataguard Gap Apllied archive]

SELECT B.LAST_SEQ - A.APPLIED_SEQ ARC_DIFF
FROM ( SELECT THREAD#,
MAX (SEQUENCE#) APPLIED_SEQ,
MAX (NEXT_TIME) LAST_APP_TIMESTAMP
FROM GV$ARCHIVED_LOG
WHERE APPLIED = 'YES'
GROUP BY THREAD#) A,
( SELECT THREAD#, MAX (SEQUENCE#) LAST_SEQ
FROM GV$ARCHIVED_LOG
GROUP BY THREAD#) B
WHERE A.THREAD# = B.THREAD# and A.THREAD#=1;

--[Thred 2 - Dataguard Gap Apllied archive]

SELECT B.LAST_SEQ - A.APPLIED_SEQ ARC_DIFF
FROM ( SELECT THREAD#,
MAX (SEQUENCE#) APPLIED_SEQ,
MAX (NEXT_TIME) LAST_APP_TIMESTAMP
FROM GV$ARCHIVED_LOG
WHERE APPLIED = 'YES'
GROUP BY THREAD#) A,
( SELECT THREAD#, MAX (SEQUENCE#) LAST_SEQ
FROM GV$ARCHIVED_LOG
GROUP BY THREAD#) B
WHERE A.THREAD# = B.THREAD# and A.THREAD#=2;


alter system set log_archive_dest_2='SERVICE=ECCSTBY LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=ECCSTBY NET_TIMEOUT=30 REOPEN=60 MAX_CONNECTIONS=5' scope=both sid='*';
alter system set log_archive_dest_2='SERVICE=ECCSTBY LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=ECCSTBY NET_TIMEOUT=30 REOPEN=60 MAX_CONNECTIONS=5' scope=both sid='*';


alter system set log_archive_dest_2= 'SERVICE=ECCSTBY ASYNC NOAFFIRM COMPRESSION=ENABLE VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=ECCSTBY' scope=both sid='ECC002';

ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS';
select b.last_seq - a.applied_seq arc_diff
from ( select thread#,max (sequence#) applied_seq from gv$archived_log where applied = 'YES' group by thread#) a,
( select thread#, max (sequence#) last_seq from gv$archived_log group by thread#) b
where a.thread# = b.thread#;


select thread#, sequence# applied_seq,applied from gv$archived_log where applied = 'YES';
select sequence# last_seq from gv$archived_log;


select NAME, VALUE, DATUM_TIME from V$DATAGUARD_STATS;

--------------------------
--  Database Switchover --
--------------------------
-- converter primary database para standby
CONNECT / AS SYSDBA
ALTER DATABASE COMMIT TO SWITCHOVER TO STANDBY;

-- Shutdown primary database
SHUTDOWN IMMEDIATE;

-- Mount old primary database as standby database
STARTUP NOMOUNT;
ALTER DATABASE MOUNT STANDBY DATABASE;
ALTER DATABASE RECOVER MANAGED STANDBY DATABASE DISCONNECT FROM SESSION;

-- -- Convert standby database to primary
CONNECT / AS SYSDBA
ALTER DATABASE COMMIT TO SWITCHOVER TO PRIMARY;
ALTER DATABASE COMMIT TO SWITCHOVER TO PRIMARY WITH SESSION SHUTDOWN; -- esse ja baixa o banco ai somente é executa o alter database open;

-- Shutdown standby database
SHUTDOWN IMMEDIATE;

-- Open old standby database as primary
STARTUP;

select SWITCHOVER_STATUS from V$DATABASE;
SELECT NAME, OPEN_MODE, DB_UNIQUE_NAME, DATABASE_ROLE FROM V$DATABASE;

--------------------------
--       Failover       --
--------------------------
ALTER DATABASE RECOVER MANAGED STANDBY DATABASE CANCEL;
ALTER DATABASE RECOVER MANAGED STANDBY DATABASE FINISH;

ALTER DATABASE ACTIVATE STANDBY DATABASE;

shutdown immediate;

Startup;

--------------------------
--   Snapshot Standby   --
--------------------------
SHUTDOWN IMMEDIATE;
STARTUP MOUNT;

-- parar a aplicação de redo o MRP
ALTER DATABASE RECOVER MANAGED STANDBY DATABASE CANCEL;

SELECT flashback_on FROM v$database;

FLASHBACK_ON
------------------
NO

-- converter para snapshot standby
ALTER DATABASE CONVERT TO SNAPSHOT STANDBY;
ALTER DATABASE OPEN;
SELECT flashback_on FROM v$database;

FLASHBACK_ON
------------------
RESTORE POINT ONLY

SQL>

-- converter de volta para physical standby
SHUTDOWN IMMEDIATE;
STARTUP MOUNT;
ALTER DATABASE CONVERT TO PHYSICAL STANDBY;
SHUTDOWN IMMEDIATE;
--STARTUP NOMOUNT;
STARTUP MOUNT;
--ALTER DATABASE MOUNT STANDBY DATABASE;
ALTER DATABASE RECOVER MANAGED STANDBY DATABASE DISCONNECT;
SELECT flashback_on FROM v$database;

FLASHBACK_ON
------------------
NO

SQL>


-- para abrir o banco caso queria usar para um tesde de DR e sabe que tera que recriar depois.
-- com banco stby em mount, o mrp parado, verifique os REDO LOG se estão certos e todas config de dataguard desfeitas no primary execute o comando abaixo:
-- para MRP
ALTER DATABASE RECOVER MANAGED STANDBY DATABASE CANCEL;

-- ativar o banco
ALTER DATABASE ACTIVATE STANDBY DATABASE;

-- Baixar e subir o banco normalmente, pois não precisa do open resetlogs
Startup

-- oou pelo srvctl
srvctl stop database -db ECCSTBY 
srvctl start database -db ECCSTBY

-- verifica o banco
SELECT DATABASE_ROLE, OPEN_MODE FROM V$DATABASE;


