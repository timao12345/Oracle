SYS@gemcoprd1 > SYS@gemcoprd1 > select * from table(dbms_xplan.display);

PLAN_TABLE_OUTPUT
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Plan hash value: 461235517

------------------------------------------------------------------------------------------------------------------------
| Id  | Operation                                | Name                        | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                         |                             | 14296 |  2959K| 52662  (12)| 00:01:35 |
|   1 |  TABLE ACCESS BY INDEX ROWID             | CAD_FILIAL_ENCOMENDAPROD    |     1 |    11 |     3   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN                      | CAD_FIL_ENCOM_PROD_PK       |     1 |       |     2   (0)| 00:00:01 |
|*  3 |  COUNT STOPKEY                           |                             |       |       |            |          |
|*  4 |   TABLE ACCESS STORAGE FULL FIRST ROWS   | CEC_NGRID_NPF               |     1 |     8 |     7  (58)| 00:00:01 |
|*  5 |  HASH JOIN                               |                             | 14296 |  2959K| 52662  (12)| 00:01:35 |
|*  6 |   HASH JOIN                              |                             |  9377 |  1822K| 45297   (8)| 00:01:22 |
|   7 |    TABLE ACCESS STORAGE FULL             | CAD_SITPRO                  |     8 |   144 |     2   (0)| 00:00:01 |
|*  8 |    HASH JOIN                             |                             |  9377 |  1657K| 45294   (8)| 00:01:22 |
|   9 |     TABLE ACCESS STORAGE FULL            | CAD_SITPRO                  |     8 |    40 |     2   (0)| 00:00:01 |
|  10 |     NESTED LOOPS                         |                             |       |       |            |          |
|  11 |      NESTED LOOPS                        |                             | 11495 |  1975K| 45291   (8)| 00:01:22 |
|* 12 |       HASH JOIN                          |                             |  7709 |  1189K| 29825  (12)| 00:00:54 |
|* 13 |        HASH JOIN                         |                             |  7677 |  1072K| 29731  (12)| 00:00:54 |
|* 14 |         HASH JOIN                        |                             | 13734 |  1649K| 19881   (5)| 00:00:36 |
|* 15 |          TABLE ACCESS STORAGE FULL       | CAD_FORNE                   | 20035 |   371K|    90  (63)| 00:00:01 |
|* 16 |          HASH JOIN                       |                             | 13734 |  1394K| 19789   (4)| 00:00:36 |
|* 17 |           HASH JOIN                      |                             | 13734 |  1126K| 19067   (2)| 00:00:35 |
|* 18 |            HASH JOIN                     |                             | 19002 |  1224K| 18747   (1)| 00:00:34 |
|* 19 |             INDEX RANGE SCAN             | CEC_NGRID_ESTOQUE_EXP_IDX01 | 21046 |   164K|   249   (1)| 00:00:01 |
|  20 |             NESTED LOOPS                 |                             |   149K|  8448K| 18491   (1)| 00:00:34 |
|  21 |              NESTED LOOPS                |                             |     1 |    22 |     2   (0)| 00:00:01 |
|* 22 |               TABLE ACCESS BY INDEX ROWID| CAD_FILIAL                  |     1 |    10 |     1   (0)| 00:00:01 |
|* 23 |                INDEX UNIQUE SCAN         | CAD_FILIAL_PK               |     1 |       |     0   (0)| 00:00:01 |
|* 24 |               TABLE ACCESS BY INDEX ROWID| CAD_FILIAL_COMPL            |     1 |    12 |     1   (0)| 00:00:01 |
|* 25 |                INDEX UNIQUE SCAN         | CAD_FILIAL_COMPL_PK         |     1 |       |     0   (0)| 00:00:01 |
|* 26 |              TABLE ACCESS BY INDEX ROWID | CAD_PRODLOC                 |   149K|  5243K| 18489   (1)| 00:00:34 |<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
|* 27 |               INDEX RANGE SCAN           | CAD_PRODLOC_IDX_FILTP       |   139K|       |   847   (2)| 00:00:02 |
|* 28 |            TABLE ACCESS STORAGE FULL     | CAD_ITPROD                  |   119K|  2098K|   313  (62)| 00:00:01 |
|* 29 |           TABLE ACCESS STORAGE FULL      | CAD_PROD                    |   149K|  2927K|   716  (55)| 00:00:02 |
|* 30 |         TABLE ACCESS STORAGE FULL        | CAD_CUSTTAB                 | 83795 |  1636K|  9846  (26)| 00:00:18 |
|* 31 |        TABLE ACCESS STORAGE FULL         | CAD_EMBAL                   |   150K|  2203K|    87  (55)| 00:00:01 |
|* 32 |       INDEX UNIQUE SCAN                  | CAD_PRECO_PK                |     1 |       |     1   (0)| 00:00:01 |
|  33 |      TABLE ACCESS BY INDEX ROWID         | CAD_PRECO                   |     1 |    18 |     2   (0)| 00:00:01 |
|* 34 |   TABLE ACCESS STORAGE FULL              | VEN_PRODFIL                 |   150K|  1908K|  7358  (36)| 00:00:14 |
------------------------------------------------------------------------------------------------------------------------
HASH JOIN  não usa indice na junão de duas tabelas e cria um indice na hora, é mais rapido que o NESTED LOOPS
NESTED LOOPS usa indice na hora de juntar duas tabelas
Tudo que for access é porque foi no indice
filter é o que o aproveita do que foi retornado pelo indice, é ruim, esta lendo informação adcionais que ira jogar fora.


Predicate Information (identified by operation id):
---------------------------------------------------

   2 - access("E"."CODFIL"=:B1 AND "E"."CODPROD"=:B2)
   3 - filter(ROWNUM<=1)
   4 - filter("NPF"."CODITPROD"=:B1 AND "NPF"."CODFIL"=:B2)
   5 - access("L"."CODFIL"="V"."CODFIL" AND "I"."CODPROD"="V"."CODPROD")
   6 - access("P"."CODSITPROD"="S"."CODSITPROD")
   8 - access("SIT_ANT"."CODSITPROD"=NVL("P"."CODSITPRODANT",'NO'))
  12 - access("EMB"."CODPROD"="PR"."CODPROD")
  13 - access("TAB"."CODFIL"="L"."CODFIL" AND "TAB"."CODPROD"="PR"."CODPROD" AND
              "TAB"."CODFORNE"="PR"."CODFORNE")
  14 - access("PR"."CODFORNE"="FO"."CODFORNE")
  15 - storage(NVL("FO"."STATUS",0)<>8 AND NVL("FO"."FLIMPORTADO",'N')='N' AND NVL("FO"."STATUS",0)<>9)
       filter(NVL("FO"."STATUS",0)<>8 AND NVL("FO"."FLIMPORTADO",'N')='N' AND NVL("FO"."STATUS",0)<>9)
  16 - access("I"."CODPROD"="PR"."CODPROD")
  17 - access("I"."CODITPROD"="L"."CODITPROD")
  18 - access("L"."CODFIL"="EXP"."CODFIL" AND "L"."CODITPROD"="EXP"."CODITPROD")
  19 - access("EXP"."CODFIL"=TO_NUMBER(:P))
  22 - filter(NVL("F"."STATUS",0)<>9)
  23 - access("F"."CODFIL"=TO_NUMBER(:P))
  24 - filter("FC"."TPDEPOS"='D' OR "FC"."TPDEPOS"='L')
  25 - access("FC"."CODFIL"=TO_NUMBER(:P))
  26 - filter(("L"."CODMODABA"=1 OR "L"."CODMODABA"=2 OR "L"."CODMODABA"=3) AND ("FC"."TPDEPOS"='L' AND
              ("L"."CODMODABA"=2 OR "L"."CODMODABA"=3) OR "FC"."TPDEPOS"='D' AND ("L"."CODMODABA"=1 OR "L"."CODMODABA"=3)))
  27 - access("L"."CODFIL"=TO_NUMBER(:P) AND "FC"."TPDEPOS"="L"."TPDEPOS")
  28 - storage(NVL("I"."FLSALDO",'N')='N' AND NVL("I"."STATUS",0)<>9)
       filter(NVL("I"."FLSALDO",'N')='N' AND NVL("I"."STATUS",0)<>9)
  29 - storage(NVL("PR"."FLESTDIR",'N')='S')
       filter(NVL("PR"."FLESTDIR",'N')='S')
  30 - storage("TAB"."CODFIL"=TO_NUMBER(:P) AND "TAB"."CODEMBAL"=0)
       filter("TAB"."CODFIL"=TO_NUMBER(:P) AND "TAB"."CODEMBAL"=0)
  31 - storage("EMB"."CODEMBAL"=0)
       filter("EMB"."CODEMBAL"=0)
  32 - access("P"."CODFIL"=TO_NUMBER(:P) AND "P"."CODITPROD"="L"."CODITPROD" AND "P"."CODEMBAL"=0)
  34 - storage("V"."CODFIL"=TO_NUMBER(:P))
       filter("V"."CODFIL"=TO_NUMBER(:P))

79 rows selected.


SELECT L.CODFIL CODFIL,
       L.TPDEPOS TPDEPOS,
       I.CODITPROD CODITPROD,
       I.DIGITPROD DIGITPROD,
       L.FISICO FISICO,
       L.RESFIS RESFIS,
       L.TECNICO TECNICO,
       L.TRANSITO TRANSITO,
       L.MDV MDV,
       L.CODMODABA CODMODABA,
       NVL((SELECT E.FLENCOMENDA
             FROM gemcopd.CAD_FILIAL_ENCOMENDAPROD E
            WHERE E.CODFIL = L.CODFIL
              AND E.CODPROD = PR.CODPROD),
           'N') FLENCOMENDA,
       L.TPESTMINMAX TPESTMINMAX,
       L.MINQT MINQT,
       P.CODSITPROD CODSITPROD,
       S.DESCRICAO DESCRICAO,
       PR.CODFORNE CODFORNE,
       FO.DIGFORNE DIGFORNE,
       PR.CODFAM CODFAM,
       FO.PRAZOENT LEADTIME_FORNE,
       F.CODFILDIST CODFILDIST,
       L.CODORIGABASTEC CODORIGABASTEC,
       FC.ENTCROSSDOCKING_CEC ENTCROSSDOCKING_CEC,
       NVL(PR.FLCROSSDOCKING_CEC, 'N') FLCROSSDOCKING_PROD,
       NVL(FO.FLCROSSDOCKING_CEC, 'N') FLCROSSDOCKING_FORNE,
       NVL(FC.FLCROSSDOCKING_CEC, 'N') FLCROSSDOCKING_FILIAL,
       TAB.CIFFOB CIFFOB,
       EMB.QTEMBMOVIM QTEMBMOVIM,
       EMB.QTEMBMOVIMVENDA QTEMBMOVIMVENDA,
       V.CMUP CMUP,
       NVL(S.FLCOMPRA, 'N') FLCOMPRA_ATUAL,
       TRIM(P.CODSITPRODANT) CODSITPRODANT,
       NVL(SIT_ANT.FLCOMPRA, 'N') FLCOMPRA_ANT,
       NVL((SELECT 'SIM'
             FROM gemcopd.CEC_NGRID_NPF NPF
            WHERE NPF.CODFIL = L.CODFIL
              AND NPF.CODITPROD = L.CODITPROD
              AND ROWNUM <= 1),
           'NAO') NAO_PODE_FALTAR,
       NVL(PR.FLNUTILEBPAD, 'N') FLNUTILEBPAD,
       EMB.CODEMBAL CODEMBAL,
       PR.CODPROD CODPROD
  FROM gemcopd.CAD_PROD              PR,
       gemcopd.CAD_ITPROD            I,
       gemcopd.CAD_SITPRO            S,
       gemcopd.CAD_PRODLOC           L,
       gemcopd.CAD_PRECO             P,
       gemcopd.CAD_FILIAL_COMPL      FC,
       gemcopd.CAD_FILIAL            F,
       gemcopd.CAD_FORNE             FO,
       gemcopd.CAD_CUSTTAB           TAB,
       gemcopd.CAD_EMBAL             EMB,
       gemcopd.VEN_PRODFIL           V,
       gemcopd.CEC_NGRID_ESTOQUE_EXP EXP,
       CAD_SITPRO            SIT_ANT
WHERE P.CODFIL = :p
   AND L.CODFIL = F.CODFIL
   AND I.CODITPROD = L.CODITPROD
   AND F.CODFIL = FC.CODFIL
   AND P.CODFIL = L.CODFIL
   AND P.CODITPROD = L.CODITPROD
   AND FC.TPDEPOS = L.TPDEPOS
   AND P.CODSITPROD = S.CODSITPROD
   AND PR.CODFORNE = FO.CODFORNE
   AND I.CODPROD = PR.CODPROD
   AND NVL(I.STATUS, 0) <> 9
   AND NVL(F.STATUS, 0) <> 9
   AND NVL(FO.STATUS, 0) NOT IN (8, 9)
   AND NVL(I.FLSALDO, 'N') = 'N'
   AND NVL(FO.FLIMPORTADO, 'N') = 'N'
   AND NVL(PR.FLESTDIR, 'N') = 'S'
   AND P.CODEMBAL = EMB.CODEMBAL
   AND EMB.CODPROD = PR.CODPROD
   AND EMB.CODEMBAL = 0
   AND TAB.CODFIL = L.CODFIL
   AND TAB.CODPROD = PR.CODPROD
   AND TAB.CODFORNE = PR.CODFORNE
   AND TAB.CODEMBAL = P.CODEMBAL
   AND L.CODFIL = V.CODFIL
   AND I.CODPROD = V.CODPROD
   AND L.CODFIL = EXP.CODFIL
   AND L.CODITPROD = EXP.CODITPROD
   AND ((FC.TPDEPOS = 'L' AND L.CODMODABA IN (2, 3)) OR (FC.TPDEPOS = 'D' AND L.CODMODABA IN (1, 3)))
   AND NVL(P.CODSITPRODANT, 'NO') = SIT_ANT.CODSITPROD;
   
   