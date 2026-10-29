#!/bin/bash

####################################################################################
#                                                                                  #
#           CONFIGURACOES - parametrizar de acordo com o ambiente                  #
#                            NAO EDITAR O RESTO DO ARQUIVO                         #
#                                                                                  #
####################################################################################

#  Onde os logs serao gerados

LOGFILE=/root/script/limpeza_logs.log

#  Lista de diretorios onde o comando find sera executado - obs: cuidado, nunca coloque o / "/"

ORACLE_DIR=`cat /root/script/oracle_dir_cfg`
LISTENER_DIR=`cat /root/script/listener_dir_cfg`

#  Parametrizacao de quais tipos de arquivos serao excluidos
#  para adicionar mais algum tipo adicione no final os paramentros " -o -name "*.oqueprocurar" "
#  Exemplo \( -name "*.aud" -o -name "*.trc"  -o -name "*.trm" -o -name "log_[0-9]*.xml -o -name "*.cacatua" " \)
#  neste exemplo foi adicionado o tipo de arquivo .cacatua

EXT="( -name "*.aud" -o -name "*.trc"  -o -name "*.trm" -o -name "log_[0-9]*.xml" )"


#  Quantos dias de arquivos deverao ser mantidos - aconselhamos manter pelo menos 7 dias

DIAS=4

######### FINAL DA SESSAO DE CONFIGURACAO DE PARAMENTROS - Nao editar a partir deste ponto #######
##################################################################################################

#  Nao alterar nada daqui para baixo se não souber o que está fazendo.

echo " " > $LOGFILE
echo "Removendo arquivos trc, aud e trm anteriores a " $DIAS " dias ....." >> $LOGFILE
echo " " >> $LOGFILE
date >>  $LOGFILE
df -h >> $LOGFILE
echo " " >> $LOGFILE
echo "Quantidade de arquivos removidos ....." >> $LOGFILE


for p in $ORACLE_DIR; do
echo $p >> $LOGFILE
/usr/bin/find $p $EXT -mtime +$DIAS -exec ls -la {} \; |  wc -l  >> $LOGFILE
echo " " >> $LOGFILE
#Find de remocao dos arquivos
/usr/bin/find $p $EXT -mtime +$DIAS -exec rm {} \; >> $LOGFILE
done

#  Depois da Remocao
echo " " >> $LOGFILE
df -h >> $LOGFILE

#  Essa parte limpa os Logs do Listener

echo " " >> $LOGFILE
echo "Limpando os logs do Listener ....." >> $LOGFILE
echo " " >> $LOGFILE

for d in $LISTENER_DIR; do
        FILES=`ls -1 $d | grep ".log"`
        for f in $FILES; do
        echo "Limpando... $d/$f" >> $LOGFILE

        tail -100000 $d/$f > $d/temp
        cat $d/temp > $d/$f
        echo " " > $d/temp
        done
done
echo " " >> $LOGFILE
df -h >> $LOGFILE
echo " " >> $LOGFILE
echo "Fim" >> $LOGFILE
                                