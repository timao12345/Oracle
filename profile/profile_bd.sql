-- consulta os profiles do bd
select * from DBA_PROFILES order by PROFILE;

-- Tirar a validação de senha padrão do Oracle, voltar ao padrão depois
alter profile default limit PASSWORD_VERIFY_FUNCTION  NULL;

-- alterar profile Usuario para reutilizar senha anteior, voltar ao padrão depois
alter profile default limit PASSWORD_REUSE_MAX unlimited;

-- altera o profile de IDLE_TIME que é responsável por matar as sessões inativas do BD
alter profile default limit IDLE_TIME 1;

-- alterar case senssitive do banco
alter system set sec_case_sensitive_logon=FALSE scope=both;

-- Profile para alterar a senha mais de 1 vez
alter profile DEFAULT limit PASSWORD_REUSE_TIME 365

alter profile DEFAULT limit PASSWORD_LIFE_TIME unlimited;

-- criar profile
CREATE PROFILE ACN LIMIT
COMPOSITE_LIMIT UNLIMITED 
INACTIVE_ACCOUNT_TIME DEFAULT   
CPU_PER_SESSION UNLIMITED 
CPU_PER_CALL UNLIMITED 
LOGICAL_READS_PER_SESSION UNLIMITED 
LOGICAL_READS_PER_CALL UNLIMITED 
IDLE_TIME UNLIMITED 
CONNECT_TIME UNLIMITED 
PRIVATE_SGA UNLIMITED 
FAILED_LOGIN_ATTEMPTS 1000      
PASSWORD_LIFE_TIME UNLIMITED 
PASSWORD_REUSE_TIME UNLIMITED 
PASSWORD_REUSE_MAX UNLIMITED 
PASSWORD_VERIFY_FUNCTION DEFAULT   
PASSWORD_LOCK_TIME 1         
PASSWORD_GRACE_TIME UNLIMITED 
SESSIONS_PER_USER UNLIMITED;

CREATE PROFILE CRM_USERS LIMIT 
    SESSIONS_PER_USER          UNLIMITED
    CPU_PER_SESSION            UNLIMITED 
    CPU_PER_CALL               3000 
    CONNECT_TIME               15;
    
--
select * from USER_RESOURCE_LIMITS;

select * from profile$
select * from profname$
select * from RESOURCE_COST

alter profile default limit FAILED_LOGIN_ATTEMPTS unlimited;

alter profile DEFAULT limit PASSWORD_REUSE_TIME 365
