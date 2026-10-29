select 
'alter user "'||username||'" identified by values '''||extract(xmltype(dbms_metadata.get_xml('USER',username)),'//USER_T/PASSWORD/text()').getStringVal()||''';'  old_password 
from 
   dba_users
where username = 'KIPREVWEB';


alter user RMS identified by "rms123";

alter user GLOBUS609 identified by "SkyOne#Migra#270322";


CONSULTA609  
SkyOne#Migra#270322

GLOBUS609 
SkyOne#Migra#270322