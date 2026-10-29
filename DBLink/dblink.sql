-- Dblinks
set lines 200 
set pages 80
col DB_LINK for a20
col name for a15
col USERNAME for a15
col host for a80
col owner for a25
select * from dba_db_links;

where DB_LINK like '%MSSQLP%';

select * from dual@SYNADMD_DW_CON;

select global_name from global_name@pemigwms16;

select * from dual@pemigwms16;

-- erro ORA-02085: database link MSSQLP connects to HO.WORLD ao executar: select sysdate from dual@MSSQLP;
ALTER SYSTEM SET GLOBAL_NAMES = FALSE;
---

select sysdate from dual@FISCAL_TRG.WORLD;
select sysdate from dual@FISCAL_APPL.WORLD;
select sysdate from dual@CIAP_APPL.WORLD;
select sysdate from dual@FISCAL_APPL.WORLD;
select sysdate from dual@FISCAL_TRG.WORLD;
select sysdate from dual@FISCAL_APPL.WORLD;

set lines 200 
set pages 80
col DB_LINK for a20
col name for a15
col USERNAME for a15
col host for a80
select * from all_db_links;
where HOST in ('R104','R119','R122','CDCONP01','DBRECPD','CDRIBP01','CDSALPD','DBERPPAP','DBERPAMP','DBRGSPRD','CDGOIP01','CDBUTP01','DBFORPD','DBGRUPD','DBERPMTP')
and owner='PUBLIC';


--Se você já tem uma conexão adicione uma entrada no tsnames.ora:

MINHA_CONEXAO =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = IP_SERVIDOR)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = MINHA_CONEXAO)
    )
  )

--Tendo a entrada no tnsnames.ora basta referenciá-la ao criar seu dblink:

CREATE DATABASE LINK |NOME_DBLINK| CONNECT TO |USUARIO_BANCO_REMOTO| IDENTIFIED BY |SENHA_USUARIO| USING 'MINHA_CONEXAO';

CREATE DATABASE LINK "DORATQS.ROOTBRASIL.INTRANET" CONNECT TO LUCAS IDENTIFIED BY CVP43LLTT2024 USING 'ORAKPVHM';

CREATE PUBLIC DATABASE LINK "MSSQLPCVP"  CONNECT TO "usr_dstage_prev" IDENTIFIED BY s2gr2d4datastage USING 'dg5msql';

--Se você não tem uma string de conexão criada, pode defini-la na criação do dblink:
CREATE DATABASE LINK |NOME_DBLINK|CONNECT TO |USUARIO_BANCO_REMOTO| IDENTIFIED BY |SENHA_USUARIO|
USING 'MINHA_CONEXAO =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = IP_SERVIDOR)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = MINHA_CONEXAO)
    )
  )';

create public database link DBLINK_KIPREVWEB connect to KIPREVWEB identified by "S5bm1r3n00" using 'DBLINK_KIPREVWEB'; -- prod

create public database link DBLINK_KIPREVWEB connect to KIPREVWEB identified by "zuPzngD76$K#" using 'KIPREV_DEV'; -- dev


create public database link MSSQLP2 connect to COLETA identified by coleta using 'dg4msql';


KIPREV_HM =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST =exacc01-kpv-hom-db01.adcorp.intranet)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SID = orakpvhm1)
    )
  )

node1 =
  (DESCRIPTION =
    (ENABLE=BROKEN)
    (ADDRESS = (PROTOCOL = TCP)(HOST = 10.98.5.67)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SID = orakpvhm1)
    )
)

DBLINK_KIPREVWEB =
(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = exacc01-kpv-hom-db01.adcorp.intranet)(PORT= 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SID = orakpvhm1)
      (FAILOVER_MODE =
        (TYPE = select)
        (METHOD = basic)
      )
    )
  )



--Como exemplo, vamos criar um dblink para o banco de dados MINHA_INSTANCIA utilizando o usuário PESSOA_USUARIO e a senha PESSOA_SENHA:
CREATE DATABASE LINK DBLINK_PESSOA CONNECT TO PESSOA_USUARIO IDENTIFIED BY PESSOA_SENHA USING 'MINHA_INSTANCIA ';

--Dessa forma, podemos acessar a tabela TBL_PESSOA do outro banco de dados com o dblink:
SELECT * FROM TBL_PESSOA@DBLINK_PESSOA;

--Também é possível criar um sinônimo público para aquele dblink:
CREATE PUBLIC SYNONYM PESSOA FOR TBL_PESSOA@DBLINK_PESSOA;

--E acessar a tabela TBL_PESSOA assim:
SELECT * FROM PESSOA;

--Para remover o sinônimo:
DROP PUBLIC SYNONYM PESSOA

--E para remover o dblink:
DROP DATABASE LINK DBLINK_PESSOA

-- mostra também hash de senha do dblink
select * from link$



(SID_DESC =
(SID_NAME=dg4msql)
(ORACLE_HOME=/u02/app/oracle/product/19.0.0.0/dbhome_1)
(ENV="LD_LIBRARY_PATH=/u01/app/oracle/product/19.0.0.0/dbhome_1/dg4msql/driver/lib:/u01/app/oracle/product/19.0.0.0/lib")
(PROGRAM=dg4msql)
)
(SID_DESC =
(SID_NAME=dg4msql2)
(ORACLE_HOME=/u02/app/oracle/product/19.0.0.0/dbhome_1)
(ENV="LD_LIBRARY_PATH=/u01/app/oracle/product/19.0.0.0/dbhome_1/dg4msql2/driver/lib:/u01/app/oracle/product/19.0.0.0/lib")
(PROGRAM=dg4msql)
)
(SID_DESC =
(SID_NAME=dg4msql3)
(ORACLE_HOME=/u02/app/oracle/product/19.0.0.0/dbhome_1)
(ENV="LD_LIBRARY_PATH=/u01/app/oracle/product/19.0.0.0/dbhome_1/dg4msql/driver/lib:/u01/app/oracle/product/19.0.0.0/lib")
(PROGRAM=dg4msql)
)


(SID_DESC =
   (SID_NAME=dg4msql)
   (ORACLE_HOME = /u02/app/oracle/product/19.0.0.0/dbhome_1)
   (ENV="LD_LIBRARY_PATH=/u02/app/oracle/product/19.0.0.0/dbhome_1/dg4msql/driver/lib:/u02/app/oracle/product/19.0.0.0/lib")
   (PROGRAM=dg4msql)
  )

(SID_DESC=
         (SID_NAME=dg4msql)
         (ORACLE_HOME=/u02/app/oracle/product/19.0.0.0/dbhome_1)
         (PROGRAM=dg4msql)
      )


# bancos SAP 19c
  (SID_DESC =
   (GLOBAL_DBNAME = BWD)
   (ORACLE_HOME = /oracle/BWD/19.0.0)
   (SID_NAME = BWD)
  )
  (SID_DESC =
   (GLOBAL_DBNAME = EDC)
   (ORACLE_HOME = /oracle/EDC/19.0.0)
   (SID_NAME = EDC)
  )
  (SID_DESC =
   (GLOBAL_DBNAME = PDO)
   (ORACLE_HOME = /oracle/PDO/19.0.0)
   (SID_NAME = PDO)
  )
  (SID_DESC =
   (GLOBAL_DBNAME = PDS)
(ORACLE_HOME = /oracle/PDS/19.0.0)
   (SID_NAME = PDS)
  )
  (SID_DESC =
   (GLOBAL_DBNAME = SDJ)
   (ORACLE_HOME = /oracle/SDJ/19.0.0)
   (SID_NAME = SDJ)
  )
  (SID_DESC =
   (GLOBAL_DBNAME = LDT)
   (ORACLE_HOME = /oracle/LDT/19.0.0)
   (SID_NAME = LDT)
  )
 
(SID_DESC =
   (SID_NAME=dg4msql)
   (ORACLE_HOME = /u01/app/oracle/product/19.0.0/dbhome_kpv)
   (ENV="LD_LIBRARY_PATH=/u01/app/oracle/product/19.0.0/dbhome_kpv/dg4msql/driver/lib:/u01/app/oracle/product/19.0.0/lib")
   (PROGRAM=dg4msql)
  )
)






SID_LIST_LISTENER =
   (SID_LIST =
      (SID_DESC =
      (SID_NAME = orakpvhm1)
      (ORACLE_HOME = /u02/app/oracle/product/19.0.0.0/dbhome_1)
     )
   (SID_DESC =
      (SID_NAME = orarcu1)
      (ORACLE_HOME = /u02/app/oracle/product/19.0.0.0/dbhome_2)
     )
    (SID_DESC=
      (SID_NAME = dg4msql)
      (ORACLE_HOME = /u02/app/oracle/product/19.0.0.0/dbhome_1)
      (PROGRAM = dg4msql)
     )
    )


SID_LIST_LISTENER =
   (SID_LIST =
      (SID_DESC =
      (SID_NAME = oradev)
      (ORACLE_HOME = /u02/app/oracle/product/19.0.0.0/dbhome_1)
      )

      (SID_DESC =
      (SID_NAME = bdweb)
      (ORACLE_HOME = /u04/app/oracle/product/19.0.0.0/dbhome_3)
      )

      (SID_DESC=
         (SID_NAME=dg4msql)
         (ORACLE_HOME=/u02/app/oracle/product/19.0.0.0/dbhome_1)
         (PROGRAM=dg4msql)
      )

   )



dg4msql =
  (DESCRIPTION=
    (ADDRESS=(PROTOCOL=tcp)(HOST = exacc01-kpv-prd-db01.adcorp.intranet)(PORT=1521))
    (CONNECT_DATA=(SID=dg4msql))
    (HS=OK)
  )

DBLINK_KIPREVWEB = 
(DESCRIPTION =                                                                 
    (ADDRESS = (PROTOCOL = TCP)(HOST = exacc01-7jrgw2.rootbrasil.intranet)(PORT= 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SID = orakpvhm2)
      (FAILOVER_MODE =
        (TYPE = select)
        (METHOD = basic)
      )
    )
  )



DBLINK_KIPREVWEB =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST =exacc01-kpv-hom-db01.adcorp.intranet)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SID = orakpvhm1)
    )
  )


SELECT DBMS_METADATA.GET_DDL('DB_LINK', object_name, owner)
FROM dba_objects
WHERE object_type = 'DATABASE LINK';
AND owner = [your_schema] -- Replace with your schema or specify PUBLIC for public links