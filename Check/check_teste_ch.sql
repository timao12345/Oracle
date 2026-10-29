ORACLE_HOME=/oracle/elma03/app/product/9.2
export ORACLE_HOME

PATH=$ORACLE_HOME/bin:$PATH
export PATH 

NLS_LANG=AMERICAN_AMERICA.WE8ISO8859P1
export NLS_LANG

usbd=tech4b
export usbd

passbd=xpto#01
export passbd

sqlplus -s /nolog << EOF
spo /oracle/elma03/scripts/last_check_wf.log
connect $usbd/$passbd@deswf
@/oracle/elma03/scripts/check_wf.sql
connect $usbd/$passbd@dbwf
@/oracle/elma03/scripts/check_wf.sql
connect $usbd/$passbd@asdb
@/oracle/elma03/scripts/check_wf.sql
connect $usbd/$passbd@elma04
@/oracle/elma03/scripts/check_wf.sql
connect $usbd/$passbd@elma06
@/oracle/elma03/scripts/check_wf.sql
spo off
EOF

