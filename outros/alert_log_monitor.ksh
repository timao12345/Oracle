	#!/usr/bin/ksh

# ------------------------------------------------------------------------------------------
# INITIAL SETUP
# ------------------------------------------------------------------------------------------
. $HOME/.ORACLE_BASE
[ -f /etc/oratab ] && export ORATAB=/etc/oratab || export ORATAB=/var/opt/oracle/oratab
echo "oratab is: $ORATAB"

cat $ORATAB|grep -v \^# |grep :Y |cut -d: -f1 |sort |sed 's/ //g' |while read DB
do

export ORACLE_SID=$DB
export ORAENV_ASK=NO
. oraenv
export DECIMAL_VERSION=$(sqlplus -V |sed -e 's/[a-z]//g' -e 's/[A-Z]//g' -e 's/ //g' |sed 's/[*:=-]//g' |grep -v ^$)
export NUMERIC_VERSION=$(echo $DECIMAL_VERSION |sed -e 's/\.//g')
echo "The database version is: $DECIMAL_VERSION - $NUMERIC_VERSION"
echo "Checking Alert Log for: $DB"

export TMPDIR=/tmp
IGNORELIST="03113|19809|19804|01013|07445"
RUNDATE=`date "+%d/%m/%y at %H:%M:%S"`
LOGFILE=${SH}/${DB}_chkalerts.log
DIFFFILE=${TMPDIR}/${DB}_chkalert.diff
ALERT2FILE=${TMPDIR}/${DB}_chkalert2
export  IGNORELIST RUNDATE LOGFILE DIFFFILE ALERT2FILE 

[ -f $DIFFFILE ] && rm $DIFFFILE
echo "Execution starts on ${HOSTNAME} on $RUNDATE"

( 

# ------------------------------------------------------------------------------------------
# SETUP Oracle Environment and alias for every database in the $ORATAB file
# ------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------
# ALERTLOG_10g=${BDUMPDIR}/alert_${DB}.log
# ALERTLOG_11g=$ORACLE_BASE/diag/rdbms/$(echo $ORACLE_SID|tr A-Z a-z)/$ORACLE_SID/trace/alert_$ORACLE_SID.log
# ------------------------------------------------------------------------------------------
if [ "$NUMERIC_VERSION" -lt 11 ]; then
  BDUMPDIR=${ORACLE_BASE}/admin/${DB}/bdump
  [ ! -d $BDUMPDIR ] && echo "BDUMP Dir: $BDUMP does not exist!!!!"
  echo "bdump: $BDUMPDIR"

  ALERTLOG=${BDUMPDIR}/alert_${DB}.log
else
  ALERTLOG=$ORACLE_BASE/diag/rdbms/$(echo $ORACLE_SID|tr A-Z a-z)/$ORACLE_SID/trace/alert_$ORACLE_SID.log
fi

[ ! -f $ALERTLOG ] && echo "ALert Log File $ALERTLOG does not exist!!!!"
echo "Alert Log is:  $ALERTLOG"

if [ ! -r ${ALERTLOG} ] ; then
  echo "$RUNDATE Could not read alert log ${ALERTLOG} for SID ${DB}"
  break
fi

touch ${SH}/chkalert1_${DB}
cp ${SH}/chkalert1_${DB} ${ALERT2FILE}

grep -n ORA- ${ALERTLOG} | egrep -v "${IGNORELIST}" > ${SH}/chkalert1_${DB}
set `wc -l ${SH}/chkalert1_${DB}`
COUNT1=$1
set `wc -l ${ALERT2FILE}`
COUNT2=$1

if [ $COUNT1 -lt $COUNT2 ] ; then
    > ${ALERT2FILE}
    COUNT2=0
fi

if [ $COUNT1 -gt $COUNT2 ] ; then
   diff ${SH}/chkalert1_${DB} ${ALERT2FILE}|grep "<" > ${DIFFFILE}

  FN=`echo $0 | sed s/\.*[/]//`
  export HOSTNAME=$(hostname)
  echo "Sending Alert - Diff file is:  $DIFFFILE"
  echo "$SH/alert_notification.ksh $FN `hostname` $DB "" "Alert log errors for ${DB}" ${DIFFFILE}"
  $SH/alert_notification.ksh $FN `hostname` $DB "" "Alert log errors for ${DB}" ${DIFFFILE}

fi

) >> ${LOGFILE} 2>&1

done