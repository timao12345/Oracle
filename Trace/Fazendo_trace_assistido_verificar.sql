SELECT s.inst_id, s.username, p.spid os_process_id, p.pid oracle_process_id, s.OSUSER, s.MACHINE, s.TERMINAL from gv$session s, gv$process p where s.paddr=p.ADDR and S.USERNAME='243812';

   INST_ID USERNAME                       OS_PROCESS_ID            ORACLE_PROCESS_ID OSUSER                         MACHINE                                                          TERMINAL
---------- ------------------------------ ------------------------ ----------------- ------------------------------ ---------------------------------------------------------------- ------------------------------
         1 243812                         2769                                    50 matera                         VMPAPPTB775                                                      unknown
         1 243812                         25169                                   50 matera                         VMPAPPTB775                                                      unknown

oradebug setospid 2769;

oradebug setospid 25169;
SQL> oradebug setospid 25169;
ORA-00072: process "25169" is not active



SELECT s.inst_id, s.username, p.spid os_process_id, p.pid oracle_process_id, s.OSUSER, s.MACHINE, s.TERMINAL from gv$session s, gv$process p where s.paddr=p.ADDR and S.USERNAME='243812';

SQL> oradebug setospid 2769;
Oracle pid: 50, Unix process pid: 2769, image: oracle@dbtb775anew
SQL> oradebug tracefile_name;
/u02/app/oracle/diag/rdbms/matera/matera1/trace/matera1_ora_2769.trc
SQL> oradebug unlimit;
Statement processed.
SQL> oradebug event 10046 trace name context forever, level 12;
Statement processed.


SELECT s.inst_id, s.username, p.spid os_process_id, p.pid oracle_process_id, s.OSUSER, s.MACHINE, s.TERMINAL from gv$session s, gv$process p where s.paddr=p.ADDR and S.MODULE='ZLMSDR054';

select OWNER,JOB_NAME,to_char(LOG_DATE,'dd/mm/yyyy hh24:mi:ss'),STATUS,RUN_DURATION,ADDITIONAL_INFO from DBA_SCHEDULER_JOB_RUN_DETAILS where JOB_NAME='MONITOR_EXPEDICAO_054' order by 3;