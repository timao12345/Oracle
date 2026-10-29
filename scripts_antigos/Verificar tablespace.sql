clear columns
column tablespace format a30
column total_mb format 999,999,999.99
column used_mb format 999,999,999,999.99
column free_mb format 999,999,999.99
column pct_used format 999.99
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
        DECODE(total.mb,NULL,0,NVL(ROUND((total.mb - free.mb)/(total.mb)*100,2),100)) pct_used
from
                (select tablespace_name ts, sum(bytes)/1024/1024 mb from dba_data_files group by tablespace_name) total,
                (select tablespace_name ts, sum(bytes)/1024/1024 mb from dba_free_space group by tablespace_name) free,
        dba_tablespaces dbat
where total.ts=free.ts(+) 
        and total.ts=dbat.tablespace_name
        and (dbat.tablespace_name LIKE '%%')
union all
select  sh.tablespace_name, 
        'TEMP',
        SUM(sh.bytes_used+sh.bytes_free)/1024/1024 total_mb,
        SUM(sh.bytes_used)/1024/1024 used_mb,
        SUM(sh.bytes_free)/1024/1024 free_mb,
        ROUND(SUM(sh.bytes_used)/SUM(sh.bytes_used+sh.bytes_free)*100,2) pct_used
FROM v$temp_space_header sh
group by tablespace_name
order by 6;


https://smuolcs.intranet/sm941/ess.do 


--Verificar o diskgroup
SELECT NAME DISKGROUP, TOTAL_MB, FREE_MB, (TOTAL_MB-FREE_MB)/TOTAL_MB*100 PCT_UTILIZADO FROM GV$ASM_DISKGROUP; --WHERE NAME ='ORADATA';

--Verificar os datafile da tablespace
compute sum of SIZE on report
col file_name for a60
page SIZE 30
break on report 
select file_id, file_name,tablespace_name,status, bytes/1024/1024 "SIZE" , AUTOEXTENSIBLE,BLOCKS, MAXBYTES,INCREMENT_BY/1024/1024, MAXBLOCKS
from dba_data_files
where TABLESPACE_NAME = 'UNDOTBS1' --or TABLESPACE_NAME='SOSVIDARESGATE_IDX'
order by 2
/

--Verificar quais datafiles e tablespace estão no diskgroup
select FILE_ID,FILE_NAME,TABLESPACE_NAME,BYTES /1024/1024 as MB from dba_data_files order by 1; --where FILE_NAME like '%%';


select d.file_id, d.FILE_NAME,d.TABLESPACE_NAME,d.BYTES /1024/1024 as MB, f.BYTES /1024/1024 as Free
from dba_data_files d join dba_free_space f on d.file_id=f.file_id
where d.TABLESPACE_NAME= 'SYSTEM';

-- Verificar discos do diskgroup
col a.group_number for a5
col a.disk_number for a5
col name for a20
col path for a22
col label for a30
col diskgroup for a12
col label for a20
set lines 2000
set pages 1000
select a.group_number, a.disk_number, a.name, b.name as DISKGROUP, a.path, a.header_status, a.mount_status, a.mode_status, a.state, a.os_mb, a.total_mb, a.free_mb 
from gv$asm_disk a, gv$asm_diskgroup b 
where a.group_number=b.group_number and (b.name='ORADATA')
order by a.group_number, a.disk_number;

--Veficiar ASM
SELECT name, state, total_mb, free_mb FROM gv$asm_diskgroup;

SELECT GROUP_NUMBER,NAME DISKGROUP,STATE, TOTAL_MB, FREE_MB, (TOTAL_MB-FREE_MB)/TOTAL_MB*100 PCT_UTILIZADO FROM V$ASM_DISKGROUP ORDER BY 1;

--Verifica se é big file
select TABLESPACE_NAME, BIGFILE from dba_tablespaces;

select TABLESPACE_NAME, BIGFILE from dba_tablespaces where tablespace_name='REL_DEV_T_01'; 

--Verificar datafile da TEMP
compute sum of SIZE on report
col file_name for a60
page SIZE 30
break on report 
select file_id, file_name,tablespace_name,status, bytes/1024/1024 "SIZE" , AUTOEXTENSIBLE,BLOCKS, MAXBYTES,INCREMENT_BY/1024/1024, MAXBLOCKS
from dba_temp_files
where TABLESPACE_NAME = 'TEMP'
order by 2
/

alter tablespace temp add tempfile '+DATA' size 8000M autoextend on next 1G maxsize 32767M;
alter database tempfile '/orainst/DGIT/wsis/tmp/temp01.dbf' resize 500M

alter tablespace PSAPSR3 add datafile '/oracle/IEQ/sapdata2/sr3_102/sr3.data102' size 32767M autoextend on next 1G maxsize 32767M;
alter tablespace PSAPSR3 add datafile '/oracle/IEQ/sapdata3/sr3_103/sr3.data103' size 32767M autoextend on next 1G maxsize 32767M;


-- verificar discos do diskgroup
col a.group_number for a5
col a.disk_number for a5
col name for a20
col path for a22
col label for a30
col diskgroup for a12
--col label for a20
select a.group_number, a.disk_number, a.name, b.name as DISKGROUP, a.path, a.header_status, a.mount_status, a.mode_status, a.state, a.os_mb, a.total_mb, a.free_mb 
from v$asm_disk a, v$asm_diskgroup b 
where a.group_number=b.group_number and (b.name='ORAFRA')
order by a.group_number, a.disk_number;

-- Verificar uso da temp.
SET PAUSE ON
SET PAGESIZE 60
SET LINESIZE 300
 
SELECT 
   A.tablespace_name tablespace, 
   D.mb_total,
   SUM (A.used_blocks * D.block_size) / 1024 / 1024 mb_used,
   D.mb_total - SUM (A.used_blocks * D.block_size) / 1024 / 1024 mb_free
FROM 
   v$sort_segment A,
(
SELECT 
   B.name, 
   C.block_size, 
   SUM (C.bytes) / 1024 / 1024 mb_total
FROM 
   v$tablespace B, 
   v$tempfile C
WHERE 
   B.ts#= C.ts#
GROUP BY 
   B.name, 
   C.block_size
) D
WHERE 
   A.tablespace_name = D.name
GROUP by 
   A.tablespace_name, 
   D.mb_total
/

--verificar tamanho atual da shared pool
select pool,name, (bytes)/1024/1024 as MB from v$sgastat where name= 'free memory' and pool ='shared pool';



-- Verificar discos do diskgroup
col a.group_number for a5
col a.disk_number for a5
col name for a20
col path for a22
col label for a30
col diskgroup for a12
col label for a20
set lines 2000
set pages 1000
compute sum of a.total_mb on report
compute sum of a.free_mb on report
select a.group_number, a.disk_number, a.name, b.name as DISKGROUP, a.path, a.label, a.header_status, a.mount_status, a.mode_status, a.state, a.os_mb, a.total_mb, a.free_mb 
from gv$asm_disk a, gv$asm_diskgroup b 
where a.group_number=b.group_number and (b.name='ORAFRA')

UNION ALL

select  SUM(a.total_mb)/1024 as total_mb,
        SUM(a.free_mb)/1024 as free_mb
from gv$asm_disk a, gv$asm_diskgroup b 
where a.group_number=b.group_number and (b.name='ORAFRA');


-- Ver os blocos de dados de um datafile
col name for a35
select file_id, block_id, blocks*8192/1024 MB, owner || '.' || segment_name "Name",SEGMENT_TYPE, block_id*8192/1024 "Position MB"
from  sys.dba_Extents
where file_id = 158
   union  
      select file_id, block_id, blocks*8192/1024, 'Free' "Name",'Free', block_id*8192/1024 "Position MB" from sys.dba_free_space  
where file_id = 158 order by 1,2,3;

-- // --
set verify off 
column value new_val blksize 
select value from v$parameter where name = 'db_block_size';


select a.file_id, a.file_name, 
   ceil((nvl(hwm,1)*&&blksize)/1024) smallest, 
   ceil(blocks*&&blksize/1024) currsize, 
   ceil(blocks*&&blksize/1024) - ceil((nvl(hwm,1)*&&blksize)/1024) savings 
   from dba_data_files a, 
   (select file_id, max(block_id+blocks-1) hwm 
    from dba_extents where owner='SIA' 
group by file_id) b
where a.file_id = b.file_id;
