Procedimento para reduzir ou excluir o 




Checking disk space on the ODA nodes, you see the /u01 partition is 66-67% full:


Observação: ( o valor do resize é medido em segundos, o exemplo a abaixo ira reter 3 dias 72 horas)


1.  As user grid in oda1 execute the following command:

[grid@oda1 ~]$ oclumon manage -repos resize 259200
oda1 --> retention check successful
oda2 --> retention check successful
New retention is 259200 and will use 4516300800 bytes of disk space

CRS-9115-Cluster Health Monitor repository size change completed on all nodes.



Verifica O tamanho do repositorio em segundos.

2.   After that resize, checking repository size will fail with the following error:

[grid@oda1 ~]$ oclumon manage -get repsize
CRS-9011-Error manage: Failed to initialize connection to the Cluster Logger Service


3.  Restart crf on both nodes to resolve the issue:

[grid@oda1 ~]$ crsctl stop res ora.crf -init
CRS-2673: Attempting to stop 'ora.crf' on 'oda1'
CRS-2677: Stop of 'ora.crf' on 'oda1' succeeded
[grid@oda1 ~]$ crsctl start res ora.crf -init 

[grid@oda2 oda2]$ crsctl stop res ora.crf -init
CRS-2673: Attempting to stop 'ora.crf' on 'oda2'
CRS-2677: Stop of 'ora.crf' on 'oda2' succeeded
[grid@oda2 ~]$ crsctl start res ora.crf -init



Check that the file is now smaller:

[grid@oda1 ~]$ cd /u01/app/11.2.0.3/grid/crf/db/oda1
[grid@oda1 oda1]$ ls -lrth
total 572K
-rw-r----- 1 root root 56K Jan 17 08:04 __db.006
-rw-r----- 1 root root 1.2M Jan 17 08:04 __db.005
-rw-r----- 1 root root 2.1M Jan 17 08:04 __db.004
-rw-r----- 1 root root 392K Jan 17 08:04 __db.002
-rw-r----- 1 root root 24K Jan 17 08:04 __db.001
-rw-r----- 1 root root 8.0K Jan 17 08:04 crfhosts.bdb
-rw-r----- 1 root root 8.0K Jan 17 08:04 crfconn.bdb
-rw-r----- 1 root root 128K Jan 17 08:04 crfclust.bdb   <<<<<<<<<<<
-rw-r----- 1 root root 16M Jan 17 08:04 log.0000000001
-rw-r----- 1 root root 2.6M Jan 17 08:04 __db.003
-rw-r----- 1 root root 8.0K Jan 17 08:04 crfts.bdb
-rw-r----- 1 root root 8.0K Jan 17 08:04 crfloclts.bdb
-rw-r----- 1 root root 8.0K Jan 17 08:04 crfcpu.bdb
-rw-r----- 1 root root 8.0K Jan 17 08:04 crfalert.bdb
-rw-r--r-- 1 root root 115M Jan 17 08:05 oda1.ldb



Se o filesystem não possuir espaço e necessitar excluir os com extenção .bdb, faça o procedimento abaixo


Oracle Cluster Health Monitor (CHM) using large amount of space (more than default) (Doc ID 1343105.1)

APPLIES TO:

Oracle Server - Enterprise Edition - Version 11.2.0.2 and later
Information in this document applies to any platform.


SYMPTOMS

Cluster Health Monitor (CHM) files in $GI_HOME/crf/db/<node name? directory are filling up disk space in GI_HOME. 

The bdb files in $GRID_HOME/crf/db/<node name> are larger than 1GB (default size) and filling up the GI_HOME file system.


CAUSE

Oracle Cluster Health Monitor (CHM) using large amount of space when it is collecting the OS statistics.

Check Cluster Health Monitor berkerley database files in $GI_HOME/crf/db/<node name> directory


SOLUTION

Remove those large Berkeley database files to free up space by doing the following as root:

$GI_HOME/bin/crsctl stop res ora.crf -init 
cd $GI_HOME/crf/db/<nodename> 
rm *.bdb 
$GI_HOME/bin/crsctl start res ora.crf -init

Please note that bdb files get regenerated when CHM (ora.crf) resource is restarted.  The files are owned by root, so only root can delete the bdb files.  Other than losing the OS statistics that CHM has gathered, deleting bdb files does not have other impact.  CHM will start collecting the OS statistics again.

Having very large bdb files (greater than 2GB) is likely due to a bug since the default size limits the bdb to 1GB unless the CHM data retention time is increased.  One such bug is 10165314.

Also, please note that the local bdb file (<hostname>.ldb) may need to be deleted as well. 














