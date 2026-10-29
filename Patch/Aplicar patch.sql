-- local aonde baixa os patchs
Metalink ( https://support.oracle.com/ )

-- Levando em conta que o patch já está no servidor.

-- Instalar o OPatch mais recente, salvando a pastar anterior como OPatch_old
-- descompactar no local desejado neste exemplo foi descompactado desntro do ORACLE_HOME criando uma pasta chamada 32545013.

-- Atenção a objetos invalidos, comum gerar erros na aplicação do path, rodar utlrp antes e depois.

unzip p32545013_190000_Linux-x86-64.zip

-- Entrar dentro da pasta 32545013 e executar o comando abaixo para fazer um pre-req
-- OBS: Só passar pra proxima etapa se o comando abaixo não retornar erro, caso contrario será necessário corrigiro erro.
/u01/app/oracle/product/19.0.0/orakpv/OPatch/opatch prereq CheckConflictAgainstOHWithDetail -ph ./
/u01/app/oracle/product/19.0.0/orarcu/OPatch/opatch prereq CheckConflictAgainstOHWithDetail -ph ./
/u01/app/19.0.0.0/grid/OPatch/opatch prereq CheckConflictAgainstOHWithDetail -ph ./

/u01/app/oracle/product/19.0.0.0/oraapex/OPatch/opatch prereq CheckConflictAgainstOHWithDetail -ph ./

opatch apply -oh /u01/app/oracle/product/19.0.0.0/oraapex/OPatch/opatch -local /u02/dbhome19/36582629/36582781


-- attach home,  caso lsinventory gere erro de permissão em directorio temp faça o export da variavel TEMP para um filesystem diferente com espaço.
./runInstaller -silent -invPtrLoc "/etc/oraInst.loc" -attachHome ORACLE_HOME="/u01/app/oracle/product/19.0.0/orakpv/" ORACLE_HOME_NAME="Ora19cHome"
./runInstaller -invPtrLoc /u01/app/oracle/product/19.0.0/orarcu/oraInst.loc -attachHome ORACLE_HOME=/u01/app/oracle/product/19.0.0/orarcu/ ORACLE_HOME_NAME="Ora19cHome2"

export TEMP=/u02

-- Verificar se tem sessão aberta do sqlplus pois gera erro, entrar no ORACLE_HOME/bin e executar comando "cd $ORACLE_HOME/bin"
-- realizar kill na sessão caso exista a nivel de SO " kill [numero sessão], exemplo: kill 144964"
lsof sqlplus

-- para o banco de dados
shutdown immediate;

-- Aplicação do patch 
-- obs: Confirme se está dentro da pasta correta que foi descompactada que no nosso caso é /u02/app/oracle/product/19.0.0.0/dbhome_3/32545013
/u02/app/oracle/product/19.0.0.0/dbhome_3/OPatch/opatch apply


-- Verifica se o patch foi instalado
opatch lspatches

-- subir o banco
startup

-- Ao finalizar a aplicação do path com sucesso e subir o banco de dados e executar o comando abaixo dentro do $ORACLE_HOME/OPatch
-- Caso for o bd fique em um RAC o comando abaixo só é rodado apos terminar a aplicação do patch nos dois nós.
./datapatch -verbose


-- para fazer roolback do patch, banco precisa estar down
$ORACLE_HOME/OPatch/datapatch -rollback -id <PatchNumber>

$ORACLE_HOME/OPatch/opatch rollback -id 29779038

local path: /u01/app/oracle/product/19.3.0.0/software/33515361

-- validação
select * from registry$history;
select * from DBA_REGISTRY_SQLPATCH;

@?/rdbms/admin/utlrp.sql

 -- Erro no path no 19c, erros no verbose, em alguns casos desabilitando a trigger e executando manual resolve o problema
 SYS.LOGMNRGGC_TRIGGER 
WMSYS.NO_VM_DDL
-- Desabilite as triggers
BEGIN
    EXECUTE IMMEDIATE 'ALTER TRIGGER WMSYS.NO_VM_DDL DISABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER WMSYS.REFRESH_ON_ALTER DISABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER WMSYS.ADD_OBJ_TRIGGER DISABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER SYS.LOGMNRGGC_TRIGGER DISABLE';
EXCEPTION
WHEN OTHERS THEN
    DBMS_OUTPUT.put_line(SQLERRM);
END;
/

BEGIN
  DBMS_UTILITY.compile_schema(schema => 'WMSYS', compile_all => TRUE);
END;
/
-- Após desabilitar as triggers execute o datapatch novamente
/u02/app/oracle/product/19.0.0.0/dbhome_1/OPatch/datapatch -verbose

-- agora ative as triggers
 BEGIN
  EXECUTE IMMEDIATE 'ALTER TRIGGER WMSYS.NO_VM_DDL ENABLE';
  EXECUTE IMMEDIATE 'ALTER TRIGGER WMSYS.REFRESH_ON_ALTER ENABLE';
  EXECUTE IMMEDIATE 'ALTER TRIGGER WMSYS.ADD_OBJ_TRIGGER ENABLE';
  EXECUTE IMMEDIATE 'ALTER TRIGGER SYS.LOGMNRGGC_TRIGGER DISABLE';
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.put_line(SQLERRM);
END;
/

---- Aplicar path no home antes de instalar o software do BD em casos que o SO é RED HAT
-- https://support.oracle.com/epmos/faces/DocumentDisplay?_afrLoop=293581428015413&id=2982833.1&_afrWindowMode=0&_adf.ctrl-state=15ls3qc94n_706

export CV_ASSUME_DISTID=RHEL8 -- usado em SO com versão acima do 9 pois gera erro ao tentar instalar o software

-- instalar somente o RU 
./runInstaller -applyRU /u01/path/36582629/36582781 -applyOneOffs /u01/path/36582629/36587798

./runInstaller -applyRU /u04/app/patches/36582629/36582781 -applyOneOffs /u04/app/patches/36582629/36587798

-- instalar no RU e OneOFFS  
--RU 19.23
./gridSetup.sh -applyRU /u01/app/patches/36233126/36233263 -applyOneOffs /u01/app/patches/36233126/36240578

--RU 19.24
./gridSetup.sh -applyRU /u01/app/patches/36582629
./gridSetup.sh -applyRU /u01/app/patches/36582629/36582781 -applyOneOffs /u01/app/patches/36582629/36587798

---//// -----

-- detach home
/u01/app/19.0.0.0/grid/oui/bin/runInstaller -silent -detachHome ORACLE_HOME="/u01/app/19.0.0.0/grid"

/u01/app/19.0.0.0/grid/oui/bin/runInstaller -silent -waitforcompletion -detachHome ORACLE_HOME="/u01/app/19.0.0.0/grid" -local

-- comandos utilizados para criar os discos no AFD antes da instalação.
./asmcmd afd_label DATA01 /dev/sdc1 --init  
./asmcmd afd_label DATA02 /dev/sdg1 --init  
./asmcmd afd_label DATA03 /dev/sdh1 --init  
./asmcmd afd_label DATA04 /dev/sdi1 --init  
./asmcmd afd_label DATA05 /dev/sdj1 --init  
./asmcmd afd_label DATA06 /dev/sdk1 --init  
./asmcmd afd_label DATA07 /dev/sdl1 --init  
./asmcmd afd_label DATA08 /dev/sdm1 --init  
./asmcmd afd_label DATA09 /dev/sdn1 --init  
./asmcmd afd_label DATA10 /dev/sdo1 --init  
./asmcmd afd_label DATA11 /dev/sdp1 --init  
./asmcmd afd_label DATA12 /dev/sdq1 --init  
./asmcmd afd_label DATA13 /dev/sdr1 --init  
./asmcmd afd_label DATA14 /dev/sds1 --init  
./asmcmd afd_label DATA15 /dev/sdt1 --init  
./asmcmd afd_label DATA16 /dev/sdu1 --init  
./asmcmd afd_label DATA17 /dev/sdv1 --init  
./asmcmd afd_label RECO1  /dev/sdw1 --init


--Passo a passo para corrigir patch do SAP
--Verificar qual patch está com problema

$ORACLE_HOME/OPatch/datapatch -verbose

--Confirma os patches no registry

select patch_id, action, status, action_time
from dba_registry_sqlpatch
where patch_id in (38523609)
order by action_time;


--Limpeza dos patches

delete from sys.registry$sqlpatch where patch_id in (26749785,31891662,33105363,33144001);
delete from sys.registry$sqlpatch where patch_id in (38523609);


commit;


--Remover o patch do javavm se existir

$ORACLE_HOME/OPatch/opatch lspatches | grep 36414915


--Rollback do patch

srvctl stop database -d sdj

$ORACLE_HOME/OPatch/opatch rollback -id 38523609

--Limpeza dos patch
delete from sys.registry$sqlpatch
where patch_id = 38523609;

commit;