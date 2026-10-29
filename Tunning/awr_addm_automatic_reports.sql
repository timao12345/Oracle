set serveroutput on
spool awr_addm.sql

begin
  for cur in (
	select a.dbid, b.instance_number, b.instance_name, 
	       b.host_name || to_char(begin_interval_time, '-dd-mm-yy') || '.html' awr_file, 
		   b.host_name || '-addm' || to_char(begin_interval_time, '-dd-mm-yy') || '.txt'  addm_file,
		   min(snap_id) min_snap, max(snap_id) max_snap
	  from dba_hist_snapshot a, gv$instance b
	 where a.instance_number = b.instance_number 
	   and a.begin_interval_time >  to_date('24/02/2012 23:59:59','dd/mm/yyyy hh24:mi:ss')
	 group by a.dbid, b.instance_number, b.instance_name, b.host_name,to_char(begin_interval_time, '-dd-mm-yy')
	 order by b.host_name ) loop
 
    dbms_output.put_line('define  inst_num     = ' || cur.instance_number || ';' ) ;
    dbms_output.put_line('define  num_days     = ' || '7' || ';' ) ;
	dbms_output.put_line('define  inst_name    = ' || chr(39) || cur.instance_name || chr(39) || ';' ) ;
	dbms_output.put_line('define  db_name      = ' || chr(39) || 'PROD' || chr(39) ||  ';' ) ;
	dbms_output.put_line('define  dbid         = ' || cur.dbid || ';' ) ;
	dbms_output.put_line('define  begin_snap   = ' || cur.min_snap || ';' ) ;
	dbms_output.put_line('define  end_snap     = ' || cur.max_snap || ';' ) ;
	dbms_output.put_line('define  report_type  = ' || 'html' || ';' ) ;
	dbms_output.put_line('define  report_name  = ' || cur.awr_file || ';' ) ;
	dbms_output.put_line('@@?/rdbms/admin/awrrpti' ) ;
		
	dbms_output.put_line('define  dbid         = ' || cur.dbid || ';' ) ;
	dbms_output.put_line('define  inst_num     = ' || cur.instance_number || ';' ) ;
	dbms_output.put_line('define  num_days     = ' || '7' || ';' ) ;
	dbms_output.put_line('define  begin_snap   = ' || cur.min_snap || ';' ) ;
	dbms_output.put_line('define  end_snap     = ' || cur.max_snap || ';' ) ;
	dbms_output.put_line('define  report_name  = ' || cur.addm_file || ';' ) ;
	dbms_output.put_line('@@?/rdbms/admin/addmrpti' ) ;
		 
  end loop ;	 
	 
end;
