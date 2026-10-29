clear columns
column tablespace format a25
column total_mb format 999,999,999.99
column used_mb format 999,999,999,999.99
column free_mb format 999,999,999.99
column pct_used format 999.99
column graph format a22 heading "GRAPH (X=5%)"
column status format a7
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
where total.ts=free.ts(+) and total.ts=dbat.tablespace_name
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

select * from dba_tablespace_usage_metrics;
SELECT NAME FROM V$TABLESPACE

select tablespace_name, used_percent,TABLESPACE_SIZE from dba_tablespace_usage_metrics where tablespace_name='LLMINDX';a

compute sum of total_mb on report
col owner for a35
select owner, sum(bytes)/1024/1024 total_GB from dba_segments group by owner;
 
select TABLESPACE_NAME, BLOCK_SIZE, STATUS,BIGFILE,ENCRYPTED from dba_tablespaces;

--Veficiar diskgroups ASM

SELECT GROUP_NUMBER,NAME DISKGROUP,STATE, (TOTAL_MB/1024)/2, (FREE_MB/1024)/2, ((TOTAL_MB/2)-(FREE_MB/2))/TOTAL_MB*100  PCT_UTILIZADO, type FROM V$ASM_DISKGROUP;

SELECT GROUP_NUMBER,NAME DISKGROUP,STATE, TOTAL_MB, FREE_MB,(TOTAL_MB-FREE_MB)/TOTAL_MB*100  PCT_UTILIZADO,COMPATIBILITY,DATABASE_COMPATIBILITY FROM V$ASM_DISKGROUP;

SELECT GROUP_NUMBER,NAME DISKGROUP,STATE, TOTAL_MB, FREE_MB, (TOTAL_MB-FREE_MB)/TOTAL_MB*100 PCT_UTILIZADO FROM V$ASM_DISKGROUP_STAT ORDER BY 1;

SELECT NAME ,STATE, TOTAL_MB, FREE_MB, (TOTAL_MB-FREE_MB)/TOTAL_MB*100  PCT_UTILIZADO FROM V$ASM_DISKGROUP;


set lines 9999
set pages 9999
select name,
round(TOTAL_MB/decode(type,'NORMAL',2,'HIGH',3,1)/1024) TOTAL_GB,
round((TOTAL_MB-FREE_MB)/decode(type,'NORMAL',2,'HIGH',3,1)/1024) USED_GB,
round(FREE_MB/decode(type,'NORMAL',2,'HIGH',3,1)/1024) FREE_GB,
(TOTAL_MB-FREE_MB)/TOTAL_MB*100 PCT_USED,
(FREE_MB/TOTAL_MB)*100 PCT_FREE,
type
from v$asm_diskgroup;

set lines 9999
set pages 9999
select name,
TOTAL_MB TOTAL_MB,
TOTAL_MB-FREE_MB USED_MB,
FREE_MB FREE_MB, STATE,
--(TOTAL_MB-FREE_MB)/TOTAL_MB*100 PCT_USED,
--(FREE_MB/TOTAL_MB)*100 PCT_FREE,
type
from v$asm_diskgroup;

--Verificar os datafile da tablespace
compute sum of SIZE on report
col file_name for a90
col STATUS for a15 
page SIZE 30
break on report 
select file_id, file_name,tablespace_name,status, bytes/1024/1024 "SIZE" , AUTOEXTENSIBLE, MAXBYTES/1024/1024 "MAX", (8192*INCREMENT_BY)/1024 INCREMENT_BY
from dba_data_files
where TABLESPACE_NAME = 'TBS_CATALOGO'
order by 1;

alter tablespace PSAPSR3750 add datafile '+DATAC3' size 32767M autoextend on next 1G maxsize 32767M;
alter tablespace PSAPSR3750 add datafile '+DATAC3' size 32767M autoextend on next 1G maxsize 32767M;
alter tablespace PSAPSR3750 add datafile '+DATAC3' size 32767M autoextend on next 1G maxsize 32767M;
alter tablespace PSAPSR3750 add datafile '+DATAC3' size 32767M autoextend on next 1G maxsize 32767M;
alter tablespace PSAPSR3750 add datafile '+DATAC3' size 32767M autoextend on next 1G maxsize 32767M;
alter tablespace PSAPSR3750 add datafile '+DATAC3' size 32767M autoextend on next 1G maxsize 32767M;
alter tablespace PSAPSR3750 add datafile '+DATAC3' size 32767M autoextend on next 1G maxsize 32767M;
alter tablespace PSAPSR3750 add datafile '+DATAC3' size 32767M autoextend on next 1G maxsize 32767M;
alter tablespace PSAPSR3750 add datafile '+DATAC3' size 32767M autoextend on next 1G maxsize 32767M;
alter tablespace PSAPSR3750 add datafile '+DATAC3' size 32767M autoextend on next 1G maxsize 32767M;
alter tablespace PSAPSR3750 add datafile '+DATAC3' size 32767M autoextend on next 1G maxsize 32767M;
alter tablespace PSAPSR3750 add datafile '+DATAC3' size 32767M autoextend on next 1G maxsize 32767M;
alter tablespace PSAPSR3750 add datafile '+DATAC3' size 32767M autoextend on next 1G maxsize 32767M;
alter tablespace PSAPSR3750 add datafile '+DATAC3' size 32767M autoextend on next 1G maxsize 32767M;
alter tablespace PSAPSR3750 add datafile '+DATAC3' size 32767M autoextend on next 1G maxsize 32767M;

compute sum of SIZE on report
col file_name for a90
col STATUS for a15 
page SIZE 30
break on report 
select file_id, file_name,tablespace_name,status, bytes/1024/1024 "SIZE" , AUTOEXTENSIBLE, MAXBYTES/1024/1024 "MAX", (8192*INCREMENT_BY)/1024 INCREMENT_BY
from dba_data_files 
where FILE_NAME like '+DATAC1/KPVPRD/DATAFILE/%';

compute sum of SIZE on report
col file_name for a90
col STATUS for a15 
page SIZE 30
break on report 
select file_id, file_name,tablespace_name,status, bytes/1024/1024 "SIZE" , AUTOEXTENSIBLE, MAXBYTES/1024/1024 "MAX", (8192*INCREMENT_BY)/1024 INCREMENT_BY
from dba_data_files 
order by file_id;


--- // ---
alter database move datafile '+DATAC1/KPVPRD/prd_data_d-orakpv_ts-kiprev_ind1_fno-588.dbf' TO '+DATAC1/KPVPRD/prd_data_d-orakpv_ts-kiprev_data1_fno-674.dbf';

SELECT SEGMENT_NAME, SEGMENT_TYPE, OWNER, TABLESPACE_NAME, FILE_ID, BLOCK_ID
FROM DBA_EXTENTS
WHERE FILE_ID = (
    SELECT FILE_ID
    FROM DBA_DATA_FILES
    WHERE FILE_NAME = '+DATAC1/KPVPRD/prd_data_d-orakpv_ts-kiprev_ind1_fno-590.dbf'
)
ORDER BY SEGMENT_NAME;



-- Verifica espaço que os objetos estão ocupando nas tablespace
compute sum of MB on report
break on report
col OWNER for a25
select owner,SEGMENT_TYPE, TABLESPACE_NAME,sum(bytes) /1024/1024 as MB from dba_segments where TABLESPACE_NAME = 'SYSAUX' group by owner,SEGMENT_TYPE,TABLESPACE_NAME order by MB;

compute sum of MB on report
break on report
col OWNER for a25
select owner,SEGMENT_TYPE,segment_name, TABLESPACE_NAME,bytes/1024/1024 as MB from dba_segments where TABLESPACE_NAME = 'SYSAUX' order by MB;

-- verifica recovery_file_dest (RECO)
set lines 100
col name format a60
select
   name,
  floor(space_limit / 1024 / 1024) "Size MB",
  ceil(space_used / 1024 / 1024) "Used MB"
from
   v$recovery_file_dest
order by
   name;

-- Datafiles
col NAME for a60
select NAME,STATUS,ENABLED,ONLINE_TIME,to_char(CREATION_TIME,'DD-MON-YY HH24:MI') from v$datafile where name ='/u01/ingrid/index1/indices_particionados01.dbf' order by 1;

compute sum of SIZE on report
col file_name for a75
set lines 1000 pages 10000
page SIZE 30
break on report 
select file_id, file_name,tablespace_name,status, bytes/1024/1024 "SIZE" , AUTOEXTENSIBLE, MAXBYTES/1024/1024 "MAX",INCREMENT_BY
from dba_data_files;

1424

where file_name like '/oracle/PP0/sapdata2%'
order by 1,2
/

alter database datafile '/u01/ingrid/index1/indices_particionados02.dbf' resize 16767m; 

alter database datafile 1  autoextend off;

set lines 1000 pages 10000
select 'alter database datafile '|| h.FILE# ||' autoextend off;'
from V$DATAFILE_HEADER h, V$DATAFILE f
where h.FILE# = f.FILE# (+) 
order by h.file# ;

--Verifica datafile com status de recovery
SELECT NAME,status FROM V$DATAFILE WHERE STATUS = 'RECOVER';

   -- Dentro do rman colocar nome do datafile em modo recover, comando abaixo vai recuperar automatico do ultimo backup feito.
   RECOVER DATAFILE '+DATA/orcl_gru1d4/datafile/sysaux.262.1051262669';

   -- Dentro do BD Verificar se tem datafiles offiline.
   SELECT NAME FROM V$DATAFILE WHERE STATUS = 'OFFLINE';

   -- Colocar online o datafile.
   alter database datafile '/sdeop/data/u01/oradata/OPERACAO_0108.dbf' online;

--Verificar quais datafiles e tablespace estão no diskgroup
select FILE_ID,FILE_NAME,TABLESPACE_NAME,BYTES /1024/1024 as MB, status from dba_data_files order by 1; --where FILE_NAME like '%%';

--Criaão de tablespace
create tablespace TS_ORDEM_SERVICO_REST datafile '/u01/ajuri/data1/TS_ORDEM_SERVICO_REST_01.dbf' size 5767m autoextend on next 1g maxsize 32767m;

alter database create datafile '/u01/app/oracle/product/11.2.0/db_1/dbs/UNNAMED00228' as '/u01/ajuri/data1/TS_ORDEM_SERVICO_REST_01.dbf';

create tablespace SIAGRI_INDEX datafile '+DATA' size 5767m autoextend on next 1g maxsize 32767m;


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
where a.group_number=b.group_number and (b.name='DATA')
order by a.group_number, a.disk_number;

--Verifica se é big file
select TABLESPACE_NAME, BIGFILE from dba_tablespaces;

select TABLESPACE_NAME, BIGFILE from dba_tablespaces where tablespace_name='UNDO2'; 

--Verificar datafile da TEMP
compute sum of SIZE on report
col file_name for a60
col bytes for 999999999999
col MAXBYTES for 99999999999999
set pages 30
break on report 
select file_id, file_name,tablespace_name,status, bytes/1024/1024 "SIZE" , AUTOEXTENSIBLE, MAXBYTES/1024/1024/1024 "MAX", INCREMENT_BY
from dba_temp_files
where TABLESPACE_NAME = 'UNDOTBS01'
order by 2
/

3600728M

-- SYSAUX
set linesize 120 
set pagesize 100
COLUMN "Item" FORMAT A25
COLUMN "Space Used (GB)" FORMAT 99999.99
COLUMN "Schema" FORMAT A25
COLUMN "Move Procedure" FORMAT A40
SELECT  occupant_name "Item",
space_usage_kbytes/1048576 "Space Used (GB)",
schema_name "Schema"
FROM v$sysaux_occupants
ORDER BY 1
/

-- criação de tablespace

select dbms_metadata.get_ddl('TABLESPACE','PSAPSR3750') "DDL" from  dual;


CREATE TABLESPACE "PSAPSR3I" DATAFILE '+DATAC3' SIZE 1767M
AUTOEXTEND ON NEXT 10485760 MAXSIZE 32767M
LOGGING ONLINE PERMANENT BLOCKSIZE 8192
EXTENT MANAGEMENT LOCAL AUTOALLOCATE SEGMENT SPACE MANAGEMENT AUTO;

-- criação de tablespace SAP
CREATE TABLESPACE "PSAPSR3I" DATAFILE
'+DATAC3' SIZE 1767m
LOGGING ONLINE PERMANENT BLOCKSIZE 8192
EXTENT MANAGEMENT LOCAL AUTOALLOCATE DEFAULT NOCOMPRESS SEGMENT SPACE MANAGEMENT AUTO
;

-- Ativar criptografia da tablespace de forma Online
ALTER TABLESPACE nome_da_tablespace ENCRYPTION ONLINE USING 'AES256' ENCRYPT;

-- Com tablespace off,
-- 1. Coloque a tablespace offline
ALTER TABLESPACE PSAPSR3I OFFLINE NORMAL;

-- 2. Execute o comando de criptografia
ALTER TABLESPACE PSAPSR3I ENCRYPTION OFFLINE USING 'AES256' ENCRYPT;

-- 3. Volte a tablespace para online
ALTER TABLESPACE PSAPSR3I ONLINE;

----/ / /-----

-- Desabilitar criptografia da tablespace de forma offiline
-- Forma online
ALTER TABLESPACE PSAPSR3I ENCRYPTION ONLINE DECRYPT;

-- 1. Coloque a tablespace offline
ALTER TABLESPACE PSAPSR3I OFFLINE NORMAL;

-- 2. Execute a descriptografia
ALTER TABLESPACE PSAPSR3I ENCRYPTION OFFLINE DECRYPT;

-- 3. Volte a tablespace para online
ALTER TABLESPACE PSAPSR3I ONLINE;




CREATE TABLESPACE "PSAPSR3I" DATAFILE
SIZE 1852833792
LOGGING ONLINE PERMANENT BLOCKSIZE 8192
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
ENCRYPTION USING 'AES128' ENCRYPT DEFAULT
NOCOMPRESS  SEGMENT SPACE MANAGEMENT AUTO

-- criação de tempfiles
alter tablespace temp add tempfile '+TEMP/EQTLINFO/tempfiles/temp0171.dbf' size 65528m;

alter database tempfile 33 resize 12767M;

alter tablespace tmp add tempfile '+data' size 15767m;

alter tablespace temp1 add tempfile '+DATA' size 1767M autoextend on next 1G maxsize 12767M;

alter tablespace PSAPSR3 add datafile '/oracle/IEQ/sapdata2/sr3_102/sr3.data102' size 32767M autoextend on next 1G maxsize 32767M;

ALTER TABLESPACE media RESIZE 100G MAXSIZE 150G;

-- Tablespace RD
SELECT TS.tablespace_name             AS TABLESPACE,
       TS.CONTENTS                    AS TYPE,
       FL.bytes_used                  AS USED_BYTES,
       FL.max_bytes                   AS MAX_BYTES,
       FL.bytes_free                  AS FREE_BYTES,
       Replace(FL.pct_used, ',', '.') AS USED_PCT,
       Decode(TS.status, 'ONLINE', 1,
                         'OFFLINE', 2,
                         'READ ONLY', 3,
                         0)           AS STATUS,
       (SELECT Decode(database_role, 'SNAPSHOT STANDBY', 1,
                                     'LOGICAL STANDBY', 2,
                                     'PHYSICAL STANDBY', 3,
                                     'PRIMARY', 4,
                                     'FAR SYNC', 5,
                                     0) AS ROLE
        FROM   v$database)            AS DATABASE_ROLE
FROM   (SELECT a.tablespace_name,
               Round (a.bytes_alloc)                             bytes_alloc,
               Round (Nvl (b.bytes_free, 0))                     bytes_free,
               Round (( a.bytes_alloc - Nvl (b.bytes_free, 0) )) bytes_used,
               Round (( ( a.bytes_alloc - Nvl (b.bytes_free, 0) ) / a.maxbytes )
                      * 100,
               2)
                                                                 Pct_used,
               Round (maxbytes)                                  MAX_BYTES
        FROM   (SELECT f.tablespace_name,
                       SUM (f.bytes)                                 bytes_alloc
                       ,
                       SUM (
               Decode (f.autoextensible, 'YES', f.maxbytes,
                                         'NO', f.bytes))maxbytes
                FROM   dba_data_files f
                GROUP  BY tablespace_name) a,
               (SELECT f.tablespace_name,
                       SUM (f.bytes) bytes_free
                FROM   dba_free_space f
                GROUP  BY tablespace_name) b
        WHERE  a.tablespace_name = b.tablespace_name(+)
        UNION ALL
        SELECT h.tablespace_name,
               Round (SUM (h.bytes_free + h.bytes_used))
               bytes_alloc,
               Round (SUM (( h.bytes_free + h.bytes_used ) -
                           Nvl (p.bytes_used, 0)))
               bytes_free,
               Round (SUM (Nvl (p.bytes_used, 0)))
               bytes_used,
               Round (( SUM (Nvl (p.bytes_used, 0)) / SUM (
                               Decode (f.autoextensible, 'YES', f.maxbytes,
                                                  'NO', f.bytes)) ) * 100, 2)
               pct_used,
               Round (SUM (Decode (f.autoextensible, 'YES', f.maxbytes,
                                                     'NO', f.bytes)))
               MAX_BYTES
        FROM   sys.gv_$temp_space_header h,
               sys.gv_$temp_extent_pool p,
               dba_temp_files f
        WHERE  p.file_id(+) = h.file_id
               AND p.tablespace_name(+) = h.tablespace_name
               AND p.inst_id(+) = h.inst_id
               AND f.file_id = h.file_id
               AND f.tablespace_name = h.tablespace_name
        GROUP  BY h.tablespace_name)FL
       inner join dba_tablespaces TS
               ON FL.tablespace_name = TS.tablespace_name
ORDER  BY 6; 