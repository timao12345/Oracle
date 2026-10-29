--CHAMADO DE REFERENCIA: RS00449497
--VERIFICAR DB_LINKS CRIADOS
select * from dba_db_links;

--VERIFICAR LOCAL DOS ARQUIVOS TNSNAMES.ORA
find $ORACLE_HOME -name tnsnames.ora
exemplo: /u01/app/oracle/product/11.2.0.4/dbhome_1/network/admin/tnsnames.ora

--Editar o arquivo tnsnames.ora e adicionar a entrada para o dblink:

ORADSVME =
  (DESCRIPTION =
    (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = TCP)(HOST = 10.100.3.37)(PORT = 1521))
    )
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = oradsvmeoda01)
    )
  )


--VERIFICAR O SERVI�O DO TNS
ps -ef | grep tns


--VERIFICAR STATUS DO TNS
lsnrctl status LISTENER


--VERIFICAR SE O DBLINK EXISTE NO TNS
lsnrctl status LISTENER | grep -i oradsvmeoda01


--PEGAR EVIDENCIA DO DBLINK
select * from dual@DB_ORADSVME;


