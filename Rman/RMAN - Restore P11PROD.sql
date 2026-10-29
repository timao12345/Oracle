Baixa os dois Nodes .
Sobi somente um node
altera o paramatro cluster_database para FALSE.
baixa o banco 
Sobe o banco nomount

Restore GABC
Se tiver usando Catalogo RMAN não é preciso catalogar todos os pieces.
restore o controlfile
run
{
allocate channel ch1 type 'sbt_tape' parms 'ENV=(NB_ORA_POLICY=GABC_ORACLE_RMAN_GABCORACL01_P11PROD,NB_ORA_SERV=sts25lnx,NB_ORA_CLIENT=sd06tb389p1_bkp)';
set DBID=800868579
restore controlfile from 'diario_L0_P11PROD_evskj1mo_1_1.bkp';
release channel ch1;
}

alter database mount;
	

depois seta no SO as variaveis de ambiente para formatar a data desejada.


--> NO PROMPT DO SO
NLS_DATE_FORMAT='DD.MM.YYYY HH24:MI:SS'
NLS_TIMESTAMP_FORMAT='DD.MM.YYYY HH24:MI:SS'
export NLS_DATE_FORMAT
export NLS_TIMESTAMP_FORMAT

Script para fazer o restore e o recover.


rman tagert sys/mu2t4ng@P11PROD catalog rman/rman@RMAN

--> RECOVER FINAL - RMAN
RUN {
allocate channel ch1 type 'sbt_tape' parms 'ENV=(NB_ORA_POLICY=GABC_ORACLE_RMAN_GABCORACL01_P11PROD,NB_ORA_SERV=sts25lnx,NB_ORA_CLIENT=sd06tb389p1_bkp)';
set until time "to_date('30.11.2017 15:35:00', 'dd.mm.yyyy hh24:mi:ss')";
RESTORE DATABASE;
RECOVER DATABASE;
release channel ch1;
}

Caso tenha que alterar o local dos datafiles , então deve ser usado o set new name.


Script para deixar em background


#!/bin/bash
## Variaveis para a configuracao do script.
BASE_DIR="/home/oracle/Pimentel"
export ORACLE_HOME=/u01/app/oracle/product/11.2.0/db_1
export ORACLE_SID=P11PROD1
export PATH=/usr/local/bin:/bin:/usr/bin:$ORACLE_HOME/bin
LOG_DIR="$BASE_DIR/logs_backup"
DT_LOG=`date +%Y%m%d_%Hh%M`
DATA=`date +%d/%m/%Y-%H:%M:%S`

export NLS_DATE_FORMAT='DD.MM.YYYY HH24:MI:SS'
export NLS_TIMESTAMP_FORMAT='DD.MM.YYYY HH24:MI:SS'


# ###############################################################################
# Constroe Estrutura de Diretorios
# ###############################################################################
## Verifica / Cria o diretorio de Log
if [ ! -d ${LOG_DIR} ];
        then mkdir -p ${LOG_DIR};
fi

# ##############################################################################
# Definicao das Funcoes de Backup e Operacao
# ##############################################################################

function restore_full
{
$ORACLE_HOME/bin/rman target / catalog rman/rman@RMAN << EOF >> ${LOG_DIR}/${DT_LOG}_RMAN_RESTORE.log 2>&1
RUN {
allocate channel ch1 type 'sbt_tape' parms 'ENV=(NB_ORA_POLICY=GABC_ORACLE_RMAN_GABCORACL01_P11PROD,NB_ORA_SERV=sts25lnx,NB_ORA_CLIENT=sd06tb389p1_bkp)';
set until time "to_date('30.11.2017 15:35:00', 'dd.mm.yyyy hh24:mi:ss')";
RESTORE DATABASE;
RECOVER DATABASE;
release channel ch1;
}
EOF
# Verificando Status de execucao dos comandos RMAN
if [ "$?" == "0" ]; then
        DATA=`date +%d/%m/%Y-%H:%M:%S`
    # ##############################################################
        # Cria arquivo de controle de Status de Execucao
        # ##############################################################
        echo "  $DATA:  RMAN_RESTORE - OK!"      >> ${LOG_DIR}/${DT_LOG}_RMAN_RESTORE.log 2>&1
        exit 0
else
        DATA=`date +%d/%m/%Y-%H:%M:%S`
    # ##############################################################
        # Cria arquivo de controle de Status de Execucao
        # ##############################################################
        echo "  $DATA:  RMAN_RESTORE - ERRO!" >> ${LOG_DIR}/${DT_LOG}_RMAN_RESTORE.log 2>&1
        exit 1
fi
}

# executando o Backup
restore_full

# Fim do script.




mudar o paramtro cluster_database = TRUE
baixa o banco
srvctl start database -d P11PROD 