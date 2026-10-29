10.113.71.118


HOM02 - brcsfhscanbi

sqlplus hom02$ddomingues@hom02 


CONN DBA_MONITOR/"or@cle#123"



ORA-01157: cannot identify/lock data file 28 - see DBWR trace file
ORA-01110: data file 28: '+COLPRDATGRP/colpr_dr/datafile/tbsbuilderlive2dt01.284.938210217'
ORA-17503: ksfdopn:2 Failed to open file +COLPRDATGRP/colpr_dr/datafile/tbsbuilderlive2dt01.284.938210217
ORA-15001:


    Thread|Ultima Sequencia Recebida|Ultima Sequencia Aplicada| Diferenca
----------|-------------------------|-------------------------|----------
         1|                   154247|                   154181|        66
         2|                   149355|                   149290|        65
         3|                   147211|                   147147|        64
         4|                   147280|                   147223|        57




+PPWPRARCGRP

:q:


29086




tb-zscb1:5443



ALTER USER WESLEY_BRAGA identified by "95135746";



WESLEY_BRAGA

SELECT GRANTEE, OWNER, TABLE_NAME, PRIVILEGE FROM DBA_TAB_PRIVS WHERE GRANTEE ='WESLEY_BRAGA'; 



select * from user_sys_privs;