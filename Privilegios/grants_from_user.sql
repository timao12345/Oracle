set pagesize 5555
set linesize 1000
undef usuario
undef caminhoscript
undef caminhospool
undef useridem

SET HEAD OFF


prompt #########################################################
prompt ######GERAÇÃO DE SCRIPT DE GRANTS USUARIO - PEPSICO######
prompt #########################################################

SPO &&caminhoscript
select distinct ('Grant select on '||owner||'.'||TABLE_NAME||' to &usuario ;')
from dba_TAB_PRIVS
where GRANTEE =upper('&useridem')
order by 1;

select distinct ('create synonym &usuario'||'.'||TABLE_NAME||' for '||TABLE_owner||'.'||TABLE_NAME||';')
from dba_SYNONYMS
where owner =upper('&useridem')
order by 1;
spo off
ACCEPT caminhospool   CHAR PROMPT 'Caminho completo do arquivo de spool a ser criado :  '

SPO &&caminhospool
prompt #########################################################
prompt #####EXECUÇÃO DO SCRIPT DE GRANTS USUARIO - PEPSICO######
prompt #########################################################
@&&caminhoscript

spo off
