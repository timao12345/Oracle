###Configuração do Broker###


### Alteração do init.ora no servidor PRIMARIO

#ORCL
ALTER SYSTEM SET DG_BROKER_CONFIG_FILE1='/u01/app/oracle/broker/ORCL_config01.ora' SCOPE=BOTH;
ALTER SYSTEM SET DG_BROKER_CONFIG_FILE2='/u01/app/oracle/broker/ORCL_config02.ora' SCOPE=BOTH;
alter system set dg_broker_start=true scope=both;


### Alteração do init.ora no servidores STANDBYS

#stdby
ALTER SYSTEM SET DG_BROKER_CONFIG_FILE1='/u01/app/oracle/broker/stdby_config01.ora' SCOPE=BOTH;
ALTER SYSTEM SET DG_BROKER_CONFIG_FILE2='/u01/app/oracle/broker/stdby_config02.ora' SCOPE=BOTH;
alter system set dg_broker_start=true scope=both;

### Setup do Broker (realizado no servidor primário) ###

DGMGRL>
CREATE CONFIGURATION ORCL_DR AS PRIMARY DATABASE IS ORCL CONNECT IDENTIFIER IS orcl;

ADD DATABASE STDBY AS CONNECT IDENTIFIER IS 'stdby';

DGMGRL> enable configuration;
Enabled.
DGMGRL> show configuration


DGMGRL> CREATE CONFIGURATION ORCL_DR AS PRIMARY DATABASE IS ORCL CONNECT IDENTIFIER IS orcl;
Configuration "orcl_dr" created with primary database "orcl"

DGMGRL> ADD DATABASE STDBY AS CONNECT IDENTIFIER IS 'stdby';
Database "stdby" added
