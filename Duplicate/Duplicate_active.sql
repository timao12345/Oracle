----------------------------------------------------
-- Procedimento para duplicar um BD               --
-- Procedimento para duplicar um BD e criar um DR --
----------------------------------------------------

Documento usado como referencia https://oracle-base.com/articles/11g/duplicate-database-using-rman-11gr2

-- Itens necessários inicialmente:
pfile / spfile
arquivo ORAPWD -- Arquivo de senha do source, pode criar um novo ou somente copiar e enviar para o auxiliary no directorio padrão /u01/app/oracle/product/19.0.0.0/db_1/dbs/orapwDB11G
entrada TNSNAMES para o banco auxiliary -- Entrada padrão apontando para o auxiliary (banco destino)
-- Configurar / criar directorios necessários padrão do Oracle.
-- No Auxiliary criar pfile / init  e subir o banco (também podemos criar um pfile a partir do source, editar com os direcitorios do auxiliary e subir o banco em nomount.)
-- exemplio no source criar um pfile a partir do spfile e enviar para o auxiliary (existe diversas maneiras de fazer um backup do spfile)
create pfile from spfile; -- no source
create PFILE='/u01/app/oracle/product/11.2.0/dbhome_1/dbs/initBACKUP.ora' from SPFILE; -- no source

-- enviar para o auxiliary o arquivo de parametro e subir o bd em nomount.
-- baseando que o usuario ja esteja configurado e variaveis de ambiente setadas corretamente e esteja no ORACLE
export ORACLE_SID=ORCL2 

sqlplus / as sysdba

startup nomount pfile='/u01/app/oracle/product/11.2.0/dbhome_1/dbs/initBACKUP.ora';


-- No source entrar no rman e auxliary juntos. (temos varias maneiras de logar escolha um modo e faça não se prenda.)

$ ORACLE_SID=DB11G; export ORACLE_SID

-- precisar mandar o arquivo de senha para o auxiliary (dataguard/standby), ou criar um novo orapwd no dataguard/standby.
orapwd file=orapwkpvhml01 password=Ora#123#12

orapwd file=$ORACLE_HOME/dbs/orapworaapex password=Ora#123#12 entries=10 force=y

-- se for um RAC com arquivo de dentro do ASM, o arquivo de senha deve ser criado no ASM e não no filesystem do OS, podemos tbm fazer backup do atual de restaurar no ASM do dataguard/standby.


-- Caso nao tenha o target ou catalog com os metadados, o backup full deve existir em um local no servidor do BD auxiliary, irá ter que colocar o caminho do bkp no comando duplicate.
$ rman AUXILIARY /

-- Target, but no catalog. Metadata comes from target database controlfile.
$ rman TARGET sys/password@DB11G-SOURCE AUXILIARY /

-- Catalog, but no target. Metadata comes from the RMAN catalog.
$ rman CATALOG rman/password@rman-catalog AUXILIARY /

-- Target and catalog. Metadata can come from the target controlfile or the catalog.
$ rman TARGET sys/password@DB11G-SOURCE CATALOG rman/password@rman-catalog AUXILIARY /


-- Duplicate active deve logar no RMAN igual abaixo

$ rman TARGET sys/password@DB11G-SOURCE AUXILIARY sys/password@DB11G-DESTINATION

run{
DUPLICATE DATABASE TO DB11G FROM ACTIVE DATABASE
NOFILENAMECHECK;
}


-- exemplo simples usando duplicate porem com backup no auxiliary
run{
DUPLICATE TARGET DATABASE TO DB11G
NOFILENAMECHECK;
}

-- passando o caminho do bkp.
run {
DUPLICATE TARGET DATABASE TO DB11G
BACKUP LOCATION '/bkp/DB11G'
NOFILENAMECHECK;
}

-- Duplicate database to TARGET's state 4 days ago.
run {
DUPLICATE TARGET DATABASE TO DB11G
UNTIL TIME 'SYSDATE-4'
NOFILENAMECHECK;
}


-- node1 
10.98.2.67
exacc01db01vmc01

-- script 
/u02/duplicate_active/rman_exec_duplicate_active_database_KPV_lnxdrs003.rman

-- script para rodar em nohup.
/u02/duplicate_active/dispara.sh

rman target sys/S1SCVP2024#OR#@KPV auxiliary sys/S1SCVP2024#OR#@KPV_STBY @/u02/duplicate_active/rman_exec_duplicate_active_database_KPV_lnxdrs003.rman
rman target sys/S1SCVP2024#OR#@KPV auxiliary sys/S1SCVP2024#OR#@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=lnxdrs003.rootbrasil.intranet)(PORT=1521))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=KPV_STBY)(UR=A)))" @/u02/duplicate_active/rman_exec_duplicate_active_database_KPV_lnxdrs003.rman

duplicate target database for STANDBY from active database NOFILENAMECHECK;
RECOVER DATABASE;


rman target sys/T7UcVp20#24#@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=exacc01-7jrgw1.rootbrasil.intranet)(PORT=1521))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=orakpvhm.rootbrasil.intranet)(UR=A)))" 

rman target sys/T7UcVp20#24#@ORAKPVHM02 auxiliary sys/T7UcVp20#24#@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=exacc01-kpv-hom-db01.adcorp.intranet)(PORT=1521))(CONNECT_DATA=(SERVER=DEDICATED)(SID=orakpvhm1)(UR=A)))"


rman target sys/T7UcVp20#24#@ORAKPVHM auxiliary sys/T7UcVp20#24#@KPVHML_NEW



rman target sys/S1SCVP2024#OR#@KPVPRD2 auxiliary sys/S1SCVP2024#OR#@KPV_STBY

rman TARGET sys/password@DB11G-SOURCE AUXILIARY /


KPVHML_NEW =
(DESCRIPTION =
(ADDRESS = (PROTOCOL = TCP)(HOST = exacc01-kpv-hom-db01.adcorp.intranet)(PORT = 1521))
(CONNECT_DATA =
  (SERVER = DEDICATED)
  (SID = orakpvhm1 )
)
)



-- comando abaixo faz o duplicate mudando também o nome para novo local
-- nessa situação o primary tem local diferente dos datafiles, e no stby será colocado no local correto.
-- Repare que usamos o set newnames for clone datafile e não o comum, pois estamos fazendo um duplicate e não um restore comum.
run
{
ALLOCATE  CHANNEL prmy1   DEVICE TYPE DISK;
ALLOCATE  CHANNEL prmy2   DEVICE TYPE DISK;
ALLOCATE  CHANNEL prmy3   DEVICE TYPE DISK;
ALLOCATE  CHANNEL prmy4   DEVICE TYPE DISK;
ALLOCATE AUXILIARY CHANNEL prim5  DEVICE TYPE DISK;
ALLOCATE AUXILIARY CHANNEL prim6  DEVICE TYPE DISK;
ALLOCATE AUXILIARY CHANNEL prim7  DEVICE TYPE DISK;
ALLOCATE AUXILIARY CHANNEL prim8  DEVICE TYPE DISK;
set newname for datafile 1 to '+DATAC2/ECCSTBY/DATAFILE/data_d-ecc_ts-system_fno-1' ;
set newname for datafile 2 to '+DATAC2/ECCSTBY/DATAFILE/data_d-ecc_ts-sysaux_fno-2' ;
set newname for datafile 3 to '+DATAC2/ECCSTBY/DATAFILE/data_d-ecc_ts-psapundo001_fno-3' ;
set newname for datafile 4 to '+DATAC2/ECCSTBY/DATAFILE/data_d-ecc_ts-psapsr3_fno-4' ;
set newname for datafile 5 to '+DATAC2/ECCSTBY/DATAFILE/data_d-ecc_ts-psapsr3_fno-5' ;
set newname for datafile 6 to '+DATAC2/ECCSTBY/DATAFILE/data_d-ecc_ts-psapsr3_fno-6' ;
set newname for datafile 7 to '+DATAC2/ECCSTBY/DATAFILE/data_d-ecc_ts-psapsr3_fno-7' ;
set newname for datafile 8 to '+DATAC2/ECCSTBY/DATAFILE/data_d-ecc_ts-psapsr3_fno-8' ;
set newname for datafile 9 to '+DATAC2/ECCSTBY/DATAFILE/data_d-ecc_ts-psapsr3_fno-9' ;
set newname for datafile 10 to '+DATAC2/ECCSTBY/DATAFILE/data_d-ecc_ts-psapsr3740_fno-10' ;
DUPLICATE target DATABASE TO DB11G FROM ACTIVE DATABASE;
}

export NLS_DATE_FORMAT='DD-MM-YYYY HH24:MI:SS'
export ORACLE_SID=DESE
rman target sys/db2006cen@prd auxiliary / msglog=duplicate_tape_PRD.log << EOF
run
{
ALLOCATE CHANNEL c1 DEVICE TYPE 'SBT_TAPE' SEND 'NB_ORA_CLIENT=ORATB748.servicos,NB_ORA_SERV=IPBBKPTB00.servicos';
ALLOCATE CHANNEL c2 DEVICE TYPE 'SBT_TAPE' SEND 'NB_ORA_CLIENT=ORATB748.servicos,NB_ORA_SERV=IPBBKPTB00.servicos';
ALLOCATE CHANNEL c3 DEVICE TYPE 'SBT_TAPE' SEND 'NB_ORA_CLIENT=ORATB748.servicos,NB_ORA_SERV=IPBBKPTB00.servicos';
ALLOCATE CHANNEL c4 DEVICE TYPE 'SBT_TAPE' SEND 'NB_ORA_CLIENT=ORATB748.servicos,NB_ORA_SERV=IPBBKPTB00.servicos';
ALLOCATE AUXILIARY CHANNEL ac1 DEVICE TYPE 'SBT_TAPE' SEND 'NB_ORA_CLIENT=ORATB748.servicos,NB_ORA_SERV=IPBBKPTB00.servicos';
ALLOCATE AUXILIARY CHANNEL ac2 DEVICE TYPE 'SBT_TAPE' SEND 'NB_ORA_CLIENT=ORATB748.servicos,NB_ORA_SERV=IPBBKPTB00.servicos';
ALLOCATE AUXILIARY CHANNEL ac3 DEVICE TYPE 'SBT_TAPE' SEND 'NB_ORA_CLIENT=ORATB748.servicos,NB_ORA_SERV=IPBBKPTB00.servicos';
ALLOCATE AUXILIARY CHANNEL ac4 DEVICE TYPE 'SBT_TAPE' SEND 'NB_ORA_CLIENT=ORATB748.servicos,NB_ORA_SERV=IPBBKPTB00.servicos';
DUPLICATE TARGET DATABASE TO DESE
LOGFILE
GROUP 1 ('+ORADATA/dese/onlinelog/log01a.log','+ORAFRA/dese/onlinelog/log01b.log') size 2000M,
GROUP 2 ('+ORADATA/dese/onlinelog/log02a.log','+ORAFRA/dese/onlinelog/log02b.log') size 2000M,
GROUP 3 ('+ORADATA/dese/onlinelog/log03a.log','+ORAFRA/dese/onlinelog/log03b.log') size 2000M,
GROUP 4 ('+ORADATA/dese/onlinelog/log04a.log','+ORAFRA/dese/onlinelog/log04b.log') size 2000M
until time "to_date('02-05-2013 05:10:00','dd-mm-yyyy hh24:mi:ss')";
}
EOF


-- para dataguard, somente aumentar os canais conforme desejar e se for possivel
run
{
ALLOCATE  CHANNEL prmy1   DEVICE TYPE DISK;
ALLOCATE  CHANNEL prmy2   DEVICE TYPE DISK;
ALLOCATE  CHANNEL prmy3   DEVICE TYPE DISK;
ALLOCATE  CHANNEL prmy4   DEVICE TYPE DISK;
ALLOCATE AUXILIARY CHANNEL prim5  DEVICE TYPE DISK;
ALLOCATE AUXILIARY CHANNEL prim6  DEVICE TYPE DISK;
ALLOCATE AUXILIARY CHANNEL prim7  DEVICE TYPE DISK;
ALLOCATE AUXILIARY CHANNEL prim8  DEVICE TYPE DISK;
set newname for datafile 1 to '+DATAC2/ECCSTBY/DATAFILE/data_d-ecc_ts-system_fno-1' ;
set newname for datafile 2 to '+DATAC2/ECCSTBY/DATAFILE/data_d-ecc_ts-sysaux_fno-2' ;
set newname for datafile 3 to '+DATAC2/ECCSTBY/DATAFILE/data_d-ecc_ts-psapundo001_fno-3' ;
set newname for datafile 4 to '+DATAC2/ECCSTBY/DATAFILE/data_d-ecc_ts-psapsr3_fno-4' ;
set newname for datafile 5 to '+DATAC2/ECCSTBY/DATAFILE/data_d-ecc_ts-psapsr3_fno-5' ;
set newname for datafile 6 to '+DATAC2/ECCSTBY/DATAFILE/data_d-ecc_ts-psapsr3_fno-6' ;
set newname for datafile 7 to '+DATAC2/ECCSTBY/DATAFILE/data_d-ecc_ts-psapsr3_fno-7' ;
set newname for datafile 8 to '+DATAC2/ECCSTBY/DATAFILE/data_d-ecc_ts-psapsr3_fno-8' ;
set newname for datafile 9 to '+DATAC2/ECCSTBY/DATAFILE/data_d-ecc_ts-psapsr3_fno-9' ;
set newname for datafile 10 to '+DATAC2/ECCSTBY/DATAFILE/data_d-ecc_ts-psapsr3740_fno-10' ;
duplicate target database for standby from active database NOFILENAMECHECK; 
}

-- executar no servidor de produção
rman target sys/S1SCVP2024#OR# auxiliary sys/S1SCVP2024#OR#@ECCSTBY @/u02/duplicate_stby/duplicate_stby_ECC_13102025.rman
rman target sys/S1SCVP2024#OR# auxiliary sys/S1SCVP2024#OR#@KPV_STBY @/u02/duplicate_stby/duplicate_stby_14072025.rman


rman target sys/T7UcVp20#24# auxiliary sys/T7UcVp20#24#@KIPREV_DEV_X10


-- usa direto pelo Dataguard
rman target sys/S1SCVP2024#OR#@KPVPRD2 auxiliary sys/S1SCVP2024#OR#@KPV_STBY @/u02/duplicate_active/rman_exec_duplicate_active_database_KPV_lnxdrs003.rman



rman target sys/T7UcVp201212d# auxiliary sys/aspd1i289##q234@ORAKPV_X10_STBY

-- exemplo para criar o dispara.sh
#!/bin/bash
datainicial=`date +%s`

NLS_DATE_FORMAT=DD/MM/YYYY_HH24:MI:SS;  export NLS_DATE_FORMAT

echo "Data Inicio "`date`
echo "------------------------------------------------------------------------"

rman target sys/S1SCVP2024#OR# auxiliary sys/S1SCVP2024#OR#@ECCSTBY @/u02/duplicate_stby/duplicate_stby_ECC_13102025.rman

# Calculo do tempo de execução..
# Calculo do tempo de execução..
datafinal=`date +%s`
soma=$((datafinal - datainicial))

horas=$((soma / 3600))
minutos=$(( (soma % 3600) / 60 ))
segundos=$((soma % 60))

echo ""
echo "------------------------------------------------------------------------"
echo " Tempo de Execução Backup KIPREV : ${horas}h:${minutos}m:${segundos}s "
echo "------------------------------------------------------------------------"
echo "Data Fim "`date`
