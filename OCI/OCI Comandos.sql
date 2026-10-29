-- Copia o backup ou arquivo para o bucket na nuvem
oci os object put -bn BackupDBS --file /u01/dump/BKP_GLOBUS72-19-08-21.dmp 

-- Envia backup pra nuvem 

oci os object put -bn BackupDBS --file /Dump/GLOBUS483_20-06-22_FULL.dmp

-- envia arquivo para backut da oci
oci os object put -bn bucket-praxio-dbc10-bkp --file /u01/dump/logfile_suzantur-GLOBUS609.log

oci os object put -bn BackupDBS --file /Local/Arquivo/Exemplo_Dump.zip

oci os object put -bn BackupDBS --file /u01/dump/Dump_Schema_GLOBUS179_29_01_22.dmp


-- 1.	INSTALL OCI CLI - WINDOWS

powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.ps1'))"

-- 2.	CRIAR O PEM E API KEY PARA O SEU USER

powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.ps1'))"


-- 3 - ENVIO DE ARQUIVO PARA BUCKET DO OBJECT STORAGE

oci os object put -bn <bucket-name> --file C:\DUMP\teste.txt --part-size 512 --parallel-upload-count 50

oci os object put -bn BackupDBS --file /root/teste.txt --part-size 512 --parallel-upload-count 50

oci os object put -bn BackupDBS --file /dump/Dump_ExpEmbaixador_240621.dmp


--	INSTALL OCI CLI - LINUX

bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"

--  APÓS A INSTALAÇÃO, É NECESSÁRIO FAZER A CONFIGURAÇÃO DA FERRAMENTA ATRAVÉS DO COMANDO ABAIXO:

oci setup config

-- ENVIAR ARQUIVO PARA BUCKET OCI STORAGE OBJECT

oci os object put -bn BackupDBS --file /dump/Dump_ExpEmbaixador_240621.dmp


