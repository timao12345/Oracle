set pages 100
set lines 150
col P2 for 999999999999
select event, SQL_ID, count(*)
from dba_hist_active_sess_history
where SQL_EXEC_START > to_date('01/10/2025 07:00:00','DD/MM/YYYY HH24:MI:SS')
and SQL_EXEC_START < to_date('09/12/2025 14:00:00','DD/MM/YYYY HH24:MI:SS')
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


SQL> set long 2000
col SQL_TEXT for a2000
select SQL_ID, SQL_TEXT from DBA_HIST_SQLTEXT where SQL_ID = '&id_sql';
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



agcnga4d2251c
SELECT * FROM "FKKDIHDTMP" "FKKDIHDTMP" WHERE "MANDT"=:A0 AND "PROGN"=:A1 AND "PROGID"=:A2 FOR UPDATE

fawxauyx1tpvy
UPDATE "FDSR" SET "WRSHB"="WRSHB"+:A0,"DMSHB"="DMSHB"+:A1 WHERE "MANDT"=:A2 AND "BUKRS"=:A3 AND "GSBER"=:A4 AND "GRUPP"=:A5 AND "EBENE"=:A6 AND "DISPW"=:A7 AND "DATUM"=:A8 AND "AVDAT"=:A9

9dcqzbbsq46yz
DELETE FROM "ZFI_TRACER_RUN" WHERE "MANDT"=:A0 AND "DATA"<=:A1

but912vqqqz2x
UPDATE "LFC1" SET "UM11S"="UM11S"+:A0,"UM11H"="UM11H"+:A1,"UM11U"="UM11U"+:A2 WHERE "MANDT"=:A3 AND "LIFNR"=:A4 AND "BUKRS"=:A5 AND "GJAHR"=:A6

gst615mfyydun
SELECT * FROM "NRIV" "NRIV" WHERE "CLIENT"=:A0 AND "OBJECT"=:A1 AND "SUBOBJECT"=:A2 AND "NRRANGENR"=:A3 AND "TOYEAR"=:A4 FOR UPDATE

