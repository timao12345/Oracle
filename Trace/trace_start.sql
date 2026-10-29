-- Trace start

undef sid
select 'exec sys.dbms_system.set_sql_trace_in_session('||sid||','||serial#||', true);' from v$session where sid=(&&SID);
