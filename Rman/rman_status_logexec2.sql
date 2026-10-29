col SERVER_NAME for a12
col INSTANCE_NAME for a10
col COMMAND_NAME for a10
col ARGS for a9
set lines 400 pages 9999
select * from TECH4B.LOGEXEC where command_name in ('backup')  order by 5 desc;