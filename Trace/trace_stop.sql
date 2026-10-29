-- Trace stop

undef sid
select 'exec sys.dbms_system.set_sql_trace_in_session('||sid||','||serial#||', false);' from v$session where sid=(&&SID);