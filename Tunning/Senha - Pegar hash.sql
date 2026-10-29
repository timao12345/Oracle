select 
'alter user "'||username||'" identified by values '''||extract(xmltype(dbms_metadata.get_xml('USER',username)),'//USER_T/PASSWORD/text()').getStringVal()||''';'  old_password 
from 
   dba_users
where
username like 'ORDS_PUBLIC_USER';







select 'alter user '||name||' identified by values '''||password||''';' from user$ where spare4 is null and password is not null and name='KIPREVWEB'
union
select 'alter user '||name||' identified by values '''||spare4||';'||password||''';' from user$ where spare4 is not null and password is not null and name='KIPREVWEB';


alter user CVP_ZABBIX_MON identified by values 'S:0A146C5314D0F46BA02FF97F5CFEADC38620080285A59EBFDE27F10CE7EA;T:71ED665D68039418F9530F88E43B1F31090CC2F5397B1276990CBB45573413D4E9C10D63B5AE278B14A939CA58FF680D6FAD4049A42BF736B64AD2FAAE36DA71595690B3E4481664EEEBB1007154D971;834EFE4D4756E416';



sqlplus ANALYTICS/RF|!BZC58Mml;
sqlplus RUB/1q2w3e45t*TI
sqlplus RUB_DATA/Y$*M*8vRy0ks


usuario: RUB  
senha:   1q2w3e45t*TI

usuario: RUB_DATA
senha:  2W3z4f56MI14214

usuario: ANALYTICS
senha:  3w5Z6f57mI14598


sqlplus RUB_DATA/2W3z4f56MI14214
sqlplus ANALYTICS/3w5Z6f57mI14598
sqlplus RUB/1q2w3e45t*TI


set lines 850 pages 800
col username for a35
select USERNAME,ACCOUNT_STATUS,LOCK_DATE,EXPIRY_DATE,CREATED from dba_users
where username='PRE10259';

COL GRANTEE FOR A20
COL GRANTED_ROLE FOR A20
SELECT * FROM DBA_ROLE_PRIVS
WHERE  GRANTEE = 'ANALYTICS'
ORDER BY 1;

ALTER USER RUB_DATA identified by 204922576095802;

alter user "PRE10259" identified by values '204922576095802';
alter user "ANALYTICS" identified by  values '687329576015208';