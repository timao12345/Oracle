-- Verifica versão do apex instalado no BD
select version_no from apex_release;

-- link para o guide da versão 18.1 oficial
https://docs.oracle.com/database/apex-18.1/HTMIG/installing-AE-and-configuring-Oracle-REST-data-services.htm#HTMIG29143
https://www.oracle.com/tools/downloads/apex-v181-downloads.html


-- procedimento util de instalação
https://oracle-base.com/articles/misc/oracle-application-express-apex-installation



-- Verifica versão do ORACLE REST
java -jar /u01/app/oracle/product/ords/ords.war version
[root@lnxdev011 ords]# /u01/app/oracle/product/12.2.0.1/oraapex/jdk/bin/java -jar ords.war version
Oracle REST Data Services 3.0.7.228.03.57

/u01/app/oracle/product/12.2.0.1/oraapex/jdk/bin/java -jar ords.war validate

SELECT
    user_id,
    user_name,
    email_address,
    created_on,
    account_locked
FROM apex_users;


--
APEX_180100
APEX_INSTANCE_A

select workspace from APEX_180100.apex_workspaces;

SELECT owner, object_name FROM dba_objects WHERE object_name = 'APEX_UTIL';

SELECT WORKSPACE_ID,user_name,WORKSPACE_NAME, account_locked, ACCOUNT_EXPIRY,EMAIL
FROM APEX_WORKSPACE_APEX_USERS;


BEGIN
   APEX_180100.APEX_UTIL.SET_SECURITY_GROUP_ID(APEX_180100.APEX_UTIL.FIND_SECURITY_GROUP_ID('INTERNAL'));
   APEX_180100.APEX_UTIL.EDIT_USER(
      P_USER_ID => 16673079074545313,
      P_USER_NAME => 'LUCAS',
      P_ACCOUNT_LOCKED => 'N',
      P_EXPIRATION_DATE => NULL,
      P_NEW_PASSWORD => 'CVP#1235p0910#1'
   );
   COMMIT;
END;
/

-- Altera senha do usuario APEX
BEGIN
  APEX_180100.APEX_UTIL.SET_SECURITY_GROUP_ID(APEX_180100.APEX_UTIL.FIND_SECURITY_GROUP_ID('INTERNAL'));
  APEX_180100.APEX_UTIL.EDIT_USER(
    P_USER_ID => 16673079074545313,
    P_USER_NAME => 'LUCAS',
    P_NEW_PASSWORD => 'CSP#1235u0911#3',
    P_WEB_PASSWORD => 'CSP#1235u0911#3'
  );
  COMMIT;
END;
/


BEGIN
   APEX_180100.APEX_UTIL.SET_SECURITY_GROUP_ID(10);
   APEX_180100.APEX_UTIL.CHANGE_ADMIN_PASSWORD('CVP1234p0909');
   COMMIT;
END;
/

BEGIN
   APEX_180100.APEX_UTIL.SET_SECURITY_GROUP_ID(10);
END;
/

-- Desbloqueia usuario
BEGIN
   APEX_180100.APEX_UTIL.SET_SECURITY_GROUP_ID(APEX_180100.APEX_UTIL.FIND_SECURITY_GROUP_ID('INTERNAL'));
   APEX_180100.APEX_UTIL.UNLOCK_ACCOUNT(p_user_name => 'LUCAS');
END;
/

BEGIN
   APEX_180100.APEX_UTIL.SET_SECURITY_GROUP_ID(APEX_180100.APEX_UTIL.FIND_SECURITY_GROUP_ID('INTERNAL'));
   APEX_UTIL.EDIT_USER(
      p_user_name => 'LUCAS',
      p_web_password => 'CSP#1235u0911#3',
      p_change_password_on_first_use => 'N'
   );
END;
/

-- cria usuario pelo banco de dados do APEX
declare
  l_workspace_id   number;
begin
  l_workspace_id := APEX_180100.apex_util.find_security_group_id (p_workspace => 'INTERNAL');
  APEX_180100.apex_util.set_security_group_id (p_security_group_id => l_workspace_id);    
  APEX_180100.apex_util.create_user(
    p_user_name       => 'LUCAS',
    p_first_name      => 'Lucas de Souza',
    p_last_name       => 'Melo',
    p_email_address   => 'lucas.souza@caixavidaeprevidencia.com.br',
    p_developer_privs => 'ADMIN',
    p_web_password    => 'CvP#1235u0911#4');
  commit;
end;
/

-- remove usuario
declare
  l_workspace_id   number;
begin
  l_workspace_id := apex_util.find_security_group_id (p_workspace => 'INTERNAL');
  apex_util.set_security_group_id (p_security_group_id => l_workspace_id);    
  apex_util.remove_user(p_user_name => 'LUCAS');
  commit;
end;
/

PROCEDURE CREATE_USER
 Argument Name                  Type                    In/Out Default?
 ------------------------------ ----------------------- ------ --------
 p_user_id                      NUMBER                  IN     DEFAULT
 p_user_name                    VARCHAR2                IN
 p_first_name                   VARCHAR2                IN     DEFAULT
 p_last_name                    VARCHAR2                IN     DEFAULT
 p_description                  VARCHAR2                IN     DEFAULT
 p_email_address                VARCHAR2                IN     DEFAULT
 p_web_password                 VARCHAR2                IN
 p_web_password_format          VARCHAR2                IN     DEFAULT
 p_group_ids                    VARCHAR2                IN     DEFAULT
 p_developer_privs              VARCHAR2                IN     DEFAULT
 p_default_schema               VARCHAR2                IN     DEFAULT
 p_default_date_format          VARCHAR2                IN     DEFAULT
 p_allow_access_to_schemas      VARCHAR2                IN     DEFAULT
 p_account_expiry               DATE                    IN     DEFAULT
 p_account_locked               VARCHAR2                IN     DEFAULT
 p_failed_access_attempts       NUMBER                  IN     DEFAULT
 p_change_password_on_first_use VARCHAR2                IN     DEFAULT
 p_first_password_use_occurred  VARCHAR2                IN     DEFAULT
 p_attribute_01                 VARCHAR2                IN     DEFAULT
 p_attribute_02                 VARCHAR2                IN     DEFAULT
 p_attribute_03                 VARCHAR2                IN     DEFAULT
 p_attribute_04                 VARCHAR2                IN     DEFAULT
 p_attribute_05                 VARCHAR2                IN     DEFAULT
 p_attribute_06                 VARCHAR2                IN     DEFAULT
 p_attribute_07                 VARCHAR2                IN     DEFAULT
 p_attribute_08                 VARCHAR2                IN     DEFAULT
 p_attribute_09                 VARCHAR2                IN     DEFAULT
 p_attribute_10                 VARCHAR2                IN     DEFAULT
 p_allow_app_building_yn        VARCHAR2                IN     DEFAULT
 p_allow_sql_workshop_yn        VARCHAR2                IN     DEFAULT
 p_allow_websheet_dev_yn        VARCHAR2                IN     DEFAULT
 p_allow_team_development_yn    VARCHAR2                IN     DEFAULT


BEGIN
   APEX_180100.APEX_UTIL.CREATE_USER(
      P_USER_NAME => 'LUCAS',
      P_WEB_PASSWORD => 'CVP1234p0909',
      P_EMAIL_ADDRESS => 'lucas.souza@caixavidaeprevidencia.com.br',
      P_DEVELOPER_PRIVS => 'ADMIN',
      P_ACCOUNT_LOCKED => 'N'
   );
   COMMIT;
END;
/

BEGIN
   APEX_180100.APEX_UTIL.SET_SECURITY_GROUP_ID(APEX_180100.APEX_UTIL.FIND_SECURITY_GROUP_ID('INTERNAL'));
   APEX_180100.APEX_UTIL.EDIT_USER(
      P_USER_NAME => 'LUCAS',
      P_ACCOUNT_LOCKED => 'N',
      P_EXPIRATION_DATE => NULL,
      P_NEW_PASSWORD => 'CVP1234p0978',
      P_EMAIL_ADDRESS => 'lucas.souza@caixavidaeprevidencia.com.br'
      --,P_DEVELOPER_PRIVS => 'ADMIN'
   );
   COMMIT;
END;
/

-- Atualiza APEX caso tenha feito migração 
BEGIN
  -- Cria uma nova ACL chamada 'apex_mail_acl.xml' com descrição e concede o privilégio 'connect'
  DBMS_NETWORK_ACL_ADMIN.create_acl (
    acl          => 'apex_mail_acl.xml',
    description  => 'Permitir que o APEX envie e-mails',
    principal    => 'APEX_180100', -- Substitua pelo esquema correto do seu APEX
    is_grant     => TRUE,
    privilege    => 'connect'
  );

  -- Adiciona o privilégio 'resolve' à ACL para o mesmo principal
  DBMS_NETWORK_ACL_ADMIN.add_privilege (
    acl        => 'apex_mail_acl.xml',
    principal  => 'APEX_180100', -- Substitua pelo esquema correto do seu APEX
    is_grant   => TRUE,
    privilege  => 'resolve'
  );

  -- Associa a ACL ao host do servidor SMTP
  DBMS_NETWORK_ACL_ADMIN.assign_acl (
    acl  => 'apex_mail_acl.xml',
    host => 'smtp.adcorp.intranet', -- Substitua pelo endereço do seu servidor SMTP
    lower_port  => 25,
    upper_port  => 25
  );

  COMMIT;
END;
/


BEGIN
  DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL(
    acl         => 'acl_file.xml',
    host        => 'apexdev.caixavidaeprevidencia.intranet',
    lower_port  => 80,
    upper_port  => 80
  );
END;
/



create tablespace APEX_1521460228718673 datafile '+DATAC3' size 2G;
create tablespace APEX datafile '+DATAC3' size 2G; 
         
nohup impdp \'/as sysdba \' DIRECTORY=DUMP_APEX DUMPFILE=APEX_BKP_FULL.dmp LOGFILE=LOG_APEX_IMP.log &
   
-- ldap ta chegando no adcorp
DECLARE
  l_session SYS.DBMS_LDAP.session;
  l_ret     PLS_INTEGER;
BEGIN
  l_session := SYS.DBMS_LDAP.init(
                 hostname => 'adcorp.intranet',
                 portnum  => 389
               );
  DBMS_OUTPUT.put_line('LDAP INIT OK');
  l_ret := SYS.DBMS_LDAP.unbind_s(l_session);
END;
/


-- criar o connect na ACL do APEX para o host do LDAP com a porta 389
BEGIN
  DBMS_NETWORK_ACL_ADMIN.append_host_ace(
    host       => 'adcorp.intranet',
    lower_port => 389,
    upper_port => 389,
    ace        => xs$ace_type(privilege_list => xs$name_list('connect'),
                              principal_name => 'APEX_240100',
                              principal_type => xs_acl.ptype_db)
  );
END;
/

-- apos criar o connect, criar o resolve sem as portas lower e upper
BEGIN
  DBMS_NETWORK_ACL_ADMIN.append_host_ace(
    host       => 'adcorp.intranet',
    ace        => xs$ace_type(privilege_list => xs$name_list('resolve'),
                              principal_name => 'APEX_240100',
                              principal_type => xs_acl.ptype_db)
  );
END;
/


BEGIN
  DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL (
    acl         => 'NETWORK_ACL_495FFF536A123A3BE0633308620A8C48',
    host        => 'adcorp.intranet', -- Target host
    lower_port  => 389,           -- New lower port
    upper_port  => 389            -- New upper port (or NULL for single port)
  );
  COMMIT;
END;
/

-- Validar se está certo com o usuario correto que foi criado também

SELECT ACL_OWNER,
       acl,
       host,
       lower_port,
       upper_port
FROM   dba_network_acls;

SELECT acl,
       principal,
       privilege,
       is_grant
FROM   dba_network_acl_privileges
ORDER  BY acl, principal;





SELECT HOST, LOWER_PORT, UPPER_PORT,
       ACE_ORDER, PRINCIPAL, PRINCIPAL_TYPE,
       GRANT_TYPE, INVERTED_PRINCIPAL, PRIVILEGE,
       START_DATE, END_DATE
  FROM (SELECT ACES.*,DBMS_NETWORK_ACL_UTILITY.CONTAINS_HOST('adcorp.intranet',HOST) PRECEDENCE
          FROM DBA_HOST_ACES ACES)
 WHERE PRECEDENCE IS NOT NULL
 ORDER BY PRECEDENCE DESC,
          LOWER_PORT NULLS LAST,
          UPPER_PORT NULLS LAST,
          ACE_ORDER;

GRANT EXECUTE ON SYS.DBMS_LDAP TO APEX_240100;
GRANT EXECUTE ON apex_ldap_auth.ldap_auth TO APEX_240100;

exec dbms_xdb_config.sethttpport(0); 
exec dbms_xdb_config.sethttpport(8080);



db.hostname=exacc01-kpv-dev-db01
db.port=1521
db.servicename=apexdev
db.sid=apexdev11
db.username=APEX_PUBLIC_USER
migrate.apex.rest=false
rest.services.apex.add=
rest.services.ords.add=true
schema.tablespace.default=SYSAUX
schema.tablespace.temp=TEMP
standalone.http.port=8080
standalone.static.images=
user.tablespace.default=USERS
user.tablespace.temp=TEMP
[oracle@exacc01-kpv-dev-db01 params]$ pwd
/u02/app/oracle/product/19.0.0.0/dbhome_2/ords/params

----------------------------------------------------------
--                                                       |
--                                                       |
---- instalação e upgrade APEX / Configuração do ORDS    | 
--                                                       |
-- obs: não atualize em cima do diretório antigo         |
-- 0 Exemplo o apex normalmente fica no $ORACLE_HOME/apex|
-- Crie um directorio novo
-------------------------------------------------------- |

-- Subir os arquivos do ORDS e APEX para o servidor desejado, no nosso caso é ords-full.zip (contem o java dentro ja) e apex_24.1, também foi copiado um java na versão java 17.0.8 para dentro da pasta descompacatada do ORDS
-- Estrutura:
-- /u02/app/oracle/product/apex
-- /u02/app/oracle/product/ords
-- /u02/app/oracle/product/ords/jre17

-- valida aonde está por padrão as imagens do APEX, para evitar problemas de acesso as imagens
select any_path
from xdb.resource_view
where regexp_like(any_path,'(/images)$|(/images)$|(/images_20[0-9]{10})$|(/i_20[0-9]{10})$','c')
and instr(any_path,'/',2) = 0;

ANY_PATH
--------------------------------------------------------------------------------
/images


select count(*)
from xdb.resource_view
where any_path like '/i/%'; 

-- apex hom
https://apexhm.caixavidaeprevidencia.intranet/

-- Instalação ou upgrade, vá até a pasta descompactada do apex novo no nosso exemplo deixamos no /u02/app/oracle/product/apex,
 -- Faça bkp da pasta do apex original se for fazer upgrade que fica no $ORACLE_HOME/apex, mesmo que seja um local novo faça um bkp dessa pasta.

cd /u02/app/oracle/product/apex
sqlplus / as sysdba

-- Usando o SEU prefixo /images/ pois as imagens estão neste caminho, pode estar no /i/ também, validar com o script acima.
@apexins.sql SYSAUX SYSAUX TEMP /images/

-- depois definir a senha do ADMIN da Workspace INTERNAL
@apxchpwd.sql


-- Apos isso configurar Serviços REST, execute apex_rest_config.sql, ele solicitará uma senha para o usuário APEX_LISTENER, depois, solicitará uma senha para o usuário APEX_REST_PUBLIC_USER.
-- foi inserido a mesma do admin da  workspace para facilitar, mas pode ser diferente se quiser.

@apex_rest_config.sql

-- Apos isso validar os usuarios:
SELECT username, account_status 
FROM dba_users 
WHERE username IN ('APEX_240100', 'APEX_PUBLIC_USER', 'APEX_LISTENER', 'APEX_REST_PUBLIC_USER')
OR username LIKE 'FLOWS_FILES%';

USERNAME                                 ACCOUNT_STATUS
---------------------------------------- --------------------------------
APEX_240100                              LOCKED
APEX_LISTENER                            OPEN
APEX_PUBLIC_USER                         OPEN
APEX_REST_PUBLIC_USER                    OPEN
FLOWS_FILES                              EXPIRED & LOCKED



-- Instalação do ORDS, dentro da pasta u02/app/oracle/product/ords/bin execute o comando abaixo para instalar e configurar,
-- vai pedir uma entrada de tns que deve ser configurada para RAC ou sigle node podendo depois ser alterado a entrada no TNS caso desejar.

./ords --config /u02/app/oracle/product/ords/config install

-- Lista as configurações do ORDS, incluindo as configurações padrão
-- o ORDS está /u02/ords e o java foi copiado do home do grid para evitar problemas de compatibilidade /u02/jre17_copy/bin/java
/u02/jre17_copy/bin/java -jar ords.war config list --include-defaults

/u02/app/oracle/product/ords/jre17/bin/java -jar ords.war config list --include-defaults


java -jar /u01/app/oracle/product/ords/ords.war version

-- subir o serviço do ORDS
nohup /u02/jre17_copy/bin/java -jar ords.war serve &

-- lista as configurações
/u02/jre17_copy/bin/java -jar ords.war config list
/u02/jre17_copy/bin/java -jar ords.war config list --include-defaults

/u02/app/oracle/product/ords/jre17/bin/java -jar ords.war ords config list --include-defaults

-- desativa por segurança a validação
/u02/jre17_copy/bin/java -jar ords.war config set security.requestValidationFunction ""

-- fora aceitar origem
/u02/jre17_copy/bin/java -jar ords.war config set security.cors.enabled true
/u02/jre17_copy/bin/java -jar ords.war config set security.cors.allowOrigin "*"


--se usa Proxy Reverso (como Nginx, Apache ou F5):
/u02/jre17_copy/bin/java -jar ords.war config set jdbc.InboundProxyConfig true

--
/u02/jre17_copy/bin/java -jar ords.war config set --root /u02/ords jdbc.InboundProxyConfig true


-- muda modo da URL de logar pode voltar ao padrão que é nas versões atuais que é /ords
/u02/jre17_copy/bin/java -jar ords.war config set standalone.context.path /apex

-- forçar o uso de HTTPS ou não - n é obrigatorio
/u02/jre17_copy/bin/java -jar ords.war config set security.forceHTTPS FALSE

-- funcionou em dev
-- também precisa configurar no firewall o forwarded https, para o header X-Forwarded-Proto
-- erro como 403 Forbidde deve ter o externalSessionTrustedOrigins para aceitar fontes confiaveis e o httpsHeaderCheck 
--    para aceitar o header do proxy reverso para que aceite cabeçalhos em https

/u02/jre17_copy/bin/java -jar ords.war config set --global security.httpsHeaderCheck X-Forwarded-Proto:https
/u02/jre17_copy/bin/java -jar ords.war config set security.forwarded.enabled true
/u02/jre17_copy/bin/java -jar ords.war config set --global security.externalSessionTrustedOrigins https://apexdev.caixavidaeprevidencia.intranet/


-- aumentar o limit de sessões do ORDS
/u02/jre17_copy/bin/java -jar ords.war config set jdbc.MaxLimit 100



 --- HOM
 
-- Caso gere problema nas imagens setar manualmente o local da maneira abaixo
-- Informe ao ORDS onde estão as imagens fisicamente
./ords --config /u02/app/oracle/product/ords/config config set standalone.static.path /u02/app/oracle/product/apex/images

-- Informe ao ORDS qual o apelido (context path) que você quer usar
./ords --config /u02/app/oracle/product/ords/config config set standalone.static.context.path /images

-- verificar configurações do ORDS pro ambiente de HOM
cd /u02/app/oracle/product/ords/bin
./ords --config /u02/app/oracle/product/ords/config config list

./ords --config /u02/app/oracle/product/ords/config config set --global security.httpsHeaderCheck X-Forwarded-Proto:https
./ords --config /u02/app/oracle/product/ords/config config set security.forwarded.enabled true
./ords --config /u02/app/oracle/product/ords/config config set --global security.externalSessionTrustedOrigins https://apexhm.caixavidaeprevidencia.intranet/



-- Para alterar corretamente o jdbc.MaxLimit, precisa setar o caminho correto da config
./ords --config /u02/app/oracle/product/ords/config config set jdbc.MaxLimit 100


-- INICIAR O ORDS em hom
nohup ./ords --config /u02/app/oracle/product/ords/config serve &

-- Para alterar corretamente o jdbc.MaxLimit, precisa setar o caminho correto da config
./ords --config /u02/app/oracle/product/ords/config config set jdbc.MaxLimit 100

-- valida aonde está por padrão as imagens do APEX, para evitar problemas de acesso as imagens
select any_path
from xdb.resource_view
where regexp_like(any_path,'(/images)$|(/images)$|(/images_20[0-9]{10})$|(/i_20[0-9]{10})$','c')
and instr(any_path,'/',2) = 0;

ANY_PATH
--------------------------------------------------------------------------------
/images


select count(*)
from xdb.resource_view
where any_path like '/i/%'; 

  COUNT(*)
----------
     14158

SQL>


begin
  DBMS_XDB.DELETERESOURCE('/images', 1);
end;
/
commit;

exec DBMS_XDB.DELETERESOURCE('/images', 1);


DECLARE
  v_exists NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO v_exists
  FROM xdb.resource_view
  WHERE any_path = '/i';

  IF v_exists = 0 THEN
     INSERT INTO xdb.resource_view
     (res, any_path)
     SELECT res, REPLACE(any_path,'/images','/i')
     FROM xdb.resource_view
     WHERE any_path LIKE '/images/%';
  END IF;

  COMMIT;
END;
/

declare
  v_res boolean;
begin
  v_res := dbms_xdb.createFolder('/images');
end;
/

BEGIN
  DBMS_XDB.DELETERESOURCE('/images', DBMS_XDB.DELETE_RESOURCE);
END;
/

BEGIN
  DBMS_XDB.DELETERESOURCE('/i', DBMS_XDB.DELETE_RECURSIVE);
END;
/




DECLARE
  folder_path VARCHAR2(100) := '/images';
  bool BOOLEAN;
BEGIN
  bool := DBMS_XDB.createFolder(folder_path);
  COMMIT;
END;
/

--  comando para desativar a porta 8080 que o banco usa para ser usada pelo ORDS.
-- No SQL*Plus como SYS
sqlplus / as sysdba
-- Verifica a porta atual (deve retornar 8080)
SELECT DBMS_XDB_CONFIG.GETHTTPPORT() FROM DUAL;

-- Zera a porta no banco para liberá-la para o Sistema Operacional (ORDS)
EXEC DBMS_XDB_CONFIG.SETHTTPPORT(0);
EXEC DBMS_XDB_CONFIG.SETHTTPSPORT(0);
COMMIT;



-- criar um serviço no linux para o ORDS.
-- nesse caso abaixo foi seguido a configuração do ambiente de hom.
[Unit]
Description=Oracle REST Data Services (ORDS)
After=network.target

[Service]
Type=simple
User=oracle
Group=oinstall
# Defina o diretório de trabalho para onde o executável está
WorkingDirectory=/u02/app/oracle/product/ords/bin
# Apontando para a pasta bin do JDK que está dentro do seu ORDS
Environment="PATH=/u02/app/oracle/product/ords/jre17/bin:/usr/local/bin:/usr/bin:/bin"
# Variavel Opcional,:
Environment="JAVA_HOME=/u02/app/oracle/product/ords/jre17"
# Comando para iniciar o ORDS apontando para a sua pasta de config
ExecStart=/u02/app/oracle/product/ords/bin/ords --config /u02/app/oracle/product/ords/config serve
Restart=always
RestartSec=10
# Limite de arquivos abertos (importante para o pool de conexões)
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target



-- configurar as variaveis do apex para quando setar o banco apex todas variavies apontem corretamente tanto para o java quando directorios especificos do apex
#!/bin/bash
# Caminho do ORDS e do Java Interno
export ORDS_HOME=/u02/app/oracle/product/ords
export JAVA_HOME=$ORDS_HOME/jre17
export PATH=$JAVA_HOME/bin:$PATH
export ORDS_CONFIG=$ORDS_HOME/config

# Variáveis do Banco de Dados
export ORACLE_HOME=/u02/app/oracle/product/19.0.0.0/dbhome_2
export ORACLE_SID=<Seu_SID_Aqui>

echo "ORDS inicializado em background. Verifique o arquivo ords_server.log"



/*
PROCEDIMENTO OPERACIONAL PADRÃO (POP): INSTALAÇÃO E CONFIGURAÇÃO ORDS 24.1 & APEX 24.1
Ambiente: Oracle RAC / Exadata
Responsável: Lucas de Souza Melo
Data: 14/05/2026 */
--------------------------------------------------------------------------------
/*

1. PREPARAÇÃO DE BINÁRIOS E AMBIENTE
------------------------------------
* Objetivo: Organizar os softwares e isolar o JDK para evitar conflitos com o SO.

   a) Criar estrutura de diretórios:
      mkdir -p /u02/app/oracle/product/apex
      mkdir -p /u02/app/oracle/product/ords/bin
      mkdir -p /u02/app/oracle/product/ords/config
      mkdir -p /u02/app/oracle/product/ords/jre17

   b) Descompactar arquivos:
      unzip apex_24.1.zip -d /u02/app/oracle/product/
      unzip ords-24.1.x.zip -d /u02/app/oracle/product/ords/bin
      tar -xzvf jdk-17_linux-x64_bin.tar.gz -C /u02/app/oracle/product/ords/jre17 --strip-components=1

   c) Ajustar permissões:
      chown -R oracle:oinstall /u02/app/oracle/product/apex /u02/app/oracle/product/ords
      chmod -R 755 /u02/app/oracle/product/apex /u02/app/oracle/product/ords


2. CONFIGURAÇÃO DO BANCO DE DADOS
---------------------------------
* Objetivo: Instalar o core do APEX e liberar portas de rede no banco.

   a) Instalação do APEX (Via SQL*Plus como SYSDBA):
      cd /u02/app/oracle/product/apex
      sqlplus / as sysdba
      @apexins.sql SYSAUX SYSAUX TEMP /images

   b) Configuração de usuários de serviço e senhas:
      @apxchpwd.sql           # Define senha do ADMIN do Workspace INTERNAL
      @apex_rest_config.sql    # Define usuários APEX_LISTENER e APEX_REST_PUBLIC_USER

   c) Liberação da porta 8080 no banco (Remoção do conflito XDB):
      EXEC DBMS_XDB_CONFIG.SETHTTPPORT(0);
      COMMIT;


3. INSTALAÇÃO E CONFIGURAÇÃO DO ORDS
------------------------------------
* Objetivo: Configurar o servidor de aplicação e mapeamento de recursos estáticos.

   a) Executar Instalação:
      cd /u02/app/oracle/product/ords/bin
      ./ords --config /u02/app/oracle/product/ords/config install
      
      NOTAS: 
      - Usar usuário administrador: SYS (as SYSDBA)
      - Static Resources Path: /u02/app/oracle/product/apex/images
      - Static Context Path: /images

   b) Ajuste de Header para Proxy/HTTPS (Evita Erro 404):
      ./ords --config /u02/app/oracle/product/ords/config config set --global security.httpsHeaderCheck X-Forwarded-Proto:https

   c) Forçar caminhos estáticos (Garantia):
      ./ords --config /u02/app/oracle/product/ords/config config set standalone.static.context.path /images
      ./ords --config /u02/app/oracle/product/ords/config config set standalone.static.path /u02/app/oracle/product/apex/images


4. AUTOMAÇÃO COM SYSTEMD (SERVIÇO LINUX)
----------------------------------------
* Objetivo: Garantir que o ORDS inicie no boot e use o JDK correto.

   a) Criar arquivo de serviço:
      sudo vi /etc/systemd/system/ords.service

   b) Conteúdo do arquivo:
[Unit]
Description=Oracle REST Data Services (ORDS)
After=network.target

[Service]
Type=simple
User=oracle
Group=oinstall
Environment="PATH=/u02/app/oracle/product/ords/jre17/bin:/usr/local/bin:/usr/bin:/bin"
Environment="JAVA_HOME=/u02/app/oracle/product/ords/jre17"
WorkingDirectory=/u02/app/oracle/product/ords/bin
ExecStart=/u02/app/oracle/product/ords/bin/ords --config /u02/app/oracle/product/ords/config serve
Restart=always
RestartSec=10
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target

c) Ativação:
sudo systemctl daemon-reload
sudo systemctl enable ords
sudo systemctl start ords


5. TESTES E VALIDAÇÃO
---------------------
   a) Verificar Status: sudo systemctl status ords
   b) Ver Logs: sudo journalctl -u ords -f
   c) Acesso Web: http://[IP_SERVIDOR]:8080/ords
      - Validar se o card "Oracle APEX" carrega imagens e CSS corretamente.
--------------------------------------------------------------------------------
*/

-- alterar senha dos usuarios criados pelo ORDS (ORDS_PUBLIC_USER)
ALTER USER ORDS_PUBLIC_USER IDENTIFIED BY "ORst#n31gCwr4t!";

-- depois
./ords --config /u02/app/oracle/product/ords/config config secret db.password



https://100.80.3.67:8080/ords
