-- Lista archives expirados
list expired archivelog ALL;

-- Lista Archives
LIST BACKUP OF ARCHIVELOG FROM TIME 'sysdate-1';

LIST BACKUP OF DATABASE FROM TIME 'sysdate-1';

list backup of ARCHIVELOG until time 'SYSDATE-1/2'; 

list archivelog until time 'SYSDATE-1';

list backup of ARCHIVELOG ALL COMPLETED from 9747;

list backup of ARCHIVELOG ALL COMPLETED BEFORE 'SYSDATE-1/2'; 

list backup of ARCHIVELOG ALL COMPLETED AFTER 'SYSDATE-1/2'; 

list backup of ARCHIVELOG until sequence 9741; 

list backup of ARCHIVELOG ALL COMPLETED AFTER 'SYSDATE-30'; 

list ARCHIVELOG until time  'SYSDATE-30'; 

-- Lista archives até a sequencia
list archivelog until sequence 11922;

-- Lista backup a partir de um filesystem ou diskgroup
list backup of ARCHIVELOG like '+RECO/DB0125_vcp1tb/ARCHIVELOG/2022_02_15/*135*';

--Lista os archives que est�o em disco.
list archivelog from logseq 56744 until logseq 56774 thread 1;

--Lista os archives que foram feito o backup.
list backup of archivelog from logseq 760 until logseq 766 thread 1;

list archivelog from logseq 9256 until logseq 9264 thread 1;

-- Deleta até esta sequencia.
delete archivelog until sequence 135714;
 
-- Deleta archives que já tevem backup pelo menos 1 vez a partir de D-1 (deixando 1 dia)
delete archivelog all backed up 1 times to device type sbt completed BEFORE 'SYSDATE-1'; 

-- Deleta Archive no Standby Logico

delete noprompt foreign archivelog until time 'sysdate-1';

-- FORÇA A DELETAR ACRHIVES COM MAIS DE 2 DIAS PARA TRAZ DEIXANDO 2 DIAS DE ARCHIVES
delete force archivelog until time  'sysdate -2';

-- Força a deletar archives a partir de um filesystem ou diskgroup
delete force archivelog like '+RECO/prod4/archivelog/2011_10_03/*17*';

delete archivelog like '+RECO/DB0125_vcp1tb/ARCHIVELOG/2022_02_15/*';

delete archivelog like '+RECO/DB0125_vcp1tb/ARCHIVELOG/2022_02_15/thread_1_seq_135*';

delete archive log archive log filename='+ORAFRA/standbydb/archivelog/2014_09_23/thread_4_seq_9754.2851.859067035 recid=2894 stamp=859067035';

-- Deleta a partir desta sequencia
delete archivelog from sequence 9264;

DELETE ARCHIVELOG ALL from logseq 9256 until logseq 9264; 

delete archivelog all until sequence 9264;

delete archivelog until sequence 9264;

-- Outro tipos de delete
DELETE NOPROMPT BACKUP COMPLETED BEFORE 'SYSDATE-2'; 

delete obsolete device type disk;
 
delete noprompt force archivelog until time 'sysdate-1';

DELETE ARCHIVELOG force until time 'SYSDATE-2'; 

DELETE ARCHIVELOG ALL COMPLETED AFTER 'SYSDATE-1'; 

DELETE ARCHIVELOG ALL COMPLETED AFTER 'SYSDATE-1'; 

-- Força a deletar todos archives completados a anterior a 2 dias.
DELETE NOPROMPT ARCHIVELOG ALL FORCE COMPLETED BEFORE 'SYSDATE-2'; 

delete archivelog all force; 


list archivelog all;
list copy of archivelog until time 'SYSDATE-10';
list copy of archivelog from time 'SYSDATE-10';
list copy of archivelog from time 'SYSDATE-10' until time 'SYSDATE-2';
list copy of archivelog from sequence 1000;
list copy of archivelog until sequence 1500;
list copy of archivelog from sequence 1000 until sequence 1500;
delete archivelog all;
delete archivelog until time 'SYSDATE-10';
delete archivelog from time 'SYSDATE-10';
delete archivelog from time 'SYSDATE-10' until time 'SYSDATE-2';
delete archivelog from sequence 1000;
delete archivelog until sequence 1500;
delete archivelog from sequence 1000 until sequence 1500;
delete noprompt archivelog until time 'SYSDATE-10';

-- Politicas.
show all;

CONFIGURE ARCHIVELOG DELETION POLICY TO APPLIED ON STANDBY;