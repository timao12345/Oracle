---------------------------------------------------------
-- Procediemnto para deinstall do client do NetBackup 8.2
---------------------------------------------------------
Referencia: https://www.veritas.com/content/support/en_US/doc/27801100-136237906-0/v121344818-136237906

-- Validar a existencia dos pacotes VRTS
rpm -qa |grep VRTS

-- Verifique e atentar a remover primeiro o VRTSnbcfg
rpm -e VRTSnbcfg
rpm -e VRTSnbjava
rpm -e VRTSnbjre
rpm -e VRTSnbclt
rpm -e VRTSpbx
rpm -e VRTSnbpck

rpm -e VRTSnbcfg-10.4.0.1-1717258879.x86_64
rpm -e VRTSnbjre-10.4.0.1-1717258880.x86_64
rpm -e VRTSpbx-1.19.5.0-0.x86_64
rpm -e VRTSnbjava-10.4.0.1-1717258897.x86_64
rpm -e VRTSnbclt-10.4.0.1-1717259104.x86_64
rpm -e VRTSpddea-20.4.0.1-0021.x86_64
rpm -e VRTSnbclibs-10.4.0.1-1717258939.x86_64
rpm -e VRTSnbpck-10.4.0.1-1717259175.x86_64

rpm -e VRTSnbclt-10.4.0.1-1717259104.x86_64
rpm -e VRTSnbpck-10.4.0.1-1717259175.x86_64
rpm -e VRTSpbx-1.19.5.0-0.x86_64


--Remover pastas dentro do /usr/openv, atenção ao local que está antes de rodar o comando rm -rf.
-- deve estar algo parecido com exemplo abaixo:
[root@vmlnxhom015 openv]# cd /usr/openv
[root@vmlnxhom015 openv]# ll
total 44
drwxr-xr-x.  4 root bin   8192 Nov 12 14:56 java
drwxr-xr-x.  8 root bin  12288 Nov 12 14:56 lib
drwxr-xr-x.  7 root root    84 Nov 12 14:25 logs
drwxr-xr-x.  2 root bin     19 Nov 12 14:56 msg
drwxr-xr-x. 10 root bin   4096 Nov 18 17:07 netbackup
drwxr-xr-x.  2 root bin     29 Nov 12 14:24 pack
drwxr-xr-x.  7 root bin     85 Jun 24  2019 pdde
drwxr-xr-x. 81 root bin   4096 Jun 25  2019 resources
drwxr-xr-x.  2 root bin     25 Nov 12 14:56 share
drwxr-xr-x.  4 root bin   4096 Nov 12 15:41 tmp
drwxr-xr-x. 13 root bin   4096 Nov 12 14:56 var
[root@vmlnxhom015 openv]#
[root@vmlnxhom015 openv]# pwd
/usr/openv

rm -rf *

[root@vmlnxhom015 openv]# rm -rf *