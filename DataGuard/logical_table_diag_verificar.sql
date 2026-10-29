-- NAME: dg_table_diag.sql  (Run on PRIMARY and on LOGICAL STANDBY)
-- ------------------------------------------------------------------------  
--    Copyright 2004, Oracle Corporation       
-- LAST UPDATED: 2/20/04
--
-- Usage: @dg_table_diag schema table
-- ------------------------------------------------------------------------  
-- PURPOSE:  
--    This script is to be used to assist in collection information to help
--    troubeshoot Data Guard issues with an emphasis on Logical Standby.
-- ------------------------------------------------------------------------  
-- DISCLAIMER:  
--    This script is provided for educational purposes only. It is NOT   
--    supported by Oracle World Wide Technical Support.  
--    The script has been tested and appears to work as intended.  
--    You should always run new scripts on a test instance initially.  
-- ------------------------------------------------------------------------  
-- Script output is as follows: 
 
set echo off 
set feedback off 
column timecol new_value timestamp 
column spool_extension new_value suffix 
select to_char(sysdate,'Mondd_hhmi') timecol, 
'.out' spool_extension from sys.dual; 
column output new_value dbname 
select value || '_' output 
from v$parameter where name = 'db_name'; 
spool logical_table_diag_&&dbname&&timestamp&&suffix 
set linesize 79
set pagesize 180
set trim on 
set trims on 
alter session set nls_date_format = 'MON-DD-YYYY HH24:MI:SS'; 
set numwidth 15
set long 90000
set feedback on 

-- Update the version when you change this file, so we know what file was
-- used to produce what output.

set echo on
--
-- Diagnostic version: 040618
--
set echo off
select to_char(sysdate) time from dual; 
 
 
-- Show the database name and role, then display details about the table.
select name,database_role,supplemental_log_data_pk pk,
 supplemental_log_data_ui ui
from v$database; 

-- Exit on error
Whenever sqlerror exit


-- Get the input
variable inowner varchar2(30);
variable intable varchar2(30);
variable objnum number;

exec :inowner := UPPER('&1'); :intable := UPPER('&2')

-- Continue on error
Whenever sqlerror continue

-- Show the table
select DBMS_METADATA.GET_DDL('TABLE', :intable, :inowner)  create_table
from dual;

-- Show the indexes on the table.
select DBMS_METADATA.GET_DEPENDENT_DDL('INDEX', :intable, :inowner)
 create_indexes
from dual;

-- Show the triggers on the table.
select DBMS_METADATA.GET_DEPENDENT_DDL('TRIGGER', :intable, :inowner)
 create_triggers
from dual;

-- Exit on error
Whenever sqlerror exit

-- Get the object number from the log miner dictionary
begin
 select slo.obj# into :objnum
     from system.logmnr_obj$ slo, system.logmnr_user$ slu, 
          system.logmnr_uid$ sud, system.logstdby$parameters slp 
     where slo.owner# = slu.user# 
       and slo.logmnr_uid = sud.logmnr_uid 
       and slu.logmnr_uid = sud.logmnr_uid 
       and to_char(sud.session#) = slp.value 
       and slp.name = 'LMNR_SID' 
       and (slo.type# = 2 or slo.type# = 6)
       and slu.name = :inowner
       and slo.name = :intable;
end;
/

-- Show the various column numbers. (Needed if no dictionary)
set numwidth 8
select c.name, c.col#, c.segcol#, c.null$, c.obj# 
from system.logmnr_col$ c, 
     system.logmnr_uid$ sud, system.logstdby$parameters slp 
where c.obj# = :objnum 
  and c.logmnr_uid = sud.logmnr_uid 
  and to_char(sud.session#) = slp.value 
  and slp.name = 'LMNR_SID' 
order by col#;

-- Show the statement we died on.
select commit_scn, current_scn, xidusn, xidslt, xidsqn, event, status
from dba_logstdby_events
where commit_scn = (select max(commit_scn) from dba_logstdby_events);


set echo on
--
-- Log Miner: Changes to table on primary.
-- Data gathered from logs registered on standby.
--
set echo off

-- This assumes a standby with logs in it.  If you have no logs
-- This does no harm
declare
    final_scn number;
    mineopt number;
    instver number;
    dict number;

    CURSOR logfiles IS SELECT file_name FROM dba_logstdby_log
    WHERE first_change# <= final_scn;
begin
    -- Get the instance base version#
    select to_number(substr(version, 1, 2)) into instver from v$instance;

    -- Compute the last scn to be mined.
    select greatest(
            (select applied_scn from dba_logstdby_progress),
            (select max(commit_scn) from dba_logstdby_events))
           into final_scn 
    from sys.dual;

    -- If there is a dictionary use local catelog.
    select count(*) into dict from dba_logstdby_log 
    where dict_begin = 'YES';

    -- Register the necessary files
    FOR log IN logfiles LOOP
      dbms_logmnr.add_logfile(log.file_name);
    END LOOP;

    -- Start Log Miner (without a dictionary)
    -- In 10.1 dbms_logmnr.NO_ROWID_IN_STMT = 2048
    mineopt := dbms_logmnr.PRINT_PRETTY_SQL;
    if instver > 9 then mineopt := mineopt + 2048; end if;
    if dict > 0 
    then
      mineopt := mineopt + dbms_logmnr.DICT_FROM_REDO_LOGS;
      mineopt := mineopt + dbms_logmnr.DDL_DICT_TRACKING;
    end if;
    dbms_logmnr.start_logmnr(
                        endScn => final_scn,
                        options => mineopt);
end;
/

-- Continue on error
Whenever sqlerror continue

-- Verify we've added the right logs
set numwidth 6
select thread_id, thread_sqn, low_time, high_time, dictionary_begin 
from v$logmnr_logs order by thread_id, thread_sqn;

-- Look at redo for a given table.
column scn format 999999999999999
select 'P' P, SCN, XIDUSN, XIDSLT, XIDSQN, ROLLBACK,
       THREAD#, RBASQN, RBABLK, RBABYTE, 
       SQL_REDO
from v$logmnr_contents
where  DATA_OBJ# = :objnum;

-- Exit on error
Whenever sqlerror exit

-- Finish by cleaning up this log miner session.
exec dbms_logmnr.end_logmnr;


set echo on
--
-- Log Miner: Changes to table on local system
-- Data gathered only if ARCHIVELOG mode is on
--
set echo off

-- Mine local logs, since the time we registered our first from primary.
-- The files may not be on disk, so we trap for that.
declare
    CURSOR logfiles IS SELECT name FROM v$archived_log 
    WHERE dest_id = 1
      AND completion_time > (select min(timestamp) from dba_logstdby_log)
    ORDER BY first_time DESC;
    instver NUMBER;
    mineopt NUMBER;
begin
    BEGIN
      FOR log IN logfiles LOOP
        dbms_logmnr.add_logfile(log.name);
      END LOOP;

    EXCEPTION
    WHEN OTHERS THEN mineopt := 0;
    END;
end;
/

declare
    instver NUMBER;
    mineopt NUMBER;
begin
    -- Get the instance base version#
    select to_number(substr(version, 1, 2)) into instver from v$instance;

    -- Start Log Miner (without a dictionary)
    -- In 10.1 dbms_logmnr.NO_ROWID_IN_STMT = 2048
    mineopt := dbms_logmnr.PRINT_PRETTY_SQL +
               dbms_logmnr.DICT_FROM_ONLINE_CATALOG;
    if instver > 9 then mineopt := mineopt + 2048; end if;

    dbms_logmnr.start_logmnr(options => mineopt);
end;
/


-- Continue on error
Whenever sqlerror continue

-- Verify we've added the right logs
set numwidth 6
select thread_id, thread_sqn, low_time, high_time, dictionary_begin 
from v$logmnr_logs order by thread_id, thread_sqn;

-- Look at redo for a given table or standby tables.
column scn format 999999999999999
select 'S' S, SCN, XIDUSN, XIDSLT, XIDSQN, ROLLBACK,
       THREAD#, RBASQN, RBABLK, RBABYTE, 
       SQL_REDO
from v$logmnr_contents
 where seg_name = 'LOGSTDBY$PARAMETERS'
    or seg_name = 'LOGSTDBY$HISTORY'
    or seg_name = 'LOGSTDBY$SKIP'
    or seg_name = 'LOGSTDBY$SKIP_TRANSACTION'
    or (seg_owner = :inowner and seg_name = :intable);

-- Finish by cleaning up this log miner session.
exec dbms_logmnr.end_logmnr;

spool off


