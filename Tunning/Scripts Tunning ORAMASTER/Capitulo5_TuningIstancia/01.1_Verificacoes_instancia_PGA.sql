-- Configuracao inicial recomendada para a PGA:
--  para OLTP:  PGA_AGGREGATE_TARGET  = (physical memory * 80%) * 20%
--  para OLAP:  PGA_AGGREGATE_TARGET  = (physical memory * 80%) * 50%

alter session container = cdb$root;

-- 1: descobrir tamanho da PGA
	-- se estiver usando ASMM:
		select name, value, display_value from v$parameter where name = 'pga_aggregate_target';
		-- ou
		show parameter pga_aggregate_target
		
	-- se estiver usando AMM tamanho da PGA esta incluso em memory_target:
		select name, value, display_value from v$parameter where name = 'memory_target';
		-- ou
		show parameter memory_target
  
-- 2: verificar se tamanho atende necessidade do BD. 
	-- "over allocation count" deve ser igual a zero ou um valor muito baixo
	-- "cache hit percentage" deve ser maior que 60% (se bd for oltp e estiver em uso constante)
	 select name, value from v$pgastat;
     
     -- na consulta abaixo se "ESTD_OVERALLOC_COUNT" > 0 no TARGET_MB atual, aumente a PGA 
    SELECT  round(PGA_TARGET_FOR_ESTIMATE/1024/1024) target_mb,
            ESTD_PGA_CACHE_HIT_PERCENTAGE cache_hit_perc,
            ESTD_OVERALLOC_COUNT
    FROM    V$PGA_TARGET_ADVICE;

    SELECT PGA_TARGET_FOR_ESTIMATE,PGA_TARGET_FACTOR, ADVICE_STATUS, ESTD_TIME, ESTD_PGA_CACHE_HIT_PERCENTAGE
    FROM V$PGA_TARGET_ADVICE ORDER BY PGA_TARGET_FACTOR;
    
select component, 
       CURRENT_SIZE/1024/1024 current_size_mb, 
       MIN_SIZE/1024/1024 min_size_mb, 
       max_size/1024/1024 max_size_mb, 
       last_oper_type,
       LAST_OPER_TIME
  from V$MEMORY_DYNAMIC_COMPONENTS
  /


-- total de uso da PGA atual
SELECT (value/1024/1024) CURRENT_PGA_IN_USE_IN_MB FROM V$PGASTAT WHERE NAME ='total PGA inuse';

-- Total alocado para o BD atualmente
SELECT (value/1024/1024) MAX_PGA_ALLOCATED_IN_MB FROM V$PGASTAT WHERE NAME = 'maximum PGA allocated';

-- A partir do 12cR1 eh possivel configurar tamanho limite para a PGA:
alter system set pga_agregate_limit = X;
    
-- alterar o tamanho da PGA - PRECISA REINICIAR BD para entrar em vigor

alter system set pga_aggregate_target=3G scope=spfile;
alter system set pga_aggregate_target=3000M scope=spfile;


-- Mais informacoes: 
    -- http://www.dba-oracle.com/t_v_pgastat.htm
    -- http://docs.oracle.com/cd/B12037_01/server.101/b10752/memory.htm    
    

TARGET_MB CACHE_HIT_PERC ESTD_OVERALLOC_COUNT
---------- -------------- --------------------
       912             93                 9597
      1824            100                    0
      3648            100                    0
      5472            100                    0
      7296            100                    0
      8755            100                    0
     10214            100                    0
     11674            100                    0
     13133            100                    0
     14592            100                    0
     21888            100                    0
     29184            100                    0
     43776            100                    0
     58368            100                    0

-- Verifica quem está consumindo PGA
SELECT spid, program, round(pga_max_mem/1024/1024) max_MB, round(pga_alloc_mem/1024/1024)alloc_MB, round(pga_used_mem/1024/1024) used_MB, round(pga_freeable_mem/1024/1024) free_MB FROM V$PROCESS ORDER BY 3 asc;

-- Verifica quem esta consumindo PGA tirando os processsos de background
SELECT sum(p.pga_max_mem)/1024/1024 "PGA MAX USER SESSION (MB)" FROM v$process p, v$session s WHERE P.ADDR = S.paddr and s.username IS NOT NULL;

-- Retorna a sessão que eta consumindo pga e a quantidade
SELECT s.username, p.pga_max_mem/1024/1024 "PGA USER SESSION (MB)", q.sql_text, s.sql_id FROM v$process p, v$session s, v$SQL q WHERE P.ADDR = S.paddr AND s.username IS NOT NULL AND s.sql_id = q.sql_id ORDER BY 2;


-- Consulta retorna sessões ativas consumindo PGA
compute sum of CURRENT_SIZE on report
compute sum of MAXIMUM_SIZE on report
column CURRENT_SIZE format 999,999,999.99
column MAXIMUM_SIZE format 999,999,999.99
col SESSION for a60
break on report 
SELECT to_char(ssn.sid, '9999') || ' - ' || nvl(ssn.username, nvl(bgp.name, 'background')) || nvl(lower(ssn.machine), ins.host_name) "SESSION", ssn.USERNAME,
to_char(prc.spid, '999999999') "PID/THREAD",
se1.value/1024/1024  as CURRENT_SIZE,
se2.value/1024/1024 as MAXIMUM_SIZE
FROM v$sesstat se1, v$sesstat se2, v$session ssn, v$bgprocess bgp, v$process prc,
v$instance ins, v$statname stat1, v$statname stat2
WHERE se1.statistic# = stat1.statistic# and stat1.name = 'session pga memory'
AND se2.statistic# = stat2.statistic# and stat2.name = 'session pga memory max'
AND se1.sid = ssn.sid
AND se2.sid = ssn.sid
AND ssn.paddr = bgp.paddr (+)
AND ssn.paddr = prc.addr (+)
order by CURRENT_SIZE ASC
/

-- Verifica sessões ativas consumindo PGA.
SET LINES 400
SET PAGES 60
COL OSUSER FORMAT A15
COL USERNAME FORMAT A15
COL MACHINE FORMAT A20 trunc
COL PROGRAM FORMAT A20 trunc
COL SPID FORMAT A10
COL MODULE FORMAT A15
COL pga_used_mem heading "PGA Used" format 999,999,999,999
COL pga_alloc_mem heading "PGA Allocated" format 999,999,999,999
COL pga_freeable_mem heading "PGA Freeable" format 999,999,999,999
COL pga_max_mem heading "PGA Max Used" format 999,999,999,999
SELECT * FROM (
SELECT S.INST_ID,
       S.SID, 
       s.SERIAL#,
       p.SPID,
       s.OSUSER, 
       s.USERNAME, 
       s.MACHINE, 
       s.PROGRAM,      
       s.status,
       s.sql_id,
       p.pga_used_mem/1024/1024 AS pga_used_mem, 
       p.pga_alloc_mem/1024/1024 AS pga_alloc_mem, 
       p.pga_freeable_mem/1024/1024 AS pga_freeable_mem, 
       p.pga_max_mem/1024/1024 AS pga_max_mem
from gv$session s, gv$process p
where s.inst_id=p.inst_id
and s.paddr = p.addr
AND s.type <> 'BACKGROUND'
AND s.inst_id=&NODE
order by pga_max_mem desc
) WHERE ROWNUM <=50;