Apaga Archive no Standby Logico
delete noprompt foreign archivelog until time 'sysdate-1';


deleta at� esta sequencia.
delete archivelog until sequence 11904;
 
list archivelog until sequence 11922;

list archivelog until time 'SYSDATE-1';
delete archivelog until time 'SYSDATE-1'; 

deleta aparti desta sequencia
delete archivelog from sequence 9264;

Lista os archives que est�o em disco.
list archivelog from logseq 56744 until logseq 56774 thread 1;

Lista os archives que foram feito o backup.
list backup of archivelog from logseq 760 until logseq 766 thread 1;



list archivelog from logseq 9256 until logseq 9264 thread 1;

Deleta um dia de backup


DELETE ARCHIVELOG ALL from logseq 9256 until logseq 9264; 
delete archivelog all until sequence 9264;
delete archivelog until sequence 9264;

DELETE NOPROMPT ARCHIVELOG ALL COMPLETED BEFORE 'SYSDATE-1'; 
list backup of ARCHIVELOG ALL COMPLETED BEFORE 'SYSDATE-1/2'; 
list backup of ARCHIVELOG ALL COMPLETED AFTER 'SYSDATE-1/2'; 
Este � usado para limpar o archives backupeados anterior a um dia. (Usar este)

list backup of ARCHIVELOG ALL COMPLETED AFTER 'SYSDATE-30'; 

list ARCHIVELOG until time  'SYSDATE-30'; 
allocate channel for maintenance type disk;

RMAN> allocate channel for maintenance type disk; 
RMAN> delete obsolete device type disk;
 

DELETE ARCHIVELOG until time 'SYSDATE-1/2'; 

DELETE ARCHIVELOG ALL COMPLETED AFTER 'SYSDATE-1'; 

DELETE ARCHIVELOG ALL COMPLETED AFTER 'SYSDATE-1'; 


DELETE ARCHIVELOG ALL COMPLETED until sequence 9741; 



list expired archivelog ALL;

delete archivelog all backed up 1 times to device type sbt completed BEFORE 'SYSDATE-1'; 

COMPLETION_TIME       SEQUENCE# ARC APP DEL
-------------------- ---------- --- --- ---
23/09/2014 21:33           9741 YES YES NO

list backup of ARCHIVELOG ALL COMPLETED from 9741
]

CONFIGURE ARCHIVELOG DELETION POLICY TO APPLIED ON STANDBY;


list backup of ARCHIVELOG until time 'SYSDATE-1/2'; 

list backup of ARCHIVELOG until sequence 9741; 

deleted archive log
archive log filename=+ORAFRA/standbydb/archivelog/2014_09_23/thread_4_seq_9754.2851.859067035 recid=2894 stamp=859067035




RMAN>list archivelog all;
RMAN>list copy of archivelog until time �SYSDATE-10';
RMAN>list copy of archivelog from time �SYSDATE-10'
RMAN>list copy of archivelog from time �SYSDATE-10' until time �SYSDATE-2';
RMAN>list copy of archivelog from sequence 1000;
RMAN>list copy of archivelog until sequence 1500;
RMAN>list copy of archivelog from sequence 1000 until sequence 1500;

RMAN>delete archivelog all;
RMAN>delete archivelog until time �SYSDATE-10';
RMAN>delete archivelog from time �SYSDATE-10'
RMAN>delete archivelog from time �SYSDATE-10' until time �SYSDATE-2';
RMAN>delete archivelog from sequence 1000;
RMAN>delete archivelog until sequence 1500;
RMAN>delete archivelog from sequence 1000 until sequence 1500;

Note : Also, you can use noprompt statement for do not yes-no question.
RMAN>delete noprompt archivelog until time �SYSDATE-10';

