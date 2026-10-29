#!/bin/sh

. ~oracle/.bash_profile

# Confere parametros de entrada
if [ $# -eq 1 ]; then
   ORACLE_SID=$1
else
   echo "$0 deve receber como parametro o nome da instancia"
   exit
fi

export NLS_DATE_FORMAT='YYYYMMDD HH24:MI:SS'

echo "-------------------------------------------------------------------------------------"
echo `date` " - Backup com RMAN - catalogo na orams"
rman target / log=/u02/bkp.log << EOF
show all;
backup database plus archivelog delete all input;
delete noprompt obsolete;
list backup;
exit
EOF
echo `date` " - Fim do backup do synprd "
echo "-------------------------------------------------------------------------------------"

~
~
