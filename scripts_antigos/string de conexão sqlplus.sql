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


'(DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = lnxdrs003.rootbrasil.intranet)(PORT = 1521)) (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = PDBRCU)))'



PBSMART =(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.143.99.194)(PORT=1521))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=PBSMART)))


sqlplus / as sysdba@'(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.20.45.2)(PORT=1524))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=PBSMART)))'

sqlplus / as sysdba@'(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.20.45.2)(PORT=1524)))'


slqplus / as sysdba@'(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=10.154.72.42)(Port=1521))(CONNECT_DATA=(SID=itacard)))'




sqlplus @'(DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = lnxdrs003.rootbrasil.intranet)(PORT = 1521)) (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = orarcu_pdbrcuprd.pass.oracle.com)))'

PDBRCU = (DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = lnxdrs003.rootbrasil.intranet)(PORT = 1521)) (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = PDBRCU)))