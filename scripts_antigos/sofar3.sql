set lines 1000
col sid format 9999
col serial# format 999999
col "Time spent and left" format a50
col detail format a60
col message format a50
select SID,
       SERIAL#,
       substr(OPNAME, 1, 30) "What ",
       'Time Elapsed ' || round(Elapsed_seconds / 60, 2) || ' Mins. ' ||
       'Time left ' || round(time_remaining / 60, 2) || ' Mins.' "Time spent and left",
       'Est Compl time=' ||
       to_char(sysdate + (round(TIME_REMAINING / 60, 2) / 1440),
               'DD-MM-YYYY HH24:MI:SS') || ' completed ' ||
       round((sofar / totalwork) * 100, 2) || '%' || ' ' || sofar || ' of ' ||
       totalwork || ' compl' "Detail",
       message
  from v$session_longops
 where time_remaining > 0
 order by time_remaining

/