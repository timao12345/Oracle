
/* PROCEDIMENTO
Usando o pacote DBMS_METADATA no SQL*Plus
*/

Configurando o ambiente
SQL> set linesize 1000
SQL> set pagesize 0
SQL> set long 9999999
SQL> set trimsp on

/*
Exemplo
OBJECT_TYPE = Tipo de objeto que será extraido o DDL.
OBJECT_NAME = Nome do objeto que será extraido o DDL.
OWNER = Owner dono dos objetos.
 
select dbms_metadata.get_ddl('OBJECT_TYPE','OBJECT_NAME','OWNER') "DDL TABLE" from dual;
*/


-- Gerando DDL para a "TABELA"
SQL> select dbms_metadata.get_ddl('TABLE','TESTE') "DDL TABLE" from dual;
  
DDL TABLE
--------------------------------------------------------------------------------
CREATE TABLE "TECH4B"."TESTE"
( "A" NUMBER(2,0)
) SEGMENT CREATION IMM


-- Gerando DDL para a "VIEW" 
SQL> select dbms_metadata.get_ddl('VIEW','V980_65','ESTACIO') "DDL VIEW" from dual;
 
DDL VIEW
--------------------------------------------------------------------------------
CREATE OR REPLACE FORCE VIEW "OWNER.VIEW" ("ID", "CHAPA", "NOME", "LOCAL", 
"CARGO", "CCUSTO", "ADMISSAO", "TIPO_SERVICO", "HORARIO", "HORAS_CONTR", "DEMISSAO", 
"EMPRESA", "AREA", "DATA_NASC", "DEF_FISICO") AS
SELECT "ID","CHAPA","NOME","LOCAL","CARGO","CCUSTO","ADMISSAO","TIPO_SERVICO",
"HORARIO","HORAS_CONTR","DEMISSAO","EMPRESA","AREA","DATA_NASC","DEF_FISICO" FROM SISTEMA_MDP
WHERE ID IN ( SELECT ID FROM VP910_65 )


-- Gerando DDL para criação da "TABLESPACE"
SYS> select dbms_metadata.get_ddl('TABLESPACE','PSAPSR3') "DDL TABLESPACE" from  dual;
   
  DDL TABLESPACE
  --------------------------------------------------------------------------------
  CREATE TABLESPACE "USERS" DATAFILE
  'C:\ORACLEXE\ORADATA\XE\USERS.DBF' SIZE 104857600
  AUTOEXTEND ON NEXT 10485760 MAXSIZE 5120M
  LOGGING ONLINE PERMANENT BLOCKSIZE 8192
  EXTENT MANAGEMENT LOCAL AUTOALLOCATE SEGMENT SPACE MANAGEMENT AUTO;
  ALTER DATABASE DATAFILE
  'C:\ORACLEXE\ORADATA\XE\USERS.DBF' RESIZE 3145728000;
  
  
-- Gerando DDL para criação do "USUÁRIO"
select dbms_metadata.get_ddl('USER','UOLDIVEO_DBA') DDL from dual;
 
DDL USER
--------------------------------------------------------------------------------
CREATE USER "UOLDIVEO_DBA" IDENTIFIED BY VALUES 'S:7FBB6E7D2BE85BFEA068278267
9C19B42F76C93730B441724CA386578468;8AAD467667DF140B'
TEMPORARY TABLESPACE "TEMP"


-- Gerando DDL de privilégios de sistema concedidos ao usuário uoldiveo_dba
SQL> select dbms_metadata.get_granted_ddl('SYSTEM_GRANT','UOLDIVEO_DBA') DDL from dual;
 
DBMS_METADATA.GET_GRANTED_DDL('SYSTEM_GRANT','UOLDIVEO_DBA')
--------------------------------------------------------------------------------
  GRANT UNLIMITED TABLESPACE TO "UOLDIVEO_DBA"

  
-- Gerando DDL de roles cocedidas ao usuário UOLDIVEO_DBA
SYS> select dbms_metadata.get_granted_ddl('ROLE_GRANT','UOLDIVEO_DBA') DDL from  dual;
   
DDL
--------------------------------------------------------------------------------
   GRANT "CONNECT" TO "UOLDIVEO_DBA"
   GRANT "DBA" TO "UOLDIVEO_DBA"
   
   
-- Gerando DDL de privilégios de objetos que foram concedidos pelo usuário SCOTT ao usuário UOLDIVEO_DBA
SYS> select dbms_metadata.get_granted_ddl('OBJECT_GRANT','UOLDIVEO_DBA') DDL  from dual;
DDL
--------------------------------------------------------------------------------
  GRANT WRITE ON DIRECTORY "DIR_RH" TO "UOLDIVEO_DBA"
  GRANT READ ON DIRECTORY "DIR_RH" TO "UOLDIVEO_DBA"
  GRANT WRITE ON DIRECTORY "DIR_RH_LOG" TO "UOLDIVEO_DBA"
  GRANT READ ON DIRECTORY "DIR_RH_LOG" TO "UOLDIVEO_DBA"
  GRANT SELECT ON "SCOTT"."TIPO_BOLSA" TO "UOLDIVEO_DBA"
  GRANT SELECT ON "SCOTT"."TIPO_CURSO" TO "UOLDIVEO_DBA"
  GRANT SELECT ON "SCOTT"."TURMA" TO "UOLDIVEO_DBA"
  GRANT SELECT ON "SCOTT"."FAIXA_SEED" TO "UOLDIVEO_DBA"
  
  

-- Gerando DDL de criação da role CONNECT
SYS> select dbms_metadata.get_ddl('ROLE','CONNECT') DDL from dual;
   
  DDL
  --------------------------------------------------------------------------------
  CREATE ROLE "CONNECT";