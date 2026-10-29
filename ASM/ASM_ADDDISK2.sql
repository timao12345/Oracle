/etc/init.d/oracleasm querydisk -d `/etc/init.d/oracleasm listdisks -d` |
cut -f2,10,11 -d" " | perl -pe 's/"(.*)".*\[(.*), *(.*)\]/$1 $2 $3/g;' |
while read v_asmdisk v_minor v_major
do
v_device=`ls -la /dev | grep " $v_minor, *$v_major " | awk '{print $10}'`
echo "ASM disk $v_asmdisk based on /dev/$v_device [$v_minor, $v_major]"
done
ASM disk ARCH_CF_01 based on /dev/sdd1 [8, 49]
ASM disk ARCH_CF_02 based on /dev/sdc1 [8, 33]
ASM disk DATA_CF_01 based on /dev/sde1 [8, 65]
ASM disk DATA_CF_02 based on /dev/sdf1 [8, 81]
ASM disk DATA_CF_03 based on /dev/sdg1 [8, 97]
ASM disk DATA_CF_04 based on /dev/sdh1 [8, 113]
ASM disk DATA_CF_05 based on /dev/sdi1 [8, 129]
ASM disk DATA_CF_06 based on /dev/sdj1 [8, 145]
ASM disk DATA_CF_07 based on /dev/sdk1 [8, 161]
ASM disk DATA_CF_08 based on /dev/sdl1 [8, 177]
ASM disk DATA_CF_09 based on /dev/sdm1 [8, 193]
ASM disk DATA_CF_10 based on /dev/sdn1 [8, 209]
ASM disk DATA_CF_11 based on /dev/sdo1 [8, 225]
[root@ACSLCFR01 dev]#
SQL> select GROUP_NUMBER,DISK_NUMBER,MOUNT_STATUS,TOTAL_MB,PATH,MOUNT_STATUS from v$asm_disk where GROUP_NUMBER=2;

GROUP_NUMBER DISK_NUMBER MOUNT_S   TOTAL_MB PATH                           MOUNT_S
------------ ----------- ------- ---------- ------------------------------ -------
           2           0 CACHED      215034 ORCL:DATA_CF_01                CACHED
           2           1 CACHED      215034 ORCL:DATA_CF_02                CACHED
           2           2 CACHED      215034 ORCL:DATA_CF_03                CACHED
           2           3 CACHED      215034 ORCL:DATA_CF_04                CACHED
           2           4 CACHED      215034 ORCL:DATA_CF_05                CACHED
           2           5 CACHED      215034 ORCL:DATA_CF_06                CACHED
           2           6 CACHED      215034 ORCL:DATA_CF_07                CACHED
           2           7 CACHED      215034 ORCL:DATA_CF_08                CACHED
           2           8 CACHED      215034 ORCL:DATA_CF_09                CACHED
           2           9 CACHED      215034 ORCL:DATA_CF_10                CACHED
           2          10 CACHED      215034 ORCL:DATA_CF_11                CACHED

                                  
                                  
                                  /dev/sdr1 
/dev/sds1 
[root@ACSLCFR01 dev]# ls -ltr /dev/sdr1
brw-rw---- 1 root disk 65, 17 Sep 20 11:05 /dev/sdr1
[root@ACSLCFR01 dev]# ls -ltr /dev/sds1
brw-rw---- 1 root disk 65, 33 Sep 20 11:06 /dev/sds1
[root@ACSLCFR01 dev]# /usr/sbin/oracleasm createdisk DATA_CF_12 /dev/sdr1
Writing disk header: done
Instantiating disk: done
[root@ACSLCFR01 dev]# /usr/sbin/oracleasm createdisk DATA_CF_13 /dev/sds1
Writing disk header: done
Instantiating disk: done
[root@ACSLCFR01 dev]#

create diskgroup teste EXTERNAL REDUNDANCY DISK 'ORCL:DATA_CF_12','ORCL:DATA_CF_13';
  1* select GROUP_NUMBER,DISK_NUMBER,MOUNT_STATUS,TOTAL_MB,PATH,MOUNT_STATUS from v$asm_disk
SQL> /

GROUP_NUMBER DISK_NUMBER MOUNT_S   TOTAL_MB PATH                           MOUNT_S
------------ ----------- ------- ---------- ------------------------------ -------
           0           0 CLOSED           0 ORCL:DATA_CF_12                CLOSED
           0           1 CLOSED           0 ORCL:DATA_CF_13                CLOSED
           1           0 CACHED      215034 ORCL:ARCH_CF_01                CACHED
           1           1 CACHED      220156 ORCL:ARCH_CF_02                CACHED
           2           0 CACHED      215034 ORCL:DATA_CF_01                CACHED
           2           1 CACHED      215034 ORCL:DATA_CF_02                CACHED
           2           2 CACHED      215034 ORCL:DATA_CF_03                CACHED
           2           3 CACHED      215034 ORCL:DATA_CF_04                CACHED
           2           4 CACHED      215034 ORCL:DATA_CF_05                CACHED
           2           5 CACHED      215034 ORCL:DATA_CF_06                CACHED
           2           6 CACHED      215034 ORCL:DATA_CF_07                CACHED
           2           7 CACHED      215034 ORCL:DATA_CF_08                CACHED
           2           8 CACHED      215034 ORCL:DATA_CF_09                CACHED
           2           9 CACHED      215034 ORCL:DATA_CF_10                CACHED
           2          10 CACHED      215034 ORCL:DATA_CF_11                CACHED

15 rows selected.

SQL>
SQL> create diskgroup teste EXTERNAL REDUNDANCY DISK 'ORCL:DATA_CF_12','ORCL:DATA_CF_13';

Diskgroup created.

[UOL-oracle@ACSLCFR01 (+ASM)~]$ asmcmd
ASMCMD> lsdg
State    Type    Rebal  Sector  Block       AU  Total_MB  Free_MB  Req_mir_free_MB  Usable_file_MB  Offline_disks  Voting_files  Name
MOUNTED  EXTERN  N         512   4096  1048576    435190   394015                0          394015              0             N  ARCH_CF/
MOUNTED  EXTERN  N         512   4096  1048576   2365374     6243                0            6243              0             N  DATA_CF/
MOUNTED  EXTERN  N         512   4096  1048576    420862   420702                0          420702              0             N  TESTE/
ASMCMD> cd teste
ASMCMD> ls
ACCFP0/
ASMCMD> cd accfp0
ASMCMD> ll
ASMCMD> ls
CONTROLFILE/
ASMCMD> cd controlfile
ASMCMD> ls
Backup.256.987333545
ASMCMD>
ASMCMD>
ASMCMD> exit
SQL> drop diskgroup teste including contents;

Diskgroup dropped.

SQL> ALTER DISKGROUP DATA_CF ADD DISK 'ORCL:DATA_CF_12','ORCL:DATA_CF_13';

Diskgroup altered.

SQL> SET LINES 300 PAGES 100
SQL> COL PATH FOR A30
SQL> select GROUP_NUMBER,DISK_NUMBER,MOUNT_STATUS,TOTAL_MB,PATH,MOUNT_STATUS from v$asm_disk;

GROUP_NUMBER DISK_NUMBER MOUNT_S   TOTAL_MB PATH                           MOUNT_S
------------ ----------- ------- ---------- ------------------------------ -------
           1           0 CACHED      215034 ORCL:ARCH_CF_01                CACHED
           1           1 CACHED      220156 ORCL:ARCH_CF_02                CACHED
           2           0 CACHED      215034 ORCL:DATA_CF_01                CACHED
           2           1 CACHED      215034 ORCL:DATA_CF_02                CACHED
           2           2 CACHED      215034 ORCL:DATA_CF_03                CACHED
           2           3 CACHED      215034 ORCL:DATA_CF_04                CACHED
           2           4 CACHED      215034 ORCL:DATA_CF_05                CACHED
           2           5 CACHED      215034 ORCL:DATA_CF_06                CACHED
           2           6 CACHED      215034 ORCL:DATA_CF_07                CACHED
           2           7 CACHED      215034 ORCL:DATA_CF_08                CACHED
           2           8 CACHED      215034 ORCL:DATA_CF_09                CACHED
           2           9 CACHED      215034 ORCL:DATA_CF_10                CACHED
           2          10 CACHED      215034 ORCL:DATA_CF_11                CACHED
           2          11 CACHED      205823 ORCL:DATA_CF_12                CACHED
           2          12 CACHED      215039 ORCL:DATA_CF_13                CACHED

15 rows selected.

SQL>
SQL> select * from v$asm_operation;

GROUP_NUMBER OPERA STAT      POWER     ACTUAL      SOFAR   EST_WORK   EST_RATE EST_MINUTES ERROR_CODE
------------ ----- ---- ---------- ---------- ---------- ---------- ---------- ----------- --------------------------------------------
           2 REBAL RUN           1          1       2441     450153       2413         185

SQL>
ALTER DISKGROUP DATA_CF REBALANCE POWER 8;
