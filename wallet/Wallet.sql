-- Recompila 
@?/rdbms/admin/utlrp.sql

-- cria wallet
orapki wallet create -wallet /u02/app/oracle/wallet3 -pwd Oracle123 -auto_login

-- adicionar certificado
orapki wallet add -wallet /u01/app/oracle/wallet3/ewallet.p12 -trusted_cert -cert certificate.crt -pwd Oracle123

orapki wallet add -wallet /u01/app/oracle/wallet3/ewallet.p12 -trusted_cert -cert certificate.crt -pwd Oracle123


-- remover
orapki wallet remove -wallet /u01/app/oracle/wallet3/ewallet.p12 -trusted_cert -cert certificado01.cer -pwd Oracle123

orapki wallet remove -wallet /u01/app/oracle/wallet3/ewallet.p12 -dn "CN=AAA Certificate Services,O=Comodo CA Limited,L=Salford,ST=Greater Manchester,C=GB" -trusted_cert -pwd Oracle123

-- lista certificado
orapki wallet display -wallet /u02/wallet_hm/bkp_ewallet.p12 -pwd Oracle123


--1) Criado pasta para armazenar o wallet 
     mkdir -p /u01/app/oracle/wallet
--2) Copiado via browser o certificado da url https://servicosdev2.caixaseguros.intranet e armazenado na pasta criada
--3) Criar o wallet :
     orapki wallet create -wallet /u01/app/oracle/wallet -pwd master123 -auto_login
--4) Adicionar o certificado :
    orapki wallet add -wallet /u01/app/oracle/wallet -trusted_cert -cert "/u01/app/oracle/wallet/servicosdev2.caixaseguros.intranet.crt" -pwd master123


url hom - https://servicoshm.caixaseguros.intranet
url dev - https://servicosdev2.caixaseguros.intranet

-- criando acl 

begin
  dbms_network_acl_admin.create_acl (
    acl         => 'ACL_DISLUB_PRD.xml',
    description => 'Libera conexao ao cliente',
    principal   => 'MGCUSTOM',
    is_grant    => TRUE,
    privilege   => 'connect',
    start_date  => null,
    end_date    => null
  );
 
  dbms_network_acl_admin.add_privilege (
    acl        => 'ACL_DISLUB_PRD.xml',
    principal  => 'MGCUSTOM',
    is_grant   => TRUE,
    privilege  => 'resolve',
    start_date => null,
    end_date   => null
  );
 
  dbms_network_acl_admin.assign_acl (
    acl        => 'ACL_DISLUB_PRD.xml',
    host       => 'portaldeacesso.dislubequador.com.br',
    lower_port => 587,
    upper_port => 587
  );
  commit;
end;
/
-- drop ACL
begin
  dbms_network_acl_admin.DROP_ACL(acl=>'ACL_DISLUB_PRD.xml');
end;
/

dbms_network_acl_admin.DELETE_PRIVILEGE(ACL=>'teste01.xml',PRINCIPAL=>'SYS');
dbms_network_acl_admin.UNASSIGN_ACL(ACL=>'teste01.xml');


-- teste ACL

SELECT UTL_INADDR.get_host_name() FROM dual;

DECLARE
  l_url  VARCHAR2(32767);
  l_conn utl_http.req;
BEGIN
  l_url  := 'http://smtp.gmail.com';
  l_conn := utl_http.begin_request(url          => l_url
                                  ,method       => 'POST'
                                  ,http_version => 'HTTP/1.0');
  dbms_output.put_line('Anonymous Block Executed successfully');
END;
/

/u01/app/oracle/wallet3 -pwd as09kl00__

select utl_http.request('https://sapbowebservices.ingeteam.com/IngeTeamWmsServices/api/login/Authenticate',NULL,'file:/u01/app/oracle/wallet3','as09kl00__') from dual;

-- enviar para o solicitande
caminho = /u01/app/oracle/wallet
senha = Oracle123

grant execute on utl_http to sys;
grant execute on utl_smtp to sys;
grant execute on  utl_tcp to sys;



 
SELECT UTL_HTTP.Request(Url =>'https://sapbowebservices.ingeteam.com/IngeTeamWmsServices/api/login/Authenticate',
Wallet_Path => 'file:/u01/app/oracle/wallet3',
Wallet_Password => 'as09kl00__')
FROM Dual;



https://portaldeacesso.dislubequador.com.br/api/Liberacao/criarLiberacaoIntegracaoMega

begin
  mgcustom.p_callportalacesso(pfil_cod => 111, prmo_seq => 1, pide_veic => 'ABC-1234');
end;
/

begin
  mgcustom.p_callportalacesso(pfil_cod => 111, prmo_seq => 1, pide_veic => 'Oracle123');
end;
/



declare
  obj_param_smtp c5_tp_param_smtp;
begin
  obj_param_smtp := c5_tp_param_smtp(1);
  sp_envia_email(obj_param => obj_param_smtp,
  psDestinatario => 'lucas.melo@skyone.solutions',
  psAssunto => 'Reunidas - TESTE Envio de e-mail',
  psMensagem => 'TESTE Envio de e-mail',
  psindusahtml => 'S');
end;
/

declare
  obj_param_smtp c5_tp_param_smtp;
begin
  obj_param_smtp := c5_tp_param_smtp(0);
  sp_envia_email(obj_param => obj_param_smtp,
  psDestinatario => 'xml@supcrema.com.br',
  psAssunto => 'SMPCREMATESTE',
  psMensagem => 'TESTE Envio de e-mail',
  psindusahtml => 'S');
end;


BEGIN
   DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACE(
         host => 'daterraatacadoevarejo.com.br',
         ace =>  xs$ace_type(privilege_list => xs$name_list('http'),
                             principal_name => 'ADMIN',
                             principal_type => xs_acl.ptype_db));
END;
/

BEGIN
   UTL_HTTP.SET_WALLET('/u01/app/oracle/wallet3');
END;
/

BEGIN
   DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACE(
         host => 'www.google.com',
         ace =>  xs$ace_type(privilege_list => xs$name_list('http'),
                             principal_name => 'SYS',
                             principal_type => xs_acl.ptype_db));
END;
/


BEGIN
   UTL_HTTP.SET_WALLET(PATH=>'file:/u01/app/oracle/wallet3',PASSWORD=>'Oracle123');
END;
/

SELECT UTL_HTTP.REQUEST(URL =>'portaldeacesso.dislubequador.com.br')
FROM Dual;

SELECT UTL_HTTP.REQUEST('www.google.com') from DUAL;



-- Ao migrar um ambiente que tenha TDE habilitado, é necessário copiar o wallet,tde e configurar o sqlnet.ora para apontar para o local correto do wallet.
-- Deve olha no banco prod ou banco que vc vai copiar sqlnet.ora, o local do wallet de TDE e do banco de dados, 
-- no servidor destino não precisa ser igual somente aponte para aonde vc colocou a wallet, tde e arquivos de autologin, vc pode criar a mesma estrutura de pastas ou colocar em outro local.
-- Exemplo de configuração do sqlnet.ora:
HTTPS_SSL_VERSION=1.2
SQLNET.CRYPTO_CHECKSUM_CLIENT=ACCEPTED
SQLNET.CRYPTO_CHECKSUM_SERVER=ACCEPTED
SQLNET.CRYPTO_CHECKSUM_TYPES_CLIENT=(SHA256,SHA384,SHA512,SHA1)
SQLNET.CRYPTO_CHECKSUM_TYPES_SERVER=(SHA256,SHA384,SHA512)
SQLNET.ENCRYPTION_CLIENT=REQUESTED
SQLNET.ENCRYPTION_SERVER=REQUESTED
SQLNET.ENCRYPTION_TYPES_CLIENT=(AES256,AES192,AES128)
SQLNET.ENCRYPTION_TYPES_SERVER=(AES256,AES192,AES128)
SQLNET.EXPIRE_TIME=10
SQLNET.IGNORE_ANO_ENCRYPTION_FOR_TCPS=TRUE
SQLNET.WALLET_OVERRIDE=FALSE
SSL_CIPHER_SUITES=(SSL_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,SSL_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,SSL_ECDHE_RSA_WITH_AES_128_GCM_SHA256,SSL_ECDHE_RSA_WITH_AES_256_GCM_SHA384)
SSL_CLIENT_AUTHENTICATION=FALSE
SSL_VERSION=1.2
WALLET_LOCATION=
    (SOURCE=
      (METHOD=FILE)
      (METHOD_DATA=(DIRECTORY=/u04/app/oracle/admin/orarcu/db_wallet)))
ENCRYPTION_WALLET_LOCATION=
    (SOURCE=
      (METHOD=FILE)
      (METHOD_DATA=(DIRECTORY=/u04/app/oracle/admin/orarcu/wallet_root/tde)))
S