--Problemas ao fazer duplicate ou copia de ambiente, pode gera problemas no JAVA de diferença de versão.

/*
-- Ao executar o script abaixo ou alguma package que utilize recursos do java gera o erro:
ORA-29548: classe de sistema Java informada: release of Java system classes in the database (19.0.0.0.240116 1.8) does not match that of the oracle executable (19.0.0.0.0 1.8)
*/
select dbms_java.get_jdk_version() from dual;


--Para validar local do script acesse $ORACLE_HOME/javavm/install

/u03/app/oracle/product/19.0.0.0/dbhome_2/javavm/install


-- Deve ser baixado o banco e subir em modo upgrade
SQL> SHUTDOWN IMMEDIATE;
SQL> STARTUP UPGRADE;
SQL> @?/javavm/install/update_javavm.sql ou update_javavm_db.sql /*depende da versão do banco*/
SQL> SHUTDOWN IMMEDIATE;
SQL> STARTUP;

-- Apos subir o banco fazer o recompile
@?/rdbms/admin/utlrp.sql

-- Validações

select dbms_java.get_jdk_version() from dual;
SELECT dbms_java.longname('TEST') long_name FROM dual;