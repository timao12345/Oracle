-- usuario usado é o cdcadmin
--cdc alguns comandos
cd /u02/opt/ibm/bin
cd /u02/opt/ibm/InfoSphereDataReplication/bin
./dmshowlogdependency -I cdckpv -a -t

-- entrar no dmconfigurets
./dmconfigurets

MAIN MENU
---------

1. List Current Instances
2. Add an Instance
3. Edit an Instance
4. Delete an Instance
5. Manage encryption profiles

6. Exit

Enter your selection:1

LIST OF CURRENT INSTANCES
-------------------------

Name      Server Port Database      Schema      Status
--------- ----------- ------------- ----------- ------------
cdckpv    11002       orakpv        USR_REPLICA running


Press ENTER to return to the Main menu...



-- apos achar a "Name" baixar o CDC 
./dmshutdown -I cdckpv
 
 -- Para subir comando abaixo
nohup ./dmts64 -I cdckpv &


-- veririca eventos
./dmshowevents -I cdckpv -a 

./dmshowevents -I cdckpv -a -c 100

./dmshowevents -I cdckpv -T "2026-04-26 00:00" -a -c 100000 > log_cdc_26_27_abril.txt

./dmshowevents  -I cdckpv -T "2026-06-23 00:00" -a | grep "2026-06-23" > log_cdc_26_abril.txt

-- Criar um serviço para o CDC no linux, criar o arquivo /etc/systemd/system/cdc.service com o conteudo abaixo:
[Unit]
Description=IBM CDC
After=network.target

[Service]
Type=simple
User=cdcadmin
Group=cdcadmin
Environment="PATH=/u02/opt/ibm/InfoSphereDataReplication/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin"
WorkingDirectory=/u02/opt/ibm/InfoSphereDataReplication/bin
ExecStart=/u02/opt/ibm/InfoSphereDataReplication/bin/dmts64 -I cdckpv
ExecStop=/u02/opt/ibm/InfoSphereDataReplication/bin/dmshutdown -I cdckpv
Restart=always
RestartSec=10
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target


SELECT *
FROM KIPREV.FO_CUENTAS
WHERE COD_CUENTA = '27870160';
FETCH FIRST 1 ROW ONLY;