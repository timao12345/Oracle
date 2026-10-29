-- usando oradebug
-- oradebug setorapid XXX
--  oradebug event 10046 trace name context forever, level 12
-- oradebug tracefile_name ;

begin
   sys.dbms_system.set_bool_param_in_session(sid=>  151,  serial# => 1779, parnam  => 'timed_statistics', bval    => true);
   sys.dbms_system.set_int_param_in_session(sid=>  151, serial# => 1779,parnam=>'max_dump_file_size',intval=> 2147483647);
   sys.dbms_system.set_bool_param_in_session( 151, 1779,'sql_trace',true);
   dbms_support.start_trace_in_session( 151, 1779, waits=>true, binds=>true);
--     dbms_support.stop_trace_in_session(sid=> 93, serial  => 871);
end;
