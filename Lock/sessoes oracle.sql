column idle format a10
column logon_time  format a22
SELECT INST_id,sid, osuser, username, status,
       TO_CHAR(logon_time, 'DAY HH24:MI:SS') LOGON_TIME,
       FLOOR(last_call_et/3600)||':'||
       FLOOR(MOD(last_call_et,3600)/60)||':'||
       MOD(MOD(last_call_et,3600),60) IDLE, program
 FROM gv$session
WHERE INST_id=1 and username IS NOT NULL
ORDER BY username;