previ
windows 2008r2 standard  1qaz@WSX
2048 mem
25gb hd
2 placas de rede nat(dhcp) e host(192.168.56.1)
firewall desabilitado
habilitar acesso remoto
adicionar filesystem 100gb (d:)
1QAZ@wsx
instalar 11.2.0.1  --> D:\oracle\product\11.2.0\dbhome_1
oradim criar serviço tprev
restore banco
	avaliar nls igual da produção
instalar 11.2.0.4  --> D:\oracle\product\11.2.0\dbhome_2


***backup prd
rman target /
	
	run{
	allocate channel c1 device type disk format 'D:\BACKUP\%d_%I_%p_%s';
	backup as compressed backupset database plus archivelog;
	backup current controlfile  format 'D:\BACKUP\controlfile_atual.bkp';
}
exit
EOF


***oradim
%ORACLEHOME%\Oracle10\bin\oradim -NEW -SID TPREV -startmode MANUAL -pfile D:\oracle\product\11.2.0\dbhome_1\database\SPFILETPREV.ORA
Criado pastas oradata , flash , adump...

***restore teste
	INICIAR O BANCO EM nOMOUNT (no SQLPLUS):

		startup nomount;

	
RESTAURAR O CONTROLFILE (no RMAN)(VERIFICAR O NOME DO CONTROLFILE GERADO NO BACKUP DO COMEÇO DO PROCEDIMENTO)


		restore controlfile from 'D:\BACKUP\CONTROLFILE_ATUAL.BKP'; 
		alter database mount;


	CATALOGAR AS PEÇAS DE BACKUP (no RMAN):
		CATALOG START WITH 'D:\BACKUP1\*';


	RESTAURAR O BANCO:
		reset database to incarnation 10;
		set until time "to_date('06/07/2015 13:58:00','dd/mm/yyyy hh24:mi:ss')";

		
run{
allocate channel c1 device type disk;

		restore database;

		switch datafile all;
		
switch tempfile all;

		recover database;
		
}

	
	VALIDAR SE A TEMPORÁRIA FOI RECRIADA:


		

		ALTER TABLESPACE TS_TMP_01  ADD TEMPFILE ''X:\ORACLE\ORADATA\SATIX\TEMP01.DBF' RESIZE 4000M AUTOEXTEND OFF;
	ABRIR O BANCO DE DADOS:
	
		alter database open resetlogs;

***11.2.0.4 intsall
	
	install 11.2.0.4 
	validar instalção do olap / spatial) --> OUI
	cd D:\oracle\product\11.2.0\dbhome_2\bin
	chopt enable olap
	chopt enable spatial


***11.2.0.4 dbua
	
	alter user sys identified by db2006pre;
	cd D:\oracle\product\11.2.0\dbhome_1\database
	orapwd file=PWDTPREV.ora password=db2006pre entries=5 FORCE=Y
	
	copiar spfile D:\oracle\product\11.2.0\dbhome_1\database 
	copiar tnsnames D:\oracle\product\11.2.0\dbhome_1\NETWORK\ADMIN
	copiar listener D:\oracle\product\11.2.0\dbhome_1\NETWORK\ADMIN 
	copiar arquivo de senha D:\oracle\product\11.2.0\dbhome_1\database

	 --> Vide Doc ID 1565816.1

	dbua  
	http://asanga-pradeep.blogspot.com.br/2011/12/upgrading-from-10204-to-11203.html
	purge dba_recyclebin;
	EXECUTE dbms_stats.gather_dictionary_stats
	@?/rdbms/admin/utlrp.sql
	SELECT (translate(value,chr(13)||chr(10),' ')) FROM sys.v$parameter2  WHERE  UPPER(name) ='EVENT' AND  isdefault='FALSE';
	SELECT (translate(value,chr(13)||chr(10),' ')) from sys.v$parameter2     WHERE UPPER(name) = '_TRACE_EVENTS' AND isdefault='FALSE'
	select version from v$timezone_file;  (11)
	select version from v$timezone_file; (11)
	grant administer database trigger to mdsys; 


	set heading off;
	set echo off;
	Set pages 999;
	set long 90000;
	SELECT DBMS_METADATA.GET_DDL('VIEW','OLAP_SYS_AW_ACCESS_DIM_VIEW','OLAPSYS') FROM DUAL;
	
	validar o oracle home do serviço
	select owner,count(*) from dba_objects where status !='VALID' group by owner;
	reconfigure  o listener para o HOME correto (NETCA)
			
		
*** select comp_name, version, status from dba_registry;
COMP_NAME                                          VERSION                        STATUS
-------------------------------------------------- ------------------------------ --------------------------------------------
OWB                                                11.2.0.1.0                     VALID
Oracle Application Express                         3.2.1.00.10                    VALID
Oracle Enterprise Manager                          11.2.0.1.0                     VALID
OLAP Catalog                                       11.2.0.1.0                     VALID
Spatial                                            11.2.0.1.0                     VALID
Oracle Multimedia                                  11.2.0.1.0                     VALID
Oracle XML Database                                11.2.0.1.0                     VALID
Oracle Text                                        11.2.0.1.0                     VALID
Oracle Expression Filter                           11.2.0.1.0                     VALID
Oracle Rules Manager                               11.2.0.1.0                     VALID
Oracle Workspace Manager                           11.2.0.1.0                     VALID
Oracle Database Catalog Views                      11.2.0.1.0                     VALID
Oracle Database Packages and Types                 11.2.0.1.0                     VALID
JServer JAVA Virtual Machine                       11.2.0.1.0                     VALID
Oracle XDK                                         11.2.0.1.0                     VALID
Oracle Database Java Packages                      11.2.0.1.0                     VALID
OLAP Analytic Workspace                            11.2.0.1.0                     VALID
Oracle OLAP API                                    11.2.0.1.0                     VALID

18 linhas selecionadas.

*** Após 

OLAP Analytic Workspace        11.2.0.1.0                     OPTION OFF
OLAP Catalog                   11.2.0.1.0                     OPTION OFF
Oracle OLAP API                11.2.0.1.0                     OPTION OFF
Spatial                        11.2.0.1.0                     OPTION OFF



***limpar incarnation
	https://chandlerdba.wordpress.com/2011/03/23/time-for-a-mistake-problems-with-rman-and-incarnations/


***nls language
select 'NLS_LANG='
|| ( select value from v$nls_parameters where parameter='NLS_LANGUAGE' )
|| '_'
|| ( select value from v$nls_parameters where parameter='NLS_TERRITORY' )
|| '.'
|| ( select value from v$nls_parameters where parameter='NLS_CHARACTERSET' )
language#
from dual;

LANGUAGE#
--------------------------------------------------------------------------------
NLS_LANG=BRAZILIAN PORTUGUESE_BRAZIL.AL32UTF8

SQL>

DMU
MIGRATE AL32UTF8  TO WE8MSWIN1252 
http://www.oracle.com/technetwork/database/database-technologies/globalization/dmu/downloads/index.html
https://oracle-base.com/articles/12c/database-migration-assistant-for-unicode-dmu-12cr1
- CRIA REPOSITORIO

***
PREVIERICSSON_PROD.LOG_TRUSTPREV;


***
set NLS_LANG=AMERICAN_BRAZIL.WE8MSWIN1252
startup restrict 
export full tprev
create directory bkp as 'd:\backup';
expdp directory=bkp dumpfile=tprevfull.dmp logfile=tprevfull.log full=y consistent=y

criado banco tprev1 como base no modelo TPREV (alterado character set  WE8MSWIN1252 / DEFAULT LANGUAGE BRAZILIAN PORTUGUESE / default NLS_TERRITORY BRAZIL / SEM DATABASE COMPONENTS))

criação de tablespaces alterar para ol local datafile correto
set head off echo off
select 'select dbms_metadata.get_ddl(''TABLESPACE'','''    ||  tablespace_name || ''') from dual;' from dba_tablespaces ;

set ORACLE_SID=TPREV1
CREATE TABLESPACE "PREVERICSSON" DATAFILE  'D:\ORACLE\ORADATA\TPREV1\PREVIERICSSON' SIZE 1073741824  AUTOEXTEND ON NEXT 104857600 MAXSIZE 32767M  LOGGING ONLINE PERMANENT BLOCKSIZE 8192  EXTENT MANAGEMENT LOCAL AUTOALLOCATE DEFAULT NOCOMPRESS  SEGMENT SPACE MANAGEMENT AUTO;
ALTER DATABASE DATAFILE  'D:\ORACLE\ORADATA\TPREV1\PREVIERICSSON' RESIZE 7155482624
***ja existe pois foi criado como base no model TPREV

set NLS_LANG=AMERICAN_BRAZIL.WE8MSWIN1252
impdp  directory=bkp dumpfile=tprevfull.dmp logfile=imp_tprevfull.log full=y 
@?/rdbms/admin/utlrp.sql
select * from PREVIERICSSON_PROD.LOG_TRUSTPREV;

stop / desabilitar serviço tprev

nid tprev1
nid TARGET=sys/db2006pre@tprev1  DBNAME=tprev

alterar oradim serviços


set NLS_LANG=AMERICAN_BRAZIL.WE8MSWIN1252
set ORACLE_SID=TPREV1
sqlplus / as sysdba
create directory bkp as 'd:\backup';
impdp  directory=bkp dumpfile=tprevfull.dmp logfile=imp_tprevfull.log full=y





