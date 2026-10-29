###Configuração do Broker###


### Alteração do init.ora no servidor PRIMARIO

#FILA
ALTER SYSTEM SET DG_BROKER_CONFIG_FILE1='/u02/app/oracle/product/19.0.0.0/dbhome_1/dbs/drs1KPVPRD.dat' SCOPE=BOTH sid='*';
ALTER SYSTEM SET DG_BROKER_CONFIG_FILE2='/u02/app/oracle/product/19.0.0.0/dbhome_1/dbs/drs2KPVPRD.dat' SCOPE=BOTH sid='*';
alter system set dg_broker_start=true scope=both;


### Alteração do init.ora no servidores STANDBYS

#FILADG
ALTER SYSTEM SET DG_BROKER_CONFIG_FILE1='/u01/app/oracle/product/19.0.0/orakpv/dbs/drs1KPV_STBY.dat' SCOPE=BOTH sid='*';
ALTER SYSTEM SET DG_BROKER_CONFIG_FILE2='/u01/app/oracle/product/19.0.0/orakpv/dbs/drs2KPV_STBY.dat' SCOPE=BOTH sid='*';
alter system set dg_broker_start=true scope=both;


### Setup do Broker (realizado no servidor primário) ###
dgmgrl
connect sys

DGMGRL>
CREATE CONFIGURATION KPVSTBY AS PRIMARY DATABASE IS KPVPRD CONNECT IDENTIFIER IS KPVPRD;

ADD DATABASE KPVSTBY AS CONNECT IDENTIFIER IS 'KPVSTBY';

DGMGRL> enable configuration;
Enabled.
DGMGRL> show configuration

remove configuration



---------------------------------------
--                                  --
--                                  --
--                                  --
--                                  --
--                                  --
--                                  --
---------------------------------------





###Configuração do Broker###


### Alteração do init.ora no servidor PRIMARIO

#ORCL
ALTER SYSTEM SET DG_BROKER_CONFIG_FILE1='/u01/app/oracle/broker/ORCL_config01.ora' SCOPE=BOTH;
ALTER SYSTEM SET DG_BROKER_CONFIG_FILE2='/u01/app/oracle/broker/ORCL_config02.ora' SCOPE=BOTH;
alter system set dg_broker_start=true scope=both;


### AAlteração do init.ora no servidores STANDBYS

#stdby
ALTER SYSTEM SET DG_BROKER_CONFIG_FILE1='/u01/app/oracle/broker/stdby_config01.ora' SCOPE=BOTH;
ALTER SYSTEM SET DG_BROKER_CONFIG_FILE2='/u01/app/oracle/broker/stdby_config02.ora' SCOPE=BOTH;
alter system set dg_broker_start=true scope=both;

### Setup do Broker (realizado no servidor primário) ###

DGMGRL>
CREATE CONFIGURATION ORAKPV_DR AS PRIMARY DATABASE IS ORAKPV CONNECT IDENTIFIER IS ORAKPV;

ADD DATABASE KPVPRD_STBY AS CONNECT IDENTIFIER IS 'KPVPRD_STBY';

DGMGRL> enable configuration;
Enabled.
DGMGRL> show configuration


DGMGRL> CREATE CONFIGURATION ORCL_DR AS PRIMARY DATABASE IS ORCL CONNECT IDENTIFIER IS orcl;
Configuration "orcl_dr" created with primary database "orcl"

DGMGRL> ADD DATABASE STDBY AS CONNECT IDENTIFIER IS 'stdby';
Database "stdby" added

