

SET LINES 160
SET PAGES 200
COL HOST_NAME FORMAT A20
col INITIAL_ALLOCATION format a19
col LIMIT_VALUE format a12

alter session set nls_date_format = 'dd/mm/yyyy hh24:mi:ss';

PROMPT
PROMPT Informações da Instancia:
PROMPT

select instance_name, startup_time from v$instance;

PROMPT
PROMPT Parametros de Banco de Dados:
PROMPT

show parameter sga_max_size
show parameter sga_target
show parameter pga_aggregate_target
show parameter processes
show parameter sessions

PROMPT
PROMPT Sessoes conectadas nas instâncias:
PROMPT

SELECT INST_ID, COUNT(*) QTY
FROM GV$SESSION
GROUP BY INST_ID
ORDER BY INST_ID;

PROMPT
PROMPT Uso de Limite de Recursos:
PROMPT

select * from v$resource_limit;

PROMPT
PROMPT Informações de PGA:
PROMPT

show parameter workarea_size_policy

select name Statistic, value
from v$sysstat
where name LIKE '%workarea%';

select * from v$pgastat;

PROMPT
PROMPT Uso medio de memoria por processo:
PROMPT

select (tpga.value/proc.value)/1024/1024 mem_proc_mb
from v$pgastat tpga, v$pgastat proc
where tpga.name = 'total PGA allocated'
and	  proc.name = 'process count';

PROMPT
PROMPT Informações de componentes da SGA:
PROMPT

PROMPT
PROMPT Library Cache:
PROMPT

select namespace, gethitratio, gets, gethits, pinhitratio, pins, reloads, invalidations
from v$librarycache;

PROMPT
PROMPT Reload Ratio: - reloads (qtd de vezes reparseado) / pins (qtd executes)
PROMPT

col "Reload Ratio" format 999999999.9999999999
select (sum(reloads)/sum(pins)) "Reload Ratio"
from v$librarycache;

PROMPT
PROMPT Dictionary Cache:
PROMPT

SELECT 1 - (SUM(getmisses)/SUM(gets)) "Data Dictionary Hit Ratio"
FROM v$rowcache;

PROMPT
PROMPT Shared pool reserved area:
PROMPT

show parameter shared_pool_reserved_size

select request_misses, request_failures, free_space from v$shared_pool_reserved;

PROMPT
PROMPT Buffer Cache Hit Ratio:
PROMPT

select 1 - (p.value - d.value - l.value)/s.value "Buffer Cache Hit Ratio"
from v$sysstat p, v$sysstat d, v$sysstat l, v$sysstat s
where 	lower(p.name) = 'physical reads'
and 	lower(d.name) = 'physical reads direct'
and 	lower(l.name) = 'physical reads direct (lob)'
and 	lower(s.name) = 'session logical reads';

PROMPT
PROMPT estatisticas Non-hit ratio:
PROMPT

SELECT name, value
FROM v$sysstat
WHERE name IN ('free buffer inspected')
UNION
SELECT event, total_waits
FROM v$system_event
WHERE event in ('free buffer waits','buffer busy waits');


PROMPT
PROMPT Tuning Redo Log Buffer:
PROMPT

col "Redo Log Buffer Retry Ratio" format 9999.999999999999999999999999
SELECT retries.value/entries.value "Redo Log Buffer Retry Ratio"
FROM v$sysstat retries, v$sysstat entries
WHERE retries.name = 'redo buffer allocation retries'
AND entries.name = 'redo entries';

PROMPT
PROMPT Tuning Checkpoint: avg wait em centesimos de segundo. valores crescentes indicam tuning de checkpoint:
PROMPT

SELECT event, total_waits, average_wait
FROM v$system_event
WHERE event LIKE '%check%' OR event like '%log file switch%';

PROMPT
PROMPT Tuning Redo log file:
PROMPT

SELECT event, total_waits, average_wait
FROM v$system_event
WHERE 	event = 'log file switch completion'
OR 		event = 'log file parallel write';



PROMPT
PROMPT Tuning Segment IO:
PROMPT

PROMPT
PROMPT Monitoracao de tabelas prestes a necessitar de alocacao de extent:
PROMPT

SELECT owner, table_name, 1-(empty_blocks/(empty_blocks+blocks)) "% Blocks Used"
FROM dba_tables
WHERE owner != 'SYS'  AND 1-(empty_blocks/(empty_blocks+blocks)) > .95
ORDER BY 1;


PROMPT
PROMPT Ordenação em memória:
PROMPT

select mem.value/(disk.value + mem.value) "In-memory Sort Ratio"
from v$sysstat mem, v$sysstat disk
where mem.name = 'sorts (memory)'
and disk.name = 'sorts (disk)';


PROMPT
PROMPT Medindo contenção em Rollback segment header: (idealmente, os valor do average_wait deveria ser consistentemente próximo a zero). undo segment tx slot
PROMPT

SELECT event, total_waits, time_waited, average_wait
FROM v$system_event
WHERE event like '%undo%';

PROMPT
PROMPT Inclui o número de vezes que usuários tiveram que esperar por acesso ao block reader de segmentos de rollback.
PROMPT Para 'undo header' e 'system undo header' estas esperar devem ser consistentemente próximos a zero.
PROMPT

PROMPT
PROMPT Undo Header Contention:
PROMPT

SELECT class, count
FROM v$waitstat
WHERE class IN ('undo header', 'system undo header');

PROMPT
PROMPT abaixo, usando v$rollstat, Oracle recomenda para OLTP ter 'rollback segment header get ratio' de 95% ou maior para todos os segmentos de roolback:
PROMPT

SELECT n.name, s.usn, DECODE(s.waits, 0, 1, 1-(s.waits/s.gets)) "RBS Header Get Ratio"
FROM v$rollstat s, v$rollname n
WHERE s.usn = n.usn
ORDER BY usn;


SELECT class, count
FROM v$waitstat
WHERE class IN ('undo block', 'system undo block');



-- todas as sessões com processo de rollback: (used_ublk: qtd de blocos undo usados)

set lines 180
col username format a14
col machine format a16
col program format a16
SELECT s.sid, s.serial#, s.username, s.machine, s.program, s.status, s.logon_time, t.used_ublk, t.used_urec  
FROM v$session s, v$transaction t
WHERE s.taddr=t.addr;


-- 1. 	Execução query.....................:	used_ublk = used_1
-- 2. 	Execução query (60 segundos depois):	used_ublk = used_2
-- 3.	Tempo para finalizar...............:	(used_2 / ( used_1 - used_2 ))	= time_remaining (em minutos)


--

SELECT s.osuser, s.username, t.used_ublk
FROM v$session s, v$transaction t
WHERE s.taddr = t.addr;

-- se for verificar large transactions, mais dificil pela query acima. usa-se a debaixo:

SELECT n.name, s.usn, s.writes
FROM v$rollname n, v$rollstat s
WHERE n.usn = s.usn 	AND name != 'SYSTEM';

-- Latch Contention:

SELECT event, total_waits, time_waited
FROM v$system_event
WHERE event = 'latch free';

-- Identificando quais latchs:

SELECT name "Willing to Wait Latch", gets, misses, wait_time
FROM v$latch
WHERE misses != 0;

-- Free List Contention - medindo:

SELECT event, total_waits
FROM v$system_event
WHERE event = 'buffer busy waits';

-- > 0, está ocorrendo free list contention:

SELECT class, count
FROM v$waitstat
WHERE class IN ('free list', 'segment header');

-- Identificar segmentos com Free List Contention com V$SESSION_WAIT e DBA_SEGMENTS:

SELECT s.segment_name, s.segment_type, s.freelists
FROM dba_segments s, v$session_wait w
WHERE w.p1 	= s.header_file
AND w.p2 	= s.header_block
AND w.event = 'buffer busy waits';

PROMPT
PROMPT Locks:
PROMPT

PROMPT
PROMPT Sessões esperando por qualquer lock:
PROMPT

select event,  p1,  p2,  p3
from v$session_wait
where wait_time = 0 and event = 'enqueue';

PROMPT
PROMPT Sessões esperando por lock TX:
PROMPT

select sid,  p1raw,  p2,  p3
from v$session_wait
where wait_time = 0 and event = 'enq: TX - row lock contention';

PROMPT
PROMPT Sessões esperando por TX lock:
PROMPT

select * from v$lock where type = 'TX' and request > 0;

PROMPT
PROMPT Sessões mantendo TX lock:
PROMPT

SELECT * FROM v$lock WHERE type='TX' AND lmode > 0;



