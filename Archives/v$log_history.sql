-- Verifica a quantidade de switch por horario.
select count(*),to_char(first_time,'dd/mm/yyyy:HH24')
from v$log_history
group by to_char(first_time,'dd/mm/yyyy:HH24')
order by 2;