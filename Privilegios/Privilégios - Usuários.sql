-- System privileges for a user -- 

SELECT PRIVILEGE
  FROM sys.dba_sys_privs
 WHERE grantee = 'ORACLE_BKP'
UNION
SELECT PRIVILEGE 
  FROM dba_role_privs rp JOIN role_sys_privs rsp ON (rp.granted_role = rsp.role)
 WHERE rp.grantee = 'ORACLE_BKP'
 ORDER BY 1;
 
 -- Direct grants to tables/views --
 
 SELECT owner, table_name, select_priv, insert_priv, delete_priv, update_priv, references_priv, alter_priv, index_priv 
  FROM table_privileges
 WHERE grantee = 'ORAPDE'
 ORDER BY owner, table_name;
 
-- Indirect grants to tables/views -- 

SELECT DISTINCT owner, table_name, PRIVILEGE, rp.GRANTED_ROLE 
  FROM dba_role_privs rp JOIN role_tab_privs rtp ON (rp.granted_role = rtp.role)
 WHERE rp.grantee = 'ORACLE_BKP'
 ORDER BY owner, table_name;


GRANT AUDIT ANY TO BACKUP;
GRANT AUDIT SYSTEM TO BACKUP;
GRANT SELECT ANY TABLE TO VIPCOMMERCE ;
grant select on ROSSIT_STATUS_ECOMM_LJ  to VIPCOMMERCE;

select * from dba_role_privs where grantee= 'ORACLE_BKP';