1- 
--Lista as istancias, lista os usuarios respectivos a cada instancia, 
nem todas instancias utilizam o mesmo usuario.

ps -ef | grep pmon

[svcacc_cofre_a503@oradb1tb578h ~]$ ps -ef  | grep pmon
trax       720     1  0 Jan22 ?        00:00:41 ora_pmon_TRAXDBH1
grid      4106     1  0  2018 ?        00:25:22 asm_pmon_+ASM1
trax      6237     1  0 Jan14 ?        00:03:12 ora_pmon_TRAXDBD1
sabre     9775     1  0  2018 ?        00:20:54 ora_pmon_SABRECCD1
cargo     9784     1  0  2018 ?        00:22:38 ora_pmon_CARGODBH1
sabre     9788     1  0  2018 ?        00:21:16 ora_pmon_SABREMCH1
oradb     9792     1  0  2018 ?        00:25:49 ora_pmon_ORADBD1
oradb     9821     1  0  2018 ?        00:23:19 ora_pmon_ORADBH1
osbpel    9845     1  0  2018 ?        00:21:58 ora_pmon_OSBPELD1
oraodi    9889     1  0  2018 ?        00:21:54 ora_pmon_ORAODIH1
sabre     9893     1  0  2018 ?        00:21:41 ora_pmon_SABREMCD1
fatwire   9897     1  0  2018 ?        00:21:51 ora_pmon_FATCDLH1
fatwire   9971     1  0  2018 ?        00:21:19 ora_pmon_FATDSV1
fatwire   9994     1  0  2018 ?        00:23:14 ora_pmon_WCSCSTH1
xrt       9997     1  0  2018 ?        00:20:58 ora_pmon_XRTH1
fatwire  10017     1  0  2018 ?        00:23:34 ora_pmon_WCSCDLH1
tdazul   10033     1  0  2018 ?        00:21:25 ora_pmon_TDAZULH1
synchro  10080     1  0  2018 ?        00:22:34 ora_pmon_FISCALD1
fatwire  10091     1  0  2018 ?        00:21:51 ora_pmon_FATCSTH1
siebel   10099     1  0  2018 ?        00:22:20 ora_pmon_CRMDBD1
soa12    10117     1  0  2018 ?        00:22:06 ora_pmon_SOA12H1ps - ef
osbpel   10169     1  0  2018 ?        00:22:57 ora_pmon_OSBPELH1
fatwire  10177     1  0  2018 ?        00:22:59 ora_pmon_WCSDSV1
soa12    10199     1  0  2018 ?        00:23:50 ora_pmon_SOA12D1
tdazul   10213     1  0  2018 ?        00:21:35 ora_pmon_TDAZULD1
oraodi   10251     1  0  2018 ?        00:23:45 ora_pmon_ORAODID1
siebel   10347     1  0  2018 ?        00:21:24 ora_pmon_CRMDBH1
xrt      10374     1  0  2018 ?        00:21:56 ora_pmon_XRTD1
54347    15783 11165  0 10:52 pts/2    00:00:00 grep pmon
ebsh     16930     1  0  2018 ?        00:16:24 ora_pmon_EBSH1
cargo    17710     1  0 Jan18 ?        00:02:29 ora_pmon_CARGODBD1
sabre    21480     1  0 Jan23 ?        00:00:28 ora_pmon_SABRECCH1
synchro  28269     1  0  2018 ?        00:14:16 ora_pmon_FISCALH1
ebsd     28888     1  0  2018 ?        00:12:54 ora_pmon_EBSD1

2-
--Muda para o usuairo da instancia desejada
 sudo su - "usuario da intancia que deseja se conectar"

Exemplo: " sudo su - trax "

3-
--Veficiar se existe alguma instancia setada no SID "ORACLE_SID"

echo $ORACLE_SID

4- Indicar a instancia a ser setada no ORACLE_SID.

 . oraenv

--apos executar o comando acima, digitar a instancia desejada, listada no passo 1.


5-

-- Connectar no sql plus.

sqlplus / as sysdba







