Procedimento Refresh

/*define charset*/
set lines 150
select 'NLS_LANG='
|| ( select value from v$nls_parameters where parameter='NLS_LANGUAGE' )
|| '_'
|| ( select value from v$nls_parameters where parameter='NLS_TERRITORY' )
|| '.'
|| ( select value from v$nls_parameters where parameter='NLS_CHARACTERSET' )
language#
from dual;


/*Estimativa*/

expdp full=y userid=" '/ as sysdba' " ESTIMATE_ONLY=Y NOLOGFILE=Y

EXPORT

Neste caso esta sendo gerado export dos schemas 'RM_WORK' e 'RM_LIVE' que sera gerado no diretorio padrão= Refresh e tal tal tal

expdp 'userid="/ as sysdba"'
expdp 'userid="/ as sysdba"' schemas=RM_WORK,RM_LIVE directory=refresh dumpfile=refresh_02122011.dmp logfile=refresh_02122011.log compression=all



select 'create user '||USERNAME||' identified by values '||PASSWORD||' default tablespace '||DEFAULT_TABLESPACE||' temporary tablepace '||TEMPORARY_TABLESPACE||' profile '||PROFILE||';' from dba_users where username = upper('&USER');


IMPORT

No servidor de ser solicitado Import os comandos abaixo escluem os schemas a serem importados recriando vazios em suas devidas tablespaces hash de senha antiga

drop user RM_LIVE cascade;
drop user RM_WORK cascade;
create user RM_LIVE identified by values '386D93D147AB30B5' default tablespace SABRE_DATA profile DEFAULT;
create user RM_WORK identified by values '8C90A19C9852BAEC' default tablespace SABRE_DATA profile DEFAULT;


## Matando sessões ativas:

select 'alter system kill session ''''||sid||','||serial#||'''' from v$session where username = 'RM_LIVE';

Comando do import

impdp 'userid="/ as sysdba"' schemas=RM_WORK,RM_LIVE directory=refresh dumpfile=refresh_02122011.dmp logfile=refresh_02122011.log

Recompila objetos invalidos:

sqlplus / as sysdba @/u06/app/oracle/product/10.2.0/sabre/rdbms/admin/utlrp.sql


verificação:

select count(*) from dba_objects where owner='UE6OD';
select object_type, count(*) from dba_objects where owner='UE6OD' group by object_type;



