# Ver versão do dbaascli

dbaascli --version


# Listar patchs dbaascli

dbaascli patch tools list

or 

dbaascli admin showLatestStackVersion


-------------

[root@exacc01-7jrgw1 ~]# dbaascli patch tools list
DBAAS CLI version 21.2.1.2.0
Executing command patch tools list
Checking Current tools on all nodes

exacc01-7jrgw1: Patchid : 21.2.1.2.0_210903.0832

Available Patches
Patchid : 21.3.1.1.0_211012.0110
Patchid : 21.3.1.2.0_211221.0941
Patchid : 21.4.1.1.0_220128.0941
Patchid : 22.1.1.1.0_220322.1440
Patchid : 22.2.1.0.1_220504.1405
Patchid : 22.2.1.1.0_220629.1546
Patchid : 22.2.1.1.0_220713.1149
Patchid : 22.3.1.0.1_220831.2106
Patchid : 22.3.1.1.0_221003.1823
Patchid : 22.4.1.0.1_221121.1117
Patchid : 22.4.1.0.1_221214.1249
Patchid : 23.1.1.0.1_230302.2348
Patchid : 23.1.2.0.0_230411.0838
Patchid : 23.2.1.0.0_230708.1101
Patchid : 23.2.1.0.0_230724.1149
Patchid : 23.3.1.0.0_230817.2029
Patchid : 23.3.1.0.0_231020.1640
Patchid : 23.3.2.0.0_231115.0227
Patchid : 23.4.1.0.0_231219.1834
Patchid : 24.1.1.0.0_240118.1119(LATEST)

Install tools patch using
dbaascli patch tools apply --patchid 24.1.1.0.0_240118.1119    or
dbaascli patch tools apply --patchid LATEST

exacc01-7jrgw2: Patchid : 21.2.1.2.0_210903.0832

Available Patches
Patchid : 21.3.1.1.0_211012.0110
Patchid : 21.3.1.2.0_211221.0941
Patchid : 21.4.1.1.0_220128.0941
Patchid : 22.1.1.1.0_220322.1440
Patchid : 22.2.1.0.1_220504.1405
Patchid : 22.2.1.1.0_220629.1546
Patchid : 22.2.1.1.0_220713.1149
Patchid : 22.3.1.0.1_220831.2106
Patchid : 22.3.1.1.0_221003.1823
Patchid : 22.4.1.0.1_221121.1117
Patchid : 22.4.1.0.1_221214.1249
Patchid : 23.1.1.0.1_230302.2348
Patchid : 23.1.2.0.0_230411.0838
Patchid : 23.2.1.0.0_230708.1101
Patchid : 23.2.1.0.0_230724.1149
Patchid : 23.3.1.0.0_230817.2029
Patchid : 23.3.1.0.0_231020.1640
Patchid : 23.3.2.0.0_231115.0227
Patchid : 23.4.1.0.0_231219.1834
Patchid : 24.1.1.0.0_240118.1119(LATEST)

Install tools patch using
dbaascli patch tools apply --patchid 24.1.1.0.0_240118.1119    or
dbaascli patch tools apply --patchid LATEST

All Nodes have the same tools version



## Atualizar dbaascli

dbaascli patch tools apply --patchid LATEST