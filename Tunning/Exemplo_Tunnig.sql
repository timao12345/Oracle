Semppre iniciar Pelo Filtro

Operador diferente n�o usa indice.
Coluna abaixo tambem n�o usa o indice devido a fun��o NVL
AND NVL(I.STATUS, 0) <> 9

Ex: Cardinalidade:

Tabela abaixo possui em m�dia 260 mil resgistros bem distribuidos entre o valor S e N, quase a metade para cada um.
O indice seria util se por exemplo o N fosse menor que 10% do total, como � quase metade, este filtro tamebm n�o � bom para usar o indice.

Ira fazer join das duas tabelas
AND ((FC.TPDEPOS = 'L' AND L.CODMODABA IN (2, 3)) OR (FC.TPDEPOS = 'D' AND L.CODMODABA IN (1, 3)))


SYS@gemcoprd1 > select FLSALDO, count(1) from gemcopd.CAD_ITPROD group by FLSALDO order by 2;

F         COUNT(1)
- ----------------
                 1
S           111339
N           150660


Ver o quanto � seletivo
Contem 111 feliais 
SYS@gemcoprd1 > select P.CODFIL, count(1) from gemcopd.CAD_PRECO p group by P.CODFIL order by 2;

          CODFIL         COUNT(1)
---------------- ----------------
             555            11401
             546            12274
              15            12274
             557            12274
             940           120604
             527           124298
              27           124740
             603           147782
             628           147782
             866           283752
              16           303016
              47           316591
              53           340204
             524           358685
             629           360722
             622           360775
             719           360860
             639           362570
             613           362833
             513           362833
              38           364687
              32           364746
              39           364899
              25           364914
              45           364992
              42           365035
              29           365046
              26           365059
              41           365059
             936           365112
              24           365217
              22           365255
              69           365269
              67           365269
              48           365323
              40           365429
              46           365457
             619           365556
              19           365578
              37           365699
              18           365750
             522           365764
              59           365833
              49           365843
              70           365847
             633           365882
              33           365882
              71           365885
              28           365897
              62           366428
              63           366732
             413           367359
             105           367960
              36           367960
              50           369220
             943           369597
              13           369736
              52           369913
             953           370037
              12           370062
               4           370339
               9           370475
               6           370480
             813           370481
             839           370528
             829           370565
             846           370597
             822           370604
             824           370663
              10           370799
              17           370918
             519           370994
             819           371012
               3           371052
             533           371435
             833           371435
              14           372305
              51           372400
              11           373213
               5           373213
             539           373499
              34           373896
             934           373896
             671           374532
              57           374735
              58           374894
              55           375041
             958           375186
             551           375453
             806           375583
             809           375659
             810           375962
             959           376060
             851           376195
             834           377658
             609           378171
             651           379677
              65           379950
             510           380329
             509           380582
             506           384086
              54           384602
               1           387961
              31           394883
              68           394883
              35           394883
              56           394883
               2           398189
              30           401756
             529           402647
              99           404213

111 rows selected.


SYS@gemcoprd1 > select INDEX_NAME, COLUMN_NAME, COLUMN_POSITION from dba_ind_columns where INDEX_OWNER='GEMCOPD' and TABLE_NAME='CAD_PRECO' order by 1,3
  2  ;

INDEX_NAME                     COLUMN_NAME                                         COLUMN_POSITION
------------------------------ -------------------------------------------------- ----------------
CAD_PRECO_DTALTSITFL_IDX       DTALTSITFL                                                        1
CAD_PRECO_IDX_FILEMBSITPROD    CODFIL                                                            1
CAD_PRECO_IDX_FILEMBSITPROD    CODEMBAL                                                          2
CAD_PRECO_IDX_FILEMBSITPROD    CODSITPROD                                                        3
CAD_PRECO_IDX_ITPROD           CODITPROD                                                         1
CAD_PRECO_INDEX1               FLPROMOCAO                                                        1
CAD_PRECO_INDEX1               SYS_NC00060$                                                      2
CAD_PRECO_INDEX1               SYS_NC00061$                                                      3
CAD_PRECO_PK                   CODFIL                                                            1
CAD_PRECO_PK                   CODITPROD                                                         2
CAD_PRECO_PK                   CODEMBAL                                                          3


PLAN_TABLE_OUTPUT
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Plan hash value: 3103130365

------------------------------------------------------------------------------------------------------------------------
| Id  | Operation                                | Name                        | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                         |                             | 14660 |  3035K| 47212  (11)| 00:01:25 |
|   1 |  TABLE ACCESS BY INDEX ROWID             | CAD_FILIAL_ENCOMENDAPROD    |     1 |    11 |     3   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN                      | CAD_FIL_ENCOM_PROD_PK       |     1 |       |     2   (0)| 00:00:01 |
|*  3 |  COUNT STOPKEY                           |                             |       |       |            |          |
|*  4 |   TABLE ACCESS STORAGE FULL FIRST ROWS   | CEC_NGRID_NPF               |     1 |     8 |     7  (58)| 00:00:01 |
|*  5 |  HASH JOIN                               |                             | 14660 |  3035K| 47212  (11)| 00:01:25 |
|*  6 |   HASH JOIN                              |                             |  9003 |  1749K| 40453   (8)| 00:01:13 |
|*  7 |    HASH JOIN                             |                             |  8942 |  1606K| 40360   (8)| 00:01:13 |
|   8 |     TABLE ACCESS STORAGE FULL            | CAD_SITPRO                  |     8 |   144 |     2   (0)| 00:00:01 |
|*  9 |     HASH JOIN                            |                             |  8942 |  1449K| 40357   (8)| 00:01:13 |
|  10 |      TABLE ACCESS STORAGE FULL           | CAD_SITPRO                  |     8 |    40 |     2   (0)| 00:00:01 |
|  11 |      NESTED LOOPS                        |                             |       |       |            |          |
|  12 |       NESTED LOOPS                       |                             | 10943 |  1720K| 40354   (8)| 00:01:13 |
|* 13 |        HASH JOIN                         |                             |  6774 |   945K| 26779  (12)| 00:00:49 |
|* 14 |         HASH JOIN                        |                             |  8010 |   962K| 17252   (5)| 00:00:32 |
|* 15 |          TABLE ACCESS STORAGE FULL       | CAD_FORNE                   | 19856 |   368K|    89  (62)| 00:00:01 |
|* 16 |          HASH JOIN                       |                             | 11147 |  1132K| 17160   (5)| 00:00:31 |
|* 17 |           HASH JOIN                      |                             | 11147 |   914K| 16439   (3)| 00:00:30 |
|* 18 |            HASH JOIN                     |                             | 13712 |   883K| 16120   (1)| 00:00:29 |
|* 19 |             INDEX RANGE SCAN             | CEC_NGRID_ESTOQUE_EXP_IDX01 | 16240 |   126K|   234   (1)| 00:00:01 |
|  20 |             NESTED LOOPS                 |                             |   124K|  7059K| 15880   (1)| 00:00:29 |
|  21 |              NESTED LOOPS                |                             |     1 |    22 |     2   (0)| 00:00:01 |
|* 22 |               TABLE ACCESS BY INDEX ROWID| CAD_FILIAL                  |     1 |    10 |     1   (0)| 00:00:01 |
|* 23 |                INDEX UNIQUE SCAN         | CAD_FILIAL_PK               |     1 |       |     0   (0)| 00:00:01 |
|* 24 |               TABLE ACCESS BY INDEX ROWID| CAD_FILIAL_COMPL            |     1 |    12 |     1   (0)| 00:00:01 |
|* 25 |                INDEX UNIQUE SCAN         | CAD_FILIAL_COMPL_PK         |     1 |       |     0   (0)| 00:00:01 |
|* 26 |              TABLE ACCESS BY INDEX ROWID | CAD_PRODLOC                 |   124K|  4381K| 15878   (1)| 00:00:29 |
|* 27 |               INDEX RANGE SCAN           | CAD_PRODLOC_IDX_FILTP       |   116K|       |   846   (2)| 00:00:02 |
|* 28 |            TABLE ACCESS STORAGE FULL     | CAD_ITPROD                  |   119K|  2108K|   313  (62)| 00:00:01 |
|* 29 |           TABLE ACCESS STORAGE FULL      | CAD_PROD                    |   149K|  2917K|   715  (55)| 00:00:02 |
|* 30 |         TABLE ACCESS STORAGE FULL        | CAD_CUSTTAB                 |   126K|  2467K|  9522  (23)| 00:00:18 |
|* 31 |        INDEX UNIQUE SCAN                 | CAD_PRECO_PK                |     1 |       |     1   (0)| 00:00:01 |
|  32 |       TABLE ACCESS BY INDEX ROWID        | CAD_PRECO                   |     2 |    36 |     2   (0)| 00:00:01 |
|* 33 |    TABLE ACCESS STORAGE FULL             | CAD_EMBAL                   |   150K|  2203K|    87  (55)| 00:00:01 |
|* 34 |   TABLE ACCESS STORAGE FULL              | VEN_PRODFIL                 |   162K|  2068K|  6751  (30)| 00:00:13 |
------------------------------------------------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   2 - access("E"."CODFIL"=:B1 AND "E"."CODPROD"=:B2)
   3 - filter(ROWNUM<=1)
   4 - filter("NPF"."CODITPROD"=:B1 AND "NPF"."CODFIL"=:B2)
   5 - access("L"."CODFIL"="V"."CODFIL" AND "I"."CODPROD"="V"."CODPROD")
   6 - access("P"."CODEMBAL"="EMB"."CODEMBAL" AND "EMB"."CODPROD"="PR"."CODPROD")
   7 - access("P"."CODSITPROD"="S"."CODSITPROD")
   9 - access("SIT_ANT"."CODSITPROD"=NVL("P"."CODSITPRODANT",'NO'))
  13 - access("TAB"."CODFIL"="L"."CODFIL" AND "TAB"."CODPROD"="PR"."CODPROD" AND
              "TAB"."CODFORNE"="PR"."CODFORNE")
  14 - access("PR"."CODFORNE"="FO"."CODFORNE")
  15 - storage(NVL("FO"."STATUS",0)<>8 AND NVL("FO"."FLIMPORTADO",'N')='N' AND NVL("FO"."STATUS",0)<>9)
       filter(NVL("FO"."STATUS",0)<>8 AND NVL("FO"."FLIMPORTADO",'N')='N' AND NVL("FO"."STATUS",0)<>9)
  16 - access("I"."CODPROD"="PR"."CODPROD")
  17 - access("I"."CODITPROD"="L"."CODITPROD")
  18 - access("L"."CODFIL"="EXP"."CODFIL" AND "L"."CODITPROD"="EXP"."CODITPROD")
  19 - access("EXP"."CODFIL"=10)
  22 - filter(NVL("F"."STATUS",0)<>9)
  23 - access("F"."CODFIL"=10)
  24 - filter("FC"."TPDEPOS"='D' OR "FC"."TPDEPOS"='L')
  25 - access("FC"."CODFIL"=10)
  26 - filter(("L"."CODMODABA"=1 OR "L"."CODMODABA"=2 OR "L"."CODMODABA"=3) AND ("FC"."TPDEPOS"='L' AND
              ("L"."CODMODABA"=2 OR "L"."CODMODABA"=3) OR "FC"."TPDEPOS"='D' AND ("L"."CODMODABA"=1 OR "L"."CODMODABA"=3)))
  27 - access("L"."CODFIL"=10 AND "FC"."TPDEPOS"="L"."TPDEPOS")
  28 - storage(NVL("I"."FLSALDO",'N')='N' AND NVL("I"."STATUS",0)<>9)
       filter(NVL("I"."FLSALDO",'N')='N' AND NVL("I"."STATUS",0)<>9)
  29 - storage(NVL("PR"."FLESTDIR",'N')='S')
       filter(NVL("PR"."FLESTDIR",'N')='S')
  30 - storage("TAB"."CODFIL"=10 AND "TAB"."CODEMBAL"=0)
       filter("TAB"."CODFIL"=10 AND "TAB"."CODEMBAL"=0)
  31 - access("P"."CODFIL"=10 AND "P"."CODITPROD"="L"."CODITPROD" AND "P"."CODEMBAL"=0)
  33 - storage("EMB"."CODEMBAL"=0)
       filter("EMB"."CODEMBAL"=0)
  34 - storage("V"."CODFIL"=10)
       filter("V"."CODFIL"=10)

79 rows selected.

