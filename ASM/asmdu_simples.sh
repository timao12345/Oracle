export ORAENV_ASK=NO
export ORACLE_SID=`ps -ef|grep pmon_+ASM |grep -v grep |awk -F"_" '{ print $NF;}'`
. oraenv
echo "------Main Report--------"
asmcmd lsdg | awk  'BEGIN { print "\nSize\tUsed\tAvail\tUse%\tName" getline } { printf" %s \t%.0f\t %.0f  %.0f'%' \t%s    \n"  ,$7/1024 ,$7/1024-$8/1024 , $8
/1024, ($7-$8)*100/$7, $12}'
echo
for m  in $(asmcmd ls + | awk -v z='+' '{ print z$0 }' |egrep '/$' );
do
echo -e "$m \t `asmcmd du $m | awk  'BEGIN {getline } { printf"%.0fGB\n"  ,$2/1024}'`"
done
echo

echo "----Detailed  Report------"
for dg  in $(asmcmd ls + | awk -v z='+' '{ print z$0 }' |egrep '/$' );
do
    #echo -e "$dg \t `asmcmd du $dg | awk  'BEGIN {getline } { printf"%.0fGB\n"  ,$2/1024}'`"
    printf "%-20s %-20s \n" $dg `asmcmd du $dg | awk  'BEGIN {getline } { printf"%.0fGB\n"  ,$2/1024}'`
    #asmcmd ls $dg| awk -v y=$dg '{ print y$0 }'|egrep '/$';
    for db in $(asmcmd ls $dg| awk -v y=$dg '{ print y$0 }'|egrep '/$';)
    do
     #echo -e "$db \t `asmcmd du $db | awk  'BEGIN {getline } { printf"%.0fGB\n"  ,$2/1024}'`"
     printf "\t%-20s %-20s \n" $db `asmcmd du $db | awk  'BEGIN {getline } { printf"%.0fGB\n"  ,$2/1024}'`
    done
    #echo -------------
for cdir in $(asmcmd ls $dg| awk -v y=$dg '{ print y$0 }'|egrep '/$');
do
   #asmcmd ls $cdir| awk -v x=$cdir '{ print x$0 }'|egrep '/$';
   printf "\t\t%-20s\n" `asmcmd ls $cdir| awk -v x=$cdir '{ print x$0 }'|egrep '/$';`
done
echo
done