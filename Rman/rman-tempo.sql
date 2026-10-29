SELECT sid, serial#, opname, sofar, totalwork,
      round(sofar/totalwork*100,2) "% Complete", time_remaining
 FROM v$session_longops
WHERE opname LIKE 'RMAN:%'
  AND opname NOT LIKE 'RMAN: aggregate%'
  AND sofar <> totalwork
  AND totalwork != 0;