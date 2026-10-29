-- Procediemnto para recriar REDOLOG
-- obs: não dropar GRUPO DE REDO QUE ESTEJA COM STATUS ACTIVE OU CURRENT SEMPRE FAZER SWITCH.

--1 Realizando troca de Switches

SQL> alter system switch logfile ; -- quando estiver como current.

alter database clear unarchived logfile group 8;

alter system checkpoint -- caso esteja staus ACTIVE que é quando esta gravando nos archives

--2 Verificando os grupos de redolog files:

select thread#,group#, bytes/1024/1024 as MB, members, status from v$log ORDER BY 1;

   THREAD#     GROUP#         MB    MEMBERS STATUS
---------- ---------- ---------- ---------- ----------
         1          1        200          1 INACTIVE
         1          2        200          1 CURRENT
         1          3        200          1 INACTIVE
         1          4        200          1 INACTIVE
         2          5        200          1 UNUSED
         2          6        200          1 UNUSED
         2          7        200          1 UNUSED
         2          8        200          1 UNUSED


6 rows selected.

--3 verifca local dos REDO, no caso abaixo contem 2 arquivos de REDO por grupo.

SELECT group#, thread# FROM v$standby_log ORDER BY group#, thread#;

select CON_ID,group#, type, member from v$logfile order by 1 ;

SET LINES 200
COLUMN member FORMAT A120
SELECT group#, type,member FROM v$logfile ORDER BY 1,2;

SELECT GROUP#,THREAD#,SEQUENCE#,ARCHIVED,STATUS FROM V$STANDBY_LOG;


    GROUP# TYPE    MEMBER
---------- ------- ---------------------------------------------------------------------------
         1 ONLINE  +DG_DATA/ipordtpd/onlinelog/group_1.990.1113343471
         1 ONLINE  +DG_ARCH/ipordtpd/onlinelog/group_1.425.1113343479
         2 ONLINE  +DG_DATA/ipordtpd/onlinelog/group_2.991.1113343487
         2 ONLINE  +DG_ARCH/ipordtpd/onlinelog/group_2.426.1113343493
         3 ONLINE  +DG_DATA/ipordtpd/onlinelog/group_3.992.1113343501
         3 ONLINE  +DG_ARCH/ipordtpd/onlinelog/group_3.427.1113343509
         4 ONLINE  +DG_ARCH/ipordtpd/onlinelog/group_4.428.1113343525
         4 ONLINE  +DG_DATA/ipordtpd/onlinelog/group_4.993.1113343519
        5 ONLINE  +DG_ARCH/ipordtpd/onlinelog/group_5.429.1113343543
         5 ONLINE  +DG_DATA/ipordtpd/onlinelog/group_5.994.1113343535
         6 ONLINE  +DG_DATA/ipordtpd/onlinelog/group_6.995.1113343551
         6 ONLINE  +DG_ARCH/ipordtpd/onlinelog/group_6.430.1113343559
         7 STANDBY +DG_DATA/ipordtpd/onlinelog/group_7.996.1113343813
         7 STANDBY +DG_ARCH/ipordtpd/onlinelog/group_7.431.1113343821
         8 STANDBY +DG_DATA/ipordtpd/onlinelog/group_8.997.1113343829
         8 STANDBY +DG_ARCH/ipordtpd/onlinelog/group_8.432.1113343839
         9 STANDBY +DG_DATA/ipordtpd/onlinelog/group_9.998.1113343847
         9 STANDBY +DG_ARCH/ipordtpd/onlinelog/group_9.433.1113343855
        10 STANDBY +DG_DATA/ipordtpd/onlinelog/group_10.999.1113343863
        10 STANDBY +DG_ARCH/ipordtpd/onlinelog/group_10.434.1113343871
        11 STANDBY +DG_DATA/ipordtpd/onlinelog/group_11.1000.1113343879
        11 STANDBY +DG_ARCH/ipordtpd/onlinelog/group_11.435.1113343887
        12 STANDBY +DG_DATA/ipordtpd/onlinelog/group_12.1001.1113343897
        12 STANDBY +DG_ARCH/ipordtpd/onlinelog/group_12.436.1113343903
        13 STANDBY +DG_ARCH/ipordtpd/onlinelog/group_13.437.1113343921
        13 STANDBY +DG_DATA/ipordtpd/onlinelog/group_13.1002.1113343913

26 rows selected.

SQL>

-- 4 DROPAR os grupo de REDO que estão com status innactive

   THREAD#     GROUP#         MB    MEMBERS STATUS
---------- ---------- ---------- ---------- ----------------
         1         19       4096          1 INACTIVE
         1         18       4096          1 INACTIVE
         1         17       4096          1 INACTIVE
         1         16       4096          1 INACTIVE
         1         10       4096          1 INACTIVE
         1         13       4096          1 INACTIVE
         1         12       4096          1 CURRENT
         1         11       4096          1 INACTIVE
         1         14       4096          1 INACTIVE
         2         28       4096          1 INACTIVE
         2         27       4096          1 CURRENT
         2         26       4096          1 INACTIVE
         2         25       4096          1 INACTIVE
         2         24       4096          1 INACTIVE
         2         23       4096          1 INACTIVE
         2         22       4096          1 INACTIVE
         2         21       4096          1 INACTIVE
         2         29       4096          1 INACTIVE
         2         20       4096          1 INACTIVE


ALTER DATABASE DROP LOGFILE GROUP 30; 
ALTER DATABASE DROP LOGFILE GROUP 31; 
ALTER DATABASE DROP LOGFILE GROUP 32; 
ALTER DATABASE DROP LOGFILE GROUP 33; 
ALTER DATABASE DROP LOGFILE GROUP 34; 
ALTER DATABASE DROP LOGFILE GROUP 35; 
ALTER DATABASE DROP LOGFILE GROUP 36; 
ALTER DATABASE DROP LOGFILE GROUP 37; 
ALTER DATABASE DROP LOGFILE GROUP 38;
ALTER DATABASE DROP LOGFILE GROUP 39; 


ALTER DATABASE DROP LOGFILE MEMBER '+RECOC1/KPVPPRD/ONLINELOG/group_21.286.1196099901';


-- 5 adicionando novos grupos - SOMENTE MUDAR nome do arquivo, no caso abaixo criamos grupos com 2 membros em cada grupo

alter database add logfile group 1 ('+DG_DATA/ipordtpd/onlinelog/group1_1.log','+DG_DATA/ipordtpd/onlinelog/group1_2.log') size 20G reuse;
alter database add logfile group 2 ('+DG_DATA/ipordtpd/onlinelog/group2_1.log','+DG_DATA/ipordtpd/onlinelog/group2_2.log') size 20G reuse;
alter database add logfile group 3 ('+DG_DATA/ipordtpd/onlinelog/group3_1.log','+DG_DATA/ipordtpd/onlinelog/group3_2.log') size 20G reuse;

alter database add logfile group 4 ('+DG_DATA/ipordtpd/onlinelog/group4_1.log','+DG_DATA/ipordtpd/onlinelog/group4_2.log') size 20G reuse;
alter database add logfile group 5 ('+DG_DATA/ipordtpd/onlinelog/group5_1.log','+DG_DATA/ipordtpd/onlinelog/group5_2.log') size 20G reuse;
alter database add logfile group 6 ('+DG_DATA/ipordtpd/onlinelog/group6_1.log','+DG_DATA/ipordtpd/onlinelog/group6_2.log') size 20G reuse;

alter database add logfile thread 2 group 4 ('+DATAC4')  size 200m reuse;
alter database add logfile thread 2 group 5 ('+DATAC4')  size 200m reuse;
alter database add logfile thread 2 group 6 ('+DATAC4')  size 200m reuse;


alter database add logfile thread 1 group 10 ('+DATAC2/ECCSTBY/ONLINELOG/group_10.log') SIZE 4096m;


alter database add logfile thread 2 group 4 ('+DATAC1')  size 200m reuse;
alter database add logfile thread 2 group 5 ('+DATAC1')  size 200m reuse;
alter database add logfile thread 2 group 6 ('+DATAC1')  size 200m reuse;

-- exemplo multiplex diskgroup, aonde 1 grupo de redo tem 2 membros, cada membro em um diskgroup diferente, caso um diskgroup fique indisponivel o redo log continua funcionando normalmente.
ALTER DATABASE ADD LOGFILE GROUP 4 ('+DATAC4','+RECOC4') SIZE 1G;

-- 6  exemplo adicionando membros no grupo.

ALTER DATABASE ADD LOGFILE MEMBER '+DG_DATA/ipordtpd/onlinelog/group1_1.log' TO GROUP 1;



----- REDO LOG STANDBY
-- 1  verifica grupo de REDO standby
select group#, type, member from v$logfile order by 1 ;
select group#, bytes/1024/1024 as MB, members, status from v$log ;
select group#, bytes/1024/1024, status from v$standby_log;

SELECT group#,
       l.thread#,
       lf.member,
       l.bytes/1024/1024 size_mb,
       lf.type,
       nvl(lf.status,'IN USE') status,
       l.status group_status
FROM   v$logfile lf JOIN v$log l USING (group#)
ORDER BY group#, lf.member;


    GROUP# BYTES/1024/1024 STATUS
---------- --------------- ----------
         7           10240 UNASSIGNED
         8           10240 UNASSIGNED
         9           10240 UNASSIGNED
        10           10240 UNASSIGNED
        11           10240 UNASSIGNED
        12           10240 UNASSIGNED
        13           10240 UNASSIGNED

7 rows selected.

alter database add standby logfile thread 1 group  9 ('+DATAC1')  size 200m;
alter database add standby logfile thread 1 group 10 ('+DATAC1')  size 200m;
alter database add standby logfile thread 1 group 11 ('+DATAC1')  size 200m;
alter database add standby logfile thread 1 group 12 ('+DATAC1')  size 200m;
alter database add standby logfile thread 1 group 13 ('+DATAC1')  size 200m;
alter database add standby logfile thread 2 group 14 ('+DATAC1')  size 200m;
alter database add standby logfile thread 2 group 15 ('+DATAC1')  size 200m;
alter database add standby logfile thread 2 group 16 ('+DATAC1')  size 200m;
alter database add standby logfile thread 2 group 17 ('+DATAC1')  size 200m;
alter database add standby logfile thread 2 group 18 ('+DATAC1')  size 200m;

-- 2 NO STANDBY pare o MRP e mude o parametro standby_file_management para MANUAL
-- Stop MRP
alter database recover standby database cancel;

-- set parameter MANUAL
alter system set standby_file_management='MANUAL' ;
alter system set standby_file_management='AUTO' ;

-- 3 Dropar o grupo
alter database drop standby logfile group <group#>;

-- 4 criar os novos REDO standby
alter database add standby logfile group <group no> ('<member1_file_name>') size <size>;
alter database add standby logfile group 7 ('+DG_DATA/ipordtpd/onlinelog/group_7') size 20G;

-- ou para RAC
alter database add standby logfile thread 1 group 30 ('+RECOC2/')  size 4096m;

-- clear
alter database clear logfile group 18;
alter database clear logfile group 25;

alter database clear standby logfile group 101;
alter database clear logfile group 11;
alter database clear logfile group 12;
alter database clear logfile group 13;
alter database clear logfile group 14;
alter database clear logfile group 15;
alter database clear logfile group 16;

-- drop
alter database drop standby logfile group 30; 
alter database drop standby logfile group 31; 
alter database drop standby logfile group 32; 
alter database drop standby logfile group 33; 
alter database drop standby logfile group 34; 
alter database drop standby logfile group 35; 
alter database drop standby logfile group 36; 
alter database drop standby logfile group 37; 
alter database drop standby logfile group 38;
alter database drop standby logfile group 39; 

alter database drop standby logfile group 101;
alter database drop standby logfile group 102;
alter database drop standby logfile group 103;
alter database drop standby logfile group 104;
alter database drop standby logfile group 105;
alter database drop standby logfile group 106;
alter database drop standby logfile group 107;
alter database drop standby logfile group 108;
alter database drop standby logfile group 201;
alter database drop standby logfile group 202;
alter database drop standby logfile group 203;
alter database drop standby logfile group 204;
alter database drop standby logfile group 205;
alter database drop standby logfile group 206;
alter database drop standby logfile group 207;
alter database drop standby logfile group 208;

-- standby

alter database add standby logfile group 9  ('+DG_DATA','+DG_DATA') size 20G reuse; 
alter database add standby logfile group 10 ('+DG_DATA','+DG_DATA') size 20G reuse; 
alter database add standby logfile group 11 ('+DG_DATA','+DG_DATA') size 20G reuse; 
alter database add standby logfile group 12 ('+DG_DATA','+DG_DATA') size 20G reuse;
alter database add standby logfile group 13 ('+DG_DATA','+DG_DATA') size 20G reuse;
alter database add standby logfile group 14 ('+DG_DATA','+DG_DATA') size 20G reuse; 
alter database add standby logfile group 15 ('+DG_DATA','+DG_DATA') size 20G reuse;
alter database add standby logfile group 16 ('+DG_DATA','+DG_DATA') size 20G reuse;
alter database add standby logfile group 17 ('+DG_DATA','+DG_DATA') size 20G reuse;

alter database add standby logfile group  1 ('+DATAC2/') size 4096m;
alter database add standby logfile group  2 ('+DATAC2/') size 4096m;
alter database add standby logfile group  3 ('+DATAC2/') size 4096m;
alter database add standby logfile group  4 ('+DATAC2/') size 4096m;
alter database add standby logfile group  5 ('+DATAC2/') size 4096m;
alter database add standby logfile group  6 ('+DATAC2/') size 4096m;
alter database add standby logfile group  7 ('+DATAC2/') size 4096m;
alter database add standby logfile group  8 ('+DATAC2/') size 4096m;
alter database add standby logfile group  9 ('+DATAC2/') size 4096m;
alter database add standby logfile group 15 ('+DATAC2/') size 4096m;
alter database add standby logfile group 40 ('+DATAC2/') size 4096m;
alter database add standby logfile group 41 ('+DATAC2/') size 4096m;
alter database add standby logfile group 42 ('+DATAC2/') size 4096m;
alter database add standby logfile group 43 ('+DATAC2/') size 4096m;
alter database add standby logfile group 44 ('+DATAC2/') size 4096m;
alter database add standby logfile group 45 ('+DATAC2/') size 4096m;
alter database add standby logfile group 46 ('+DATAC2/') size 4096m;
alter database add standby logfile group 47 ('+DATAC2/') size 4096m;
alter database add standby logfile group 48 ('+DATAC2/') size 4096m;
alter database add standby logfile group 49 ('+DATAC2/') size 4096m;
alter database add standby logfile group 50 ('+DATAC2/') size 4096m;
alter database add standby logfile group 51 ('+DATAC2/') size 4096m;


alter database add standby logfile group 30 ('+RECOC2/') size 4096m; 
alter database add standby logfile group 31 ('+RECOC2/') size 4096m; 
alter database add standby logfile group 32 ('+RECOC2/') size 4096m; 
alter database add standby logfile group 33 ('+RECOC2/') size 4096m; 
alter database add standby logfile group 34 ('+RECOC2/') size 4096m; 
alter database add standby logfile group 35 ('+RECOC2/') size 4096m; 
alter database add standby logfile group 36 ('+RECOC2/') size 4096m; 
alter database add standby logfile group 37 ('+RECOC2/') size 4096m; 
alter database add standby logfile group 38 ('+RECOC2/') size 4096m;
alter database add standby logfile group 39 ('+RECOC2/') size 4096m; 

-- normal

alter database add logfile group 1 ('+DG_DATA','+DG_DATA') size 20G reuse;
alter database add logfile group 2 ('+DG_DATA','+DG_DATA') size 20G reuse;
alter database add logfile group 3 ('+DG_DATA','+DG_DATA') size 20G reuse;
alter database add logfile group 4 ('+DG_DATA','+DG_DATA') size 20G reuse;
alter database add logfile group 5 ('+DG_DATA','+DG_DATA') size 20G reuse;
alter database add logfile group 6 ('+DG_DATA','+DG_DATA') size 20G reuse;

alter database add logfile group 7 ('+DG_DATA','+DG_DATA') size 20G reuse; 
alter database add logfile group 8 ('+DG_DATA','+DG_DATA') size 20G reuse;



select group#, type, member from v$logfile order by 1 ;
select group#, bytes/1024/1024 as MB, members, status from v$log ;

-- clear and drop
alter database clear logfile group 1;
ALTER DATABASE DROP LOGFILE GROUP 1;

alter database clear logfile group 2;
ALTER DATABASE DROP LOGFILE GROUP 2;

alter database clear logfile group 3;
ALTER DATABASE DROP LOGFILE GROUP 3;

alter database clear logfile group 4;
ALTER DATABASE DROP LOGFILE GROUP 4;

alter database clear logfile group 5;
ALTER DATABASE DROP LOGFILE GROUP 5;

alter database clear logfile group 6;
ALTER DATABASE DROP LOGFILE GROUP 6;


-- opção para renomear

ALTER DATABASE RENAME FILE '/diska/logs/log1a.rdo', '/diska/logs/log2a.rdo' TO '/diskc/logs/log1c.rdo', '/diskc/logs/log2c.rdo';

ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 1;
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 2;
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 3;
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 4;
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 5;
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 6;
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 7;
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 8;
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 9;
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 10;
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 11;
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 12;
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 13;
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 14;
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 15;
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 16;
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 17;
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 18;
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 19;
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 20;
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 21;
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 22;

ALTER DATABASE DROP LOGFILE GROUP 1;
ALTER DATABASE DROP LOGFILE GROUP 2;
ALTER DATABASE DROP LOGFILE GROUP 3;
ALTER DATABASE DROP LOGFILE GROUP 4;
ALTER DATABASE DROP LOGFILE GROUP 5;
ALTER DATABASE DROP LOGFILE GROUP 6;
ALTER DATABASE DROP LOGFILE GROUP 7;
ALTER DATABASE DROP LOGFILE GROUP 8;
ALTER DATABASE DROP LOGFILE GROUP 9;
ALTER DATABASE DROP LOGFILE GROUP 10;
ALTER DATABASE DROP LOGFILE GROUP 11;
ALTER DATABASE DROP LOGFILE GROUP 12;
ALTER DATABASE DROP LOGFILE GROUP 13;
ALTER DATABASE DROP LOGFILE GROUP 14;
ALTER DATABASE DROP LOGFILE GROUP 15;
ALTER DATABASE DROP LOGFILE GROUP 16;
ALTER DATABASE DROP LOGFILE GROUP 17;
ALTER DATABASE DROP LOGFILE GROUP 18;
ALTER DATABASE DROP LOGFILE GROUP 19;
ALTER DATABASE DROP LOGFILE GROUP 20;
ALTER DATABASE DROP LOGFILE GROUP 21;
ALTER DATABASE DROP LOGFILE GROUP 22;