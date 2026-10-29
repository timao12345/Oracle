alter session set container = pdbxe;

-- VER top WAIT EVENTS POR CLASSE
select    wait_class, total_waits, sum(time_waited)/100 as total_sec, ROUND( sum(time_waited)/sum(total_waits)/100 , 2) as event_sec
FROM      V$SYSTEM_WAIT_CLASS
GROUP BY  WAIT_CLASS, total_waits
order by  2 desc;

-- ver TOP WAIT EVENTS POR Application E Concurrency
select      a.event, a.total_waits, a.time_waited, a.average_wait
from        v$system_event a, v$event_name b, v$system_wait_class c
where       a.event_id=b.event_id
and         b.wait_class#=c.wait_class#
AND         C.WAIT_CLASS IN ('Application','Concurrency')
order by    average_wait desc;

-- Ver lock em nivel de linha. Analisar se tempo de espera eh alto
select 	wait_class, event, time_waited / 100 time_secs
from 	v$system_event e
where 	e.wait_class <> 'Idle' AND time_waited > 0
and    	event LIKE 'enq: TX - row lock contention'
union
select 	'Time Model', stat_name NAME,
		round((value / 1000000), 2) time_secs
from 	v$sys_time_model
WHERE 	STAT_NAME NOT IN ('background elapsed time', 'background cpu time') 
and    	stat_name LIKE 'enq: TX - row lock contention'
order by 3 desc;


-- V$SYS_TIME_MODEL: Contem estatisticas acumuladas de varias operacoes de todo o sistema