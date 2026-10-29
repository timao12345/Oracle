-- Estimate IMPDP
SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
SELECT rpad(instance_name, 17) current_instance FROM v$instance;


SET TERMOUT ON;

PROMPT 
PROMPT +------------------------------------------------------------------------+
PROMPT | Report   : IMPDP Import Progress                                       |
PROMPT | Instance : &current_instance                                           |
PROMPT | Note     :                                                             |
PROMPT |       											                        |
PROMPT +------------------------------------------------------------------------+

SET ECHO        OFF
SET FEEDBACK    6
SET HEADING     ON
SET LINESIZE    180
SET PAGESIZE    50000
SET TERMOUT     ON
SET TIMING      OFF
SET TRIMOUT     ON
SET TRIMSPOOL   ON
SET VERIFY      OFF

CLEAR COLUMNS
CLEAR BREAKS
CLEAR COMPUTES

COLUMN instance_name      FORMAT a10      HEADING 'Instance'
COLUMN sid                                HEADING 'Oracle|SID'
COLUMN serial_num                         HEADING 'Serial|#'
COLUMN opname             FORMAT a40      
COLUMN start_time         FORMAT a18      HEADING 'Start|Time'
COLUMN totalwork                          HEADING 'Total|Work'
COLUMN sofar                              HEADING 'So|Far'
COLUMN pct_done                           HEADING 'Percent|Done'
COLUMN elapsed_seconds                    HEADING 'Elapsed|Seconds'
COLUMN time_remaining                     HEADING 'Seconds|Remaining'
COLUMN done_at            FORMAT a18      HEADING 'Done|At'

-- elapsed_seconds (O número de segundos decorridos desde o início das operações
-- time_remaining (Estimate (in seconds) of time remaining for the operation to complete SELECT)
-- sofar (As unidades de trabalho feito até agora)
-- totalwork (As unidades totais de trabalho)

SELECT
    i.instance_name                                 instance_name
  , sid                                             sid
  , serial#                                         serial_num
  , b.opname                                        opname
  , TO_CHAR(b.start_time, 'yy/mm/dd HH24:MI:SS')    start_time
  , b.totalwork                                     totalwork
  , b.sofar                                         sofar
  , ROUND( (b.sofar/DECODE(   b.totalwork
                            , 0
                            , 0.001
                            , b.totalwork)*100),2)  pct_done
  , b.elapsed_seconds                               elapsed_seconds
  , b.time_remaining                                time_remaining
  , DECODE(   b.time_remaining
            , 0
            , TO_CHAR((b.start_time + b.elapsed_seconds/3600/24), 'yy/mm/dd HH24:MI:SS')
            , TO_CHAR((SYSDATE + b.time_remaining/3600/24), 'yy/mm/dd HH24:MI:SS')
    ) done_at
FROM
       gv$session         a
  JOIN gv$session_longops b USING (sid,serial#)
  JOIN gv$instance        i ON (      i.inst_id = a.inst_id
                                  AND i.inst_id = b.inst_id)
WHERE
      sid =708
  AND b.totalwork > 0
ORDER BY 11
/
