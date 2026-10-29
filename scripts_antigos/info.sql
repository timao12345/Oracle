set termout       off
set echo          off
set feedback      off
set verify        off
set wrap          on
set trimspool     on
set serveroutput  on
set escape        on
prompt 
prompt 
prompt INFORMACÃO INSTANCE
prompt ===================
SET PAGES 10000 LINES 130
COLUMN instance_name       FORMAT a20    HEAD 'Nome|Instance'
COLUMN host_name           FORMAT a20    HEAD 'Host|Name'
alter session set nls_date_format = 'DD/MM/RRRR HH24:MI:SS' ;
SELECT
    instance_name   instance_name
  , host_name       host_name
FROM v$instance
/
prompt
prompt
prompt
prompt INFORMACÃO USUÁRIOS
prompt ===================
SET PAGES 10000 LINES 130
COLUMN username            FORMAT a25 
COLUMN profile             FORMAT a45 
select USERNAME, PROFILE from dba_users order by USERNAME, PROFILE ; 
prompt 
prompt
prompt
prompt INFORMACÃO PROFILES
prompt ===================
SET PAGES 10000 LINES 130
COLUMN PROFILE            FORMAT a45 
COLUMN RESOURCE_NAME      FORMAT a45 
select profile, RESOURCE_NAME from dba_profiles where RESOURCE_NAME like 'PASSWORD%' 
order by profile
/
prompt
prompt
prompt *****************************************************************************************                                                                                                                                         
