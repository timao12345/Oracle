SELECT TYPE, HIGH_SCN, STATUS FROM V$LOGSTDBY;

set lines 180 pages 10000
col message form a80
select to_char(TIMESTAMP,'dd/mm/yyyy-hh24:mi') "DATE", MESSAGE 
from V$DATAGUARD_STATUS where TIMESTAMP>sysdate-1/12;