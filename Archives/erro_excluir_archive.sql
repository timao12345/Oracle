-- Encontrar sessão que está bloqueando archive ou datafile
-- ativar o trace dentro do banco do ASM
alter system set events '15028 trace name errorstack level 3';

-- Apos trace ativo tentar excluir o datafile ou archive logado no rman do banco kpvprd, nesse exemplo é de archive.

RMAN> delete archivelog until sequence 111985;

Key     Thrd Seq     S Low Time
------- ---- ------- - ---------
356857  1    111985  A 25-NOV-24
        Name: +RECOC1/KPVPRD/ARCHIVELOG/2024_11_25/thread_1_seq_111985.7684.1185979941


Do you really want to delete the above objects (enter YES or NO)? yes
RMAN-00571: ===========================================================
RMAN-00569: =============== ERROR MESSAGE STACK FOLLOWS ===============
RMAN-00571: ===========================================================
RMAN-03009: failure of delete command on ORA_DISK_1 channel at 12/04/2024 10:58:04
ORA-15028: ASM file '+RECOC1/KPVPRD/ARCHIVELOG/2024_11_25/thread_1_seq_111985.7684.1185979941' not dropped; currently being accessed

-- Desativar o trace na outra sessão do ASM
alter system set events '15028 trace name context off'; 

-- Olhar no alert log o trace gerado em nosso exemplo o trace foi gerado em /u01/app/grid/u01/app/grid/diag/asm/+asm/+ASM1/trace/+ASM1_nfg_88064_kpvprd1_KPVPRD.trc



Sessões bloqueando o archive

INST_ID|STATUS  |    SID|SERIAL#|USERNAME       |OSUSER  |MACHINE     |EVENT                         |WAIT_CLASS     |SQL_ID         |PROGRAM             |Min_Active|LOGON_TIME
-------|--------|-------|-------|---------------|--------|------------|------------------------------|---------------|---------------|--------------------|----------|--------------------
      1|INACTIVE|   4908|  20554|KIPREVWEB      |weblogic|lnxprd031.ro|SQL*Net message from client   |Idle           |               |JDBC Thin Client    |.633333333|03-12-24 22:34:33
       |        |       |       |               |        |otbrasil.int|                              |               |               |                    |          |
       |        |       |       |               |        |ranet       |                              |               |               |                    |          |

      1|INACTIVE|   4908|  20554|KIPREVWEB      |weblogic|lnxprd031.ro|SQL*Net message from client   |Idle           |               |JDBC Thin Client    |.633333333|03-12-24 22:34:33
       |        |       |       |               |        |otbrasil.int|                              |               |               |                    |          |
