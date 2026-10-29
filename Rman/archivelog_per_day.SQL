select round(s1.switches_per_day, 2) avg_log_switches_per_day,
       round(s2.switch_size * s1.switches_per_day / 1024 / 1024, 2)
associated_storage_necessary
from  (select (count(*) / (max(first_time) - min(first_time))) switches_per_day
       from V$LOG_HISTORY) s1,
      (Select avg(bytes) switch_size from   V$log) s2