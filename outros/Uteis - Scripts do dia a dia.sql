-- comandos para reinicializar o serviço de backup da OCI dentro do Servidor
systemctl restart initdcsagent
systemctl restart initdcsadmin
cliadm update-dbcli

-- usar o source /home/oracle/dpcdb.env em vez do . oraenv
cgpsapcrmdb2
source /home/oracle/dpcdb.env

-- script ciclo de faturamento estacio /home/oracle/script_ciclo
nohup sqlplus  "/ as sysdba" @move_table_PSAPSR3_from_PSAPSR31.sql &
114131

nohup sqlplus  "/ as sysdba" @rebuild_lob.sql &

nohup sqlplus / as sysdba@bdprods @teste.sql &

sqlplus / as sysdba@bdprods @awr_miner.sql

watch "ps -ef | grep move_idx_tablespace_ECQ_2"

nohup sqlplus 'user/'@RDP1 @PRJ_790501_043.sql &
sqlplus system/\"\"@dbgoipd1 @format_prod.sql
sqlplus system/\"\"@DBERPMTP1
sqlplus system/\"\"@R102HNEW

sqlplus system/\"\"@DBERPMTP1

sqlplus oraadmin/\"\"@dbprcstg   

sqlplus oraadmin/\"\"@dbpystg           

-- procura o alert mais facil.
find $ORACLE_BASE -name alert_$ORACLE_SID.log

set sqlblanklines on -- parametro para tirar ignorar as linhas em branco pelo sqlplus caso gerar erro ao eaxecutar.

-- localizando o caminho dos arquivos de trace, alert, dump ... (a partir do 11G):
col NAME  for a35
col VALUE FOR a80
set lines 600
select * from v$diag_info;

-- lendo o alert log (a partir do 11G):
SELECT      ORIGINATING_TIMESTAMP, message_text 
FROM        X$DBGALERTEXT ORDER BY 1 DESC;

-- pesquisando erros no alert log:
col ORIGINATING_TIMESTAMP for a35
col MESSAGE_TEXT for a80
set lines 600
set pages 10000
SELECT ORIGINATING_TIMESTAMP, message_text 
FROM X$DBGALERTEXT 
where ORIGINATING_TIMESTAMP> (SYSDATE -3)
and  message_text like '%ORA-%'
ORDER BY 1 ASC;


SELECT to_char(ORIGINATING_TIMESTAMP, 'YYYY-Mon-DD') ORIGINATING_TIMESTAMP, message_level, count(message_level) QTD
FROM V$DIAG_ALERT_EXT
where ORIGINATING_TIMESTAMP> (SYSDATE -30)
and  message_text like '%ORA-%'
group by TO_CHAR(ORIGINATING_TIMESTAMP, 'YYYY-Mon-DD'),message_level
ORDER BY 1 ASC;

select count (1) value
from v$dbg_alert_text
where ORIGINATING_TIMESTAMP> ( SYSDATE -1 )
and  message_text like '%ORA-%';
select ORIGINATING_TIMESTAMP, message_text
from v$dbg_alert_text
where  ORIGINATING_TIMESTAMP> ( SYSDATE -1 ) and message_text like '%ORA-%';

col ORIGINATING_TIMESTAMP for a35
col MESSAGE_TEXT for a80
set lines 600
set pages 10000
SELECT ORIGINATING_TIMESTAMP, message_text 
FROM X$DBGALERTEXT 
where  message_text like '%resetlogs%'
ORDER BY 1 ASC;

select HOST_ID,MESSAGE_TYPE,MESSAGE_LEVEL,INSTANCE_ID,USER_ID,MESSAGE_TEXT
from V$DIAG_ALERT_EXT;

select * from dba_errors where name='PKG_EDI_PEDIDOSUPRIM';

-- limpar alertlogKP_SP_017_SOL_EMISSAO_PJ
show HOME

set HOMEPATH (resultado anterior, por exemplo: diag/rdbms/bdsmped_gru12x/BDSMPED)

purge -age 1 -type alert

-- editar a crontab no linux, parecido com VI, aperte I para editar/inserir, apos as modificações ":wq"
crontab -e

-- verifica usuarios do bd
set lines 850 pages 800
col username for a35
col PROFILE for a15
COL LAST_LOGIN FOR a15
select USERNAME,ACCOUNT_STATUS,LOCK_DATE,EXPIRY_DATE,LAST_LOGIN,PROFILE,PASSWORD_VERSIONS,CREATED,DEFAULT_TABLESPACE,TEMPORARY_TABLESPACE from dba_users
where USERNAME like '%SIS%';

alter user ORACLE_BKP identified by "CvP#Cat#lo1298gO" account unlock;


set lines 850 pages 800
col username for a35
col PROFILE for a15
select USERNAME,ACCOUNT_STATUS,LOCK_DATE,EXPIRY_DATE,CREATED,PROFILE,PASSWORD_VERSIONS,CREATED,DEFAULT_TABLESPACE,TEMPORARY_TABLESPACE from dba_users 
order by 3;

SET LINES 850 PAGES 800
COL USERNAME FOR A35
SELECT USERNAME,ACCOUNT_STATUS,LOCK_DATE,EXPIRY_DATE,CREATED,PROFILE FROM DBA_USERS WHERE USERNAME IN ('CVP14818','CVP13607','CVE14410','CVE14411','CVT42779','CVT40389','CVT24057','CVT20590','CVT42729','CVT54258','CVT43787')

-- lista os directories do BD
col owner for a25
col DIRECTORY_NAME for a25
col DIRECTORY_PATH for a65
set lines 850
select * from dba_directories;

-- Verifica status da instância --
--set heading off;
set echo off;
set lines 220
set pages 1000
col host_name for a20
select INSTANCE_NUMBER,INSTANCE_NAME,HOST_NAME,TO_CHAR(STARTUP_TIME, 'DD/MM/YYYY HH24:MI:SS') as STARTUP,STATUS,DATABASE_STATUS,ARCHIVER,logins from v$instance;

-- Verifica status da instância do RAC --
set lines 220
set pages 1000
col STARTUP_TIME for a20
col host_name for a20
select INSTANCE_NUMBER,INSTANCE_NAME,HOST_NAME,TO_CHAR(STARTUP_TIME, 'DD/MM/YYYY HH24:MI:SS') as STARTUP_TIME,STATUS,DATABASE_STATUS,ARCHIVER,logins from gv$instance;

set lines 220
set pages 1000
col STARTUP_TIME for a20
col host_name for a20
select INSTANCE_NUMBER,INSTANCE_NAME,HOST_NAME,STATUS,DATABASE_STATUS,ARCHIVER,logins from gv$instance;

--Verifica status do banco de dados, instancia, area de archive ...
  
select * from v$active_instances;

-- Verifica modo em que o banco está aberto, se é primary ou standby
select dbid,log_mode,open_mode,database_role from gv$database;


-- Verificar modo de logins allowed ou restricted
startup restrict; -- deixar banco modo restrito
alter database close -- deixar o banco em modo mount banco estando em modo open ficara mount.

alter system enable restricted session; -- modifica o banco para acesso restrito.

select logins from v$instance;

alter system disable restricted session;

-- Verifica recursos do banco de dados --
select RESOURCE_NAME,CURRENT_UTILIZATION,MAX_UTILIZATION,INITIAL_ALLOCATION,LIMIT_VALUE from v$resource_limit;

-- Verifica parâmetro de processos -- 

alter system set processes=3000 scope=spfile;
alter system set sessions=4000 scope=spfile;

set lines 220
set pages 1000
col RESOURCE_NAME for a25
col INITIAL_ALLOCATION for a30
col LIMIT_VALUE for a25
select RESOURCE_NAME,CURRENT_UTILIZATION,MAX_UTILIZATION,INITIAL_ALLOCATION,LIMIT_VALUE from v$resource_limit where RESOURCE_NAME in ('processes','sessions','transactions');

clear columns
set lines 220
set pages 1000
col RESOURCE_NAME for a25
col INITIAL_ALLOCATION for a30
col LIMIT_VALUE for a25
select INST_ID,RESOURCE_NAME,CURRENT_UTILIZATION,MAX_UTILIZATION,INITIAL_ALLOCATION,LIMIT_VALUE from gv$resource_limit where RESOURCE_NAME in ('processes','sessions','transactions');

-- contar processos ativos atuais
select count(*) from v$process;

-- Verifica tamanho do banco --
select sum(bytes) / 1024 / 1024 / 1024 GB from dba_segments;

-- Verifica tamanho dos owners
col owner for a25 
compute sum of MB on report
break on report
set lines 750 pages 1000 
select owner, sum(bytes) /1024/1024 MB from dba_segments group by owner order by MB ASC;


SELECT owner, COUNT(0) AS QUANTIDADE FROM dba_objects  
where owner not in
('DBSNMP', 
'CTXSYS', 
'MDSYS', 
'MDSYS', 
'ODM',
'ODM_MTR',
'ORDPLUGINS',
'ORDSYS',
'ORDCOMMON',
'OUTLN',
'SCOTT',
'WK_PROXY',
'WK_SYS',
'WMSYS',
'XDB',
'TRACESVR',
'OAS_PUBLIC',
'WEBSYS',
'LBACSYS',
'RMAN',
'PERFSTAT',
'EXFSYS',
'SI_INFORMTN_SCHEMA',
'SYS',
'SYS',
'SYSTEM')
GROUP BY owner order by 1;

col owner for a25 
compute sum of MB on report
break on report
set lines 750 pages 1000 
select owner,segment_name,TABLESPACE_NAME, sum(bytes) /1024/1024 MB from dba_segments where segment_name='PA_FAIXA_DETALHE' group by segment_name,owner,TABLESPACE_NAME order by MB ASC;

col owner for a25 
compute sum of MB on report
break on report
set lines 750 pages 1000 
select owner,segment_name,segment_type,sum(bytes) /1024/1024 MB from dba_segments where owner='INT_090_COMIS_SIGDC_RET_DETA' group by owner,segment_name,segment_type order by 3 asc ;

-- verifica tamanho do total de indices por owner
col owner for a25 
compute sum of MB on report
break on report
set lines 750 pages 1000 
select owner,SEGMENT_TYPE, sum(bytes) /1024/1024 MB from dba_segments where SEGMENT_TYPE='INDEX' group by SEGMENT_TYPE,owner order by MB ASC;

col owner for a25 
compute sum of MB on report
break on report
set lines 750 pages 1000
col segment_name for a25
select owner,segment_name,TABLESPACE_NAME,sum(bytes) /1024/1024 MB 
from dba_segments 
where owner='SAPSR3' and segment_type='INDEX' and tablespace_name='PSAPSR3' 
group by owner,segment_name,TABLESPACE_NAME order by 4 asc ;

col owner for a25 
compute sum of MB on report
break on report
set lines 750 pages 1000
col segment_name for a25
select owner,segment_name,TABLESPACE_NAME,sum(bytes) /1024/1024 MB 
from dba_segments 
where tablespace_name='SYSAUX' 
group by owner,segment_name,TABLESPACE_NAME order by 4 asc ;


alter index SAPPSR3.TESTE rebuild tablespace PSAPSR3750 PARALLEL 40;
-- 

-- verifica quantidade de indice
set lines 750 pages 1000 
select SEGMENT_TYPE, count(segment_name) QTD from dba_segments where SEGMENT_TYPE='INDEX' group by SEGMENT_TYPE order by QTD ASC;

-- Verifica espaço que os objetos estão ocupando nas tablespace
compute sum of MB on report
break on report
col OWNER for a25
select owner,SEGMENT_TYPE, TABLESPACE_NAME,sum(bytes) /1024/1024 as MB from dba_segments where owner = 'MI_KIPREV' group by owner,SEGMENT_TYPE,TABLESPACE_NAME order by MB;


col OWNER for a25
select owner,SEGMENT_TYPE,segment_name, TABLESPACE_NAME,sum(bytes) /1024/1024/1024 as GB from dba_segments where owner = 'SAPSR3' and segment_name='DFKKOPK~0' 
group by owner,SEGMENT_TYPE,TABLESPACE_NAME,segment_name order by GB;

select owner,SEGMENT_TYPE,segment_name,PARTITION_NAME from dba_segments where owner = 'SQL133_REMESSA_5018'  order by 1;

-- verifica nome do objeto, tipo, owner
select  owner, object_name, object_type,STATUS,CREATED,to_char (LAST_DDL_TIME, 'DD-MON-YY HH24:MI:SS') as LAST_DDL_TIME, TEMPORARY
from dba_objects 
where object_name in ('PREV_GARANTIA_LIBERACAO');
 

select owner,SEGMENT_TYPE,segment_name,PARTITION_NAME, TABLESPACE_NAME, sum(bytes) /1024/1024 AS MB from dba_segments where SEGMENT_TYPE = 'INDEX'
group by owner,SEGMENT_TYPE,segment_name, PARTITION_NAME,TABLESPACE_NAME order by MB;


select * from ALL_LOG_GROUPS where OWNER= 'OPERACAO' and TABLE_NAME='BE_LOG_PROCESSO_SINISTRO';

select SUPPLEMENTAL_LOG_DATA_MIN, SUPPLEMENTAL_LOG_DATA_PK,SUPPLEMENTAL_LOG_DATA_UI from v$database;

select  owner, object_name, object_type,STATUS,CREATED,to_char (LAST_DDL_TIME, 'DD-MON-YY HH24:MI:SS') as LAST_DDL_TIME
from dba_objects 
where  owner ='RMAN';

select * from dba_roles where role like 'S_%';

-- Verifica quantidade de tipos de objetos por owner
select  object_type, count(object_name) QTD 
from dba_objects 
where owner = 'APEX_180100' 
group by object_type order by QTD;

FLOWS_FILES
APEX_PUBLIC_USER
APEX_INSTANCE_ADMIN_USER
APEX_180100
SPATIAL_CSW_ADMIN_USR

select  owner,object_type, count(object_name) QTD 
from dba_objects
where owner = 'PRDFRM12C_IAU_APPEND' 
group by owner,object_type order by QTD;



-- ANALYSE
select OWNER,TABLE_NAME,LAST_ANALYZED from dba_tables
WHERE table_name IN ('PLSMETAS','PLSMETASESTRS','PLSMETASESTRSXMETAS','PLSMETASESTRSXMETASITS','PERIODICIDADES','METASCALCULOS');

select OWNER,TABLE_NAME,TABLESPACE_NAME from dba_tables
WHERE table_name IN ('BALDAT','BSAS','BSIS','CDCLS','DFKKINFCO','DFKKOP','DFKKOPK','DFKKZP','DPAYH','DPAYP','FAGLFLEXA','MLOG$_DFKKKO','MLOG$_DFKKOP','MLOG$_FAGLFLEXA','MLOG$_FAGLFLEXT','RFBLG','VVSCPOS','WITH_ITEM','ZCONSEGTRDSUM','ZFI_LOG_ARQH_CA','ZTE_LOG_CONTABIL');

--- // --
col OWNER for a25
select OWNER,SEGMENT_TYPE, count(segment_name) from dba_segments where OWNER = 'CEA_LOG' group by owner,SEGMENT_TYPE order by 3;

col OWNER for a25
select sum(bytes/1024/1024/1024) AS mb, OWNER,SEGMENT_TYPE, segment_name from dba_segments where segment_name = 'DFKKOP' group by OWNER,SEGMENT_TYPE, segment_name order by 3;


select bytes/1024/1024/1024  from dba_segments where segment_name = 'NCL_ARQUIVO_META' order by 3;

SELECT owner,TABLE_NAME,STATUS,SEGMENT_CREATED,DROPPED FROM DBA_TABLES WHERE TABLE_NAME='TB_FORNECEDOR_PRODUTO_REGIONAL' ORDER BY 1;

select owner,SEGMENT_NAME,segment_type, sum(bytes)/1024/1024/1024 as MB from dba_segments where owner='MIXDATA' GROUP BY owner,SEGMENT_NAME,segment_type;

-- Retorna as constraints agrupadas
col OWNER for a25
col CONSTRAINT_TYPE for a10
select owner,CONSTRAINT_TYPE, count(CONSTRAINT_NAME) as QTD from dba_constraints where owner='CIARAMA' group by owner, CONSTRAINT_TYPE order by qtd;

col OWNER for a25
col CONSTRAINT_TYPE for a10
select owner,CONSTRAINT_NAME,CONSTRAINT_TYPE,status  from dba_constraints where owner='TESTE' and status !='ENABLED' order by status;


BEGIN
  FOR CONST IN (SELECT CONSTRAINT_NAME,TABLE_NAME,OWNER FROM DBA_CONSTRAINTS WHERE OWNER='CIARAMA' AND CONSTRAINT_TYPE='R')
  loop
  if CONST <> (select CONSTRAINT_NAME from dba_constraints where owner='TESTE' and CONSTRAINT_NAME=const) 
  	then
		dbms_output.put_line('ALTER TABLE ' || CONST.OWNER || CONST.TABLE_NAME || ' ADD CONSTRAINT '|| CONST.CONSTRAINT_NAME) ;
    
  end loop;
END;

select  object_type, STATUS,object_name, owner, to_char(LAST_DDL_TIME,'DD-MON-YY HH24:MI') as Data
from dba_objects 
where object_name='FKKDIHDTMP' ;
group by object_type order by QTD;

-- Lista tamanho ocupado pelos index agrupado por owner
col Size format 999,999,999.99
col sum format 999,999,999.99
compute sum of Size on report
break on report
set lines 750 pages 1000 
select owner, SEGMENT_TYPE ,sum(bytes)/1024/1024 as "Size" from dba_segments where SEGMENT_TYPE='INDEX' and owner='&OWNER'group by owner,SEGMENT_TYPE order by 3 desc;


col Size format 999,999,999.99
col sum format 999,999,999.99
compute sum of Size on report
break on report
set lines 750 pages 1000 
select owner, SEGMENT_TYPE ,sum(bytes)/1024/1024 as "Size" from dba_segments where SEGMENT_TYPE='INDEX' and owner='&OWNER' and SEGMENT_NAME='CONTRATADOS' group by owner,SEGMENT_TYPE order by 3 desc;


col Size format 999,999,999.99
col sum format 999,999,999.99
compute sum of Size on report
break on report
set lines 750 pages 1000
col owner for a15
col SEGMENT_NAME for a35
select owner, segment_name, sum(bytes)/1024/1024 as "Size" from dba_segments where SEGMENT_TYPE='INDEX' and owner='BILD' group by owner, segment_name order by 3 asc;

select owner, segment_name, sum(bytes)/1024/1024 as "Size" from dba_segments where SEGMENT_NAME='CONTRATADOS'  group by owner, segment_name order by 3 asc;

-- drop dos obbjetos usuario atual
select 'drop '||object_type||' AGROZAP.'|| object_name || ';' from dba_objects where owner='AGROZAP' and object_type in ('PROCEDURE');

-- Verificar profiles
SELECT * FROM DBA_PROFILES WHERE RESOURCE_NAME = 'SESSIONS_PER_USER';

-- Verificar shared pool
select pool,name, (bytes)/1024/1024 as MB from v$sgastat where name= 'free memory' and pool ='shared pool';

-- Datapump em execução.
col OWNER_NAME for a12
col JOB_NAME for a35
col JOB_MODE for a8
col OPERATION for a6
col STATE for a15
set lines 850 pages 8000
select * from dba_datapump_jobs;

-- job expdp prezo

drop table BACKUP_NOITE purge;

--Retornar arquivos ou pastas ordenadas por tamanho no LINUX

$ du -h --max-depth=1 | sort -h

-- verificar usuarios ativos em um banco de dados SQL SERVER caso seja necessário realziar kill
use master
GO

select 
    d.name, 
    d.dbid, 
    spid, 
    login_time, 
    nt_domain, 
    nt_username, 
    loginame
from sysprocesses p 
    inner join sysdatabases d 
        on p.dbid = d.dbid
where d.name = 'consolidador_fast'
GO

-----------------------


with
  node as
   (select
      substr(host_name,-1) this,
      to_char(3-to_number(substr(host_name,-1))) other
    from v$instance),
  sizes as
   (select
      node.this n,
      nvl(segment_type,'TOTAL SIZE') segment_type,
      segment_name,
      round(sum(bytes)/1024/1024,1) size_mb
    from
      dba_segments,
      node
    where
      owner = 'DBA'
    group by grouping sets ((node.this),(node.this, segment_type, segment_name))
    union all
    select
      node.other n,
      nvl(segment_type,'TOTAL SIZE') segment_type,
      segment_name,
      round(sum(bytes)/1024/1024,1) size_mb
    from
      dba_segments@x,
      node
    where
      owner = 'DBA'
    group by grouping sets ((node.other),(node.other, segment_type, segment_name)))
select
  segment_type, segment_name,
  sum(decode(n,1,size_mb)) size_mb_n1,
  sum(decode(n,2,size_mb)) size_mb_n2
from sizes
group by segment_type, segment_name
order by nvl(size_mb_n1,0)+nvl(size_mb_n2,0) desc, segment_name, segment_type;


-- reiniciar serviços da OCI caso backups automaticos gerem erros.
-- For RHEL 6:
# initctl stop initdcsagent
# initctl stop initdcsadmin

# initctl start initdcsagent
# initctl start initdcsadmin

# initctl status initdcsagent
# initctl status initdcsadmin

-- For RHEL 7:
# systemctl stop initdcsagent
# systemctl stop initdcsadmin

# systemctl start initdcsagent
# systemctl start initdcsadmin

# systemctl status initdcsagent
# systemctl status initdcsadmin



select 
machine,
username,
osuser,
serial#
from gv$session 
where username not in 
('PETERSON','KIPREVWEB','ADAIL','OPS$KPV','DOUGLASREIS','KIPREVWEBMSG','USRGIA','SYS','SYSTEM','REPORT_SERVER','APLKPVEUL','SYSRAC','KPVEUL','KIPREV','DBSNMP','USR_MONITOR','SYSMAN','USR_DSTAGE','SYSESTUDO','USR_SQLLINK','USR_REPLICA_NEW','USR_REPLICA_02','USR_REPLICA_03','USR_REPLICA','USR_REPLICA_CDC_TESTE','SYSRAC');