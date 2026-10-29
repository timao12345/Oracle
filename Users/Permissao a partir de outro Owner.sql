-- CONCEDER PERMISS�ES ATRAV�S COM BASE EM OUTRO OWNER

select name from v$pbds;

alter session set container =SBM;

select distinct owner from dba_objects order by 1;

select 'grant select on SABRE_ODS.' || table_name || ' to CRM_Servicenow;' from dba_tables where owner ='SABRE_ODS';

select 'grant select on SABRE_ODS.' || view_name || ' to CRM_Servicenow;' from dba_views where owner ='SABRE_ODS';

select * from dba_tab_privs where grantee ='CRM_Servicenow';



col GRANTEE for a20
col OWNER for a15
col TABLE_NAME for a20
col PRIVILEGE for a20
SELECT GRANTEE, OWNER, TABLE_NAME, PRIVILEGE FROM DBA_TAB_PRIVS WHERE GRANTEE ='RDWMS17REC';


select * from user_sys_privs;