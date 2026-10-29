-- Tipo de string para conexão no sqlplus
-- pegar o atring no arquivo TNSNAME, sempre retirar os espaços
--Pode utilizar o TNSPING seguido do nome da instancia para encontrar a string
$> tnsping {nome do banco}

--Exemplo

$> tnsping XE

----- // -----

sqlplus usuario/senha@//host:porta/server_name{banco}

sqlplus system/system@//havanab/itacard

sqlplus / as sysdba@'(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.154.72.42)(PORT=1521))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=itacard)))'

sqlplus / as sysdba@//localhost/PBSMART

sqlplus system/system@//localhost/XE

sqlplus / as sysdba@'(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=XE)))'



PBSMART =(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.143.99.194)(PORT=1521))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=PBSMART)))


sqlplus / as sysdba@'(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.20.45.2)(PORT=1524))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=PBSMART)))'

sqlplus / as sysdba@'(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.20.45.2)(PORT=1524)))'


slqplus / as sysdba@'(DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = lnxdrs003.rootbrasil.intranet)(PORT = 1521)) (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = PDBRCU)))'


slqplus / as sysdba@'(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=lnxdrs003.rootbrasil.intranet)(PORT=1521))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=PDBRCU)(UR=A)))'



sqlplus / as sysdba@'(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=exacc01-scan)(PORT=4577))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=PDIREC4)(FAILOVER_MODE=(TYPE=SELECT)(METHOD = BASIC))))'

sqlplus oracle_bkp@'(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=exacc01-kpv-hom-scan.adcorp.intranet)(PORT=1521))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=ORAKPVHM.adcorp.intranet)))'

sqlplus oracle_bkp@'(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=exacc01-kpv-hom-db01.adcorp.intranet)(PORT=1521))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=ORAKPVHM.adcorp.intranet)(INSTANCE_NAME=orakpvhm1)))'

rman target oracle_bkp@'(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=exacc01-kpv-prd-bkp-db01.adcorp.intranet)(PORT=1521))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=KPVPRD.adcorp.intranet)(INSTANCE_NAME=kpvprd1)))'


rman target oracle_bkp/CKP09#Bzp03@'(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=exacc01-kpv-prd-bkp-db01.adcorp.intranet)(PORT=1521))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=KPVPRD.adcorp.intranet)(INSTANCE_NAME=kpvprd1)))' AS SYSBACKUP

rman target oracle_bkp/CKP09#Bzp03@NETBACKUP AS SYSBACKUP



rman target oracle_bkp/CKP09#Bzp03 AS SYSBACKUP