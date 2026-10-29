rman target / << EOF
run {
sql 'alter session set optimizer_mode=all_rows';
sql 'alter system archive log current';
allocate channel backup_disk1 type disk;
allocate channel backup_disk2 type disk;
allocate channel backup_disk3 type disk;
allocate channel backup_disk4 type disk;
allocate channel backup_disk5 type disk;
allocate channel backup_disk6 type disk;
allocate channel backup_disk7 type disk;
allocate channel backup_disk8 type disk;
allocate channel backup_disk9 type disk;
allocate channel backup_disk10 type disk;
allocate channel backup_disk11 type disk;
allocate channel backup_disk12 type disk;
allocate channel backup_disk13 type disk;
allocate channel backup_disk14 type disk;
allocate channel backup_disk15 type disk;
BACKUP VALIDATE DATABASE ;
release channel backup_disk1;
release channel backup_disk2;
release channel backup_disk3;
release channel backup_disk4;
release channel backup_disk5;
release channel backup_disk6;
release channel backup_disk7;
release channel backup_disk8;
release channel backup_disk9;
release channel backup_disk10;
release channel backup_disk11;
release channel backup_disk12;
release channel backup_disk13;
release channel backup_disk14;
release channel backup_disk15;
}
exit
EOF

