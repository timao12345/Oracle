dgmgrl
connect sys
db2006ban

show configuration verbose;
show database nome;

PRÉ REQUISITOS

--------------------
Before you install or deinstall the patch, ensure that you meet the following requirements:

Note: In case of an Oracle RAC environment, meet these prerequisites on each of the nodes.

--1.	Garantir a  Release 11.2.0.4.0.
 
--2.	Opatch  OPatch Version: 11.2.0.3.6
 
--4.	export ORACLE_HOME=/u01/app/11.2.0/grid


--5.	[root@cgdoradbstby grid]# echo $PATH
	-- /usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/opt/CA/SharedComponents/bin:/opt/CA/SharedComponents/ccs/cam/bin:/opt/CA/SharedComponents/SystemsPerformanceLiteAgent/bin:/root/bin


/*6.	[grid@cgdoradbstby OPatch]$ ./opatch lsinventory
	Oracle Interim Patch Installer version 11.2.0.3.6
	Copyright (c) 2013, Oracle Corporation.  All rights reserved.
	Oracle Home       : /u01/app/11.2.0/grid
	Central Inventory : /u01/app/oraInventory
        from           : /u01/app/11.2.0/grid/oraInst.loc
	OPatch version    : 11.2.0.3.6
	OUI version       : 11.2.0.4.0
	Log file location : /u01/app/11.2.0/grid/cfgtoollogs/opatch/opatch2014-10-29_16-34-47PM_1.log
	Lsinventory Output file location : /u01/app/11.2.0/grid/cfgtoollogs/opatch/lsinv/lsinventory2014-10-29_16-34-47PM.txt

	--------------------------------------------------------------------------------
	Installed Top-level Products (1):
	Oracle Grid Infrastructure 11g                                       11.2.0.4.0
	There are 1 product(s) installed in this Oracle Home.
	There are no Interim patches installed in this Oracle Home.
	--------------------------------------------------------------------------------*/



--7.	(Only for Installation) Maintain a location for storing the contents of the patch ZIP file. In the rest of the document, this location (absolute path) is referred to as <PATCH_TOP_DIR>. Extract the contents of the patch ZIP file to the location (PATCH_TOP_DIR) you have created above. To do so, run the following command:
	--$ unzip -d <PATCH_TOP_DIR> p18317531_112040_Linux-x86-64.zip 


--8.	cd /home/grid/18317531
       -- $ORACLE_HOME/OPatch/opatch prereq CheckConflictAgainstOHWithDetail -ph ./
	
	[grid@cgdoradbstby 18317531]$ $ORACLE_HOME/OPatch/opatch prereq CheckConflictAgainstOHWithDetail -ph ./
	Oracle Interim Patch Installer version 11.2.0.3.6
	Copyright (c) 2013, Oracle Corporation.  All rights reserved.
	PREREQ session
	Oracle Home       : /u01/app/11.2.0/grid
	Central Inventory : /u01/app/oraInventory
	from           : /u01/app/11.2.0/grid/oraInst.loc
	OPatch version    : 11.2.0.3.6
	OUI version       : 11.2.0.4.0
	Log file location : /u01/app/11.2.0/grid/cfgtoollogs/opatch/opatch2014-10-29_16-39-21PM_1.log
	Invoking prereq "checkconflictagainstohwithdetail"
	Prereq "checkConflictAgainstOHWithDetail" passed.
	OPatch succeeded.




--9.	Ensure that you shut down all the services running from the Oracle home of Oracle Database home.

[grid@cgdoradbstby 18317531]$ crs_stat -t
Name           Type           Target    State     Host
------------------------------------------------------------
ora.DATA.dg    ora....up.type OFFLINE   OFFLINE
ora....ER.lsnr ora....er.type ONLINE    ONLINE    cgdo...stby
ora.ORADATA.dg ora....up.type ONLINE    ONLINE    cgdo...stby
ora.ORAFRA.dg  ora....up.type ONLINE    ONLINE    cgdo...stby
ora.asm        ora.asm.type   ONLINE    ONLINE    cgdo...stby
ora.cssd       ora.cssd.type  ONLINE    ONLINE    cgdo...stby
ora.diskmon    ora....on.type OFFLINE   OFFLINE
ora.evmd       ora.evm.type   ONLINE    ONLINE    cgdo...stby
ora.ons        ora.ons.type   OFFLINE   OFFLINE

[grid@cgdoradbstby 18317531]$ ps -ef |grep tns
grid     11468     1  0 Oct25 ?        00:00:20$ORACLE_HOME/bin/srvctl stop home -o <ORACLE_HOME>/bin/tnslsnr LISTENER -inherit
grid     13555 13029  0 16:41 pts/1    00:00:00 grep tns

[grid@cgdoradbstby 18317531]$ ps -ef |grep pmon
grid     11722     1  0 Oct25 ?        00:00:05 asm_pmon_+ASM
grid     13566 13029  0 16:41 pts/1    00:00:00 grep pmon
oracle   20690     1  0 Oct26 ?        00:00:05 ora_pmon_STANDBYDB

su - oracle
export ORACLE_SID=STANDBYDB
sqlplus / as sysdba
shutdown immediate;

su - grid
$ORACLE_HOME/bin/srvctl stop home -o /u01/app/11.2.0/grid -s /home/grid/status.log


	
--10.	Run the pre-root script as a root user from the Oracle home of Oracle Grid Infrastructure:
su - root
$<ORACLE_HOME>/crs/install/roothas.pl -unlock 


***************************************************************************************************
INSTALA��O

II) Installation
-----------------
To install the patch, follow these steps:
1. 	su - grid 
	cd /home/grid/18317531
	opatch apply

2.	$ORACLE_HOME/OPatch/opatch lsinventory

3.	su - root
	$ORACLE_HOME/crs/install/roothas.pl -patch 


4.	su -grid
	$ORACLE_HOME/bin/srvctl start home -o /u01/app/11.2.0/grid -s /home/grid/status.log
	su - oracle
	export ORACLE_SID=STANDBYDB
	sqlplus / as sysdba
	startup
		
	




