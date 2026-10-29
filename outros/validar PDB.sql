https://oracle-base.com/articles/12c/multitenant-connecting-to-cdb-and-pdb-12cr1

--Verificar se o BD é container.
SYS@SBCDB> 
select con_id, cdb, name, open_mode from v$database;


    CON_ID CDB NAME      OPEN_MODE
---------- --- --------- --------------------
         0 YES SBCDB     READ WRITE


SYS@SBCDB>

--Verificar os PDBS

SYS@SBCDB> select con_id, name, open_mode from v$pdbs;

    CON_ID NAME                           OPEN_MODE
---------- ------------------------------ ----------
         2 PDB$SEED                       READ ONLY
         3 SBM                            READ WRITE


    SELECT name, pdb FROM v$services ORDER BY name;

-- Caso sejá necessário utilizar algun dos PDBS

SYS@SBCDB> alter session set container=SBM;

ALTER SESSION SET CONTAINER=cdb$root;

Session altered.

-- para saber qual PDB está conectado.

show con_name
show con_id

SYS@SBCDB> 

select a.con_id,a.name, b.status,a.open_mode, a.OPEN_TIME FROM  gv$pdbs a, dba_pdbs b WHERE a.con_id = b.pdb_id;

select CON_ID,DBID,CON_UID,GUID,NAME,OPEN_MODE,OPEN_TIME,RECOVERY_STATUS from v$containers;

select con_id "PDBID", name "PDBName", application_root "AppRoot", application_pdb "AppPDB" from v$pdbs;

-- Serviços

SELECT name FROM dba_services ORDER BY name;

SELECT name, pdb FROM v$services ORDER BY name;

-- verificar lsnrctl

$ lsnrctl service

-- verificar erros que ocorrem quando nao abre, ou modifica o status do PDB;
select name, cause, type, message, action from PDB_PLUG_IN_VIOLATIONS where status = 'PENDING' and con_id = 3;

select time,name,type,cause,status,message from pdb_plug_in_violations where status <>'RESOLVED';

-- problema de sync de USUARIO - com a query acima verifica qual usuario está causando o problema geralmente erro " ORA-65177 during 'alter user ACNDBA"
-- usar
show con_name -- para ver em qual CDB ou PDB está

-- executar no CDB
col SQLSTMT for a25
col name for a25
col SQLSTMT for a55
select ctime,sqlstmt,name,flags,opcode,replay# from pdb_sync$ where sqlstmt like 'alter user ACNDBA%';

-- executar no pdb
col SQLSTMT for a25
col name for a25
col SQLSTMT for a55
select ctime,sqlstmt,name,flags,opcode,replay# from pdb_sync$ where sqlstmt like 'alter user ACNDBA%';

--A partir do usuario verificar a diferença executando no CDB e no PDB

select con_id,username,account_status,created,common from cdb_users where username='ACNDBA';

-- deletar no CDB
delete from PDB_SYNC$ where sqlstmt like ('alter user ACNDBA%');
commit;
-- deletar no PDB
delete from PDB_SYNC$ where sqlstmt like ('alter user ACNDBA%');
commit;