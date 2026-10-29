-- Verifica usuario expirado ou bloqueado
select username,account_status,expiry_date, lock_date from dba_users;

--Pegar senha hash do usuario
select 
'alter user "'||username||'" identified by values '''||extract(xmltype(dbms_metadata.get_xml('USER',username)),'//USER_T/PASSWORD/text()').getStringVal()||''';'  old_password 
from 
dba_users
where
username like 'DBSNMP';


	select 'alter user '||name||' identified by values '''||password||''';' 
	from user$
	where spare4 is null and password is not null and name='DVSYS'
	union
	select 'alter user '||name||' identified by values '''||spare4||';'||password||''';' 
	from user$ 
	where spare4 is not null and password is not null and name='DVSYS';


-- // Resultado // --
	alter user "UOLDIVEO_MON" identified by values 'A83546811780FB0F';


-- // -- // --

SELECT  ' CREATE USER ' || A.NAME || ' IDENTIFIED BY VALUES ' ||''''||A.PASSWORD||'''' ||CHR(10)||
' DEFAULT TABLESPACE ' ||B.DEFAULT_TABLESPACE|| ' TEMPORARY TABLESPACE '||B.TEMPORARY_TABLESPACE|| 
' PROFILE ' ||PROFILE|| ' ACCOUNT UNLOCK;' as DDL
FROM USER$ A , DBA_USERS B 
WHERE A.NAME='DVSYS' AND  B.USERNAME='DVSYS';

SELECT ' GRANT ' ||GRANTED_ROLE|| ' '||  GRANTEE FROM  DBA_ROLE_PRIVS WHERE GRANTEE='UOLDIVEO_MON';

SELECT ' GRANT ' ||PRIVILEGE|| ' '||  GRANTEE FROM  DBA_SYS_PRIVS WHERE GRANTEE='UOLDIVEO_MON';


SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE LIKE 'DIEGO_SANTOS';


SELECT * FROM DBA_USERS WHERE USERNAME LIKE 'DIEGO_SANTOS';
SELECT * FROM DBA_TAB_PRIVS WHERE GRANTOR LIKE 'DIEGO_SANTOS';

col grantee for a25
col owner for a15
col table_name for a25
col privilege for a10
col grantable for a25
col hierarchy for a25
col common for a25
col type for a5
SELECT grantee,owner, table_name,grantor,privilege,grantable,hierarchy,common,type 
from DBA_TAB_PRIVS 
WHERE owner='DIEGO_SANTOS' 
order by table_name 

and
	table_name = 'TODS_PDR_CARTAOCARREFOUR' and
	table_name = 'TODS_PDR_CLIENTE' and 
	table_name = 'TODS_EXCELLER_ATENDIMENTO';





BACKUP               
,IGORDBM              
,STM                  
,DBSNMP               
,LBACSYS              
,MGSYS                
,OJVMSYS              
,ORDSYS               
,MGWPD                
,GSMADMIN_INTERNAL   
,MGFRO                               
,MGINS                
,CTXSYS                            
,MGEBS                
,MGPROJ               
,MGLOJ                
,MGESC                
,MGCSP                
,MGGER                
,MGRMT                
,DVSYS                
,MGCSC                
,WMSYS                
,MEGASOA              
,DBM                  
,MGORC                
,MGNFE                
,MGCRR                
,MGBAL                
,MGCTT                
,MGCBA                
,MGCLI                
,MGWEB                
,ORDDATA              
,MGCTO                
,MGOPF                
,MGPGE                
,DBM_LOG              
,MGPGC                
,MGECF                
,MGATI                
,MEGAECF              
,MGRH                 
,MGMAN                
,MEGAECF14                            
,MGTRA                
,MGEMP                
,MGVEN                
,MDSYS                
,MGCWB                
,MGADO                
,MGAGR                
,MGNFS                
,MGADM                
,MEGA                 
,MGCSZ                
,MGTRF                
,MGCRM                
,MGCMR                
,MGMAG                
,MGINT                
,MGCUSTOM             
,CWEB                 
,MGPGW                
,MGADT                                 
,MGFIN                
,MGCON                
,MGREL                
,MGGLO                
,MGCAR                
,MGDBM                