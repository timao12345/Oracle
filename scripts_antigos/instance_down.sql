prompt ******************INFORMACOES DA INSTANCIA ******************
alter session set nls_date_format='dd/mm/yy:hh24:mi:ss';
set pagesize 5555
set linesize 500
col host_name for a20
select sysdate, startup_time, host_name, instance_name, status, a.open_mode, v.sessions_current, v.sessions_highwater
from v$instance, v$license v, v$database a
/


prompt ****************** VERIFICAR SE O DATAFILE SE ENCONTRA EM RECOVER ******************
select * from v$recover_file;

prompt VERIFICAR O HEADER DOS DATAFILES
select fuzzy, status, error, recover, checkpoint_change#, checkpoint_time from v$datafile_header;

prompt STATUS DATAFILES
col file_name for a63
select file_id, file_name, tablespace_name, status, autoextensible, increment_by, user_bytes, user_blocks 
from dba_data_files
order by file_id
/


prompt ****************** FREE SPACE TABLESPACE ******************

clear columns
column tablespace format a30
column total_mb format 999,999,999.99
column used_mb format 999,999,999,999.99
column free_mb format 999,999,999.99
column pct_used format 999.99
column graph format a25 heading "GRAPH (X=5%)"
column status format a10
compute sum of total_mb on report
compute sum of used_mb on report
compute sum of free_mb on report
break on report 
set lines 200 pages 100
select  total.ts tablespace,
        DECODE(total.mb,null,'OFFLINE',dbat.status) status,
	total.mb total_mb,
	NVL(total.mb - free.mb,total.mb) used_mb,
	NVL(free.mb,0) free_mb,
        DECODE(total.mb,NULL,0,NVL(ROUND((total.mb - free.mb)/(total.mb)*100,2),100)) pct_used,
	CASE WHEN (total.mb IS NULL) THEN '['||RPAD(LPAD('OFFLINE',13,'-'),20,'-')||']'
	ELSE '['|| DECODE(free.mb,
                             null,'XXXXXXXXXXXXXXXXXXXX',
                             NVL(RPAD(LPAD('X',trunc((100-ROUND( (free.mb)/(total.mb) * 100, 2))/5),'X'),20,'-'),
		'--------------------'))||']' 
         END as GRAPH
from
	(select tablespace_name ts, sum(bytes)/1024/1024 mb from dba_data_files group by tablespace_name) total,
	(select tablespace_name ts, sum(bytes)/1024/1024 mb from dba_free_space group by tablespace_name) free,
        dba_tablespaces dbat
where total.ts=free.ts(+) and
      total.ts=dbat.tablespace_name
UNION ALL
select  sh.tablespace_name, 
        'TEMP',
	SUM(sh.bytes_used+sh.bytes_free)/1024/1024 total_mb,
	SUM(sh.bytes_used)/1024/1024 used_mb,
	SUM(sh.bytes_free)/1024/1024 free_mb,
        ROUND(SUM(sh.bytes_used)/SUM(sh.bytes_used+sh.bytes_free)*100,2) pct_used,
        '['||DECODE(SUM(sh.bytes_free),0,'XXXXXXXXXXXXXXXXXXXX',
              NVL(RPAD(LPAD('X',(TRUNC(ROUND((SUM(sh.bytes_used)/SUM(sh.bytes_used+sh.bytes_free))*100,2)/5)),'X'),20,'-'),
                '--------------------'))||']'
FROM v$temp_space_header sh
GROUP BY tablespace_name
order by 6 
/

prompt ****************** SEE ALERTLOG ******************
undef days
set lines 100
 select to_char (ORIGINATING_TIMESTAMP, 'DD-MM-YYYY HH24:MI') data,
 message_text
 from x$dbgalertext
 where ORIGINATING_TIMESTAMP > (SYSDATE -1/24);
 
 