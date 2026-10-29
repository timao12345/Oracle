col NAME for a15
col Disk_group for a10
col LABEL for a10
col PATH for a20
set lines 200
set pages 200
select g.NAME Disk_group, d.name, d.PATH,d.TOTAL_MB,d.FREE_MB,D.TOTAL_MB ,D.CREATE_DATE,D.MODE_STATUS,d.mount_status,d.header_status 
from 
v$asm_disk d,v$asm_diskgroup g 
WHERE 
G.GROUP_NUMBER(+)=D.GROUP_NUMBER  ORDER BY g.NAME,d.name, d.PATH,header_status; 


--
--./oracleasm scandisks
--./oracleasm querydisk /dev/dm*