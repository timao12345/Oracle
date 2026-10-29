select username, sid, serial#,program, logon_time, sql_id, resource_consumer_group, status from v$session where status='ACTIVE' and username is not null order by 1;

select username,sid, serial#, inst_id, status,osuser, machine, program,module, logon_time  from gv$session where username ='SIA_CONNECT' and status='ACTIVE';   is not null and module='cfa' order by module;