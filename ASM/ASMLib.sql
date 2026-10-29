##Instalando o ASMLIB


yum install -y oracleasm
yum install -y oracleasm-support


##Configurando

/usr/sbin/oracleasm configure -i

oracle/oinstall/y/y

/usr/sbin/oracleasm init

systemctl enable oracleasm

systemctl start oracleasm



##Particionando os discos (Caso seja menos de 2TB usar o fdisk)

[root@vmlnxprd014 bin]# fdisk /dev/sdd
Welcome to fdisk (util-linux 2.23.2).

Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table
Building a new DOS disklabel with disk identifier 0xc606e62f.

WARNING: The size of this disk is 5.5 TB (5497558138880 bytes).
DOS partition table format can not be used on drives for volumes
larger than (2199023255040 bytes) for 512-byte sectors. Use parted(1) and GUID
partition table format (GPT).


Command (m for help): n
Partition type:
   p   primary (0 primary, 0 extended, 4 free)
   e   extended
Select (default p): p
Partition number (1-4, default 1):
First sector (2048-4294967295, default 2048):
Using default value 2048
Last sector, +sectors or +size{K,M,G} (2048-4294967294, default 4294967294):
Using default value 4294967294
Partition 1 of type Linux and of size 2 TiB is set

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.
Syncing disks.




--------------------------------------------------------------------------------


[root@vmlnxprd014 sbin]# parted /dev/sdg
GNU Parted 3.1
Using /dev/sdg
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) mklabel
New disk label type? gpt
Warning: The existing disk label on /dev/sdg will be destroyed and all data on this disk will be lost. Do you want to continue?
Yes/No? yes
(parted)
(parted) mkpart
Partition name?  []?
File system type?  [ext2]?
Start? 1
End? -0
Warning: The resulting partition is not properly aligned for best performance.
Ignore/Cancel? igonre
parted: invalid token: igonre
Ignore/Cancel? ignore
(parted)
(parted)
(parted) print
Model: VMware Virtual disk (scsi)
Disk /dev/sdg: 5498GB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags:
Number  Start   End     Size    File system  Name  Flags
 1      1000kB  5498GB  5498GB

(parted) quit
Information: You may need to update /etc/fstab.
[root@vmlnxprd014 sbin]#

##Adicionando no ASMLIB


/usr/sbin/oracleasm createdisk DISK1 /dev/sdd1
/usr/sbin/oracleasm createdisk DISK2 /dev/sde1
/usr/sbin/oracleasm createdisk DISK3 /dev/sdf1
/usr/sbin/oracleasm createdisk DISK4 /dev/sdg1
/usr/sbin/oracleasm createdisk DISK5 /dev/sdh1
/usr/sbin/oracleasm createdisk DISK6 /dev/sdi1
/usr/sbin/oracleasm createdisk DISK7 /dev/sdj1


##Listando discos no ASMLIB


oracleasm listdisks


## Criar DG
create diskgroup DATALTH external redundancy disk 'AFD:DATALTH01','AFD:DATALTH02' attribute 'compatible.asm'='19.0.0.0.0' , 'compatible.rdbms'='10.1.0.0.0';


250G  200G   51G  80% /oracle/SDJ - 1 disco 500gb
1.2T  1.1T  159G  87% /oracle/LDT - 3 disco 500gb
250G   62G  189G  25% /oracle/PDO - 1 disco 500gb 
2.0T  837G  1.2T  41% /oracle/EDC - 2 disco 500gb
150G   39G  112G  26% /oracle/PDS - 1 disco 500gb

diskgroup:
   DATA_SDJ - 
      disk:  
         DATASDJ01
diskgroup:
   DATA_LDT - ok
      disk:
         DATALDT01
         DATALDT02
         DATALDT03
diskgroup:
   DATA_PDO - 
      disk:
        DATAPDO01 
diskgroup:
   DATA_EDC - 
      disk:
        DATAEDC01 
        DATAEDC02 
diskgroup:
   DATA_PDS - 
      disk:
         DATAPDS01



oracleasm createdisk DATASDJ01 /dev/sdi1
oracleasm createdisk DATALDT01 /dev/sdj1
oracleasm createdisk DATALDT02 /dev/sdk1
oracleasm createdisk DATALDT03 /dev/sdl1
oracleasm createdisk DATAPDO01 /dev/sdm1
oracleasm createdisk DATAEDC01 /dev/sdn1
oracleasm createdisk DATAEDC02 /dev/sdo1
oracleasm createdisk DATAPDS01 /dev/sdp1


mount -t nfs -v 10.98.1.69:/backup_acfs /backup_acfs -o nolock,rw