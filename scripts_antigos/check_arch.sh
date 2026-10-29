for oradb in $(cat /home/grid/listsid.txt)
do

        ## gera lista de archives por DB
        arquivo=~/gap/arch_$oradb.lst
        asmcmd -p ls dgarch/$oradb/archivelog/*/thread* > $arquivo

        echo "base $oradb"
        /home/grid/checkarc.awk $arquivo
        echo

done
