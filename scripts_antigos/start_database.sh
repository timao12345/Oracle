BCO=bancos.txt
for banco in $(cat $BCO)
do
    echo "Iniciando banco $banco"
    srvctl start database -d $banco
done
