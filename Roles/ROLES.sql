
SELECT  * FROM ROLE_ROLE_PRIVS where ROLE ='RXX_CONSULTA';


SELECT  * FROM ROLE_SYS_PRIVS where ROLE ='RO_APEX_SMPREV';


SELECT  * FROM ROLE_TAB_PRIVS   where ROLE ='RO_APEX_SMPREV';



-- todas Roles
SELECT SUBSTR(TRIM(rtp.role),1,12)          AS ROLE
     , SUBSTR(rp.grantee,1,16)              AS GRANTEE
     , SUBSTR(TRIM(rtp.privilege),1,12)     AS PRIVILEGE
     , SUBSTR(TRIM(rtp.owner),1,12)         AS OWNER
     , SUBSTR(TRIM(rtp.table_name),1,28)    AS TABLE_NAME
     , SUBSTR(TRIM(rtp.column_name),1,20)   AS COLUMN_NAME
     , SUBSTR(rtp.common,1,4)               AS COMMON
     , SUBSTR(rtp.grantable,1,4)            AS GRANTABLE
     , SUBSTR(rp.default_role,1,16)         AS DEFAULT_ROLE
     , SUBSTR(rp.admin_option,1,4)          AS ADMIN_OPTION
  FROM role_tab_privs rtp
  LEFT JOIN dba_role_privs rp
    ON (rtp.role = rp.granted_role)
 WHERE ('&1' IS NULL OR UPPER(rtp.role) LIKE UPPER('%&1%'))
   AND ('&2' IS NULL OR UPPER(rp.grantee) LIKE UPPER('%&2%'))
   AND ('&3' IS NULL OR UPPER(rtp.table_name) LIKE UPPER('%&3%'))
   AND ('&4' IS NULL OR UPPER(rtp.owner) LIKE UPPER('%&4%'))
 ORDER BY 1
        , 2
        , 3
        , 4
;



GRANTEE             |GRANTED_ROLE        |ADM|DEF
--------------------|--------------------|---|---
OPERACAO            |COPERACAO           |NO |YES
OPERACAO            |COPERACAO_CARGA     |NO |YES
OPERACAO            |MOPERACAO_CARGA     |NO |YES
OPERACAO            |RL_ITRAJURI         |YES|YES
OPERACAO            |RESOURCE            |NO |YES
OPERACAO            |DBA                 |NO |YES
OPERACAO            |COPERACAO_MOBILE    |NO |YES
OPERACAO            |CONNECT             |NO |YES
OPERACAO            |EXECUTE_CATALOG_ROLE|NO |YES
OPERACAO            |MOPERACAO_MOBILE    |NO |YES
OPERACAO            |AOPERACAO_CARGA     |NO |YES
OPERACAO            |AOPERACAO_MOBILE    |NO |YES
OPERACAO            |CITRCCS             |NO |YES
OPERACAO            |AUDIT_USUARIO       |YES|YES
OPERACAO            |AQ_ADMINISTRATOR_ROL|NO |YES
                    |E                   |   |

OPERACAO            |AUTHENTICATEDUSER   |NO |YES
OPERACAO            |ROLE_CONNECT        |NO |YES

