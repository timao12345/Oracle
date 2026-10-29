chkconfig  --list oracleasm

Em teste só executo o procedimento: chkconfig --level 2345 oracleasm on   e faço o boot da maquina , todos os serviços devem subir automaticamente se configurado corretamente

Start ASMlib manually 
As root OS user,
/etc/init.d/oracleasm start
b.Validate all ASMlibs are getting listed or not.
/etc/init.d/oracleasm listdisks
c. If all ASMlib are listing ,start the cluster normally,
$ crsctl start crs
d. Then enable asmlib service.
chkconfig --level 2345 oracleasm on
