--VERIFICAR AREA DE ARCHIVE

SYS@FISCALD1> archive log list
Database log mode              Archive Modepbacku
Automatic archival             Enabled
**Archive destination            
Oldest online log sequence     1237
Next log sequence to archive   1240
Current log sequence           1240


SYS@FISCALD1> select * from v$recovery_area_usage;

set lines 120
break on report
 
compute sum of percent_space_used on report
compute sum of percent_space_reclaimable on report

select file_type
,      percent_space_used
,      percent_space_reclaimable
,      number_of_files
from   v$recovery_area_usage
order by 1
/

set lines 120
break on report
compute sum of percent_space_used on report
compute sum of MB on report
compute sum of percent_space_reclaimable on report
compute sum of GB on report
SELECT
 F.FILE_TYPE
,round((F.PERCENT_SPACE_USED/100*D.SPACE_LIMIT/1024/1024),7) MB
,round((F.PERCENT_SPACE_USED/100*D.SPACE_LIMIT/1024/1024/1024),7) GB
,F.PERCENT_SPACE_USED
,F.PERCENT_SPACE_RECLAIMABLE
,F.NUMBER_OF_FILES
--,F.CON_ID
FROM V$RECOVERY_AREA_USAGE F, V$RECOVERY_FILE_DEST D;


SELECT * FROM V$RECOVERY_FILE_DEST;

    -- SELECT * FROM V$FLASH_RECOVERY_AREA_USAGE;

    -- SELECT * FROM V$RECOVERY_FILE_DEST; 

FILE_TYPE            PERCENT_SPACE_USED PERCENT_SPACE_RECLAIMABLE NUMBER_OF_FILES
-------------------- ------------------ ------------------------- ---------------
CONTROL FILE                        .12                         0               1
REDO LOG                              0                         0               0
ARCHIVED LOG                      74.44                      46.7             370
BACKUP PIECE                          0                         0               0
IMAGE COPY                            0                         0               0
FLASHBACK LOG                         0                         0               0
FOREIGN ARCHIVED LOG                  0                         0               0



SYS@FISCALD1> show parameter reco

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
control_file_record_keep_time        integer     90
**db_recovery_file_dest              string      +DGARCH
db_recovery_file_dest_size           big integer 60G
db_unrecoverable_scn_tracking        boolean     TRUE
recovery_parallelism                 integer     0



SYS@FISCALD1> SELECT NAME DISKGROUP, TOTAL_MB, FREE_MB, (TOTAL_MB-FREE_MB)/TOTAL_MB*100 PCT_UTILIZADO FROM V$ASM_DISKGROUP;

DISKGROUP                        TOTAL_MB    FREE_MB PCT_UTILIZADO
------------------------------ ---------- ---------- -------------
DGACFS                              20480       5021    75.4833984
**DGARCH                             512000     205711    59.8220703
DGCARGO                           1095680     231163    78.9023255
DGXRT                              153600      80168    47.8072917
DGCLM                             1622016    1416511    12.6697271
DGCRM                              686080     284774    58.4925956
DGDATAX                           5529582     573693    89.6250205
DGFATWIRE                          247808     159468    35.6485666
DGFISCAL                          1258496     362193    71.2201707
DGORADB                            772096     406875    47.3025375
DGREDOAX                            51199       9680    81.0933807
DGREDOBX                            51199      14739    71.2123284
DGSABRE                            542720     193925    64.2679466
DGSOA                              727040     189718    73.9054247
DGTRAX                            3727360     412039     88.945554
DGWCS                              104448      62695    39.9749157
ORAOCRVOTE                           5120       4190    18.1640625
