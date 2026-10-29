set pagesize 555
set linesize 500
col tablespace for a40
select a.TABLESPACE_NAME Tablespace, 
b.Mb TBS_MB,
round(a.USED_BLOCKS*(select value from v$parameter where upper(name)='DB_BLOCK_SIZE')/1024/1024,0) IN_USE_MB, 
round(b.Mb-(a.USED_BLOCKS*(select value from v$parameter where upper(name)='DB_BLOCK_SIZE')/1024/1024),0) FREE_MB,
round(a.MAX_BLOCKS*(select value from v$parameter where upper(name)='DB_BLOCK_SIZE')/1024/1024,0) MAX_USED_MB,
trunc(((b.Mb-round(b.Mb-(a.USED_BLOCKS*(select value from v$parameter where upper(name)='DB_BLOCK_SIZE')/1024/1024),0))/b.Mb)*100,2) as PCT_USED
from v$sort_segment A, 
	(select tablespace_name, sum(bytes/1024/1024) Mb from dba_temp_files group by tablespace_name) B
where a.tablespace_name=b.tablespace_name;
