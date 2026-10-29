-- EXEMPLO DE CRIACAO DE BIGFILE tablespace 
create bigfile tablespace teste2 datafile '/tmp/teste2.dbf' size 100M
    AUTOEXTEND ON NEXT 1G  MAXSIZE UNLIMITED     
    extent management local -- Locally managed    
    segment space management auto -- ASSM
    ; 

-- ver tipo de tbs default do bd:
SELECT * FROM database_properties WHERE PROPERTY_NAME = 'DEFAULT_TBS_TYPE';

-- mudando para bigfile o tipo de tbs default do bd:
ALTER DATABASE SET DEFAULT BIGFILE TABLESPACE;

alter session set container = cdb$root;
alter system set db_32k_cache_size = 32768 scope=spfile;


ALTER DATABASE SET DEFAULT SMALLFILE TABLESPACE;



undef object_type
undef object_name
undef owner
set trims on
col DLL for a500
set long 999999999
select dbms_metadata.get_ddl('USER','SPATIAL_CSW_ADMIN_USR') ||chr(10)||';' as DLL from dual;