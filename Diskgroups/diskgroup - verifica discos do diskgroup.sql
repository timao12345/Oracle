col a.group_number for a5
col a.disk_number for a5
col name for a20
col path for a22
col label for a30
col diskgroup for a12
--col label for a20
select a.group_number, a.disk_number, a.name, b.name as DISKGROUP, a.path, a.header_status, a.mount_status, a.mode_status, a.state, a.os_mb, a.total_mb, a.free_mb 
from v$asm_disk a, v$asm_diskgroup b 
where a.group_number=b.group_number and (b.name='SYSTEM')
order by a.group_number, a.disk_number;