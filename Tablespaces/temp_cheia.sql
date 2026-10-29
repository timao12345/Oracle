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
SET PAGESIZE 60
SET LINESIZE 300 
SELECT 
   A.tablespace_name tablespace, 
   D.mb_total,
   SUM (A.used_blocks * D.block_size) / 1024 / 1024 mb_used, D.mb_total - SUM (A.used_blocks * D.block_size) / 1024 / 1024 mb_free
FROM 
   gv$sort_segment A,
(
    SELECT 
    B.name, 
    C.block_size, 
    SUM (C.bytes) / 1024 / 1024 mb_total
    FROM 
    v$tablespace B,gv$tempfile C
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


SELECT sysdate,a.username, a.sid, a.serial#, a.osuser, b.blocks, c.sql_text
FROM gv$session a, gv$sort_usage b, gv$sqlarea c
WHERE b.tablespace = 'TEMP'
and a.saddr = b.session_addr
AND c.address= a.sql_address
AND c.hash_value = a.sql_hash_value
AND b.blocks* 8192 > 10000
ORDER BY b.tablespace, b.blocks;

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
    gv$tempseg_usage
order by
   username;


--Verifica os usuarios que estão usando a tablespace com mais detalhe, trazendo tamanho utiliado individualmente da tablespace TEMP
-- Sessões consumidoras de temp
col SID_N_SERIAL for a13
col USERNAME for a20
col osuser for a20
col MODULE for a25
col program for a45
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
   gv$sort_usage    t,
   gv$session       s,
   dba_tablespaces tbs,
   gv$process       p
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
order by
   7;

-- Sessões consumidoras de temp
SELECT a.inst_id,b.tablespace,to_char(a.LOGON_TIME,'DD-MM-YY hh24:mi') data,
      ROUND(((b.blocks*p.value)/1024/1024),2)||'M' "SIZE",
      a.sid||','||a.serial# SID_SERIAL,
      a.username,
      a.program
   FROM sys.gv_$session a,
      sys.gv_$sort_usage b,
      sys.gv_$parameter p
WHERE a.inst_id=b.inst_id
and a.inst_id=p.inst_id
and      p.name  = 'db_block_size'
   AND a.saddr = b.session_addr
ORDER BY b.tablespace, b.blocks;

-- Sessões consumidoras de temp
SELECT * FROM(
SELECT
  S.SID                SID
 , S.SERIAL#            SERIAL_ID
 , S.INST_ID
 , LPAD(S.STATUS,9)     SES_STAT
 , LPAD(S.USERNAME,12)  ORA_USER
 , LPAD(S.OSUSER,9)     OS_USER
 , LPAD(P.SPID,7)       OS_PI
 , S.PROGRAM            SES_PRO
 , S.MACHINE
 , S.SECONDS_IN_WAIT
 , S.SQL_ID                             SQL_ID
 , ROUND(SUM (T.BLOCKS) * TBS.BLOCK_SIZE / 1024 / 1024 / 1024,3) GB_USED
 FROM     GV$SORT_USAGE T, GV$SESSION S, DBA_TABLESPACES TBS, GV$PROCESS P
 WHERE    T.INST_ID = S.INST_ID
 AND      T.SESSION_ADDR = S.SADDR
 AND S.INST_ID = P.INST_ID
 AND      S.PADDR = P.ADDR
 AND      T.TABLESPACE = TBS.TABLESPACE_NAME
 GROUP BY S.SID,S.SERIAL#,S.INST_ID,LPAD(S.STATUS,9),LPAD(S.USERNAME,12),LPAD(S.OSUSER,9),LPAD(P.SPID,7),S.PROGRAM,S.MACHINE,S.SECONDS_IN_WAIT,S.SQL_ID, TBS.BLOCK_SIZE
 ORDER BY GB_USED DESC) WHERE ROWNUM<=20;

--Verificar tamanho dos datafiles
select file_name, file_id, (bytes/1024)/1024 bytes_MB from dba_temp_files;

-- Apos a analise caso seja necessário realizar o comando abaixo, KEEP é o novo valor desejado pra que a tablespace fique.
-- Reduza a tablespace TEMP para o menor tamanho possível sem reduzir o tempfile:
ALTER TABLESPACE TEMP SHRINK SPACE;

--Reduza o Tablespace TEMP usando o comando alter tablespace e deixando do tamanho desejado com KEEP (reduz o tempfile travando a TEMP enquando o comando estiver em execução.)
ALTER TABLESPACE PSAPTEMP1 SHRINK SPACE KEEP 150G;
--Reduza TEMPFILE usando o comando alter tablespace diretamente no tempfile desejado.
ALTER TABLESPACE TEMP_1 SHRINK TEMPFILE '+DATAC1/RDP/TEMPFILE/temp_1.794.1148942755' KEEP 1500728m;


-- Nas versões 10g para baixo fazer resize direntamente no tempfile
alter database tempfile '+DATAC1/MTZBISTD/TEMPFILE/temp.401.1105275075' resize 3000728M;

-- obs:
O cenario ideal é usar o comando 'ALTER TABLESPACE TEMP SHRINK SPACE;' para não indisponibilizar a TEMP, e em um periodo mais tranquilo executar o comando com KEEP caso seja necessário diminuir o datafile,
geralmente não é tão recomendado em ambientes produtivos reduzir muito a TEMP pois o banco tera que aumentar novamente consumindo recursos do BD e tempo.