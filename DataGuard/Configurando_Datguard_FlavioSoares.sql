SQL> SELECT LOG_MODE FROM V$DATABASE;

LOG_MODE
------------
NOARCHIVELOG


[oracle@bancodg ~]$ lsnrctl status

LSNRCTL for Linux: Version 11.2.0.4.0 - Production on 14-JAN-2015 17:02:11

Copyright (c) 1991, 2013, Oracle.  All rights reserved.

Connecting to (ADDRESS=(PROTOCOL=tcp)(HOST=)(PORT=1521))
STATUS of the LISTENER
------------------------
Alias                     LISTENER
Version                   TNSLSNR for Linux: Version 11.2.0.4.0 - Production
Start Date                14-JAN-2015 15:33:59
Uptime                    0 days 1 hr. 28 min. 13 sec
Trace Level               off
Security                  ON: Local OS Authentication
SNMP                      OFF
Listener Log File         /u01/app/oracle/diag/tnslsnr/bancodg/listener/alert/log.xml
Listening Endpoints Summary...
  (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=bancodg.localdomain)(PORT=1521)))
Services Summary...
Service "orcl" has 1 instance(s).
  Instance "orcl", status READY, has 1 handler(s) for this service...
Service "orclXDB" has 1 instance(s).
  Instance "orcl", status READY, has 1 handler(s) for this service...
The command completed successfully


SQL> !mkdir -p /u01/app/oracle/archive/orcl

SQL> alter system set log_archive_format='orcl_%t_%s_%r.arc' scope=spfile;

System altered.

SQL> alter system set log_archive_dest_1='LOCATION=/u01/app/oracle/archive/orcl' scope=spfile;

System altered.

SQL> shut immediate;
SQL> alter database archivelog;
Database altered.
SQL> alter database open;
Database altered.

SQL> alter database force logging;
Database altered.

SQL> select force_logging from v$database;

FOR
---
YES

SQL>  alter database add standby logfile group 4 '/u01/app/oracle/oradata/orcl/redo_st04.log' size 50M;
Database altered.

SQL> alter database add standby logfile group 5 '/u01/app/oracle/oradata/orcl/redo_st05.log' size 50M;
Database altered.

SQL> alter database add standby logfile group 6 '/u01/app/oracle/oradata/orcl/redo_st06.log' size 50M;
Database altered.

SQL> alter database add standby logfile group 7 '/u01/app/oracle/oradata/orcl/redo_st07.log' size 50M;
Database altered.

SQL> select group#, sequence#, archived, status from v$standby_log;

    GROUP#  SEQUENCE# ARC STATUS
---------- ---------- --- ----------
         4          0 YES UNASSIGNED
         5          0 YES UNASSIGNED
         6          0 YES UNASSIGNED
         7          0 YES UNASSIGNED

LOG_ARCHIVE_CONFIG: Habita ou desabilita o comportamento de enviar as mensagens do redo log para o destino. 
Com a op��o DG_CONFIG, podemos definir um range de at� 9 destinos, definindo atrav�s do DB_UNIQUE_NAME de cada um deles.

SQL> alter system set LOG_ARCHIVE_CONFIG='DG_CONFIG=(orcl,stdby)'; 
System altered.



LOG_ARCHIVE_DEST_1: Especifica o caminho do primeiro destino de archive do banco de dados. 
No nosso caso ele ser� gravado no caminho '/u01/app/oracle/archive/orcl' do servidor do banco prim�rio. 
A op��o VALID_FOR define como ser� gravado os dados, veja mais detalhes aqui

SQL> alter system set LOG_ARCHIVE_DEST_1='LOCATION=/u01/app/oracle/archive/orcl VALID_FOR=(ALL_LOGFILES,ALL_ROLES) DB_UNIQUE_NAME=orcl';
System altered.


LOG_ARCHIVE_DEST_2: Esse par�metro, defini o segundo destino de archive. 
Nesse par�metro que concentra a m�gica do Oracle Dataguard, diferente com o que fizemos no primeiro destino (LOG_ARCHIVE_DEST_1), 
vamos fazer com que o segundo destino de archive do banco prim�rio seja gravado no primeiro destino de archive do banco standby. 
Veja que � exatamente o que definimos nesse par�metro, pedidos para o LGWR escrever os dados de log atrav�s do servi�o chamado �stdby� para o banco de dados �stdby�

SQL> alter system set LOG_ARCHIVE_DEST_2='SERVICE=stdby LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=stdby'; 
System altered.


LOG_ARCHIVE_DEST_STATE_1: Com esse par�metro, apenas definimos que o primeiro destino de archive est� habitado. 
Por enquanto o segundo destino de archive (LOG_ARCHIVE_DEST_STATE_2) que levar� os dados de log para o Data Guard, matemos desativado.

SQL> alter system set LOG_ARCHIVE_DEST_STATE_1=ENABLE; 
System altered.

FAL_SERVER e FAL_CLIENT: S�o par�metros de inicializa��o usados para o FAL (fetch archive log), 
ou seja � utilizado para a detec��o e resolu��o dos destinos do Data Guard. 
Basicamente, o no banco prim�rio o FAL_SERVER ser� o TNS service name do banco standby e vice-versa.

SQL> alter system set FAL_SERVER=stdby; 
System altered.
SQL> alter system set FAL_CLIENT=orcl; 
System altered.


DB_FILE_NAME_CONVERT: Ele n�o � mandat�rio para o Data Guard, na verdade sua fun��o n�o � nem para o Data Guard, ele � apenas utilizado no momento do recovery. 
Esse par�metro como o nome diz converte o nome do datafile e tempfile do prim�rio database para o correspondente caminho no standby database, 
� ut�l muito �til no momento do recover, pois assim podemos renomear os datafiles facilmente. No nosso caso, vamos converter todos os datafiles que est�o no caminho 
'/u01/app/oracle/oradata/orcl' no prim�rio database para o novo caminho '/u01/app/oracle/oradata/stdby' no standby database.

SQL> alter system set DB_FILE_NAME_CONVERT='/u01/app/oracle/oradata/stdby','/u01/app/oracle/oradata/orcl' scope=spfile; 
System altered.


LOG_FILE_NAME_CONVERT: O par�metro LOG_FILE_NAME_CONVERT faz exatamente o que o DB_FILE_NAME_CONVERT faz, por�m apenas com redo logs.

SQL> alter system set LOG_FILE_NAME_CONVERT='/u01/app/oracle/oradata/stdby','/u01/app/oracle/oradata/orcl' scope=spfile; 
System altered.


Backup do banco prim�rio

run {
allocate channel c1 type disk; 
allocate channel c2 type disk; 
backup database format '/u01/app/oracle/backup/rman/%d_%s_%p_%U.bkp'; 
backup archivelog all format '/u01/app/oracle/backup/rman/ARCH_%d_%s_%p_%U.bkp'; 
backup current controlfile for standby format '/u01/app/oracle/backup/rman/control_%d_%U.bkp'; 
}

Criando uma c�pia do arquivo de inicializa��o
SQL> create pfile='/u01/app/oracle/backup/rman/initstdby.ora' from spfile;

File created.


Copia do password file
 
[oracle@bancodg orcl]$ cd $ORACLE_HOME/dbs
[oracle@bancodg dbs]$ scp orapworcl   standdg:/u01/app/oracle/product/11.2.0/dbhome_1/dbs/orapwstdby
The authenticity of host 'standdg (192.168.56.20)' can't be established.
RSA key fingerprint is 11:8f:d4:3d:9d:7e:50:f5:7b:ff:e9:75:8f:51:85:1d.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'standdg,192.168.56.20' (RSA) to the list of known hosts.
oracle@standdg's password:
orapworcl                                                                                     


Criando os servi�os TNS

# tnsnames.ora Network Configuration File: /u01/app/oracle/product/11.2.0/dbhome_1/network/admin/tnsnames.ora
# Generated by Oracle configuration tools.

ORCL =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = bancodg.localdomain)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = orcl)
    )
  )

STDBY =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = standdg.localdomain)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = stdby)
    )
  )

  
Movendo os arquivos para o standby

[oracle@bancodg admin]$ cd $ORACLE_BASE/backup/rman
[oracle@bancodg rman]$ ls -ltr
total 1141324
-rw-r----- 1 oracle oinstall 384819200 Jan 14 18:28 ORCL_2_1_02psng8i_1_1.bkp
-rw-r----- 1 oracle oinstall   9797632 Jan 14 18:28 ORCL_3_1_03psngam_1_1.bkp
-rw-r----- 1 oracle oinstall     98304 Jan 14 18:28 ORCL_4_1_04psngb4_1_1.bkp
-rw-r----- 1 oracle oinstall 736108544 Jan 14 18:29 ORCL_1_1_01psng8i_1_1.bkp
-rw-r----- 1 oracle oinstall   1078272 Jan 14 18:29 ARCH_ORCL_6_1_06psngd2_1_1.bkp
-rw-r----- 1 oracle oinstall  25829376 Jan 14 18:29 ARCH_ORCL_5_1_05psngd2_1_1.bkp
-rw-r----- 1 oracle oinstall   9797632 Jan 14 18:30 control_ORCL_07psngd9_1_1.bkp
-rw-r--r-- 1 oracle oinstall      1352 Jan 14 18:52 initstdby.ora
[oracle@bancodg rman]$ ssh oracle@standdg mkdir -p /u01/app/oracle/backup/rman
oracle@standdg's password:
[oracle@bancodg rman]$
[oracle@bancodg rman]$ scp * standdg:`pwd`
oracle@standdg's password:
ARCH_ORCL_5_1_05psngd2_1_1.bkp                                                                                                                                     100%   25MB  24.6MB/s   00:01
ARCH_ORCL_6_1_06psngd2_1_1.bkp                                                                                                                                     100% 1053KB   1.0MB/s   00:00
control_ORCL_07psngd9_1_1.bkp                                                                                                                                      100% 9568KB   9.3MB/s   00:00
initstdby.ora                                                                                                                                                      100% 1352     1.3KB/s   00:00
ORCL_1_1_01psng8i_1_1.bkp                                                                                                                                          100%  702MB   2.6MB/s   04:27
ORCL_2_1_02psng8i_1_1.bkp                                                                                                                                          100%  367MB   2.1MB/s   02:54
ORCL_3_1_03psngam_1_1.bkp                                                                                                                                          100% 9568KB   4.7MB/s   00:02
ORCL_4_1_04psngb4_1_1.bkp                                                              


	select
	thread#,
	dest_id,
	sequence#,
	to_char(first_time,'dd/mm/yyyy hh24:mi:ss') ,
	to_char(next_time,'dd/mm/yyyy hh24:mi:ss')  
    from v$archived_log
    where resetlogs_change# = (select resetlogs_change# from v$database)
    order by thread#, sequence#, dest_id;
	
	
to_char(next_time,'dd/mm/yyyy hh24:mi:ss')  