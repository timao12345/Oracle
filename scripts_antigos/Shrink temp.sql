SQL> SELECT * FROM dba_temp_free_space;

TABLESPACE_NAME                TABLESPACE_SIZE ALLOCATED_SPACE FREE_SPACE
------------------------------ --------------- --------------- ----------
TEMP                                  56623104        56623104   55574528

1 row selected.

SQL>
Armed with this information, you can perform an online shrink of a temporary tablespace using the ALTER TABLESPACE command.

SQL> ALTER TABLESPACE temp SHRINK SPACE KEEP 40M;

Tablespace altered.

SQL> SELECT * FROM dba_temp_free_space;

TABLESPACE_NAME                TABLESPACE_SIZE ALLOCATED_SPACE FREE_SPACE
------------------------------ --------------- --------------- ----------
TEMP                                  42991616         1048576   41943040

1 row selected.

SQL>
The shrink can also be directed to a specific tempfile using the TEMPFILE clause.

SQL> ALTER TABLESPACE temp SHRINK TEMPFILE '/u01/app/oracle/oradata/DB11G/temp01.dbf' KEEP 30M;

Tablespace altered.

SQL> SELECT * FROM dba_temp_free_space;

TABLESPACE_NAME                TABLESPACE_SIZE ALLOCATED_SPACE FREE_SPACE
------------------------------ --------------- --------------- ----------
TEMP                                  31522816           65536   31457280

1 row selected.

SQL>

--Verifica objectos e extends do banco de dados, para depois realizar move nos objetos para blocks anterior a marca dagua

select file_id, block_id, blocks*8192/1024 MB,owner || '.' || segment_name "Name", block_id*8192/1024 "Position MB"
from  sys.dba_Extents 
where file_id = 12
union
select file_id, block_id, blocks*8192/1024, 'Free' "Name", block_id*8192/1024 "Position MB"
from sys.dba_free_space
where file_id = 12
order by 1,2,3;

https://www.siltechconsult.com.br/post/oracle-ora-03297-file-contains-used-data-beyond-requested-resize-value