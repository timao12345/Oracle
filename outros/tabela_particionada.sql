alter table prd01_bi_dm4.TBAC_CONTA add PARTITION TP_430 VALUES LESS THAN (431) LOGGING COMPRESS BASIC TABLESPACE TS_BIDM4_DAT01;



select dbms_metadata.get_ddl('TABLE','FO_CONTRIB_HIST','KIPREV') "DDL  TABLE" from dual;





col owner for a30
col name for a30
col column_name for a30
column_position for a30
select * from all_part_key_columns where owner='CEMAR' and name='LEITURA_CCS';


select table_owner, table_name, partition_name, tablespace_name, logging, compression from dba_tab_partitions where table_name='ZCD_LOG_CEF_VAL' and table_owner='CEAL' order by partition_name;