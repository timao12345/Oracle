-- Configurar BD como Catalogo.
-- Criar tablespace.
CREATE TABLESPACE TBS_CATALOGO DATAFILE '+DATAC1' SIZE 1000M AUTOEXTEND ON NEXT 100M maxsize 32767m;

--Criar usuario ou usuarios conforme a configuração e estrategia.
create user CVP_KPV_HML identified by OraCvpHml123456# temporary tablespace temp default tablespace TBS_CATALOGO quota unlimited on TBS_CATALOGO;
create user CVP_KPV_PRD identified by OraCvpPrd123456# temporary tablespace temp default tablespace TBS_CATALOGO quota unlimited on TBS_CATALOGO;
create user CVP_SAP_DEV identified by OraCvpOraSAP123456# temporary tablespace temp default tablespace TBS_CATALOGO quota unlimited on TBS_CATALOGO;

create user CVP_APEX_PRD identified by OraCvpOraSAP123456# temporary tablespace temp default tablespace TBS_CATALOGO quota unlimited on TBS_CATALOGO;

create user CVP_SAP_PRD identified by CvpOraSAP#21986# temporary tablespace temp default tablespace TBS_CATALOGO quota unlimited on TBS_CATALOGO;


-- Realizar os grants
GRANT CONNECT, RESOURCE, RECOVERY_CATALOG_OWNER TO CVP_KPV_HML;
GRANT CONNECT, RESOURCE, RECOVERY_CATALOG_OWNER TO CVP_KPV_PRD;
GRANT CONNECT, RESOURCE, RECOVERY_CATALOG_OWNER TO CVP_SAP_DEV;

GRANT CONNECT, RESOURCE, RECOVERY_CATALOG_OWNER TO CVP_APEX_PRD;

GRANT CONNECT, RESOURCE, RECOVERY_CATALOG_OWNER TO CVP_SAP_PRD;

-- Logar no RMAN com parametros de catalogo. (cada usuario que for configurado para cada banco diferente dever ser criado o catalogo dessa maneira.)
    OraCvpHml123456#@dbrman

rman catalog CVP_KPV_HML/OraCvpHml123456#@dbrman
rman catalog CVP_SAP_DEV/OraCvpOraSAP123456#@dbrman

rman target / catalog CVP_APEX_PRD/OraCvpOraSAP123456#@dbrman

rman target / catalog CVP_APEX_PRD@dbrman

-- Realizar a criação do catalogo.
CREATE CATALOG;

-- Apos criar entrar no servidor que deseja registar o banco no catalogo e fazer o register database.
rman target / catalog CVP_KPV_HML/OraCvpHml123456#@dbrman
rman target / catalog CVP_KPV_HML@dbrman


rman target / catalog CVP_SAP_DEV/OraCvpOraSAP123456#@dbrman

rman target sys/password@<target_db> catalog cvp_sap_dev/password@dbrman

rman target / catalog CVP_SAP_PRD/CvpOraSAP#21986#@dbrman
rman target / catalog CVP_SAP_PRD@dbrman

REGISTER DATABASE;

--  No banco de catalogo lista os bancos configurados com " register database " no catalogo
list db_unique_name all;


/* PRODUÇÃO */

-- Configurar BD como Catalogo.
-- Criar tablespace.
CREATE TABLESPACE TBS_CATALOGO DATAFILE '+DATAC1' SIZE 1000M AUTOEXTEND ON NEXT 100M maxsize 32767m;

--Criar usuario ou usuarios conforme a configuração e estrategia.
create user CVP_KPV_HML identified by OraCvpHml123456# temporary tablespace temp default tablespace TBS_CATALOGO quota unlimited on TBS_CATALOGO;
create user CVP_KPV_PRD identified by OraCvpPrd123456# temporary tablespace temp default tablespace TBS_CATALOGO quota unlimited on TBS_CATALOGO;
create user CVP_KPV_ORARCU identified by OraCvpOraRcu123456# temporary tablespace temp default tablespace TBS_CATALOGO quota unlimited on TBS_CATALOGO;


-- Realizar os grants
GRANT CONNECT, RESOURCE, RECOVERY_CATALOG_OWNER TO CVP_KPV_HML;
GRANT CONNECT, RESOURCE, RECOVERY_CATALOG_OWNER TO CVP_KPV_PRD;
GRANT CONNECT, RESOURCE, RECOVERY_CATALOG_OWNER TO CVP_KPV_ORARCU;

-- Logar no RMAN com parametros de catalogo. (cada usuario que for configurado para cada banco diferente dever ser criado o catalogo dessa maneira.)
rman catalog CVP_KPV_ORARCU/OraCvpOraRcu123456#@dbrman
rman catalog CVP_KPV_ORARCU@dbrman
-- Realizar a criação do catalogo.
CREATE CATALOG;

-- Apos criar entrar no servidor que deseja registar o banco no catalogo e fazer o resync database.
rman target / catalog CVP_KPV_ORARCU/OraCvpOraRcu123456#@dbrman

rman target / catalog CVP_KPV_ORARCU/OraCvpOraRcu123456#@dbrman

rman target / catalog CVP_KPV_ORARCU@dbrman

REGISTER DATABASE;
RESYNC CATALOG;

--  No banco de catalogo lista os bancos configurados com " register database " no catalogo
list db_unique_name all;


rman target / catalog CVP_KPV_PRD/OraCvpPrd123456#@dbrman

rman target / catalog CVP_KPV_PRD@dbrman

-- Para remover um banco do catalogo, basta usar o comando abaixo caso ainda tenha acesso ao banco.
-- entre servidor do banco de dados, logue no catalogo e execute o comando abaixo.
rman target / catalog CVP_KPV_PRD/OraCvpPrd123456#@dbrman
rman target / catalog CVP_KPV_PRD@dbrman

unregister database KPVPPRD noprompt;

--- Para tirar um banco do catalogo que não temos mais acesso, basta usar o comando abaixo.

SQL> connect rman/rman@catdb -- use usuario e senha do catalogo desejado apontando pro tns correto
Connected.
SQL> select db_key, dbid, name from rc_database where name = 'ORAKPV';

    DB_KEY       DBID NAME
---------- ---------- --------
     1 3325602173 ORAKPVHM

1 row selected.

-- execute a procedure to unregister the database
SQL> execute dbms_rcvcat.unregisterdatabase(14640460, 3435822571);

PL/SQL procedure successfully completed.

SQL>



DELETE ARCHIVELOG UNTIL time "SYSDATE - interval '168' hour" BACKED UP 1 TIMES to DEVICE TYPE sbt;

-- localizar o controlfile no arquivos restaurados
-- Opção A: consulta no rman de produção
export NLS_DATE_FORMAT='DD-MM-YYYY HH24:MI:SS'
rman target /
list backup of controlfile completed between "TO_DATE('22/08/2026 01:00:00','DD-MM-YYYY HH24:MI:SS')" AND "TO_DATE('22/08/2026 17:00:00','DD-MM-YYYY HH24:MI:SS')";

-- or 
rman target /
SQL "ALTER SESSION SET NLS_DATE_FORMAT=''DD/MM/YYYY HH24:MI:SS''";
list backup of controlfile completed between '19/08/2026 12:00:00' and '19/08/2026 17:00:00';



export NLS_DATE_FORMAT='DD-MM-YYYY HH24:MI:SS'

UNTIL TIME "TO_DATE('11-09-2026 18:00:00','MM-DD-YYYY HH24:MI:SS')"

