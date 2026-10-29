-- usar comando para ver qual undo está setada no banco
show parameter undo;

-- criar a undo nova
CREATE UNDO TABLESPACE PSAPUNDO1 DATAFILE '+DATAC3' SIZE 1767m AUTOEXTEND ON NEXT 100M;
CREATE UNDO TABLESPACE UNDOTBS02 DATAFILE '+DATAC2' SIZE 32767m AUTOEXTEND ON NEXT 100M;

--alterar no banco para apontar para a nova undo.
ALTER SYSTEM SET UNDO_TABLESPACE=PSAPUNDO1;

-- dropar a undo antiga
DROP TABLESPACE UNDOTBS2 INCLUDING CONTENTS AND DATAFILES;

DROP TABLESPACE UNDOTBS2 INCLUDING CONTENTS AND DATAFILES;

-- alterar op spfile;
ALTER SYSTEM SET undo_tablespace=PSAPUNDO1 SCOPE=SPFILE SID='pds1';
ALTER SYSTEM SET undo_tablespace=PSAPUNDO2 SCOPE=SPFILE SID='pds2';

alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;
alter tablespace UNDOTBS02 add datafile '+DATAC2' size 32767m;



ALTER SYSTEM SET service_names='ECC,ECC001' SCOPE=SPFILE SID='ECC001';
ALTER SYSTEM SET service_names='ECC,ECC002' SCOPE=SPFILE SID='ECC002';

CREATE UNDO TABLESPACE UNDOTBS2 DATAFILE '+DATAC1' SIZE 1445m AUTOEXTEND ON NEXT 100M;