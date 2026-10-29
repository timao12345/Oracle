declare
   nSid    number ;
   nSerial number ;
begin

   nSid := 79 ;
   select serial# into nSerial from v$session where sid= nSid ;

 --  sys.dbms_system.set_bool_param_in_session(sid=>  nSid,  serial# => nSerial parnam  => 'timed_statistics', bval    => true);
   sys.dbms_system.set_int_param_in_session(sid=>  nSid, serial# => nSerial, parnam=>'max_dump_file_size',intval=> 2147483647);
   sys.dbms_system.set_bool_param_in_session( nSid, nSerial,'sql_trace',true);
   dbms_support.start_trace_in_session( nSid, nSerial, waits=>true, binds=>true);
 --    dbms_support.stop_trace_in_session(sid=> nSid, serial  => nSerial);
end;


ou 

 EXEC DBMS_SYSTEM.set_sql_trace_in_session(sid=>1058, serial#=>24954, sql_trace=>TRUE);
 EXEC DBMS_SYSTEM.set_sql_trace_in_session(sid=>1058, serial#=>24954, sql_trace=>FALSE);
 
 