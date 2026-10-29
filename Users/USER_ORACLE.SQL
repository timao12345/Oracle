-- Create the user 
create user OPS$ORACLE
  identified externally
  default tablespace ???
  temporary tablespace ???
  profile DEFAULT;

-- Grant/Revoke role privileges 
grant dba to OPS$ORACLE;

-- Grant/Revoke system privileges 
grant unlimited tablespace to OPS$ORACLE;

-- Verifica tableas que estão com permissão
SELECT * FROM DBA_TAB_PRIVS WHERE GRANTEE = 'PBI_CCO';


---Retorna os grants de um usuário para aplicar em outro.

SET LINES 180 PAGES 9999
select 'grant ' || GRANTED_ROLE || upper(' to &&USER;')
from dba_role_privs
where  grantee = upper ('&&USER')
union all
select 'grant ' || PRIVILEGE || ' on ' || OWNER || '.' || TABLE_NAME || upper(' to &&USER;')
from dba_tab_privs
where  grantee = upper ('AERTON')
union all
select 'grant ' || PRIVILEGE || upper(' to &&USER;')
from dba_sys_privs
where  grantee = upper ('AERTON')
order by 1;
