--10g
http://docs.oracle.com/cd/B19306_01/appdev.102/b14258/d_ftran.htm#i998903

--11r2g
http://docs.oracle.com/cd/E11882_01/appdev.112/e25788/d_ftran.htm#ARPLS66385
DBMS_FILE_TRANSFER.COPY_FILE(
   source_directory_object       IN  VARCHAR2,
   source_file_name              IN  VARCHAR2,
   destination_directory_object  IN  VARCHAR2,
   destination_file_name         IN  VARCHAR2);

DBMS_FILE_TRANSFER.GET_FILE (
source_directory_object      IN  VARCHAR2,
source_file_name             IN  VARCHAR2,
source_database              IN  VARCHAR2,
destination_directory_object IN  VARCHAR2,
destination_file_name        IN  VARCHAR2);

DBMS_FILE_TRANSFER.PUT_FILE(
   source_directory_object       IN  VARCHAR2,   
   source_file_name              IN  VARCHAR2,
   destination_directory_object  IN  VARCHAR2,
   destination_file_name         IN  VARCHAR2,  
   destination_database          IN  VARCHAR2);

   
--PUT FILE   
conn mig_pure/pure@hom011
alter session set global_names=false;
BEGIN
dbms_file_transfer.put_file ('GG',
                             'EXP_HOM01_NROWS_01.dmp',
                             'GG',
                             'EXP_HOM01_NROWS_01.dmp',
							 'PURE_H');
END;
/
--RESULTADO COM UM DUMP DE 16GB
10:13:59 @hom011>
10:15:19 @hom011>
10:15:19 @hom011> BEGIN
10:15:20   2  dbms_file_transfer.put_file ('GG',
10:15:20   3                               'CSF_6159_13.dmp',
10:15:20   4                               'GG',
10:15:20   5                               'CSF_6159_13.dmp',
10:15:20   6                                                     'PURE_HOM01');
10:15:20   7  END;
10:15:20   8  /

PL/SQL procedure successfully completed.

Elapsed: 00:09:16.31

--RESULTADO COM UM DUMP DE 20GB
BEGIN
dbms_file_transfer.put_file ('ASMDMP',
                             'matera_dados_only.dmp',
                             'DATA1',
                             'matera_dados_only.dmp',
							 'PRD02');
END;
/

11:15:16 @hom011> BEGIN
11:15:21   2  dbms_file_transfer.put_file ('GG',
11:15:21   3                               'TESTE_MIGRACAO_WF_ASM_02.dmp',
11:15:21   4                               'GG',
11:15:21   5                               'TESTE_MIGRACAO_WF_ASM_02.dmp',
11:15:21   6                                                     'PURE_HOM01');
11:15:21   7  END;
11:15:21   8  /

PL/SQL procedure successfully completed.

Elapsed: 00:13:55.51



--PASSOS DE CONFIGURAÇÃO

--prd02


--asmcmd
cd data/hom01
mkdir gg


--sqlplus do hom01
create user atu_syspergamum identified by pergamum;
GRANT CREATE SESSION TO atu_syspergamum;
GRANT EXP_FULL_DATABASE TO atu_syspergamum;
GRANT IMP_FULL_DATABASE TO atu_syspergamum;
GRANT EXECUTE ON SYS.DBMS_DEFER_IMPORT_INTERNAL TO atu_syspergamum;
GRANT EXECUTE ON SYS.DBMS_EXPORT_EXTENSION TO  atu_syspergamum ;	

create directory pergamum_to_orahmgme as 'DATA_DM01/exp/atu_orahmgme/';
create directory pergamum_to_oradsvme as 'DATA_DM01/exp/atu_oradsvme/';


--exa_hom01

create user mig_pure identified by pure;
grant dba to mig_pure;
grant sysdba to mig_pure;

create database link prd02 connect to system identified by oracle using 'prd021';

--usando um directory que já existe
origem prd02
destino hom01

directory prd02 DATA1
directory hom01 EXPBI

create database link P8_BI01 connect to hom01$falves identified by oracle using 'ASM_HOM01';

--exec dbms_file_transfer.put_file ('DIRECTORY_ORIGEM','NOME_DO_DUMP','DIRECTORY_DESTINO','NOME_DO_DUMP_NO_DESTINO','NOME_DO_DB_LINK');
create database link p8_bi01 connect to bi$falves identified by temp using 'P8_bi011';

spo dbms_file_transfer_sisbon_ensaio.txt
set echo on
set time on
set timing on
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_01.dmp','EXPBI','ensaio_dump_sisbon_01.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_02.dmp','EXPBI','ensaio_dump_sisbon_02.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_03.dmp','EXPBI','ensaio_dump_sisbon_03.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_04.dmp','EXPBI','ensaio_dump_sisbon_04.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_05.dmp','EXPBI','ensaio_dump_sisbon_05.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_06.dmp','EXPBI','ensaio_dump_sisbon_06.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_07.dmp','EXPBI','ensaio_dump_sisbon_07.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_08.dmp','EXPBI','ensaio_dump_sisbon_08.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_09.dmp','EXPBI','ensaio_dump_sisbon_09.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_10.dmp','EXPBI','ensaio_dump_sisbon_10.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_11.dmp','EXPBI','ensaio_dump_sisbon_11.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_12.dmp','EXPBI','ensaio_dump_sisbon_12.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_13.dmp','EXPBI','ensaio_dump_sisbon_13.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_14.dmp','EXPBI','ensaio_dump_sisbon_14.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_15.dmp','EXPBI','ensaio_dump_sisbon_15.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_16.dmp','EXPBI','ensaio_dump_sisbon_16.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_17.dmp','EXPBI','ensaio_dump_sisbon_17.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_18.dmp','EXPBI','ensaio_dump_sisbon_18.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_19.dmp','EXPBI','ensaio_dump_sisbon_19.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_20.dmp','EXPBI','ensaio_dump_sisbon_20.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_21.dmp','EXPBI','ensaio_dump_sisbon_21.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_22.dmp','EXPBI','ensaio_dump_sisbon_22.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_23.dmp','EXPBI','ensaio_dump_sisbon_23.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_24.dmp','EXPBI','ensaio_dump_sisbon_24.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_25.dmp','EXPBI','ensaio_dump_sisbon_25.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_26.dmp','EXPBI','ensaio_dump_sisbon_26.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_27.dmp','EXPBI','ensaio_dump_sisbon_27.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_28.dmp','EXPBI','ensaio_dump_sisbon_28.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_29.dmp','EXPBI','ensaio_dump_sisbon_29.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_30.dmp','EXPBI','ensaio_dump_sisbon_30.dmp','P8_BI01');
exec dbms_file_transfer.put_file ('GMUD_RECUPERA_RECO','ensaio_dump_sisbon_31.dmp','EXPBI','ensaio_dump_sisbon_31.dmp','P8_BI01');

spo off





