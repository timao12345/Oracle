----------------------------------------------------------------------------------------
-- VERIFICAR DADOS ATRAV�S DO NOME DO SIN�NIMO
----------------------------------------------------------------------------------------

undef nomedosinonimo
set pagesize 5555
set linesize 500
col synonym_name for a30
col table_name for a30
col db_link for a30
col table_owner for a15
col owner for a15
select owner, synonym_name, table_owner, table_name, db_link
from dba_synonyms
where synonym_name =upper('&&nomedosinonimo')
order by owner;


undef nomedosinonimo
set pagesize 5555
set linesize 500
col synonym_name for a30
col table_name for a30
col db_link for a30
col table_owner for a15
col owner for a15
select owner, synonym_name, table_owner, table_name, db_link
from dba_synonyms
where owner ='OPERACAO'
order by owner;


undef nomedosinonimo
set pagesize 5555
set linesize 500
col synonym_name for a30
col table_name for a30
col db_link for a30
col table_owner for a15
col owner for a15
select owner, synonym_name, table_owner, table_name, db_link
from dba_synonyms
where table_name ='OCORRENCIA'
order by owner;


undef nomedosinonimo
set pagesize 5555
set linesize 500
col synonym_name for a30
col table_name for a30
col db_link for a30
col table_owner for a15
col owner for a15
select owner, synonym_name, table_owner, table_name, db_link
from dba_synonyms
where synonym_name ='FO_PREV_GARANT_MOVIMTOS'
order by owner;