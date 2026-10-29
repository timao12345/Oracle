/*
GRANTEE – Nome do usuário com acesso concedido.
OWNER – Proprietário do objeto
TABLE_NAME –  Nome do objeto (tabela, índice, sequência etc.).
GRANTOR – Nome do usuário que executou a concessão
PRIVILEGE – Privilégio atribuído ao GRANTEE objeto associado.
*/

--Privilegio de sistema
SELECT * FROM DBA_SYS_PRIVS WHERE  GRANTEE = 'CVT12320' ORDER BY 1;

-- PRIVILEGIO EM OBJETOS
SET LINES 750 PAGES 1000 
COL GRANTEE FOR A20
COL OWNER FOR A15
COL TABLE_NAME FOR A25
COL GRANTOR FOR A15
 COL PRIVILEGE FOR A25
SELECT * FROM DBA_TAB_PRIVS WHERE  GRANTEE = 'CVT12320' ORDER BY 3;

-- PRIVILEGIO EM ROLES
COL GRANTEE FOR A20
COL GRANTED_ROLE FOR A20
SELECT * FROM DBA_ROLE_PRIVS WHERE  GRANTEE = 'CVT12320' ORDER BY 1;

COL GRANTEE FOR A20
COL GRANTED_ROLE FOR A20
SELECT * FROM DBA_ROLE_PRIVS WHERE  GRANTED_ROLE = 'CVT12320' ORDER BY 1;
 
SELECT  ro.GRANTEE,ro.GRANTED_ROLE, usr.ACCOUNT_STATUS,usr.LOCK_DATE,usr.EXPIRY_DATE,usr.CREATED,usr.PROFILE FROM DBA_ROLE_PRIVS ro, dba_users usr
WHERE  ro.GRANTEE = usr.USERNAME and ro.GRANTED_ROLE='RXX_CONSULTA';

-- Verifica tabelas com grantee public
SELECT owner,
       table_name,
       privilege,
       grantee
FROM dba_tab_privs
WHERE grantee IN ('PUBLIC') and owner='KIPREV'
ORDER BY owner, table_name, privilege;

-- verifca usuarios com sysdba
SELECT * 
FROM v$pwfile_users
ORDER BY username;

select USERNAME,ACCOUNT_STATUS,LOCK_DATE,EXPIRY_DATE,CREATED,PROFILE,PASSWORD_VERSIONS,CREATED,DEFAULT_TABLESPACE,TEMPORARY_TABLESPACE from dba_users 
where USERNAME like '%ALAN%' ;

KIPREV.PCK_DB_FO_RESG_SOLIC

SET LINES 750 PAGES 1000 
COL GRANTEE FOR A20
COL OWNER FOR A15
COL TABLE_NAME FOR A25
COL GRANTOR FOR A15
COL PRIVILEGE FOR A25
SELECT * FROM DBA_TAB_PRIVS where TABLE_NAME='DBA_USERS';

SELECT * FROM DBA_ROLE_PRIVS
WHERE  GRANTED_ROLE = 'KIPREVATOS'
ORDER BY 1;

SELECT * FROM DBA_SYS_PRIVS
WHERE  privilege = 'DBA'
ORDER BY 1;

-- Gera sql pra relizar grants a partir de um usuario
select * from (
select 'GRANT '||privilege||' TO '||grantee||';' from DBA_SYS_PRIVS
where grantee in ('KIPREVATOS')
union all
select 'grant '||privilege||' on '||grantor||'.'||table_name||' to '||grantee||';' from DBA_TAB_PRIVS
where grantee in ('KIPREVATOS')
union all
select 'GRANT '||GRANTED_ROLE||' TO '||grantee||';' from DBA_ROLE_PRIVS
where grantee in ('KIPREVATOS'));

GRANT DEBUG ANY PROCEDURE TO USR_ZABBIX;
GRANT SELECT ANY TABLE TO USR_ZABBIX;
grant SELECT on SYS.DBA_SCHEDULER_JOB_RUN_DETAILS to USR_ZABBIX;
grant SELECT on SYS.ALL_SCHEDULER_JOB_RUN_DETAILS to USR_ZABBIX;
GRANT RL_READ TO USR_ZABBIX;

grant update on REDEDES.CAD_SOLICITACAO_REAVISO to U11001;

-- Grants
GRANT UNLIMITED TABLESPACE TO EDOCS;
GRANT RESOURCE TO AGROCP;
GRANT ROLE_SQL TO EDOCS;
GRANT ROLE_SQL_ORACLE TO EDOCS;
GRANT ROLE_SENIORPRD TO EDOCS;
GRANT ROLE_SQLORACLE TO EDOCS;
GRANT CONNECT TO LOADTIMOBILE;
GRANT DBA TO EDOCS;
GRANT ROLE_SQLXORACLE TO EDOCS;

-- Grant ROLE, acrecenta uma tabela a uma role
GRANT select, insert, update, delete ON kiprev.BENEFICIOS_X_CUENTA_ASSISTENCIA TO RXX;

-- REVOKE Udate em uma tabela especifica.
REVOKE UPDATE ON CONSINCO.EDI_PEDVENDACLIENTE FROM SITEMERCADO;
REVOKE UPDATE ON CONSINCO.EDI_PEDVENDACLIENTE FROM VIPCOMMERCE;

-- consulta de usuario
select username from dba_users where username='OWGRDCEE';
select username from dba_users where username='VIPCOMMERCE';

-- consulta objetos da ROLE
select * from role_tab_privs where ROLE='RO_APEX_SMPREV';

--Consulta tabelas que estejam dentro da ROLE
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'USR_WORK_KPV';
SELECT * FROM DBA_TAB_PRIVS WHERE GRANTEE = 'USR_WORK_KPV';

-- grant para todos objetos de um usuario para outro


select 'grant EXECUTE on CONSINCO.'||object_name||' to SAERJ;' from dba_objects where owner = 'SCI' and object_type in ('PROCEDURE','FUNCTION','PACKAGE','PACKAGE BODY');



select 'grant select on SCI.' ||object_name || ' to S_CSI;' from dba_objects where owner='REDEDES' and object_type in ('TABLE');


select 'grant EXECUTE on SCA.'||object_name||' to CARLOSCALEGARI;' from dba_objects where owner = 'SCA' and object_type in ('PROCEDURE','FUNCTION','PACKAGE','PACKAGE BODY');

-- grant mais facil em todas tabelas para uma ROLE
set lines 750 pages 0 
spool grant_select_sci_sco.sql
select 'grant select on SCI.'||table_name||' to S_CSI;' from dba_tables where owner='SCI';
select 'grant select on SCO.'||table_name||' to S_SCO;' from dba_tables where owner='SCO';
spool off

@grant_select_sci_sco.sql

-- verifica quais tabelas existem em uma role e não na outra montando o comando
select  * from DBA_TAB_PRIVS where  GRANTEE = 'RXX' and table_name not in (select  table_name FROM DBA_TAB_PRIVS WHERE  GRANTEE = 'RXX_NEW');
select  'grant '||privilege ||' on '||owner ||'.'||table_name || ' to '||'RXX_NEW;' from DBA_TAB_PRIVS where  GRANTEE = 'RXX' and table_name not in (select  table_name FROM DBA_TAB_PRIVS WHERE  GRANTEE = 'RXX_NEW');

KIPREV.RE_MEMORIA_CALCULO_IOF E KIPREV.RE_MEMORIA_CALCULO_IOF_DETA

select  
'grant '
||privilege 
||' on "'
|| ''
||owner 
||'"."'
||table_name 
|| '" to '
||'RXX_NEW;' 
from DBA_TAB_PRIVS where  GRANTEE = 'RXX' and table_name not in (select  table_name FROM DBA_TAB_PRIVS WHERE  GRANTEE = 'RXX_CONSULTA');

SQL> set lines 850 pages 800
SQL> col username for a35
SQL> col PROFILE for a15
SQL> select USERNAME,ACCOUNT_STATUS,LOCK_DATE,EXPIRY_DATE,CREATED,PROFILE,PASSWORD_VERSIONS,CREATED,DEFAULT_TABLESPACE,TEMPORARY_TABLESPACE from dba_users 
  2  where USERNAME like '%CVP14944%' ;
>>Query Run In:Resultado da Consulta
Decorrido: 00:00:00.351
SQL> COL GRANTEE FOR A20
SQL> COL GRANTED_ROLE FOR A20
SQL> SELECT * FROM DBA_ROLE_PRIVS
  2  WHERE  GRANTEE = 'CVP14944'
  3  ORDER BY 1;
>>Query Run In:Resultado da Consulta 1
Decorrido: 00:00:00.363
SQL> grant RXX_NEW to CVP14944;

Grant bem-sucedido.

Decorrido: 00:00:00.040
SQL> COL GRANTEE FOR A20
SQL> COL GRANTED_ROLE FOR A20
SQL> SELECT * FROM DBA_ROLE_PRIVS
  2  WHERE  GRANTEE = 'CVP14944'
  3  ORDER BY 1;
>>Query Run In:Resultado da Consulta 2
Decorrido: 00:00:00.366

select  
'grant '
||privilege 
||' on "'
|| ''
||owner 
||'"."'
||table_name 
|| '" to '
||'RXX_NEW;' 
from DBA_TAB_PRIVS where  GRANTEE = 'RXX' and table_name not in (select  table_name FROM DBA_TAB_PRIVS WHERE  GRANTEE = 'RXX_CONSULTA');

'GRANT'||PRIVILEGE||'ON"'||''||OWNER||'"."'||TABLE_NAME||'"TO'||'RXX_NEW;'                                                                                                                                                                                                                                                         
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
grant DELETE on "KIPREVWEB"."E_FINANCEIRA_INFO_RESPONSAVEL_RMF" to RXX_NEW;
grant INSERT on "KIPREVWEB"."E_FINANCEIRA_INFO_RESPONSAVEL_RMF" to RXX_NEW;
grant SELECT on "KIPREVWEB"."E_FINANCEIRA_INFO_RESPONSAVEL_RMF" to RXX_NEW;
grant UPDATE on "KIPREVWEB"."E_FINANCEIRA_INFO_RESPONSAVEL_RMF" to RXX_NEW;

set lines 750 pages 1000 
col GRANTEE for a20
col OWNER for a15
col TABLE_NAME for a25
col GRANTOR for a15
 col PRIVILEGE for a15
select * from dba_tab_privs
where  grantee = 'COMPASSO' and owner='VIASOFT'
order by 3;

grant select on CEA.ZNET_LOCAL to 

grant select on CEA.ZNET_LOCAL to u11167;
grant select on CEA.ZNET_LOCAL to u10737;
grant select on CEA.ZNET_LOCAL to u1203555;


grant select on SIGO.VW_TTK_FULL to USR_MAMOR;
grant select on SIGO.VW_TTK_FULL to USR_FEFAR;
grant select on SIGO.VW_TTK_FULL to USR_SYNOG;
grant select on SIGO.VW_TTK_FULL to USR_WESOU;
grant select on SIGO.VW_TTK_FULL to USR_THKOM;
grant select on SIGO.VW_TTK_FULL to USR_CELNE;
grant select on SIGO.VW_TTK_FULL to USR_CLFUT;
grant select on SIGO.VW_TTK_FULL to USR_LUMOL;


grant select on SIGO.VW_IDS_SERVICO_TTK  to USR_MAMOR;
grant select on SIGO.VW_IDS_SERVICO_TTK  to USR_FEFAR;
grant select on SIGO.VW_IDS_SERVICO_TTK  to USR_SYNOG;
grant select on SIGO.VW_IDS_SERVICO_TTK  to USR_WESOU;
grant select on SIGO.VW_IDS_SERVICO_TTK  to USR_THKOM;
grant select on SIGO.VW_IDS_SERVICO_TTK  to USR_CELNE;
grant select on SIGO.VW_IDS_SERVICO_TTK  to USR_CLFUT;

select OWNER,GRANTEE,TABLE_NAME,PRIVILEGE from dba_tab_privs where TABLE_NAME ='INT_001_SIVPF_CEF_DETA';



GRANT DEBUG ANY PROCEDURE TO SEG13096;
GRANT SELECT ANY TRANSACTION TO SEG13096;
GRANT SELECT ANY SEQUENCE TO SEG13096;
GRANT SELECT ANY DICTIONARY TO SEG13096;
GRANT SELECT ANY TABLE TO SEG13096;
grant SELECT on KIPREVWEB.FO_DADOS_EMAIL_PORTAB_VW to SEG13096;
GRANT RESOURCE TO SEG13096;
GRANT RO_CONSULTA_KIPREVWEB TO SEG13096;
GRANT RXX TO SEG13096;
GRANT RO_CONSULTA_KIPREV TO SEG13096;
GRANT CONNECT TO SEG13096;
GRANT DB_DATAREADER TO SEG13096;


GRANT CONNECT TO CVT00972;
GRANT RXX TO CVT00972;
GRANT RXX_NEW TO CVT00972;
GRANT RO_CONSULTA_KIPREVWEB TO CVT00972;
GRANT RO_CONSULTA_KIPREV TO CVT00972;


-- query para trazer usuarios que tem role alem das 3 padrões
SELECT rp.grantee AS username, 
       rp.granted_role, 
       rp.admin_option, 
       rp.delegate_option
FROM dba_role_privs rp
WHERE rp.grantee IN (
    'SEG11130','PRE10174','SEG10802','SEG10800','SEG13096','SEG11377','PRE06871',
    'CVP14944','CVP14920','CVP16043','CVP14370','CVP16129','CVP16132','CVP14913',
    'TER07250','TER06748','TER70229','TER00608','TER60558','TER03880','TER05210',
    'CVT15152','CVT12320','CVT00865','CVT38342','CVT41383','CVT00237'
)
AND rp.granted_role NOT IN ('RXX_CONSULTA', 'RXX', 'CONNECT')
ORDER BY rp.grantee, rp.granted_role;
-- ou
SELECT rp.grantee AS username,
       LISTAGG(rp.granted_role, ', ') WITHIN GROUP (ORDER BY rp.granted_role) AS outras_roles
FROM dba_role_privs rp
WHERE rp.grantee IN (
    'SEG11130','PRE10174','SEG10802','SEG10800','SEG13096','SEG11377','PRE06871',
    'CVP14944','CVP14920','CVP16043','CVP14370','CVP16129','CVP16132','CVP14913',
    'TER07250','TER06748','TER70229','TER00608','TER60558','TER03880','TER05210',
    'CVT15152','CVT12320','CVT00865','CVT38342','CVT41383','CVT00237'
)
AND rp.granted_role NOT IN ('RXX_CONSULTA', 'RXX', 'CONNECT')
GROUP BY rp.grantee
ORDER BY rp.grantee;

-- query para trazer usuarios que não tem uma role especifica.
SELECT u.username, u.account_status, u.created
FROM dba_users u  
WHERE u.username in ('SEG11130','PRE10174','SEG10802','SEG10800','SEG13096','SEG11377','PRE06871','CVP14944','CVP14920','CVP16043','CVP14370','CVP16129','CVP16132','CVP14913','TER07250','TER06748','TER70229',
'TER00608','TER60558','TER03880','TER05210','CVT15152','CVT12320','CVT00865','CVT38342','CVT41383','CVT00237')
AND 
NOT EXISTS (
    SELECT 1 
    FROM dba_role_privs rp 
    WHERE rp.grantee = u.username 
      AND rp.granted_role ='RXX_CONSULTA'
)
ORDER BY u.username;

-- query para verificar se uma tabela especifica está dentro da role
select OWNER,GRANTEE,TABLE_NAME,PRIVILEGE from dba_tab_privs where TABLE_NAME ='PCK_DB_FO_RESG_SOLIC' AND GRANTEE='RXX';

PCK_DB_FO_RESG_SOLIC
PCK_DB_FO_RESG_SOLIC



revoke RESOURCE FROM SEG11377;	
revoke ROLE_CONS_KIPREV_KPVCUST04 FROM SEG11377;	
revoke DB_DATAREADER FROM SEG13096;	
revoke RESOURCE FROM SEG13096;	
revoke RO_CONSULTA_KIPREVWEB FROM SEG13096;	
revoke ROLE_CONS_KIPREV_KPVCUST04 FROM TER06748;	
revoke RESOURCE FROM TER07250;	
revoke RO_CONSULTA_KIPREVWEB FROM TER60558;	

-- definiar uma role como default
ALTER USER PRE10174 DEFAULT ROLE CONNECT, RXX_CONSULTA;

-- definir role padrão para todos os usuarios listados
BEGIN
    FOR r IN (
        SELECT column_value AS username 
        FROM table(sys.odcivarchar2list(
            'SEG11130','PRE10174','SEG10802','SEG10800','SEG13096','SEG11377','PRE06871',
            'CVP14944','CVP14920','CVP16043','CVP14370','CVP16129','CVP16132','CVP14913',
            'TER07250','TER06748','TER70229','TER00608','TER60558','TER03880','TER05210',
            'CVT15152','CVT12320','CVT00865','CVT38342','CVT41383','CVT00237'
        ))
    ) LOOP
        -- O comando "DEFAULT ROLE ALL" garante que a nova role E as antigas fiquem ativas no login
        EXECUTE IMMEDIATE 'ALTER USER ' || r.username || ' DEFAULT ROLE CONNECT';
    END LOOP;
END;


-- Criar function para extrair DDL de objetos de forma controlada
-- function:
CREATE OR REPLACE FUNCTION sys.get_ddl_user (
p_object_type IN VARCHAR2,
p_object_name IN VARCHAR2,
p_owner       IN VARCHAR2
)
RETURN CLOB
    AUTHID DEFINER
IS
    v_ddl CLOB;
BEGIN
-- Validação dos owners permitidos
    IF UPPER(p_owner) NOT IN ('KIPREV', 'KPVCUST04', 'KIPREVWEB') THEN
        raise_application_error(-20001,'Acesso negado. Extração permitida apenas para KIPREV, KPVCUST04 e KIPREVWEB.');
    END IF;
    -- Remove cláusulas físicas do DDL
    DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'STORAGE',FALSE);
    DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'TABLESPACE',FALSE);
    -- Extrai o DDL
    v_ddl := DBMS_METADATA.GET_DDL(
    object_type => UPPER(p_object_type),
    name        => UPPER(p_object_name),
    schema      => UPPER(p_owner)
    );

    RETURN v_ddl || CHR(10) || ';';

    EXCEPTION
    WHEN OTHERS THEN
    raise_application_error(-20002,'Erro ao extrair DDL: ' || SQLERRM);
END;
/

-- criar a role
-- 1. Cria a role dedicada
CREATE ROLE ROLE_DDL_USER;

-- 2. Concede a permissão de executar a function para a nova role
GRANT EXECUTE ON sys.get_ddl_user TO ROLE_DDL_USER;

GRANT EXECUTE ON sys.get_ddl_user TO TER07250;

-- associando os usuarios a role 
BEGIN
    FOR r IN (
        SELECT column_value AS username 
        FROM table(sys.odcivarchar2list(
            'SEG11130','PRE10174','SEG10802','SEG10800','SEG13096','SEG11377','PRE06871',
            'CVP14944','CVP14920','CVP16043','CVP14370','CVP16129','CVP16132','CVP14913',
            'TER07250','TER06748','TER70229','TER00608','TER60558','TER03880','TER05210',
            'CVT15152','CVT12320','CVT00865','CVT38342','CVT41383','CVT00237'
        ))
    ) LOOP
        EXECUTE IMMEDIATE 'GRANT ROLE_DDL_USER TO ' || r.username;
    END LOOP;
END;
/


-- como o usuario vai chamar
SET LONG 1000000

SELECT sys.get_ddl_user('PACKAGE','PCK_DB_FO_RESG_SOLIC','KIPREV')FROM dual;
