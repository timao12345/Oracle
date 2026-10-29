When a database is created with the DBCA , it is possible to configure automated maintenance jobs during database creation. The maintenance jobs run during specific maintenance windows in the nightly hours. Oracle 11g includes three automated database maintenance tasks:
• Automatic Optimizer Statistics Collection - Gathers stale or missing statistics for all schema objects. The task name is 'auto optimizer stats collection'.
• Automatic Segment Advisor - Identifies segments that could be reorganized to save space. The task name is 'auto space advisor'.
• Automatic SQL Tuning Advisor - Identifies and attempts to tune high load SQL. The task name is 'sql tuning advisor'.
The Monday-Friday are from 10:00PM till 02:00AM and Saturday-Sunday are from 06:00AM till 02:00AM. Each weekday window also has a pre-defined Resource Plan called DEFAULT_MAINTENANCE_PLAN, which will become active once the related window opens.


Usefull Views
DBA_AUTOTASK_CLIENT_JOB
DBA_AUTOTASK_JOB_HISTORY
DBA_AUTOTASK_CLIENT_HISTORY
DBA_AUTOTASK_OPERATION
DBA_AUTOTASK_WINDOW_CLIENTS
== Usefull queries ==
/* view automated jobs in the database */

SQL> select client_name, status from dba_autotask_operation;

CLIENT_NAME                     STATUS
------------------------------- --------
auto optimizer stats collection ENABLED
auto space advisor              ENABLED
sql tuning advisor              ENABLED
/* View active maintenance windows in the database */

SQL> select window_name, window_next_time from DBA_AUTOTASK_WINDOW_CLIENTS;

WINDOW_NAME                    WINDOW_NEXT_TIME
------------------------------ ----------------------------------------
MONDAY_WINDOW                  11.05.20 18:00:00,000000 +02:00
TUESDAY_WINDOW                 05.05.20 18:00:00,000000 +02:00
WEDNESDAY_WINDOW               06.05.20 18:00:00,000000 +02:00
THURSDAY_WINDOW                07.05.20 18:00:00,000000 +02:00
FRIDAY_WINDOW                  08.05.20 18:00:00,000000 +02:00
SATURDAY_WINDOW                14.05.11 06:00:00,000000 EUROPE/VIENNA
SUNDAY_WINDOW                  15.05.11 06:00:00,000000 EUROPE/VIENNA
 /* view history of automated statistics job */

SQL> col client_name format a32
SQL> col job_status format a10
SQL> col job_start_time format a40
SQL> col job_info format a60
SQL> col job_duration format a20
SQL> set linesize 200
SELECT client_name, job_status, job_start_time, job_duration, job_info
FROM dba_autotask_job_history
WHERE client_name like '%stats%'
ORDER BY job_start_time;

CLIENT_NAME                      JOB_STATUS JOB_START_TIME                           JOB_DURATION  JOB_INFO
-------------------------------- ---------- ---------------------------
auto optimizer stats collection  STOPPED    30.04.11 06:00:08,582336 EUROPE/VIENNA   +000 00:01:36        ORA-01014: ORACLE-SHUTDOWN lauft ...
auto optimizer stats collection  STOPPED    30.04.11 06:00:08,582336 EUROPE/VIENNA   +000 00:01:36        ORA-01014: ORACLE-SHUTDOWN lauft ...
auto optimizer stats collection  STOPPED    01.05.11 09:10:48,478764 EUROPE/VIENNA   +003 00:42:26        ORA-01014: ORACLE-SHUTDOWN lauft ...
auto optimizer stats collection  STOPPED    01.05.11 09:10:48,478764 EUROPE/VIENNA   +003 00:42:26        ORA-01014: ORACLE-SHUTDOWN lauft ...
auto optimizer stats collection  STOPPED    04.05.11 22:00:08,929371 EUROPE/VIENNA   +000 03:59:52        REASON="Stop job called because associated window was closed"
auto optimizer stats collection  SUCCEEDED  07.05.11 06:00:08,818549 EUROPE/VIENNA   +000 01:11:18
auto optimizer stats collection  SUCCEEDED  07.05.11 10:00:28,670036 EUROPE/VIENNA   +000 00:24:50
Enable/Disable automated maintenance tasks
BEGIN
dbms_auto_task_admin.[disable/enable](
    client_name => 'sql tuning advisor',
    operation   => NULL,
    window_name => NULL);
END;

/* Enable/Disable the whole maintenance window */

BEGIN
dbms_scheduler.[disable/enable](
    name => 'SYS_MAINTEANCE_WINDOW_GROUP',
    force   => TRUE);
END;
/
Change parallelism of the statistics automated maintenance job
SQL> exec dbms_stats.set_global_prefs('degree', '128');
Change the maintenance window start time and duration
EXECUTE DBMS_SCHEDULER.DISABLE(name => 'SYS.MONDAY_WINDOW', force=>TRUE);
 
EXECUTE DBMS_SCHEDULER.SET_ATTRIBUTE(name => 'SYS.MONDAY_WINDOW', attribute => 'duration', value => interval '360' minute);

EXECUTE DBMS_SCHEDULER.SET_ATTRIBUTE(name => 'SYS.MONDAY_WINDOW', attribute => 'repeat_interval', value => 'FREQ=WEEKLY;BYDAY=MON;BYHOUR=18;BYMINUTE=0;BYSECOND=0');

EXECUTE DBMS_SCHEDULER.ENABLE(name => 'SYS.MONDAY_WINDOW');

select log_date,status from dba_scheduler_job_run_details where job_name='BSLN_MAINTAIN_STATS_JOB';


System name:    Linux
Node name:      bsa6752
Release:        3.0.93-0.8-default
Version:        #1 SMP Tue Aug 27 08:44:18 UTC 2013 (70ed288)
Machine:        x86_64
Instance name: DC13LMQ1
Redo thread mounted by this instance: 1
Oracle process number: 196
Unix process pid: 24825, image: oracle@bsa6752 (J001)


*** 2015-05-03 14:07:22.785
*** SESSION ID:(508.31009) 2015-05-03 14:07:22.785
*** CLIENT ID:() 2015-05-03 14:07:22.785
*** SERVICE NAME:(SYS$USERS) 2015-05-03 14:07:22.785
*** MODULE NAME:(DBMS_SCHEDULER) 2015-05-03 14:07:22.785
*** ACTION NAME:(ORA$AT_SA_SPC_SY_1241) 2015-05-03 14:07:22.785

ORA-12012: error on auto execute of job "SYS"."ORA$AT_SA_SPC_SY_1241"
ORA-01652: unable to extend temp segment by 128 in tablespace TEMP
ORA-06512: at "SYS.DBMS_ADVISOR", line 201
ORA-06512: at "SYS.DBMS_SPACE", line 2276
ORA-06512: at "SYS.DBMS_SPACE", line 2538
~
~


select log_date,status, JOB_NAME from dba_scheduler_job_run_details where status='FAILED' order by log_date;

LOG_DATE                                                                    STATUS                         JOB_NAME
--------------------------------------------------------------------------- ------------------------------ --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
21-APR-15 10.03.05.972202 PM +00:00                                         FAILED                         ORA$AT_SA_SPC_SY_1125
22-APR-15 10.02.46.692722 PM +00:00                                         FAILED                         ORA$AT_SA_SPC_SY_1142
23-APR-15 10.02.53.070757 PM +00:00                                         FAILED                         ORA$AT_SA_SPC_SY_1162
24-APR-15 10.03.00.491222 PM +00:00                                         FAILED                         ORA$AT_SA_SPC_SY_1165
25-APR-15 06.01.55.794034 AM +00:00                                         FAILED                         ORA$AT_SA_SPC_SY_1168
25-APR-15 10.03.57.711337 AM +00:00                                         FAILED                         ORA$AT_SA_SPC_SY_1171
25-APR-15 02.03.51.754096 PM +00:00                                         FAILED                         ORA$AT_SA_SPC_SY_1173
25-APR-15 06.04.15.936204 PM +00:00                                         FAILED                         ORA$AT_SA_SPC_SY_1175
25-APR-15 10.05.07.590314 PM +00:00                                         FAILED                         ORA$AT_SA_SPC_SY_1177
26-APR-15 06.02.13.613850 AM +00:00                                         FAILED                         ORA$AT_SA_SPC_SY_1179
26-APR-15 10.05.43.824568 AM +00:00                                         FAILED                         ORA$AT_SA_SPC_SY_1182
26-APR-15 02.05.24.614258 PM +00:00                                         FAILED                         ORA$AT_SA_SPC_SY_1184
26-APR-15 06.06.03.387341 PM +00:00                                         FAILED                         ORA$AT_SA_SPC_SY_1186
26-APR-15 10.06.23.724653 PM +00:00                                         FAILED                         ORA$AT_SA_SPC_SY_1188
27-APR-15 10.03.15.933640 PM +00:00                                         FAILED                         ORA$AT_SA_SPC_SY_1190
28-APR-15 10.03.02.826409 PM +00:00                                         FAILED                         ORA$AT_SA_SPC_SY_1193
29-APR-15 10.08.07.713088 PM +00:00                                         FAILED                         ORA$AT_SA_SPC_SY_1202
02-MAY-15 06.02.59.828675 AM +00:00                                         FAILED                         ORA$AT_SA_SPC_SY_1225
02-MAY-15 10.05.46.035694 AM +00:00                                         FAILED                         ORA$AT_SA_SPC_SY_1228
02-MAY-15 02.06.10.475135 PM +00:00                                         FAILED                         ORA$AT_SA_SPC_SY_1230
02-MAY-15 06.05.58.419331 PM +00:00                                         FAILED                         ORA$AT_SA_SPC_SY_1232
02-MAY-15 10.06.37.501169 PM +00:00                                         FAILED                         ORA$AT_SA_SPC_SY_1234
03-MAY-15 06.02.34.349868 AM +00:00                                         FAILED                         ORA$AT_SA_SPC_SY_1236
03-MAY-15 10.07.48.284858 AM +00:00                                         FAILED                         ORA$AT_SA_SPC_SY_1239
03-MAY-15 02.07.22.803063 PM +00:00                                         FAILED                         ORA$AT_SA_SPC_SY_1241

25 rows selected.




SQL> set lines 180 pages 1000
col client_name for a40
col attributes for a60
select client_name, status,attributes,service_name from dba_autotask_client
/SQL> SQL> SQL>   2

CLIENT_NAME                              STATUS   ATTRIBUTES                                                   SERVICE_NAME
---------------------------------------- -------- ------------------------------------------------------------ ----------------------------------------------------------------
auto optimizer stats collection          ENABLED  ON BY DEFAULT, VOLATILE, SAFE TO KILL
auto space advisor                       ENABLED  ON BY DEFAULT, VOLATILE, SAFE TO KILL
sql tuning advisor                       ENABLED  ONCE PER WINDOW, ON BY DEFAULT, VOLATILE, SAFE TO KILL

SQL>

to check the status of suto space adviser 


select client_name, status
from dba_autotask_client;

CLIENT_NAME                     STATUS
------------------------------- --------
auto optimizer stats collection ENABLED
auto space advisor              ENABLED
sql tuning advisor              DISABLED

set lines 180 pages 1000
col client_name for a40
col attributes for a60
select distinct client_name, window_name, job_status, job_info
from dba_autotask_job_history
where job_status <> 'SUCCEEDED'
order by 1,2;


Disable the auto space adviser 

BEGIN
  dbms_auto_task_admin.disable(
    client_name => 'auto space advisor',
    operation   => NULL,
    window_name => NULL);
END;
/

PL/SQL procedure successfully completed




SQL> select window_name, window_next_time from DBA_AUTOTASK_WINDOW_CLIENTS;

WINDOW_NAME                    WINDOW_NEXT_TIME
------------------------------ ---------------------------------------------------------------------------
MONDAY_WINDOW                  04-MAY-15 10.00.00.000000 PM UTC
TUESDAY_WINDOW                 05-MAY-15 10.00.00.000000 PM UTC
WEDNESDAY_WINDOW               06-MAY-15 10.00.00.000000 PM UTC
THURSDAY_WINDOW                07-MAY-15 10.00.00.000000 PM UTC
FRIDAY_WINDOW                  08-MAY-15 10.00.00.000000 PM UTC
SATURDAY_WINDOW                09-MAY-15 06.00.00.000000 AM UTC
SUNDAY_WINDOW                  03-MAY-15 06.00.00.000000 AM UTC



When enabling and/or disabling auto tasks, you must use the CLIENT_NAME as found in DBA_AUTOTASK_CLIENT view.

The full list of DBA_AUTOTASK_% views is:

DBA_AUTOTASK_CLIENT
DBA_AUTOTASK_CLIENT_HISTORY
DBA_AUTOTASK_CLIENT_JOB
DBA_AUTOTASK_JOB_HISTORY
DBA_AUTOTASK_OPERATION
DBA_AUTOTASK_SCHEDULE
DBA_AUTOTASK_TASK
DBA_AUTOTASK_WINDOW_CLIENTS
DBA_AUTOTASK_WINDOW_HISTORY