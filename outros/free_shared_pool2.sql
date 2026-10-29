col value for 999,999,999,999 heading "Shared Pool Size"
col bytes for 999,999,999,999 heading "Free Bytes"
select   to_number(v$parameter.value) value, v$sgastat.bytes, 
	(v$sgastat.bytes/v$parameter.value)*100 "Percent Free"
from 	v$sgastat, v$parameter
where	v$sgastat.name = 'free memory'
and	v$parameter.name = 'shared_pool_size'
