-- Longops IMPDP
SELECT sid, serial#, context, sofar, totalwork, round(sofar/totalwork*100,2) "% Complete"
FROM v$session_longops
WHERE opname LIKE '%SYS_IMPORT_SCHEMA_01%'
AND sofar <> totalwork
AND totalwork != 0;