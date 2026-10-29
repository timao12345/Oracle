set pagesize 5555
set linesize 1000
undef Sigla_Sistema
undef caminhoscript
undef caminhospool

SET HEAD OFF


prompt #########################################################
prompt ######GERAÇÃO DE SCRIPT DE GRANTS USUARIO - PEPSICO######
prompt #########################################################

SPO &&caminhoscript
select DISTINCT('grant '||privilege||' to &usuario ;')
from dba_sys_privs
where grantee = upper('&useridem');

select distinct('grant '||granted_role||' to &usuario ;')
from dba_role_privs
where grantee = upper('&useridem');

select distinct ('Grant '||privilege||' on '||owner||'.'||table_name||' to &usuario ;')
from dba_tab_privs
where grantee = upper('&useridem')
order by 1;

select distinct ('create synonym &usuario'||'.'||table_name||' for '||table_owner||'.'||table_name||';')
from dba_synonyms
where owner = upper('&useridem')
order by 1;

ACCEPT caminhospool   CHAR PROMPT 'Caminho completo do arquivo de spool a ser criado :  '

SPO &&caminhospool
prompt #########################################################
prompt #####EXECUÇÃO DO SCRIPT DE GRANTS USUARIO - PEPSICO######
prompt #########################################################
@&&caminhoscript

spo off
