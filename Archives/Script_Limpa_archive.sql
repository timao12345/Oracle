
oracle@nerv05 ~]$ rman target / catalog=USER_CATALOGO/USER_CATALOGO@CATALOGO cmdfile=/home/oracle/script.sql log=/u01/backup/blalalalalalalla.log


mkdir /backup/RMAN/scripts
mkdir /backup/RMAN/logs


#!/bin/bash

delete_archive_gemcoprd1.ksh

#!/bin/ksh
export ORACLE_HOME=/u01/app/oracle/product/11.2.0.3/oraprd
export ORACLE_SID=roadnetdr1
rman target / log=/backup/RMAN/logs/rman_delete_archive_gemcoprd1-$(date +%d%m%Y).log << EOF
list archivelog all;
EOF
