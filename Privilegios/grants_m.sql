undef OWNER
select 'grant ' || GRANTED_ROLE || ' to GEREPROJETOS;'
from dba_role_privs
where  grantee = upper ('&&OWNER')
union all
select 'grant ' || PRIVILEGE || ' on ' || OWNER || '.' || TABLE_NAME || ' to GEREPROJETOS;'
from dba_tab_privs
where  grantee = upper('&&OWNER')
union all
select 'grant ' || PRIVILEGE || ' to GEREPROJETOS;'
from dba_sys_privs
where  grantee = upper ('&&OWNER')
order by 1;




grant execute on envia_email_lock to central;

grant update on sys.envia_email_lock to central;




grant create type to NDD_NFSE_CONNECTOR;
grant create type to NDD_NFSE_COLD;