Consider unsetting database Parameter DB_FILE_MULTIBLOCK_READ_COUNT

db_file_multiblock_read_count parameter value = 16                              
db_file_multiblock_read_count isdefault value = FALSE  



Consider setting database parameter NLS_SORT to BINARY

nls_sort parameter value=                                                       
nls_sort parameter isdefault= TRUE    

If Checkpoints are not being completed the database may hang or experience performance degradation.  
Under this circumstance the alert.log will contain "checkpoint not complete" messages and it is recommended that the online redo logs be recreated with a larger size.

    Note: 265831.1 - Automatic Checkpoint Tuning in Oracle 10g
    Note: 147468.1 - Checkpoint Tuning and Troubleshooting Guide
	

Query dia 12-02-2015 16:00

	
SQL ordered by Reads  DB/Inst: RECH/RECH  Snaps: 76713-76723
-> End Disk Reads Threshold:      1000  Total Disk Reads:         415,566
-> Captured SQL accounts for    7.5% of Total Disk Reads
-> SQL reported below exceeded  1.0% of Total Disk Reads

                                                     CPU      Elapsd     Old
 Physical Reads  Executions  Reads per Exec %Total Time (s)  Time (s) Hash Value
--------------- ------------ -------------- ------ -------- --------- ----------
         21,728            1       21,728.0    5.2     2.43    538.52 2091401203
Module: dbaccess64opt@rechdata (TNS V1-V3)
SELECT 
D1_FILIAL,
D1_NFORI,
D1_SERIORI,
D1_ITEMORI,
D1_TIPO,
D1_PICM,
D1_BASEICM,
D1_VALICM,
D1_TES 
FROM TOTVSRECH.SD1040 SD1 WHERE  D1_FILIAL='08' 
AND D1_FORNECE = '000487' 
AND D1_LOJA = '08' 
AND D1_NFORI='000027912' 
AND D1_SERIORI='1' 
AND D1_ITEMORI='0012' 
AND D1_TIPO='I' AND D_E_L_E_T_=' '

          -------------------------------------------------------------
^LSQL ordered by Executions  DB/Inst: RECH/RECH  Snaps: 76713-76723
-> End Executions Threshold:       100  Total Executions:       6,795,577
-> Captured SQL accounts for   15.0% of Total Executions
-> SQL reported below exceeded  1.0% of Total Executions

                                                CPU per    Elap per     Old
 Executions   Rows Processed   Rows per Exec    Exec (s)   Exec (s)  Hash Value
------------ --------------- ---------------- ----------- ---------- ----------
     180,386         180,386              1.0       0.00        0.00 3686265474
Module: dbaccess64opt@rechdata (TNS V1-V3)
SELECT 
TSK_CODIGO,
TSK_ITEM,
TSK_ENV,
TSK_EMP,
TSK_FILIAL,
TSK_USERID,
TSK_DIA,
TSK_HORA,
TSK_ROTINA,
TSK_MODULO,
TSK_STATUS,
TSK_EXEC,TSK_TENTAT,TBL.D_E_L_E_T_ 
FROM CHDTSK TBL WHERE TBL.R_E_C_N_O_ = :1


SQL ordered by CPU  DB/Inst: RECH/RECH  Snaps: 76953-76963
	
    CPU                  CPU per             Elapsd                     Old
  Time (s)   Executions  Exec (s)  %Total   Time (s)    Buffer Gets  Hash Value
---------- ------------ ---------- ------ ---------- --------------- ----------
     32.56    1,167,122       0.00    1.2      30.24       3,492,671 1793166411
Module: dbaccess64opt@rechdata (TNS V1-V3)
SELECT * FROM SPED000 TBL WHERE TBL.R_E_C_N_O_ = :1


LSQL ordered by Gets  DB/Inst: RECH/RECH  Snaps: 76953-76963
                                                     CPU      Elapsd     Old
  Buffer Gets    Executions  Gets per Exec  %Total Time (s)  Time (s) Hash Value
--------------- ------------ -------------- ------ -------- --------- ----------
      4,122,980      824,173            5.0    1.6    13.74     14.58 2482976222
select intcol#,nvl(pos#,0),col#,nvl(spare1,0) from ccol$ where c
on#=:1

      3,492,671    1,167,122            3.0    1.4    32.56     30.24 1793166411
Module: dbaccess64opt@rechdata (TNS V1-V3)
SELECT * FROM SPED000 TBL WHERE TBL.R_E_C_N_O_ = :1
	
	
SQL> SELECT * FROM V$SGA_DYNAMIC_COMPONENTS;

COMPONENT                                                        CURRENT_SIZE   MIN_SIZE   MAX_SIZE USER_SPECIFIED_SIZE OPER_COUNT LAST_OPER_TYP LAST_OPER LAST_OPER GRANULE_SIZE
---------------------------------------------------------------- ------------ ---------- ---------- ------------------- ---------- ------------- --------- --------- ------------
shared pool                                                        1526726656 1275068416 2533359616                   0      10542 GROW          DEFERRED  19-FEB-15     16777216
large pool                                                           16777216   16777216   16777216                   0          0 STATIC                                16777216
java pool                                                            33554432   33554432   33554432                   0          0 STATIC                                16777216
streams pool                                                         16777216   16777216   50331648                   0       1542 SHRINK        DEFERRED  19-FEB-15     16777216
DEFAULT buffer cache                                               1.9864E+10 1.8841E+10 2.0116E+10                   0      12084 SHRINK        DEFERRED  19-FEB-15     16777216
KEEP buffer cache                                                           0          0          0                   0          0 STATIC                                16777216
RECYCLE buffer cache                                                        0          0          0                   0          0 STATIC                                16777216
DEFAULT 2K buffer cache                                                     0          0          0                   0          0 STATIC                                16777216
DEFAULT 4K buffer cache                                                     0          0          0                   0          0 STATIC                                16777216
DEFAULT 8K buffer cache                                                     0          0          0                   0          0 STATIC                                16777216
DEFAULT 16K buffer cache                                                    0          0          0                   0          0 STATIC                                16777216
DEFAULT 32K buffer cache                                                    0          0          0                   0          0 STATIC                                16777216
ASM Buffer Cache                                                            0          0          0                   0          0 STATIC                                16777216

13 rows selected.
	

SQL> select * from V$SGA_TARGET_ADVICE ;

  SGA_SIZE SGA_SIZE_FACTOR ESTD_DB_TIME ESTD_DB_TIME_FACTOR ESTD_PHYSICAL_READS
---------- --------------- ------------ ------------------- -------------------
     20480               1     19510139                   1          1444448718
      5120             .25     38940286              1.9959          4368735148
     10240              .5     29725648              1.5236          2986542169
     40960               2     12660129               .6489           136355959
     25600            1.25     16833348               .8628          1102692151
     30720             1.5     13941945               .7146           662279737
     35840            1.75     12708905               .6514           395201169
     15360             .75     23736035              1.2166          2084483945


	
SQL> select * from V$PGA_TARGET_ADVICE ;

PGA_TARGET_FOR_ESTIMATE PGA_TARGET_FACTOR ADV BYTES_PROCESSED ESTD_EXTRA_BYTES_RW ESTD_PGA_CACHE_HIT_PERCENTAGE ESTD_OVERALLOC_COUNT
----------------------- ----------------- --- --------------- ------------------- ----------------------------- --------------------
              629932032              .125 ON       1.2924E+13          1.1168E+12                            92                81756
             1259864064               .25 ON       1.2924E+13          5.0965E+10                           100                    0
             2519728128                .5 ON       1.2924E+13          2.0092E+10                           100                    0
             3779592192               .75 ON       1.2924E+13          2.0092E+10                           100                    0
             5039456256                 1 ON       1.2924E+13          1.9525E+10                           100                    0
             6047346688               1.2 ON       1.2924E+13          3856886784                           100                    0
             7055238144               1.4 ON       1.2924E+13          3856886784                           100                    0
             8063129600               1.6 ON       1.2924E+13          3856886784                           100                    0
             9071021056               1.8 ON       1.2924E+13          3856886784                           100                    0
             1.0079E+10                 2 ON       1.2924E+13          3856886784                           100                    0
             1.5118E+10                 3 ON       1.2924E+13          3856886784                           100                    0

PGA_TARGET_FOR_ESTIMATE PGA_TARGET_FACTOR ADV BYTES_PROCESSED ESTD_EXTRA_BYTES_RW ESTD_PGA_CACHE_HIT_PERCENTAGE ESTD_OVERALLOC_COUNT
----------------------- ----------------- --- --------------- ------------------- ----------------------------- --------------------
             2.0158E+10                 4 ON       1.2924E+13          3856886784                           100                    0
             3.0237E+10                 6 ON       1.2924E+13          3856886784                           100                    0
             4.0316E+10                 8 ON       1.2924E+13          3856886784                           100                    0

14 rows selected.


alter table TOTVSRECH.SF3070 enable row movement;
alter table TOTVSRECH.SF3070 shrink space compact;
alter table TOTVSRECH.SF3070 shrink space ;


alter table TOTVSRECH.CSB060 enable row movement;
alter table TOTVSRECH.CSB060 shrink space compact;
alter table TOTVSRECH.CSB060 shrink space ;



OWNER                          TABLE_NAME                     TABLESIZE_KB ACTUALTABLESIZE_KB      DIFF_KB
------------------------------ ------------------------------ ------------ ------------------ ------------
TOTVSRECH                      SF3070                              192,512             91,450      101,062
PERFSTAT                       STATS$SQL_SUMMARY                   195,064             87,326      107,738
TOTVSRECH                      SF2040                              987,080            876,010      111,070
SYS                            HISTGRM$                            145,416             22,161      123,255
TOTVSRECH                      CV3070                              694,976            571,114      123,862
TOTVSRECH                      CV3060                              572,416            443,798      128,618
TOTVSRECH                      CTK030                              505,664            374,524      131,140
TOTVSRECH                      SZH040                              131,440                  0      131,440
TOTVSRECH                      CSB060                              744,736            612,647      132,089
TOTVSRECH                      CT2060                              629,760            491,362      138,398
TOTVSRECH                      SC7040                              857,352            716,625      140,727
TOTVSRECH                      SCY040                              618,224            476,073      142,151
TOTVSRECH                      SD1060                              339,016            171,579      167,437
TOTVSRECH                      SE2040                            1,003,104            829,216      173,888
TOTVSRECH                      CTK070                              949,760            769,193      180,567
SYS                            IDL_UB1$                            181,232                659      180,573
TOTVSRECH                      SZN040                            1,094,776            909,794      184,982
TOTVSRECH                      CT2070                              958,208            745,258      212,950
TOTVSRECH                      SB1040                              833,408            613,757      219,651
TOTVSRECH                      SD1070                              433,248            209,955      223,293
TOTVSRECH                      CTK060                            1,063,592            836,306      227,286
TOTVSRECH                      SCJ040                              251,424             21,921      229,503
TOTVSRECH                      SC5040                            1,497,720          1,234,971      262,749
TOTVSRECH                      CT2020                            1,022,720            756,625      266,095
TOTVSRECH                      SE5040                            2,180,512          1,913,290      267,222
TOTVSRECH                      CT2030                            1,167,928            895,664      272,264
TOTVSRECH                      SF3040                            1,505,536          1,216,929      288,607
TOTVSRECH                      SE1070                              441,344            137,995      303,349
TOTVSRECH                      SC9040                            2,068,816          1,754,173      314,643
SPEDRECH                       TOP_IDXSTATS                      2,079,632          1,750,494      329,138
TOTVSRECH                      SCK060                              368,632             31,746      336,886
TOTVSRECH                      SC6040                            3,779,128          3,440,104      339,024
TOTVSRECH                      SFT070                              613,888            269,889      343,999
TOTVSRECH                      CD2040                            2,966,856          2,574,278      392,578
LMSRECH                        ELE_SCHEDULING_MESSAGE              408,448             11,857      396,591
SPEDRECH                       SPED052                           1,945,984          1,522,504      423,480
SPEDRECH                       SPED054                           1,670,744          1,243,866      426,878
SPEDRECH                       SPED154                             724,424            279,456      444,968
TOTVSRECH                      DA1040                              472,592                  0      472,592
TOTVSRECH                      CSB030                            2,675,568          2,166,509      509,059
TOTVSRECH                      SD2040                            4,089,824          3,572,550      517,274
TOTVSRECH                      ZZF040                              909,992            329,812      580,180
TOTVSRECH                      SFT040                            5,820,328          4,993,896      826,432
TOTVSRECH                      SCK040                            1,243,392             88,665    1,154,727
TOTVSRECH                      SE1040                            3,365,272          2,094,044    1,271,228
TOTVSRECH                      CV3040                            8,076,144          6,795,933    1,280,211
TOTVSRECH                      CTK040                            9,967,064          8,315,154    1,651,910
TOTVSRECH                      CT2040                            8,662,344          6,863,046    1,799,298
TOTVSRECH                      SD1040                            4,439,280          2,604,188    1,835,092
SPEDRECH                       SPED050                           2,710,400            725,814    1,984,586
TOTVSRECH                      CSB040                           19,010,656         15,685,597    3,325,059
TOTVSRECH                      TOP_IDXSTATS                     44,085,760         37,154,762    6,930,998

52 rows selected.


create table UOLDIVEO_DBA.tb_index_stats (name varchar2(40), del_lf_rows number,  lf_rows_used number, ibadness number);

begin
for i in (select owner, index_name from dba_indexes where owner='SAPR3')
   loop

    execute immediate 'ANALYZE INDEX '|| i.owner||'.'||i.index_name ||' VALIDATE STRUCTURE';

    insert into UOLDIVEO_DBA.tb_index_stats (SELECT name, 
                                        del_lf_rows, 
                                        lf_rows - del_lf_rows lf_rows_used
                                      , TO_CHAR( del_lf_rows /(DECODE(lf_rows,0,0.01,lf_rows))*100,'999.99999') ibadness
                                 FROM index_stats);
commit;
end loop;
end;
/

Se o valor da coluna IBADNESS da tabela UOLDIVEO_DBA.tb_index_stats for maior que 20, o indice é candidato a reduild.
este select concatena e gera script para recriar os indices

select 'alter index '||OWNER||'.'||index_name||' rebuild tablespace '||TABLESPACE_NAME||';' from dba_indexes WHERE  owner='SAPR3' and INDEX_NAME IN (SELECT NAME FROM UOLDIVEO_DBA.tb_index_stats WHERE ibadness >20);


