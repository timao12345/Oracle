SET pages 500 lines 120

SELECT first_time, qty, qty * BYTES / 1048576 AS Mb
  FROM (SELECT TO_CHAR (first_time, 'yyyy/mm/dd hh24') AS first_time,
               COUNT (*) AS qty
          FROM v$log_history
         GROUP BY TO_CHAR (first_time, 'yyyy/mm/dd hh24')),
         (SELECT BYTES
            FROM v$log
           WHERE ROWNUM < 2)
ORDER BY first_time;
