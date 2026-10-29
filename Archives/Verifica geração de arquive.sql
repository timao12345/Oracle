-- Archive Gerados por HORA

col "h00" format 099
col "h01" format 099
col "h02" format 099
col "h03" format 099
col "h04" format 099
col "h05" format 099
col "h06" format 099
col "h07" format 099
col "h08" format 099
col "h09" format 099
col "h10" format 099
col "h11" format 099
col "h12" format 099
col "h13" format 099
col "h14" format 099
col "h15" format 099
col "h16" format 099
col "h17" format 099
col "h18" format 099
col "h19" format 099
col "h20" format 099
col "h21" format 099
col "h22" format 099
col "h23" format 099
col Day format a5
col "Total" format 0g999
com mb for 999g999
break on report
compute sum label 'Total:' avg label 'Media:' of Total on report
SELECT  trunc(first_time) "Date",
         to_char(first_time, 'Dy') "Day",   count(1) Total,
         round(sum(blocks*block_size)/1024/1024,0) as "MB",
         SUM(decode(to_char(first_time, 'hh24'),'00',1,0)) AS "h00",
         SUM(decode(to_char(first_time, 'hh24'),'01',1,0)) AS "h01",
         SUM(decode(to_char(first_time, 'hh24'),'02',1,0)) AS "h02",
         SUM(decode(to_char(first_time, 'hh24'),'03',1,0)) AS "h03",
         SUM(decode(to_char(first_time, 'hh24'),'04',1,0)) AS "h04",
         SUM(decode(to_char(first_time, 'hh24'),'05',1,0)) AS "h05",
         SUM(decode(to_char(first_time, 'hh24'),'06',1,0)) AS "h06",
         SUM(decode(to_char(first_time, 'hh24'),'07',1,0)) AS "h07",
         SUM(decode(to_char(first_time, 'hh24'),'08',1,0)) AS "h08",
         SUM(decode(to_char(first_time, 'hh24'),'09',1,0)) AS "h09",
         SUM(decode(to_char(first_time, 'hh24'),'10',1,0)) AS "h10",
         SUM(decode(to_char(first_time, 'hh24'),'11',1,0)) AS "h11",
         SUM(decode(to_char(first_time, 'hh24'),'12',1,0)) AS "h12",
         SUM(decode(to_char(first_time, 'hh24'),'13',1,0)) AS "h13",
         SUM(decode(to_char(first_time, 'hh24'),'14',1,0)) AS "h14",
         SUM(decode(to_char(first_time, 'hh24'),'15',1,0)) AS "h15",
         SUM(decode(to_char(first_time, 'hh24'),'16',1,0)) AS "h16",
         SUM(decode(to_char(first_time, 'hh24'),'17',1,0)) AS "h17",
         SUM(decode(to_char(first_time, 'hh24'),'18',1,0)) AS "h18",
         SUM(decode(to_char(first_time, 'hh24'),'19',1,0)) AS "h19",
         SUM(decode(to_char(first_time, 'hh24'),'20',1,0)) AS "h20",
         SUM(decode(to_char(first_time, 'hh24'),'21',1,0)) AS "h21",
         SUM(decode(to_char(first_time, 'hh24'),'22',1,0)) AS "h22",
         SUM(decode(to_char(first_time, 'hh24'),'23',1,0)) AS "h23"
FROM gv$archived_log
WHERE first_time > (sysdate-&before_date) AND dest_id=1
GROUP BY trunc(first_time), to_char(first_time, 'Dy')
ORDER BY 1
/


STANDBY_DEST=NO