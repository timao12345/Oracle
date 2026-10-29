--Verificar quota utilizada dos usuarios
select 
    username,
    tablespace_name, 
    bytes/1024/1024 usado_MB,
    max_bytes/1024/1024 quota_Mb
from dba_ts_quotas 
where username='USUARIO'
--order by username;

--Verificar se o usuario tem acesso ilimitado na tablespace

col GRANTEE for a50
col PRIVILEGE for a50
col ADMIN_OPTION for a50
select GRANTEE,PRIVILEGE,ADMIN_OPTION 
from dba_sys_privs where GRANTEE='USUARIO' ;