http://www.snapdba.com/2014/10/dbms_scheduler-jobs-running-an-hour-late-dstbst-issues/

DBMS_SCHEDULER jobs running an hour late – DST/BST issues!

This week one of our developers highlighted the fact that the DBMS_SCHEDULER on one of our 11.2.0.3 databases was running jobs an hour later than scheduled until just recently, when the clocks went back (26/10/2014) for British Summer Time (BST) …and now they’re running on-time again!

I’d not seen this before, and at first I thought we were hitting some kind of Daylight Saving Time (DST) related Oracle bug with the DBMS_SCHEDULER, but I did a bit more digging around and eventually found out why.  It’s a bit of a long winded explanation, but hopefully this all makes sense to someone else who hits a similar issue…

So what’s happening?

I took a look at the DBMS_SCHEDULER logs for the ‘MON_SAT_EVENING_REFRESH’ job which encountered the problem:

COL "Job Name" FOR A25
COL "Operation" FOR A12

SELECT l.log_id                              "Log ID", 
       l.job_name                            "Job Name", 
       TO_CHAR (l.log_date, 
       'YYYY/MM/DD HH24:MI:SS.FF TZH:TZM')   "Log Date", 
       TO_CHAR (r.actual_start_date,
       'YYYY/MM/DD HH24:MI:SS.FF TZH:TZM')   "Actual Start Date" 
FROM   dba_scheduler_job_log l, 
       dba_scheduler_job_run_details r 
WHERE  l.owner = 'DATAMART' 
       AND l.job_name = 'MON_SAT_EVENING_REFRESH' 
       AND l.log_id = r.log_id(+) 
ORDER  BY 1 DESC 
/

    Log ID Job Name                  Log Date                             Actual Start Date
---------- ------------------------- ------------------------------------ ---------------------------------
     57776 MON_SAT_EVENING_REFRESH   2014/10/30 18:30:26.767000 +00:00    2014/10/30 18:30:00.511000 +00:00
     57553 MON_SAT_EVENING_REFRESH   2014/10/29 18:30:28.455000 +00:00    2014/10/29 18:30:00.545000 +00:00
     57330 MON_SAT_EVENING_REFRESH   2014/10/28 18:30:27.162000 +00:00    2014/10/28 18:30:00.361000 +00:00
     57107 MON_SAT_EVENING_REFRESH   2014/10/27 18:30:25.415000 +00:00    2014/10/27 18:30:00.252000 +00:00
     56623 MON_SAT_EVENING_REFRESH   2014/10/25 19:30:25.217000 +01:00    2014/10/25 18:30:00.038000 +00:00
     56344 MON_SAT_EVENING_REFRESH   2014/10/24 19:30:24.684000 +01:00    2014/10/24 18:30:01.002000 +00:00
     56121 MON_SAT_EVENING_REFRESH   2014/10/23 19:30:22.536000 +01:00    2014/10/23 18:30:00.821000 +00:00
	 
	 
So we can see that the log date and time reflects the true time the job ran, but the actual start time contradicts this…but why??

The clue is in the time zone (TZ) setting at the end of each value (underlined).  When the jobs were created, the START_DATE used a TZ of +00:00 (GMT/UTC) as can be seen below.  Notice the SYS job TZ in comparison, which has the correct setup (although strictly speaking it should really be ‘EUROPE/LONDON’ in our case): 

SELECT owner, 
       job_name, 
       start_date, 
       next_run_date 
FROM   dba_scheduler_jobs;

OWNER        JOB_NAME                       START_DATE                               NEXT_RUN_DATE
------------ ------------------------------ ---------------------------------------- ---------------------------------------
SYS          PURGE_LOG                      03-SEP-13 03.00.00.900000 EUROPE/LISBON  01-NOV-14 03.00.00.800000 EUROPE/LISBON
DATAMART     MON_SAT_EVENING_REFRESH        11-OCT-14 18.30.00.000000 +00:00         31-OCT-14 18.30.00.500000 +00:00


If we check the DBMS_SCHEDULER system time, that picks up the correct TZ too:

SELECT dbms_scheduler.stime FROM dual; 

STIME
-------------------------------------------------------------------
31-OCT-14 15.10.05.521000000 EUROPE/LISBON


So where is GMT being picked up from?

Well, I created a test job without specifying a TZ in the date/time string:


BEGIN
DBMS_SCHEDULER.CREATE_JOB (
   job_name             => 'hr.my_job',
   job_type             => 'PLSQL_BLOCK',
   job_action           => 'BEGIN DBMS_STATS.GATHER_TABLE_STATS(''HR'',
                            ''EMPLOYEES''); END;',
   start_date           =>  TO_DATE('01-OCT-2014 14:00','DD-MON-YYYY HH24:MI'),
   repeat_interval      => 'FREQ=DAILY',
   end_date             =>  TO_DATE('01-DEC-2014 14:00','DD-MON-YYYY HH24:MI'),
   enabled              =>  TRUE,
   comments             => 'Gather table statistics');
END;
/

PL/SQL procedure successfully completed.

and it used the same TZ (GMT) as the ‘DATAMART’ owned job above:

SELECT owner, 
       job_name, 
       start_date, 
       next_run_date 
FROM   dba_scheduler_jobs 
WHERE  owner = 'HR';

OWNER        JOB_NAME       START_DATE                               NEXT_RUN_DATE
------------ -------------- ---------------------------------------- --------------------------------
HR           MY_JOB         01-OCT-14 14.00.00.000000 +00:00         31-OCT-14 14.00.00.000000 +00:00
…after checking the session TZ used by my client, I can see where that’s being derived that from now:

SELECT sessiontimezone FROM dual; 

SESSIONTIMEZONE
-------------------------------------------------------------
+00:00

Using a bit of PL/SQL and calling the DBMS_SCHEDULER.EVALUATE_CALENDAR_STRING procedure, I was able to determine exactly what the next run date/time values would have been used from 23/10/2014, for a weeks’ worth of executions (clock change was 26/10/2014):


-- Current GMT TZ
DECLARE
-- Set repeat interval
interval_string VARCHAR2(100) DEFAULT 'FREQ=DAILY;BYDAY=MON,TUE,WED,THU,FRI,SAT,SUN;BYHOUR=14';
start_date TIMESTAMP with time zone;
return_date_after TIMESTAMP with time zone;
next_run_date TIMESTAMP with time zone;
no_of_days PLS_INTEGER DEFAULT 7;

BEGIN
-- Set start_date NOT TO INCLUDE TZ   
start_date := to_timestamp_tz('22-OCT-2014 14:00:00' ,'DD-MON-YYYY HH24:MI:SS');
return_date_after := start_date;

FOR i IN 1..no_of_days LOOP
DBMS_SCHEDULER.EVALUATE_CALENDAR_STRING( 
interval_string
,start_date
,return_date_after
,next_run_date);

DBMS_OUTPUT.PUT_LINE('Next Run: ' ||to_char(next_run_date, 'DY DD-MON-YYYY HH24:MI:SS TZD TZH TZR'));
return_date_after := next_run_date;
END LOOP;
END;
/

Next Run: THU 23-OCT-2014 14:00:00  +00 +00:00
Next Run: FRI 24-OCT-2014 14:00:00  +00 +00:00
Next Run: SAT 25-OCT-2014 14:00:00  +00 +00:00
Next Run: SUN 26-OCT-2014 14:00:00  +00 +00:00
Next Run: MON 27-OCT-2014 14:00:00  +00 +00:00
Next Run: TUE 28-OCT-2014 14:00:00  +00 +00:00
Next Run: WED 29-OCT-2014 14:00:00  +00 +00:00

PL/SQL procedure successfully completed.

The important thing to note here, is that my START_DATE didn’t include a time zone:

start_date := to_timestamp_tz('22-OCT-2014 14:00:00' ,'DD-MON-YYYY HH24:MI:SS')

Running the same procedure again, but this time including the TZ in the START_DATE yielded the results we’d expect to see:

-- New BST TZ
DECLARE
-- Set repeat interval
interval_string VARCHAR2(100) DEFAULT 'FREQ=DAILY;BYDAY=MON,TUE,WED,THU,FRI,SAT,SUN;BYHOUR=14';
start_date TIMESTAMP with time zone;
return_date_after TIMESTAMP with time zone;
next_run_date TIMESTAMP with time zone;
no_of_days PLS_INTEGER DEFAULT 7;

BEGIN
-- Set start_date NOT TO INCLUDE TZ
--start_date := to_timestamp_tz('22-OCT-2014 14:00:00' ,'DD-MON-YYYY HH24:MI:SS');

-- Set start_date TO INCLUDE TZ
start_date := to_timestamp_tz('22-OCT-2014 14:00:00 Europe/London' ,'DD-MON-YYYY HH24:MI:SS TZR');
return_date_after := start_date;

FOR i IN 1..no_of_days LOOP
DBMS_SCHEDULER.EVALUATE_CALENDAR_STRING(
interval_string
,start_date
,return_date_after
,next_run_date);

DBMS_OUTPUT.PUT_LINE('Next Run: ' ||to_char(next_run_date, 'DY DD-MON-YYYY HH24:MI:SS TZD TZH TZR'));
return_date_after := next_run_date;
END LOOP;
END;
/

Next Run: THU 23-OCT-2014 14:00:00 BST +01 EUROPE/LONDON
Next Run: FRI 24-OCT-2014 14:00:00 BST +01 EUROPE/LONDON
Next Run: SAT 25-OCT-2014 14:00:00 BST +01 EUROPE/LONDON
Next Run: SUN 26-OCT-2014 14:00:00 GMT +00 EUROPE/LONDON
Next Run: MON 27-OCT-2014 14:00:00 GMT +00 EUROPE/LONDON
Next Run: TUE 28-OCT-2014 14:00:00 GMT +00 EUROPE/LONDON
Next Run: WED 29-OCT-2014 14:00:00 GMT +00 EUROPE/LONDON

PL/SQL procedure successfully completed.
NOTE: The START_DATE used this time included the time zone:

start_date := to_timestamp_tz('22-OCT-2014 14:00:00 Europe/London' ,'DD-MON-YYYY HH24:MI:SS TZR');
So if you don’t specify a start date to include your TZ, it’ll pickup your session level TZ, which is most likely set incorrectly and take that into account for the next run date.  You’ll then end up with jobs created during GMT running on time throughout GMT (30/03/2014-26/10/2014 in our case), but then they’ll be 1 hour out during BST, which is what we’d been seeing with the job scheduler for this particular database.

There are other scenarios and conditions where the session TZ is used too, so as per Oracle’s recommendation (see MOS Doc 467722.1):

…the best option is to always specify a full start date with a timezone name that uses the DST rules you expect or to use for example CURRENT_TIMESTAMP and set the session timezone first to the timezone name that uses the DST rules you expect.

What did I do to fix this?

It’s pretty simple really, for my test job, I just updated the START_DATE to include the correct TZ:

BEGIN
DBMS_SCHEDULER.SET_ATTRIBUTE (
   name                 => 'HR.MY_JOB',
   attribute            => 'start_date',
   value                => TO_TIMESTAMP_TZ('22-OCT-2014 14:00:00 Europe/London' ,'DD-MON-YYYY HH24:MI:SS TZR'));
END;
/

PL/SQL procedure successfully completed.

SELECT owner, 
       job_name, 
       start_date, 
       next_run_date 
FROM   dba_scheduler_jobs 
WHERE  owner = 'HR';

OWNER        JOB_NAME       START_DATE                               NEXT_RUN_DATE
------------ -------------- ---------------------------------------- ---------------------------------------
HR           MY_JOB         22-OCT-14 14.00.00.000000 EUROPE/LONDON  01-NOV-14 14.00.00.400000 EUROPE/LONDON
By the way, if anyone’s wondering where the EUROPE/LISBON TZ came from for the SYS jobs earlier on, that’s what the default DBMS_SCHEDULER TZ was set to on that database:

SELECT * 
FROM   dba_scheduler_global_attribute 
WHERE  attribute_name = 'DEFAULT_TIMEZONE'; 

ATTRIBUTE_NAME                 VALUE
------------------------------ ---------------------
DEFAULT_TIMEZONE               Europe/Lisbon
That’s something else I’ve learnt this week :)

References:
Configuring Oracle Scheduler – Setting Scheduler Preferences
Pythian – Have Your Scheduler Jobs Changed Run Times Since DST ??
Scheduler (DBMS_SCHEDULER) in Oracle Database 10g – Time Zones

Procedimento feito na Lasa
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



SQL> set lines 500 pages 500
SQL> /

    Log ID Job Name                  Log Date                             Actual Start Date
---------- ------------------------- ------------------------------------ ------------------------------------
    364730 CLIENTE_UNICO             2015/10/21 08:24:24.842429 -02:00    2015/10/21 07:30:00.371494 -02:00
    363953 CLIENTE_UNICO             2015/10/20 08:22:41.264297 -02:00    2015/10/20 07:30:00.159577 -02:00
    363493 CLIENTE_UNICO             2015/10/19 08:12:01.844681 -02:00    2015/10/19 07:30:01.112852 -02:00
    363238 CLIENTE_UNICO             2015/10/18 08:29:11.646736 -02:00    2015/10/18 07:30:00.878843 -02:00
    362893 CLIENTE_UNICO             2015/10/17 07:25:50.168821 -03:00    2015/10/17 07:30:00.797966 -02:00
    362494 CLIENTE_UNICO             2015/10/16 07:17:50.601453 -03:00    2015/10/16 07:30:00.637738 -02:00
    362194 CLIENTE_UNICO             2015/10/15 07:27:52.672077 -03:00    2015/10/15 07:30:00.540247 -02:00
    361914 CLIENTE_UNICO             2015/10/14 07:32:55.153403 -03:00    2015/10/14 07:30:00.371838 -02:00
    361593 CLIENTE_UNICO             2015/10/13 07:29:12.253410 -03:00    2015/10/13 07:30:00.266587 -02:00
    361253 CLIENTE_UNICO             2015/10/12 07:24:24.486054 -03:00    2015/10/12 07:30:01.018281 -02:00
    359954 CLIENTE_UNICO             2015/10/11 08:02:58.763630 -03:00    2015/10/11 07:30:00.905413 -02:00
    358773 CLIENTE_UNICO             2015/10/10 08:15:12.634730 -03:00    2015/10/10 07:30:00.750281 -02:00
    357974 CLIENTE_UNICO             2015/10/09 07:26:06.622784 -03:00    2015/10/09 07:30:00.636410 -02:00
    356813 CLIENTE_UNICO             2015/10/08 07:34:14.542438 -03:00    2015/10/08 07:30:00.420604 -02:00
    355814 CLIENTE_UNICO             2015/10/07 07:19:11.327560 -03:00    2015/10/07 07:30:00.293899 -02:00
    354714 CLIENTE_UNICO             2015/10/06 07:16:27.617704 -03:00    2015/10/06 07:30:01.018285 -02:00
    353594 CLIENTE_UNICO             2015/10/05 07:06:20.679190 -03:00    2015/10/05 07:30:00.584958 -02:00
    352393 CLIENTE_UNICO             2015/10/04 07:25:31.420237 -03:00    2015/10/04 07:30:00.513297 -02:00
    351037 CLIENTE_UNICO             2015/10/03 07:19:44.146122 -03:00    2015/10/03 07:30:00.411761 -02:00
    349994 CLIENTE_UNICO             2015/10/02 07:24:03.759175 -03:00    2015/10/02 07:30:00.248483 -02:00
    349059 CLIENTE_UNICO             2015/10/01 07:11:13.008983 -03:00    2015/10/01 07:30:00.220412 -02:00
    348115 CLIENTE_UNICO             2015/09/30 07:05:28.231958 -03:00    2015/09/30 07:30:00.171320 -02:00
    347002 CLIENTE_UNICO             2015/09/29 07:00:56.737415 -03:00    2015/09/29 07:30:00.978155 -02:00
    346454 CLIENTE_UNICO             2015/09/28 06:56:56.774296 -03:00    2015/09/28 07:30:00.926049 -02:00
    345460 CLIENTE_UNICO             2015/09/27 07:12:06.952578 -03:00    2015/09/27 07:30:00.841071 -02:00
    344822 CLIENTE_UNICO             2015/09/26 07:08:10.268569 -03:00    2015/09/26 07:30:00.782885 -02:00
    343894 CLIENTE_UNICO             2015/09/25 07:12:27.750353 -03:00    2015/09/25 07:30:00.663984 -02:00
    342993 CLIENTE_UNICO             2015/09/24 07:05:26.474221 -03:00    2015/09/24 07:30:00.606134 -02:00
    341997 CLIENTE_UNICO             2015/09/23 07:06:55.874705 -03:00    2015/09/23 07:30:00.447683 -02:00
    341213 CLIENTE_UNICO             2015/09/22 07:03:52.019466 -03:00    2015/09/22 07:30:00.350184 -02:00

30 rows selected.

SQL> SELECT owner,
       job_name,
       start_date,
       next_run_date
FROM   dba_scheduler_jobs;  2    3    4    5

OWNER                          JOB_NAME                       START_DATE                                                                  NEXT_RUN_DATE
------------------------------ ------------------------------ --------------------------------------------------------------------------- ---------------------------------------------------------------------------
SYS                            CAMPANHA_RETORNO               22-JUN-15 07.00.00.000000 AM -03:00                                         22-OCT-15 07.00.00.700000 AM -03:00
SYS                            SAC_IMPORTAR                   12-JUN-15 04.00.00.000000 AM -03:00                                         22-OCT-15 04.00.00.500000 AM -03:00
SYS                            CLIENTE_BRADESCARD             19-MAY-14 06.20.00.000000 AM -03:00                                         22-OCT-15 06.20.00.900000 AM -03:00
SYS                            CLIENTE_INTERFACE              14-MAR-14 12.00.00.000000 AM -02:00                                         22-OCT-15 09.00.00.500000 AM -02:00
SYS                            XMLDB_NFS_CLEANUP_JOB
SYS                            SM$CLEAN_AUTO_SPLIT_MERGE      17-SEP-11 09.52.27.133715 AM PST8PDT                                        22-OCT-15 12.00.00.900000 AM AMERICA/RECIFE
SYS                            RSE$CLEAN_RECOVERABLE_SCRIPT   17-SEP-11 09.52.27.122955 AM PST8PDT                                        22-OCT-15 12.00.00.900000 AM AMERICA/RECIFE
SYS                            FGR$AUTOPURGE_JOB
SYS                            BSLN_MAINTAIN_STATS_JOB        18-SEP-11 12.00.00.000000 AM -07:00                                         25-OCT-15 12.00.00.600000 AM -07:00
SYS                            DRA_REEVALUATE_OPEN_FAILURES
SYS                            HM_CREATE_OFFLINE_DICTIONARY
SYS                            ORA$AUTOTASK_CLEAN             18-SEP-11 03.00.00.000000 AM PST8PDT                                        22-OCT-15 03.00.00.900000 AM AMERICA/RECIFE
SYS                            FILE_WATCHER
SYS                            PURGE_LOG                      18-SEP-11 03.00.00.200000 AM PST8PDT                                        22-OCT-15 03.00.00.900000 AM AMERICA/RECIFE
ORACLE_OCM                     MGMT_STATS_CONFIG_JOB          17-SEP-11 09.52.15.221975 AM -07:00                                         01-NOV-15 01.01.01.000000 AM -07:00
ORACLE_OCM                     MGMT_CONFIG_JOB
EXFSYS                         RLM$SCHDNEGACTION              22-OCT-15 01.05.21.000000 AM -02:00                                         22-OCT-15 01.05.21.000000 AM -02:00
EXFSYS                         RLM$EVTCLEANUP                 17-SEP-11 10.00.15.000000 AM -07:00                                         21-OCT-15 08.00.15.100000 PM -07:00
CLIUNICO                       CLIENTE_LIMPEZA_AUDITORIA      13-DEC-13 10.00.00.000000 PM -02:00                                         22-OCT-15 10.00.00.700000 PM -02:00
CLIUNICO                       CLIENTE_UNICO                  04-DEC-13 12.00.00.000000 AM -02:00                                         22-OCT-15 07.30.00.400000 AM -02:00

20 rows selected.

SQL> SELECT dbms_scheduler.stime FROM dual;

STIME
---------------------------------------------------------------------------
21-OCT-15 11.45.08.000639000 PM AMERICA/RECIFE

SQL> SELECT sessiontimezone FROM dual;

SESSIONTIMEZONE
---------------------------------------------------------------------------
-02:00

SQL> BEGIN
DBMS_SCHEDULER.SET_ATTRIBUTE (
   name                 => 'HR.MY_JOB',
   attribute            => 'start_date',
   value                => TO_TIMESTAMP_TZ('04-DEC-15 12:00:00 AMERICA/SAO_PAULO' ,'DD-MON-YY HH24:MI:SS TZR'));
END;
/
  2    3    4    5    6    7  BEGIN
*
ERROR at line 1:
ORA-27476: "HR.MY_JOB" does not exist
ORA-06512: at "SYS.DBMS_ISCHED", line 4450
ORA-06512: at "SYS.DBMS_SCHEDULER", line 2979
ORA-06512: at line 2


SQL> BEGIN
DBMS_SCHEDULER.SET_ATTRIBUTE (
   name                 => 'CLIUNICO.CLIENTE_UNICO',
   attribute            => 'start_date',
   value                => TO_TIMESTAMP_TZ('04-DEC-15 12:00:00 AMERICA/SAO_PAULO' ,'DD-MON-YY HH24:MI:SS TZR'));
END;
/
  2    3    4    5    6    7
PL/SQL procedure successfully completed.

SQL>
SQL> SELECT owner,
       job_name,
       start_date,
       next_run_date
FROM   dba_scheduler_jobs
WHERE  owner = 'CLIUNICO';  2    3    4    5    6

OWNER                          JOB_NAME                       START_DATE                                                                  NEXT_RUN_DATE
------------------------------ ------------------------------ --------------------------------------------------------------------------- ---------------------------------------------------------------------------
CLIUNICO                       CLIENTE_LIMPEZA_AUDITORIA      13-DEC-13 10.00.00.000000 PM -02:00                                         22-OCT-15 10.00.00.700000 PM -02:00
CLIUNICO                       CLIENTE_UNICO                  04-DEC-15 12.00.00.000000 PM AMERICA/SAO_PAULO                              05-DEC-15 07.30.00.000000 AM AMERICA/SAO_PAULO

SQL> BEGIN
DBMS_SCHEDULER.SET_ATTRIBUTE (
   name                 => 'CLIUNICO.CLIENTE_UNICO',
   attribute            => 'start_date',
   value                => TO_TIMESTAMP_TZ('04-OCT-15 12:00:00 AMERICA/SAO_PAULO' ,'DD-MON-YY HH24:MI:SS TZR'));
END;
/
  2    3    4    5    6    7
PL/SQL procedure successfully completed.

SQL>
SQL>
SELECT owner,
       job_name,
       start_date,
       next_run_date
FROM   dba_scheduler_jobs
WHERE  owner = 'CLIUNICO';SQL>   2    3    4    5    6

OWNER                          JOB_NAME                       START_DATE                                                                  NEXT_RUN_DATE
------------------------------ ------------------------------ --------------------------------------------------------------------------- ---------------------------------------------------------------------------
CLIUNICO                       CLIENTE_LIMPEZA_AUDITORIA      13-DEC-13 10.00.00.000000 PM -02:00                                         22-OCT-15 10.00.00.700000 PM -02:00
CLIUNICO                       CLIENTE_UNICO                  04-OCT-15 12.00.00.000000 PM AMERICA/SAO_PAULO                              22-OCT-15 07.30.00.500000 AM AMERICA/SAO_PAULO

SQL>
SELECT owner,
       job_name,
       start_date,
       next_run_date
FROM   dba_scheduler_jobs
WHERE  owner = 'CLIUNICO' AND job_name='CLIENTE_UNICO';SQL>   2    3    4    5    6

OWNER                          JOB_NAME                       START_DATE                                                                  NEXT_RUN_DATE
------------------------------ ------------------------------ --------------------------------------------------------------------------- ---------------------------------------------------------------------------
CLIUNICO                       CLIENTE_UNICO                  04-OCT-15 12.00.00.000000 PM AMERICA/SAO_PAULO                              22-OCT-15 07.30.00.500000 AM AMERICA/SAO_PAULO

SQL>
SQL> COL NEXT_RUN_DATE FORM A50
SQL> /

OWNER                          JOB_NAME                       START_DATE                                                                  NEXT_RUN_DATE
------------------------------ ------------------------------ --------------------------------------------------------------------------- --------------------------------------------------
CLIUNICO                       CLIENTE_UNICO                  04-OCT-15 12.00.00.000000 PM AMERICA/SAO_PAULO                              22-OCT-15 07.30.00.500000 AM AMERICA/SAO_PAULO

SQL>
SQL>
SQL>
SQL>
SQL>
SQL> SELECT dbms_scheduler.stime FROM dual;

STIME
---------------------------------------------------------------------------
22-OCT-15 12.00.05.919747000 AM AMERICA/RECIFE

SQL> select instance_name, host_name from v$instance;

INSTANCE_NAME    HOST_NAME
---------------- ----------------------------------------------------------------
BAPRD1           lasa-portaldb3

SQL>
SELECT owner,
       job_name,
       start_date,
       next_run_date
FROM   dba_scheduler_jobs
WHERE  owner = 'CLIUNICO' AND job_name='CLIENTE_UNICO';SQL>   2    3    4    5    6

OWNER                          JOB_NAME                       START_DATE                                                                  NEXT_RUN_DATE
------------------------------ ------------------------------ --------------------------------------------------------------------------- --------------------------------------------------
CLIUNICO                       CLIENTE_UNICO                  04-OCT-15 12.00.00.000000 PM AMERICA/SAO_PAULO                              22-OCT-15 07.30.00.500000 AM AMERICA/SAO_PAULO












