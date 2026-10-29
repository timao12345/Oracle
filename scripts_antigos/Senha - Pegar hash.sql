select 
'alter user "'||username||'" identified by values '''||extract(xmltype(dbms_metadata.get_xml('USER',username)),'//USER_T/PASSWORD/text()').getStringVal()||''';'  old_password 
from 
   dba_users
where
username like 'ORDS_PUBLIC_USER';





select 'alter user '||name||' identified by values '''||password||''';' from user$ where spare4 is null and password is not null and name='ORDS_PUBLIC_USER'
union
select 'alter user '||name||' identified by values '''||spare4||';'||password||''';' from user$ where spare4 is not null and password is not null and name='ORDS_PUBLIC_USER';


alter user CULTIVO identified by values 'S:158D49AE1D6B2E78408AEFDA77EB346DD590E75519FAD6BAA53E3C1A5425;T:5193C8FEC91EF6D640CB63DC9E86AF0B004578DFC437FFB7EBC94C94022A43963EAB271CE453AD9C168B99273C28133BDD946C6900D3294FD9229DE8537934B03ECEA2EFBF740BDAF483B86C029926A9;FF924540692C0063';


select username,account_status,LOCK_DATE,EXPIRY_DATE from dba_users where account_status <> 'OPEN';


