$ sqlplus / as sysasm
SQL> select dg.name, d.name, d.total_mb from v$asm_disk d join v$asm_diskgroup dg using (group_number) order by 1,2;