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