--List RMAN backup command for particular time period
Checked list of archive backup between time range

RMAN> list backup of archivelog time between "to_date('01-FEV-2020 00:00:00','DD-MON-YYYY HH24:MI:SS')" and "to_date('05-MAR-2020 00:00:00','DD-MON-YYYY HH24:MI:SS')";

--Checked list of database backup

RMAN> LIST BACKUP OF DATABASE COMPLETED AFTER '(SYSDATE-2)';

--Checked list of archivelog backup

RMAN> LIST BACKUP OF ARCHIVELOG BETWEEN '01-02-2020' AND '05-02-2020';

--List of backup of one datafile:

RMAN>LIST BACKUP OF DATAFILE 1 COMPLETED BETWEEN '06-OCT-2008' and '25-DEC-2008';

--Other user full commands:

--LIST BACKUP: 
list all backup sets, copies, and proxy copies of a database, tablespace, data file, archived redo log, control file, or server parameter file.

--LIST COPY: 
list all the images copy of database files and archive log files

--LIST archivelog:
list all archive log files

--List incarnation: 
list all incarnations of the database (incarnation is created when open database with resetlogs)

--List script names: 
list the name of recovery catalog created.

List failure: it is part of data recovery advisory which list the failure present in database.

LIST BACKUP SUMMARY: provide one line summary for backup Status.

LIST BACKUP BY FILE: List backup of each datafile, archive, control file by file wise