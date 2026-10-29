--Verifica status do banco de dados, instancia, area de archive ...

SET SQLBLANKLINES ON
SET COLSEP '|'
COL STARTUP_TIME     FOR A20
COL INSTANCE_NAME    FOR A15
COL HOST_NAME        FOR A10
COL SYSDATE          FOR A30
COL "NOME_SERVIDOR"  FOR A30
COL "BANCO_INICIADO" FOR A20
COL "DATA_E_HORA"    FOR A20
SET LINES 900 PAGES 500 TRIMS ON
SET TIME ON
SELECT DISTINCT 
INSTANCE_NAME NOME_BANCO, 
I.HOST_NAME NOME_SERVIDOR, 
TO_CHAR(STARTUP_TIME,'DD/MM/YYYY HH24:MI:SS') BANCO_INICIADO,
D.LOG_MODE, 
I.STATUS,
I.ARCHIVER, 
I.LOGINS, 
D.DATABASE_ROLE,
D.OPEN_MODE,  
TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI:SS') DATA_E_HORA
FROM GV$INSTANCE I, GV$DATABASE D; 

--This view maps instance names to instance numbers for all instances that have the database currently mounted.
SQL> select * from v$active_instances;

--This view describes, for the current instance, all the archive log destinations, their current value, mode, and status.
SQL> 
COL DEST_ID FOR A15
COL DEST_NAME FOR A50
COL DEPENDENCY FOR A50
COL REMOTE_TEMPLATE FOR A50
select * from V$ARCHIVE_DEST

SQL> archive log list;

SQL> delete archivelog all backed up 1 times to device type sbt;

SQL> delete archivelog all backed up 1 times to sbt;