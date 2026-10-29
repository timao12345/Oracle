run {

allocate channel ch1 device type 'sbt_tape'
parms="sbt_library=oracle.disksbt, env=(backup_dir=/tmp/backup)";
crosscheck backup;
crosscheck archivelog all;
crosscheck backup of controlfile;
delete noprompt expired archivelog all;
delete noprompt expired backup;
delete noprompt obsolete;

}


RMAN> allocate channel for maintenance type disk;

allocated channel: ORA_MAINT_DISK_2
channel ORA_MAINT_DISK_2: SID=1265 instance=TESTKING1 device type=DISK

RMAN> delete obsolete device type disk;



-- emrep 

run {
allocate channel device type disk;
crosscheck backup;
delete obsolete recovery window of 3 days device type disk;
}