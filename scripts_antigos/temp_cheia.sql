--Procedimento para realizar a redção da tablespace TEMP
--Verificar a tablespace TEMP
select  sh.tablespace_name, 
        'TEMP',
        SUM(sh.bytes_used+sh.bytes_free)/1024/1024 total_mb,
        SUM(sh.bytes_used)/1024/1024 used_mb,
        SUM(sh.bytes_free)/1024/1024 free_mb,
        ROUND(SUM(sh.bytes_used)/SUM(sh.bytes_used+sh.bytes_free)*100,2) pct_used
FROM v$temp_space_header sh
group by tablespace_name;

--Verifica espaço disponivel na temp
    -- Temporary Tablespace Sort Usage
SET PAUSE ON
SET PAGESIZE 60ORA-1652: unable to extend temp segment by 128 in tablespace
SET LINESIZE 300 
SELECT 
   A.tablespace_name tablespace, 
   D.mb_total,
   SUM (A.used_blocks * D.block_size) / 1024 / 1024 mb_used, D.mb_total - SUM (A.used_blocks * D.block_size) / 1024 / 1024 mb_free
FROM 
   v$sort_segment A,
(
    SELECT 
    B.name, 
    C.block_size, 
    SUM (C.bytes) / 1024 / 1024 mb_total
    FROM 
    v$tablespace B,v$tempfile C
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
   D.mb_total;
/

--Verifica na tabela v$tempseg_usage os usuarios que estão usando a tablespace TEMP, juntamente do SQL_ID, 
   --talvez sejá necessário matar a sessão caso esteja muito tempo inativa. (verificar procedimento "sessões oracle ativas.sql")

set lines 200
col username format a20
select
   username,
   session_addr,
   session_num,
--   sqladdr,
--   sqlhash,
   sql_id,
   contents,
   segtype,
   extents,
   blocks
from
    v$tempseg_usage
order by
   username;


--Verifica os usuarios que estão usando a tablespace com mais detalhe, trazendo tamanho utiliado da tablespace
col SID_N_SERIAL for a10
col USERNAME for a20
col osuser for a20
col MODULE for a25
col program for a30
col SPID for a10
select
   s.sid || ',' || s.serial# sid_n_serial,
   s.username,
   s.osuser,
   p.spid,
   s.module,
   p.program,
   sum (t.blocks) * tbs.block_size / 1024 / 1024 mb_used,
   t.tablespace,
   count(*) nbr_statements
 from
   v$sort_usage    t,
   v$session       s,
   dba_tablespaces tbs,
   v$process       p
 where
   t.session_addr = s.saddr
and
   s.paddr = p.addr
and
   t.tablespace = tbs.tablespace_name
group by
   s.sid,
   s.serial#,
   s.username,
   s.osuser,
   p.spid,
   s.module,
   p.program,
   tbs.block_size,
   t.tablespace
order by 1;

--Verifica os usuarios que estão usando a tablespace com mais detalhe, trazendo tamanho utiliado da tablespace
col tablespace format a10
col status format a10
col sql_id format a14
col TEMP_SIZE format a5
col sid_serial format a15
col username format a20
col program format a30
col status format a10
col instance format 9999999
set pages 10000
SELECT b.tablespace, 
ROUND(((b.blocks*p.value)/1024/1024),2)||'M' AS temp_size, 
a.inst_id as Instance, 
a.sid||','||a.serial# AS sid_serial, 
NVL(a.username, '(oracle)') AS username, 
a.program, 
a.status, 
a.sql_id 
FROM gv$session a, 
gv$sort_usage b, 
gv$parameter p 
WHERE p.name = 'db_block_size' 
AND a.saddr = b.session_addr 
AND a.inst_id=b.inst_id 
AND a.inst_id=p.inst_id 
ORDER BY temp_size asc 
/
--Verificar tamanho dos datafiles
select file_name, file_id, (bytes/1024)/1024 bytes_MB from dba_temp_files;

-- Apos a analise caso seja necessário realizar o comando abaixo.
ALTER TABLESPACE TEMP1 SHRINK SPACE;
ALTER TABLESPACE PSAPTEMP1 SHRINK SPACE KEEP 500767M;

--opção 2, KEEP é o novo valor desejado pra o datafile da tablespace


ALTER TABLESPACE TMP SHRINK TEMPFILE '' KEEP  100M;