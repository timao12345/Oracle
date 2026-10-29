select * from dba_segments where tablespace_name='TBS_USR_ZABBIX_V8'; 



select * from dba_extents where tablespace_name='TBS_USR_ZABBIX_V8';


select * from dba_free_space where tablespace_name='TBS_USR_ZABBIX_V8';

select segment_name, segment_type, tablespace_name, block_id, blocks, bytes from dba_extents where tablespace_name='TBS_USR_ZABBIX_V8' order by 1,2,3,4,5;


select row_movement, STATUS,PCT_FREE, PCT_USED,PCT_INCREASE, initial_extent from dba_tables where table_name='TAB_TRACE';

select * from (select SQL_ID, rowid, dbms_rowid.rowid_block_number(rowid)  blocknum from USR_ZABBIX_V8.TAB_TRACE) where blocknum < 130 order by blocknum;