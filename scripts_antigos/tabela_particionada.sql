alter table prd01_bi_dm4.TBAC_CONTA add PARTITION TP_430 VALUES LESS THAN (431) LOGGING COMPRESS BASIC TABLESPACE TS_BIDM4_DAT01;



select dbms_metadata.get_ddl('TABLE','TBAC_CONTA','PRD01_BI_DM4') "DDL  TABLE" from dual;





col owner for a30
col name for a30
col column_name for a30
column_position for a30
select * from all_part_key_columns where owner='PRD01_BI_DM4' and name='TBAC_CONTA';


select table_owner, table_name, partition_name, tablespace_name, logging, compression from dba_tab_partitions where table_name='TBAC_CONTA' and table_owner='PRD01_BI_DM4' order by partition_name;