set pages 100
set lines 150
col P2 for 999999999999
select event, SQL_ID, count(*)
from dba_hist_active_sess_history
where SQL_EXEC_START > to_date('10/04/2023 16:10:00','DD/MM/YYYY HH24:MI:SS')
and SQL_EXEC_START < to_date('19/04/2023 17:00:00','DD/MM/YYYY HH24:MI:SS')
AND event IN
   ('enq: TM - contention'
         , 'enq: TX - row lock contention'
        ,'enq: UL - contention'
        ,'enq: TX - allocate ITL entry'
        )
group by event, SQL_ID
order by 3,1;

EVENT                                                            SQL_ID          COUNT(*)
---------------------------------------------------------------- ------------- ----------
enq: TX - row lock contention                                    dgy3862hh48yy          1
enq: TX - row lock contention                                    2ak8nkqam9qj9          1
enq: TX - row lock contention                                    fb86sznht1tkv          1
enq: TX - row lock contention                                    1m0rr1j5pvvn3          3
enq: TX - row lock contention                                    79k50v8pqzxf0          6
enq: TX - row lock contention                                    22ucgawn9vrnm          8
enq: TX - row lock contention                                    d390fw58jt9x9      10457

7 rows selected.

SQL>


SQL> set pages 100
SQL> set lines 150
SQL> col P2 for 999999999999
SQL> select event, SQL_ID, count(*)
  2  from dba_hist_active_sess_history
  3  where SQL_EXEC_START > to_date('27/04/2018 19:00:00','DD/MM/YYYY HH24:MI:SS')
  4  and SQL_EXEC_START < to_date('27/04/2018 20:30:00','DD/MM/YYYY HH24:MI:SS')
  5  AND event IN
  6          ('enq: TM - contention'
  7          , 'enq: TX - row lock contention'
  8          ,'enq: UL - contention'
  9          ,'enq: TX - allocate ITL entry'
 10          )
 11  group by event, SQL_ID
 12  order by 3,1;

EVENT                                                            SQL_ID          COUNT(*)
---------------------------------------------------------------- ------------- ----------
enq: TX - row lock contention                                    4abdjpy25kf04          1
enq: TX - row lock contention                                    4p564pj5vqwca          1
enq: TX - row lock contention                                    3s28rjhzbk359          1
enq: TX - row lock contention                                    gvumdtkm65nm1          1
enq: TX - row lock contention                                    g97amak1xdj18          5
enq: TX - row lock contention                                    dgy3862hh48yy          5
enq: TX - row lock contention                                    a0f5mjzdbdh7u          5
enq: TX - row lock contention                                    6duyaz8bup2qh          8
enq: TX - row lock contention                                    6yf00c7k5auy6          9
enq: TX - row lock contention                                    266xq6gstsbf4          9
enq: TX - row lock contention                                    gg8crwbnwfdzw         45
enq: TX - row lock contention                                    gugsryy36f1uw         49
enq: TX - row lock contention                                    f5yuqamscm1xc         54
enq: TX - row lock contention                                    bmk4sy6vnyuzz         54
enq: TX - row lock contention                                    22ucgawn9vrnm         56
enq: TX - row lock contention                                    gp8mfdy1wb81k        269
enq: TX - row lock contention                                    d390fw58jt9x9       2721

17 rows selected.

SQL>


SQL> set long 2000
col SQL_TEXT for a2000
select SQL_ID, SQL_TEXT from DBA_HIST_SQLTEXT where SQL_ID = '&id_sql';SQL> SQL>
Enter value for id_sql: d390fw58jt9x9
old   1: select SQL_ID, SQL_TEXT from DBA_HIST_SQLTEXT where SQL_ID = '&id_sql'
new   1: select SQL_ID, SQL_TEXT from DBA_HIST_SQLTEXT where SQL_ID = 'd390fw58jt9x9'

SQL_ID
-------------
SQL_TEXT
------------------------------------------------------------------------------------------------------------------------------------------------------
d390fw58jt9x9
UPDATE GEMENSUSER   SET GMEN_CD = :1 ,    GMPA_CD = :2 ,    GEUS_CD = :3 ,    GMUS_DS_TEXTO = :4 ,    GMUS_DT_ENVIADO = :5 ,    GMUS_DT_LIDO = :6 ,
 GMUS_DT_CONFIRMADO = :7 ,    GMUS_DT_EXCLUIDO = :8 ,    GMUS_TP_RESTRICAO = :9 ,    GEUS_CD_LOG = :10 ,    DH_REF_LOG = :11 ,    GMUS_CD_AUX = :12 ,
   GMUS_DT_RESPONDIDO = :13 ,    GMUS_DT_ENCAMINHADO = :14 ,    GMUS_BO_CANCELADO = :15 ,    GEUS_CD_ORIGINAL = :16 ,    GMUS_TP = :17    WHERE GMUS_C
D = :18


SQL>
