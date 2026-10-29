Manage the archivelogs using RMAN
 

Your are told to backup your Oracle database and its archived redo logs with RMAN.  If we backup archived redo logs with RMAN we ideally manage them with RMAN as well.

Here are some useful RMAN commands for archive log management.  

 

With this command we list all the archive logs current known in the control file 

 

RMAN > list archivelog all;

 

With this command we backup the all archive logs currently known in the control file. ( and the control file is updated )

 

RMAN> backup archivelog all;

 

With this command we backup the all archive logs currently known in the control file which haven' t been backed up to disk yet.  ( and the control file is updated )

 

RMAN> backup archivelog all not backed up 1 times;

 

With this command we backup the all archive logs currently known in the control file and once backed up we delete them ( and the control file is updated )

 

RMAN> backup archivelog all delete input ;

 

With this command we list all archive logs currently known in the control file and backed up at least once to disk.

 

RMAN> list archivelog all backed up 1 times to DISK;

 

List of Archived Log Copies for database with db_unique_name SILVER

=====================================================================

Key Thrd Seq S Low Time 

------- ---- ------- - ---------
1903 1 222 A 15-OCT-13
Name: /u02/fast_recovery_area/SILVER/archivelog/2013_10_22/o1_mf_1_222_96dzdz10_.arc

1904 1 223 A 22-OCT-13

Name: /u02/fast_recovery_area/SILVER/archivelog/2013_10_25/o1_mf_1_223_96njbc7c_.arc

 

With this command we delete all the archive logs currently known in the control file and backed up at least once to disk. ( and the control file is updated )

 

RMAN> delete archivelog all backed up 1 times to DISK;

 

With this command we delete all the archive logs currently known in the control file and backed up at least once to tape. ( and the control file is updated )

 

RMAN> delete archivelog all backed up 1 times to SBT_TAPE;


With this command we delete all the archive logs currently known in the control file and backed up at least once to disk except those generated the latest 4 hours ( and the control file is updated ) . 

 

RMAN> delete archivelog all backed up 1 times to disk completed before 'sysdate - 4/24';



released channel: ORA_DISK_1

allocated channel: ORA_DISK_1
channel ORA_DISK_1: SID=423 device type=DISK
List of Archived Log Copies for database with db_unique_name SILVER
=====================================================================

Key Thrd Seq S Low Time 
------- ---- ------- - ---------
1903 1 222 A 15-OCT-13
Name: /u02/fast_recovery_area/SILVER/archivelog/2013_10_22/o1_mf_1_222_96dzdz10_.arc


Do you really want to delete the above objects (enter YES or NO)? YES
deleted archived log
archived log file name=/u02/fast_recovery_area/SILVER/archivelog/2013_10_22/o1_mf_1_222_96dzdz10_.arc RECID=1903 STAMP=829495746
Deleted 1 objects

 

With this command we verify whether the archive logs currently known in the control file physically exist, the archive logs  which aren' t found got the flag EXPIRED 

 

RMAN> crosscheck archivelog all;

 

With this command we update the control file. Archive logs physically purged and logically flagged as EXPIRED  ( see above ) are removed from the control file repository

 

RMAN> delete expired archivelog all;

 

With this command we verify whether 1 archive log for a specific redo log sequence physically exists, ( is available on disk )

 

RMAN> crosscheck archivelog sequence 87174;

 

With this command we verify whether there is a backup for 1 archive log for a specific redo log sequence.

 

RMAN> crosscheck backup of archivelog sequence 87174;