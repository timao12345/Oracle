SET PAUSE ON
SET PAUSE 'Press Return to Continue'
SET PAGESIZE 60
SET LINESIZE 300
SET VERIFY OFF
 
COLUMN object FORMAT A32
COLUMN type FORMAT A15
COLUMN sid FORMAT 9999
COLUMN username FORMAT A20
COLUMN osuser FORMAT A10
COLUMN program FORMAT A40
 
SELECT a.object,
       a.type,
       a.sid,
       b.username,
       b.osuser,
       b.program
FROM   v$access a,
       v$session b
WHERE  a.sid   = b.sid
AND    a.owner = UPPER('&ENTER_SCHEMA_NAME')
AND    a.sid = &enter_session_id
ORDER BY a.object
/
