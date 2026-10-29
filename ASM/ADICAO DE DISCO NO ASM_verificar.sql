Using username "ddomingues".
Access denied
Using keyboard-interactive authentication.
Password:
Last login: Thu Nov  9 15:56:18 2017 from 172.23.20.29
----------------------------------------------------------------------------
                                JUMPBOX TEMPLATE

Favor executarem os comandos abaixo:

Time de HW UOLCS:
user> sudo /sbin/UOLCloud_ini_config

Time de Implantacao UOLDIVEO:
user> sudo /sbin/UOLCloud_config

UOLCLOUD_INI -> Configuracao Inicial da Jumpbox (Rede, Hosts, Hostname, etc)

UOLCLOUD -> Configuracao da eth1 (IP, Mask e GW) do cliente

Em caso de duvidas, contate l-tec-cloud@uoldiveo.com
----------------------------------------------------------------------------
[ddomingues@tb-b5-vxtjump-ab10 ~]$ ssh dcadmin@10.10.35.2
The authenticity of host '10.10.35.2 (10.10.35.2)' can't be established.
RSA key fingerprint is 99:7d:a8:b8:d4:e7:26:aa:9d:af:5f:71:9e:d1:c0:52.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '10.10.35.2' (RSA) to the list of known hosts.
dcadmin@10.10.35.2's password:
Last login: Fri Sep 21 15:54:38 2018 from 10.10.36.254
----------------------------------------------------------------------------
ATENCAO: Aviso Importante, e proibido o acesso nao autorizado.
Esse e um recurso de acesso restrito devidamente controlado, monitorado e de
responsabilidade do Universo Online S/A.
Se voce nao possui autorizacao para acessar este recurso, desconecte
imediatamente ou podera sofrer sancoes legais e/ou acao disciplinar.

Em caso de problemas envie email para l-monitor-sec@uolinc.com
----------------------------------------------------------------------------
[dcadmin@UC-DB-SERVER01 ~]$
[dcadmin@UC-DB-SERVER01 ~]$
[dcadmin@UC-DB-SERVER01 ~]$
[dcadmin@UC-DB-SERVER01 ~]$ sudo su -
[sudo] password for dcadmin:
Sorry, user dcadmin is not allowed to execute '/bin/su -' as root on UC-DB-SERVER01.
[dcadmin@UC-DB-SERVER01 ~]$ su -
Password:
su: incorrect password
[dcadmin@UC-DB-SERVER01 ~]$ su -
Password:
[root@UC-DB-SERVER01 ~]#
[root@UC-DB-SERVER01 ~]#
[root@UC-DB-SERVER01 ~]#
[root@UC-DB-SERVER01 ~]#
[root@UC-DB-SERVER01 ~]#  for i in $(ls -1 /sys/class/scsi_host/); do echo '- - -' > /sys/class/scsi_host/$i/scan; done;
[root@UC-DB-SERVER01 ~]# for i in $(ls -1 /sys/class/fc_host/); do echo '1' /sys/class/fc_host/$i/issue_lip; done;
ls: cannot access /sys/class/fc_host/: No such file or directory
[root@UC-DB-SERVER01 ~]# vi /etc/multipath/bindings
[root@UC-DB-SERVER01 ~]# cd /etc/multipath/bindings
-bash: cd: /etc/multipath/bindings: No such file or directory
[root@UC-DB-SERVER01 ~]# cd /etc/multipath/
-bash: cd: /etc/multipath/: No such file or directory
[root@UC-DB-SERVER01 ~]# cd /dev/
Display all 196 possibilities? (y or n)
[root@UC-DB-SERVER01 ~]# cd /dev/
[root@UC-DB-SERVER01 dev]# ls -l
total 0
crw-rw---- 1 root    video    10, 175 Sep 17 19:46 agpgart
drwxr-xr-x 2 root    root         900 Sep 21 15:59 block
drwxr-xr-x 2 root    root         160 Sep 21 15:59 bsg
crw------- 1 root    root     10, 234 Sep 17 16:46 btrfs-control
lrwxrwxrwx 1 root    root           3 Sep 17 19:46 cdrom -> sr0
lrwxrwxrwx 1 root    root           3 Sep 17 19:46 cdrw -> sr0
drwxr-xr-x 2 root    root        2740 Sep 21 15:59 char
crw------- 1 root    root      5,   1 Sep 17 19:46 console
lrwxrwxrwx 1 root    root          11 Sep 17 16:46 core -> /proc/kcore
drwxr-xr-x 6 root    root         120 Sep 17 16:45 cpu
crw-rw---- 1 root    root     10,  61 Sep 17 19:46 cpu_dma_latency
crw-rw---- 1 root    root     10,  62 Sep 17 19:46 crash
drwxr-xr-x 6 root    root         120 Sep 17 19:47 disk
brw-rw---- 1 root    disk    253,   0 Sep 17 19:46 dm-0
brw-rw---- 1 root    disk    253,   1 Sep 17 19:46 dm-1
brw-rw---- 1 root    disk    253,   2 Sep 17 19:46 dm-2
brw-rw---- 1 root    disk    253,   3 Sep 17 19:46 dm-3
brw-rw---- 1 root    disk    253,   4 Sep 17 19:46 dm-4
brw-rw---- 1 root    disk    253,   5 Sep 17 19:46 dm-5
brw-rw---- 1 root    disk    253,   6 Sep 17 19:46 dm-6
brw-rw---- 1 root    disk    253,   7 Sep 17 19:46 dm-7
lrwxrwxrwx 1 root    root           3 Sep 17 19:46 dvd -> sr0
lrwxrwxrwx 1 root    root           3 Sep 17 19:46 dvdrw -> sr0
lrwxrwxrwx 1 root    root           3 Sep 17 16:46 fb -> fb0
crw-rw---- 1 root    root     29,   0 Sep 17 16:46 fb0
lrwxrwxrwx 1 root    root          13 Sep 17 16:46 fd -> /proc/self/fd
crw-rw-rw- 1 root    root      1,   7 Sep 17 19:46 full
crw-rw-rw- 1 root    root     10, 229 Sep 17 16:46 fuse
crw-rw---- 1 root    root     10, 228 Sep 17 19:46 hpet
drwxr-xr-x 2 root    root          40 Sep 17 16:46 hugepages
crw------- 1 root    root    229,   0 Sep 17 16:46 hvc0
drwxr-xr-x 3 root    root         200 Sep 17 19:46 input
crw-rw---- 1 root    root      1,  11 Sep 17 19:46 kmsg
srw-rw-rw- 1 root    root           0 Sep 17 19:47 log
brw-rw---- 1 root    disk      7,   0 Sep 17 19:46 loop0
brw-rw---- 1 root    disk      7,   1 Sep 17 19:46 loop1
brw-rw---- 1 root    disk      7,   2 Sep 17 19:46 loop2
brw-rw---- 1 root    disk      7,   3 Sep 17 19:46 loop3
brw-rw---- 1 root    disk      7,   4 Sep 17 19:46 loop4
brw-rw---- 1 root    disk      7,   5 Sep 17 19:46 loop5
brw-rw---- 1 root    disk      7,   6 Sep 17 19:46 loop6
brw-rw---- 1 root    disk      7,   7 Sep 17 19:46 loop7
crw-rw---- 1 root    lp        6,   0 Sep 17 16:46 lp0
crw-rw---- 1 root    lp        6,   1 Sep 17 16:46 lp1
crw-rw---- 1 root    lp        6,   2 Sep 17 16:46 lp2
crw-rw---- 1 root    lp        6,   3 Sep 17 16:46 lp3
lrwxrwxrwx 1 root    root          13 Sep 17 16:46 MAKEDEV -> /sbin/MAKEDEV
drwxr-xr-x 2 root    root         220 Sep 17 19:46 mapper
crw-rw---- 1 root    root     10, 227 Sep 17 19:46 mcelog
crw-r----- 1 root    kmem      1,   1 Sep 17 19:46 mem
drwxr-xr-x 2 root    root          60 Sep 17 16:46 net
crw-rw---- 1 root    root     10,  60 Sep 17 19:46 network_latency
crw-rw---- 1 root    root     10,  59 Sep 17 19:46 network_throughput
crw-rw-rw- 1 root    root      1,   3 Sep 17 19:46 null
crw-r----- 1 root    kmem     10, 144 Sep 17 19:46 nvram
crw-rw---- 1 root    root      1,  12 Sep 17 19:46 oldmem
drwxr-xr-x 4 root    root           0 Sep 17 19:47 oracleasm
crw-r----- 1 root    kmem      1,   4 Sep 17 19:46 port
crw------- 1 root    root    108,   0 Sep 17 16:46 ppp
crw-rw-rw- 1 root    tty       5,   2 Sep 21 16:03 ptmx
drwxr-xr-x 2 root    root           0 Sep 17 16:45 pts
brw-rw---- 1 root    disk      1,   0 Sep 17 19:46 ram0
brw-rw---- 1 root    disk      1,   1 Sep 17 19:46 ram1
brw-rw---- 1 root    disk      1,  10 Sep 17 19:46 ram10
brw-rw---- 1 root    disk      1,  11 Sep 17 19:46 ram11
brw-rw---- 1 root    disk      1,  12 Sep 17 19:46 ram12
brw-rw---- 1 root    disk      1,  13 Sep 17 19:46 ram13
brw-rw---- 1 root    disk      1,  14 Sep 17 19:46 ram14
brw-rw---- 1 root    disk      1,  15 Sep 17 19:46 ram15
brw-rw---- 1 root    disk      1,   2 Sep 17 19:46 ram2
brw-rw---- 1 root    disk      1,   3 Sep 17 19:46 ram3
brw-rw---- 1 root    disk      1,   4 Sep 17 19:46 ram4
brw-rw---- 1 root    disk      1,   5 Sep 17 19:46 ram5
brw-rw---- 1 root    disk      1,   6 Sep 17 19:46 ram6
brw-rw---- 1 root    disk      1,   7 Sep 17 19:46 ram7
brw-rw---- 1 root    disk      1,   8 Sep 17 19:46 ram8
brw-rw---- 1 root    disk      1,   9 Sep 17 19:46 ram9
crw-rw-rw- 1 root    root      1,   8 Sep 17 19:46 random
drwxr-xr-x 2 root    root          60 Sep 17 16:46 raw
lrwxrwxrwx 1 root    root           4 Sep 17 19:46 root -> dm-0
lrwxrwxrwx 1 root    root           4 Sep 17 16:46 rtc -> rtc0
crw-rw---- 1 root    root    254,   0 Sep 17 16:46 rtc0
lrwxrwxrwx 1 root    root           3 Sep 17 19:46 scd0 -> sr0
brw-rw---- 1 root    disk      8,   0 Sep 17 19:46 sda
brw-rw---- 1 root    disk      8,   1 Sep 17 19:46 sda1
brw-rw---- 1 root    disk      8,   2 Sep 17 19:46 sda2
brw-rw---- 1 root    disk      8,  16 Sep 17 19:46 sdb
brw-rw---- 1 root    disk      8,  17 Sep 17 19:46 sdb1
brw-rw---- 1 root    disk      8,  32 Sep 17 19:47 sdc
brw-rw---- 1 root    disk      8,  33 Sep 17 19:47 sdc1
brw-rw---- 1 root    disk      8,  48 Sep 17 19:47 sdd
brw-rw---- 1 root    disk      8,  49 Sep 17 19:47 sdd1
brw-rw---- 1 root    disk      8,  64 Sep 21 15:59 sde
crw-rw---- 1 root    cdrom    21,   0 Sep 17 19:46 sg0
crw-rw---- 1 root    disk     21,   1 Sep 17 19:46 sg1
crw-rw---- 1 root    disk     21,   2 Sep 17 19:46 sg2
crw-rw---- 1 root    disk     21,   3 Sep 17 19:46 sg3
crw-rw---- 1 root    disk     21,   4 Sep 17 19:46 sg4
crw-rw---- 1 root    disk     21,   5 Sep 21 15:59 sg5
drwxrwxrwt 2 root    root        5480 Sep 17 19:48 shm
crw-rw---- 1 root    root     10, 231 Sep 17 19:46 snapshot
brw-rw---- 1 root    cdrom    11,   0 Sep 17 19:46 sr0
lrwxrwxrwx 1 root    root          15 Sep 17 16:46 stderr -> /proc/self/fd/2
lrwxrwxrwx 1 root    root          15 Sep 17 16:46 stdin -> /proc/self/fd/0
lrwxrwxrwx 1 root    root          15 Sep 17 16:46 stdout -> /proc/self/fd/1
lrwxrwxrwx 1 root    root           4 Sep 17 16:46 systty -> tty0
crw-rw-rw- 1 root    tty       5,   0 Sep 21 15:58 tty
crw--w---- 1 root    tty       4,   0 Sep 17 19:46 tty0
crw--w---- 1 dcadmin tty       4,   1 Sep 21 15:53 tty1
crw--w---- 1 root    tty       4,  10 Sep 17 19:46 tty10
crw--w---- 1 root    tty       4,  11 Sep 17 19:46 tty11
crw--w---- 1 root    tty       4,  12 Sep 17 19:46 tty12
crw--w---- 1 root    tty       4,  13 Sep 17 19:46 tty13
crw--w---- 1 root    tty       4,  14 Sep 17 19:46 tty14
crw--w---- 1 root    tty       4,  15 Sep 17 19:46 tty15
crw--w---- 1 root    tty       4,  16 Sep 17 19:46 tty16
crw--w---- 1 root    tty       4,  17 Sep 17 19:46 tty17
crw--w---- 1 root    tty       4,  18 Sep 17 19:46 tty18
crw--w---- 1 root    tty       4,  19 Sep 17 19:46 tty19
crw------- 1 root    root      4,   2 Sep 17 19:47 tty2
crw--w---- 1 root    tty       4,  20 Sep 17 19:46 tty20
crw--w---- 1 root    tty       4,  21 Sep 17 19:46 tty21
crw--w---- 1 root    tty       4,  22 Sep 17 19:46 tty22
crw--w---- 1 root    tty       4,  23 Sep 17 19:46 tty23
crw--w---- 1 root    tty       4,  24 Sep 17 19:46 tty24
crw--w---- 1 root    tty       4,  25 Sep 17 19:46 tty25
crw--w---- 1 root    tty       4,  26 Sep 17 19:46 tty26
crw--w---- 1 root    tty       4,  27 Sep 17 19:46 tty27
crw--w---- 1 root    tty       4,  28 Sep 17 19:46 tty28
crw--w---- 1 root    tty       4,  29 Sep 17 19:46 tty29
crw------- 1 root    root      4,   3 Sep 17 19:47 tty3
crw--w---- 1 root    tty       4,  30 Sep 17 19:46 tty30
crw--w---- 1 root    tty       4,  31 Sep 17 19:46 tty31
crw--w---- 1 root    tty       4,  32 Sep 17 19:46 tty32
crw--w---- 1 root    tty       4,  33 Sep 17 19:46 tty33
crw--w---- 1 root    tty       4,  34 Sep 17 19:46 tty34
crw--w---- 1 root    tty       4,  35 Sep 17 19:46 tty35
crw--w---- 1 root    tty       4,  36 Sep 17 19:46 tty36
crw--w---- 1 root    tty       4,  37 Sep 17 19:46 tty37
crw--w---- 1 root    tty       4,  38 Sep 17 19:46 tty38
crw--w---- 1 root    tty       4,  39 Sep 17 19:46 tty39
crw------- 1 root    root      4,   4 Sep 17 19:47 tty4
crw--w---- 1 root    tty       4,  40 Sep 17 19:46 tty40
crw--w---- 1 root    tty       4,  41 Sep 17 19:46 tty41
crw--w---- 1 root    tty       4,  42 Sep 17 19:46 tty42
crw--w---- 1 root    tty       4,  43 Sep 17 19:46 tty43
crw--w---- 1 root    tty       4,  44 Sep 17 19:46 tty44
crw--w---- 1 root    tty       4,  45 Sep 17 19:46 tty45
crw--w---- 1 root    tty       4,  46 Sep 17 19:46 tty46
crw--w---- 1 root    tty       4,  47 Sep 17 19:46 tty47
crw--w---- 1 root    tty       4,  48 Sep 17 19:46 tty48
crw--w---- 1 root    tty       4,  49 Sep 17 19:46 tty49
crw------- 1 root    root      4,   5 Sep 17 19:47 tty5
crw--w---- 1 root    tty       4,  50 Sep 17 19:46 tty50
crw--w---- 1 root    tty       4,  51 Sep 17 19:46 tty51
crw--w---- 1 root    tty       4,  52 Sep 17 19:46 tty52
crw--w---- 1 root    tty       4,  53 Sep 17 19:46 tty53
crw--w---- 1 root    tty       4,  54 Sep 17 19:46 tty54
crw--w---- 1 root    tty       4,  55 Sep 17 19:46 tty55
crw--w---- 1 root    tty       4,  56 Sep 17 19:46 tty56
crw--w---- 1 root    tty       4,  57 Sep 17 19:46 tty57
crw--w---- 1 root    tty       4,  58 Sep 17 19:46 tty58
crw--w---- 1 root    tty       4,  59 Sep 17 19:46 tty59
crw------- 1 root    root      4,   6 Sep 17 19:47 tty6
crw--w---- 1 root    tty       4,  60 Sep 17 19:46 tty60
crw--w---- 1 root    tty       4,  61 Sep 17 19:46 tty61
crw--w---- 1 root    tty       4,  62 Sep 17 19:46 tty62
crw--w---- 1 root    tty       4,  63 Sep 17 19:46 tty63
crw--w---- 1 root    tty       4,   7 Sep 17 19:46 tty7
crw--w---- 1 root    tty       4,   8 Sep 17 19:46 tty8
crw--w---- 1 root    tty       4,   9 Sep 17 19:46 tty9
crw-rw---- 1 root    dialout   4,  64 Sep 17 16:46 ttyS0
crw-rw---- 1 root    dialout   4,  65 Sep 17 16:46 ttyS1
crw-rw---- 1 root    dialout   4,  66 Sep 17 16:46 ttyS2
crw-rw---- 1 root    dialout   4,  67 Sep 17 16:46 ttyS3
crw-rw-rw- 1 root    root      1,   9 Sep 17 19:46 urandom
crw-rw---- 1 root    root    250,   0 Sep 17 19:46 usbmon0
crw-rw---- 1 vcsa    tty       7,   0 Sep 17 19:46 vcs
crw-rw---- 1 vcsa    tty       7,   1 Sep 17 19:46 vcs1
crw-rw---- 1 vcsa    tty       7,   2 Sep 17 19:47 vcs2
crw-rw---- 1 vcsa    tty       7,   3 Sep 17 19:47 vcs3
crw-rw---- 1 vcsa    tty       7,   4 Sep 17 19:47 vcs4
crw-rw---- 1 vcsa    tty       7,   5 Sep 17 19:47 vcs5
crw-rw---- 1 vcsa    tty       7,   6 Sep 17 19:47 vcs6
crw-rw---- 1 vcsa    tty       7, 128 Sep 17 19:46 vcsa
crw-rw---- 1 vcsa    tty       7, 129 Sep 17 19:46 vcsa1
crw-rw---- 1 vcsa    tty       7, 130 Sep 17 19:47 vcsa2
crw-rw---- 1 vcsa    tty       7, 131 Sep 17 19:47 vcsa3
crw-rw---- 1 vcsa    tty       7, 132 Sep 17 19:47 vcsa4
crw-rw---- 1 vcsa    tty       7, 133 Sep 17 19:47 vcsa5
crw-rw---- 1 vcsa    tty       7, 134 Sep 17 19:47 vcsa6
drwxr-xr-x 2 root    root         180 Sep 17 19:46 vg00
drwxr-xr-x 2 root    root          60 Sep 17 19:46 vg01
crw-rw---- 1 root    root     10,  63 Sep 17 19:46 vga_arbiter
crw-rw-rw- 1 root    root      1,   5 Sep 17 19:46 zero
[root@UC-DB-SERVER01 dev]# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/mapper/vg00-lv_raiz
                      5.9G  2.3G  3.3G  41% /
tmpfs                  16G  631M   16G   4% /dev/shm
/dev/sda1             124M   85M   34M  72% /boot
/dev/mapper/vg00-lv_opt
                      2.9G  103M  2.7G   4% /opt
/dev/mapper/vg01-lv_u01
                       50G   32G   15G  68% /u01
/dev/mapper/vg00-lv_var
                      5.9G  2.3G  3.4G  40% /var
tmpfs                 2.0G   16K  2.0G   1% /tmp
[root@UC-DB-SERVER01 dev]# oracleasm list disks
oracleasm: 'list' is not an oracleasm command
Usage: oracleasm [--exec-path=<exec_path>] <command> [ <args> ]
       oracleasm --exec-path
       oracleasm -h
       oracleasm -V

The basic oracleasm commands are:
    configure        Configure the Oracle Linux ASMLib driver
    init             Load and initialize the ASMLib driver
    exit             Stop the ASMLib driver
    scandisks        Scan the system for Oracle ASMLib disks
    status           Display the status of the Oracle ASMLib driver
    listdisks        List known Oracle ASMLib disks
    querydisk        Determine if a disk belongs to Oracle ASMlib
    createdisk       Allocate a device for Oracle ASMLib use
    deletedisk       Return a device to the operating system
    renamedisk       Change the label of an Oracle ASMlib disk
    update-driver    Download the latest ASMLib driver
[root@UC-DB-SERVER01 dev]# oracleasm listdisks
DATA_ASM_01
DATA_ASM_02
[root@UC-DB-SERVER01 dev]# fdisk -l

Disk /dev/sda: 80.5 GB, 80530636800 bytes
255 heads, 63 sectors/track, 9790 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x0009d131

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *           1          17      131072   83  Linux
Partition 1 does not end on cylinder boundary.
/dev/sda2              17        9791    78511104   8e  Linux LVM

Disk /dev/sdb: 53.7 GB, 53687091200 bytes
255 heads, 63 sectors/track, 6527 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x5f658ea5

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1               1        6527    52428096   83  Linux

Disk /dev/sdc: 53.7 GB, 53687091200 bytes
255 heads, 63 sectors/track, 6527 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x64fb89a6

   Device Boot      Start         End      Blocks   Id  System
/dev/sdc1               1        6527    52428096   83  Linux

Disk /dev/sdd: 53.7 GB, 53687091200 bytes
255 heads, 63 sectors/track, 6527 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0xd9b90a4d

   Device Boot      Start         End      Blocks   Id  System
/dev/sdd1               1        6527    52428096   83  Linux

Disk /dev/mapper/vg00-lv_raiz: 6509 MB, 6509559808 bytes
255 heads, 63 sectors/track, 791 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_swap1: 4294 MB, 4294967296 bytes
255 heads, 63 sectors/track, 522 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg01-lv_u01: 53.7 GB, 53682896896 bytes
255 heads, 63 sectors/track, 6526 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_var: 6509 MB, 6509559808 bytes
255 heads, 63 sectors/track, 791 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_opt: 3221 MB, 3221225472 bytes
255 heads, 63 sectors/track, 391 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_swap2: 4294 MB, 4294967296 bytes
255 heads, 63 sectors/track, 522 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_swap3: 4294 MB, 4294967296 bytes
255 heads, 63 sectors/track, 522 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_swap4: 4294 MB, 4294967296 bytes
255 heads, 63 sectors/track, 522 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/sde: 21.5 GB, 21474836480 bytes
255 heads, 63 sectors/track, 2610 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000

[root@UC-DB-SERVER01 dev]#
[root@UC-DB-SERVER01 dev]#
[root@UC-DB-SERVER01 dev]#
[root@UC-DB-SERVER01 dev]# cat /sys/class/scsi_host/$i/scan
cat: /sys/class/scsi_host/host2/scan: Permission denied
[root@UC-DB-SERVER01 dev]# cd /sys/class/scsi_host/$i/scan
-bash: cd: /sys/class/scsi_host/host2/scan: Not a directory
[root@UC-DB-SERVER01 dev]# cd /sys/class/scsi_host/
[root@UC-DB-SERVER01 scsi_host]# ls -ltr
total 0
lrwxrwxrwx 1 root root 0 Sep 17 16:46 host2 -> ../../devices/pci0000:00/0000:00:10.0/host2/scsi_host/host2
lrwxrwxrwx 1 root root 0 Sep 17 16:46 host1 -> ../../devices/pci0000:00/0000:00:07.1/host1/scsi_host/host1
lrwxrwxrwx 1 root root 0 Sep 17 16:46 host0 -> ../../devices/pci0000:00/0000:00:07.1/host0/scsi_host/host0
[root@UC-DB-SERVER01 scsi_host]# cat host2
cat: host2: Is a directory
[root@UC-DB-SERVER01 scsi_host]# cd host2
[root@UC-DB-SERVER01 host2]# ls -ltr
total 0
-rw-r--r-- 1 root root 4096 Sep 17 16:46 uevent
--w------- 1 root root 4096 Sep 21 15:59 scan
-r--r--r-- 1 root root 4096 Sep 21 16:09 version_product
-r--r--r-- 1 root root 4096 Sep 21 16:09 version_nvdata_persistent
-r--r--r-- 1 root root 4096 Sep 21 16:09 version_nvdata_default
-r--r--r-- 1 root root 4096 Sep 21 16:09 version_mpi
-r--r--r-- 1 root root 4096 Sep 21 16:09 version_fw
-r--r--r-- 1 root root 4096 Sep 21 16:09 version_bios
-r--r--r-- 1 root root 4096 Sep 21 16:09 unique_id
-r--r--r-- 1 root root 4096 Sep 21 16:09 unchecked_isa_dma
-rw-r--r-- 1 root root 4096 Sep 21 16:09 supported_mode
lrwxrwxrwx 1 root root    0 Sep 21 16:09 subsystem -> ../../../../../../class/scsi_host
-rw-r--r-- 1 root root 4096 Sep 21 16:09 state
-r--r--r-- 1 root root 4096 Sep 21 16:09 sg_tablesize
-r--r--r-- 1 root root 4096 Sep 21 16:09 prot_guard_type
-r--r--r-- 1 root root 4096 Sep 21 16:09 prot_capabilities
-r--r--r-- 1 root root 4096 Sep 21 16:09 proc_name
drwxr-xr-x 2 root root    0 Sep 21 16:09 power
-r--r--r-- 1 root root 4096 Sep 21 16:09 io_delay
-r--r--r-- 1 root root 4096 Sep 21 16:09 host_busy
-rw-r--r-- 1 root root 4096 Sep 21 16:09 eh_deadline
-r--r--r-- 1 root root 4096 Sep 21 16:09 device_delay
lrwxrwxrwx 1 root root    0 Sep 21 16:09 device -> ../../../host2
-rw-r--r-- 1 root root 4096 Sep 21 16:09 debug_level
-r--r--r-- 1 root root 4096 Sep 21 16:09 cmd_per_lun
-r--r--r-- 1 root root 4096 Sep 21 16:09 can_queue
-r--r--r-- 1 root root 4096 Sep 21 16:09 board_tracer
-r--r--r-- 1 root root 4096 Sep 21 16:09 board_name
-r--r--r-- 1 root root 4096 Sep 21 16:09 board_assembly
-rw-r--r-- 1 root root 4096 Sep 21 16:09 active_mode
[root@UC-DB-SERVER01 host2]# cd /dev/
[root@UC-DB-SERVER01 dev]# ls -ltr
total 0
drwxr-xr-x 6 root    root         120 Sep 17 16:45 cpu
drwxr-xr-x 2 root    root           0 Sep 17 16:45 pts
drwxr-xr-x 2 root    root          60 Sep 17 16:46 raw
crw------- 1 root    root     10, 234 Sep 17 16:46 btrfs-control
lrwxrwxrwx 1 root    root           4 Sep 17 16:46 systty -> tty0
crw-rw---- 1 root    root     29,   0 Sep 17 16:46 fb0
lrwxrwxrwx 1 root    root           3 Sep 17 16:46 fb -> fb0
crw------- 1 root    root    229,   0 Sep 17 16:46 hvc0
lrwxrwxrwx 1 root    root          13 Sep 17 16:46 fd -> /proc/self/fd
lrwxrwxrwx 1 root    root          15 Sep 17 16:46 stdin -> /proc/self/fd/0
lrwxrwxrwx 1 root    root          15 Sep 17 16:46 stdout -> /proc/self/fd/1
lrwxrwxrwx 1 root    root          15 Sep 17 16:46 stderr -> /proc/self/fd/2
lrwxrwxrwx 1 root    root          11 Sep 17 16:46 core -> /proc/kcore
drwxr-xr-x 2 root    root          40 Sep 17 16:46 hugepages
lrwxrwxrwx 1 root    root          13 Sep 17 16:46 MAKEDEV -> /sbin/MAKEDEV
crw-rw---- 1 root    lp        6,   0 Sep 17 16:46 lp0
crw-rw---- 1 root    lp        6,   1 Sep 17 16:46 lp1
crw-rw---- 1 root    lp        6,   2 Sep 17 16:46 lp2
crw-rw---- 1 root    lp        6,   3 Sep 17 16:46 lp3
drwxr-xr-x 2 root    root          60 Sep 17 16:46 net
crw------- 1 root    root    108,   0 Sep 17 16:46 ppp
crw-rw-rw- 1 root    root     10, 229 Sep 17 16:46 fuse
crw-rw---- 1 root    dialout   4,  67 Sep 17 16:46 ttyS3
crw-rw---- 1 root    dialout   4,  66 Sep 17 16:46 ttyS2
crw-rw---- 1 root    dialout   4,  65 Sep 17 16:46 ttyS1
crw-rw---- 1 root    dialout   4,  64 Sep 17 16:46 ttyS0
crw-rw---- 1 root    root    254,   0 Sep 17 16:46 rtc0
lrwxrwxrwx 1 root    root           4 Sep 17 16:46 rtc -> rtc0
brw-rw---- 1 root    disk      1,  15 Sep 17 19:46 ram15
brw-rw---- 1 root    disk      1,  13 Sep 17 19:46 ram13
brw-rw---- 1 root    disk      1,   1 Sep 17 19:46 ram1
brw-rw---- 1 root    disk      7,   5 Sep 17 19:46 loop5
brw-rw---- 1 root    disk      7,   1 Sep 17 19:46 loop1
brw-rw---- 1 root    disk      1,   2 Sep 17 19:46 ram2
brw-rw---- 1 root    disk      1,  14 Sep 17 19:46 ram14
brw-rw---- 1 root    disk      1,  11 Sep 17 19:46 ram11
brw-rw---- 1 root    disk      7,   6 Sep 17 19:46 loop6
brw-rw---- 1 root    disk      7,   2 Sep 17 19:46 loop2
brw-rw---- 1 root    disk      1,   3 Sep 17 19:46 ram3
brw-rw---- 1 root    disk      1,  12 Sep 17 19:46 ram12
brw-rw---- 1 root    disk      1,  10 Sep 17 19:46 ram10
brw-rw---- 1 root    disk      7,   4 Sep 17 19:46 loop4
brw-rw---- 1 root    disk      7,   3 Sep 17 19:46 loop3
brw-rw---- 1 root    disk      1,   5 Sep 17 19:46 ram5
brw-rw---- 1 root    disk      1,   4 Sep 17 19:46 ram4
brw-rw---- 1 root    disk      1,   0 Sep 17 19:46 ram0
brw-rw---- 1 root    disk      7,   7 Sep 17 19:46 loop7
brw-rw---- 1 root    disk      7,   0 Sep 17 19:46 loop0
crw-r----- 1 root    kmem      1,   1 Sep 17 19:46 mem
crw-rw---- 1 root    root      1,  11 Sep 17 19:46 kmsg
crw-rw-rw- 1 root    root      1,   7 Sep 17 19:46 full
crw-rw-rw- 1 root    root      1,   9 Sep 17 19:46 urandom
crw-rw-rw- 1 root    root      1,   8 Sep 17 19:46 random
brw-rw---- 1 root    disk      1,   6 Sep 17 19:46 ram6
crw-r----- 1 root    kmem      1,   4 Sep 17 19:46 port
crw-rw---- 1 root    root      1,  12 Sep 17 19:46 oldmem
crw-rw-rw- 1 root    root      1,   3 Sep 17 19:46 null
crw-rw-rw- 1 root    root      1,   5 Sep 17 19:46 zero
crw-rw---- 1 root    root     10,  61 Sep 17 19:46 cpu_dma_latency
crw-rw---- 1 root    video    10, 175 Sep 17 19:46 agpgart
brw-rw---- 1 root    disk      1,   8 Sep 17 19:46 ram8
crw-rw---- 1 root    root     10,  59 Sep 17 19:46 network_throughput
crw-rw---- 1 root    root     10,  60 Sep 17 19:46 network_latency
crw-rw---- 1 root    root     10, 227 Sep 17 19:46 mcelog
crw-rw---- 1 root    root     10, 228 Sep 17 19:46 hpet
crw-rw---- 1 root    root     10,  62 Sep 17 19:46 crash
crw-rw---- 1 root    root     10,  63 Sep 17 19:46 vga_arbiter
crw-rw---- 1 root    root     10, 231 Sep 17 19:46 snapshot
crw-r----- 1 root    kmem     10, 144 Sep 17 19:46 nvram
brw-rw---- 1 root    disk      1,   9 Sep 17 19:46 ram9
brw-rw---- 1 root    disk      1,   7 Sep 17 19:46 ram7
crw------- 1 root    root      5,   1 Sep 17 19:46 console
crw--w---- 1 root    tty       4,  10 Sep 17 19:46 tty10
crw--w---- 1 root    tty       4,   0 Sep 17 19:46 tty0
crw--w---- 1 root    tty       4,  16 Sep 17 19:46 tty16
crw--w---- 1 root    tty       4,  15 Sep 17 19:46 tty15
crw--w---- 1 root    tty       4,  14 Sep 17 19:46 tty14
crw--w---- 1 root    tty       4,  13 Sep 17 19:46 tty13
crw--w---- 1 root    tty       4,  12 Sep 17 19:46 tty12
crw--w---- 1 root    tty       4,  11 Sep 17 19:46 tty11
crw--w---- 1 root    tty       4,  19 Sep 17 19:46 tty19
crw--w---- 1 root    tty       4,  18 Sep 17 19:46 tty18
crw--w---- 1 root    tty       4,  17 Sep 17 19:46 tty17
crw--w---- 1 root    tty       4,  26 Sep 17 19:46 tty26
crw--w---- 1 root    tty       4,  25 Sep 17 19:46 tty25
crw--w---- 1 root    tty       4,  24 Sep 17 19:46 tty24
crw--w---- 1 root    tty       4,  23 Sep 17 19:46 tty23
crw--w---- 1 root    tty       4,  22 Sep 17 19:46 tty22
crw--w---- 1 root    tty       4,  21 Sep 17 19:46 tty21
crw--w---- 1 root    tty       4,  20 Sep 17 19:46 tty20
crw--w---- 1 root    tty       4,  30 Sep 17 19:46 tty30
crw--w---- 1 root    tty       4,  29 Sep 17 19:46 tty29
crw--w---- 1 root    tty       4,  28 Sep 17 19:46 tty28
crw--w---- 1 root    tty       4,  27 Sep 17 19:46 tty27
crw--w---- 1 root    tty       4,  37 Sep 17 19:46 tty37
crw--w---- 1 root    tty       4,  36 Sep 17 19:46 tty36
crw--w---- 1 root    tty       4,  35 Sep 17 19:46 tty35
crw--w---- 1 root    tty       4,  34 Sep 17 19:46 tty34
crw--w---- 1 root    tty       4,  33 Sep 17 19:46 tty33
crw--w---- 1 root    tty       4,  32 Sep 17 19:46 tty32
crw--w---- 1 root    tty       4,  31 Sep 17 19:46 tty31
crw--w---- 1 root    tty       4,  40 Sep 17 19:46 tty40
crw--w---- 1 root    tty       4,  39 Sep 17 19:46 tty39
crw--w---- 1 root    tty       4,  38 Sep 17 19:46 tty38
crw--w---- 1 root    tty       4,  45 Sep 17 19:46 tty45
crw--w---- 1 root    tty       4,  44 Sep 17 19:46 tty44
crw--w---- 1 root    tty       4,  43 Sep 17 19:46 tty43
crw--w---- 1 root    tty       4,  42 Sep 17 19:46 tty42
crw--w---- 1 root    tty       4,  41 Sep 17 19:46 tty41
crw--w---- 1 root    tty       4,  50 Sep 17 19:46 tty50
crw--w---- 1 root    tty       4,  49 Sep 17 19:46 tty49
crw--w---- 1 root    tty       4,  48 Sep 17 19:46 tty48
crw--w---- 1 root    tty       4,  47 Sep 17 19:46 tty47
crw--w---- 1 root    tty       4,  46 Sep 17 19:46 tty46
crw--w---- 1 root    tty       4,  55 Sep 17 19:46 tty55
crw--w---- 1 root    tty       4,  54 Sep 17 19:46 tty54
crw--w---- 1 root    tty       4,  53 Sep 17 19:46 tty53
crw--w---- 1 root    tty       4,  52 Sep 17 19:46 tty52
crw--w---- 1 root    tty       4,  51 Sep 17 19:46 tty51
crw--w---- 1 root    tty       4,  61 Sep 17 19:46 tty61
crw--w---- 1 root    tty       4,  60 Sep 17 19:46 tty60
crw--w---- 1 root    tty       4,  59 Sep 17 19:46 tty59
crw--w---- 1 root    tty       4,  58 Sep 17 19:46 tty58
crw--w---- 1 root    tty       4,  57 Sep 17 19:46 tty57
crw--w---- 1 root    tty       4,  56 Sep 17 19:46 tty56
crw-rw---- 1 root    root    250,   0 Sep 17 19:46 usbmon0
crw--w---- 1 root    tty       4,   9 Sep 17 19:46 tty9
crw--w---- 1 root    tty       4,   8 Sep 17 19:46 tty8
crw--w---- 1 root    tty       4,   7 Sep 17 19:46 tty7
crw--w---- 1 root    tty       4,  63 Sep 17 19:46 tty63
crw--w---- 1 root    tty       4,  62 Sep 17 19:46 tty62
crw-rw---- 1 vcsa    tty       7, 129 Sep 17 19:46 vcsa1
crw-rw---- 1 vcsa    tty       7, 128 Sep 17 19:46 vcsa
crw-rw---- 1 vcsa    tty       7,   1 Sep 17 19:46 vcs1
crw-rw---- 1 vcsa    tty       7,   0 Sep 17 19:46 vcs
crw-rw---- 1 root    cdrom    21,   0 Sep 17 19:46 sg0
crw-rw---- 1 root    disk     21,   1 Sep 17 19:46 sg1
crw-rw---- 1 root    disk     21,   2 Sep 17 19:46 sg2
crw-rw---- 1 root    disk     21,   3 Sep 17 19:46 sg3
crw-rw---- 1 root    disk     21,   4 Sep 17 19:46 sg4
drwxr-xr-x 3 root    root         200 Sep 17 19:46 input
brw-rw---- 1 root    disk      8,  16 Sep 17 19:46 sdb
brw-rw---- 1 root    disk      8,   0 Sep 17 19:46 sda
brw-rw---- 1 root    disk      8,  17 Sep 17 19:46 sdb1
brw-rw---- 1 root    disk      8,   2 Sep 17 19:46 sda2
brw-rw---- 1 root    cdrom    11,   0 Sep 17 19:46 sr0
lrwxrwxrwx 1 root    root           3 Sep 17 19:46 scd0 -> sr0
lrwxrwxrwx 1 root    root           3 Sep 17 19:46 dvdrw -> sr0
lrwxrwxrwx 1 root    root           3 Sep 17 19:46 dvd -> sr0
lrwxrwxrwx 1 root    root           3 Sep 17 19:46 cdrw -> sr0
lrwxrwxrwx 1 root    root           3 Sep 17 19:46 cdrom -> sr0
brw-rw---- 1 root    disk    253,   1 Sep 17 19:46 dm-1
drwxr-xr-x 2 root    root          60 Sep 17 19:46 vg01
brw-rw---- 1 root    disk    253,   6 Sep 17 19:46 dm-6
brw-rw---- 1 root    disk    253,   7 Sep 17 19:46 dm-7
brw-rw---- 1 root    disk    253,   5 Sep 17 19:46 dm-5
drwxr-xr-x 2 root    root         180 Sep 17 19:46 vg00
drwxr-xr-x 2 root    root         220 Sep 17 19:46 mapper
lrwxrwxrwx 1 root    root           4 Sep 17 19:46 root -> dm-0
brw-rw---- 1 root    disk    253,   0 Sep 17 19:46 dm-0
brw-rw---- 1 root    disk      8,   1 Sep 17 19:46 sda1
brw-rw---- 1 root    disk    253,   4 Sep 17 19:46 dm-4
brw-rw---- 1 root    disk    253,   2 Sep 17 19:46 dm-2
brw-rw---- 1 root    disk    253,   3 Sep 17 19:46 dm-3
srw-rw-rw- 1 root    root           0 Sep 17 19:47 log
drwxr-xr-x 4 root    root           0 Sep 17 19:47 oracleasm
brw-rw---- 1 root    disk      8,  48 Sep 17 19:47 sdd
drwxr-xr-x 6 root    root         120 Sep 17 19:47 disk
brw-rw---- 1 root    disk      8,  49 Sep 17 19:47 sdd1
brw-rw---- 1 root    disk      8,  32 Sep 17 19:47 sdc
brw-rw---- 1 root    disk      8,  33 Sep 17 19:47 sdc1
crw-rw---- 1 vcsa    tty       7, 130 Sep 17 19:47 vcsa2
crw-rw---- 1 vcsa    tty       7,   2 Sep 17 19:47 vcs2
crw-rw---- 1 vcsa    tty       7,   4 Sep 17 19:47 vcs4
crw-rw---- 1 vcsa    tty       7, 132 Sep 17 19:47 vcsa4
crw-rw---- 1 vcsa    tty       7, 131 Sep 17 19:47 vcsa3
crw-rw---- 1 vcsa    tty       7,   5 Sep 17 19:47 vcs5
crw-rw---- 1 vcsa    tty       7,   3 Sep 17 19:47 vcs3
crw-rw---- 1 vcsa    tty       7, 133 Sep 17 19:47 vcsa5
crw-rw---- 1 vcsa    tty       7, 134 Sep 17 19:47 vcsa6
crw-rw---- 1 vcsa    tty       7,   6 Sep 17 19:47 vcs6
crw------- 1 root    root      4,   6 Sep 17 19:47 tty6
crw------- 1 root    root      4,   5 Sep 17 19:47 tty5
crw------- 1 root    root      4,   4 Sep 17 19:47 tty4
crw------- 1 root    root      4,   3 Sep 17 19:47 tty3
crw------- 1 root    root      4,   2 Sep 17 19:47 tty2
drwxrwxrwt 2 root    root        5480 Sep 17 19:48 shm
crw--w---- 1 dcadmin tty       4,   1 Sep 21 15:53 tty1
crw-rw-rw- 1 root    tty       5,   0 Sep 21 15:58 tty
drwxr-xr-x 2 root    root         160 Sep 21 15:59 bsg
crw-rw---- 1 root    disk     21,   5 Sep 21 15:59 sg5
drwxr-xr-x 2 root    root        2740 Sep 21 15:59 char
brw-rw---- 1 root    disk      8,  64 Sep 21 15:59 sde
drwxr-xr-x 2 root    root         900 Sep 21 15:59 block
crw-rw-rw- 1 root    tty       5,   2 Sep 21 16:10 ptmx
[root@UC-DB-SERVER01 dev]# fdisk -l

Disk /dev/sda: 80.5 GB, 80530636800 bytes
255 heads, 63 sectors/track, 9790 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x0009d131

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *           1          17      131072   83  Linux
Partition 1 does not end on cylinder boundary.
/dev/sda2              17        9791    78511104   8e  Linux LVM

Disk /dev/sdb: 53.7 GB, 53687091200 bytes
255 heads, 63 sectors/track, 6527 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x5f658ea5

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1               1        6527    52428096   83  Linux

Disk /dev/sdc: 53.7 GB, 53687091200 bytes
255 heads, 63 sectors/track, 6527 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x64fb89a6

   Device Boot      Start         End      Blocks   Id  System
/dev/sdc1               1        6527    52428096   83  Linux

Disk /dev/sdd: 53.7 GB, 53687091200 bytes
255 heads, 63 sectors/track, 6527 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0xd9b90a4d

   Device Boot      Start         End      Blocks   Id  System
/dev/sdd1               1        6527    52428096   83  Linux

Disk /dev/mapper/vg00-lv_raiz: 6509 MB, 6509559808 bytes
255 heads, 63 sectors/track, 791 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_swap1: 4294 MB, 4294967296 bytes
255 heads, 63 sectors/track, 522 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg01-lv_u01: 53.7 GB, 53682896896 bytes
255 heads, 63 sectors/track, 6526 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_var: 6509 MB, 6509559808 bytes
255 heads, 63 sectors/track, 791 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_opt: 3221 MB, 3221225472 bytes
255 heads, 63 sectors/track, 391 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_swap2: 4294 MB, 4294967296 bytes
255 heads, 63 sectors/track, 522 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_swap3: 4294 MB, 4294967296 bytes
255 heads, 63 sectors/track, 522 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_swap4: 4294 MB, 4294967296 bytes
255 heads, 63 sectors/track, 522 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/sde: 21.5 GB, 21474836480 bytes
255 heads, 63 sectors/track, 2610 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000

[root@UC-DB-SERVER01 dev]# oracleasm listdisks
DATA_ASM_01
DATA_ASM_02
[root@UC-DB-SERVER01 dev]# ls sd
sda   sda1  sda2  sdb   sdb1  sdc   sdc1  sdd   sdd1  sde
[root@UC-DB-SERVER01 dev]# ls sd
sda   sda1  sda2  sdb   sdb1  sdc   sdc1  sdd   sdd1  sde
[root@UC-DB-SERVER01 dev]# ls sde
Display all 196 possibilities? (y or n)
[root@UC-DB-SERVER01 dev]# ls sde
sde
[root@UC-DB-SERVER01 dev]# ls -l sde
brw-rw---- 1 root disk 8, 64 Sep 21 15:59 sde
[root@UC-DB-SERVER01 dev]# df -h | grep ^/dev
/dev/mapper/vg00-lv_raiz
/dev/sda1             124M   85M   34M  72% /boot
/dev/mapper/vg00-lv_opt
/dev/mapper/vg01-lv_u01
/dev/mapper/vg00-lv_var
[root@UC-DB-SERVER01 dev]# sfdisk -l

Disk /dev/sda: 9790 cylinders, 255 heads, 63 sectors/track
Units = cylinders of 8225280 bytes, blocks of 1024 bytes, counting from 0

   Device Boot Start     End   #cyls    #blocks   Id  System
/dev/sda1   *      0+     16-     17-    131072   83  Linux
/dev/sda2         16+   9790-   9775-  78511104   8e  Linux LVM
/dev/sda3          0       -       0          0    0  Empty
/dev/sda4          0       -       0          0    0  Empty

Disk /dev/sdb: 6527 cylinders, 255 heads, 63 sectors/track
Units = cylinders of 8225280 bytes, blocks of 1024 bytes, counting from 0

   Device Boot Start     End   #cyls    #blocks   Id  System
/dev/sdb1          0+   6526    6527-  52428096   83  Linux
/dev/sdb2          0       -       0          0    0  Empty
/dev/sdb3          0       -       0          0    0  Empty
/dev/sdb4          0       -       0          0    0  Empty

Disk /dev/sdc: 6527 cylinders, 255 heads, 63 sectors/track
Units = cylinders of 8225280 bytes, blocks of 1024 bytes, counting from 0

   Device Boot Start     End   #cyls    #blocks   Id  System
/dev/sdc1          0+   6526    6527-  52428096   83  Linux
/dev/sdc2          0       -       0          0    0  Empty
/dev/sdc3          0       -       0          0    0  Empty
/dev/sdc4          0       -       0          0    0  Empty

Disk /dev/sdd: 6527 cylinders, 255 heads, 63 sectors/track
Units = cylinders of 8225280 bytes, blocks of 1024 bytes, counting from 0

   Device Boot Start     End   #cyls    #blocks   Id  System
/dev/sdd1          0+   6526    6527-  52428096   83  Linux
/dev/sdd2          0       -       0          0    0  Empty
/dev/sdd3          0       -       0          0    0  Empty
/dev/sdd4          0       -       0          0    0  Empty

Disk /dev/mapper/vg00-lv_raiz: 791 cylinders, 255 heads, 63 sectors/track

Disk /dev/mapper/vg00-lv_swap1: 522 cylinders, 255 heads, 63 sectors/track

Disk /dev/mapper/vg01-lv_u01: 6526 cylinders, 255 heads, 63 sectors/track

Disk /dev/mapper/vg00-lv_var: 791 cylinders, 255 heads, 63 sectors/track

Disk /dev/mapper/vg00-lv_opt: 391 cylinders, 255 heads, 63 sectors/track

Disk /dev/mapper/vg00-lv_swap2: 522 cylinders, 255 heads, 63 sectors/track

Disk /dev/mapper/vg00-lv_swap3: 522 cylinders, 255 heads, 63 sectors/track

Disk /dev/mapper/vg00-lv_swap4: 522 cylinders, 255 heads, 63 sectors/track

Disk /dev/sde: 2610 cylinders, 255 heads, 63 sectors/track
[root@UC-DB-SERVER01 dev]# fdisk -l

Disk /dev/sda: 80.5 GB, 80530636800 bytes
255 heads, 63 sectors/track, 9790 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x0009d131

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *           1          17      131072   83  Linux
Partition 1 does not end on cylinder boundary.
/dev/sda2              17        9791    78511104   8e  Linux LVM

Disk /dev/sdb: 53.7 GB, 53687091200 bytes
255 heads, 63 sectors/track, 6527 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x5f658ea5

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1               1        6527    52428096   83  Linux

Disk /dev/sdc: 53.7 GB, 53687091200 bytes
255 heads, 63 sectors/track, 6527 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x64fb89a6

   Device Boot      Start         End      Blocks   Id  System
/dev/sdc1               1        6527    52428096   83  Linux

Disk /dev/sdd: 53.7 GB, 53687091200 bytes
255 heads, 63 sectors/track, 6527 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0xd9b90a4d

   Device Boot      Start         End      Blocks   Id  System
/dev/sdd1               1        6527    52428096   83  Linux

Disk /dev/mapper/vg00-lv_raiz: 6509 MB, 6509559808 bytes
255 heads, 63 sectors/track, 791 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_swap1: 4294 MB, 4294967296 bytes
255 heads, 63 sectors/track, 522 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg01-lv_u01: 53.7 GB, 53682896896 bytes
255 heads, 63 sectors/track, 6526 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_var: 6509 MB, 6509559808 bytes
255 heads, 63 sectors/track, 791 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_opt: 3221 MB, 3221225472 bytes
255 heads, 63 sectors/track, 391 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_swap2: 4294 MB, 4294967296 bytes
255 heads, 63 sectors/track, 522 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_swap3: 4294 MB, 4294967296 bytes
255 heads, 63 sectors/track, 522 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_swap4: 4294 MB, 4294967296 bytes
255 heads, 63 sectors/track, 522 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/sde: 21.5 GB, 21474836480 bytes
255 heads, 63 sectors/track, 2610 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000

[root@UC-DB-SERVER01 dev]#
[root@UC-DB-SERVER01 dev]#
[root@UC-DB-SERVER01 dev]#
[root@UC-DB-SERVER01 dev]# cfdisk

[root@UC-DB-SERVER01 dev]# cfdisk /dev/sde
Disk has been changed.

WARNING: If you have created or modified any
DOS 6.x partitions, please see the cfdisk manual
page for additional information.

[root@UC-DB-SERVER01 dev]# fdisk -l

Disk /dev/sda: 80.5 GB, 80530636800 bytes
255 heads, 63 sectors/track, 9790 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x0009d131

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *           1          17      131072   83  Linux
Partition 1 does not end on cylinder boundary.
/dev/sda2              17        9791    78511104   8e  Linux LVM

Disk /dev/sdb: 53.7 GB, 53687091200 bytes
255 heads, 63 sectors/track, 6527 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x5f658ea5

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1               1        6527    52428096   83  Linux

Disk /dev/sdc: 53.7 GB, 53687091200 bytes
255 heads, 63 sectors/track, 6527 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x64fb89a6

   Device Boot      Start         End      Blocks   Id  System
/dev/sdc1               1        6527    52428096   83  Linux

Disk /dev/sdd: 53.7 GB, 53687091200 bytes
255 heads, 63 sectors/track, 6527 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0xd9b90a4d

   Device Boot      Start         End      Blocks   Id  System
/dev/sdd1               1        6527    52428096   83  Linux

Disk /dev/mapper/vg00-lv_raiz: 6509 MB, 6509559808 bytes
255 heads, 63 sectors/track, 791 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_swap1: 4294 MB, 4294967296 bytes
255 heads, 63 sectors/track, 522 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg01-lv_u01: 53.7 GB, 53682896896 bytes
255 heads, 63 sectors/track, 6526 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_var: 6509 MB, 6509559808 bytes
255 heads, 63 sectors/track, 791 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_opt: 3221 MB, 3221225472 bytes
255 heads, 63 sectors/track, 391 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_swap2: 4294 MB, 4294967296 bytes
255 heads, 63 sectors/track, 522 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_swap3: 4294 MB, 4294967296 bytes
255 heads, 63 sectors/track, 522 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_swap4: 4294 MB, 4294967296 bytes
255 heads, 63 sectors/track, 522 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/sde: 21.5 GB, 21474836480 bytes
255 heads, 63 sectors/track, 2610 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000

   Device Boot      Start         End      Blocks   Id  System
/dev/sde1               1        2611    20971488+  83  Linux
[root@UC-DB-SERVER01 dev]# oracleasm listdisk
oracleasm: 'listdisk' is not an oracleasm command
Usage: oracleasm [--exec-path=<exec_path>] <command> [ <args> ]
       oracleasm --exec-path
       oracleasm -h
       oracleasm -V

The basic oracleasm commands are:
    configure        Configure the Oracle Linux ASMLib driver
    init             Load and initialize the ASMLib driver
    exit             Stop the ASMLib driver
    scandisks        Scan the system for Oracle ASMLib disks
    status           Display the status of the Oracle ASMLib driver
    listdisks        List known Oracle ASMLib disks
    querydisk        Determine if a disk belongs to Oracle ASMlib
    createdisk       Allocate a device for Oracle ASMLib use
    deletedisk       Return a device to the operating system
    renamedisk       Change the label of an Oracle ASMlib disk
    update-driver    Download the latest ASMLib driver
[root@UC-DB-SERVER01 dev]# oracleasm listdisks
DATA_ASM_01
DATA_ASM_02
[root@UC-DB-SERVER01 dev]# ps -ef | grep pmon
oracle    2654     1  0 Sep17 ?        00:00:07 asm_pmon_+ASM
oracle    2828     1  0 Sep17 ?        00:00:08 ora_pmon_sondanet
oracle    2836     1  0 Sep17 ?        00:00:07 ora_pmon_DIS
root     32111 26442  0 16:56 pts/1    00:00:00 grep pmon
[root@UC-DB-SERVER01 dev]# sudo su - oracle
[oracle@UC-DB-SERVER01 ~]$ . oraenv
ORACLE_SID = [oracle] ? +ASM
The Oracle base remains unchanged with value /u01/app/oracle
[oracle@UC-DB-SERVER01 ~]$ sqlplus / as sysasm

SQL*Plus: Release 12.1.0.2.0 Production on Fri Sep 21 16:56:48 2018

Copyright (c) 1982, 2014, Oracle.  All rights reserved.


Connected to:
Oracle Database 12c Enterprise Edition Release 12.1.0.2.0 - 64bit Production
With the Automatic Storage Management option

SQL> select * from v$asm_disks;
select * from v$asm_disks
              *
ERROR at line 1:
ORA-01219: database or pluggable database not open: queries allowed on fixed
tables or views only


SQL> desc v$asm_disk
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 GROUP_NUMBER                                       NUMBER
 DISK_NUMBER                                        NUMBER
 COMPOUND_INDEX                                     NUMBER
 INCARNATION                                        NUMBER
 MOUNT_STATUS                                       VARCHAR2(7)
 HEADER_STATUS                                      VARCHAR2(12)
 MODE_STATUS                                        VARCHAR2(7)
 STATE                                              VARCHAR2(8)
 REDUNDANCY                                         VARCHAR2(7)
 LIBRARY                                            VARCHAR2(64)
 OS_MB                                              NUMBER
 TOTAL_MB                                           NUMBER
 FREE_MB                                            NUMBER
 HOT_USED_MB                                        NUMBER
 COLD_USED_MB                                       NUMBER
 NAME                                               VARCHAR2(30)
 FAILGROUP                                          VARCHAR2(30)
 LABEL                                              VARCHAR2(31)
 PATH                                               VARCHAR2(256)
 UDID                                               VARCHAR2(64)
 PRODUCT                                            VARCHAR2(32)
 CREATE_DATE                                        DATE
 MOUNT_DATE                                         DATE
 REPAIR_TIMER                                       NUMBER
 READS                                              NUMBER
 WRITES                                             NUMBER
 READ_ERRS                                          NUMBER
 WRITE_ERRS                                         NUMBER
 READ_TIMEOUT                                       NUMBER
 WRITE_TIMEOUT                                      NUMBER
 READ_TIME                                          NUMBER
 WRITE_TIME                                         NUMBER
 BYTES_READ                                         NUMBER
 BYTES_WRITTEN                                      NUMBER
 PREFERRED_READ                                     VARCHAR2(1)
 HASH_VALUE                                         NUMBER
 HOT_READS                                          NUMBER
 HOT_WRITES                                         NUMBER
 HOT_BYTES_READ                                     NUMBER
 HOT_BYTES_WRITTEN                                  NUMBER
 COLD_READS                                         NUMBER
 COLD_WRITES                                        NUMBER
 COLD_BYTES_READ                                    NUMBER
 COLD_BYTES_WRITTEN                                 NUMBER
 VOTING_FILE                                        VARCHAR2(1)
 SECTOR_SIZE                                        NUMBER
 FAILGROUP_TYPE                                     VARCHAR2(7)
 CON_ID                                             NUMBER

SQL> select DISK_NUMBER,LABEL,STATE,REDUNDANCY from v$asm_disk;

DISK_NUMBER LABEL                           STATE
----------- ------------------------------- --------
          0 DATA_ASM_01                     NORMAL
          1 DATA_ASM_02                     NORMAL

SQL> select name, state from v$asm_diskgroup;

NAME                           STATE
------------------------------ -----------
DATA                           MOUNTED

SQL> select name, path , header_status from v$asm_disk where
HEADER_STATUS<>'MEMBER';  2

no rows selected

SQL> select DISK_NUMBER,LABEL,STATE,HEADER_STATUS from v$asm_disk;

DISK_NUMBER LABEL                           STATE    HEADER_STATU
----------- ------------------------------- -------- ------------
          0 DATA_ASM_01                     NORMAL   MEMBER
          1 DATA_ASM_02                     NORMAL   MEMBER

SQL> Disconnected from Oracle Database 12c Enterprise Edition Release 12.1.0.2.0 - 64bit Production
With the Automatic Storage Management option
[oracle@UC-DB-SERVER01 ~]$ logout
[root@UC-DB-SERVER01 dev]# oracleasm createdisk "ARCH_ASM_01" /dev/sde;
Device "/dev/sde" is not a partition
[root@UC-DB-SERVER01 dev]# oracleasm createdisk "ARCH_ASM_01" /dev/sde
Device "/dev/sde" is not a partition
[root@UC-DB-SERVER01 dev]# fdisk -l

Disk /dev/sda: 80.5 GB, 80530636800 bytes
255 heads, 63 sectors/track, 9790 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x0009d131

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *           1          17      131072   83  Linux
Partition 1 does not end on cylinder boundary.
/dev/sda2              17        9791    78511104   8e  Linux LVM

Disk /dev/sdb: 53.7 GB, 53687091200 bytes
255 heads, 63 sectors/track, 6527 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x5f658ea5

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1               1        6527    52428096   83  Linux

Disk /dev/sdc: 53.7 GB, 53687091200 bytes
255 heads, 63 sectors/track, 6527 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x64fb89a6

   Device Boot      Start         End      Blocks   Id  System
/dev/sdc1               1        6527    52428096   83  Linux

Disk /dev/sdd: 53.7 GB, 53687091200 bytes
255 heads, 63 sectors/track, 6527 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0xd9b90a4d

   Device Boot      Start         End      Blocks   Id  System
/dev/sdd1               1        6527    52428096   83  Linux

Disk /dev/mapper/vg00-lv_raiz: 6509 MB, 6509559808 bytes
255 heads, 63 sectors/track, 791 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_swap1: 4294 MB, 4294967296 bytes
255 heads, 63 sectors/track, 522 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg01-lv_u01: 53.7 GB, 53682896896 bytes
255 heads, 63 sectors/track, 6526 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_var: 6509 MB, 6509559808 bytes
255 heads, 63 sectors/track, 791 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_opt: 3221 MB, 3221225472 bytes
255 heads, 63 sectors/track, 391 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_swap2: 4294 MB, 4294967296 bytes
255 heads, 63 sectors/track, 522 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_swap3: 4294 MB, 4294967296 bytes
255 heads, 63 sectors/track, 522 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/mapper/vg00-lv_swap4: 4294 MB, 4294967296 bytes
255 heads, 63 sectors/track, 522 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000


Disk /dev/sde: 21.5 GB, 21474836480 bytes
255 heads, 63 sectors/track, 2610 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000

   Device Boot      Start         End      Blocks   Id  System
/dev/sde1               1        2611    20971488+  83  Linux
[root@UC-DB-SERVER01 dev]# oracleasm createdisk "ARCH_ASM_01" /dev/sde1
Writing disk header: done
Instantiating disk: done
[root@UC-DB-SERVER01 dev]# sudo su - oracle
[oracle@UC-DB-SERVER01 ~]$ . oraenv
ORACLE_SID = [oracle] ? +ASM
The Oracle base remains unchanged with value /u01/app/oracle
[oracle@UC-DB-SERVER01 ~]$ sqlplus / as sysasm

SQL*Plus: Release 12.1.0.2.0 Production on Fri Sep 21 17:04:02 2018

Copyright (c) 1982, 2014, Oracle.  All rights reserved.


Connected to:
Oracle Database 12c Enterprise Edition Release 12.1.0.2.0 - 64bit Production
With the Automatic Storage Management option

SQL> select DISK_NUMBER,LABEL,STATE,HEADER_STATUS from v$asm_disk;

DISK_NUMBER LABEL                           STATE    HEADER_STATU
----------- ------------------------------- -------- ------------
          0 ARCH_ASM_01                     NORMAL   PROVISIONED
          0 DATA_ASM_01                     NORMAL   MEMBER
          1 DATA_ASM_02                     NORMAL   MEMBER

SQL> create diskgroup ARCH external redundancy DISK 'ORCL:ARCH_ASM_01';

Diskgroup created.

SQL> select DISK_NUMBER,LABEL,STATE,HEADER_STATUS from v$asm_disk;

DISK_NUMBER LABEL                           STATE    HEADER_STATU
----------- ------------------------------- -------- ------------
          0 DATA_ASM_01                     NORMAL   MEMBER
          1 DATA_ASM_02                     NORMAL   MEMBER
          0 ARCH_ASM_01                     NORMAL   MEMBER

SQL> SELECT NAME DISKGROUP, TOTAL_MB, FREE_MB, (TOTAL_MB-FREE_MB)/TOTAL_MB*100 PCT_UTILIZADO FROM V$ASM_DISKGROUP;

DISKGROUP                        TOTAL_MB    FREE_MB PCT_UTILIZADO
------------------------------ ---------- ---------- -------------
DATA                               102398      15327    85.0319342
ARCH                                20479      20429    .244152547

SQL> Disconnected from Oracle Database 12c Enterprise Edition Release 12.1.0.2.0 - 64bit Production
With the Automatic Storage Management option
[oracle@UC-DB-SERVER01 ~]$ ps -ef | grep pmon
oracle    2654     1  0 Sep17 ?        00:00:07 asm_pmon_+ASM
oracle    2828     1  0 Sep17 ?        00:00:08 ora_pmon_sondanet
oracle    2836     1  0 Sep17 ?        00:00:07 ora_pmon_DIS
oracle   33530 33324  0 17:07 pts/1    00:00:00 grep pmon
[oracle@UC-DB-SERVER01 ~]$ . oraenv
ORACLE_SID = [+ASM] ? sondanet
The Oracle base remains unchanged with value /u01/app/oracle
[oracle@UC-DB-SERVER01 ~]$ s
-bash: s: command not found
[oracle@UC-DB-SERVER01 ~]$ sqlplus / as sysdba

SQL*Plus: Release 12.1.0.2.0 Production on Fri Sep 21 17:07:25 2018

Copyright (c) 1982, 2014, Oracle.  All rights reserved.


Connected to:
Oracle Database 12c Standard Edition Release 12.1.0.2.0 - 64bit Production
With the Automatic Storage Management option

SQL> alter database backup controlfile to '+ARCH';

Database altered.

SQL> Disconnected from Oracle Database 12c Standard Edition Release 12.1.0.2.0 - 64bit Production
With the Automatic Storage Management option
[oracle@UC-DB-SERVER01 ~]$ . oraenv
ORACLE_SID = [sondanet] ? +ASM
The Oracle base remains unchanged with value /u01/app/oracle
[oracle@UC-DB-SERVER01 ~]$ asmcmd -p
ASMCMD [+] > lsdg
State    Type    Rebal  Sector  Block       AU  Total_MB  Free_MB  Req_mir_free_MB  Usable_file_MB  Offline_disks  Voting_files  Name
MOUNTED  EXTERN  N         512   4096  1048576     20479    20412                0           20412              0             N  ARCH/
MOUNTED  EXTERN  N         512   4096  1048576    102398    15327                0           15327              0             N  DATA/
ASMCMD [+] > cd ARCH
ASMCMD [+ARCH] > ls
SONDANET/
ASMCMD [+ARCH] > cd sondanet/
ASMCMD [+ARCH/sondanet] > ls
CONTROLFILE/
ASMCMD [+ARCH/sondanet] > cd CONTROLFILE/
ASMCMD [+ARCH/sondanet/CONTROLFILE] > ls
Backup.256.987440877
ASMCMD [+ARCH/sondanet/CONTROLFILE] > rm Backup.256.987440877
ASMCMD [+ARCH/sondanet/CONTROLFILE] > cd ..
ASMCMD-8002: entry 'sondanet' does not exist in directory '+ARCH/'
ASMCMD [+ARCH/sondanet/CONTROLFILE] > cd +ARCH/
ASMCMD [+ARCH] > ls
ASMCMD [+ARCH] > exit
[oracle@UC-DB-SERVER01 ~]$ . oraenv
ORACLE_SID = [+ASM] ? sondanet
The Oracle base remains unchanged with value /u01/app/oracle
[oracle@UC-DB-SERVER01 ~]$ sqlplus / as sysdba

SQL*Plus: Release 12.1.0.2.0 Production on Fri Sep 21 17:09:38 2018

Copyright (c) 1982, 2014, Oracle.  All rights reserved.


Connected to:
Oracle Database 12c Standard Edition Release 12.1.0.2.0 - 64bit Production
With the Automatic Storage Management option

SQL> archive log list
Database log mode              Archive Mode
Automatic archival             Enabled
Archive destination            +DATA
Oldest online log sequence     4112
Next log sequence to archive   4117
Current log sequence           4117
SQL> show parameter dest

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
audit_file_dest                      string      /u01/app/oracle/admin/sondanet
                                                 /adump
background_dump_dest                 string      /u01/app/oracle/product/12.1.0
                                                 .2/db_1/rdbms/log
core_dump_dest                       string      /u01/app/oracle/diag/rdbms/son
                                                 danet/sondanet/cdump
cursor_bind_capture_destination      string      memory+disk
db_create_file_dest                  string      +DATA
db_create_online_log_dest_1          string
db_create_online_log_dest_2          string
db_create_online_log_dest_3          string

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
db_create_online_log_dest_4          string
db_create_online_log_dest_5          string
db_recovery_file_dest                string
db_recovery_file_dest_size           big integer 0
diagnostic_dest                      string      /u01/app/oracle
log_archive_dest                     string
log_archive_dest_1                   string      LOCATION=+DATA
log_archive_dest_10                  string
log_archive_dest_11                  string
log_archive_dest_12                  string
log_archive_dest_13                  string

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
log_archive_dest_14                  string
log_archive_dest_15                  string
log_archive_dest_16                  string
log_archive_dest_17                  string
log_archive_dest_18                  string
log_archive_dest_19                  string
log_archive_dest_2                   string
log_archive_dest_20                  string
log_archive_dest_21                  string
log_archive_dest_22                  string
log_archive_dest_23                  string

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
log_archive_dest_24                  string
log_archive_dest_25                  string
log_archive_dest_26                  string
log_archive_dest_27                  string
log_archive_dest_28                  string
log_archive_dest_29                  string
log_archive_dest_3                   string
log_archive_dest_30                  string
log_archive_dest_31                  string
log_archive_dest_4                   string
log_archive_dest_5                   string

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
log_archive_dest_6                   string
log_archive_dest_7                   string
log_archive_dest_8                   string
log_archive_dest_9                   string
log_archive_dest_state_1             string      enable
log_archive_dest_state_10            string      enable
log_archive_dest_state_11            string      enable
log_archive_dest_state_12            string      enable
log_archive_dest_state_13            string      enable
log_archive_dest_state_14            string      enable
log_archive_dest_state_15            string      enable

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
log_archive_dest_state_16            string      enable
log_archive_dest_state_17            string      enable
log_archive_dest_state_18            string      enable
log_archive_dest_state_19            string      enable
log_archive_dest_state_2             string      enable
log_archive_dest_state_20            string      enable
log_archive_dest_state_21            string      enable
log_archive_dest_state_22            string      enable
log_archive_dest_state_23            string      enable
log_archive_dest_state_24            string      enable
log_archive_dest_state_25            string      enable

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
log_archive_dest_state_26            string      enable
log_archive_dest_state_27            string      enable
log_archive_dest_state_28            string      enable
log_archive_dest_state_29            string      enable
log_archive_dest_state_3             string      enable
log_archive_dest_state_30            string      enable
log_archive_dest_state_31            string      enable
log_archive_dest_state_4             string      enable
log_archive_dest_state_5             string      enable
log_archive_dest_state_6             string      enable
log_archive_dest_state_7             string      enable

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
log_archive_dest_state_8             string      enable
log_archive_dest_state_9             string      enable
log_archive_duplex_dest              string
log_archive_min_succeed_dest         integer     1
standby_archive_dest                 string      ?/dbs/arch
user_dump_dest                       string      /u01/app/oracle/product/12.1.0
                                                 .2/db_1/rdbms/log
SQL> alter system set log_archive_dest_1='LOCATION=+ARCH';

System altered.

SQL> alter system archive log current;

System altered.

SQL> select sequence#,name from v$archived_log where sequence# > (select max(sequence#)-10 from v$archived_log);

 SEQUENCE#
----------
NAME
--------------------------------------------------------------------------------
      4108


      4109


      4110



 SEQUENCE#
----------
NAME
--------------------------------------------------------------------------------
      4111


      4112


      4113



 SEQUENCE#
----------
NAME
--------------------------------------------------------------------------------
      4114
+DATA/SONDANET/ARCHIVELOG/2018_09_21/thread_1_seq_4114.336.987400509

      4115
+DATA/SONDANET/ARCHIVELOG/2018_09_21/thread_1_seq_4115.295.987414861

      4116
+DATA/SONDANET/ARCHIVELOG/2018_09_21/thread_1_seq_4116.298.987429193


 SEQUENCE#
----------
NAME
--------------------------------------------------------------------------------
      4117
+ARCH/SONDANET/ARCHIVELOG/2018_09_21/thread_1_seq_4117.256.987441047


10 rows selected.

SQL> set lines 300
SQL> set pages 500
SQL> col NAME for a80
SQL> /

 SEQUENCE# NAME
---------- --------------------------------------------------------------------------------
      4108
      4109
      4110
      4111
      4112
      4113
      4114 +DATA/SONDANET/ARCHIVELOG/2018_09_21/thread_1_seq_4114.336.987400509
      4115 +DATA/SONDANET/ARCHIVELOG/2018_09_21/thread_1_seq_4115.295.987414861
      4116 +DATA/SONDANET/ARCHIVELOG/2018_09_21/thread_1_seq_4116.298.987429193
      4117 +ARCH/SONDANET/ARCHIVELOG/2018_09_21/thread_1_seq_4117.256.987441047

10 rows selected.

SQL> archive log list
Database log mode              Archive Mode
Automatic archival             Enabled
Archive destination            +ARCH
Oldest online log sequence     4113
Next log sequence to archive   4118
Current log sequence           4118
SQL> select instance_name,host_name from v$instance;

INSTANCE_NAME    HOST_NAME
---------------- ----------------------------------------------------------------
sondanet         UC-DB-SERVER01

SQL> Disconnected from Oracle Database 12c Standard Edition Release 12.1.0.2.0 - 64bit Production
With the Automatic Storage Management option
[oracle@UC-DB-SERVER01 ~]$ ps -ef | grep pmon
oracle    2654     1  0 Sep17 ?        00:00:07 asm_pmon_+ASM
oracle    2828     1  0 Sep17 ?        00:00:08 ora_pmon_sondanet
oracle    2836     1  0 Sep17 ?        00:00:07 ora_pmon_DIS
oracle   34225 33324  0 17:13 pts/1    00:00:00 grep pmon
[oracle@UC-DB-SERVER01 ~]$ . oraenv
ORACLE_SID = [sondanet] ? DIS
The Oracle base remains unchanged with value /u01/app/oracle
[oracle@UC-DB-SERVER01 ~]$ sqlplus / as sysdba

SQL*Plus: Release 12.1.0.2.0 Production on Fri Sep 21 17:14:15 2018

Copyright (c) 1982, 2014, Oracle.  All rights reserved.


Connected to:
Oracle Database 12c Standard Edition Release 12.1.0.2.0 - 64bit Production
With the Automatic Storage Management option

SQL> archive log list
Database log mode              Archive Mode
Automatic archival             Enabled
Archive destination            +DATA
Oldest online log sequence     139
Next log sequence to archive   141
Current log sequence           141
SQL> alter system set log_archive_dest_1='LOCATION=+ARCH';

System altered.

SQL> alter system archive log current;

System altered.

SQL> set lines 300
SQL> set pages 500
SQL> col NAME for a80
SQL> select sequence#,name from v$archived_log where sequence# > (select max(sequence#)-10 from v$archived_log);

 SEQUENCE# NAME
---------- --------------------------------------------------------------------------------
       132
       133
       134
       135
       136
       137
       138 +DATA/DIS/ARCHIVELOG/2018_09_21/thread_1_seq_138.269.987400543
       139 +DATA/DIS/ARCHIVELOG/2018_09_21/thread_1_seq_139.333.987414909
       140 +DATA/DIS/ARCHIVELOG/2018_09_21/thread_1_seq_140.349.987429263
       141 +ARCH/DIS/ARCHIVELOG/2018_09_21/thread_1_seq_141.257.987441345

10 rows selected.

SQL> SELECT NAME DISKGROUP, TOTAL_MB, FREE_MB, (TOTAL_MB-FREE_MB)/TOTAL_MB*100 PCT_UTILIZADO FROM V$ASM_DISKGROUP;

DISKGROUP                        TOTAL_MB    FREE_MB PCT_UTILIZADO
------------------------------ ---------- ---------- -------------
DATA                               102398      15327    85.0319342
ARCH                                20479      20326    .747106792

SQL> SELECT INSTANCE_NAME, STATUS, DATABASE_STATUS FROM V$INSTANCE;

INSTANCE_NAME    STATUS       DATABASE_STATUS
---------------- ------------ -----------------
DIS              OPEN         ACTIVE

SQL> Disconnected from Oracle Database 12c Standard Edition Release 12.1.0.2.0 - 64bit Production
With the Automatic Storage Management option
[oracle@UC-DB-SERVER01 ~]$






***https://confluence.intranet.uol.com.br/confluence/pages/viewpage.action?spaceKey=BDC&title=ORA-POPT-HowTo%3DOracle+-+ASM+em+Linux