-- referencia
https://support.oracle.com/epmos/faces/DocumentDisplay?_afrLoop=477574283303287&parent=SrDetailText&sourceId=3-13260168871&id=336133.1&_afrWindowMode=0&_adf.ctrl-state=ssx3pebsf_4

-- verifica o se existe blocos corrompidos
SELECT e.owner, e.segment_type, e.segment_name, e.partition_name, c.file#
     , greatest(e.block_id, c.block#) corr_start_block#
     , least(e.block_id+e.blocks-1, c.block#+c.blocks-1) corr_end_block#
     , least(e.block_id+e.blocks-1, c.block#+c.blocks-1) 
       - greatest(e.block_id, c.block#) + 1 blocks_corrupted
     , null description
  FROM dba_extents e, v$database_block_corruption c
 WHERE e.file_id = c.file#
   AND e.block_id <= c.block# + c.blocks - 1
   AND e.block_id + e.blocks - 1 >= c.block#
UNION
SELECT s.owner, s.segment_type, s.segment_name, s.partition_name, c.file#
     , header_block corr_start_block#
     , header_block corr_end_block#
     , 1 blocks_corrupted
     , 'Segment Header' description
  FROM dba_segments s, v$database_block_corruption c
 WHERE s.header_file = c.file#
   AND s.header_block between c.block# and c.block# + c.blocks - 1
UNION
SELECT null owner, null segment_type, null segment_name, null partition_name, c.file#
     , greatest(f.block_id, c.block#) corr_start_block#
     , least(f.block_id+f.blocks-1, c.block#+c.blocks-1) corr_end_block#
     , least(f.block_id+f.blocks-1, c.block#+c.blocks-1) 
       - greatest(f.block_id, c.block#) + 1 blocks_corrupted
     , 'Free Block' description
  FROM dba_free_space f, v$database_block_corruption c
 WHERE f.file_id = c.file#
   AND f.block_id <= c.block# + c.blocks - 1
   AND f.block_id + f.blocks - 1 >= c.block#
order by file#, corr_start_block#;

-- verifica o extent
select segment_name, segment_type, owner
from dba_extents
where file_id = 29
and 253509 between block_id
and block_id + blocks -1;

-- para marcar o bloco como corrompido devemos executar o comando abaixo no rman
VALIDATE DATABASE;

-- verifica se existe bloco corrompido 
select * from v$database_block_corruption;

--ou

-- Exectar no rman
backup validate check logical datafile 27 ; 

-- verifica em qual objeto está alocado o bloco corrompido
select segment_name, segment_type, owner
from dba_extents
where file_id = 28
and 401294 between block_id
and block_id + blocks -1;

-- criar trigger 
CREATE OR REPLACE TRIGGER corrupt_trigger 
  AFTER INSERT ON DBSKYONE.s 
  REFERENCING OLD AS p_old NEW AS new_p 
  FOR EACH ROW 
DECLARE 
  corrupt EXCEPTION; 
BEGIN 
  IF (dbms_rowid.rowid_block_number(:new_p.rowid)=&blocknumber)
 and (dbms_rowid.rowid_relative_fno(:new_p.rowid)=&filenumber) THEN 
     RAISE corrupt; 
  END IF; 
EXCEPTION 
  WHEN corrupt THEN 
     RAISE_APPLICATION_ERROR(-20000, 'Corrupt block has been formatted'); 
END; 
/

-- verificar dba_free_space
select BYTES from dba_free_space where file_id=28 and 401294 between block_id and block_id + blocks -1;

     BYTES
----------
   8388608


-- Alterar a tabela
alter table DBSKYONE.s allocate extent (DATAFILE '+DATA/orcl/tsd_nddigital03.dbf' size 8m);

BEGIN
for i in 1..10000 loop
EXECUTE IMMEDIATE 'alter table owner.s allocate extent (DATAFILE '||'''+DATA/orcl/tsd_nddigital03.dbf''' ||'SIZE 8m) ';
end loop;
end ;
/

-- continuar alocando até o bloco fazer parte da tabela s
select segment_name, segment_type, owner
from dba_extents
where file_id = 27
and 2956297 between block_id
and block_id + blocks -1 ;

--Insira os dados na tabela fictícia para formatar o bloco
BEGIN
FOR i IN 1..1000000000 LOOP
INSERT /*+ APPEND */ INTO <username>.s select i, lpad('REFORMAT',3092, 'R') from dual;
commit ;
END LOOP;
END;

--OU 

BEGIN
  FOR i IN 1..1000000000 LOOP
    INSERT INTO <username>.s VALUES(i,'x');
  END LOOP;
END;
/
-- Ou use o código abaixo, que inclui 2 loops:

Begin
  FOR i IN 1..1000000000 loop
    for j IN 1..1000 loop
      Insert into <username>.s VALUES(i,'x');
    end loop;
    commit;
  END LOOP;
END; 

-- deverá reotrnar um ORA-20000, ai estará confirmado a correção do bloco corrompido.

ERROR at line 1:
ORA-20000: Corrupt block has been formatted
ORA-06512: at "owner.CORRUPT_TRIGGER", line 10
ORA-04088: error during execution of trigger 'owner.CORRUPT_TRIGGER'
ORA-06512: at line 3


-- Executar comando abaixo no rman para confirmar a limpeza do bloco
backup validate check logical datafile 27 ; 
 -- ou 
validate datafile 28 block 401294;

validate datafile 29 block 2839105;

-- ou caso tenha mais de 1 bloco corrompido
validate datafile 27 block 2956297,2956296,2956297 ... ;
