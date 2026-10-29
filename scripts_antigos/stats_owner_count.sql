|================================|
|   ESTATISTICS TABLES OF OWNER  |
|================================|

prompt ========================
prompt ESTATISTICAS das TABELAS
prompt ========================

UNDEF OWNER
COL TABELA FOR A30
select table_name||DECODE(temporary,'Y',' (Tmp.)','')||DECODE (PARTITIONED,'YES',' (Part.)','') TABELA,  num_rows REGISTROS, last_analyzed ULTIMA_COLETA from dba_tables where owner like decode(upper('&OWNER'),'ALL','%',null,user,upper('&OWNER')) order by 1,2,3
/