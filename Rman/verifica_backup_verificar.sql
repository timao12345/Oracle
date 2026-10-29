set lines 180 pages 10000
col OPERATION form a12
col STATUS form a27
col DEVICE form a10
select OPERATION, OBJECT_TYPE, STATUS,
       to_char(START_TIME, 'dd/mm/yy-hh24:mi') "START",
       to_char(END_TIME, 'dd/mm/yy-hh24:mi') "END",
       (END_TIME-START_TIME)*1440 "MIN.ELAPSED",
       MBYTES_PROCESSED/1024 MB_PROCESSED,
       OUTPUT_DEVICE_TYPE DEVICE
  from V$RMAN_STATUS
where OPERATION='BACKUP'
order by START_TIME;
