    Thread Ultima Sequencia Recebida Ultima Sequencia Aplicada  Diferenca
---------- ------------------------- ------------------------- ----------
         1                    118281                    118263         18
         2                    118610                    118582         28


primario desde 118268 thread 1



1_118284_818087961.dbf
2_118612_818087961.dbf




[oracle@drdbtb775 scripts]$ cat comandos_rman.rcv
catalog start with '/replicacao/MIDDLE/archives/' noprompt;
crosscheck archivelog all;
delete noprompt archivelog all completed before 'sysdate-2' ;
recover database;
exit;





run {
set until sequence 118282 thread 1;
recover database;
}
















[oracle@drdbtb775 archives]$ cd ../
[oracle@drdbtb775 MIDDLE]$ crontab -l
### Sincronismo de archives:
### Replicacao CHANGE:
59 * * * *      sh /replicacao/CHANGE/scripts/sincronismo.sh

### Replicacao MIDDLE:
49 * * * *      sh /replicacao/MIDDLE/scripts/sincronismo.sh

### Replicacao MATERA:
39 * * * *      sh /replicacao/MATERA/scripts/sincronismo.sh

### Replicacao JDBCCHST:
29 * * * *      sh /replicacao/JDBCCHST/scripts/sincronismo.sh

### Replicacao JDBCC:
19 * * * *      sh /replicacao/JDBCC/scripts/sincronismo.sh

### Replicacao ORION
09 * * * *      sh /replicacao/ORION/scripts/sincronismo.sh

### Replicacao CHANGEBK:
25 * * * *      sh /replicacao/CHANGEBK/scripts/sincronismo.sh
[oracle@drdbtb775 MIDDLE]$











run {

allocate channel c1 type 'sbt_tape';
send 'NB_ORA_CLIENT=DBTB775ANEW.servicos,NB_ORA_SERV=IPBTBMS1,NB_ORA_POLICY=Sha.Ora.Catalog.Arc';
SET ARCHIVELOG DESTINATION TO '/replicacao/ORION/archives';
restore archivelog from logseq=72480 until logseq=72922 thread 1;
release channel c1;
}


run {

allocate channel c1 type 'sbt_tape';
send 'NB_ORA_CLIENT=DBTB775ANEW.servicos,NB_ORA_SERV=IPBTBMS1,NB_ORA_POLICY=Sha.Ora.Catalog.Arc';
SET ARCHIVELOG DESTINATION TO '/replicacao/CHANGE/archives';
restore archivelog logseq=104110 thread 1;
release channel c1;
}