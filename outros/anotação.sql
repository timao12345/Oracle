-- OCI info
cd /var/opt/oracle/creg/

/*
Novo Contrato
1) Exadata Kiprev x10M alocado:
- 48 Cores para os nodes de produção
- 12 Cores para os nodes de homologação 
- 4 Cores para os nodes de desenvolvimento
2) Exadata SAP x10M alocado:
- 24 Cores para os nodes de produção
- 8 Cores para os nodes de homologação
- 4 Cores para os nodes de desenvolvimento
3) Exadata DR x10 alocado:
- 16 Cores para replicação

-- Alocado hoje:
1) Exadata Kiprev  (tenancy  tokcvp) x10M alocado:
- 48 Cores para os nodes de produção
- 12 Cores para os nodes de homologação
- 2 Cores para os nodes de desenvolvimento
- 4 Cores para banco do Catalogo

2) Exadata SAP (tenancy toccvp) x10M alocado:
- 24 Cores para os nodes de produção
- 8 Cores para os nodes de homologação
- 4 Cores para os nodes de desenvolvimento
- 4 Cores para VMCluster CSH

3) Exadata DR (tenancy toccvp) x10M alocado:
- 8 Cores para Dataguard Kiprev 
- 8 Cores para Dataguard SAP
*/

-- Exemplo change DOM0 e Segurança
CHG0072863 - DOM0 SAP
CHG0075797 - DOM0 KPV
CHG0071400 - Path Segurança
CHG0075795 - 07/02/2024 - Patch de segurança SAP
CHG0072861 - 07/02/2024 - Patch de segurança Kiprev
CHG0073413 - 07/03/2025 - Patch de segurança Dataguard
CHG0073417 - 08/03/2026 - Patch de SO SAP
CHG0073414 - 08/03/2026 - Patch de SO Kiprev
CHG0072873 - REGRA DE FIREWALL KIPREV DEV
CHG0074783 - DOM0 Dataguard
CHG0074302 - netbackup migração

-- Agenda / Atividade
Tem a Master Key para ativar, TDE já está ativo. - 
Verificar objetos invalidos no Kiprev e SAP, verificar com os times GETIP e SAP. (Dev KPV ja foi feito, agora falta Hom e PRD).
Criar Monitoramento do Listener dos bancos produtivos.
Arrumar monitoramento de backup incremental.

-- change que alterou a package que gera cursor aberto
CHG0075484
esse sql_id 7rrdmgstpkgbz essa é a rotina de baixa informado pelo Ricardo Granja

------ // ------
set echo on
set lines 200
set timi on
set time on

spool C:\Users\cvp14857\Downloads\change\CHG0078205.log

select to_char(sysdate,'cc dd/mm/yyyy hh24:mi:ss') data from dual;
select instance_name, host_name, status from gv$instance;
 
set pages 10000
set lines 200
col object_name for a45
col OBJECT_TYPE for a30
col owner for a45
select object_name, object_type, owner, status,to_char (LAST_DDL_TIME, 'DD-MON-YY HH24:MI:SS') as LAST_DDL_TIME from dba_objects where status <> 'VALID' order by 1;
 
@C:\Users\cvp14857\Downloads\us_67541_bxa_retro.sql

set pages 10000
set lines 200
col object_name for a45
col OBJECT_TYPE for a30
col owner for a45
select object_name, object_type, owner, status,to_char (LAST_DDL_TIME, 'DD-MON-YY HH24:MI:SS') as LAST_DDL_TIME from dba_objects where status <> 'VALID'order by 1;
 
spool off

--------------------- // ---------------------------------
--Verifica quando bloqueou a conta e o motivo
alter session set nls_date_format='yyyy/mm/dd hh24:mi';
SELECT * from AUDITORIA.CONTROL_ACESS where USUARIO='CVT42780'; 

--Verifica como esta o acesso
SELECT * from AUDITORIA.VERIFY_ACESS where USUARIO='CVT42780'; 

--Verifica ultimo logon
select * from auditoria.monitor_user_logon where USUARIO='CVT42780';


--Verificar usuarios
SET LINES 850 PAGES 800
COL USERNAME FOR A35
select * from kiprev.usuarios where COD_USUARIO IN ('CVT42780');
SELECT username,account_status,lock_date,expiry_date,created,profile from dba_users where username in ('CVT42780');

about:blank#blocked-- Verifica Roles
select * from KIPREV.USUARIOS_X_ROLES where COD_USUARIO='CVP16079';

-- Verifica auditoria de login
select v.* from   kiprev.v_au_login_auditoria v where  v.usuario in ( 'CVP16079') order by v.usuario, v.data desc;

--Ativa usuários
update kiprev.usuarios u set u.est_activo = 'S' where u.cod_usuario = 'CVT51076';
update kiprev.usuarios u set u.est_activo = 'S' where u.cod_usuario = 'CVT52130';
update kiprev.usuarios u set u.est_activo = 'S' where u.cod_usuario = 'CVT54324';
update kiprev.usuarios u set u.est_activo = 'S' where u.cod_usuario = 'CVT06559';

select v.*
from   kiprev.v_au_login_auditoria v
where  v.usuario in ( 'CVT46164' , 'CVT31774')
order by v.usuario, v.data desc

--desativar usuários
update kiprev.usuarios u set u.est_activo = 'S' where u.cod_usuario = 'KIPREVATOS';

-- Cadastrar usuários
insert into kiprev.usuarios (COD_USUARIO, COD_PER_FISICA, ES_PRINCIPIANTE, PALABRA_PASO, EST_ACTIVO, COD_GRUPO_AGENDA, 
COD_EMPRESA_DFLT, COD_AGENCIA_DFLT, MANEJA_EFECTIVO, ES_OFICIAL, INCLUIDO_POR, FECHA_INCLUSION, MODIFICADO_POR, FECHA_MODIFICACION, 
NOME_USUARIO, COD_CPFID, COD_MATRICULA, EMAIL, TELEFONE, MG_REMESSA_LINHA, IND_DEVE_ALTERAR_SENHA, DATA_ALTERACAO_SENHA, IND_LOG, 
SEQ_REG_TABELA, DATA_ULTIMO_LOGIN, DATA_LOGIN_ATUAL, FALHA_DE_LOGIN, COD_EMPRESA_LOTACAO, COD_AREA_LOTACAO) 
VALUES ('KIPREVATOS',NULL,NULL,'EF8C59BFB7D3C66A','S',NULL,500,1000,'N',NULL,'@3','09-MAR-26','@3','09-MAR-26','Kiprev Atos',37506691809,14213,
'kiprev.atos@caixavidaeprevidencia.com.br','+55 11957910367',NULL,'S',NULL,'N',NULL,NULL,NULL,NULL,NULL,NULL);

-- 

create user CVP00983 identified by "CVP#Teste#123"
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP"
PROFILE "ACESSOS_KIPREV";

grant RXX to CVP14213;
grant RXX_NEW to CVP14213;

RXX -- ROLE PARA GRANT CASO SEJA NECESSARIO CRIAR O USUARIO.
ACESSOS_KIPREV -- Profile padrão 

grant select on

grant select on kiprev.USUARIOS_X_ROLES to CVP14910;
grant insert on kiprev.USUARIOS_X_ROLES to CVP14910;
grant update on kiprev.USUARIOS_X_ROLES to CVP14910;

grant select on kiprev.USUARIOS_X_ROLES to CVP14527;
grant insert on kiprev.USUARIOS_X_ROLES to CVP14527;
grant update on kiprev.USUARIOS_X_ROLES to CVP14527;


--Incluir perfil
INSERT INTO KIPREV.USUARIOS_X_ROLES(COD_USUARIO,COD_ROL) VALUES ('KIPREVATOS','RADM');
INSERT INTO KIPREV.USUARIOS_X_ROLES(COD_USUARIO,COD_ROL) VALUES ('KIPREVATOS','INTERF');
INSERT INTO KIPREV.USUARIOS_X_ROLES(COD_USUARIO,COD_ROL) VALUES ('KIPREVATOS','ANASIN');
INSERT INTO KIPREV.USUARIOS_X_ROLES(COD_USUARIO,COD_ROL) VALUES ('KIPREVATOS','DIROT');

--Ver perfil
select * from KIPREV.USUARIOS_X_ROLES where COD_USUARIO='CVP14315';

select  est_activo, count (est_activo) from  kiprev.usuarios group by est_activo;
