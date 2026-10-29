--  VERIFICAR UTILIZAÇÃO DO AWR

set lines 200 pages 999
break on version skip 1
select version, name, detected_usages, currently_used, first_usage_date, last_usage_date
 from DBA_FEATURE_USAGE_STATISTICS
where detected_usages > 0 and (name like '%Repository%' or name like '%AWR%') order by 1, 2;


--  COMO DESATIVAR O AWR

col SNAP_INTERVAL for a30
col RETENTION for a30
select * from dba_hist_wr_control;

execute DBMS_WORKLOAD_REPOSITORY.MODIFY_SNAPSHOT_SETTINGS(interval=>0);

col SNAP_INTERVAL for a30
col RETENTION for a30
select * from dba_hist_wr_control;


-- INSTALAÇÃO DO STATSPACK

O STATSPACK é uma ferramenta de diagnóstico de desempenho, disponível desde a versão Oracle8i, podemos utilizá-lo para analise de problemas de desempenho da instância, 
estes problemas costumam afetar várias aplicações ao mesmo tempo, ou podemos utiliza-lo para identificar instruções SQL consumindo uma quantidade excessiva de recursos da instância 
e com um tempo de resposta insatisfatório para aplicação .

O STATSPACK pode ser utilizado tanto de forma proativa para monitorar a alteração de carga na instância, como reativa para investigar um problema de desempenho.


-- CRIANDO O TABLESPACE DO STATSPACK PARA ARMAZENAMENTO

CREATE TABLESPACE "PERFSTAT" DATAFILE '+DATA' SIZE 100m AUTOEXTEND ON NEXT 100m MAXSIZE 32767m LOGGING ONLINE PERMANENT BLOCKSIZE 8192  EXTENT MANAGEMENT LOCAL AUTOALLOCATE   DEFAULT NOCOMPRESS  SEGMENT SPACE MANAGEMENT AUTO;


/*
Executar o script de criação
Próximo passo é a criação do usuário PERFSTAT e seus respectivos objetos, para isso vamos executar o script SPCREATE.sql que pode ser encontrado no diretório “$ORACLE_HOME/rdbms/admin”. 
Esse script vai executar na sequência 3 scripts:

spcuser.sql que vai criar o usuário PERFSTAT
spctab.sql que vai cria as tabelas e sinônimos
spcpkg.sql que vai cria os pacotes com os programas utilizados pelo STATSPACK

Durante o processo de execução desse script você será solicitado a informar 3 parâmetros:
1) Informar uma senha que será utilizada para o usuário PERFSTAT
2) Informar o nome de uma tablespace que será utilizada como repositório para os dados do STATSPACK.
3) Informar o nome de uma tablespace temporária que deve ser escolhida entre os nomes listados antes dessa solicitação.
*/


-- PERCORRA O CAMINHO ATÉ ONDE ENCONTRA-SE O SCRIPT QUE SERÁ EXECUTADO

[oracle@oracle19c ~]$ cd /u01/app/oracle/product/12.1.0.2/dbhome_1/rdbms/admin/

[oracle@oracle19c admin]$ sqlplus / as sysdba

-- Execute o script spcreate.sql

SQL> start spcreate.sql
--ou
SQL> @spcreate.sql

PFd5h2t2cSts
perfstat123

/*
AJUSTAR O NÍVEL DE COLETA DO STATSPACK

O STATSPACK possui 5 opções de nível de coleta de informações da instância, ao termino da instalação este valor é definido como 5, o nível 10 permite que seja feita a coleta do maior número de 
informações possível, não recomendamos que seja definido este nível na coleta normal do STATSPACK num ambiente de produção pois ele vai consumir mais recurso do banco para faze-lo.

A definição do nível 6, na maioria das situações, será suficiente para fazer analise de problemas de desempenho da instância, para listar a descrição de cada um dos níveis podemos 
utilizar a tabela “stats$level_description”.

Overview of the SNAP level
    4 General Performance Statistics 
    5 Same as Level 4 but including performance-intensive SQL statements - padrão
    6 Same as Level 5 but with SQL plans
    7 Same as Level 6 but with Segment Statistics
    10 Same as Level 7 but with Parent and Child Latches
*/

SQL>  select * from PERFSTAT.STATS$LEVEL_DESCRIPTION;

-- Alterando o nivel de informacoes na coleta (valor padrao igual a 5):
execute statspack.snap(i_snap_level=>7);

-- ou 

execute statspack.snap(i_snap_level=>5);

/*
PROGRAMAR A COLETA DE SNAPSHOTS

Feita a configuração do STATSPACK o próximo passo é programar um JOB para coletar um SNAPSHOT a cada 30 minutos, o intervalo de tempo entre uma coleta de SNAPSHOT 
e outra deve ser definido conforme a necessidade de cada instalação.

Para programar a coleta automática dos SNAPSHOTS vamos utilizar o pacote DBMS_SCHEDULER e para tal precisamos conceder o direito para executar o comando “CREATE JOB” ao usuário PERFSTAT.
*/

grant connect to PERFSTAT;
grant create job to PERFSTAT;

Grant succeeded.
$ exit

sqlplus perfstat/oracle123@ORCL;

Connected.

-- criar scheduler job para criar snaphots de hora em hora (a partir da proxima hora):
begin
    dbms_scheduler.create_job(
    job_name => 'PERFSTAT.JOB_STATSPACK_SNAPSHOT',
    job_type => 'PLSQL_BLOCK',
    job_action => 'begin statspack.snap; end;',
    start_date => TO_TIMESTAMP_TZ(trunc(sysdate)),
    repeat_interval => 'FREQ=hourly; INTERVAL=1;',
    comments => 'Scheduler Job para criar snapshots de hora em hora',
    enabled => TRUE);
end;
/

-- Criar job para apagar snapshots mais velhos que 30 dias:
begin
    dbms_scheduler.create_job(
    job_name => 'PERFSTAT.JOB_STATSPACK_PURGE',
    job_type => 'PLSQL_BLOCK',
    job_action => 'begin statspack.purge(30); end;',
    start_date => SYSTIMESTAMP,
    repeat_interval => 'FREQ=daily; byhour=23;',
    comments => 'Scheduler Job para apagar snapshots mais velhos que 30 dias',
    enabled => TRUE);
end;
/
-- segunda opção de scheduler pra dropar snaps
BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
    job_name            => 'PERFSTAT.statspack_purge_snapshots',
    job_type             => 'PLSQL_BLOCK',
    job_action           => 'STATSPACK.PURGE(I_NUM_DAYS => 3);',
    repeat_interval     => 'FREQ=DAILY; BYHOUR=04; BYMINUTE=30',
    auto_drop           => FALSE,
    comments            => 'Statspack snapshots purge'
  );
  DBMS_SCHEDULER.ENABLE('statspack_purge_snapshots');
END;
/

-- Apagar job caso precise:
EXEC dbms_scheduler.DROP_job(job_name => 'PERFSTAT.JOB_STATSPACK_SNAPSHOT');



-- verificar os schedulers criados do statspack
set lines 200 pages 200;
col JOB_NAME for a26;
col STATE for a9p
col REPEAT_INTERVAL for a35
col JOB_ACTION for a35;
col SCHEDULE_NAME for a25;
col ENABLED for a10
select JOB_NAME, JOB_TYPE, REPEAT_INTERVAL, JOB_ACTION, ENABLED, AUTO_DROP, STATE, TO_CHAR(NEXT_RUN_DATE,'YYYY-MM-DD HH24:MI') as NEXT_RUN 
from DBA_SCHEDULER_JOBS where job_name like '%STATSPACK%';

select JOB_NAME, JOB_TYPE, REPEAT_INTERVAL, JOB_ACTION, ENABLED, AUTO_DROP, STATE, TO_CHAR(NEXT_RUN_DATE,'YYYY-MM-DD HH24:MI') as NEXT_RUN 
from DBA_SCHEDULER_JOBS where OWNER ='SYS';

JOB_NAME                   JOB_TYPE         REPEAT_INTERVAL                     JOB_ACTION                          ENABLED    AUTO_ STATE     NEXT_RUN
-------------------------- ---------------- ----------------------------------- ----------------------------------- ---------- ----- --------- ----------------
JOB_STATSPACK_SNAPSHOT     PLSQL_BLOCK      FREQ=hourly; INTERVAL=1;            begin statspack.snap; end;          TRUE       TRUE  SCHEDULED 2021-10-20 18:00
JOB_STATSPACK_PURGE        PLSQL_BLOCK      FREQ=daily; byhour=23;              begin statspack.purge(30); end;     TRUE       TRUE  SCHEDULED 2021-10-20 23:49


-- VERIFICAR OS SNAPSHOTS DO STATSPACK CRIADOS

alter session set nls_date_format='dd/mm/yyyy hh24:mi';
select SNAP_ID, SNAP_TIME from STATS$SNAPSHOT order by 2;


/*

GERAR UM RELATÓRIO STATSPACK

A geração do relatório STATSPACK e muito simples, basta excutar o script “spreport.sql” que pode ser encontrado no diretório “$ORACLE_HOME/rdbms/admin”, durante a execução do script serão solicitadas três informações: o SNAP_ID inicial, o SNAP_ID final e um nome para o relatório.

O SNAP_ID inicial e SNAP_ID final corresponde ao intervalo de tempo para o qual o relatório STATSPACK será gerado, ou seja, todas as atividades da instância nesse período de tempo serão reportadas em forma de estatísticas para analise.

Antes de solicitar a informação do SNAP_ID inicial o script vai fornecer uma lista de todos os SNAP_ID e suas respectivas datas e horas de geração, escolha os SNAP_ID de acordo com o período que deseja que seja gerado o relatório.
*/


@spreport.sql

/*

GERAR UM PLANO DE EXECUÇÃO

Caso você identifique uma ou mais instrução SQL e queira analisar o plano de execução, é possível gerar o plano de execução utilizando o script “sprepsql.sql” que se encontra no diretório “$ORACLE_HOME/rdbms/admin” e durante sua execução será solicitada a identificação da instrução SQL (Old Hash Value) que é informada no relatório STATSPACK.
*/


@sprepsql.sql


[oracle@odbsrv11 ~]$ cd $ORACLE_HOME/rdbms/admin
[oracle@odbsrv11 admin]$ sqlplus / as sysdba

SQL*Plus: Release 11.2.0.4.0 Production on Thu Nov 19 22:35:43 2015

Copyright (c) 1982, 2013, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, Real Application Clusters, Automatic Storage Management, OLAP,
Data Mining and Real Application Testing options

SQL> @sprepsql.sql

Current Instance
~~~~~~~~~~~~~~~~

   DB Id    DB Name      Inst Num Instance
----------- ------------ -------- ------------
 2991626347 LAB11               1 LAB11  



Instances in this Statspack schema
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   DB Id    Inst Num DB Name      Instance     Host
----------- -------- ------------ ------------ ------------
 2991626347        1 LAB11        LAB11        odbsrv11
                                               
Using 2991626347 for database Id
Using          1 for instance number


Specify the number of days of snapshots to choose from
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Entering the number of days (n) will result in the most recent
(n) days of snapshots being listed.  Pressing <return> without
specifying a number lists all completed snapshots.



Listing all Completed Snapshots

                               Snap                    Snap
Instance     DB Name             Id   Snap Started    Level Comment
------------ ------------ --------- ----------------- ----- --------------------
LAB11  1     LAB11                1 12 Nov 2015 17:13     7
                                  2 12 Nov 2015 18:13     7
                                  3 12 Nov 2015 19:13     7
                                  4 12 Nov 2015 20:13     7
                                  5 12 Nov 2015 21:13     7
                                 11 12 Nov 2015 22:13     7
                                 12 12 Nov 2015 23:13     7
                                 13 13 Nov 2015 00:13     7
                                 14 13 Nov 2015 01:13     7
                                 15 13 Nov 2015 02:13     7
                                 16 13 Nov 2015 03:13     7
                                 17 13 Nov 2015 04:13     7
                                 18 13 Nov 2015 05:13     7
                                 19 13 Nov 2015 06:13     7
                                 20 13 Nov 2015 07:13     7
                                 21 13 Nov 2015 08:13     7
                                 22 13 Nov 2015 09:13     7
                                 23 13 Nov 2015 10:13     7
                                 24 13 Nov 2015 11:13     7
                                 25 13 Nov 2015 12:13     7
                                 26 13 Nov 2015 13:13     7
                                 27 13 Nov 2015 14:13     7
                                 28 13 Nov 2015 15:13     7
                                 29 13 Nov 2015 16:13     7
                                 30 13 Nov 2015 17:13     7
                                 31 13 Nov 2015 18:13     7
                                 32 13 Nov 2015 19:13     7
                                 33 13 Nov 2015 20:13     7
 


Specify the Begin and End Snapshot Ids
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Enter value for begin_snap: 23
Begin Snapshot Id specified: 23

Enter value for end_snap: 25
End   Snapshot Id specified: 25



Specify the old (i.e. pre-10g) Hash Value
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Enter value for hash_value: 116748235
Hash Value specified is: 116748235



Specify the Report Name
~~~~~~~~~~~~~~~~~~~~~~~
The default report file name is sp_23_25_116748235.  To use this name,
press <return> to continue, otherwise enter an alternative.

Enter value for report_name: statsapck_report_23_25_116748235

Using the report name statsapck_report_23_25_116748235


STATSPACK SQL report for Old Hash Value: 116748235  Module: SQL*Plus

DB Name         DB Id    Instance     Inst Num Release     RAC Host
------------ ----------- ------------ -------- ----------- --- ----------------
LAB11         2991626347 LAB11               1 11.2.0.4.0  YES odbsrv11

 Start Id     Start Time         End Id      End Time       Duration(mins)
--------- ------------------- --------- ------------------- --------------
       23 13-Nov-15 10:13:06         25 13-Nov-15 12:13:06          120.00

SQL Statistics
~~~~~~~~~~~~~~
-> CPU and Elapsed Time are in seconds (s) for Statement Total and in
   milliseconds (ms) for Per Execute
                                                       % Snap
                     Statement Total      Per Execute   Total
                     ---------------  ---------------  ------
        Buffer Gets:      1,177,852         65,436.2    5.06
         Disk Reads:        190,545         10,585.8   14.20
     Rows processed:             18              1.0
     CPU Time(s/ms):             28          1,577.4
 Elapsed Time(s/ms):            422         23,420.7
              Sorts:             -1              -.1
        Parse Calls:             18              1.0
      Invalidations:              0
      Version count:              2
    Sharable Mem(K):            361
         Executions:             18

SQL Text
~~~~~~~~
SELECT :"SYS_B_00"||MAX(ROUND(( SUM (total_mb)- SUM (free_mb))/
SUM (max_mb)*:"SYS_B_01")) PCT FROM (    SELECT tablespace_name,
 SUM (bytes)/:"SYS_B_02"/:"SYS_B_03" FREE_MB,    :"SYS_B_04" TOT
AL_MB, :"SYS_B_05" MAX_MB    FROM dba_free_space    GROUP BY tab
lespace_name    UNION ALL    SELECT tablespace_name, :"SYS_B_06"
 CURRENT_MB,    SUM (bytes)/:"SYS_B_07"/:"SYS_B_08" TOTAL_MB,
 SUM ( DECODE (maxbytes,:"SYS_B_09",bytes, maxbytes))/:"SYS_B_10
"/:"SYS_B_11" MAX_MB    FROM dba_data_files    GROUP BY tablespa
ce_name) GROUP BY tablespace_name

Known Optimizer Plan(s) for this Old Hash Value
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Shows all known Optimizer Plans for this database instance, and the Snap Ids
they were first found in the shared pool.  A Plan Hash Value will appear
multiple times if the cost has changed
-> ordered by Snap Id

  First        First           Last           Plan
 Snap Id     Snap Time      Active Time    Hash Value        Cost
--------- --------------- --------------- ------------ ----------
        1 12-Nov-15 17:13 18-Nov-15 00:12    874526296       112
       11 12-Nov-15 22:13 12-Nov-15 21:33   3155862605       106
       15 13-Nov-15 02:13 17-Nov-15 21:34   3933858862       112
      164 18-Nov-15 01:13 19-Nov-15 02:42   2569970882       114
      164 18-Nov-15 01:13 19-Nov-15 22:12   3933858862       114

Plans in shared pool between Begin and End Snap Ids
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Shows the Execution Plans found in the shared pool between the begin and end
snapshots specified.  The values for Rows, Bytes and Cost shown below are those
which existed at the time the first-ever snapshot captured this plan - these
values often change over time, and so may not be indicative of current values
-> Rows indicates Cardinality, PHV is Plan Hash Value
-> ordered by Plan Hash Value

--------------------------------------------------------------------------------
| Operation                      | PHV/Object Name     |  Rows | Bytes|   Cost |




-- PARAR EXECUÇÃO DO JOB

BEGIN
  DBMS_SCHEDULER.STOP_JOB('STATSPACK_PURGE_SNAPSHOTS');
END;
/


/*

REMOVER A INSTALAÇÃO DO STATSPACK

Para finalizar, se por alguma razão você não for mais utilizar o STATSPACK, poderá remove-lo utilizando o script “spdrop.sql” que pode ser encontrado no diretório “$ORACLE_HOME/rdbms/admin”, não se esqueça que você precisa de um usuário SYSDBA para executar esse script e ao final da execução desse script, remova os JOBS criados para automatizar os processos e elimine a tablespace do repositório do STATSPACK se ela era de uso exclusivo deste.
*/


-- REALIZAR A PARADA E A EXCLUSÃO DO JOB de PURGE

BEGIN 
EXEC DBMS_SCHEDULER.STOP_JOB(job_name=>'STATSPACK_PURGE_SNAPSHOTS', force=>true);
END;
/

BEGIN 
SYS.DBMS_SCHEDULER.DROP_JOB (job_name => 'SYS.STATSPACK_PURGE_SNAPSHOTS');
END;
/ 


-- REALIZAR A PARADA E A EXCLUSÃO DO JOB DE COLETA STATSPACK


BEGIN 
EXEC DBMS_SCHEDULER.STOP_JOB(job_name=>'STATSPACK_SNAPSHOT', force=>true);
END;
/

BEGIN 
SYS.DBMS_SCHEDULER.DROP_JOB (job_name => 'STATSPACK_SNAPSHOT');
END;
/

BEGIN
  DBMS_SCHEDULER.drop_schedule (schedule_name => 'statspack_snap_30min');
END;
/



/*

CONCLUSÃO

O STATSPACK pode suprir a maioria das informações fornecidas no relatório AWR, mas se além do STATSPACK você decidir adquirir algum software de Performance e Tuning,
observe se ele não acessa alguma visão que faz parte da Option “Diagnostic Pack License” pois a utilização dessas visões também requerem a contratação da licença.
*/


