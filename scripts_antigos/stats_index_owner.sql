|=============================|
|   ESTATISTICS INDEXS OWNER  |
|=============================|

prompt ========================
prompt ESTATISTICAS dos INDICES
prompt ========================

UNDEF OWNER
COL INDICE FOR A30
select index_name||DECODE(temporary,'Y',' (Tmp.)','')||DECODE (PARTITIONED,'YES',' (Part.)','') INDICE, last_analyzed ULTIMA_COLETA, status from dba_indexes where owner like decode(upper('&OWNER'),'ALL','%',null,user,upper('&OWNER')) order by 1,2,3
/