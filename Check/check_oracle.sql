set feed off echo off verify off trimspo on
set lines 200 pages 1000 numwidth 10

spool uoldiveo_check_oracle.log

Prompt Versão do Oracle
Prompt --------------------------------------------------------------------------------
-- Possíveis ações
-- Verificar se o banco de dados está no último patchset disponível
-- Informar cliente do upgrade disponível e solicitar janela de manutenção

select * from v$version;


Prompt Backup mais recente
Prompt --------------------------------------------------------------------------------
-- Possíveis ações
-- Verificar logs de backup em /usr/openv/netbackup/dbext ou /opt/DHC/ScriptsNbu/rman/Logs
-- Verificar e corrigir os erros encontrados ou acionar equipe de Backup para correção 

set lines 200 pages 1000 numwidth 10
col operation form a9
col recid form 999999
col device form a8
select recid, operation, object_type, status,
     to_char(start_time, 'dd/mm/yy-hh24:mi') "start",
     to_char(end_time, 'dd/mm/yy-hh24:mi') "end",
     trunc(INPUT_BYTES/1024/1024) input_mb,
     trunc((end_time-start_time)*1440) "min_elaps",
     output_device_type device
from V$rman_status
     where trunc(start_time)>trunc(sysdate-3)
     and operation='BACKUP'
     and substr(object_type,1,2) in ('DB','AR')
     and output_device_type='SBT_TAPE'
order by start_time;


Prompt Analyze mais recente
Prompt --------------------------------------------------------------------------------
-- Possíveis ações
-- Verificar o agendamento da coleta autonmática na dba_scheduler_jobs
-- Schedular o job através do Orcla ou via CRONTAB

col schema format a22;
select distinct trunc(last_analyzed) as last_analized,
       owner as schema, count(*) as nr_objetcs
from dba_tables
where owner in (select username from dba_users where account_status='OPEN')
and owner not in ('SYS','SYSTEM','PERFSTAT','AURORA$JIS$UTILITY$','CTXSYS','DBSNMP',
                  'DMSYS','EXFSYS','MDSYS','MTSSYS','OLAPSYS','ORDSYS','OSE$HTTP$ADMIN',
                  'OUTLN','SCOTT','SYSMAN','TSMSYS','WKSYS','WK_TEST','WMSYS','XDB',
                  'ORDDATA','OWBSYS','APPQOSSYS','APEX_030200','FLOWS_FILES')
group by trunc(last_analyzed), owner
order by owner, trunc(last_analyzed);


Prompt Tablespaces com utilizacao > 70 porcento
Prompt --------------------------------------------------------------------------------
-- Possíveis ações
-- Ajustar espaço
-- Capacity: Verificar necessidade de aquisição de disco
-- Verificar tablespace>70% utilizado e autoextend do datafile

col bytes_used form 9999999999999
col bytes_free form 9999999999999
col tablespace_name form a20
select a.tablespace_name, a.bytes mb_used, b.bytes mb_free, b.largest mb_largest,
       round(((a.bytes-b.bytes)/a.bytes)*100,2) percent_used
from  (select tablespace_name, round(sum(bytes)/1024/1024) bytes
       from dba_data_files
       group by tablespace_name) a,
      (select tablespace_name, round(sum(bytes)/1024/1024) bytes, round(max(bytes)/1024/1024) largest
       from dba_free_space
       group by tablespace_name) b
where a.tablespace_name=b.tablespace_name
and round(((a.bytes-b.bytes)/a.bytes)*100,2) > 70
order by a.tablespace_name;

col tablespace_name form a30
col file_name form a90
select tablespace_name, file_name, trunc(bytes/1024/1024) size_mb, autoextensible, round(maxbytes/1024/1024) maxsize_mb
from dba_data_files
order by tablespace_name, file_name;


Prompt Utilizacao do ASM (diskgroups)
Prompt --------------------------------------------------------------------------------

Prompt Espaço ASM
Prompt --------------------------------------------------------------------------------
-- Possíveis ações
-- Capacity: Verificar necessidade de aquisição de disco
-- Verificar disco >85% utilizado

select name, state, round(total_mb/1024,2) Total_GB, round(free_mb/1024,2) Free_GB,
       round(free_mb/total_mb*100,2) pct_Free       
from v$asm_diskgroup;


Prompt Tabelas Fragmentadas
Prompt --------------------------------------------------------------------------------
-- Possíveis ações
-- Agendar shrink dos segmentos através do Oracle

col owner form a15
col table_name form a30
select owner, table_name, 
round((blocks*8192/1024),2) tablesize_KB, 
trunc(round((num_rows*avg_row_len/1024),2)) actualtablesize_KB, 
(round((blocks*8192/1024),2) - trunc(round((num_rows*avg_row_len/1024),2))) diff_KB
from  dba_tables
where round((blocks*8192/1024),2)>1 
and (round((blocks*8192/1024),2) - trunc(round((num_rows*avg_row_len/1024),2))) > 250000
order by diff_KB desc;

Prompt Status dos indices
Prompt --------------------------------------------------------------------------------
-- Possíveis ações
-- rebuild dos indices

select owner, table_name, index_name from dba_indexes where status='UNUSABLE' ;



Prompt Redundancia de Control File em discos distintos
Prompt --------------------------------------------------------------------------------
-- Possíveis ações
-- Abrir change para correção com inclusão de controlfile redundante em disco distinto

col name form a80
select name from v$controlfile;


Prompt Redundancia de RedoLogs em discos distintos
Prompt --------------------------------------------------------------------------------
-- Possíveis ações
-- Abrir change para correção com inclusão de redolog member redundante em disco distinto

col member form a65
select a.group#, member, bytes/1024/1024 size_mb
from v$log a , v$logfile b
where a.group# = b.group#
order by a.group#, member;


Prompt Parametros principais
Prompt --------------------------------------------------------------------------------
-- Possíveis ações
-- Verificar anomalias de valores em relação aos recursos disponíveis no servidor

col name form a40
col value form a60
select name, value  from v_$parameter
where name in ('processes','sessions','open_cursors','session_cached_cursors',
               'sga_target','sga_max_size','control_file_record_keep_time',
               'utl_file_dir','spfile','db_create_file_dest','memory_max_target'
              ,'memory_target','pga_aggregate_target')
order by name;


Prompt Profiles limits
Prompt --------------------------------------------------------------------------------
-- Possíveis ações
-- Verificar a configuração de password_lifetime para evitar expiração de senhas (default desde 11g)

select profile, resource_name, limit 
from dba_profiles
where profile='DEFAULT'
order by resource_name;


Prompt Usuários com Permissão SYSDBA
Prompt --------------------------------------------------------------------------------
-- Possíveis ações
-- Verificar se o cliente tem carta de risco para administração compartilhada 

select username, sysdba
from gv$pwfile_users
order by username;


Prompt Usuários com Permissão DBA
Prompt --------------------------------------------------------------------------------
-- Possíveis ações
-- Verificar se o cliente tem carta de risco para administração compartilhada 

select grantee, granted_role 
from dba_role_privs
where granted_role = 'DBA';


Prompt Permissão dos pacotes UTL
Prompt --------------------------------------------------------------------------------
-- Possíveis ações
-- Verificar se o cliente tem carta de risco para administração compartilhada 

select grantee,table_name, privilege from dba_tab_privs
where grantee = 'PUBLIC'
and table_name in ('UTL_FILE','UTL_HTTP','UTL_TCP');


Prompt Tablespaces com BIGFILEs
Prompt --------------------------------------------------------------------------------
-- Possíveis ações
-- Verificar se o disco onde está o datafile tem espaço para crescimento

select tablespace_name 
from dba_tablespaces
where bigfile = 'YES';


Prompt Configuracao AWR
Prompt --------------------------------------------------------------------------------
-- Possíveis ações
-- Aplicar procedimento para desabilitar a ferramenta quando o cliente não possuir
-- pacote Diagnostic Pack

select extract( day from snap_interval) *24*60 + extract( hour from snap_interval) *60 + extract( minute from snap_interval ) snapshot_interval,
       extract( day from retention) *24*60 + extract( hour from retention) *60 + extract( minute from retention ) retention_interval
  from dba_hist_wr_control;


Prompt Verificar Statspack instalado
Prompt --------------------------------------------------------------------------------
-- Possíveis ações
-- Instalar o Statspack conforme procedimento Oracle

select object_type, owner, object_name 
from dba_objects 
where owner='%STAT%';


Prompt Verificar erros ORA-
Prompt --------------------------------------------------------------------------------
-- Possíveis ações
-- Verificar os erros encontrados na base da Oracle support.oracle.com
-- 11g
select message_text from X$DBGALERTEXT where message_text like '%ORA-%';
--10g
show parameter background_dump
create directory BDUMP as '/u01/app/oracle/admin/<sid>/bdump';
create table 
   alert_log ( msg varchar2(100) )
organization external (
   type oracle_loader
   default directory BDUMP
   access parameters (records delimited by newline)
   location('alert_<sid>.log')
)
reject limit 1000;
select * from alert_log where msg like '%ORA-%';


Prompt Verificar blocos corrompidos
Prompt --------------------------------------------------------------------------------
-- Possíveis ações
-- Verificar a possibilidade de recover dos blocos encontrados

select * from V$database_block_corruption order by 1,5;
select * from v$backup_corruption;


Prompt Verificar limite de recursos (capacity)
Prompt --------------------------------------------------------------------------------
-- Possíveis ações
-- Verificar possibilidad e de aumento de processes/sessions e/ou memória para alocar mais 
-- processos

col RESOURCE_NAME form a30
select RESOURCE_NAME, CURRENT_UTILIZATION, MAX_UTILIZATION, LIMIT_VALUE 
from v$resource_limit;

spool off;
