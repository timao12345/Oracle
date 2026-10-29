####AFD


$su -
# export ORACLE_HOME=/u01/app/19.0.0.0/grid
# export ORACLE_BASE=/u01/app

# Provision Disks Using ASMCMD
    cd $ORACLE_HOME/bin
    ./asmcmd afd_label DISK01 /dev/sdb1 --init
    ./asmcmd afd_label DISK02 /dev/sdc1 --init
    ./asmcmd afd_label DISK03 /dev/sdd1 --init
    ./asmcmd afd_label DISK04 /dev/sde1 --init
	

. Verify
    ./asmcmd afd_lslbl '/dev/sd*'
    Label   Duplicate  Path
    ===========================
    DISK01             /dev/sdb
    DISK02             /dev/sdc
    DISK03             /dev/sdd
    DISK04             /dev/sde


ls -alrt /dev/oracleafd/disks/*

    -rwxrwx--- 1 grid oinstall 22 Mar 27 10:44 /dev/oracleafd/disks/DISK01
    -rwxrwx--- 1 grid oinstall 22 Mar 27 10:44 /dev/oracleafd/disks/DISK02
    -rwxrwx--- 1 grid oinstall 22 Mar 27 10:44 /dev/oracleafd/disks/DISK03
    -rwxrwx--- 1 grid oinstall 22 Mar 27 10:44 /dev/oracleafd/disks/DISK04


# Status


ls -alrt /dev/oracleafd/disks/*
  -rwxrwx--- 1 grid oinstall 22 Mar 27 10:44 /dev/oracleafd/disks/DISK01
  -rwxrwx--- 1 grid oinstall 22 Mar 27 10:44 /dev/oracleafd/disks/DISK02
  -rwxrwx--- 1 grid oinstall 22 Mar 27 10:44 /dev/oracleafd/disks/DISK03


 ORACLE_HOME/bin/asmcmd afd_lslbl '/dev/sd*'
   Label   Duplicate  Path
   ===========================
   DISK01             /dev/sdb
   DISK02             /dev/sdc
   DISK03             /dev/sdd  
   
$ORACLE_HOME/bin/asmcmd afd_state



##Unlabel (if needed)
cd $ORACLE_HOME/bin
./asmcmd help afd_unlabel

./asmcmd afd_unlabel DISK01 -f --init
./asmcmd afd_unlabel '/dev/sdb' -f --init

./asmcmd afd_lslbl '/dev/sd*'
ls -alrt /dev/oracleafd/disks/*

Then to relabel it use this form (as it is already initialized):
./asmcmd afd_label DISK01 /dev/sdb   