-- Gera plano de execução
explain plan for 
    select * from fornecedor.produtos_estoque;
select * from table (dbms_xplan.display);

-- Retorna plano de execução a partir do SQL_ID
set lines 600
set pages 5000
select * from table (dbms_xplan.display_cursor('3zjkrh6722470',format => 'ADVANCED'));

-- Retorna informações de consumo de recursos da query, tempo de execução, CPU etc.
col CPU_TIME for 99999999999999
col HASH_VALUE for 99999999999999
col PLAN_HASH_VALUE for 99999999999999
col OLD_HASH_VALUE for 99999999999999
col EXECUTIONS for 99999999999999
select 
    SQL_ID,
    --SQL_PLAN_BASELINE,
    --SQL_PROFILE,
    to_char(ELAPSED_TIME/1000, '999,999,999.000') AS TIME,
    --PLSQL_EXEC_TIME,
    to_char(LAST_ACTIVE_TIME,'DD-MM-YY HH24:MI:SS') as LAST_EXECUTE, 
    CPU_TIME,
    --PHYSICAL_READ_BYTES,
    --PHYSICAL_WRITE_BYTES,
    HASH_VALUE,
    PLAN_HASH_VALUE,
    OLD_HASH_VALUE,
    EXECUTIONS
from v$sql 
where 
PLAN_HASH_VALUE= 4028776760 
--SQL_ID='1gxuagwf1yc7a'
order by LAST_ACTIVE_TIME asc;

-- verificar tempo de execução da query
col SQL_TEXT for a100
col MODULE for a15
set lines 1000
select * from (
  select LAST_LOAD_TIME, to_char(ELAPSED_TIME/1000, '999,999,999.000') || ' ms' as TIME,
         MODULE, SQL_TEXT from V$SQL
    where SQL_ID ='3zjkrh6722470'
    order by LAST_LOAD_TIME desc
  ) where ROWNUM <= 5;



explain plan for 
select /* + index (a TB_NFEESTORNO_PK)*/ a.nroempresa,
       a.seriedocto,
       a.nronotafiscal,
       a.ativo,
       a.nrocarga,a.seriedocto||'|'|| a.nronotafiscal||'|'|| b.nrocheckout||'|'|| b.seqdocto||'|'|| a.ativo||'|' linha
from tb_nfeestorno a, tb_doctocupom b
 where b.nroempresa = a.nroempresa and a.seriedocto = b.seriedocto and b.nronotafiscal = a.nronotafiscal;
