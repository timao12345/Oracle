SELECT sid, serial#, opname, start_time, context, sofar, totalwork, round(sofar/totalwork*100,2) "% Complete"
FROM v$session_longops
WHERE opname LIKE 'RMAN:%'
AND opname NOT LIKE 'RMAN: aggregate%'
AND sofar <> totalwork
AND totalwork != 0;
