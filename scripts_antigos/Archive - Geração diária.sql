alter session set nls_date_format='DD/MM/YYYY';
col "00:00" format 099
col "01:00" format 099
col "02:00" format 099
col "03:00" format 099
col "04:00" format 099
col "05:00" format 099
col "06:00" format 099
col "07:00" format 099
col "08:00" format 099
col "09:00" format 099
col "10:00" format 099
col "11:00" format 099
col "12:00" format 099
col "13:00" format 099
col "14:00" format 099
col "15:00" format 099
col "16:00" format 099
col "17:00" format 099
col "18:00" format 099
col "19:00" format 099
col "20:00" format 099
col "21:00" format 099
col "22:00" format 099
col "23:00" format 099
col Day format a3
col "Total" format 0999
col "GB" for 999,999
set lines 250
break on report
undef days
compute sum label 'Total:' avg label 'Media:' of Total on report
compute sum avg of GB on report
SELECT  trunc(first_time) "Date",
         to_char(first_time, 'Dy') "Day",   count(1) Total,
         round(sum(blocks*block_size)/1024/1024/1024,1) as "GB",
         SUM(decode(to_char(first_time, 'hh24'),'00',1,0)) AS "00:00",
         SUM(decode(to_char(first_time, 'hh24'),'01',1,0)) AS "01:00",
         SUM(decode(to_char(first_time, 'hh24'),'02',1,0)) AS "02:00",
         SUM(decode(to_char(first_time, 'hh24'),'03',1,0)) AS "03:00",
         SUM(decode(to_char(first_time, 'hh24'),'04',1,0)) AS "04:00",
         SUM(decode(to_char(first_time, 'hh24'),'05',1,0)) AS "05:00",
         SUM(decode(to_char(first_time, 'hh24'),'06',1,0)) AS "06:00",
         SUM(decode(to_char(first_time, 'hh24'),'07',1,0)) AS "07:00",
         SUM(decode(to_char(first_time, 'hh24'),'08',1,0)) AS "08:00",
         SUM(decode(to_char(first_time, 'hh24'),'09',1,0)) AS "09:00",
         SUM(decode(to_char(first_time, 'hh24'),'10',1,0)) AS "10:00",
         SUM(decode(to_char(first_time, 'hh24'),'11',1,0)) AS "11:00",
         SUM(decode(to_char(first_time, 'hh24'),'12',1,0)) AS "12:00",
         SUM(decode(to_char(first_time, 'hh24'),'13',1,0)) AS "13:00",
         SUM(decode(to_char(first_time, 'hh24'),'14',1,0)) AS "14:00",
         SUM(decode(to_char(first_time, 'hh24'),'15',1,0)) AS "15:00",
         SUM(decode(to_char(first_time, 'hh24'),'16',1,0)) AS "16:00",
         SUM(decode(to_char(first_time, 'hh24'),'17',1,0)) AS "17:00",
         SUM(decode(to_char(first_time, 'hh24'),'18',1,0)) AS "18:00",
         SUM(decode(to_char(first_time, 'hh24'),'19',1,0)) AS "19:00",
         SUM(decode(to_char(first_time, 'hh24'),'20',1,0)) AS "20:00",
         SUM(decode(to_char(first_time, 'hh24'),'21',1,0)) AS "21:00",
         SUM(decode(to_char(first_time, 'hh24'),'22',1,0)) AS "22:00",
         SUM(decode(to_char(first_time, 'hh24'),'23',1,0)) AS "23:00"
FROM gv$archived_log
WHERE STANDBY_DEST='NO' and first_time > sysdate - &days
GROUP BY trunc(first_time), to_char(first_time, 'Dy')
ORDER BY 1
/

