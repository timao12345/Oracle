#!/bin/bash
# #############################################################################
# SHELL SCRIPT - Identifica os devices no SO para os Aliases MultPath ASM
# #############################################################################

# FORMATACAO DO TEXTO 
FG_BAR1="$(tput smso setaf 1)"
TextOPT0="$(tput sgr0)"
TextOPT1="$(tput bold setaf 1)"
TextOPT2="$(tput smso setaf 1)"
T_Blue="\e[34m"
T_Orange="\e[38;5;166m"
T_Light_Red="\e[91m"
T_Light_Cyan="\e[96m"
T_Light_Blue="\e[94m"
T_Light_Green="\e[92m"
T_Light_Yellow="\e[93m"
T_Light_Orange="\e[38;5;202m"
T_Default="\e[39m"

sName=`hostname`
TODAY=`date +%d/%m/%Y-%H:%M:%S`

DD/MM/YYYY-01:01:01

clear
echo
# identificando o arquivo (parametro de entrada) com a relacao dos discos ASM (oracleasm ASMLIB)
if [[ -z $1 ]]; then
	echo -e " ${TextOPT2}${T_Light_Green} AJUDA ${TextOPT0}"
	echo -e " ${TextOPT1} Voce precisa criar um arquivo com a relacao dos "
	echo -e "  discos ASM (asmlib / oracleasm) que vc pretende "
	echo -e "  obter  o  detalhamento. O  arquivo  deve  estar "
	echo -e "  no mesmo caminho deste script. "
	echo -e "  Para executar basta chamar este script  seguido "
	echo -e "  pelo nome do arquivo com a lista dos ASMDISKS.: ${TextOPT0}"
	echo -e " ${T_Light_Green} ./asmDisk_multpath_completo.sh nomeDoArquivo  ${TextOPT0}"
	echo
	echo -e " ${TextOPT1}EXIT 0 ${TextOPT0}"
	exit 0
fi

# Verificando se o arquivo de entrada exite no file system
if [[ -e $1 ]]; then 
	echo -e " ${TextOPT1}OBTENDO A LISTA DOS DISCOS ASM :${T_Light_Cyan} $1 ${TextOPT0}"
	echo
else
	echo -e " ${TextOPT2}${T_Light_Yellow} ATENCAO ${TextOPT0}"
	echo -e " ${T_Light_Yellow}Nao foi encontrado o arquivo com a relacao dos Oracle ASMDISKS. "
	echo -e " ----> $1 ${TextOPT0}"
	echo -e " ${TextOPT1}EXIT 1 ${TextOPT0}"
	exit 1
fi

#gerando o report de saida
echo -e "+--------------------------------------------------------------------------------+"  > ${1}.report
echo -e "|                             LIST DOS ORACLE ASMDISKS SELECIONADOS NESTE REPORT |" >> ${1}.report
echo -e "|                                                            ${TODAY} |" >> ${1}.report
echo -e "+--------------------------------------------------------------------------------+" >> ${1}.report
cat ${1} 	>> ${1}.report
echo 		>> ${1}.report
echo 		>> ${1}.report
echo -e "+--------------------------------------------------------------------------------+" >> ${1}.report
echo -e "|                                               DETALHAMENTO DOS ORACLE ASMDISKS |" >> ${1}.report
echo -e "|                                                            ${TODAY} |" >> ${1}.report
echo -e "+--------------------------------------------------------------------------------+" >> ${1}.report

# iniciando o loop com os discos ASM selecionados
for diskASM in `cat $1`
do
	#status execucao
	echo -en " ${TextOPT1}     ...........................................${TextOPT0} ${T_Light_Yellow}    0% ${TextOPT0} \r"
	echo -en " ${TextOPT1}${diskASM} ${TextOPT0}\r "
	#identificando o patch/mapper
	vDevMapper=`oracleasm querydisk -p ${diskASM} |grep "/dev/mapper"` 	#Exibir na saida
	#status execucao
	echo -en " ${TextOPT1}     ..........................................${TextOPT0} ${T_Light_Yellow}   80% ${TextOPT0} \r"
	echo -en " ${TextOPT1}${diskASM} ${TextOPT0}\r "
	vVAR1=`echo $vDevMapper |awk -F / '{print $4}' |awk -F : '{print $1}'`
	vDevice=`multipath -ll ${vVAR1} |grep "${vVAR1}"` 				#Exibir na saida
	vDevSize=`multipath -ll ${vVAR1} |grep size |awk -F " " '{print $1}'` #Exibir na saida
	#formatando a saida, gerando arquivo com o report.
	echo -e "ASMDISK: ${diskASM}" 				>> ${1}.report
	echo -e "         ${vDevMapper}" 			>> ${1}.report
	echo -e "         ${vDevice} ${vDevSize}"	>> ${1}.report
	echo 										>> ${1}.report
	#status execucao
	echo -en " ${TextOPT1}     ..........................................${TextOPT0} ${T_Light_Green}  DONE  ${TextOPT0} \r" 
	echo -en " ${TextOPT1}${diskASM} ${TextOPT0}\r "; sleep 0.300
done
echo; echo; echo -e "${T_Light_Green} CONCLUIDO! ${TextOPT0}"; echo

#Apresenta o arquivo gerado.
echo -e " ${TextOPT1}GERADO O REPORT :${TextOPT0} ${T_Light_Cyan}${1}.report ${TextOPT0}";echo; echo
exit 0
