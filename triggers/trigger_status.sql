-- lista triggers
col owner for a25
col TRIGGER_NAME for a35
col TRIGGERING_EVENT for a45
select owner,TRIGGER_NAME,TRIGGER_TYPE,TRIGGERING_EVENT,STATUS, table_name from dba_triggers
where owner='KIPREV' and status='ENABLED' order by 6;

col owner for a25
col TRIGGER_NAME for a35
col TRIGGERING_EVENT for a45
select owner,TRIGGER_NAME,TRIGGER_TYPE,TRIGGERING_EVENT,STATUS, table_name from dba_triggers
where TRIGGER_NAME='TRG_MOVIMTODETA_SALDO';
KIPREV.TRG_MOVIMTODETA_SALDO 


col owner for a25
col TRIGGER_NAME for a35
col TRIGGERING_EVENT for a45
select owner,TRIGGER_NAME,TRIGGER_TYPE,TRIGGERING_EVENT,STATUS,table_name from dba_triggers
where table_name = 'USUARIO';

TRG_MOVIMTODETA_SALDO 

-- lista triggers
col owner for a25
col TRIGGER_NAME for a35
col TRIGGERING_EVENT for a45
select owner,TRIGGER_NAME,TRIGGER_TYPE,TRIGGERING_EVENT,STATUS, table_name,TRIGGER_BODY from dba_triggers
where owner='ELETROMAPA' order by 6;


-- retorna o ddl da trigger
undef object_type
undef object_name
undef owner
set trims on
col DLL for a500
set long 999999999
select dbms_metadata.get_ddl('TRIGGER','TRG_AUDIT_FVDISTRIBPLATAFOR_01','KIPREV') ||chr(10)||';' as DLL from dual;

-- DESABILITAR
alter trigger USR_AUDIT.TR_BLOQUEIA_ACESSO_CLIE disable;

-- Habilitar
alter trigger USR_AUDIT.TR_BLOQUEIA_ACESSO_CLIE enable;

alter trigger  AUDITORIA.TGR_CREATE_USER_LOGON disable;


-- retorna trigger
select owner as trigger_schema_name,
       trigger_name,
       trigger_type,
       triggering_event,
       table_owner as schema_name,
       table_name as object_name,
       --base_object_type as object_type,
       --status,
       trigger_body as script       
from sys.dba_triggers
-- excluding some Oracle maintained schemas
where  table_name = 'TB_AUTORIZACAO_NF_ITEM'
order by trigger_name,
         table_owner,
         table_name,
         base_object_type;
