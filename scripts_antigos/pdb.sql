-- DETERMINANDO SE UM BANCO DE DADOS � UM CDB
SELECT CDB FROM V$DATABASE;

-- VERIFICA INFORMA��ES DOS CONTAINERS
COLUMN NAME FORMAT A8
SELECT NAME, CON_ID, DBID, CON_UID, GUID FROM V$CONTAINERS ORDER BY CON_ID;

-- Verifica container name, ID e status de cada CDB
COLUMN PDB_NAME FORMAT A15
SELECT PDB_ID, PDB_NAME, STATUS FROM DBA_PDBS ORDER BY PDB_ID;

-- setar um PDB
alter session set container=SABREODS; 


-- Abrir o PDB em modo restrito, opção 1 quando quando ele estiver já montado, opção 2 quando não está OPEN
--1 
    alter pluggable database ORCLPDB open restricted force;
--2
    alter pluggable database ORCLPDB open restricted;

-- Tirar o modo restrict
alter pluggable database ORCLPDB open force;



SQL> alter pluggable database ORCLPDB close immediate instances=all;

Pluggable database altered.

SQL> alter pluggable database ORCLPDB open instances=all;

Pluggable database altered.