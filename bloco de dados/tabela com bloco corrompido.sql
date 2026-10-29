-- Processo para encontrar blocos corrompidos em uma tabela a partir de um ORA-0600

-- Qualquer outra duvida veiricar a Doc ID 816784.1 https://support.oracle.com/epmos/faces/DocumentDisplay?_afrLoop=220245024967150&id=816784.1&_afrWindowMode=0&_adf.ctrl-state=w748gzylk_53

 -- Alert log encontrado
18-JAN-22 01.25.28.431 PM -03:00    Errors in file /u01/app/oracle/diag/rdbms/orcl_gru15k/ORCL/trace/ORCL_ora_46801.
                                    trc  (incident=369991):
                                    ORA-00600: codigo de erro interno, argumentos: [13013], [5001], [85849], [124473921], [50], [935700519], [17], [], [], [], [], []



A Oracle está tentando obter um conjunto estável de linhas para atualizar e não conseguiu, após 5001 tentativas.

--Aqui está o que os argumentos significam:

[2252] ==> indica que o problema é uma falha na identificação de um conjunto estável de linhas para atualização
[7288] ==> o número de vezes que o Oracle tentou
[2527728629] => O número do objeto de dados ( SELECT * FROM DBA_OBJECTS WHERE DATA_OBJECT_ID = 3066448)
[4286] => Endereço do bloco de dados relativo ao tablespace
[1243987968] ==> número do slot da linha
[1243987968] ==> endereço do bloco de dados relativo decimal do bloco que está sendo atualizado
[17] ==> código interno
[] ==> não usado

ORA-00600: internal error code, arguments: [2252], [7288], [2527728629], [4286], [1243987968], [], [], [], [], [], [], []

select * from v$database_block_corruption;

-- Lista o objeto a partir do data_object_id

select owner,object_name from DBA_OBJECTS WHERE DATA_OBJECT_ID = 4286;

select owner,object_name from DBA_OBJECTS WHERE OBJECT_NAME='FO_CONTRIB_HIST';

-- Verifica o tamanho do objeto
select owner,SEGMENT_NAME, sum(bytes)/1024/1024 as MB from dba_segments where owner='SYSTEM' and SEGMENT_NAME='MVIEW$_ADV_PRETTY_IDX_01' GROUP BY owner,SEGMENT_NAME;

-- Realiza o analyze ONLINE no objeto  para encontrar blocos corrompidos ()
--Se o comando abaixo falhar com ORA-1498 indica bloco corrompido
analyze table SYSTEM.MVIEW$_ADV_PRETTY  validate structure online;



-- Caso comand acima não gerou erro execute o abaixo.
-- Se o comando acima errar com ora-1499, isso indica uma corrupção no index.
Analyze table NDD_CONNECTOR.TBSTATISTICS validate structure cascade online ;

-- Encontra o datafile e numero do bloco
select dbms_utility.data_block_address_file(3066448) Rfile# ,dbms_utility.data_block_address_block(609425) "Block#" from dual;

    RFILE#     Block#
---------- ----------
        37    2839105


SQL> Select name from v$datafile where FILE#=1530;

NAME
----------------------------------
+DATA/orcl/tsd_consinco13.dbf

SQL>

-- Usar o dbverify
dbv file='+DATA/unicom_gru1xg/datafile/data_d-unicom_ts-tdindex150k_fno-1042' blocksize=8192


set verify off

select file#,
dbms_utility.data_block_address_block(
to_number('&hex_rdba','0x24342a56')) block#
from sys.v$datafile
where ts# = &tsn
and rfile# = dbms_utility.data_block_address_file(
to_number('&hex_rdba','0x24342a56'));


-- retorna o objeto em que o bloco está populado
select owner,SEGMENT_NAME,TABLESPACE_NAME,FILE_ID,BLOCK_ID from DBA_EXTENTS where BLOCK_ID=609425;


select * from v$database_block_corruption where CORRUPTION_TYPE='CORRUPT';

select * from v$database_block_corruption where BLOCK#=609425;














