SET pages 500 lines 120
SELECT first_time, qty, qty * BYTES / 1048576 AS Mb
  FROM (SELECT TO_CHAR (first_time, 'yyyy/mm/dd') AS first_time,
               COUNT (*) AS qty
          FROM v$log_history
         where first_time>= (sysdate-3)
         GROUP BY TO_CHAR (first_time, 'yyyy/mm/dd')),
         (SELECT BYTES
            FROM v$log
           WHERE ROWNUM < 2)
ORDER BY first_time;