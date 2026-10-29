alter session set nls_date_format='dd/mm/yyyy:hh24';
select to_char(FIRST_TIME, 'MM/DD HH24') as dia, count( * ) as total, round(sum ((blocks*block_size)/1024/1024),0) MB
from v$archived_log
where first_time > '&datahorainicial'
and first_time < '&datahorafinal'
group by to_char(FIRST_TIME, 'MM/DD HH24')
/
