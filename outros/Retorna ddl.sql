-- pega a query de criação do objeto.

-- Tablespace
undef object_type
undef object_name
undef owner
set trims on
set long 999999999
col DLL for a700
select dbms_metadata.get_ddl('TABLESPACE','PSAPSR3I') as DDL from  dual;


-- view materialized
undef object_type
undef object_name
undef owner
set trims on
set long 999999999
col DLL for a700
select dbms_metadata.get_ddl('MATERIALIZED_VIEW','FUNCIONARIOS','ORAPDR') ||chr(10)||';'  as DLL from dual;

-- view
undef object_type
undef object_name
undef owner
set trims on
col DLL for a5000
set long 999999999
select dbms_metadata.get_ddl('VIEW','VW_ITMKT_FILIAL_APP_SITE','A_RAIABD') ||chr(10)||';' as DLL from dual;


-- Procedure 
undef object_type
undef object_name
undef owner
set trims on
set lines 1200
set long 999999999
col DLL for a1000
select dbms_metadata.get_ddl('PROCEDURE','PROC_KILL_USER_OCIOSO','SYS') ||chr(10)||';' as DLL  from dual;
select dbms_metadata.get_ddl('PROCEDURE','PRC_EXTRAI_PRIVS_DBA','VIMERSON') ||chr(10)||';' as DLL  from dual;
select dbms_metadata.get_ddl('PROCEDURE','PRC_EXTRAI_PRIVS','VIMERSON') ||chr(10)||';' as DLL  from dual;
select dbms_metadata.get_ddl('PROCEDURE','PRC_EVENTO_MUTEX','VIMERSON') ||chr(10)||';' as DLL  from dual;
select dbms_metadata.get_ddl('PACKAGE','PCK_DB_OPE_RESGATES','NILTON') ||chr(10)||';' as DLL  from dual;
select dbms_metadata.get_ddl('PACKAGE','PCK_DB_NCL_TRANS_EMISSAO','NILTON') ||chr(10)||';' as DLL  from dual;

undef object_type
undef object_name
undef owner
set trims on
set lines 1200
set long 999999999
col DLL for a1000
select dbms_metadata.get_ddl('VIEW','NCL_FUNDOS','KIPREVWEB') ||chr(10)||';' as DLL  from dual;


-- Function
undef object_type
undef object_name
undef owner
col DLL for a1000
set trims on
set long 999999999
select dbms_metadata.get_ddl('FUNCTION','VERIFY_ACESS_USER_KPV','SYS') ||chr(10)||';' as DLL from dual;

-- Package
undef object_type
undef object_name
undef owner
set trims on
col DLL for a1000
set long 999999999
set lines 1500 pages 50000
select dbms_metadata.get_ddl('PACKAGE_BODY','PCK_DB_PA_USUARIO','KIPREV') ||chr(10)||';' as DLL from dual;

PCK_DB_PA_IR 

-- scheduler
undef object_type
undef object_name
undef owner
set trims on
col DLL for a500
set long 999999999
select dbms_metadata.get_ddl('PROCOBJ','KILL_USER_OCIOSO','SYS') ||chr(10)||';' as DLL from dual;

KIPREV.PCK_DB_FO_SOL_UTL_SAL

undef object_type
undef object_name
undef owner
set trims on
col DLL for a500
set long 999999999
select dbms_metadata.get_ddl('PROCOBJ',job_name,owner) ||chr(10)||';' as DLL
FROM DBA_SCHEDULER_JOBS where job_name ='KILL_LOCK_INATIVA';

select dbms_metadata.get_ddl('SCHEDULER','KILL_LOCK_INATIVA') from dual;



-- JOB
undef object_type
undef object_name
undef owner
set trims on
col DLL for a500
set long 999999999
select dbms_metadata.get_ddl('JOB','11','CONSINCO') ||chr(10)||';'  as DLL from dual;

-- INDEX
undef object_type
undef object_name
undef owner
set trims on
col DLL for a500
set long 999999999
select dbms_metadata.get_ddl('INDEX','WITH_ITEM~0','SAPSR3') ||chr(10)||';'  as DLL from dual;

CREATE  
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "PSAPSR3"
;


-- tabela
undef object_type
undef object_name
undef owner
set trims on
set long 999999999
col DLL for a1000
select dbms_metadata.get_ddl('TABLE','FO_CUENTAS','KIPREV') ||chr(10)||';' as DDL from dual;

ORDER_NOTE

undef object_type
undef object_name
undef owner
set trims on
col ddl for a500
set long 999999999
set lines 1500 pages 50000
SELECT DBMS_METADATA.GET_DDL('TABLE', TABLE_NAME,'CIARAMA' ) ||chr(10)||';' AS ddl
FROM DBA_TABLES where OWNER='CIARAMA' AND TABLE_NAME IN ('ACERTOMOT','TICKET','TALHAO','SINICICLO','REQUIS','PARTEBLL','OCORATD','NEGENTRCOMM','NEGENTRCOMMESP','ILEVMERCADO','CTRFRET','CTRCOMPRADEP','CONTRATOFIN') ;


-- trigger

undef object_type
undef object_name
undef owner
set trims on
col DLL for a500
set long 999999999
select dbms_metadata.get_ddl('TRIGGER','TRG_AUDIT_CGCONTABOUTRAS_01','KIPREV') ||chr(10)||';' as DLL from dual;

undef object_type
undef object_name
undef owner
set trims on
col ddl for a500
set long 999999999
set lines 1500 pages 50000
SELECT DBMS_METADATA.GET_DDL('TRIGGER', TRIGGER_NAME,'SISJURI' ) ||chr(10)||';' AS ddl
FROM DBA_TRIGGERS where OWNER='SISJURI' AND TRIGGER_NAME IN ('TSC00_1253339931_BIR','TSC00_1088105611_BIR','TSC00_215184671_BIR','TSC00_2011178691_BIR','TSC00_2165241611_BIR','TSC00_2318341481_BIR','TSC00_922585881_BIR','TSC00_771514631_BIR','TSC01_1253339931_BIR','TSC01_1238330651_BIR','TSC01_215184671_BIR','TSC02_1238330651_BIR','TSC01_771514631_BIR','TSC06_215184671_BIR','TSC07_215184671_BIR','TSC10_215184671_BIR','TSC11_215184671_BIR','TSC16_215184671_BIR','TSC17_215184671_BIR','TSC20_215184671_BIR','TSC21_215184671_BIR') ;

-- USER
undef object_type
undef object_name
undef owner
set trims on
col DLL for a500
set long 999999999
select dbms_metadata.get_ddl('USER','USRGIA') ||chr(10)||';' as DLL from dual;

CREATE USER "APEX_180100" IDENTIFIED BY VALUES 'S:B4D30B8C560413A864BF0F79CE274C39EE6B491E7A4B753E0C4530C1E3F3;T:9AAEF092200D89E717A834AD5362B9C0704F8505880C2C00BA76106EF1E4100CB35F93063C6C337B68450FA1F2B1F714AECF2B3942B70208C8E3E2C1C216256CA2514BA3BB8E013FB34411E87C082C9D'
DEFAULT TABLESPACE "APEX"
TEMPORARY TABLESPACE "TEMP"
PASSWORD EXPIRE
ACCOUNT LOCK
;

CREATE USER "KIPREVATOS" IDENTIFIED BY VALUES 'S:96D4A7B22A418F40F9406C8718825A3C15A1E5194D4A11142EEF0BEDC985;T:35779C22ECD5154B5626209338B2F6C9AAC1025C989D7EE209D05D317D5C300FF4E687D1CC8B40E84D12C87A85AC8BF7515EEC26E1486ED2762379D9A0E7434DD0C39E0E99433BDDF1530224BEE3D9AE;206B4181755EB1F6'
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP"
;

-- USRGIA PROD
   CREATE USER "USRGIA" IDENTIFIED BY VALUES 'S:70F61E36A7139784339FFC48190E3925
F3FE059F1B8A5D34FD7F12216A2A;H:A992F24C4061B73C2AA73C162DEB3673;T:B3F1C56DD0A391
C68A8AF1E34D928B319DA967EB664BE2126B0BE641ABD182A0CA2DAC9F83C2CF188E4AF61A6BEA51
29BCF6711BB3B8BBE908E850D16E77813015915C759DFE862F5396033E2A260181'
      DEFAULT TABLESPACE "USERS"
      TEMPORARY TABLESPACE "TEMP"
;



select count(username) QTD_USR,TEMPORARY_TABLESPACE from dba_users group by TEMPORARY_TABLESPACE order by 2;
-- PRD PDB backup
CREATE USER "C##ORACLE_BKP" IDENTIFIED BY VALUES 'S:2566233A1294677089739974F8A363C284144B5F2A19DA11FF70DA510E94;T:2C84B5E8BF368359E37F9F42356A3886C7EF0A2A9A8058B7821E31B9DDE6E48623A21E14DE361861CF6A9D2026FC05BE0FF82E52AC785811F4A2633C73F4DA3B9E2D2776B56E3187C964A9B6083FA2E6'
DEFAULT TABLESPACE "SYSTEM"
TEMPORARY TABLESPACE "TEMP"
;


CREATE USER "USR_SQLLINK" IDENTIFIED BY VALUES 
'S:987E8FA58711E9DA83FC9B1B6FB262BEE0606FC83568016643ED837806F9;H:166C93B8E61B8E073497FE41C90F6316;T:755B9CAEC428A8D6CC04109994E52DFA67B3A947431876104BE42839FF18315723137E835E787F8EF81866231DC80B3C4CD84A7C67831DA5B473A91B6F17F32400D7E86FD4CE75805E267B87CE230BDC'
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP"
;


CREATE USER "CVP_SAP_DEV" IDENTIFIED by "OraCvpOraSAP123456#"
DEFAULT TABLESPACE "TBS_CATALOGO"
TEMPORARY TABLESPACE "TEMP"
;
GRANT CONNECT TO CVP_SAP_DEV;
GRANT RECOVERY_CATALOG_OWNER TO CVP_SAP_DEV;
GRANT RESOURCE TO CVP_SAP_DEV;


CREATE USER "ORACLE_BKP" IDENTIFIED BY "SKA09P#Bzp1"
DEFAULT TABLESPACE "SYSTEM"
TEMPORARY TABLESPACE "TEMP"
;


CREATE USER "LUCAS" IDENTIFIED BY VALUES 'S:83FD0BFCD2958B95CA139B39BABD8BF2AEF2D7A3BB8C1E7C1C8BD8767D18;T:1AF53B6372A1BCFD0504C25385430A8AE06C14F996897992703320C1B1C4D2F073A138EFE9AC9DAE6F8083AABD566F678FEE3D7062779878C8FCFB8823976E5601FD97070B9E3B60D2A5BB32F7D2B757;26285193E1C7EDDE'
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP"
;


GRANT CONNECT to ORACLE_BKP; 
GRANT RESOURCE to ORACLE_BKP;
GRANT DBA to ORACLE_BKP;     

-- dev
CREATE USER "USRGIA" IDENTIFIED BY VALUES 'S:8ADA4B22DA54B79DC76790D8EEE323B32A94ECBBCCCB99521057DB5186BA;H:E61255BE8BFF6D9ED99BCD12032D71DD;T:CE70BDDCFFD0D666B8AAFDB030C8C1F8CED08575BF84057F7E6076F38DDD8802697BCD6B6026E9B33B6351AE466C722D5E738444DC0EE7DD74C096605913C09C3A38563C6E1EE89625AA6B571C0CDCA8;D8484348F1ED98F5'
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP"
;
-- hml
CREATE USER "USRGIA" IDENTIFIED BY VALUES 'S:8ADA4B22DA54B79DC76790D8EEE323B32A94ECBBCCCB99521057DB5186BA;H:E61255BE8BFF6D9ED99BCD12032D71DD;T:CE70BDDCFFD0D666B8AAFDB030C8C1F8CED08575BF84057F7E6076F38DDD8802697BCD6B6026E9B33B6351AE466C722D5E738444DC0EE7DD74C096605913C09C3A38563C6E1EE89625AA6B571C0CDCA8;D8484348F1ED98F5'
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP"
;



CREATE USER "USR_SQLLINK" IDENTIFIED BY VALUES 'S:987E8FA58711E9DA83FC9B1B6FB262BEE0606FC83568016643ED837806F9;H:166C93B8E61B8E073497FE41C90F6316;T:755B9CAEC428A8D6CC04109994E52DFA67B3A947431876104BE42839FF18315723137E835E787F8EF81866231DC80B3C4CD84A7C67831DA5B473A91B6F17F32400D7E86FD4CE75805E267B87CE230BDC'
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP"
;


-- type

undef object_type
undef object_name
undef owner
set trims on
set long 999999999
select dbms_metadata.get_ddl('TYPE','MRL_FAMEMBEMPRESA','CVP_ZABBIX_MON') ||chr(10)||';' as DDL from dual;

-- USER / USUARUI

undef object_type
undef object_name
undef owner
set trims on
set long 999999999
select dbms_metadata.get_ddl('USER','ORACLE_BKP') ||chr(10)||';' as DDL from dual;

CREATE USER "ORACLE_BKP" IDENTIFIED BY VALUES 'S:03C21224B2B655AFBD0B60A935A9F0DDB808C25AEE44E7C5397D309B189B;T:E1DFE84EB438529FDEBA118156B75C6E3B7BD945786A74AEA4D7F9816203FE5F412E07EB3BF0C2866D0F0A085F46E0D7010A2D925BD014B00F37CC591CADD52CB10ACCFE6768ABFB281D95E8D07E4F85'
TEMPORARY TABLESPACE "TEMP"
;

-- constraint
undef object_type
undef object_name
undef owner
set trims on
col ddl for a500
set long 999999999
set lines 1500 pages 50000
SELECT DBMS_METADATA.GET_DDL('CONSTRAINT', CONSTRAINT_NAME,'CIARAMA' ) ddl
FROM DBA_CONSTRAINTS where OWNER='CIARAMA' AND CONSTRAINT_TYPE='R' ;

undef object_type
undef object_name
undef owner
set trims on
set long 999999999
select dbms_metadata.get_ddl('TYPE BODY','JSON_LIST','KIPREVWEB') ||chr(10)||';' as DDL from dual;






-- // --

select owner, object_name, object_type,status from dba_objects where object_name='RFF_BUSCAVLRCTB';

-- copia scheduler pra outro owner.
exec dbms_scheduler.copy_job('LSSKY.DBMS_JOB$_566','CONSINCO.DBMS_JOB$_566');    



set serveroutput on
set linesize 200;
set pagesize 10000;
set long 9999999;
set ECHO off;
set FEED off;
set HEAD off;
set time off;
set timi off;
COLUMN DDL FORMAT a9999;
set wrap on
 
spool gera_bkp_procedure.sql
set serveroutput on;
Declare
cursor 
gera_bkp_procedure 
is
select owner, object_name, object_type from dba_objects where status='INVALID';
Begin
    dbms_output.put_line('set linesize 200');
    dbms_output.put_line('set pagesize 10000');
    dbms_output.put_line('set long 9999999');
    dbms_output.put_line('set ECHO off');
    dbms_output.put_line('set FEED off');
    dbms_output.put_line('set time off');
    dbms_output.put_line('set timi off');
    dbms_output.put_line('set heading off');
    dbms_output.put_line('undef object_type');
    dbms_output.put_line('undef object_name');
    dbms_output.put_line('undef owner');
    dbms_output.put_line('set trims on');
    dbms_output.put_line('column COLUMN DDL FORMAT a9999');
  for linha in gera_bkp_procedure  loop
    dbms_output.put_line('spool '||linha.owner||'-'||linha.object_name||'.txt');
    dbms_output.put_line('SELECT dbms_metadata.get_ddl('''||linha.object_type||''','''||linha.object_name||''','''||linha.owner||''') DDL from dual;');
    dbms_output.put_line('spool off');
  end loop;
end;
/
 
spool off;


select to_char (CREATED, 'DD-MON-YY HH24:MI:SS') || ' '|| decode(object_type,'PACKAGE BODY','PACKAGE',object_type) || ' ' ||
owner || '.' || object_name || decode(object_type,'PACKAGE BODY',' COMPILE BODY;',' COMPILE;') COMANDO
from dba_objects
where status ='INVALID';





select 'drop 'owner,object_type,object_name
from dba_objects
where status ='INVALID'
order by 1;


set serveroutput on
set linesize 200;
set pagesize 10000;
set long 9999999;
set ECHO off;
set FEED off;
set HEAD off;
set time off;
set timi off;
COLUMN DDL FORMAT a9999;
set wrap on
 
spool gera_bkp_procedure.sql
Declare
 
cursor 
gera_bkp_procedure 
is
select owner, object_name, object_type from dba_objects where status ='INVALID';
Begin
    dbms_output.put_line('set linesize 200');
    dbms_output.put_line('set pagesize 10000');
    dbms_output.put_line('set long 9999999');
    dbms_output.put_line('set ECHO off');
    dbms_output.put_line('set FEED off');
    dbms_output.put_line('set time off');
    dbms_output.put_line('set timi off');
    dbms_output.put_line('set heading off');
    dbms_output.put_line('undef object_type');
    dbms_output.put_line('undef object_name');
    dbms_output.put_line('undef owner');
    dbms_output.put_line('set trims on');
    dbms_output.put_line('column COLUMN DDL FORMAT a9999');
  for linha in gera_bkp_procedure  loop
    dbms_output.put_line('spool '||linha.owner||'-'||linha.object_name||'.txt');
    dbms_output.put_line('SELECT dbms_metadata.get_ddl('''||decode(linha.object_type,'PACKAGE BODY','PACKAGE',linha.object_type)||''','''||linha.object_name||''','''||linha.owner||''') DDL from dual;');
    dbms_output.put_line('spool off');
  end loop;
end;
/

select 'DROP ' || decode(object_type,'PACKAGE BODY','PACKAGE',object_type) || ' ' ||
owner || '.' || object_name || ';' COMANDO
from dba_objects
where status ='INVALID';