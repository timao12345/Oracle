Prompt File Types in Diskgroups
Prompt ========================
col "File Type"      for a16
col "Block Size"     for a5    Head "Block|Size"
col "Gb"             for 9990.00
col "Files"          for 99990
break on "Group Name" skip 1 nodup
 
select g.name                                   "Group Name"
,      f.TYPE                                   "File Type"
,      f.BLOCK_SIZE/1024||'k'                   "Block Size"
,      f.STRIPED
,        count(*)                               "Files"
,      round(sum(f.BYTES)/(1024*1024*1024),2)   "Gb"
from   v$asm_file f,v$asm_diskgroup g
where  f.group_number=g.group_number
group by g.name,f.TYPE,f.BLOCK_SIZE,f.STRIPED
order by 1,2;
clear break