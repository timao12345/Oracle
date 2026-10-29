-- Mudando IP do Scanlistener:
Estamos mudando de final 22 para final 12:

## Verificando onde o scan esta rodando:
[grid@jp-hq-db0 crsd]$ srvctl config scan
SCAN name: jp-hq-db-scan, Network: 1/172.16.22.0/255.255.255.0/bond0
SCAN VIP name: scan1, IP: /jp-hq-db-scan/172.16.22.22

## Alterar entrada no /etc/hosts (dos 2 nós):
DE:
## ScanVip: (Interface Bond0:2)
172.16.22.22    jp-hq-db-scan

PARA:
## ScanVip: (Interface Bond0:2)
172.16.22.12    jp-hq-db-scan

## Para os serviços de Scan e Scan Listener:
[root@jp-hq-db0 ~]# /u01/app/11.2.0/grid/bin/srvctl stop scan_listener
[root@jp-hq-db0 ~]# /u01/app/11.2.0/grid/bin/srvctl stop scan

## Modificar 
[root@jp-hq-db0 ~]# /u01/app/11.2.0/grid/bin/srvctl modify scan -n jp-hq-db-scan
** Sendo -n o nome do node scan.

## Validando se foi alterado:
[root@jp-hq-db0 ~]# /u01/app/11.2.0/grid/bin/srvctl config scan
SCAN name: jp-hq-db-scan, Network: 1/172.16.22.0/255.255.255.0/bond0
SCAN VIP name: scan1, IP: /jp-hq-db-scan/172.16.22.12

## Efetivando a mudança:
[root@jp-hq-db0 ~]# /u01/app/11.2.0/grid/bin/srvctl modify scan_listener -u

## Iniciando os seviços:
[root@jp-hq-db0 ~]# /u01/app/11.2.0/grid/bin/srvctl start scan
[root@jp-hq-db0 ~]# /u01/app/11.2.0/grid/bin/srvctl start scan_listener

## Verificando onde o scan esta rodando:
[grid@jp-hq-db0 crsd]$ srvctl config scan
SCAN name: jp-hq-db-scan, Network: 1/172.16.22.0/255.255.255.0/bond0
SCAN VIP name: scan1, IP: /jp-hq-db-scan/172.16.22.12

## Validando pelo lsnrctl:
[grid@jp-hq-db1 cdata]$ lsnrctl status LISTENER_SCAN1

LSNRCTL for Linux: Version 11.2.0.3.0 - Production on 09-APR-2013 19:19:40

Copyright (c) 1991, 2011, Oracle.  All rights reserved.

Connecting to (DESCRIPTION=(ADDRESS=(PROTOCOL=IPC)(KEY=LISTENER_SCAN1)))
STATUS of the LISTENER
------------------------
Alias                     LISTENER_SCAN1
Version                   TNSLSNR for Linux: Version 11.2.0.3.0 - Production
Start Date                09-APR-2013 19:13:26
Uptime                    0 days 0 hr. 6 min. 13 sec
Trace Level               off
Security                  ON: Local OS Authentication
SNMP                      OFF
Listener Parameter File   /u01/app/11.2.0/grid/network/admin/listener.ora
Listener Log File         /u01/app/11.2.0/grid/log/diag/tnslsnr/jp-hq-db1/listener_scan1/alert/log.xml
Listening Endpoints Summary...
  (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=LISTENER_SCAN1)))
  (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=172.16.22.12)(PORT=1524)))
Services Summary...
Service "JPMCQA" has 2 instance(s).
  Instance "JPMCQA1", status READY, has 1 handler(s) for this service...
  Instance "JPMCQA2", status READY, has 1 handler(s) for this service...
Service "JPMCQAXDB" has 2 instance(s).
  Instance "JPMCQA1", status READY, has 1 handler(s) for this service...
  Instance "JPMCQA2", status READY, has 1 handler(s) for this service...
The command completed successfully

