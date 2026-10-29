DBMS_METADATA.GET_DDL('PROCEDURE','EXPURGA_SOA_SCHEDULE','AZLHMXRT_SOAINFRA')
--------------------------------------------------------------------------------

  CREATE OR REPLACE PROCEDURE "AZLHMXRT_SOAINFRA"."EXPURGA_SOA_SCHEDULE" (P_DIAS
_RETENCAO NUMBER, P_REORG_TAB BOOLEAN DEFAULT FALSE) is
-- Ref. Notes do metalink:
--      Purging Strategies in Oracle SOA Suite 11g (Doc ID 1341163.1)
--      Troubleshooting SOA Instance Purging In Fusion Applications (Doc ID 1533
474.1)
--
  MAX_CREATION_DATE    TIMESTAMP;
  MIN_CREATION_DATE    TIMESTAMP;
  BATCH_SIZE           INTEGER;

DBMS_METADATA.GET_DDL('PROCEDURE','EXPURGA_SOA_SCHEDULE','AZLHMXRT_SOAINFRA')
--------------------------------------------------------------------------------
  MAX_RUNTIME          INTEGER;
  RETENTION_PERIOD     TIMESTAMP;
--
BEGIN
--
  MIN_CREATION_DATE := TO_TIMESTAMP('2014-04-01','YYYY-MM-DD');
  MAX_CREATION_DATE := TO_TIMESTAMP(sysdate - P_DIAS_RETENCAO);
  RETENTION_PERIOD  := TO_TIMESTAMP(sysdate - P_DIAS_RETENCAO);
  MAX_RUNTIME := P_DIAS_RETENCAO;
  BATCH_SIZE := 10000;
--

DBMS_METADATA.GET_DDL('PROCEDURE','EXPURGA_SOA_SCHEDULE','AZLHMXRT_SOAINFRA')
--------------------------------------------------------------------------------
 SOA.DELETE_INSTANCES (
                        MIN_CREATION_DATE               => MIN_CREATION_DATE,
                        MAX_CREATION_DATE               => MAX_CREATION_DATE,
                        BATCH_SIZE                      => BATCH_SIZE,
                        MAX_RUNTIME                     => MAX_RUNTIME,
                        RETENTION_PERIOD                => RETENTION_PERIOD,
                        PURGE_PARTITIONED_COMPONENT     => FALSE);
--

/* Reorg.. das tebelas abaixo
SELECT owner, TABLE_name FROM dba_tables

DBMS_METADATA.GET_DDL('PROCEDURE','EXPURGA_SOA_SCHEDULE','AZLHMXRT_SOAINFRA')
--------------------------------------------------------------------------------
WHERE table_name IN (''
,'AUDIT_TRAIL'
,'AUDIT_DETAILS'
,'CUBE_INSTANCE'
,'CUBE_SCOPE'
,'DLV_MESSAGE'
,'DLV_SUBSCRIPTION'
,'DOCUMENT_CI_REF'
,'DOCUMENT_DLV_MSG_REF'
,'HEADERS_PROPERTIES'
,'WORK_ITEM'

DBMS_METADATA.GET_DDL('PROCEDURE','EXPURGA_SOA_SCHEDULE','AZLHMXRT_SOAINFRA')
--------------------------------------------------------------------------------
,'WI_FAULT'
,'XML_DOCUMENT'
)
*/
   IF P_REORG_TAB  THEN
         EXECUTE IMMEDIATE 'alter table audit_trail  deallocate unused';
         EXECUTE IMMEDIATE 'alter table audit_trail  enable row movement';
         EXECUTE IMMEDIATE 'alter table audit_trail  shrink space compact';
         EXECUTE IMMEDIATE 'alter table audit_trail  shrink space';
         EXECUTE IMMEDIATE 'alter table audit_trail  disable row movement';


DBMS_METADATA.GET_DDL('PROCEDURE','EXPURGA_SOA_SCHEDULE','AZLHMXRT_SOAINFRA')
--------------------------------------------------------------------------------
         EXECUTE IMMEDIATE 'alter table audit_details deallocate unused';
         EXECUTE IMMEDIATE 'alter table audit_details enable row movement';
         EXECUTE IMMEDIATE 'alter table audit_details shrink space compact';
         EXECUTE IMMEDIATE 'alter table audit_details shrink space';
         EXECUTE IMMEDIATE 'alter table audit_details disable row movement';

         EXECUTE IMMEDIATE 'alter table cube_instance deallocate unused';
         EXECUTE IMMEDIATE 'alter table cube_instance enable row movement';
         EXECUTE IMMEDIATE 'alter table cube_instance shrink space compact';
         EXECUTE IMMEDIATE 'alter table cube_instance shrink space';
         EXECUTE IMMEDIATE 'alter table cube_instance disable row movement';

DBMS_METADATA.GET_DDL('PROCEDURE','EXPURGA_SOA_SCHEDULE','AZLHMXRT_SOAINFRA')
--------------------------------------------------------------------------------

         EXECUTE IMMEDIATE 'alter table cube_scope deallocate unused';
         EXECUTE IMMEDIATE 'alter table cube_scope enable row movement';
         EXECUTE IMMEDIATE 'alter table cube_scope shrink space compact';
         EXECUTE IMMEDIATE 'alter table cube_scope shrink space';
         EXECUTE IMMEDIATE 'alter table cube_scope disable row movement';

         EXECUTE IMMEDIATE 'alter table dlv_message deallocate unused';
         EXECUTE IMMEDIATE 'alter table dlv_message enable row movement';
         EXECUTE IMMEDIATE 'alter table dlv_message shrink space compact';
         EXECUTE IMMEDIATE 'alter table dlv_message shrink space';

DBMS_METADATA.GET_DDL('PROCEDURE','EXPURGA_SOA_SCHEDULE','AZLHMXRT_SOAINFRA')
--------------------------------------------------------------------------------
         EXECUTE IMMEDIATE 'alter table dlv_message disable row movement';

         EXECUTE IMMEDIATE 'alter table dlv_subscription deallocate unused';
         EXECUTE IMMEDIATE 'alter table dlv_subscription enable row movement';
         EXECUTE IMMEDIATE 'alter table dlv_subscription shrink space compact';
         EXECUTE IMMEDIATE 'alter table dlv_subscription shrink space';
         EXECUTE IMMEDIATE 'alter table dlv_subscription disable row movement';

         EXECUTE IMMEDIATE 'alter table document_ci_ref deallocate unused';
         EXECUTE IMMEDIATE 'alter table document_ci_ref enable row movement';
         EXECUTE IMMEDIATE 'alter table document_ci_ref shrink space compact';

DBMS_METADATA.GET_DDL('PROCEDURE','EXPURGA_SOA_SCHEDULE','AZLHMXRT_SOAINFRA')
--------------------------------------------------------------------------------
         EXECUTE IMMEDIATE 'alter table document_ci_ref shrink space';
         EXECUTE IMMEDIATE 'alter table document_ci_ref disable row movement';

         EXECUTE IMMEDIATE 'alter table document_dlv_msg_ref deallocate unused';

         EXECUTE IMMEDIATE 'alter table document_dlv_msg_ref enable row movement
';
         EXECUTE IMMEDIATE 'alter table document_dlv_msg_ref shrink space compac
t';
         EXECUTE IMMEDIATE 'alter table document_dlv_msg_ref shrink space';
         EXECUTE IMMEDIATE 'alter table document_dlv_msg_ref disable row movemen

DBMS_METADATA.GET_DDL('PROCEDURE','EXPURGA_SOA_SCHEDULE','AZLHMXRT_SOAINFRA')
--------------------------------------------------------------------------------
t';

         EXECUTE IMMEDIATE 'alter table headers_properties deallocate unused';
         EXECUTE IMMEDIATE 'alter table headers_properties enable row movement';

         EXECUTE IMMEDIATE 'alter table headers_properties shrink space compact'
;
         EXECUTE IMMEDIATE 'alter table headers_properties shrink space';
         EXECUTE IMMEDIATE 'alter table headers_properties disable row movement'
;


DBMS_METADATA.GET_DDL('PROCEDURE','EXPURGA_SOA_SCHEDULE','AZLHMXRT_SOAINFRA')
--------------------------------------------------------------------------------
         EXECUTE IMMEDIATE 'alter table work_item deallocate unused';
         EXECUTE IMMEDIATE 'alter table work_item enable row movement';
         EXECUTE IMMEDIATE 'alter table work_item shrink space compact';
         EXECUTE IMMEDIATE 'alter table work_item shrink space';
         EXECUTE IMMEDIATE 'alter table work_item disable row movement';

         EXECUTE IMMEDIATE 'alter table wi_fault deallocate unused';
         EXECUTE IMMEDIATE 'alter table wi_fault enable row movement';
         EXECUTE IMMEDIATE 'alter table wi_fault shrink space compact';
         EXECUTE IMMEDIATE 'alter table wi_fault shrink space';
         EXECUTE IMMEDIATE 'alter table wi_fault disable row movement';

DBMS_METADATA.GET_DDL('PROCEDURE','EXPURGA_SOA_SCHEDULE','AZLHMXRT_SOAINFRA')
--------------------------------------------------------------------------------

         EXECUTE IMMEDIATE 'alter table xml_document deallocate unused';
         EXECUTE IMMEDIATE 'alter table xml_document enable row movement';
         EXECUTE IMMEDIATE 'alter table xml_document shrink space compact';
         EXECUTE IMMEDIATE 'alter table xml_document shrink space';
         EXECUTE IMMEDIATE 'alter table xml_document disable row movement';
   END IF;
END;

