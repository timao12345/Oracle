--Verificar se o BD é container.

SYS@SBCDB> select con_id, cdb, name, open_mode from v$database;

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

-- Caso sejá necessário utilizar algun dos PDBS

SYS@SBCDB> alter session set container=SBM;

Session altered.

SYS@SBCDB>
