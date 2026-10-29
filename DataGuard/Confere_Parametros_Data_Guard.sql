set lines 230
col value for a100
col name for a30
select inst_id,name, value
from gv$parameter
where name in ('db_name','db_unique_name','log_archive_config', 'log_archive_dest_1','log_archive_dest_2',
               'log_archive_dest_state_1','log_archive_dest_state_2', 'remote_login_passwordfile',
               'log_archive_format','log_archive_max_processes','fal_server','db_file_name_convert',
                     'log_file_name_convert', 'standby_file_management') order by 2,1;
col DEST_NAME for a20
select INST_ID,DEST_ID,DEST_NAME,STATUS,TYPE,DATABASE_MODE,RECOVERY_MODE,SYNCHRONIZATION_STATUS,SYNCHRONIZED,GAP_STATUS,PROTECTION_MODE from gV$ARCHIVE_DEST_STATUS where DEST_NAME in ('LOG_ARCHIVE_DEST_1','LOG_ARCHIVE_DEST_2');
alter session set  NLS_date_format='DD/MM/YYYY HH24:MI:SS';
PROMPT "COMPARAR A HORA DO CONTROLFILE COM SYSDATE -- IMPORTANTE ANTES DO SWITCHOVER"
select inst_id,controlfile_time,sysdate from gv$database;
PROMPT "MOVIMENTACAO DE ARCHIVES ENTRE AS MAQUINAS"
SELECT PROCESS, STATUS, THREAD#, SEQUENCE#, BLOCK#, BLOCKS,DELAY_MINS  FROM V$MANAGED_STANDBY;


RECOVERY_MODE