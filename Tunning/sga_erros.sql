rem Look at v$sga_dynamic_components (and in 11g the 
rem equivalent v$memory_dynamic_components) for summary
rem view of granule sizes (which implies a future option
rem for varying granule sizes).
rem
rem See also: V$SGA_DYNAMIC_FREE_MEMORY (x$ksge)
 
start setenv
set timing on
set linesize 900
set pagesize 6000
 
column component format a25
column parameter format a30 
 
column initial_size format 99,999,999,999 
column target_size  format 99,999,999,999 
column final_size   format 99,999,999,999 
 
column started_at format a15
column ended_at   format a15
 
prompt  ============
prompt  Full History
prompt  ============
 
select 
        component, 
        oper_type, 
        oper_mode, 
        parameter, 
        initial_size, 
        target_size, 
        final_size, 
        status, 
        to_char(start_time,'dd-mon hh24:mi:ss') started_at, 
        to_char(end_time,'dd-mon hh24:mi:ss')   ended_at 
from 
        v$sga_resize_ops 
where
    initial_size != 0
or  target_size  != 0
or  final_size   != 0
order by 
        start_time 
; 
 
prompt  ==============
prompt  Since midnight
prompt  ==============
 
break on starting_time skip 1
 
column oper_type format     a12
column component format     a25
column parameter format     a22
column timed_at  format     a10
 
select
    to_char(start_time,'hh24:mi:ss') timed_at,
    oper_type,
    component,
    parameter,
    oper_mode,
    initial_size,
    final_size
from
    v$sga_resize_ops
where
    start_time > trunc(sysdate)
order by
    start_time, component
;


-- Problema de erros de resize de SGA
COLUMN PARAMETER FORMAT A30
COLUMN COMPONENT FORMAT A28
COLUMN OPER_MODE FORMAT A24
COLUMN STATUS FORMAT A14
COLUMN START_TIME FORMAT A24
COLUMN END_TIME FORMAT A21
SELECT INST_ID,COMPONENT,PARAMETER,OPER_TYPE AS OPERATION ,INITIAL_SIZE/1024/1024 as INITIAL_SIZE ,TARGET_SIZE/1024/1024 as TARGET_SIZE, FINAL_SIZE/1024/1024 as FINAL_SIZE,STATUS,to_char(START_TIME,'DD/MM/YYYY HH24:MI:SS') START_TIME,TO_CHAR(END_TIME,'DD/MM/YYYY HH24:MI:SS') END_TIME 
FROM GV$SGA_RESIZE_OPS 
WHERE status in ('CANCELLED','ERROR') and
START_TIME > sysdate -10 ORDER BY START_TIME;

-- Problema de erros de resize de SGA completo
column component format a25
column parameter format a30 
column initial_size format 99,999,999,999 
column target_size  format 99,999,999,999 
column final_size   format 99,999,999,999 
column started_at format a15
column ended_at   format a15
select 
        component, 
        oper_type, 
        oper_mode, 
        parameter, 
        initial_size, 
        target_size, 
        final_size, 
        status, 
        to_char(start_time,'dd-mon hh24:mi:ss') started_at, 
        to_char(end_time,'dd-mon hh24:mi:ss')   ended_at 
from v$sga_resize_ops 
where START_TIME > sysdate -1
and initial_size != 0
or target_size  != 0
or final_size   != 0
order by start_time ; 