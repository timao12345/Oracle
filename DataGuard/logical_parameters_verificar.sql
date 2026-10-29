column name format a33 wrap
column value format a33 wrap
column type format 99
set pages 44

select name, value from dba_logstdby_parameters
order by name;
