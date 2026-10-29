#############################################
# Adicionar discos no ASM em servidores AIX #
#############################################

-- Verificar o ownership dos novos discos (deve ser <ownergrid>.<grupo>)

ls -l /dev/rhdiskpower50

-- Criar diskgroup de teste para validação dos LUN's:

sqlplus / as sysasm

SQL> create diskgroup teste external redundancy disk '/dev/rhdiskpower50';

Diskgroup created.

SQL> select state, name from v$asm_diskgroup;

State       NAME
----------- ---------------
MOUNTED     RECO
MOUNTED     DATA
MOUNTED     ARCH
MOUNTED		TESTE


-- Os novos discos devem ter o mesmo tamanho dos anteriores

GROUP_NUMBER DISK_NUMBER NAME            DISKGROUP  PATH                 LABEL      HEADER_STATU MOUNT_S MODE_ST STATE         OS_MB   TOTAL_MB    FREE_MB
------------ ----------- --------------- ---------- -------------------- ---------- ------------ ------- ------- -------- ---------- ---------- ----------
           1           0 ARCH_0000       ARCH       /dev/rhdisk8                    MEMBER       CACHED  ONLINE  NORMAL       131072     131072     129908
           2           0 DATA_0000       DATA       /dev/rhdisk6                    MEMBER       CACHED  ONLINE  NORMAL       131072     131072       5069
           2           1 DATA_0001       DATA       /dev/rhdisk9                    MEMBER       CACHED  ONLINE  NORMAL       131072     131072       5071
           2           2 DATA_0002       DATA       /dev/rhdisk10                   MEMBER       CACHED  ONLINE  NORMAL       131072     131072       5081
           2           3 DATA_0003       DATA       /dev/rhdisk11                   MEMBER       CACHED  ONLINE  NORMAL       131072     131072       5083
           2           4 DATA_0004       DATA       /dev/rhdisk12                   MEMBER       CACHED  ONLINE  NORMAL       131072     131072       5070
           2           5 DATA_0005       DATA       /dev/rhdisk13                   MEMBER       CACHED  ONLINE  NORMAL       131072     131072       5073
           3           0 RECO_0000       RECO       /dev/rhdisk7                    MEMBER       CACHED  ONLINE  NORMAL       131072     131072     130879
           4           0 TESTE_0000      TESTE      /dev/rhdisk14                   MEMBER       CACHED  ONLINE  NORMAL       131072     131072     131052
           4           1 TESTE_0001      TESTE      /dev/rhdisk15                   MEMBER       CACHED  ONLINE  NORMAL       131072     131072     131054
           4           2 TESTE_0002      TESTE      /dev/rhdisk16                   MEMBER       CACHED  ONLINE  NORMAL       131072     131072     131053

11 rows selected.


-- Validação do dg teste

SQL> create tablespace ora1 datafile '+TESTE';

Tablespace created.

SQL> select * from dba_data_files where tablespace_name='ORA1';

/* Alocação definitiva

Remover a tablespace criada e o dg "teste" e alocar os discos no dg de dados */

Drop diskgroup teste;

Diskgroup dropped.

-- Verificar os discos

col a.group_number for a5
col a.disk_number for a5
col name for a15
col path for a15
col label for a20
col diskgroup for a10
col label for a10
select a.group_number, a.disk_number, a.name, b.name as DISKGROUP, a.path, a.label, a.header_status, a.mount_status, a.mode_status, a.state, a.os_mb, a.total_mb, a.free_mb from v$asm_disk a, v$asm_diskgroup b where a.group_number=b.group_number order by a.group_number, a.disk_number;

-- Alterar o diskgroup e adicionar os discos:

SQL> alter diskgroup DATA add disk '/dev/rhdiskpower50' rebalance power 11;

-- Acompanhar o rebalanceamento:

select * from v$asm_operation;

