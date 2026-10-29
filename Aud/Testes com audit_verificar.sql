-- Verifica as açoes das sessões nos objetos

col OS_USERNAME format a10
col username format a10
col USERHOST format a10
col TERMINAL format a10
col OWNER format a10
col obj_name format a30
COL COMMENT_TEXT FORMAT A50
set linesize 1000

SELECT 
 os_username               
,username                  
,userhost                  
,terminal                  
,to_char(timestamp,'DD/MM/YYYY HH24:MI')                 
,obj_name                  
,ses_actions               
,sessionid                 
,entryid                   
,statementid               
,returncode                
,priv_used                 
FROM  dba_audit_object
/

-- Verifica as os login e logoffs

SELECT
  os_username                    
, username                       
, userhost                       
, terminal                       
, to_char(timestamp,'DD/MM/YYYY HH24:MI')                       
, action_name                    
, logoff_time                    
, logoff_lread                   
, logoff_pread                   
, logoff_lwrite                  
, logoff_dlock                   
, sessionid                      
, returncode 
FROM dba_audit_session
/

-- Verifica as os objetos auditados e as opções

SELECT 
 owner          
,object_name    
,object_type    
,del            
,ins            
,sel            
,upd            
FROM dba_obj_audit_opts
WHERE owner='UCA'
AND object_type = 'TABLE'

-- Verifica as opções de audit para sessão
SELECT  *        
FROM dba_priv_audit_opts


--

  1  SELECT * FROM AUDIT_ACTIONS
  2* WHERE NAME IN ('SELECT','INSERT','UPDATE','DELETE')
UCAT->/

   ACTION NAME
--------- ---------------------------
        2 INSERT
        3 SELECT
        6 UPDATE
        7 DELETE
        
        
SELECT         
 SESSIONID              
, STATEMENT              
, to_char(timestamp#,'DD/MM/YYYY HH24:MI')                       
, USERID                 
, USERHOST               
, TERMINAL               
, ACTION#                
, RETURNCODE             
, OBJ$CREATOR            
, OBJ$NAME               
, AUTH$PRIVILEGES        
, AUTH$GRANTEE           
, NEW$OWNER              
, NEW$NAME               
, SES$ACTIONS            
, SES$TID                
, LOGOFF$LREAD           
, LOGOFF$PREAD           
, LOGOFF$LWRITE          
, LOGOFF$DEAD            
, LOGOFF$TIME            
, SPARE1                 
, SPARE2                 
, OBJ$LABEL              
, SES$LABEL              
, PRIV$USED              
FROM SYS.AUD$





user esta view para analisar os commandos

col "OS User"     	format a10
col "User DB"		format a10
col "Machine"		format a15
col "Dt_Time"		format a19
col "Schema"		format a08
col "Objeto"		format a30
col "Action"		format a30
col "Comment"     	format a50
col "Priv_used"   	format a30
set linesize 1000
set pagesize 1000

SELECT
 os_username  					"OS User"          
,username               			"User DB"
,terminal               			"Machine"	
,to_char(timestamp,'DD/MM/YYYY HH24:MI:SS')	"Dt_Time"
,owner                  			"Schema"
,obj_name               			"Objeto"
,action                 			"Cd_Action"
,action_name            			"Action"
,comment_text					"Comment"         
,sessionid   					"SesionId"          
,entryid     					"Entryid"          
,statementid 					"Statementid"           
,returncode  					"Returncode"          
,priv_used   					"Priv_used"           
FROM dba_audit_trail
WHERE action NOT IN (100,101,102)
AND os_username <> 'x261827'
AND TRUNC(timestamp)=TRUNC(sysdate)
order by 4 



select count(*) 
from dba_audit_trail
where trunc(timestamp)=trunc(sysdate)-1


