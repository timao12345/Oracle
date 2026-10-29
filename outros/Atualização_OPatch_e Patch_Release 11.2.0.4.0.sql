CGD Investimentos (CGDORADB03 e CGDORADB04

Links
https://updates.oracle.com/Orion/Services/download?type=readme&aru=17600853
https://support.oracle.com/epmos/faces/DocumentDisplay?_afrLoop=240508941972400&id=224346.1&_afrWindowMode=0&_adf.ctrl-state=5iz99379v_4
https://support.oracle.com/epmos/faces/DocumentDisplay?_afrLoop=240520201465808&id=244241.1&_afrWindowMode=0&_adf.ctrl-state=5iz99379v_54




Versão Antiga OPatch:

[grid@cgdoradb03 OPatch]$ ./opatch lsinventory
Oracle Interim Patch Installer version 11.2.0.3.4
Copyright (c) 2012, Oracle Corporation.  All rights reserved.


Oracle Home       : /u01/app/11.2.0/grid
Central Inventory : /u01/app/oraInventory
   from           : /u01/app/11.2.0/grid/oraInst.loc
OPatch version    : 11.2.0.3.4
OUI version       : 11.2.0.4.0
Log file location : /u01/app/11.2.0/grid/cfgtoollogs/opatch/opatch2014-11-17_16-31-57PM_1.log

Lsinventory Output file location : /u01/app/11.2.0/grid/cfgtoollogs/opatch/lsinv/lsinventory2014-11-17_16-31-57PM.txt

--------------------------------------------------------------------------------
Installed Top-level Products (1):

Oracle Grid Infrastructure 11g                                       11.2.0.4.0
There are 1 products installed in this Oracle Home.


There are no Interim patches installed in this Oracle Home.


Rac system comprising of multiple nodes
  Local node = cgdoradb03
  Remote node = cgdoradb04

--------------------------------------------------------------------------------
OPatch succeeded.


[grid@cgdoradb04 OPatch]$ ./opatch lsinventory
Oracle Interim Patch Installer version 11.2.0.3.4
Copyright (c) 2012, Oracle Corporation.  All rights reserved.


Oracle Home       : /u01/app/11.2.0/grid
Central Inventory : /u01/app/oraInventory
   from           : /u01/app/11.2.0/grid/oraInst.loc
OPatch version    : 11.2.0.3.4
OUI version       : 11.2.0.4.0
Log file location : /u01/app/11.2.0/grid/cfgtoollogs/opatch/opatch2014-11-17_16-37-06PM_1.log

Lsinventory Output file location : /u01/app/11.2.0/grid/cfgtoollogs/opatch/lsinv/lsinventory2014-11-17_16-37-06PM.txt

--------------------------------------------------------------------------------
Installed Top-level Products (1):

Oracle Grid Infrastructure 11g                                       11.2.0.4.0
There are 1 products installed in this Oracle Home.


There are no Interim patches installed in this Oracle Home.


Rac system comprising of multiple nodes
  Local node = cgdoradb04
  Remote node = cgdoradb03

--------------------------------------------------------------------------------
OPatch succeeded.


##########################################################################################################################


Backup OPatch

[root@cgdoradb03 grid]# cp -r OPatch OPatch_bkp_1711
[root@cgdoradb03 grid]# ls OPa*
OPatch:
crs  docs  emdpatch.pl  jlib  ocm  opatch  opatch.bat  opatchdiag  opatchdiag.bat  opatch.ini  opatch.pl  opatchprereqs  oplan

OPatch_bkp_1711:
crs  docs  emdpatch.pl  jlib  ocm  opatch  opatch.bat  opatchdiag  opatchdiag.bat  opatch.ini  opatch.pl  opatchprereqs  oplan


[root@cgdoradb04 grid]# ls OPa*
OPatch:
crs  docs  emdpatch.pl  jlib  ocm  opatch  opatch.bat  opatchdiag  opatchdiag.bat  opatch.ini  opatch.pl  opatchprereqs  oplan

OPatch_bkp_1711:


##########################################################################################################################

  
Note: In case of an Oracle RAC environment, meet these prerequisites on each of the nodes.

Ok
1.	Ensure that the Oracle home on which you are installing the patch or from which you are rolling back the patch is Oracle Database 11g Release 11.2.0.4.0.

Ok
2.	Oracle recommends you to use the latest version available for 11g Release 11.2.0.4.0. If you do not have OPatch 11g Release 11.2.0.4.0, then download it from patch# 6880880 for 11.2.0.4.0 release.

	For information about OPatch documentation, including any known issues, see My Oracle Support Document 293369.1 OPatch documentation list:
	https://support.oracle.com/CSP/main/article?cmd=show&type=NOT&id=224346.1

Ok (Usuário é Grid)
4.	Ensure that you set (as the home user) the ORACLE_HOME environment variable to the Oracle home.

Ok
5.	Ensure that the $PATH definition has the following executables: make, ar, ld and nm. The location of these executables depends on your operating system. On many operating systems, they are located in /usr/ccs/bin.
PATH=/u01/app/11.2.0/grid/bin:/usr/sbin:/usr/local/bin:/bin:/usr/bin:/opt/CA/SharedComponents/bin:/opt/CA/SharedComponents/ccs/cam/bin:/opt/CA/SharedComponents/SystemsPerformanceLiteAgent/bin
CA_CAILANGUAGE=enu


Ok
6.	Ensure that you verify the Oracle Inventory because OPatch accesses it to install the patches. To verify the inventory, run the following command. 
	$ opatch lsinventory 


Ok
8.	(Only for Installation) Determine whether any currently installed interim patches conflict with this patch 18317531 as shown below:
	$ cd <PATCH_TOP_DIR>/18317531
	$ opatch prereq CheckConflictAgainstOHWithDetail -ph ./


[grid@cgdoradb03 18317531]$ $ORACLE_HOME/OPatch/opatch prereq CheckConflictAgainstOHWithDetail -ph ./
Oracle Interim Patch Installer version 11.2.0.3.6
Copyright (c) 2013, Oracle Corporation.  All rights reserved.

PREREQ session

Oracle Home       : /u01/app/11.2.0/grid
Central Inventory : /u01/app/oraInventory
   from           : /u01/app/11.2.0/grid/oraInst.loc
OPatch version    : 11.2.0.3.6
OUI version       : 11.2.0.4.0
Log file location : /u01/app/11.2.0/grid/cfgtoollogs/opatch/opatch2014-11-17_16-52-21PM_1.log

Invoking prereq "checkconflictagainstohwithdetail"

Prereq "checkConflictAgainstOHWithDetail" passed.
OPatch succeeded.

[grid@cgdoradb04 18317531]$ $ORACLE_HOME/OPatch/opatch prereq CheckConflictAgainstOHWithDetail -ph ./
Oracle Interim Patch Installer version 11.2.0.3.6
Copyright (c) 2013, Oracle Corporation.  All rights reserved.

PREREQ session

Oracle Home       : /u01/app/11.2.0/grid
Central Inventory : /u01/app/oraInventory
   from           : /u01/app/11.2.0/grid/oraInst.loc
OPatch version    : 11.2.0.3.6
OUI version       : 11.2.0.4.0
Log file location : /u01/app/11.2.0/grid/cfgtoollogs/opatch/opatch2014-11-17_16-54-16PM_1.log

Invoking prereq "checkconflictagainstohwithdetail"

Prereq "checkConflictAgainstOHWithDetail" passed.
OPatch succeeded.
	

	
##########################################################################################################################
	
	
	Pasta dos Instaladores:

[root@cgdoradb03 dcadmin]# cd /backup
[root@cgdoradb03 backup]# mkdir patch
[root@cgdoradb03 backup]# chown grid:asmdba /backup/pa
[root@cgdoradb03 backup]# chown grid:asmdba /backup/patch/
[root@cgdoradb03 backup]# chmod 777 /backup/patch/
[root@cgdoradb03 backup]# cd /home/dcadmin/
[root@cgdoradb03 dcadmin]# cp p6880880_112000_Linux-x86-64.zip /backup/patch/
[root@cgdoradb03 dcadmin]# cd /backup/patch/
[root@cgdoradb03 patch]# chown grid:asmdba p6880880_112000_Linux-x86-64.zip
[root@cgdoradb03 patch]# chmod 777 p6880880_112000_Linux-x86-64.zip


##########################################################################################################################

Modelo atualização de OPtach

cd $ORACLE_HOME
mv OPatch OPatch.bkp
unzip <download directory>/p6880880_<version>_<platform>.zip
cd OPatch
./opatch version
export PATH=$ORACLE_HOME/OPatch:$PATH
  
unzip /backup/patch/p6880880_112000_Linux-x86-64.zip -d /u01/app/11.2.0/grid


##########################################################################################################################

OPtach node cgdoradb03 atualizado

[grid@cgdoradb03 grid]$ unzip /backup/patch/p6880880_112000_Linux-x86-64.zip -d /u01/app/11.2.0/grid
Archive:  /backup/patch/p6880880_112000_Linux-x86-64.zip
replace /u01/app/11.2.0/grid/OPatch/jlib/oracle.opatch.classpath.jar? [y]es, [n]o, [A]ll, [N]one, [r]ename: A
  inflating: /u01/app/11.2.0/grid/OPatch/jlib/oracle.opatch.classpath.jar
  inflating: /u01/app/11.2.0/grid/OPatch/jlib/oracle.opatch.classpath.windows.jar
  inflating: /u01/app/11.2.0/grid/OPatch/jlib/opatch.jar
  inflating: /u01/app/11.2.0/grid/OPatch/jlib/fa/oracle.opatch.fa.classpath.windows.jar
  inflating: /u01/app/11.2.0/grid/OPatch/jlib/fa/oracle.opatch.fa.classpath.unix.jar
  inflating: /u01/app/11.2.0/grid/OPatch/jlib/fa/oracle.opatch.fa.classpath.jar
  inflating: /u01/app/11.2.0/grid/OPatch/jlib/opatchsdk.jar
  inflating: /u01/app/11.2.0/grid/OPatch/jlib/oracle.opatch.classpath.unix.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/oplan.bat
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/oplan.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/osysmodel-utils.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/patchsdk.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/JMXDrivers.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/Validation.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/bundle.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/oracle.oplan.classpath.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/OuiDriver.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/automation.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/jaxb/jaxb-impl.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/jaxb/activation.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/jaxb/jaxb-api.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/jaxb/jsr173_1.0_api.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/EMrepoDrivers.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/CRSProductDriver.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/ValidationRules.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/apache-commons/commons-cli-1.0.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/OsysModel.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/oplan
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/README.txt
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/README.html
  inflating: /u01/app/11.2.0/grid/OPatch/opatchprereqs/prerequisite.properties
  inflating: /u01/app/11.2.0/grid/OPatch/opatchprereqs/opatch/opatch_prereq.xml
  inflating: /u01/app/11.2.0/grid/OPatch/opatchprereqs/opatch/runtime_prereq.xml
  inflating: /u01/app/11.2.0/grid/OPatch/opatchprereqs/opatch/rulemap.xml
  inflating: /u01/app/11.2.0/grid/OPatch/opatchprereqs/oui/knowledgesrc.xml
  inflating: /u01/app/11.2.0/grid/OPatch/emdpatch.pl
  inflating: /u01/app/11.2.0/grid/OPatch/opatch.pl
  inflating: /u01/app/11.2.0/grid/OPatch/opatch
  inflating: /u01/app/11.2.0/grid/OPatch/opatch.bat
  inflating: /u01/app/11.2.0/grid/OPatch/README.txt
  inflating: /u01/app/11.2.0/grid/OPatch/docs/Prereq_Users_Guide.txt
  inflating: /u01/app/11.2.0/grid/OPatch/docs/Users_Guide.txt
  inflating: /u01/app/11.2.0/grid/OPatch/docs/FAQ
  inflating: /u01/app/11.2.0/grid/OPatch/crs/patch11203.pl
  inflating: /u01/app/11.2.0/grid/OPatch/crs/patch11202.pl
  inflating: /u01/app/11.2.0/grid/OPatch/crs/auto_patch.pl
  inflating: /u01/app/11.2.0/grid/OPatch/crs/patch112.pl
  inflating: /u01/app/11.2.0/grid/OPatch/crs/installPatch.excl
  inflating: /u01/app/11.2.0/grid/OPatch/opatchdiag.bat
  inflating: /u01/app/11.2.0/grid/OPatch/ocm/ocm_platforms.txt
 extracting: /u01/app/11.2.0/grid/OPatch/ocm/ocm.zip
  inflating: /u01/app/11.2.0/grid/OPatch/ocm/lib/emocmclnt.jar
  inflating: /u01/app/11.2.0/grid/OPatch/ocm/lib/emocmclnt-14.jar
  inflating: /u01/app/11.2.0/grid/OPatch/ocm/lib/http_client.jar
  inflating: /u01/app/11.2.0/grid/OPatch/ocm/lib/osdt_jce.jar
  inflating: /u01/app/11.2.0/grid/OPatch/ocm/lib/jnet.jar
  inflating: /u01/app/11.2.0/grid/OPatch/ocm/lib/emocmcommon.jar
  inflating: /u01/app/11.2.0/grid/OPatch/ocm/lib/xmlparserv2.jar
  inflating: /u01/app/11.2.0/grid/OPatch/ocm/lib/log4j-core.jar
  inflating: /u01/app/11.2.0/grid/OPatch/ocm/lib/jcert.jar
  inflating: /u01/app/11.2.0/grid/OPatch/ocm/lib/jsse.jar
  inflating: /u01/app/11.2.0/grid/OPatch/ocm/lib/osdt_core3.jar
  inflating: /u01/app/11.2.0/grid/OPatch/ocm/lib/regexp.jar
  inflating: /u01/app/11.2.0/grid/OPatch/ocm/bin/emocmrsp
 extracting: /u01/app/11.2.0/grid/OPatch/version.txt
  inflating: /u01/app/11.2.0/grid/OPatch/opatch.ini
  inflating: /u01/app/11.2.0/grid/OPatch/opatchdiag
[grid@cgdoradb03 grid]$ ./opatch lsinventory
-bash: ./opatch: No such file or directory
[grid@cgdoradb03 grid]$ cd OPatch
[grid@cgdoradb03 OPatch]$ ./opatch lsinventory
Oracle Interim Patch Installer version 11.2.0.3.6
Copyright (c) 2013, Oracle Corporation.  All rights reserved.


Oracle Home       : /u01/app/11.2.0/grid
Central Inventory : /u01/app/oraInventory
   from           : /u01/app/11.2.0/grid/oraInst.loc
OPatch version    : 11.2.0.3.6
OUI version       : 11.2.0.4.0
Log file location : /u01/app/11.2.0/grid/cfgtoollogs/opatch/opatch2014-11-17_16-42-14PM_1.log

Lsinventory Output file location : /u01/app/11.2.0/grid/cfgtoollogs/opatch/lsinv/lsinventory2014-11-17_16-42-14PM.txt

--------------------------------------------------------------------------------
Installed Top-level Products (1):

Oracle Grid Infrastructure 11g                                       11.2.0.4.0
There are 1 product(s) installed in this Oracle Home.


There are no Interim patches installed in this Oracle Home.


Rac system comprising of multiple nodes
  Local node = cgdoradb03
  Remote node = cgdoradb04

--------------------------------------------------------------------------------
OPatch succeeded.


##########################################################################################################################

OPtach node cgdoradb03 atualizado

[grid@cgdoradb04 OPatch]$ unzip /backup/patch/p6880880_112000_Linux-x86-64.zip -d /u01/app/11.2.0/grid
Archive:  /backup/patch/p6880880_112000_Linux-x86-64.zip
replace /u01/app/11.2.0/grid/OPatch/jlib/oracle.opatch.classpath.jar? [y]es, [n]o, [A]ll, [N]one, [r]ename: A
  inflating: /u01/app/11.2.0/grid/OPatch/jlib/oracle.opatch.classpath.jar
  inflating: /u01/app/11.2.0/grid/OPatch/jlib/oracle.opatch.classpath.windows.jar
  inflating: /u01/app/11.2.0/grid/OPatch/jlib/opatch.jar
  inflating: /u01/app/11.2.0/grid/OPatch/jlib/fa/oracle.opatch.fa.classpath.windows.jar
  inflating: /u01/app/11.2.0/grid/OPatch/jlib/fa/oracle.opatch.fa.classpath.unix.jar
  inflating: /u01/app/11.2.0/grid/OPatch/jlib/fa/oracle.opatch.fa.classpath.jar
  inflating: /u01/app/11.2.0/grid/OPatch/jlib/opatchsdk.jar
  inflating: /u01/app/11.2.0/grid/OPatch/jlib/oracle.opatch.classpath.unix.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/oplan.bat
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/oplan.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/osysmodel-utils.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/patchsdk.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/JMXDrivers.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/Validation.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/bundle.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/oracle.oplan.classpath.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/OuiDriver.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/automation.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/jaxb/jaxb-impl.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/jaxb/activation.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/jaxb/jaxb-api.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/jaxb/jsr173_1.0_api.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/EMrepoDrivers.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/CRSProductDriver.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/ValidationRules.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/apache-commons/commons-cli-1.0.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/jlib/OsysModel.jar
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/oplan
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/README.txt
  inflating: /u01/app/11.2.0/grid/OPatch/oplan/README.html
  inflating: /u01/app/11.2.0/grid/OPatch/opatchprereqs/prerequisite.properties
  inflating: /u01/app/11.2.0/grid/OPatch/opatchprereqs/opatch/opatch_prereq.xml
  inflating: /u01/app/11.2.0/grid/OPatch/opatchprereqs/opatch/runtime_prereq.xml
  inflating: /u01/app/11.2.0/grid/OPatch/opatchprereqs/opatch/rulemap.xml
  inflating: /u01/app/11.2.0/grid/OPatch/opatchprereqs/oui/knowledgesrc.xml
  inflating: /u01/app/11.2.0/grid/OPatch/emdpatch.pl
  inflating: /u01/app/11.2.0/grid/OPatch/opatch.pl
  inflating: /u01/app/11.2.0/grid/OPatch/opatch
  inflating: /u01/app/11.2.0/grid/OPatch/opatch.bat
  inflating: /u01/app/11.2.0/grid/OPatch/README.txt
  inflating: /u01/app/11.2.0/grid/OPatch/docs/Prereq_Users_Guide.txt
  inflating: /u01/app/11.2.0/grid/OPatch/docs/Users_Guide.txt
  inflating: /u01/app/11.2.0/grid/OPatch/docs/FAQ
  inflating: /u01/app/11.2.0/grid/OPatch/crs/patch11203.pl
  inflating: /u01/app/11.2.0/grid/OPatch/crs/patch11202.pl
  inflating: /u01/app/11.2.0/grid/OPatch/crs/auto_patch.pl
  inflating: /u01/app/11.2.0/grid/OPatch/crs/patch112.pl
  inflating: /u01/app/11.2.0/grid/OPatch/crs/installPatch.excl
  inflating: /u01/app/11.2.0/grid/OPatch/opatchdiag.bat
  inflating: /u01/app/11.2.0/grid/OPatch/ocm/ocm_platforms.txt
 extracting: /u01/app/11.2.0/grid/OPatch/ocm/ocm.zip
  inflating: /u01/app/11.2.0/grid/OPatch/ocm/lib/emocmclnt.jar
  inflating: /u01/app/11.2.0/grid/OPatch/ocm/lib/emocmclnt-14.jar
  inflating: /u01/app/11.2.0/grid/OPatch/ocm/lib/http_client.jar
  inflating: /u01/app/11.2.0/grid/OPatch/ocm/lib/osdt_jce.jar
  inflating: /u01/app/11.2.0/grid/OPatch/ocm/lib/jnet.jar
  inflating: /u01/app/11.2.0/grid/OPatch/ocm/lib/emocmcommon.jar
  inflating: /u01/app/11.2.0/grid/OPatch/ocm/lib/xmlparserv2.jar
  inflating: /u01/app/11.2.0/grid/OPatch/ocm/lib/log4j-core.jar
  inflating: /u01/app/11.2.0/grid/OPatch/ocm/lib/jcert.jar
  inflating: /u01/app/11.2.0/grid/OPatch/ocm/lib/jsse.jar
  inflating: /u01/app/11.2.0/grid/OPatch/ocm/lib/osdt_core3.jar
  inflating: /u01/app/11.2.0/grid/OPatch/ocm/lib/regexp.jar
  inflating: /u01/app/11.2.0/grid/OPatch/ocm/bin/emocmrsp
 extracting: /u01/app/11.2.0/grid/OPatch/version.txt
  inflating: /u01/app/11.2.0/grid/OPatch/opatch.ini
  inflating: /u01/app/11.2.0/grid/OPatch/opatchdiag
[grid@cgdoradb04 OPatch]$ ./opatch lsinventory
Oracle Interim Patch Installer version 11.2.0.3.6
Copyright (c) 2013, Oracle Corporation.  All rights reserved.


Oracle Home       : /u01/app/11.2.0/grid
Central Inventory : /u01/app/oraInventory
   from           : /u01/app/11.2.0/grid/oraInst.loc
OPatch version    : 11.2.0.3.6
OUI version       : 11.2.0.4.0
Log file location : /u01/app/11.2.0/grid/cfgtoollogs/opatch/opatch2014-11-17_16-44-33PM_1.log

Lsinventory Output file location : /u01/app/11.2.0/grid/cfgtoollogs/opatch/lsinv/lsinventory2014-11-17_16-44-33PM.txt

--------------------------------------------------------------------------------
Installed Top-level Products (1):

Oracle Grid Infrastructure 11g                                       11.2.0.4.0
There are 1 product(s) installed in this Oracle Home.


There are no Interim patches installed in this Oracle Home.


Rac system comprising of multiple nodes
  Local node = cgdoradb04
  Remote node = cgdoradb03

--------------------------------------------------------------------------------
OPatch succeeded.

  
  
##########################################################################################################################

Minimum downtime

. Shutdown the Oracle instance on node 1 
. Apply the patch to the RAC home on node 1 
. Shutdown the Oracle instance on node 2 
. Apply the patch to the RAC home on node 2 
. Shutdown the Oracle instance on node 3 
. At this point, instances on nodes 1 and 2 can be brought up
. Apply the patch to the RAC home on node 3 
. Startup the Oracle instance on node 3
  
#########################################################################################################################

  
9.	Ensure that you shut down all the services running from the Oracle home of Oracle Database home.
If you are applying this patch to a database home, then shut down the services from the Oracle home of the database in the usual way. 
You do not have to use the srvctl command in that case.

Stopping services from Database home in Clustered Environments (Run as the database home owner)

su - grid
grid@cgdoradb03 ~]$ crs_stat -t -v -c cgdoradb03
grid@cgdoradb03 ~]$ crs_stat -t -v -c cgdoradb04 

su - grid
$ $ORACLE_HOME/bin/srvctl stop instance -d BANIF -i banif3
$ $ORACLE_HOME/bin/srvctl stop nodeapps -n cgdoradb03
$ $ORACLE_HOME/bin/srvctl stop asm -n cgdoradb03
$ $ORACLE_HOME/bin/srvctl stop Listener -n cgdoradb03
$ $ORACLE_HOME/bin/srvctl status service -s AGENDAHB1 -d BANIF
$ $ORACLE_HOME/bin/srvctl status service -s AGENDAHB -d BANIF

su - grid
$ $ORACLE_HOME/bin/srvctl stop instance -d BANIF -i banif4
$ $ORACLE_HOME/bin/srvctl stop nodeapps -n cgdoradb04
$ $ORACLE_HOME/bin/srvctl stop asm -n cgdoradb04
$ $ORACLE_HOME/bin/srvctl stop Listener -n cgdoradb04
$ $ORACLE_HOME/bin/srvctl status service -s AGENDAHB1 -d BANIF
$ $ORACLE_HOME/bin/srvctl status service -s AGENDAHB -d BANIF



$ $ORACLE_HOME/bin/crsctl stop crs


Run as root
10.	Run the pre-root script as a root user from the Oracle home of Oracle Grid Infrastructure:

--->>>diferente

Running the Script for Grid Infrastructure Home in Clustered Environments (Run as root)
$<ORACLE_HOME>/crs/install/rootcrs.pl -unlock   



INSTALAÇÃO

II) Installation
-----------------
To install the patch, follow these steps:
1. 	su - grid 
	cd /backup/patch/18317531	/u01/app/11.2.0/grid/OPatch/opatch apply

2.	$ORACLE_HOME/OPatch/opatch lsinventory

--->>>diferente
3.	su - root
	$ORACLE_HOME/crs/install/rootcrs.pl -patch  


4.	su - root
	/u01/app/11.2.0/grid/bin/crsctl start crs
	



(III) Deinstallation
--------------------
Ensure to follow the Prerequsites (Section I). To deinstall the patch, follow these steps:

1.	Deinstall the patch by running the following command from the Oracle home for which you are deinstalling the patch to either Oracle Grid Infrastructure or Oracle Database home::
	
	$ opatch rollback -id 18317531

2.	Run the post script as a root user from the Oracle home of Oracle Grid Infrastructure:

	-	Running the script for Grid Infrastructure home in Clustered Environments (Run as root)
		# $ORACLE_HOME/crs/install/rootcrs.pl -patch 

	-	Running the script for Grid Infrastructure home on Standalone Servers or Non-Clustered Environments (Run as root)
		# $ORACLE_HOME/crs/install/roothas.pl -patch 

	Note: If you are rolling back the patch from a Database home, then skip this step.

3.	Restart all the services from the Oracle home.

	-	Restarting services from Database home in Clustered Environments (Run as the database home owner)
		$ $ORACLE_HOME/bin/srvctl start instance -d <db_unique_name> -n <node_name>

	-	Restarting services from Database home in Standalone Servers or Non-Clustered Environments (Run as the database home owner)
		$ $ORACLE_HOME/bin/srvctl start home -o <ORACLE_HOME> -s <STAT_FILE_LOCATION>
	
	<STAT_FILE_LOCATION> refers to the absolute path leading up to the file name of the STAT_FILE that was created when you stopped the services.

	Note:
	-	If you rolled back the patch to a database home, then start the services from the Oracle home of the database in the usual way. You do not have to use the srvctl command in that case.
	-	If the Oracle Database was installed with an operating system user account that is different from the user account used for installing the Oracle ASM, then run srvctl as the database home user 
	(RDBMS home user) to start the database instance on each node:
	$ $ORACLE_HOME>/bin/srvctl start instance -d <db_unique_name> -n <node_name>


4.	Ensure that you verify the Oracle Inventory and compare the output with the one run before the patch installation and re-apply any patches that were rolled back as part of this patch apply. To verify the inventory, run the following command:

	$ opatch lsinventory	