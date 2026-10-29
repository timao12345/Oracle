#!/bin/bash
test -s /etc/profile.d/oracle.sh && source /etc/profile.d/oracle.sh
# ---------------------------------------------------------------------------
declare -r   ORACLE_DB_NAME='edlbeqd'
declare -rx  ORACLE_SID="${ORACLE_DB_NAME}"
declare -r   logDir="/oracle/admin/$ORACLE_DB_NAME/log"
#declare -rx  NLS_LANG='AMERICAN_AMERICA.WE8ISO8859P1'
declare -rx  NLS_LANG='AMERICAN_AMERICA.WE8MSWIN1252'
declare -r   ORACLE_CONN_USER=''
declare -r   ORACLE_CONN_PASS=''
declare -ri  STATS_DEALLOCATE_UNUSED=0

# ---------------------------------------------------------------------------
declare -r logFile="$logDir/index_rebuild_full.log"
declare -r tmpFile0="$logDir/script.index_rebuild_full.tmp"

#declare -i statsParallel=0
# ---
export PATH="/sbin:/usr/sbin:/bin:/usr/bin:$PATH:/usr/local/sbin:/usr/local/bin"
export NLS_DATE_FORMAT='DDMonYYYY/HH24:MI'

exec >> "$logFile" 2>&1

echo "Rebuild Index FULL, node `hostname`"
echo "Rebuild Index FULL, database $ORACLE_DB_NAME"

test ${#ORACLE_CONN_USER} -gt 0 && {
"$ORACLE_HOME/bin/sqlplus" -S /nolog << _SQL_
    connect / as sysdba ;
    set lines 850 pages 0 long 99999999;
    spool "$tmpFile0";
    select 'ALTER INDEX "'||idx.OWNER||'"."'||idx.segment_name||'" REBUILD ONLINE;' 
    from (
        select owner, segment_name, sum(bytes)/1024/1024 as MB 
        from dba_segments 
        where owner like ('MG%') and segment_type='INDEX' 
        group by owner,segment_name order by MB)  idx;
    spool off;
    set timing on;
    exit ;
    quit ;
}