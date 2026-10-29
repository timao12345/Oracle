#!/bin/ksh

#==========================================================================================================#
# Execucao                                                                                                 #
# sh -x rman_backup.sh -i BD -t TYPE_BACKUP                                                                #
#==========================================================================================================

#==========================================================================================================#
# Updates and comments                                                                                     #
# [12/06/2020] - Inclusao de teste com LOCKFILE para ver se o script esta em execucao.                     #
# [15/06/2020] - Para um melhor controle a validdacao do LOCKFILE foi colocado em cada funcao de backup    #
#                A funcao de backup de archive ganhou uma validacao de LOCKFILE exclusiva, pra que um      #
#                backup de archive espere o final do anterior.                                             #
# [19/06/2020] - Alterado o local de geracao dos arquivos de LOCKFILE para o mesmo local de log dos        #
#                backups.                                                                                  #
# [25/06/2020] - Colocacao de scripts no catalogo. E remocao de partes nao utilizadas.                     #
# [02/07/2020] - Ajuste de TAGs e nomes das funcoes. Nao sera possivel mais executar a manutencao no       #
#                catalogo enquanto um backup de banco estiver em execucao e vice-versa                     #
# [23/11/2020] - Retirada do bloqueio de backup pela funcao BKP_MAINTENANCE - CHG0034177.                  #
# [07/12/2020] - Alteracao para permitir o backup em paralelo de instancias diferentes no mesmo servidor   #
#                - CHG0034357.                                                                             #
# [19/03/2021] - Inclusao de chamada a script que envia alerta passivo para o Nagios caso o backup falhe   #
#                - CHG0035333.                                                                             #
#==========================================================================================================#


#===================#
# VERIFICACAO DO SO #
#===================#

CHECK_OS=$(uname)
if [ $CHECK_OS == "AIX" ]; then
alias TAIL="tail -1"
alias GREP="/usr/bin/grep"
alias EGREP="/usr/bin/egrep"
else
alias TAIL="tail -n1"
alias GREP="/bin/grep"
alias EGREP="/bin/egrep"
fi

#===========#
# VARIAVEIS #
#===========#
valida=/usr/local/scripts/diario/valida
DIRLOG=/usr/local/scripts/diario
SKIPLOGFILE=$DIRLOG/skipbackup_`date +%Y%m%d`.log
WORKDIR=/usr/local/database/monitoring

echo > $valida
MDAY=`date +%d`
DATE=`date +%Y%m%d`
DATE_2=`date +%Y%m%d%H%M`
while getopts ":i:t:" opt
do
  case $opt in
        i) INSTANCE=$OPTARG ;;
        t) TYPE_BKP=$OPTARG ;;

       esac
done

if [[ -z $INSTANCE ]]; then
  echo ""
  echo "Parametro [-i] faltando, portanto o processo sera executado para todas as instancias localizadas no /etc/oratab."
  export INSTANCE=$(EGREP -v "^#|\*|ASM" /etc/oratab | awk -F: 'length($1) > 1 {print $1}')
  echo ""
fi

#=======================#
# INFORMACOES DE CANAIS #
#=======================#

#FILESPERSET=10

#========================#
# FUNCAO BKP_DIARIO_INC #
#========================#

function BKP_DIARIO_INC {
set -x
CATALOG_DB="catalog USER_CATALOGO/rmngrprd@CATALOGDB"
TAGNAME="$i"_"$DATE"
export ORACLE_SID=$i
export ORACLE_HOME=$(GREP "$i" /etc/oratab | awk -F: '{print $2}' | TAIL)
arq="/usr/local/scripts/diario/"$i"_DIARIO_INC_"$DATE"_rman.log"

if [ -f $LOCKFILE ]; then

   echo "One Backup already executing!!! Actual: $TYPE_BKP `date +%d/%m/%Y\ %H:%M:%S`" >> $SKIPLOGFILE
   echo "One Backup already executing!!! Actual: $TYPE_BKP `date +%d/%m/%Y\ %H:%M:%S`"

   exit 40

else

   touch $LOCKFILE

fi


$ORACLE_HOME/bin/rman target / $CATALOG_DB  << EOF >> $arq
run{
ALLOCATE CHANNEL CH1 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH2 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH3 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH4 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH5 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH6 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH7 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH8 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH9 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH10 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH11 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH12 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH13 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH14 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH15 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH16 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';

CONFIGURE RETENTION POLICY TO RECOVERY WINDOW OF 31 DAYS;
CONFIGURE CONTROLFILE AUTOBACKUP OFF;
BACKUP INCREMENTAL LEVEL 1 DATABASE FORMAT 'INCR_L1_%d_%T_%s_%p.rman' TAG='DIARIO_INC' FILESPERSET 10;
BACKUP CURRENT CONTROLFILE TAG='DIARIO_INC' FORMAT 'CONTROL_%d_%T_%s_%p.rman';
}
EOF

erro=$?

if [ -f $LOCKFILE ]; then

   rm $LOCKFILE

fi

if [ "$erro" != 0 ] ; then
date >> $arq
echo "ERRO NO BACKUP FULL TAPE DO BANCO DE DADOS $i" >> $arq
echo $erro >> $valida
BACKUPOK=0
fi

}


#========================#
# FUNCAO BKP_SEMANAL_INC #
#========================#

function BKP_SEMANAL_INC {
set -x
CATALOG_DB="catalog USER_CATALOGO/rmngrprd@CATALOGDB"
TAGNAME=SEMANAL_FULL_"$i"_"$DATE"
export ORACLE_SID=$i
export ORACLE_HOME=$(GREP "$i" /etc/oratab | awk -F: '{print $2}' | TAIL)
arq="/usr/local/scripts/diario/"$i"_SEMANAL_INC_"$DATE"_rman.log"

if [ -f $LOCKFILE ]; then

   echo "One Backup already executing!!! Actual: $TYPE_BKP `date +%d/%m/%Y\ %H:%M:%S`" >> $SKIPLOGFILE
   echo "One Backup already executing!!! Actual: $TYPE_BKP `date +%d/%m/%Y\ %H:%M:%S`"

   exit 40

else

   touch $LOCKFILE

fi


$ORACLE_HOME/bin/rman target / $CATALOG_DB  << EOF >> $arq
run{
ALLOCATE CHANNEL CH1 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH2 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH3 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH4 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH5 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH6 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH7 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH8 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH9 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH10 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH11 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH12 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH13 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH14 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH15 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH16 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';

CONFIGURE RETENTION POLICY TO RECOVERY WINDOW OF 31 DAYS;
CONFIGURE CONTROLFILE AUTOBACKUP OFF;
BACKUP INCREMENTAL LEVEL 0 DATABASE FORMAT 'INCR_L0_%d_%T_%s_%p.rman' TAG='SEMANAL_INC0' FILESPERSET 10 PLUS ARCHIVELOG FORMAT 'INCR_L0_ARCH_%d_%T_%s_%p.rman' TAG='SEMANAL_INC0';
BACKUP CURRENT CONTROLFILE FORMAT 'INCR_L0_CONTROL_%d_%T_%s_%p.rman' TAG='SEMANAL_INC0';
}
EOF

erro=$?

if [ -f $LOCKFILE ]; then

   rm $LOCKFILE
fi

if [ "$erro" != 0 ] ; then
date >> $arq
echo "ERRO NO BACKUP FULL TAPE DO BANCO DE DADOS $i" >> $arq
echo $erro >> $valida
BACKUPOK=0
fi

}

#========================#
# FUNCAO BKP_FULL_MENSAL #
#========================#

function BKP_FULL_MENSAL {
set -x
CATALOG_DB="catalog USER_CATALOGO/rmngrprd@CATALOGDB"
export ORACLE_SID=$i
export ORACLE_HOME=$(GREP "$i" /etc/oratab | awk -F: '{print $2}' | TAIL)
arq="/usr/local/scripts/diario/"$i"_FULL_MENSAL_"$DATE"_rman.log"

if [ -f $LOCKFILE ]; then

   echo "One Backup already executing!!! Actual: $TYPE_BKP `date +%d/%m/%Y\ %H:%M:%S`" >> $SKIPLOGFILE
   echo "One Backup already executing!!! Actual: $TYPE_BKP `date +%d/%m/%Y\ %H:%M:%S`"

   exit 40

else

   touch $LOCKFILE

fi

$ORACLE_HOME/bin/rman target / $CATALOG_DB  << EOF >> $arq
run{
ALLOCATE CHANNEL CH1 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH2 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH3 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH4 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH5 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH6 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH7 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH8 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';

CONFIGURE CONTROLFILE AUTOBACKUP OFF;
BACKUP DATABASE FORMAT 'MENSAL_%d_%T_%s_%p.rman' TAG='MENSAL_FULL' FILESPERSET 10 KEEP UNTIL TIME 'sysdate+365' LOGS INCLUDE CURRENT CONTROLFILE PLUS ARCHIVELOG FORMAT 'MENSAL_ARCH_%d_%T_%s_%p.rman' TAG='MENSAL_FULL';
BACKUP CURRENT CONTROLFILE FORMAT 'MENSAL_CONTROL_%d_%T_%s_%p.tman' TAG='MENSAL_FULL' KEEP UNTIL TIME 'sysdate+365';
}
EOF

erro=$?

if [ -f $LOCKFILE ]; then

   rm $LOCKFILE

fi

if [ "$erro" != 0 ] ; then
date >> $arq
echo "ERRO NO BACKUP FULL TAPE DO BANCO DE DADOS $i" >> $arq
echo $erro >> $valida
BACKUPOK=0
fi

}

#========================#
# FUNCAO BKP_FULL_ANUAL  #
#========================#

function BKP_FULL_ANUAL {
set -x
CATALOG_DB="catalog USER_CATALOGO/rmngrprd@CATALOGDB"
export ORACLE_SID=$i
export ORACLE_HOME=$(GREP "$i" /etc/oratab | awk -F: '{print $2}' | TAIL)
arq="/usr/local/scripts/diario/"$i"_FULL_HIST_"$DATE"_rman.log"

if [ -f $LOCKFILE ]; then

   echo "One Backup already executing!!! Actual: $TYPE_BKP `date +%d/%m/%Y\ %H:%M:%S`" >> $SKIPLOGFILE
   echo "One Backup already executing!!! Actual: $TYPE_BKP `date +%d/%m/%Y\ %H:%M:%S`"

   exit 40

else

   touch $LOCKFILE

fi

$ORACLE_HOME/bin/rman target / $CATALOG_DB  << EOF >> $arq
run{
ALLOCATE CHANNEL CH1 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH2 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH3 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH4 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH5 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH6 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH7 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH8 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH9 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH10 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH11 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH12 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH13 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH14 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH15 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH16 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';

CONFIGURE CONTROLFILE AUTOBACKUP OFF;
BACKUP FORMAT 'HIST_%d_%T_%s_%p.rman' TAG='ANUAL_FULL' FILESPERSET 10 DATABASE KEEP UNTIL TIME 'sysdate+3660' LOGS INCLUDE CURRENT CONTROLFILE PLUS ARCHIVELOG FORMAT 'HIST_ARCH_%d_%T_%s_%p.rman' TAG='ANUAL_FULL';
BACKUP CURRENT CONTROLFILE FORMAT 'HIST_CONTROL_%d_%T_%s_%p.tman' TAG='ANUAL_FULL' KEEP UNTIL TIME 'sysdate+3660';
}
EOF

erro=$?

if [ -f $LOCKFILE ]; then

   rm $LOCKFILE

fi

if [ "$erro" != 0 ] ; then
date >> $arq
echo "ERRO NO BACKUP FULL TAPE DO BANCO DE DADOS $i" >> $arq
echo $erro >> $valida
BACKUPOK=0
fi

}

#==========================#
# FUNCAO BKP ARCHIVE       #
#==========================#

function BKP_ARCHIVE {
CATALOG_DB="catalog USER_CATALOGO/rmngrprd@CATALOGDB"
export ORACLE_SID=$i
export ORACLE_HOME=$(GREP "$i" /etc/oratab | awk -F: '{print $2}' | TAIL)
arq="/usr/local/scripts/diario/"$i"_ARCHIVE_"$DATE"_rman.log"

if [ -f $LOCKFILE ]; then

   echo "Backup already executing!!! Skipping $TYPE_BKP $ORACLE_SID `date +%d/%m/%Y\ %H:%M:%S`" >> $SKIPLOGFILE
   echo "Backup already executing!!! Skipping $TYPE_BKP $ORACLE_SID `date +%d/%m/%Y\ %H:%M:%S`"

   exit 40

elif  [ -f $LOCKFILEARCH ]; then

   echo "Backup Archive already executing!!! Skipping $TYPE_BKP $ORACLE_SID `date +%d/%m/%Y\ %H:%M:%S`" >> $SKIPLOGFILE
   echo "Backup Archive already executing!!! Skipping $TYPE_BKP $ORACLE_SID `date +%d/%m/%Y\ %H:%M:%S`"

   exit 40

else

   touch $LOCKFILEARCH

fi

$ORACLE_HOME/bin/rman target / $CATALOG_DB  << EOF >> $arq
run {
ALLOCATE CHANNEL CH1 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH2 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH3 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH4 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH5 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH6 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH7 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
ALLOCATE CHANNEL CH8 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';

CONFIGURE RETENTION POLICY TO RECOVERY WINDOW OF 31 DAYS;
BACKUP FORMAT 'ARCH_%d_%T_%s_%p.rman' TAG='ARCHIVE' ARCHIVELOG ALL DELETE ALL INPUT;
BACKUP CURRENT CONTROLFILE TAG='ARCH_CONROLFILE' FORMAT 'CONTROL_%d_%T_%s_%p.rman';
}
EOF

erro=$?

if [ -f $LOCKFILEARCH ]; then

   rm $LOCKFILEARCH

fi

BACKUPOK=2

if [ "$erro" != 0 ] ; then
date >> $arq
echo "ERRO NO BACKUP ARCHIVE TAPE DO BANCO DE DADOS $i" >> $arq
echo $erro >> $valida
fi

}

#===========================#
# FUNCAO BACKUP_MAINTENANCE #
#===========================#

function BACKUP_MAINTENANCE {
set -x
CATALOG_DB="catalog USER_CATALOGO/rmngrprd@CATALOGDB"
export ORACLE_SID=$i
export ORACLE_HOME=$(GREP "$i" /etc/oratab | awk -F: '{print $2}' | TAIL)
arq="/usr/local/scripts/diario/"$i"_MAINTENANCE_"$DATE"_rman.log"


$ORACLE_HOME/bin/rman target / $CATALOG_DB  << EOF >> $arq
allocate channel for maintenance device type 'sbt_tape' parms 'ENV=(TDPO_OPTFILE=/usr/tivoli/tsm/client/oracle/bin64/tdpo.opt)';
allocate channel for maintenance device type disk;
crosscheck backup;
crosscheck archivelog all;
delete noprompt expired backup;
delete noprompt obsolete;
delete noprompt expired archivelog all;
EOF

erro=$?
BACKUPOK=2

if [ "$erro" != 0 ] ; then
date >> $arq
echo "ERRO NA MANUTENCAO DO BACKUP DO BANCO DE DADOS $i" >> $arq
echo $erro >> $valida
fi
}

#===================#
# FUNCAO VALIDA     #
#===================#

function VALIDA {
set -x
valerro=`cat $valida`

#=====================================#
# Validacao por precaucao             #
#=====================================#

if [ -f $LOCKFILE ]; then

   if [ $TYPE_BKP != "BKP_ARCHIVE" ]; then

      rm $LOCKFILE

   fi

fi

for erro in $valerro ; do


   if [ $TYPE_BKP != "BKP_ARCHIVE" ]; then

      if [ "$erro" != 0 ] ; then

         exit $erro

      fi

   fi

done

}

set -x
for i in $INSTANCE VALIDA ; do
      if [ $i == "VALIDA" ]; then
         VALIDA
      else

         BACKUPOK=1
         LOCKFILE=$DIRLOG/LOCKFILE_$i.backup
         LOCKFILEARCH=$DIRLOG/ARCHLOCKFILE_$i.backup
         $TYPE_BKP

         if [ $BACKUPOK == "1" ]; then

            echo "With OK: NO $TYPE_BKP $ORACLE_SID"
            nohup $WORKDIR/check_backup.sh OK $TYPE_BKP $ORACLE_SID &


         elif [ $BACKUPOK == "0" ]; then

            echo "With NO OK: NO $TYPE_BKP $ORACLE_SID"
            nohup $WORKDIR/check_backup.sh NO $TYPE_BKP $ORACLE_SID &

         else

            echo $TYPE_BKP

         fi

      fi
done
