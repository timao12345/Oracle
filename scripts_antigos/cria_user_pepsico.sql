set pagesize 5555
set linesize 1000
undef Sigla_Sistema
undef usuario
undef senha
undef tbs_default
undef caminho_script
undef caminhospool

SET HEAD OFF

ACCEPT usuario   CHAR PROMPT 'Nome do usuario a ser criado :  '
ACCEPT senha   CHAR PROMPT 'Senha do usuario a ser criado :  '
ACCEPT tbs_default   CHAR PROMPT 'Tablespace Default para o usuario :  '

prompt #########################################################
prompt ######CRIACAO USUARIO CONSULTA APLICACAO - PEPSICO#######
prompt #########################################################

CREATE USER &usuario
identified by &senha
default tablespace &tbs_default
temporary tablespace temp
profile default;

ACCEPT caminho_script  CHAR PROMPT 'Caminho completo do script a ser criado :  '
ACCEPT Sigla_sistema   CHAR PROMPT 'Sigla do sistema (maiúsculo) :  '

prompt #########################################################
prompt ######GERAÇÃO DE SCRIPT DE GRANTS USUARIO - PEPSICO######
prompt #########################################################

SPO &&caminho_script
select DISTINCT('grant '||privilege||' to &usuario ;')
from dba_sys_privs
where grantee like '%&Sigla_sistema';

select distinct('grant '||granted_role||' to &usuario ;')
from dba_role_privs
where grantee like '%&Sigla_sistema';

select distinct ('Grant '||privilege||' on '||owner||'.'||table_name||' to &usuario ;')
from dba_tab_privs
where grantee like '%&Sigla_sistema'
order by 1;

select distinct ('create synonym &usuario'||'.'||table_name||' for '||table_owner||'.'||table_name||';')
from dba_synonyms
where owner like '%&Sigla_sistema'
and db_link is null
order by 1;

Select distinct ('create synonym &usuario'||'.'||table_name||' for '||table_name||'@'||db_link||';')
from dba_synonyms
where db_link is not null
and owner like '%&Sigla_sistema'
order by 1;

ACCEPT caminhospool   CHAR PROMPT 'Caminho completo do arquivo de spool a ser criado :  '

SPO &&caminhospool
prompt #########################################################
prompt #####EXECUÇÃO DO SCRIPT DE GRANTS USUARIO - PEPSICO######
prompt #########################################################
@&&caminho_script

spo off
