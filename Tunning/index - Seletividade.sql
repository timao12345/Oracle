set tab off
col "Percentual" for a10
select index_name,
    num_rows,
    distinct_keys "Qtde linhas diferentes",
    round(distinct_keys/num_rows,2) "Seletividade",
    LPAD(round(distinct_keys/num_rows,2)*100||' %',10,' ') "Percentual"
from dba_indexes
where table_name = 'FO_REGLAS_NEGOCIO_DETALLE'LUCAS @ kpvprd > select index_name,
  2      num_rows,
  3      distinct_keys "Qtde linhas diferentes",
  4      round(distinct_keys/num_rows,2) "Seletividade",
  5      LPAD(round(distinct_keys/num_rows,2)*100||' %',10,' ') "Percentual"
  6  from dba_indexes
  7  where table_name = 'FO_REGLAS_NEGOCIO_DETALLE'
  8  order by index_name;

INDEX_NAME                                                                                                                      |  NUM_ROWS|Qtde linhas diferentes|Seletividade|Percentual
--------------------------------------------------------------------------------------------------------------------------------|----------|----------------------|------------|----------
FK_FOREGLANEGOCDETAL_FOCONVE                                                                                                    |     11374|                 11339|           1|     100 %
FK_FOREGNEGDET_FOREGNEGXNIVPES                                                                                                  |   7055839|                    70|           0|       0 %
FK_GRUPO_PROD                                                                                                                   |   7055839|                    17|           0|       0 %
FK_REGLAS_DET_BENEFICIO                                                                                                         |   7055839|                   411|           0|       0 %
FK_REGLAS_DET_EMPRESA                                                                                                           |   7055839|                     1|           0|       0 %
FK_REGLAS_DET_FO_CUENTAS                                                                                                        |   7055839|                   545|           0|       0 %
FK_REGLAS_DET_FO_CUENTAS1                                                                                                       |   7055839|                213143|         ,03|       3 %
FK_REGLAS_DET_FO_CUENTAS2                                                                                                       |   7055839|               6769977|         ,96|      96 %
FK_REGLAS_DET_NIVELES                                                                                                           |   7055839|                     7|           0|       0 %
FK_REGLAS_DET_TIPSALDO                                                                                                          |   7055839|                     1|           0|       0 %
FK_REGLAS_PRODUCTO                                                                                                              |   7055839|                   544|           0|       0 %
IDX_REGLAS_DET_BE_NEW                                                                                                           |   7055839|                   915|           0|       0 %
IDX_REGLAS_DET_BP_NEW                                                                                                           |   7055839|               6776800|         ,96|      96 %
IDX_REGLAS_DET_CC_NEW                                                                                                           |   7055839|                472736|         ,07|       7 %
IDX_REGLAS_DET_CI_NEW                                                                                                           |   7055839|               6775989|         ,96|      96 %
IDX_REGLAS_DET_CM_NEW                                                                                                           |   7055839|                  3961|           0|       0 %
IDX_REGLAS_DET_EM_NEW                                                                                                           |   7055839|                    70|           0|       0 %
IDX_REGLAS_DET_GR_NEW                                                                                                           |   7055839|                   143|           0|       0 %
IDX_REGLAS_DET_PR_NEW                                                                                                           |   7055839|                  4225|           0|       0 %
IDX_REGLAS_DET_TA_NEW                                                                                                           |   7055839|                    70|           0|       0 %
IDX_REGLAS_DET_TP_NEW                                                                                                           |   7055839|               6776015|         ,96|      96 %
IDX_REGLAS_DET_TS_NEW                                                                                                           |   7055839|                    70|           0|       0 %
PK_REGLAS_NEGOCIO_DET                                                                                                           |   7055839|               7055839|           1|     100 %
UK_REGLAS_BENEFICIO                                                                                                             |   7055839|               6776800|         ,96|      96 %


order by index_name;


exec dbms_stats.gather_table_stats('CONSINCO','RF_APURAPCANALITICA', method_opt=>'for all columns size 1');

-- quantidade de linhas diferentes em uma tabela
select column_name,num_distinct,density from dba_tab_col_statistics where table_name = 'RF_APURAPCANALITICA';

-- verifica seletividade de uma tabela para ajudar a criar um index nos campos que são mais seletivos
select
   min(x) menor_grupo,
  max(x) maior_grupo,
  sum(x) total_linhas,
  100*avg(x)/sum(x) pct_seletividade
from (select count(*) x from USR_MS_FIDELIDADE.TB_RESGATE
      group by ID_BENEFICIO,CD_RESGATE_STATUS,ID_RESGATE_LYT,CDS_CPF,DT_NASCIMENTO,DT_EXPIRACAO); 



declare
  lv_ret BOOLEAN;
  begin
  lv_ret :=dbms_repair.online_index_clean(94771);
end;
/