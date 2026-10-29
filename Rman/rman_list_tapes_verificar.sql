col DEVICE_TYPE form a12
col MEDIA form a13
col TAG form a18
col T_SECS form 999999
set lines 135 pages 1000
select BS_KEY, 
decode(BACKUP_TYPE,'L','Archive Logs','D','Datafiles',BACKUP_TYPE) BACKUPTYPE,
DEVICE_TYPE, MEDIA, TAG, -- HANDLE,
to_char(START_TIME,'dd/mm/yyyy hh24:mi:ss') START_TIME,
to_char(COMPLETION_TIME,'dd/mm/yyyy hh24:mi:ss') COMPLETION_TIME,
ELAPSED_SECONDS T_SECS, BYTES, STATUS
from rman.rc_backup_piece
where DB_ID=1220573649
  and START_TIME between to_date('06/05/2011 00:00:00','dd/mm/yyyy hh24:mi:ss')
                     and to_date('07/05/2011 09:00:00','dd/mm/yyyy hh24:mi:ss')
order by start_time;
