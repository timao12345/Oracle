spool StatisticsTables_CIM00313888.log
set echo on;
set timing on;

set pages 200

col index_owner form a10
col table_owner form a10
col last_analyzed for a30
col owner form a10

SELECT TO_CHAR (SYSDATE, 'MM-DD-YYYY HH24:MI:SS') "NOW" FROM DUAL;

BEGIN
prompt ==============================================
prompt Coleta Estatisticas Tabela -> DWT_DOCTO_FISCAL
prompt ==============================================
prompt
EXEC DBMS_STATS.GATHER_TABLE_STATS(OWNNAME=>'MSAF', TABNAME=>'DWT_DOCTO_FISCAL', ESTIMATE_PERCENT=>100, DEGREE => 6);

prompt ==============================================
prompt Coleta Estatisticas Tabela -> DWT_ITENS_MERC
prompt ==============================================
prompt
EXEC DBMS_STATS.GATHER_TABLE_STATS(OWNNAME=>'MSAF', TABNAME=>'DWT_ITENS_MERC', ESTIMATE_PERCENT=>100, DEGREE => 6);

prompt ==============================================
prompt Coleta Estatisticas Tabela -> X07_DOCTO_FISCAL
prompt ==============================================
prompt
EXEC DBMS_STATS.GATHER_TABLE_STATS(OWNNAME=>'MSAF', TABNAME=>'X07_DOCTO_FISCAL', ESTIMATE_PERCENT=>100, DEGREE => 6);

prompt ==============================================
prompt Coleta Estatisticas Tabela -> X07_BASE_DOCFIS
prompt ==============================================
prompt
EXEC DBMS_STATS.GATHER_TABLE_STATS(OWNNAME=>'MSAF', TABNAME=>'X07_BASE_DOCFIS', ESTIMATE_PERCENT=>100, DEGREE => 6);

prompt ==============================================
prompt Coleta Estatisticas Tabela -> X07_TRIB_DOCFIS
prompt ==============================================
prompt
EXEC DBMS_STATS.GATHER_TABLE_STATS(OWNNAME=>'MSAF', TABNAME=>'X07_TRIB_DOCFIS', ESTIMATE_PERCENT=>100, DEGREE => 6);

prompt ==============================================
prompt Coleta Estatisticas Tabela -> X08_ITENS_MERC
prompt ==============================================
prompt
EXEC DBMS_STATS.GATHER_TABLE_STATS(OWNNAME=>'MSAF', TABNAME=>'X08_ITENS_MERC', ESTIMATE_PERCENT=>100, DEGREE => 6);

prompt ==============================================
prompt Coleta Estatisticas Tabela -> X08_BASE_MERC
prompt ==============================================
prompt
EXEC DBMS_STATS.GATHER_TABLE_STATS(OWNNAME=>'MSAF', TABNAME=>'X08_BASE_MERC', ESTIMATE_PERCENT=>100, DEGREE => 6);

prompt ==============================================
prompt Coleta Estatisticas Tabela -> X08_TRIB_MERC
prompt ==============================================
prompt
EXEC DBMS_STATS.GATHER_TABLE_STATS(OWNNAME=>'MSAF', TABNAME=>'X08_TRIB_MERC', ESTIMATE_PERCENT=>100, DEGREE => 6);
END;
/

select owner,table_name,to_char(last_analyzed, 'DD/MM/YYYY HH24:MI:SS') as last_analyzed, global_stats
from dba_tables
where owner = 'MSAF'
and table_name in ('DWT_DOCTO_FISCAL','DWT_ITENS_MERC','X07_DOCTO_FISCAL','X07_BASE_DOCFIS','X07_TRIB_DOCFIS','X08_ITENS_MERC','X08_BASE_MERC','X08_TRIB_MERC');

spool off;

select owner, table_name from dba_tables where table_name in ('DWT_DOCTO_FISCAL','DWT_ITENS_MERC','X07_DOCTO_FISCAL','X07_BASE_DOCFIS','X07_TRIB_DOCFIS','X08_ITENS_MERC','X08_BASE_MERC','X08_TRIB_MERC');

DWT_DOCTO_FISCAL
DWT_ITENS_MERC
X07_DOCTO_FISCAL
X07_BASE_DOCFIS
X07_TRIB_DOCFIS
X08_ITENS_MERC
X08_BASE_MERC
X08_TRIB_MERC