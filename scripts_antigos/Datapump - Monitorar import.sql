col username for a20
col opname for a25
col target for a10
col %done for a15
col start_time for a25

SELECT b.username, a.sid, a.serial#, b.opname, b.target,
            round(b.SOFAR*100/b.TOTALWORK,0) || '%' as "%DONE", b.TIME_REMAINING,
            to_char(b.start_time,'YYYY/MM/DD HH24:MI:SS') start_time
     FROM v$session_longops b, v$session a
     WHERE a.sid = b.sid and b.opname like '%EXP%'     ORDER BY 6;