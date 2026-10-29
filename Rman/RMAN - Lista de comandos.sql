Frequently used RMAN Commands
LIST Backups

LIST ARCHIVELOG ALL;
LIST BACKUP OF ARCHIVELOG ALL;
LIST BACKUP;
LIST BACKUP OF DATABASE;
LIST BACKUP OF DATAFILE 1;
LIST BACKUP SUMMARY;
LIST INCARNATION;
LIST BACKUP BY FILE;
LIST COPY OF DATABASE ARCHIVELOG ALL;
LIST COPY OF DATAFILE 1, 2, 3;
LIST BACKUP OF DATAFILE 11 SUMMARY;
LIST BACKUP OF ARCHIVELOG FROM SEQUENCE 1437;
LIST BACKUP OF ARCHIVELOG from sequence 67922 until sequence 67925;
LIST CONTROLFILECOPY "/tmp/cntrlfile.copy";
LIST BACKUPSET OF DATAFILE 1;
LIST FAILURE;
LIST FAILURE 641231 detail;
LIST backup of database completed between "to_date('26/11/2016','DD/MM/YYYY')" and "to_date('28/11/2016','DD/MM/YYYY')";
LIST backup of database completed after "to_date('06/20/2010','mm/dd/yyyy')";
LIST backupset tag 'INCR_BACKUPSET_LEVEL_0';
LIST COPY BY FILE;
LIST EXPIRED BACKUP BY FILE;
LIST EXPIRED BACKUP SUMMARY;
LIST expired Backup of archivelog all summary;
LIST BACKUP SUMMARY;
LIST Backup of tablespace Test summary;
LIST BACKUP OF ARCHIVELOG until sequence 22360;
LIST BACKUP OF ARCHIVELOG FROM TIME "SYSDATE-10";
LIST BACKUP OF ARCHIVELOG FROM TIME "TO_DATE('09/05/2013 22:00:00', 'MM/DD/YYYY hh24:mi:ss')" UNTIL TIME "TO_DATE('09/06/2013 04:00:00', 'MM/DD/YYYY hh24:mi:ss')";
LIST backup of database completed between "to_date('14/04/2017','DD/MM/YYYY')" and "to_date('16/04/2017','DD/MM/YYYY')";
LIST CONTROLFILECOPY /tmp/cntrlfile.copy;
LIST Backup of Controlfile;
LIST Backup of Spfile;
LIST Backup of Tablespace Test;
LIST expired Backup;
LIST expired Backup of Archivelog all;
LIST expired Backup of datafile 10;
LIST recoverable backup;
LIST backuppiece '/b01/rman_backups/OGEP/ARCHIVELOG_OGEP_20170528_0ms5br21_1_1';
REPORT NEED BACKUP;
LIST BACKUP OF PLUGGABLE DATABASE MEGABILD SUMMARY;

DELETE BACKUP;
DELETE BACKUPPIECE 101;
DELETE CONTROLFILECOPY '/tmp/control01.ctl';
DELETE NOPROMPT ARCHIVELOG UNTIL SEQUENCE = 300;
DELETE BACKUP TAG='before_upgrade';
DELETE BACKUP OF TABLESPACE users DEVICE TYPE sbt; # delete only from tape
DELETE COPY OF CONTROLFILE LIKE '/tmp/%';  #
DELETE ARCHIVELOG ALL BACKED UP 3 TIMES TO DEVICE TYPE sbt;
DELETE NOPROMPT ARCHIVELOG ALL;
CROSSCHECK BACKUP;
DELETE EXPIRED BACKUP;
DELETE OBSOLETE;
DELETE NOPROMPT OBSOLETE;
DELETE OBSOLETE REDUNDANCY = 3;
DELETE BACKUPSET N;
DELETE OBSOLETE RECOVERY WINDOW OF 7 DAYS;
DELETE ARCHIVELOG ALL COMPLETED BEFORE sysdate-1;
DELETE ARCHIVELOG ALL BACKED UP 2 TIMES to disk;
DELETE NOPROMPT ARCHIVELOG UNTIL SEQUENCE = 151301;
DELETE FORCE ARCHIVELOG ALL BACKED UP 2 TIMES to disk;
DELETE BACKUP OF archivelog UNTIL TIME='sysdate-5';
DELETE OBSOLETE RECOVERY WINDOW OF 4 DAYS;
DELETE NOPROMPT ARCHIVELOG ALL;
DELETE BACKUPSET 19775,19776,19777,19778,19779,19780;
LIST EXPIRED ARCHIVELOG ALL;


--RESTORE BACKUP

RESTORE archivelog from logseq 97696 until logseq 97697;
RESTORE Database;

PREVIEW Commands

RESTORE DATABASE PREVIEW;
RESTORE TABLESPACE users PREVIEW;
RESTORE DATAFILE 3 PREVIEW;
RESTORE ARCHIVELOG FROM LOGSEQ 200 PREVIEW;
RESTORE ARCHIVELOG FROM TIME 'SYSDATE-7' PREVIEW;
RESTORE ARCHIVELOG FROM SCN 234546 PREVIEW;


Restore archivelogs using parallel channels

run
{
allocate channel ch1 type disk;
allocate channel ch2 type disk;
allocate channel ch3 type disk;
allocate channel ch4 type disk;
restore archivelog from scn 2324906766 until scn 2324970620;
}

Backup database

run {
allocate channel c1 type disk;
backup tag weekly_orcl3_full
format '/u07/orcl3/backup/full_%d_%s_%p_%t'
(database);
release channel c1;
allocate channel c2 type disk;
backup format '/u07/orcl3/backup/archive_%d_%s_%p_%t'
(archivelog all);
release channel c2;
}


Check RMAN Backup/Recovery Status

SELECT SID, SERIAL#, CONTEXT, SOFAR, TOTALWORK,
ROUND (SOFAR/TOTALWORK*100, 2) "% COMPLETE"
FROM V$SESSION_LONGOPS
WHERE OPNAME LIKE 'RMAN%' AND OPNAME NOT LIKE '%aggregate%'
AND TOTALWORK! = 0 AND SOFAR <> TOTALWORK;


set lines 200
 select operation,status,mbytes_processed,start_time,end_time,OBJECT_TYPE from v$rman_status where OPERATION='BACKUP';

Query to find the RMAN Backup Type, Status,start time,End Time, Time taken and Backup Size .
---------------------------------------------------------------------------------------------
 select INPUT_TYPE,
 STATUS,
 TO_CHAR(START_TIME,'mm/dd/yy hh24:mi') start_time,
 TO_CHAR(END_TIME,'mm/dd/yy hh24:mi') end_time,
 ELAPSED_SECONDS/3600 hrs,
 INPUT_BYTES/1024/1024/1024 SUM_BYTES_BACKED_IN_GB,
 OUTPUT_BYTES/1024/1024/1024 SUM_BACKUP_PIECES_IN_GB,
 OUTPUT_DEVICE_TYPE
 FROM V$RMAN_BACKUP_JOB_DETAILS
 order by SESSION_KEY