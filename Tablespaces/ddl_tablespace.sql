-- BACKUP DDL TABLESPACE

set long 99999999
set lines 9999 pages 9999
set trims on
undef NAME_TABLESPACE
SELECT DBMS_METADATA.GET_DDL('TABLESPACE','&&NAME_TABLESPACE') from dual;


create tablespace "TSD_REFEITORIO" DATAFILE '+DATAC1/extrabsn_gru1m8/datafile/tsd_refeitorio01.dbf' size 15767M autoextend on next 1G maxsize 32767M;


create user REFEITORIO identified by "8L%&bg2IxrFgKu"
default tablespace TSD_REFEITORIO
    temporary tablespace TEMP
    quota unlimited on TSD_REFEITORIO
    account unlock;

grant connect to REFEITORIO;
grant RESOURCE to REFEITORIO;

 alter user REFEITORIO default tablespace TSD_REFEITORIO
    temporary tablespace TEMP
    quota unlimited on TSD_REFEITORIO
    account unlock



