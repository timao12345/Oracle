-- Instalar os pacotes do client oracle
sudo dnf install oracle-instantclient-release-el8
sudo dnf install oracle-instantclient-basic
sudo dnf install oracle-instantclient-sqlplus

-- Criar os directorios abaixo no directorio /usr/lib/oracle/21/client64/

mkdir network/admin -p

-- Criar o arquivos tnsnames.ora no direcotrio /usr/lib/oracle/21/client64/network/admin com a string do bd destidno.

SEEDPDB2 =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 10.102.13.165)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = seedpdb1.subnetclientese.vcnrootskyoneda.oraclevcn.com)
    )
  )


-- Criar arquivo /etc/profile.d/client.sh , são as variaveis de ambiente, quando usuario logar irá setar automaticamente as variaveis
export ORACLE_HOME=/usr/lib/oracle/21/client64
export PATH=$PATH:$ORACLE_HOME/bin 
export LD_LIBRARY_PATH=$ORACLE_HOME/lib 
export TNS_ADMIN=$ORACLE_HOME/network/admin


-- testando a conexão. Exemplo: sqlplus [user]@SID da string do tnsnames.ora

[root@sch-qa-one-01 ~] sqlplus dbskyone@SEEDPDB2

SQL*Plus: Release 21.0.0.0.0 - Production on Wed Mar 2 12:12:46 2022
Version 21.5.0.0.0

Copyright (c) 1982, 2021, Oracle.  All rights reserved.

Enter password:
Last Successful login time: Wed Mar 02 2022 12:05:50 -03:00

Connected to:
Oracle Database 19c Standard Edition 2 Release 19.0.0.0.0 - Production
Version 19.13.0.0.0

SQL>