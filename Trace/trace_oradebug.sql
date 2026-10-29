Analise de performance e consumo de BD.
Classificação do chamado: Técnico
Boa tarde,

Necessitamos que seja feito uma an�lise pelo DBA em um de nossos programas afim de verificar o uso e consumo de recursos do banco conforme alinhado com o Bruno Verussa. 
Esta an�lise ser� feita em ECC QAS "leosaptb1".

JOB: MONITOR_EXPEDICAO_054
Hor�rio: Executado a cada minuto (J� em execu��o)
Programa: ZLMSDR054

Att.



   INST_ID USERNAME                       OS_PROCESS_ID            ORACLE_PROCESS_ID OSUSER                         MACHINE                                                          TERMINAL
---------- ------------------------------ ------------------------ ----------------- ------------------------------ ---------------------------------------------------------------- ------------------------------
         1 SAPSR3                         19202206                                30 eq1adm                         leosaptb1


SQL> oradebug setospid
ORA-00073: command SETOSPID takes between 1 and 1 argument(s)
SQL> oradebug setospid 19202206
Oracle pid: 30, Unix process pid: 19202206, image: oracle@leosaptb1

SQL> oradebug tracefile_name;
/oracle/EQ1/saptrace/diag/rdbms/eq1/EQ1/trace/EQ1_ora_19202206.trc

SQL> oradebug unlimit;
Statement processed.

SQL> oradebug event 10046 trace name context forever, level 12;
Statement processed.

SQL> exit
Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production
With the Partitioning, Automatic Storage Management, OLAP, Data Mining
and Real Application Testing options

285     tail -f /oracle/EQ1/saptrace/diag/rdbms/eq1/EQ1/trace/EQ1_ora_19202206.trc
286     sqlplus "/as sysdba"
287     tail -f /oracle/EQ1/saptrace/diag/rdbms/eq1/EQ1/trace/EQ1_ora_23003346.trc

tkprof /oracle/EQ1/saptrace/diag/rdbms/eq1/EQ1/trace/EQ1_ora_23003346.trc leo_ZLMSDR054.log sys=no waits=yes sort=prsela,exeela,fchela,prscpu,execnt,execpu,exemis,prscnt,exedsk 

tkprof /oracle/EQ1/saptrace/diag/rdbms/eq1/EQ1/trace/EQ1_ora_23003346.trc leo_ZLMSDR054_B.log sys=no waits=yes sort=exeela,prsela,fchela,prscpu,execnt,execpu,exemis,prscnt,exedsk 



RECOMMENDATION
--------------------------------------------------------------------------------
GENERAL INFORMATION SECTION
----------------------------------------------------------------------------
---
Tuning Task Name   : Leo_chnh3qq18mscf
Tuning Task Owner  : SYS
Workload Type      : Single SQL Statement
Scope              : COMPREHENSIVE
Time Limit(seconds): 180
Completion Status  : COMPLETED
Started at         : 02/20/2015 19:57:50
Completed at       : 02/20/2015 20:00:49

RECOMMENDATION
--------------------------------------------------------------------------------

------------------------------------------------------
-------------------------
Schema Name: SAPSR3
SQL ID     : chnh3qq18mscf
SQL Text   : SELECT * FROM "ZCSVAT015" WHERE "MANDT"=:A0
AND "STATUS"=:A1
Bind Variables :
 1 -  (CHAR(32)):500
 2 -  (CHAR(32)):03


RECOMMENDATION
--------------------------------------------------------------------------------
------------------------------------------------------
-------------------------
FINDINGS SECTION (2 findings)
--------------------------------------------------------------------------
-----

1- SQL Profile Finding (see explain plans section below)
--------------------------------------------------------
  A potentially better execution plan was found for this stat
ement.


RECOMMENDATION
--------------------------------------------------------------------------------
  Recommendation (estimated benefit: 59.89%)
  ------------------------------------------
  - Consider accepting the recommended SQL profile.
    execute dbms_sqltune.accept_sql_profile(task_name => 'Leo_chnh3qq18mscf',task_owner => 'SYS', replace => TRUE);

  Validation results
  ------------------
  The SQL profile was tested by executing both its plan and the original plan

RECOMMENDATION
--------------------------------------------------------------------------------
  and measuring their respective execution statistics. A plan may ha
ve been
  only partially executed if the other could be run to completion in l
ess time.

                           Original Plan  With SQL Profile  % Impro
ved
                           -------------  ----------------  ----------
  Completion Status:            COMPLETE          COMPL
ETE
  Elapsed Time (s):            4.916947           .224636      95.43 %

RECOMMENDATION
--------------------------------------------------------------------------------
  CPU Time (s):                 .398918           .1397
38      64.97 %
  User I/O Time (s):           4.280533                 0
   100 %
  Buffer Gets:                    36635             14694      59.89
%
  Physical Read Requests:           387                 0        100 %
  Physical Write Requests:            0                 0

  Physical Read Bytes:        295501824                 0        100 %
  Physical Write Bytes:               0                 0

RECOMMENDATION
--------------------------------------------------------------------------------

  Rows Processed:                     0                 0
  Fetches:                            0                 0
  Executions:                         1                 1

  Notes
  -----
  1. Statistics for the original plan were averaged over 1 executions.
  2. Statistics for the SQL profile plan were averaged over 5 execution
s.

RECOMMENDATION
--------------------------------------------------------------------------------

2- Index Finding (see explain plans section below)
--------------------------------------------------
  The execution plan of this statement can be improved by creating one or more
  indices.

  Recommendation (estimated benefit: 85.26%)
  ------------------------------------------
  - Consider running the Access Advisor to improve the physical schema design


RECOMMENDATION
--------------------------------------------------------------------------------
    or creating the recommended index.
    create index SAPSR3.IDX$$_4ED50001 on SAPSR3.ZCSVAT015("STATUS","MANDT");

  Rationale
  ---------
    Creating the recommended indices significantly improves the execution plan of this statement. However, it might be preferable to run "Access Advisor" using a representative SQL workload as opposed to a single

RECOMMENDATION
--------------------------------------------------------------------------------
statement. This will allow to get comprehensive index recommendations which takes into  account index maintenance overhead and additional space consumption.

---------------------------------------------------------------------
----------
EXPLAIN PLANS SECTION
-----------------------------------------------------------------------
--------

RECOMMENDATION
--------------------------------------------------------------------------------

1- Original With Adjusted Cost
------------------------------
Plan hash value: 2016119897

-------------------------------------------------------
------------------------
| Id  | Operation         | Name      | Rows  | Bytes
 | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------
--

RECOMMENDATION
--------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |           |    23 |  3197 | 10016   (1)| 00:02:
01 |
|*  1 |  TABLE ACCESS FULL| ZCSVAT015 |    23 |  3197 | 10016   (1)| 00:0
2:01 |
-----------------------------------------------------------------------
--------

Predicate Information (identified by operation id):
---------------------------------------------------

   1 - filter("STATUS"=:A1 AND "MANDT"=:A0)

RECOMMENDATION
--------------------------------------------------------------------------------

2- Using SQL Profile
--------------------
Plan hash value: 1783023722

-----------------------------------------------------
----------------------------------------
| Id  | Operation                   | Name          | Rows  | B
ytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------
--------------------

RECOMMENDATION
--------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |               |
23 |  3197 |   387   (7)| 00:00:05 |
|   1 |  TABLE ACCESS BY INDEX ROWID| ZCSVAT015     |    23 |  3197
 |   387   (7)| 00:00:05 |
|*  2 |   INDEX SKIP SCAN           | ZCSVAT015~Z01 |     1 |       |   386
 (7)| 00:00:05 |
-------------------------------------------------------------
--------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

RECOMMENDATION
--------------------------------------------------------------------------------

   2 - access("MANDT"=:A0 AND "STATUS"=:A1)
       filter("STATUS"=:A1)

3- Using New Indices
--------------------
Plan hash value: 3775081384

-----------------------------------------------------
-----------------------------------------
| Id  | Operation                   | Name           | Rows  |

RECOMMENDATION
--------------------------------------------------------------------------------
 Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------
-----------------------
|   0 | SELECT STATEMENT            |                |
    23 |  3197 |    57   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| ZCSVAT015      |    23 |
 3197 |    57   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX$$_4ED50001 |   157 |       |
   3   (0)| 00:00:01 |
-------------------------------------------------------
---------------------------------------

RECOMMENDATION
--------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   2 - access("STATUS"=:A1 AND "MANDT"=:A0)

-------------------------------------------------------------------
------------
