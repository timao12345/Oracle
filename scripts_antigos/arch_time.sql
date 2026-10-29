-- Archive Gerados por HORA

set pagesize 5555
set linesize 500
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
col "day" for a5
com mb for 999g999
break on report
compute sum label 'Total:' avg label 'Media:' of Total on report
select
to_char(first_time,'DY')"Day", to_date(to_char(first_time,'dd-mm-yy'),'dd-mm-yy')" ", count(*)"Total",
sum(decode(to_char(first_time,'hh24'),'00',1,0)) "h00",
sum(decode(to_char(first_time,'hh24'),'01',1,0)) "h01",
sum(decode(to_char(first_time,'hh24'),'02',1,0)) "h02",
sum(decode(to_char(first_time,'hh24'),'03',1,0)) "h03",
sum(decode(to_char(first_time,'hh24'),'04',1,0)) "h04",
sum(decode(to_char(first_time,'hh24'),'05',1,0)) "h05",
sum(decode(to_char(first_time,'hh24'),'06',1,0)) "h06",
sum(decode(to_char(first_time,'hh24'),'07',1,0)) "h07",
sum(decode(to_char(first_time,'hh24'),'08',1,0)) "h08",
sum(decode(to_char(first_time,'hh24'),'09',1,0)) "h09",
sum(decode(to_char(first_time,'hh24'),'10',1,0)) "h10",
sum(decode(to_char(first_time,'hh24'),'11',1,0)) "h11",
sum(decode(to_char(first_time,'hh24'),'12',1,0)) "h12",
sum(decode(to_char(first_time,'hh24'),'13',1,0)) "h13",
sum(decode(to_char(first_time,'hh24'),'14',1,0)) "h14",
sum(decode(to_char(first_time,'hh24'),'15',1,0)) "h15",
sum(decode(to_char(first_time,'hh24'),'16',1,0)) "h16",
sum(decode(to_char(first_time,'hh24'),'17',1,0)) "h17",
sum(decode(to_char(first_time,'hh24'),'18',1,0)) "h18",
sum(decode(to_char(first_time,'hh24'),'19',1,0)) "h19",
sum(decode(to_char(first_time,'hh24'),'20',1,0)) "h20",
sum(decode(to_char(first_time,'hh24'),'21',1,0)) "h21",
sum(decode(to_char(first_time,'hh24'),'22',1,0)) "h22",
sum(decode(to_char(first_time,'hh24'),'23',1,0)) "h23"
from v$log_history
where trunc(first_time) >= sysdate -30
group by
to_char(first_time,'DY'), to_date(to_char(first_time,'dd-mm-yy'),'dd-mm-yy')
order by to_date(to_char(first_time,'dd-mm-yy'),'dd-mm-yy')
/
