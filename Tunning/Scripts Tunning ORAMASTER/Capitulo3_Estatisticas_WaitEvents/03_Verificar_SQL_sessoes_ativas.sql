alter session set container=pdbxe;

-- ver SQL de sessoes ativas:
-- Retorna dados das sessoes ativas e seus respectivos SQLs, junto com o hash_value e cursor_id do plano de execucao sendo utilizado
SELECT          /*+ ALL_ROWS */
                p.spid, -- id do processo no SO
                a.sid,
                a.serial#, -- identifica objeto de sessao, util para distinguir objeto quando uma sessao possui o mesmo sid de uma sessao anterior
                a.program,    
                a.username,  
                B.SQL_ID, b.child_number,
                b.optimizer_cost,
                b.SQl_PLAN_BASELINE,
                a.status,  -- active, inactive, killed (marcada p/ finalizar), cached (temporiaramente em cache p/ uso pelo Oracle XA), sniped (inativa, esperando no cliente)
                to_char(a.logon_time, 'DD-MON-YYYY HH24:MI:SS') as logon_time,
                to_char(sysdate - last_call_et / 86400,'DD-MON-YYYY HH24:MI:SS') as last_activity,
                a.osuser,
                a.machine,                
                b.cpu_time/(1000000) as cpu_time,
                b.executions,
                b.elapsed_time/(1000000) as elapsed_time,
                case 
                    when b.executions > 0 then (b.elapsed_time/(1000000))  / b.executions 
                    else 0
                end as elapsed_time_per_exec,     
                b.parse_calls,
                b.loads, -- num. de X q o objeto foi lido ou relido
                b.rows_processed,
                b.open_versions, -- num. de cursores abertos
                b.users_opening, -- num. de usuarios com cursores abertos                
                b.buffer_gets,
                b.disk_reads,                
                --round(((c.CONSISTENT_GETS+c.BLOCK_GETS-c.PHYSICAL_READS) / (c.CONSISTENT_GETS+c.BLOCK_GETS) * 100),2) Ratio,
                b.application_wait_time/(1000000) as application_wait_time_sec,
                b.concurrency_wait_time/(1000000) as concurrency_wait_time_sec,
                b.user_io_wait_time/(1000000) as user_io_wait_time_sec,                          
                b.OPTIMIZER_MODE,                
                (b.sharable_mem + b.persistent_mem + b.runtime_mem) /1024/1024 "used_memory (mb)",                
                b.first_load_time,
                B.PLAN_HASH_VALUE,
                --SP.COST AS PLAN_SQL_TOTAL_COST,
                --SP.CHILD_NUMBER AS PLAN_CHILD_NUMBER,
                sc.SQL_TYPE_MISMATCH,
                sc.OPTIMIZER_MISMATCH,
                sc.STATS_ROW_MISMATCH,
                sc.LITERAL_MISMATCH,
                sc.FORCE_HARD_PARSE,
                sc.TYPECHECK_MISMATCH,
                sc.AUTH_CHECK_MISMATCH,
                sc.BIND_MISMATCH,
                sc.DESCRIBE_MISMATCH,
                sc.BIND_EQUIV_FAILURE,
                SC.ROLL_INVALID_MISMATCH,
                SC.LOAD_OPTIMIZER_STATS,
                SC.USE_FEEDBACK_STATS,
                sc.PURGED_CURSOR,
                dbms_lob.substr(sc.REASON, 4000, 1) as reason,
                B.IS_BIND_SENSITIVE,
                B.IS_BIND_AWARE,
                b.SQL_TEXT,
                listagg(bc.value_string, ', ' ) within group (order by BC.POSITION) AS SQL_BIND_VALUES,
                a.event, A.SECONDS_IN_WAIT
FROM            V$SESSION A
LEFT JOIN       V$PROCESS P
    ON          a.PADDR = P.ADDR
left join       v$sql b
    on          a.sql_address = b.address
    and         a.sql_hash_value = b.hash_value       
    and         a.sql_child_number = b.child_number
--LEFT JOIN       V$SQL_PLAN sp
    --on          sp.SQL_ID = b.sql_id
    --and         sp.PLAN_HASH_VALUE = b.PLAN_HASH_VALUE
    --and         sp.id = 0
LEFT join       v$sess_io c
    ON          A.SID = C.SID
LEFT JOIN       v$sql_bind_capture bC
    ON          b.address = bc.address
    AND         b.hash_value = bc.hash_value
left join       V$SQL_SHARED_CURSOR sc
    on          sc.SQL_ID = a.SQL_ID    
    and         sc.child_number = b.child_number
WHERE           a.status = 'ACTIVE'
and             a.username is not null
GROUP BY        p.spid, 
                a.sid, 
                a.serial#, 
                a.program,    
                a.username,  
                a.status,                
                a.osuser,                
                a.machine,                    
                to_char(a.logon_time, 'DD-MON-YYYY HH24:MI:SS'),
                to_char(sysdate - last_call_et / 86400,'DD-MON-YYYY HH24:MI:SS'),
                b.executions,
                b.loads, 
                b.rows_processed,
                b.open_versions,
                b.users_opening,
                b.first_load_time,            
                b.parse_calls,
                b.disk_reads,
                b.buffer_gets,                
                b.application_wait_time/(1000000),
                b.concurrency_wait_time/(1000000),
                b.user_io_wait_time/(1000000),
                b.optimizer_cost,
                b.SQl_PLAN_BASELINE,
                b.OPTIMIZER_MODE,
                b.cpu_time/(1000000),
                b.elapsed_time/(1000000),
                case 
                    when b.executions > 0 then (b.elapsed_time/(1000000))  / b.executions 
                    else 0
                end,
                (b.sharable_mem + b.persistent_mem + b.runtime_mem) /1024/1024,
                B.SQL_ID, b.child_number,
                B.PLAN_HASH_VALUE,     
                --SP.COST,
                --SP.CHILD_NUMBER,
                sc.SQL_TYPE_MISMATCH,
                sc.OPTIMIZER_MISMATCH,
                sc.STATS_ROW_MISMATCH,
                sc.LITERAL_MISMATCH,
                sc.FORCE_HARD_PARSE,
                sc.TYPECHECK_MISMATCH,
                sc.AUTH_CHECK_MISMATCH,
                sc.BIND_MISMATCH,
                sc.DESCRIBE_MISMATCH,
                sc.BIND_EQUIV_FAILURE,
                SC.ROLL_INVALID_MISMATCH,
                SC.LOAD_OPTIMIZER_STATS,
                SC.USE_FEEDBACK_STATS,
                sc.PURGED_CURSOR,
                dbms_lob.substr(sc.REASON, 4000, 1),
                B.IS_BIND_SENSITIVE,
                B.IS_BIND_AWARE,
                b.SQL_TEXT,
                a.event,
                A.SECONDS_IN_WAIT
order by        a.sid, B.SQL_ID, b.child_number ;

-- ver consumo de CPU por sessao:
Select    username,v.sid||','||v.serial# sid_session,round((s.value/y.value)*100,2) cpu_used_percentage
from      v$session v, v$sesstat s,v$sysstat y
where     v.username is not null
and       v.sid = s.sid
and       s.statistic#=y.statistic#
and       y. name = 'CPU used by this session'
Order by  3 desc;

-- ver qtde e tamanho das sessoes por usuario:
SELECT      NVL(A.USERNAME,'(oracle)') AS USERNAME,
            a.module,
            A.PROGRAM,
            SUM(DECODE(A.SERVER,'DEDICATED',1,0)) AS TOTAL_DEDICATED,
            SUM(DECODE(A.SERVER,'DEDICATED',0,1)) AS TOTAL_SHARED,
            ROUND(SUM(DECODE(A.SERVER,'DEDICATED',B.VALUE,0))/1024/1024,2) AS MB_MEMORY_PGA,
            ROUND(SUM(DECODE(A.SERVER,'DEDICATED',0,B.VALUE))/1024/1024,2) AS MB_MEMORY_LARGEPOOL
            ,COUNT(NVL(A.USERNAME,'(oracle)')) AS QTD_SESSIONS
FROM        V$SESSION A
INNER JOIN  V$SESSTAT B
    ON      a.sid = b.sid
INNER JOIN  V$STATNAME C
    ON      B.STATISTIC# = C.STATISTIC#
WHERE       C.NAME = 'session pga memory' 
GROUP BY    NVL(A.USERNAME,'(oracle)'),
            A.MODULE,
            A.PROGRAM
ORDER BY    ROUND(SUM(B.VALUE)/1024/1024,2) DESC;

-- matar sessoes de um usuario a partir do processo no SO (pegue o resultado e execute-o no prompt de comandos do SO)
SELECT        'kill -9 ' || P.SPID
FROM          V$SESSION S
INNER JOIN    V$PROCESS P
    ON        S.PADDR = P.ADDR
where         S.username = UPPER('&USERNAME');

-- ver sessoes bloqueadas X bloqueadoras (com comando para matar a bloqueadora):
with s as (select * from v$session),
     l as (select * from v$lock),
     sq as (select * from v$sqlarea)
          
select      s1.username || '@' || s1.machine 
                || ' ' || s1.program
                || ' ( SID=' || s1.sid || ' )  is blocking '
                || s2.username || '@' || s2.machine || ' ' || s2.program || ' ( SID=' || s2.sid || ' ) '
                || ' SQL 1: ' || sql1.sql_text
                || ' SQL 2: ' || sql2.sql_text AS blocking_status,
                s2.wait_time time_waiting,
                'ALTER system KILL SESSION '''||s1.sid || ',' ||s1.serial# ||''' IMMEDIATE;',
                'ALTER system KILL SESSION '''||s2.sid || ',' ||s2.serial#||''' IMMEDIATE;'
from        l l1
inner join  s s1
    on      s1.sid=l1.sid
inner join  l l2
    on      l1.id1 = l2.id1
    and     l1.id2 = l2.id2                   
inner join  s s2
    on      s2.sid=l2.sid
left join   sq sql1
    on       s1.sql_hash_value = sql1.hash_value  
left join   sq sql2
    on       s2.sql_hash_value = sql2.hash_value  
where       l1.BLOCK=1 and l2.request > 0
order by    s2.wait_time;

--- eliminar SQLs em execucao de um usuario especifico:
SET SERVEROUTPUT ON
BEGIN
    -- elimina SQLS de sessões de um determinado usuário conectado no BD
    DBMS_OUTPUT.ENABLE(NULL);
    FOR CUR_TAB IN (SELECT  SID, 
                            USERNAME,                            
                            'ALTER SYSTEM CANCEL SQL ''' || SID || ', ' || SERIAL# || '''' as cmd
                    FROM    V$SESSION 
                    WHERE   USERNAME = UPPER('&USER')
                    AND     USERNAME IS NOT NULL) LOOP
        BEGIN
          EXECUTE IMMEDIATE CUR_TAB.CMD;
          dbms_output.put_line('O SQL da sessão ' || CUR_TAB.SID || ' do usuário ' ||  CUR_TAB.USERNAME || ' foi cancelado!');
        EXCEPTION
          WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao cancelar o SQL da sessão ' || CUR_TAB.SID || '. ' || SQLERRM);
        END;
    END LOOP;
END;


