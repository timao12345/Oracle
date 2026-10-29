SIA.ALUNO_CURSO AC 
INTERNET.SMO_PARTICIPACAO_SIMULADO PS 
SIA.PERIODO_ACADEMICO
INTERNET.SMO_RESPOSTA_SIMULADO RS, 

select OWNER, TABLE_NAME, NUM_ROWS, LAST_ANALYZED from dba_tables where OWNER='SIA' and TABLE_NAME='ALUNO_CURSO'
select OWNER, TABLE_NAME, NUM_ROWS, LAST_ANALYZED from dba_tables where OWNER='INTERNET' and TABLE_NAME='SMO_PARTICIPACAO_SIMULADO'
select OWNER, TABLE_NAME, NUM_ROWS, LAST_ANALYZED from dba_tables where OWNER='SIA' and TABLE_NAME='PERIODO_ACADEMICO'
select OWNER, TABLE_NAME, NUM_ROWS, LAST_ANALYZED from dba_tables where OWNER='INTERNET' and TABLE_NAME='SMO_RESPOSTA_SIMULADO'

select sum(bytes)/1024/1024/1024 from dba_segments where owner='SIA' and segment_name='ALUNO_CURSO';
select sum(bytes)/1024/1024/1024 from dba_segments where owner='INTERNET' and segment_name='SMO_PARTICIPACAO_SIMULADO';
select sum(bytes)/1024/1024 from dba_segments where owner='SIA' and segment_name='PERIODO_ACADEMICO';
select sum(bytes)/1024/1024/1024 from dba_segments where owner='INTERNET' and segment_name='SMO_RESPOSTA_SIMULADO';

select sum(bytes)/1024/1024 from dba_segments where owner='SIA' and segment_name=' I_PERIODO_ACADEMICO_14';

PERIODO_ACADEMICO

OWNER                          TABLE_NAME                       NUM_ROWS LAST_ANA
------------------------------ ------------------------------ ---------- --------
SIA                            ALUNO_CURSO                       2108983 08/11/14

OWNER                          TABLE_NAME                       NUM_ROWS LAST_ANA
------------------------------ ------------------------------ ---------- --------
INTERNET                       SMO_PARTICIPACAO_SIMULADO         4486750 09/11/14

OWNER                          TABLE_NAME                       NUM_ROWS LAST_ANA
------------------------------ ------------------------------ ---------- --------
SIA                            PERIODO_ACADEMICO                    5199 09/11/14

OWNER                          TABLE_NAME                       NUM_ROWS LAST_ANA
------------------------------ ------------------------------ ---------- --------
INTERNET                       SMO_RESPOSTA_SIMULADO            47101020 09/11/14


SQL> select sum(bytes)/1024/1024/1024 from dba_segments where owner='SIA' and segment_name='ALUNO_CURSO';

SUM(BYTES)/1024/1024/1024
-------------------------
                       ,5

SQL> select sum(bytes)/1024/1024/1024 from dba_segments where owner='INTERNET' and segment_name='SMO_PARTICIPACAO_SIMULADO';

SUM(BYTES)/1024/1024/1024
-------------------------
                 ,3984375

SQL> select sum(bytes)/1024/1024/1024 from dba_segments where owner='SIA' and segment_name='PERIODO_ACADEMICO';

SUM(BYTES)/1024/1024/1024
-------------------------
               ,001953125

SQL> select sum(bytes)/1024/1024/1024 from dba_segments where owner='INTERNET' and segment_name='SMO_RESPOSTA_SIMULADO';

SUM(BYTES)/1024/1024/1024
-------------------------
               3,25097656

				 

