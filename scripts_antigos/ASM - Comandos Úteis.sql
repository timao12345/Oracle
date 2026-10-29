############################################
#                                          #									
# Useful ASM commands in a RAC environment #
# http://www.hhutzler.de/blog/asm_commands #
#                                          #									
############################################

-------------------------------------------------------------------------------------------------------------------------------------------

# Check diskgroup including the dismounted DGs
#  asmcmd lsdg -g  --discovery 
Inst_ID  State       Type  Rebal  Sector  Block  AU  Total_MB  Free_MB  Req_mir_free_MB  Usable_file_MB  Offline_disks  Voting_files  Name
      3  DISMOUNTED        N           0   4096   0         0        0                0               0              0             N  ACFS/
      2  DISMOUNTED        N           0   4096   0         0        0                0               0              0             N  ACFS/
      1  DISMOUNTED        N           0   4096   0         0        0                0               0              0             N  ACFS/

	  
# Check ASM disk status
# asmcmd lsdsk -k -g 
Inst_ID  Total_MB  Free_MB  OS_MB  Name       Failgroup  Failgroup_Type  Library  Label  UDID  Product  Redund   Path
      3     10236     4316  10236  DATA_0000  DATA_0000  REGULAR         System                         UNKNOWN  /dev/asm_data_10g_disk1
      1     10236     4316  10236  DATA_0000  DATA_0000  REGULAR         System                         UNKNOWN  /dev/asm_data_10g_disk1
      2     10236     4316  10236  DATA_0000  DATA_0000  REGULAR         System                         UNKNOWN  /dev/asm_data_10g_disk1
..


# Check ASM disk status for candidate disk 
# asmcmd lsdsk -k -g --candidate
Inst_ID  Total_MB  Free_MB  OS_MB  Name       Failgroup  Failgroup_Type  Library  Label  UDID  Product  Redund   Path
      3         0        0   1019                        REGULAR         System                         UNKNOWN  /dev/asm_test_1G_disk1
      2         0        0   1019                        REGULAR         System                         UNKNOWN  /dev/asm_test_1G_disk1
      1         0        0   1019                        REGULAR         System                         UNKNOWN  /dev/asm_test_1G_disk1
      3         0        0   1019                        REGULAR         System                         UNKNOWN  /dev/asm_test_1G_disk2
      2         0        0   1019                        REGULAR         System                         UNKNOWN  /dev/asm_test_1G_disk2
      1         0        0   1019                        REGULAR         System                         UNKNOWN  /dev/asm_test_1G_disk2

	  
# Clients accessing ASM instance:
# asmcmd lsct
DB_Name  Status     Software_Version  Compatible_version  Instance_Name  Disk_Group
+ASM     CONNECTED        11.2.0.3.0          11.2.0.3.0  +ASM1          OCR
GRACE2   CONNECTED        11.2.0.3.0          11.2.0.0.0  GRACE21        DATA


#Files opened by ASM instance:
# asmcmd lsof
DB_Name  Instance_Name  Path
+ASM     +ASM1          +ocr.255.4294967295
GRACE2   GRACE21        +data/grace2/controlfile/current.260.822058257
GRACE2   GRACE21        +data/grace2/datafile/example.264.822058263
GRACE2   GRACE21        +data/grace2/datafile/sysaux.257.822058183
GRACE2   GRACE21        +data/grace2/datafile/system.256.822058183
GRACE2   GRACE21        +data/grace2/datafile/undotbs1.258.822058183
GRACE2   GRACE21        +data/grace2/datafile/undotbs2.265.822058387
GRACE2   GRACE21        +data/grace2/datafile/users.259.822058183
GRACE2   GRACE21        +data/grace2/onlinelog/group_1.261.822058257
GRACE2   GRACE21        +data/grace2/onlinelog/group_2.262.822058259
GRACE2   GRACE21        +data/grace2/onlinelog/group_3.266.822058427
GRACE2   GRACE21        +data/grace2/onlinelog/group_4.267.822058427
GRACE2   GRACE21        +data/grace2/tempfile/temp.263.822058261




------------------------------------------------------------------------------------------------------------------------------------------- 




# Use kfed, kfod to dump ASM headers and display the current ASM status

# Use kfed to display the ASM disk header status
# $GRID_HOME/bin/kfed  read /dev/oracleasm/disks/DATA2  | grep name
kfdhdb.dskname:               DATA_0001 ; 0x028: length=9
kfdhdb.grpname:                    DATA ; 0x048: length=4
kfdhdb.fgname:                DATA_0001 ; 0x068: length=9
kfdhdb.capname:                         ; 0x088: length=0

# Use kfod to get an idea about the ASM disk status
# kfod asm_diskstring='/dev/oracleasm/disks/*' nohdr=true verbose=true disks=all status=true op=disks
5114 CANDIDATE /dev/oracleasm/disks/DATA1 grid     asmadmin
5114 MEMBER /dev/oracleasm/disks/DATA2 grid     asmadmin
5114 MEMBER /dev/oracleasm/disks/DATA3 grid     asmadmin
2047 CANDIDATE /dev/oracleasm/disks/OCR1 grid     asmadmin
2047 CANDIDATE /dev/oracleasm/disks/OCR2 grid     asmadmin
2047 CANDIDATE /dev/oracleasm/disks/OCR3 grid     asmadmin
 
-------------------------------------------------------------------------------------------------------------------------------------------




# Use -g switch to check whether all diskgroups and disks are mounted clusterwide
# asmcmd lsdg -g
Inst_ID  State    Type    Rebal  Sector  Block       AU  Total_MB  Free_MB  Req_mir_free_MB  Usable_file_MB  Offline_disks  Voting_files  Name
      1  MOUNTED  NORMAL  N         512   4096  1048576      6141     5089             2047            1521              0             Y  OCR/
      3  MOUNTED  NORMAL  N         512   4096  1048576      6141     5089             2047            1521              0             Y  OCR/
      2  MOUNTED  NORMAL  N         512   4096  1048576      6141     5089             2047            1521              0             Y  OCR/
      3  MOUNTED  EXTERN  N         512   4096  1048576      5739     4565                0            4565              0             N  OPENFILER_DG/
      2  MOUNTED  EXTERN  N         512   4096  1048576      5739     4565                0            4565              0             N  OPENFILER_DG/
      1  MOUNTED  NORMAL  N         512   4096  1048576      3057     1995             1019             488              0             N  SSD/
      3  MOUNTED  NORMAL  N         512   4096  1048576      3057     1995             1019             488              0             N  SSD/
      2  MOUNTED  NORMAL  N         512   4096  1048576      3057     1995             1019             488              0             N  SSD/
--> OPENFILER diskgroup not mount on instance 1

# asmcmd lsdsk -k -g
Inst_ID  Total_MB  Free_MB   OS_MB  Name               Failgroup          Failgroup_Type  Library  Label  UDID  Product  Redund   Path
      1    204797   173589  204797  FRA_0000           FRA_0000           REGULAR         System                         UNKNOWN  /dev/asmdisk1_fra
      2    204797   173589  204797  FRA_0000           FRA_0000           REGULAR         System                         UNKNOWN  /dev/asmdisk1_fra
      3    204797   173589  204797  FRA_0000           FRA_0000           REGULAR         System                         UNKNOWN  /dev/asmdisk1_fra
...
      2      1913     1521    1913  OPENFILER_DG_0000  OPENFILER_DG_0000  REGULAR         System                         UNKNOWN  /dev/asmdisk_OF-disk1
      3      1913     1521    1913  OPENFILER_DG_0000  OPENFILER_DG_0000  REGULAR         System                         UNKNOWN  /dev/asmdisk_OF-disk1
      2      1913     1522    1913  OPENFILER_DG_0001  OPENFILER_DG_0001  REGULAR         System                         UNKNOWN  /dev/asmdisk_OF-disk2
      3      1913     1522    1913  OPENFILER_DG_0001  OPENFILER_DG_0001  REGULAR         System                         UNKNOWN  /dev/asmdisk_OF-disk2
      2      1913     1522    1913  OPENFILER_DG_0002  OPENFILER_DG_0002  REGULAR         System                         UNKNOWN  /dev/asmdisk_OF-disk3
      3      1913     1522    1913  OPENFILER_DG_0002  OPENFILER_DG_0002  REGULAR         System                         UNKNOWN  /dev/asmdisk_OF-disk3
-->  Disks OPENFILER_DG_0000, OPENFILER_DG_0001, OPENFILER_DG_0002 not visible on Instance 1 
     Action: check UDEV rules on instance 1 and verify diskheader with kfed
	 
	 
#Dismount a diskgroup on a local instance
# ASMCMD> lsdg -g OPENFILER_DG 
Inst_ID  State    Type    Rebal  Sector  Block       AU  Total_MB  Free_MB  Req_mir_free_MB  Usable_file_MB  Offline_disks  Voting_files  Name
      1  MOUNTED  EXTERN  N         512   4096  1048576      5739     4565                0            4565              0             N  OPENFILER_DG/
      3  MOUNTED  EXTERN  N         512   4096  1048576      5739     4565                0            4565              0             N  OPENFILER_DG/
      2  MOUNTED  EXTERN  N         512   4096  1048576      5739     4565                0            4565              0             N  OPENFILER_DG/
--> Diskgroup mounted on all instances 

# ASMCMD> umount  OPENFILER_DG
ORA-15032: not all alterations performed
ORA-15027: active use of diskgroup "OPENFILER_DG" precludes its dismount (DBD ERROR: OCIStmtExecute)

# ASMCMD> umount -f OPENFILER_DG
# ASMCMD>  lsdg -g OPENFILER_DG 
Inst_ID  State    Type    Rebal  Sector  Block       AU  Total_MB  Free_MB  Req_mir_free_MB  Usable_file_MB  Offline_disks  Voting_files  Name
      3  MOUNTED  EXTERN  N         512   4096  1048576      5739     4565                0            4565              0             N  OPENFILER_DG/
      2  MOUNTED  EXTERN  N         512   4096  1048576      5739     4565                0            4565              0             N  OPENFILER_DG/
--> Diskgroup OPENFILER dismounted on instance 1 
 
 
 
 
 
-------------------------------------------------------------------------------------------------------------------------------------------




# Manually add an ASM instance after Oracle Restart installation  failed
# Check resources - you may need to drop the ASM resource if already available
#[root@orars4 Desktop]# crs
*****  Local Resources: *****
Rescource NAME                 TARGET     STATE           SERVER       STATE_DETAILS                       
-------------------------      ---------- ----------      ------------ ------------------                  
ora.LISTENER.lsnr              ONLINE     ONLINE          orars4          
ora.ons                        OFFLINE    OFFLINE         orars4          
*****  Cluster Resources: *****
Resource NAME               INST   TARGET       STATE        SERVER          STATE_DETAILS
--------------------------- ----   ------------ ------------ --------------- -----------------------------------------
ora.cssd                       1   OFFLINE      OFFLINE                        
ora.diskmon                    1   OFFLINE      OFFLINE                        
ora.evmd                       1   ONLINE       ONLINE       orars4   

--> Run GUI tool asmca and create DG 

# Check resourses again asm resoruce is add and up and running 
#[root@orars4 Desktop]# crs
*****  Local Resources: *****
Rescource NAME                 TARGET     STATE           SERVER       STATE_DETAILS                       
-------------------------      ---------- ----------      ------------ ------------------                  
ora.DATA.dg                    ONLINE     ONLINE          orars4          
ora.LISTENER.lsnr              ONLINE     ONLINE          orars4          
ora.asm                        ONLINE     ONLINE          orars4       Started   
ora.ons                        OFFLINE    OFFLINE         orars4          
*****  Cluster Resources: *****
Resource NAME               INST   TARGET       STATE        SERVER          STATE_DETAILS
--------------------------- ----   ------------ ------------ --------------- -----------------------------------------
ora.cssd                       1   ONLINE       ONLINE       orars4            
ora.diskmon                    1   OFFLINE      OFFLINE                        
ora.evmd                       1   ONLINE       ONLINE       orars4