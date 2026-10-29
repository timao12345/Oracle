$ oracleasm createdisk DATA6 /dev/sdi1
$ oracleasm listdisks

## Conectar no servidor UC-VM-BD-ORACLE (172.102.200.2) com o usu�rio "grid" e executar:
$ . oraenv (Informar +ASM)
$ sqlplus / as sysasm
SQL> SELECT NAME, HEADER_STATUS FROM V$ASM_DISK WHERE NAME = 'DATA6';

Obs.: Valor retornado deve pode ser PROVISIONED ou CANDIDATE.

- Adicionar o disco no DG ORADATA:
SQL> ALTER DISKGROUP ORADATA ADD DISK 'ORCL:DATA6' REBALANCE POWER 11;

- Acompanhar o processo com a query abaixo:
SQL> SELECT GROUP_NUMBER, OPERATION, STATE, POWER, SOFAR, EST_WORK, ROUND((SOFAR*100)/EST_WORK)||�%� PCT, EST_MINUTES FROM V$ASM_OPERATION;