set wrap off
set lines 120
set pages 999
col "Group Name"   form a25
col "Disk Name"    form a30
col "State"  form a15
col "Type"   form a7
col "Free TB"   form 9,999
 
prompt
prompt ASM Disk Groups
prompt ===============
select group_number  "Group"
,      name          "Group Name"
,      state         "State"
,      type          "Type"
,      total_mb/1024/1024 "Total TB"
,      free_mb/1024/1024  "Free TB"
from   v$asm_diskgroup



prompt
prompt Instances currently accessing these diskgroups
prompt ==============================================
col "Instance" form a8
select c.group_number  "Group"
,      g.name          "Group Name"
,      c.instance_name "Instance"
from   v$asm_client c
,      v$asm_diskgroup g
where  g.group_number=c.group_number
/


prompt
prompt free ASM disks and their paths
prompt ===========================
select header_status , mode_status, path from V$asm_disk
where header_status in ('FORMER','CANDIDATE')
/