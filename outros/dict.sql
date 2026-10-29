----------------------------------------------------------------------------------------
-- PESQUISAR NA DICIONARIO POR PARTE DO NOME DA TABELA
----------------------------------------------------------------------------------------
set pagesize 5555
set linesize 198
col TABLE_NAME for a30
col COMMENTS for a60
undef PESQUISAR
select TABLE_NAME,  COMMENTS  from dict where TABLE_NAME like upper('%&&PESQUISAR%');


