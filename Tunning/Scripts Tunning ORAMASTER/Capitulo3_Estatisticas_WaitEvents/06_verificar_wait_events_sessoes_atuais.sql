-- *** ATENCAO: ANTES DE EXECUTAR ESTE SCRIPT, INICIE UM TESTE DE STRESS COM O SWINGBENCH

-- ver WE atuais das sessoes de usuarios
SELECT      sw.SID, s.username, sw.EVENT, sw.SECONDS_IN_WAIT, ROUND( sw.SECONDS_IN_WAIT / 60, 2) MIN_IN_WAIT
FROM        V$SESSION_WAIT sw
join        v$session s
   on       sw.sid = s.sid
   where    s.username is not null
ORDER BY    sw.SECONDS_IN_WAIT DESC;

-- consultar sessoes em espera x processos SO:
SELECT      T1.SPID AS PROCESSO_SO,
            t2.sid SESSION_ID,
            t2.serial# SESSION_SERIAL, 
            t2.program as PROGRAMA,
            t2.username as USUARIO_BD,
            t2.osuser as USUARIO_SO,
            to_char(t2.logon_time, 'DD/MM/YYYY HH24:MI:SS') AS DATA_HORA_LOGIN,
            ROUND(t2.last_call_et / 60, 2) as time_last_call,
            TO_CHAR(SYSDATE - (1 /24/60/60 * last_call_et),'dd/mm/yy hh24:mi:ss') last_call_time,
            t2.seconds_in_wait as WAIT_SECONDS, 
            t2.action,
            t2.machine as MACHINE
FROM        v$process t1
INNER JOIN  v$session t2
    ON      t1.addr = t2.paddr
where       t2.seconds_in_wait > 0;

-- Verificar maiores wait events que ocorreram nas sessoes atuais (descartando "idle wait events")
SELECT      en.wait_class,
            se.EVENT,            
            (sum(time_waited) / 100) total_time_waited_sec,
            round( (sum(time_waited) / 100) / 60, 2) total_time_waited_min,
            SUM(TOTAL_WAITS) total_waits
FROM        V$SESSION_EVENT se
JOIN        v$event_name en
    on      se.event = en.name
where       en.wait_class <> 'Idle'
GROUP BY    en.wait_class, se.event
order by    total_time_waited_sec desc;