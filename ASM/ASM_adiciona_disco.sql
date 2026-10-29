--1 - . orenv +ASM 

EQTBPDTCIM01 /home/oracle> sqlplus / as sysasm

RAC - AVISAR o TASSO

ADICIONADO DISCOS EM DISKGROUP ASM VER DISPONIVEIS:


-- Com nome dos discos em maos, caso seja linux vire root e execute os comandos abaixo.
oracleasm createdisk OPER_DATA_013 /dev/sdm1

oracleasm createdisk OPER_DATA_014 /dev/mapper/36001738c7c805d0f0000000000023940
oracleasm createdisk OPER_DATA_015 /dev/mapper/36001738c7c805d0f0000000000023941
oracleasm createdisk OPER_DATA_016 /dev/mapper/36001738c7c805d0f0000000000023942
oracleasm createdisk OPER_DATA_017 /dev/mapper/36001738c7c805d0f0000000000023943



oracleasm createdisk DATA_0019 /dev/dm-135
oracleasm createdisk DATA_0020 /dev/dm-136
oracleasm createdisk DATA_0021 /dev/dm-137
oracleasm createdisk DATA_0022 /dev/dm-138

DATA_0019

--1 - Checar os discos disponíveis : (## nao alocado ##)

set pagesize 100;
set line 200;
COLUMN group_number FORMAT 9999;
COLUMN disk_number FORMAT 9999;
COLUMN name FORMAT A20;
COLUMN failgroup FORMAT A20;
COLUMN create_date FORMAT A20;
COLUMN path FORMAT A45;
col DEVICE for a28
select
  group_number,
    disk_number,
    name,
    failgroup,
    create_date,
    path
  from
    v$asm_disk
    where group_number=1
  order by
  1,2;



set linesize 200 pagesize 10000
break on asm_dg_name skip 1 on report
column DG_NAME          format a12
column ASM_DG_NAME      format a20
column ASM_DISK_NAME    format a14
column NUM              format 99999
column DEVICE           format a45
column HEADER_STATUS    format a12
column STATE            format a12
column TOTAL_MB         format 99g999g999
column FREE_MB          format 99g999g999
column USED_MB          format 99g999g999
column PCT_FREE         format 990d0
column USED_GB          format 999g999
column FREE_GB          format 999g999
column TOTAL_GB         format 999g999

select dg_name as asm_dg_name,redundancy, num,device,voting_files,header_status state,total_mb,used_mb,free_mb,pct_free,asm_disk_name
from ( select dg_name, redundancy, device, num, voting_files, asm_disk_name,grouping(dg_name) as ORD1,decode(dg_name, '## nao alocado ##', 3
,'## nao montado ##', 2
,1) as ORD2
,sum(TOTAL_MB)     as TOTAL_MB
,sum(USED_MB)      as USED_MB
,sum(FREE_MB)      as FREE_MB
,decode(grouping(dg_name), 1, 'TOTAL =>'
,decode(grouping(redundancy), 1,'Subtotal =>'))
|| header_status as header_status
,decode(grouping(state)
,1,to_char(count(*))||' discos'
,state) as state
,decode(grouping(header_status)
,1,round(100*sum(FREE_MB)/sum(TOTAL_MB),1)
,decode(header_status
,'CANDIDATE', to_number(null)
,PCT_FREE))
as pct_free
from ( select d.path as device
,case
when d.header_status in ('PROVISIONED', 'FORMER')
then '## nao alocado ##'
when d.header_status = 'MEMBER' and g.name IS NULL
then '## nao montado ##'
else g.name
end as dg_name
,d.disk_number as num
,d.name as asm_disk_name
,g.voting_files
,d.header_status
,d.state
,g.type as redundancy
,d.os_mb as total_mb /*11g: OS_MB=;10g:d.total_mb*/
,decode(g.group_number
,0,to_number(null)
,d.total_mb-d.free_mb) as used_mb
,decode(g.group_number,0,d.os_mb,d.free_mb) as free_mb
,decode(d.total_mb,0,to_number(null)
,round(100*d.free_mb/d.total_mb,1)) as pct_free
from (select x.*
,decode(group_number,0,-1, group_number) as grp#
from v$asm_disk x) d
left outer
join (select y.*, group_number as grp#
from v$asm_diskgroup y) g
using (grp#))
where device not like '/dev/ORAASM/VNXDC%' group by rollup (dg_name, (device, num, redundancy, voting_files, header_status,state, pct_free, asm_disk_name))
)
--and asm_dg_name = 'AJURILOB'
order by ord1, ord2, decode(dg_name,'DATA_SDEOP','Z',null,'Y',dg_name), device
/

--lista os discos do asm
set lines 1000
col PATH for a65
col name for a20
select GROUP_NUMBER, name, header_status, path, MOUNT_STATUS,MODE_STATUS, STATE, OS_MB/1024,TOTAL_MB/1024, FREE_MB from v$asm_disk
where 
GROUP_NUMBER=2
and name like 'RECO%'
order by 4;

column path format a20
set lines 9999 pages 9999
select path,os_mb,header_Status from v$asm_Disk where header_Status!='MEMBER';

--O comando para adicionar o disco novo no grupo data.
/dev/sde1
/dev/sdg1
/dev/sdh1
/dev/sdi1
/dev/sdj1
/dev/sdk1
/dev/sdl1
/dev/sdm1
/dev/sdn1
/dev/sdo1
/dev/sdp1
/dev/sdq1
/dev/sdr1
/dev/sds1
/dev/sdt1
/dev/sdu1
/dev/sdv1
/dev/sdw1 -- usar no RECO

/dev/sde
/dev/sdg
/dev/sdh
/dev/sdi
/dev/sdj
/dev/sdk
/dev/sdl
/dev/sdm
/dev/sdn
/dev/sdo
/dev/sdp
/dev/sdq
/dev/sdr
/dev/sds
/dev/sdt
/dev/sdu
/dev/sdv
/dev/sdw


-- CRIA DISKGROUP
create diskgroup DATALTH external redundancy disk 'AFD:DATALTH01','AFD:DATALTH02' attribute 'compatible.asm'='19.0.0.0.0' , 'compatible.rdbms'='10.1.0.0.0';
create diskgroup DATAPOH external redundancy disk 'AFD:DATAPOH01','AFD:DATAPOH02','AFD:DATAPOH03' attribute 'compatible.asm'='19.0.0.0.0' , 'compatible.rdbms'='10.1.0.0.0';

create diskgroup DATAC01 external redundancy disk 'AFD:DATA16' attribute 'compatible.asm'='19.0.0.0.0' , 'compatible.rdbms'='10.1.0.0.0';


  --PRIMARY - DATA_AJURI:
su - grid 
. oraenv - +ASM1 
sqlplus / as sysasm

alter diskgroup DATA add disk '/dev/rlv_eqm_asm03' name DATA_0001 rebalance power 11;

alter diskgroup DATAC1 add disk '/dev/rhdisk274' name DATA_0301 rebalance power 11;
alter diskgroup DATAC1 add disk '/dev/rhdisk275' name DATA_0302 rebalance power 11;
alter diskgroup DATAC1 add disk '/dev/rhdisk276' name DATA_0303 rebalance power 11;
alter diskgroup DATAC1 add disk '/dev/rhdisk277' name DATA_0304 rebalance power 11;

alter diskgroup DATAC1 add disk 'AFD:DATA15' name DATA15 rebalance power 11;
alter diskgroup DATAC1 add disk 'AFD:DATA16' name DATA16 rebalance power 11;


alter diskgroup DATA_SDEOP add disk '/dev/oracleasm/disks/OPER_DATA_014' name DATA_SDEOP_0018;
alter diskgroup DATA_SDEOP add disk '/dev/oracleasm/disks/OPER_DATA_015' name DATA_SDEOP_0019;
alter diskgroup DATA_SDEOP add disk '/dev/oracleasm/disks/OPER_DATA_016' name DATA_SDEOP_0020;
alter diskgroup DATA_SDEOP add disk '/dev/oracleasm/disks/OPER_DATA_017' name DATA_SDEOP_0021;


alter diskgroup DATA add disk '/dev/oracleasm/disks/DATA_0019' name DATA_0019; 
alter diskgroup DATA add disk '/dev/oracleasm/disks/DATA_0020' name DATA_0020; 
alter diskgroup DATA add disk '/dev/oracleasm/disks/DATA_0021' name DATA_0021; 
alter diskgroup DATA add disk '/dev/oracleasm/disks/DATA_0022' name DATA_0022; 

alter diskgroup DATAC01 add disk 'AFD:DATA01' name DATA01 rebalance power 20;
alter diskgroup DATAC01 add disk 'AFD:DATA02' name DATA02 rebalance power 20;
alter diskgroup DATAC01 add disk 'AFD:DATA03' name DATA03 rebalance power 20;
alter diskgroup DATAC01 add disk 'AFD:DATA04' name DATA04 rebalance power 20;
alter diskgroup DATAC01 add disk 'AFD:DATA05' name DATA05 rebalance power 20;
alter diskgroup DATAC01 add disk 'AFD:DATA06' name DATA06 rebalance power 20;
alter diskgroup DATAC01 add disk 'AFD:DATA07' name DATA07 rebalance power 20;
alter diskgroup DATAC01 add disk 'AFD:DATA08' name DATA08 rebalance power 20;
alter diskgroup DATAC01 add disk 'AFD:DATA09' name DATA09 rebalance power 20;
alter diskgroup DATAC01 add disk 'AFD:DATA10' name DATA10 rebalance power 20;
alter diskgroup DATAC01 add disk 'AFD:DATA11' name DATA11 rebalance power 20;
alter diskgroup DATAC01 add disk 'AFD:DATA12' name DATA12 rebalance power 20;
alter diskgroup DATAC01 add disk 'AFD:DATA13' name DATA13 rebalance power 20;
alter diskgroup DATAC01 add disk 'AFD:DATA14' name DATA14 rebalance power 20;
alter diskgroup DATAC01 add disk 'AFD:DATA15' name DATA15 rebalance power 20;
alter diskgroup DATAC01 add disk 'AFD:DATA17' name DATA017 rebalance power 20;


DATA_0429
  --STANDBY - DATA:
su - grid 
. oraenv - +ASM1
sqlplus / as sysasm

alter diskgroup DATA add disk '/dev/oracleasm/disks/DATA023' name DATA_0020;
alter diskgroup DATA add disk '/dev/oracleasm/disks/DATA024' name DATA_0021;

alter diskgroup DATA add disk '/dev/oracleasm/disks/DATA023' size 286099M rebalance power 11;
alter diskgroup DATA add disk '/dev/oracleasm/disks/DATA024' size 286099M rebalance power 11;

select dg.name group_name,
dg.type,
dg.compatibility,
d.name disk_name,
d.total_mb
from v$asm_diskgroup dg, v$asm_disk d
where dg.group_number=d.group_number and dg.name='DATAECT'
order by d.disk_number;

-- drop disk
alter diskgroup DATAC1 drop disk DATA12;
alter diskgroup DATAC1 drop disk DATA13;
alter diskgroup DATAC1 drop disk DATA14;
alter diskgroup DATAC1 drop disk DATA15;
alter diskgroup DATAC1 drop disk DATA16;
alter diskgroup DATAC1 drop disk DATA17;

---- // ----

column path format a20
set lines 132
set pages 50

select path, group_number group_#, disk_number disk_#, mount_status,
       header_status, state, total_mb, free_mb
from v$asm_disk
order by path;

-- Na Instância do +ASM consultar na visão V$ASM_OPERATION  o status e andamento do processo de rebalance:

set pagesize 100;
set line 200;
COLUMN group_number format 9999;
COLUMN operation format A10;
COLUMN state  format A10;
COLUMN power format 9999
COLUMN actual format 9999;
COLUMN est_work format 999999;
COLUMN est_rate format 999999;
COLUMN est_minutes format 999999;
select group_number,operation,state,power,actual,sofar,est_work,est_rate,est_minutes from gv$asm_operation;

GROUP_NUMBER OPERATION  STATE    POWER ACTUAL SOFAR EST_WORK EST_RATE EST_MINUTES
------------ ---------- -------- ----- ------ ----- -------- -------- -----------
           2 REBAL      RUN          1      1  338    18669      107          179


--A verificação do status da operação de rebalanceamento é de 179 minutos, você decide alocar mais recursos para a operação de rebalanceamento mudando o limite de energia dessa operação específica.

 -- Abaixo o comando para alterar a velocidade do processo:

alter diskgroup DATAC3  rebalance power 12;

Diskgroup altered.

set pagesize 100;
set line 200;
COLUMN group_number format 9999;
COLUMN operation format A10;
COLUMN state  format A10;
COLUMN power format 9999
COLUMN actual format 9999;
COLUMN sofar format 9999
COLUMN est_work format 999999;
COLUMN est_rate format 999999;
COLUMN est_minutes format 999999;
select
  group_number,
  operation,
  state,
  power,
  actual,
  sofar,
  est_work,
  est_rate,
  est_minutes
  from
   v$asm_operation;

GROUP_NUMBER OPERATION  STATE    POWER ACTUAL SOFAR EST_WORK EST_RATE EST_MINUTES
------------ ---------- -------- ----- ------ ----- -------- -------- -----------
           2 REBAL      RUN          9      9  2090    14661      181          69

select name,state,HEADER_STATUS,MODE_STATUS,path from v$asm_disk order by path;

--Após alteração do power para 9 podemos verificar que o tempo caiu para 69 minutos.


SELECT name, path, header_status, mount_status, state, total_mb, free_mb
FROM v$asm_disk
WHERE group_number = (SELECT group_number FROM v$asm_diskgroup WHERE name='DATAECT');


SET LINES 200
COL group_number FOR 999
COL name FOR A15
COL state FOR A10
SELECT group_number, name, state, type, total_mb, free_mb, 
       (free_mb/total_mb)*100 AS pct_free
FROM v$asm_diskgroup;

--Após o termino da operação podemos verificar que o disco foi adicionado com sucesso!!!

set pagesize 100;
set lines 200;
COLUMN group_number FORMAT 9999;
COLUMN disk_number FORMAT 9999;
COLUMN name FORMAT A15;
COLUMN failgroup FORMAT A15;
COLUMN create_date FORMAT A10;
COLUMN path FORMAT A47;

select
group_number,disk_number,name,failgroup,create_date,path from v$asm_disk order by 1,2
/


GROUP_NUMBER DISK_NUMBER NAME       FAILGROUP  CREATE_DAT PATH
------------ ----------- ---------- ---------- ---------- --------------------
           1           0 D2A        FG1        30-MAR-13  ORCL:DISK4
           1           1 D2B        FG2        30-MAR-13  ORCL:DISK5
           2           0 DISK6      DISK6      30-MAR-13  ORCL:DISK6
           2           1 DISK7      DISK7      30-MAR-13  ORCL:DISK7
           2           2 DISK8      DISK8      30-MAR-13  ORCL:DISK8
           2           3 DISK9      DISK9      30-MAR-13  ORCL:DISK9
           2           4 DISK14     DISK14     22-MAY-13  ORCL:DISK14
           3           0 DISK1      DISK1      30-MAR-13  ORCL:DISK1
           3           1 DISK2      DISK2      30-MAR-13  ORCL:DISK2
           3           2 DISK3      DISK3      30-MAR-13  ORCL:DISK3
           4           0 DISK10     DISK10     21-MAY-13  ORCL:DISK10
           4           1 DISK11     DISK11     21-MAY-13  ORCL:DISK11
           4           2 DISK12     DISK12     21-MAY-13  ORCL:DISK12
           4           3 DISK13     DISK13     21-MAY-13  ORCL:DISK13

14 rows selected.

Status do disco no ASMCMD:

ASMCMD> ls -l
State    Type    Rebal  Name
MOUNTED  EXTERN  N      DATA/
MOUNTED  NORMAL  N      DATA2/
MOUNTED  HIGH    Y      DATA3/
MOUNTED  NORMAL  N      RECOV/
ASMCMD>

-- executa para pegar o valor para o proximo passo
oracleasm querydisk -d AJURIDG

-- pesquisa
ls -l /dev | grep 252, | grep 64


-- verificar o logical_sector_size se está igual
ALTER DISKGROUP DATA SET ATTRIBUTE 'logical_sector_size'='512';

oracelasm create disk xx /dev/oracleasm/disks/AJURIPD_DATA_13


-- cria diskgroup com path do ASMLIB
CREATE DISKGROUP RECOC1 EXTERNAL REDUNDANCY  DISK 'AFD:RECO01' ATTRIBUTE 'compatible.rdbms'='19.0.0.0';


CREATE DISKGROUP DATA_SDJ EXTERNAL REDUNDANCY  DISK '/dev/oracleasm/disks/DATASDJ01' ATTRIBUTE 'compatible.asm'='19.0.0.0.0','compatible.rdbms'='10.1.0.0.0';
CREATE DISKGROUP DATA_PDO EXTERNAL REDUNDANCY  DISK '/dev/oracleasm/disks/DATAPDO01' ATTRIBUTE 'compatible.asm'='19.0.0.0.0','compatible.rdbms'='10.1.0.0.0';
CREATE DISKGROUP DATA_EDC EXTERNAL REDUNDANCY  DISK '/dev/oracleasm/disks/DATAEDC01','/dev/oracleasm/disks/DATAEDC02' ATTRIBUTE 'compatible.asm'='19.0.0.0.0','compatible.rdbms'='10.1.0.0.0';
CREATE DISKGROUP DATA_PDS EXTERNAL REDUNDANCY  DISK '/dev/oracleasm/disks/DATAPDS01' ATTRIBUTE 'compatible.asm'='19.0.0.0.0','compatible.rdbms'='10.1.0.0.0';

-- cria diskgroup com path do ASMLIB com opção de nomear o disco
create diskgroup DATA1 external redundancy disk '/dev/oracleasm/disks/DISK1','/dev/oracleasm/disks/DISK2',
'/dev/oracleasm/disks/DISK4','/dev/oracleasm/disks/DISK3','/dev/oracleasm/disks/DISK5','/dev/oracleasm/disks/DISK6',
'/dev/oracleasm/disks/DISK7' 
name DATA1 attribute 'compatible.asm'='12.1.0.2.0' , 'compatible.rdbms'='12.1.0.2.0';


DATA_SDJ - 
      DATASDJ01

DATA_LDT - ok
      DATALDT01
      DATALDT02
      DATALDT03

DATA_PDO - 
    DATAPDO01 

DATA_EDC - 
    DATAEDC01 
    DATAEDC02 

DATA_PDS - 
      DATAPDS01

----- logs 
export GRID_HOME=/u01/app/19.0.0.0/grid
export GRID_BASE=/u01/app/grid
export ORACLE_HOME=$GRID_HOME
export ORACLE_BASE=$GRID_BASE
export ORACLE_SID=+ASM
export PATH=$ORACLE_HOME/bin:$ORACLE_HOME/OPatch:$PATH

[root@vmlnxhom015 bin]# fdisk -l /dev/sdv
Disk /dev/sdv: 2 TiB, 2199023255552 bytes, 4294967296 sectors
Disk model: Virtual disk
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 13378E49-2F75-4B6B-BEA9-D3FD8B5F319C





/u04

AFD:RECO01



fdisk -l /dev/sdw

parted /dev/sdw


SET LINESIZE 200;
COL NAME FORMAT A20;
COL PATH FORMAT A40;

SELECT name, path, state, mount_status
FROM v$asm_disk
WHERE path LIKE '%sdw%';



/dev/sdw: PTUUID="37ff943a-c9df-469b-b716-f836e38c3548" PTTYPE="gpt"
SELECT name, path, state, mount_status
FROM v$asm_disk
WHERE path LIKE '%sdw%';

ALTER DISKGROUP RECOC1 OFFLINE DISK 'RECO01';


/dev/sdv1 --init

SELECT GROUP#, MEMBER FROM V$LOGFILE WHERE MEMBER LIKE '+RECOC3%';


kfed read /dev/sda
dd if=/dev/zero of=/dev/sdb bs=1M count=10

dd if=/dev/zero of=/dev/sdu bs=1M count=10
dd if=/dev/zero of=/dev/sds bs=1M count=10
dd if=/dev/zero of=/dev/sdp bs=1M count=10

kfed read /dev/sdu1
kfed read /dev/sds1
kfed read /dev/sdp1

DATA13 /dev/sdu1
DATA14 /dev/sds1
DATA15 /dev/sdp1

fdisk -l /dev/sdv
fdisk -l /dev/sdw
fdisk -l /dev/sdu
fdisk -l /dev/sds
fdisk -l /dev/sdp

fdisk /dev/sdv
fdisk /dev/sdw
fdisk /dev/sdu
fdisk /dev/sds
fdisk /dev/sdp
