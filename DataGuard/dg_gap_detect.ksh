# File Name: dg_gap_detect.ksh
export DR_DB=DEV_STDBY
export GAPFILE=${DR_DB}_gap.log

[ -f $GAPFILE ] && rm $GAPFILE

echo "Gaps in DR DB: $DR_DB"
echo "set head off ver off pages 0 feed off lines 122
SELECT * FROM V\$ARCHIVE_GAP;" |sqlplus -s "sys/${SYSPASSWD}@${DR_DB} as sysdba" > $GAPFILE

# Print the contents of the GAPFILE
cat $GAPFILE

cat $GAPFILE |while read THREAD LOW HIGH
do
echo "Reporting Archivelogs that need to be manually shipped"
echo "set head off ver off pages 0 feed off lines 222
select name 
from v\$archived_log
where thread#=${THREAD}
and dest_id=1
and sequence# between ${LOW} and ${HIGH};" |sqlplus -s / as sysdba
done
