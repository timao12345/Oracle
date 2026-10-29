-- verifica tablespaces padrão dos usuarios.
select USERNAME, CREATED, DEFAULT_TABLESPACE as DEF, TEMPORARY_TABLESPACE as TEMP from dba_users where username='USR_ALGUE' order by USERNAME asc;

--para verificar o caminho de criação do datafile
show parameter create;

--Criação de usuario 
create user RMAN identified by "BKP#vpc95175#"
default tablespace TBS_RMAN_PROD 
quota unlimited on TBS_RMAN_PROD
account unlock;
grant connect to RMAN;
grant resource to RMAN;
grant sysbackup to oracle_bkp;
grant RECOVERY_CATALOG_OWNER to RMAN;


create user C##ORACLE_BKP identified by "Ekl09#BZp01" CONTAINER=ALL;
account unlock;
grant connect to C##ORACLE_BKP  CONTAINER=ALL;
grant resource to C##ORACLE_BKP  CONTAINER=ALL;
grant sysbackup to C##ORACLE_BKP  CONTAINER=ALL;
grant sysdba to C##ORACLE_BKP  CONTAINER=ALL;
GRANT DBA TO C##ORACLE_BKP  container=ALL;
grant create session to C##ORACLE_BKP  CONTAINER=ALL;


grant connect to ORACLE_BKP;
grant sysbackup to ORACLE_BKP;
grant sysdba to ORACLE_BKP;
GRANT DBA TO ORACLE_BKP;

-- hash antigo do usuario dbskyone no container megacolorado
alter user "oracle_bkp" identified by values 'BKP01#bkp01';

alter user DBSKYONE identified by values 'S:EEAAED26FB3FC1A0D7490F1E567D503569B395A1351A7BC11D5C2BF0979E;T:DAC4D1E7CB0C1D88AB279725814CB3FFBCC219B5E51E09A0663D1BB7AF991A0FA701293B8C42B7CE027AD534BC30D5F187A80888C283853B8FD9E714B0E1C468C73BB265ABE4BD7FFE78CE59AF16C50E;204922D576095802';
--

alter user DBSKYONE identified by "Sky#n35eCwr7t!";

create user USR_ZABBIX identified by "Z@bBiFib#ril2023"
default tablespace USERS
PROFILE "PROFILE_SUPORT"
account unlock;

grant connect to USR_ZABBIX ;

GRANT "RL_READ" TO "USR_ZABBIX";
GRANT "RL_WRITE" TO "USR_ZABBIX";



CREATE USER "ORACLE_BKP" IDENTIFIED BY VALUES 'S:4E3D935ED203660142F9042C21CAF2760491CD7D047555BDEE72EB0672CD;T:CFE1322C671CAF867FAD45F8F1063215B3EA85B09116AE647BB0EDC5E890929ACDCC59C447B327040699842F141C8A5E79FFF8F521BD64B11F1E0D083FFFA1F00FAB7794CE2584204C5E1C577C053C01'
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";


--Ver as permissões do usuário criado
select * from user_sys_privs;

create user LSSKY identified by "blablabla"
account unlock;
grant connect to LSSKY;
grant resource to LSSKY;
grant all to LSSKY
grant EXP_FULL_DATABASE to LSSKY;
grant IMP_FULL_DATABASE to LSSKY;

create user USR_CELNE identified by "a0f3046b2d"
account unlock;
grant connect to USR_CELNE;
grant select on SIGO.VW_TTK_FULL to USR_CELNE;


create user DBIWSOSVIDARESGATE identified by "L9ZJbsIA"
default tablespace SOSVIDARESGATE_DT
quota unlimited on SOSVIDARESGATE_DT
quota unlimited on SOSVIDARESGATE_IDX
account unlock;

grant connect to DBIWSOSVIDARESGATE; DBIWSOSVIADARESGATE
grant create view to DBIWSOSVIDARESGATE;
grant create job to DBIWSOSVIDARESGATE;
grant resource to DBIWSOSVIDARESGATE;
grant DBA to DBIWSOSVIDARESGATE;


create user DBIWSAUDESUPORTE identified by "B1#d82f5!94"
default tablespace SAUDESUPORTE_DT
quota unlimited on SAUDESUPORTE_DT
quota unlimited on SAUDESUPORTE_IDX
account unlock;

grant connect to DBIWSAUDESUPORTE;
grant resource to DBIWSAUDESUPORTE;
grante DBA to DBIWSAUDESUPORTE;
grant create job to DBIWSAUDESUPORTE;
grant create view to DBIWSAUDESUPORTE;


create user TESTE identified by "blablabla"
default tablespace TESTE
quota unlimited on TESTE
account unlock;

alter user TESTE identified by values 'S:80C85F319D6A50F8753301F2DEAA0D9F4330FA7185C2A5C12CCF943D2DC6;7DFC5E6F2F5AC881';


GRANT "CONNECT" TO "TESTE";
GRANT "RESOURCE" TO "TESTE";
GRANT CREATE SESSION TO "TESTE";
GRANT UNLIMITED TABLESPACE TO "TESTE";
GRANT CREATE ANY VIEW TO "TESTE";
GRANT ADMINISTER DATABASE TRIGGER TO "TESTE";
GRANT DEBUG CONNECT SESSION TO "TESTE";
GRANT DEBUG ANY PROCEDURE TO "TESTE";
GRANT SELECT ON "SYS"."V_$SESSION" TO "TESTE";
GRANT SELECT ON "SYS"."DBA_OBJECTS" TO "TESTE";
GRANT SELECT ON "SYS"."DBA_TRIGGERS" TO "TESTE";

-- ** --- ** -- ** -- ** -- ** --
create user INTEGRADOR identified by "Tst#n31gCwr4t!"
default tablespace SYSTEM 
quota unlimited on SYSTEM
account unlock;
grant connect to INTEGRADOR;
grant resource to INTEGRADOR;
grant DBA to INTEGRADOR;



SY_PKG_MONITOR.sp_inserirpessoasemcadastro


grant EXECUTE on CONSINCOMONITOR.SY_PKG_MONITOR to INTEGRADOR;


SELECT * FROM DBA_TAB_PRIVS WHERE GRANTEE='USR_CELNE';



alter user ORDS_PUBLIC_USER identified by "ORst#n31gCwr4t!";
ORDS_PUBLIC_USER : ORst#n31gCwr4t!

alter user  APEX_PUBLIC_USER identified by "APst#n43gCwr5t!";
APEX_PUBLIC_USER : APst#n43gCwr5t!

alter user  APEX_LISTENER identified by "LNst#n66gCwr8t!";
APEX_LISTENER

alter user  APEX_REST_PUBLIC_USER identified by "RESzt#n78gCwr9t!";
APEX_LISTENER


