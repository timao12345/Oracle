Criação de um Banco novo
Classificação do chamado: Técnico
Nome completo para retorno: Rafael Felipe dos Santos

Telefone do contato com DDD: (11)98681-8184

E-mail: rafael.santos@iwsoftware.com.br


Na máquina Iberwan05, IP 10.243.8.26 precisamos criar um novo usuário Oracle a partir do Export de um usuário já existente:

1 - Criar um novo usuário Oracle, chamado dbIwUnimedCuritibaFix
2 - Criar as tablespaces UnimedCuritibaFix_DT e UnimedCuritibaFix_IDX,
3 - Tirar um export (expdp) do usuário dbIwUnimedCuritiba
4 - Fazer o import (impdp) do usuário dbIwUnimedCuritibaFix a partir do export do usuário dbIwUnimedCuritiba,

Remapeamento:

     Schema dbIwUnimedCuritiba para dbIwUnimedCuritibaFix

     Tablespace UnimedCuritiba_DT para UnimedCuritibaFix_DT

     Tablespace UnimedCuritiba_IDX para UnimedCuritibaFix_IDX

O procedimento pode ser realizado em qualquer momento.

Obrigado.


### segue comandos:

## criação da tablespace  UNIMEDCURITIBAFIX_DT  --- > tamanho será ~54 G

CREATE TABLESPACE "UNIMEDCURITIBAFIX_DT" 
  DATAFILE '+ORADATA' size 10G 
  AUTOEXTEND ON NEXT 1G MAXSIZE 32767M
  LOGGING ONLINE PERMANENT BLOCKSIZE 8192
  EXTENT MANAGEMENT LOCAL AUTOALLOCATE DEFAULT
 NOCOMPRESS  SEGMENT SPACE MANAGEMENT AUTO;

alter tablespace UNIMEDCURITIBAFIX_DT add datafile '+ORADATA' size 10G  AUTOEXTEND ON NEXT 1g MAXSIZE 32767M;

alter tablespace UNIMEDCURITIBAFIX_DT add datafile '+ORADATA' size 10G  AUTOEXTEND ON NEXT 1g MAXSIZE 32767M;


## UNIMEDCURITIBAFIX_IDX  --- > tamanho será ~16 G

CREATE TABLESPACE "UNIMEDCURITIBAFIX_IDX" 
  DATAFILE '+ORADATA' size 10G 
  AUTOEXTEND ON NEXT 1G MAXSIZE 32767M
  LOGGING ONLINE PERMANENT BLOCKSIZE 8192
  EXTENT MANAGEMENT LOCAL AUTOALLOCATE DEFAULT
 NOCOMPRESS  SEGMENT SPACE MANAGEMENT AUTO;

 
 
 ## criar o usuario DBIWUNIMEDCURITIBAFIX
   
CREATE USER "DBIWUNIMEDCURITIBAFIX" IDENTIFIED BY DBIWUNIMEDCURITIBAFIX_1001
   DEFAULT TABLESPACE "UNIMEDCURITIBAFIX_DT"
  TEMPORARY TABLESPACE "TEMP";

  
## expdp:

### como oracle
## criar o arquivo :
## server IBERWAN05
cd /ora_backup/ora_backup/dump

vi expd_par.txt

DIRECTORY=DUMP 
DUMPFILE="expdp_DBIWUNIMEDCURITIBA.dmp" 
LOGFILE="expdp_DBIWUNIMEDCURITIBA_logs.log"
JOB_NAME="DBIWUNIMEDCURITIBA_JOB"  
schemas=DBIWUNIMEDCURITIBA


### comando para expdp
### como oracle

export ORACLE_SID=iberdb

cd /ora_backup/ora_backup/dump

expdp \'/ as sysdba\'   parfile=/ora_backup/ora_backup/dump/expd_par.txt &

## verificar o log para ver o termino


### comando para impdp
## como oracle
## criar o arquivo :
## server IBERWAN05
cd /ora_backup/ora_backup/dump


vi impdp_par.txt 
DIRECTORY=DUMP 
DUMPFILE="expdp_DBIWUNIMEDCURITIBA.dmp" 
LOGFILE="impdp_DBIWUNIMEDCURITIBA_logs.log"
JOB_NAME="DBIWUNIMEDCURITIBA_JOB_i"  
remap_schema=DBIWUNIMEDCURITIBA:DBIWUNIMEDCURITIBAFIX 
REMAP_TABLESPACE=UNIMEDCURITIBA_DT:UNIMEDCURITIBAFIX_DT,UNIMEDCURITIBA_IDX:UNIMEDCURITIBAFIX_IDX


### comando para impdp
### como oracle

export ORACLE_SID=iberdb

cd /ora_backup/ora_backup/dump

impdp \'/ as sysdba\'   parfile=/ora_backup/ora_backup/dump/impdp_par.txt &	 
	 
## verificar o log para ver o termino	 
	 
