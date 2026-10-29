col sid for 999999
col serial# for 999999
col message for a60
col sofar for 99999999999
SELECT SID, serial#,
		TO_CHAR(start_time,'dd/mm/yyyy hh24:mi:ss') start_time, message,
		sofar, totalwork, ROUND(sofar/totalwork*100,2) "% Complete", 
		TO_CHAR(START_TIME+((sysdate-start_time)*100/(sofar/totalwork*100)),
		'dd/mm/yyyy hh24:mi:ss') as prev_finish
	FROM gv$session_longops
    WHERE opname LIKE 'RMAN%'
	AND opname NOT LIKE 'aggregate%'
	AND totalwork != 0
	AND sofar <> totalwork order by sid;

