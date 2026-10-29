set serveroutput on size 1000000
set lines 132
col error format a32
col destination format a35
set ver off head off feed off pages 0
DECLARE
pad10 CHAR(10) := ' ';
CURSOR c1 is
select s.db_unique_name,
       s.database_mode,
       s.dest_id id, s.status stats, 
       s.recovery_mode,
       s.protection_mode, s.standby_logfile_count,
       s.standby_logfile_active,
       s.archived_thread#, s.archived_seq#, s.applied_thread#, s.applied_seq#,
       d.status, d.destination, d.archiver,
       d.transmit_mode, d.affirm, d.async_blocks,
       d.net_timeout, d.delay_mins, d.reopen_secs,
       d.register, d.binding, 
--d.compression, 
       d.error err
from v$archive_dest_status s, v$archive_dest d
where d.dest_id=s.dest_id
and s.db_unique_name <> 'NONE'
and d.destination is not null;

BEGIN
dbms_output.put_line('---------------------------------------------------------------------------------------');
FOR r1 IN c1 LOOP
  dbms_output.put_line('Dest ID: '||r1.id||pad10||'Status: '||r1.stats);
  dbms_output.put_line('DB Name: '||r1.db_unique_name||pad10||'DB Mode: '||r1.database_mode);
  dbms_output.put_line('Recovery Mode: '||r1.recovery_mode);
  dbms_output.put_line('Protection Mode: '||r1.protection_mode);
  dbms_output.put_line('SRL Count: '||r1.standby_logfile_count||pad10||'SRL Active: '||r1.standby_logfile_active);
  dbms_output.put_line('Archived Thread#: '||r1.archived_thread#||pad10||'Archived Seq#: '||r1.archived_seq#);
  dbms_output.put_line('Applied Thread#: '||r1.applied_thread#||pad10||'Applied Seq#: '||r1.applied_seq#);

  dbms_output.put_line('Destination: '||r1.destination);
  dbms_output.put_line('Archiver: '||r1.archiver);
  dbms_output.put_line('Transmit Mode: '||r1.transmit_mode);
  dbms_output.put_line('Affirm: '||r1.affirm);
  dbms_output.put_line('Asynchronous Blocks: '||r1.async_blocks);
  dbms_output.put_line('Net Timeout: '||r1.net_timeout);
  dbms_output.put_line('Delay (Mins): '||r1.delay_mins);
  dbms_output.put_line('Reopen (Secs): '||r1.reopen_secs);
  dbms_output.put_line('Register: '||r1.register);
  dbms_output.put_line('Binding: '||r1.binding);
--  dbms_output.put_line('Compression: '||r1.compression);
  dbms_output.put_line('Error: '||r1.err);
dbms_output.put_line('---------------------------------------------------------------------------------------');
END LOOP;
END;
/
