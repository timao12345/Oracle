set pagesize 5555
set linesize 1000
undef Sigla_Sistema
undef usuario
undef senha
undef tbs_default
undef caminhoscript
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

ACCEPT caminhoscript  CHAR PROMPT 'Caminho completo do script a ser criado :  '
ACCEPT User_base   CHAR PROMPT 'Nome do usuário a ser owner :  '

prompt #########################################################
prompt ######GERAÇÃO DE SCRIPT DE GRANTS USUARIO - PEPSICO######
prompt #########################################################
SPO &&caminhoscript


grant connect to &usuario;

select distinct ('Grant select on '||owner||'.'||object_name||' to &usuario ;')
from dba_objects
where owner = upper('&User_base')
and object_type in ('TABLE', 'VIEW')
order by 1;

select distinct ('create synonym &usuario'||'.'||object_name||' for '||owner||'.'||object_name||';')
from dba_objects
where owner = upper('&User_base')
and object_type in ('TABLE', 'VIEW')
order by 1;

ACCEPT caminhospool   CHAR PROMPT 'Caminho completo do arquivo de spool a ser criado :  '

SPO &&caminhospool
prompt #########################################################
prompt #####EXECUÇÃO DO SCRIPT DE GRANTS USUARIO - PEPSICO######
prompt #########################################################
@&&caminhoscript

spo off


