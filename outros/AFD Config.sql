-- Configurando disco com parametro init para adicionar e vermos no momento da instalação
-- nesse exemplo já está particionado 
./asmcmd afd_label DATA01 /dev/sdd1 --init  
./asmcmd afd_label DATA02 /dev/sde1 --init 
./asmcmd afd_label DATA03 /dev/sdf1 --init 
./asmcmd afd_label DATA04 /dev/sdh1 --init 
./asmcmd afd_label DATA05 /dev/sdi1 --init 
./asmcmd afd_label DATA06 /dev/sdj1 --init 
./asmcmd afd_label DATA07 /dev/sdk1 --init 
./asmcmd afd_label DATA08 /dev/sdl1 --init 
./asmcmd afd_label DATA09 /dev/sdn1 --init 
./asmcmd afd_label DATA10 /dev/sdo1 --init 
./asmcmd afd_label DATA11 /dev/sdp1 --init 
./asmcmd afd_label DATA12 /dev/sdq1 --init 
./asmcmd afd_label DATA13 /dev/sds1 --init 
./asmcmd afd_label DATA14 /dev/sdt1 --init 
./asmcmd afd_label DATA15 /dev/sdu1 --init 
./asmcmd afd_label DATA16 /dev/sdv1 --init 
./asmcmd afd_label DATA17 /dev/sdw1 --init 
./asmcmd afd_label RECO01 /dev/sdx1 --init

-- Listar os discos que foram adicionados
./asmcmd afd_lslbl

-- retirar do afd com parametro init que retira da visualização no momento da instalação.
./asmcmd afd_unlabel /dev/sdd1 --init
./asmcmd afd_unlabel /dev/sde1 --init
./asmcmd afd_unlabel /dev/sdf1 --init
./asmcmd afd_unlabel /dev/sdh1 --init
./asmcmd afd_unlabel /dev/sdi1 --init
./asmcmd afd_unlabel /dev/sdj1 --init
./asmcmd afd_unlabel /dev/sdk1 --init
./asmcmd afd_unlabel /dev/sdl1 --init
./asmcmd afd_unlabel /dev/sdn1 --init
./asmcmd afd_unlabel /dev/sdo1 --init
./asmcmd afd_unlabel /dev/sdp1 --init
./asmcmd afd_unlabel /dev/sdq1 --init
./asmcmd afd_unlabel /dev/sds1 --init
./asmcmd afd_unlabel /dev/sdt1 --init
./asmcmd afd_unlabel /dev/sdu1 --init
./asmcmd afd_unlabel /dev/sdv1 --init
./asmcmd afd_unlabel /dev/sdw1 --init
./asmcmd afd_unlabel /dev/sdx1 --init

./asmcmd afd_unlabel /dev/sdf1 --init
./asmcmd afd_unlabel /dev/sdg1 --init
./asmcmd afd_unlabel /dev/sdb1 --init
./asmcmd afd_unlabel /dev/sdd1 --init
./asmcmd afd_unlabel /dev/sde1 --init

chown grid.oinstall sdc
chown grid.oinstall sdf
chown grid.oinstall sdg
chown grid.oinstall sdh
chown grid.oinstall sdk
chown grid.oinstall sdo
chown grid.oinstall sdl
chown grid.oinstall sdw
chown grid.oinstall sdq
chown grid.oinstall sdm
chown grid.oinstall sdn
chown grid.oinstall sdr
chown grid.oinstall sds
chown grid.oinstall sdt
chown grid.oinstall sdu
chown grid.oinstall sdv
chown grid.oinstall sdj
chown grid.oinstall sdp


./asmcmd afd_unlabel /dev/sdo1 --init

./asmcmd afd_unlabel  /dev/sdw1 --init
./asmcmd afd_unlabel  /dev/sdv1 --init

./asmcmd afd_unlabel DATA17 -f --init

./asmcmd afd_unlabel DATA20 -f
./asmcmd afd_unlabel DATA21 -f
./asmcmd afd_unlabel DATA22 -f
./asmcmd afd_unlabel DATA23 -f

DATA20                                /dev/sdz1
DATA21                                /dev/sdaa1
DATA22                                /dev/sdab1
DATA23                                /dev/sdac1

xauth add vmlnxhom019.rootbrasil.intranet/unix:12  MIT-MAGIC-COOKIE-1  fe2e2452432b7cba898ee3bafa0bae2f
xauth add vmlnxhom019.rootbrasil.intranet/unix:13  MIT-MAGIC-COOKIE-1  4bfc321f77ab0bb80d6f5f625fc5f0ba
xauth add vmlnxhom019.rootbrasil.intranet/unix:14  MIT-MAGIC-COOKIE-1  2fd5cfeee0e623c50ee204e0c536cfbd
xauth add vmlnxhom019.rootbrasil.intranet/unix:10  MIT-MAGIC-COOKIE-1  377f6e2f97f757d858c4bca8c9fa98b7
xauth add vmlnxhom019.rootbrasil.intranet/unix:11  MIT-MAGIC-COOKIE-1  943433fe978bcad3247926d7b41efcff

-- ambiente de DEV
./asmcmd afd_label DATA01 /dev/sdf1 --init
./asmcmd afd_label DATA02 /dev/sdg1 --init
./asmcmd afd_label DATA03 /dev/sdh1 --init
./asmcmd afd_label DATA04 /dev/sdi1 --init
./asmcmd afd_label DATA05 /dev/sdj1 --init
./asmcmd afd_label DATA06 /dev/sdk1 --init
./asmcmd afd_label DATA07 /dev/sdl1 --init
./asmcmd afd_label DATA08 /dev/sdm1 --init
./asmcmd afd_label DATA09 /dev/sdn1 --init
./asmcmd afd_label DATA10 /dev/sdo1 --init
./asmcmd afd_label DATA11 /dev/sdp1 --init
./asmcmd afd_label DATA12 /dev/sdq1 --init
./asmcmd afd_label DATA13 /dev/sdr1 --init
./asmcmd afd_label DATA14 /dev/sds1 --init
./asmcmd afd_label DATA15 /dev/sdt1 --init
./asmcmd afd_label DATA16 /dev/sdu1 --init
./asmcmd afd_label DATA17 /dev/sdv1 --init
./asmcmd afd_label RECO01 /dev/sdw1 --init


-- adicionado no pre-prod 19-08-2025 (ia até o disco DATA17)
./asmcmd afd_label DATA18 /dev/sdx1
./asmcmd afd_label DATA19 /dev/sdy1 
./asmcmd afd_label DATA20 /dev/sdz1 
./asmcmd afd_label DATA21 /dev/sdaa1
./asmcmd afd_label DATA22 /dev/sdab1
./asmcmd afd_label DATA23 /dev/sdac1




export GRID_HOME=/u01/app/19.0.0.0/grid
export GRID_BASE=/u01/app/grid
export ORACLE_HOME=$GRID_HOME
export ORACLE_BASE=$GRID_BASE
export ORACLE_SID=+ASM
export PATH=$ORACLE_HOME/bin:$ORACLE_HOME/OPatch:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib
export TNS_ADMIN=$ORACLE_HOME/network/admin


./asmcmd afd_unlabel /dev/sdr1 
./asmcmd afd_unlabel /dev/sds1
./asmcmd afd_unlabel /dev/sdt1
./asmcmd afd_unlabel /dev/sdu1
./asmcmd afd_unlabel /dev/sdv1
./asmcmd afd_unlabel /dev/sdw1

/lib/udev/scsi_id -g /dev/sdr - 
36000c29125fca461ec4a5686abbd1996
/lib/udev/scsi_id -g /dev/sds -
36000c291b21940718055c956ad0d805f
/lib/udev/scsi_id -g /dev/sdt - 
36000c299b0af142edcfcf46320a235de
/lib/udev/scsi_id -g /dev/sdu - 
36000c297ab8c4f23129ab51c04a02158
/lib/udev/scsi_id -g /dev/sdv - 
36000c294b46aefaf49df03d8b87985cf
/lib/udev/scsi_id -g /dev/sdw
36000c29d5a83d0d1ec265e5bec6bcd5f


DATAECQ01                             /dev/sdk1
DATAECQ02                             /dev/sdm1
DATAECQ03                             /dev/sdo1
DATAECQ04                             /dev/sdp1
DATAECQ05                             /dev/sdn1
DATAECQ06                             /dev/sdq1
DATAECQ07                             /dev/sdt1
DATAECQ08                             /dev/sdb1
DATAECQ09                             /dev/sdr1
DATAECQ10                             /dev/sdv1
DATAECQ11                             /dev/sds1
DATAECQ12                             /dev/sdu1
DATAECQ13                             /dev/sdaf1
DATAECQ14                             /dev/sdab1
DATAECQ15                             /dev/sdac1
DATAECQ16                             /dev/sdag1
DATAECQ17                             /dev/sdaa1
DATAECQ18                             /dev/sdz1
DATAECQ19                             /dev/sdy1
DATAECQ20                             /dev/sdae1
DATAECQ21                             /dev/sdah1
DATAECQ22                             /dev/sdl1
DATAECQ23                             /dev/sdx1
DATAECQ24                             /dev/sdad1


