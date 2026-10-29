col "00" format a4
col "01" format a4
col "02" format a4
col "03" format a4
col "04" format a4
col "05" format a4
col "06" format a4
col "07" format a4
col "08" format a4
col "09" format a4
col "10" format a4
col "11" format a4
col "12" format a4
col "13" format a4
col "14" format a4
col "15" format a4
col "16" format a4
col "17" format a4
col "18" format a4
col "19" format a4
col "20" format a4
col "21" format a4
col "22" format a4
col "23" format a4
SELECT trunc(first_time) "Date",
    max(to_char(to_date(substr(time,1,8),'dd/mm/yy'),'Dy')) "Day",
    count('1') "Total",
    decode(to_char(SUM(decode(substr(time,10,2),'00',1,0)),'999'),'   0','   ',to_char(SUM(decode(substr(time,10,2),'00',1,0)),'999')) "00",
    decode(to_char(SUM(decode(substr(time,10,2),'01',1,0)),'999'),'   0','   ',to_char(SUM(decode(substr(time,10,2),'01',1,0)),'999')) "01",
    decode(to_char(SUM(decode(substr(time,10,2),'02',1,0)),'999'),'   0','   ',to_char(SUM(decode(substr(time,10,2),'02',1,0)),'999')) "02",
    decode(to_char(SUM(decode(substr(time,10,2),'03',1,0)),'999'),'   0','   ',to_char(SUM(decode(substr(time,10,2),'03',1,0)),'999')) "03",
    decode(to_char(SUM(decode(substr(time,10,2),'04',1,0)),'999'),'   0','   ',to_char(SUM(decode(substr(time,10,2),'04',1,0)),'999')) "04",
    decode(to_char(SUM(decode(substr(time,10,2),'05',1,0)),'999'),'   0','   ',to_char(SUM(decode(substr(time,10,2),'05',1,0)),'999')) "05",
    decode(to_char(SUM(decode(substr(time,10,2),'06',1,0)),'999'),'   0','   ',to_char(SUM(decode(substr(time,10,2),'06',1,0)),'999')) "06",
    decode(to_char(SUM(decode(substr(time,10,2),'07',1,0)),'999'),'   0','   ',to_char(SUM(decode(substr(time,10,2),'07',1,0)),'999')) "07",
    decode(to_char(SUM(decode(substr(time,10,2),'08',1,0)),'999'),'   0','   ',to_char(SUM(decode(substr(time,10,2),'08',1,0)),'999')) "08",
    decode(to_char(SUM(decode(substr(time,10,2),'09',1,0)),'999'),'   0','   ',to_char(SUM(decode(substr(time,10,2),'09',1,0)),'999')) "09",
    decode(to_char(SUM(decode(substr(time,10,2),'10',1,0)),'999'),'   0','   ',to_char(SUM(decode(substr(time,10,2),'10',1,0)),'999')) "10",
    decode(to_char(SUM(decode(substr(time,10,2),'11',1,0)),'999'),'   0','   ',to_char(SUM(decode(substr(time,10,2),'11',1,0)),'999')) "11",
    decode(to_char(SUM(decode(substr(time,10,2),'12',1,0)),'999'),'   0','   ',to_char(SUM(decode(substr(time,10,2),'12',1,0)),'999')) "12",
    decode(to_char(SUM(decode(substr(time,10,2),'13',1,0)),'999'),'   0','   ',to_char(SUM(decode(substr(time,10,2),'13',1,0)),'999')) "13",
    decode(to_char(SUM(decode(substr(time,10,2),'14',1,0)),'999'),'   0','   ',to_char(SUM(decode(substr(time,10,2),'14',1,0)),'999')) "14",
    decode(to_char(SUM(decode(substr(time,10,2),'15',1,0)),'999'),'   0','   ',to_char(SUM(decode(substr(time,10,2),'15',1,0)),'999')) "15",
    decode(to_char(SUM(decode(substr(time,10,2),'16',1,0)),'999'),'   0','   ',to_char(SUM(decode(substr(time,10,2),'16',1,0)),'999')) "16",
    decode(to_char(SUM(decode(substr(time,10,2),'17',1,0)),'999'),'   0','   ',to_char(SUM(decode(substr(time,10,2),'17',1,0)),'999')) "17",
    decode(to_char(SUM(decode(substr(time,10,2),'18',1,0)),'999'),'   0','   ',to_char(SUM(decode(substr(time,10,2),'18',1,0)),'999')) "18",
    decode(to_char(SUM(decode(substr(time,10,2),'19',1,0)),'999'),'   0','   ',to_char(SUM(decode(substr(time,10,2),'19',1,0)),'999')) "19",
    decode(to_char(SUM(decode(substr(time,10,2),'20',1,0)),'999'),'   0','   ',to_char(SUM(decode(substr(time,10,2),'20',1,0)),'999')) "20",
    decode(to_char(SUM(decode(substr(time,10,2),'21',1,0)),'999'),'   0','   ',to_char(SUM(decode(substr(time,10,2),'21',1,0)),'999')) "21",
    decode(to_char(SUM(decode(substr(time,10,2),'22',1,0)),'999'),'   0','   ',to_char(SUM(decode(substr(time,10,2),'22',1,0)),'999')) "22",
    decode(to_char(SUM(decode(substr(time,10,2),'23',1,0)),'999'),'   0','   ',to_char(SUM(decode(substr(time,10,2),'23',1,0)),'999')) "23"
FROM (SELECT a.*, to_char(a.FIRST_TIME, 'dd/mm/yy hh24:mi:ss') time FROM V$log_history a)
--WHERE substr(time,7,2) = to_char(SYSDATE, 'YY')
GROUP BY trunc(first_time)
ORDER BY trunc(first_time) ASC;
