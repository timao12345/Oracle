select 'grant ' || a.PRIVILEGE || ' on ' || a.OWNER || '.' || a.TABLE_NAME ||
       ' to ' || a.GRANTEE || decode(a.GRANTABLE, 'YES', ' with grant option;', ';')
  from dba_tab_privs a
 where a.OWNER = 'SAUDE'
   and a.GRANTEE = 'PRONTUARIO'
