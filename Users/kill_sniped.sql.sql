SELECT DECODE(TRUNC(SYSDATE - LOGON_TIME), 0, NULL, TRUNC(SYSDATE - LOGON_TIME) || ' Days' || ' + ') || TO_CHAR(TO_DATE(TRUNC(MOD(SYSDATE-LOGON_TIME,1) * 86400), 'SSSSS'), 'HH24:MI:SS') LOGON, SID, v$session.SERIAL#, v$process.SPID UNIX_PROCESS, v$session.USERNAME, STATUS, OSUSER, MACHINE, v$session.PROGRAM, MODULE, 'alter system kill session ' || '''' || SID || ', ' || v$session.serial# || '''' || ' immediate;' kill_sql FROM v$session, v$process 
WHERE ((v$session.paddr = v$process.addr) AND (status = 'SNIPED')) 
ORDER BY logon_time ASC;

