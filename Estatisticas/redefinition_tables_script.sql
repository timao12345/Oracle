begin

   -- Script para redefini��o da tabela de log EMLAH$ERROR
   -- Este script ir� usar a redefini��o online para implementar um novo layout f�sico para a tabela
   -- Ao final do script ser� mantida no banco a tabela original renomeada, para efeito de backup
   -- Esta tabela ser� exclu�da em outra mudan�a, ap�s a certifica��o desta mudan�a
   
   -- Tag de monitoramento
   DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GMUD 16532',  action_name => 'In�cio'); 

   -- Aguardar at� 5 minutos a libera��o de locks para os DDLs prosseguirem
   execute immediate 'ALTER SESSION SET ddl_lock_timeout=300';

   -- Abortar a redefini��o corrente, caso ainda esteja pendente
   DBMS_REDEFINITION.ABORT_REDEF_TABLE (uname       => 'ELMAH',  orig_table  => 'ELMAH$ERROR', int_table   => 'ELMAH$ERROR_INTERIM');

   -- Caso a tabela interina esteja presente no ambiente, dropar
   declare
      v_contagem pls_integer := 0;
   begin

      -- identificar a presen�a da tabela interina no banco
      select count(1) 
       into v_contagem
      from dba_tables 
      where owner = 'ELMAH' and table_name = 'ELMAH$ERROR_INTERIM';
      
                  -- se a tabela estiver presente, dropar
      if v_contagem = 1 then
      
                  
                               -- Tag de monitoramento
                               DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GMUD 16532',  action_name => 'Drop da tabela interina'); 

         execute immediate 'drop table ELMAH.ELMAH$ERROR_INTERIM cascade constraints';
      
      end if;
      
   end;

   -- Verificar se a redefini��o pode ser realizada, usando o crit�rio da chave prim�ria
   -- Caso n�o seja poss�vel, esta procedure ir� gerar uma EXCEPTION e abortar� o script
   DBMS_REDEFINITION.CAN_REDEF_TABLE (uname => 'ELMAH', tname => 'ELMAH$ERROR', options_flag  => dbms_redefinition.cons_use_pk);


   
   -- Criar a tabela interina para uso na redefini��o
   execute immediate q'[
      create table ELMAH.ELMAH$ERROR_INTERIM (
         ERRORID nvarchar2(32) default sys_guid(),
         APPLICATION nvarchar2(60),
         HOST nvarchar2(30),
         TYPE nvarchar2(100),
         SOURCE nvarchar2(60),
         MESSAGE nvarchar2(500),
         USERNAME nvarchar2(50),
         STATUSCODE     number,
         TIMEUTC        date,
         SEQUENCENUMBER number,
         ALLXML nclob

      ) pctfree 0 compress for oltp tablespace ELMAH_BFT_01 
        lob (ALLXML) store as securefile (tablespace ELMAH_BFT_01 nocache compress low deduplicate DISABLE STORAGE IN ROW )
        partition by range (TIMEUTC) interval ( numtodsinterval(1, 'DAY')) (
        partition p_0001 values less than(to_date(' 2014-09-16 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
    )]';
  
 
   -- Iniciar a redefini��o, isto criar� os objetos de apoio e copiar� os dados para a tabela interina
   begin
   
                -- Tag de monitoramento
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GMUD 16532',  action_name => 'START_REDEF_TABLE'); 

   
     -- O uso de parallel execution visa completar a opera��o em menos tempo, uma vez que os comandos ir�o movimentar uma grande quantidade de dados
     EXECUTE IMMEDIATE 'alter session force parallel dml parallel 8';
     EXECUTE IMMEDIATE 'alter session force parallel query parallel 8';
   
     DBMS_REDEFINITION.START_REDEF_TABLE ( uname => 'ELMAH', orig_table => 'ELMAH$ERROR', int_table => 'ELMAH$ERROR_INTERIM', options_flag   =>  dbms_redefinition.cons_use_pk);
      
   end;

   -- Tag de monitoramento
   DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GMUD 16532',  action_name => '�ndice ELMAH.IDX_ELMAH$ERROR_INT'); 

   
   -- Criar manualmente os �ndices que ser�o modificados
   execute immediate 'create index ELMAH.IDX_ELMAH$ERROR_INT on ELMAH.ELMAH$ERROR_INTERIM (APPLICATION , TIMEUTC desc, SEQUENCENUMBER desc ) local tablespace elmah_bft_01';

   
   -- Registrar os �ndices modificados para n�o serem copiados da tabela original
   DBMS_REDEFINITION.REGISTER_DEPENDENT_OBJECT(uname => 'ELMAH', orig_table => 'ELMAH$ERROR', int_table => 'ELMAH$ERROR_INTERIM', dep_type => DBMS_REDEFINITION.cons_index, dep_owner => 'ELMAH', dep_orig_name => 'IDX_ELMAH$ERROR_APP_TIME_SEQ', dep_int_name => 'IDX_ELMAH$ERROR_INT');

   

   -- Tag de monitoramento
   DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GMUD 16532',  action_name => 'Sincronia intermedi�ria'); 

   -- Sincronia de dados intermedi�ria
   DBMS_REDEFINITION.SYNC_INTERIM_TABLE (uname => 'ELMAH', orig_table => 'ELMAH$ERROR', int_table => 'ELMAH$ERROR_INTERIM');
   
   -- Tag de monitoramento
   DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GMUD 16532',  action_name => 'Copiando depend�ncias'); 

   -- Copiar os objetos dependentes (�ndices n�o modificados, constraints, triggers ,...)
   declare
  
     v_erros pls_integer;
     
   begin
   
   DBMS_REDEFINITION.COPY_TABLE_DEPENDENTS(
      uname             => 'ELMAH',
      orig_table        => 'ELMAH$ERROR',
      int_table         => 'ELMAH$ERROR_INTERIM',
      copy_indexes      => 1,
      copy_triggers     => TRUE,
      copy_constraints  => TRUE,
      copy_privileges   => TRUE,
      ignore_errors     => FALSE,
      num_errors        => v_erros,
      copy_statistics   => FALSE, 
      copy_mvlog        => FALSE); 
   
   
     if v_erros > 0 then
     
       raise_application_error(-20000, 'Ocorreram ' || v_erros || ' erros durante a c�pia de depend�ncias!');
     
     end if;
   
   end;
   
   -- Tag de monitoramento
   DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GMUD 16532',  action_name => 'Finaliza��o da redefini��o'); 

   
   
   -- Finaliza��o da redefini��o, trocando de lugar a tabela nova com a original
   DBMS_REDEFINITION.FINISH_REDEF_TABLE (uname => 'ELMAH', orig_table => 'ELMAH$ERROR', int_table => 'ELMAH$ERROR_INTERIM');
   
   
   -- Atividades p�s redefini��o
   
   
   
   -- Tag de monitoramento
   DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GMUD 16532',  action_name => 'Revalida��o de objetos'); 

   -- recompila��o dos triggers, caso algum tenha ficado inv�lido
   for rec in (select object_name from dba_OBJECTS where owner = 'ELMAH' AND OBJECT_TYPE = 'TRIGGER' AND STATUS = 'INVALID') loop
   
      execute immediate 'ALTER trigger ELMAH.' || rec.object_name  || ' compile';
      
   end loop;
   
   -- revalida��o dos triggers, caso algum esteja desativado
   for rec in (select trigger_name from dba_triggers where owner = 'ELMAH' and table_name not like 'BIN$%' and status = 'DISABLED') loop
      
      execute immediate 'ALTER trigger ELMAH.' || rec.trigger_name  || ' ENABLE';
         
   end loop;
   
   -- revalida��o de constraints, caso alguma n�o esteja validada
   for rec in (select table_name, constraint_name from dba_constraints where owner = 'ELMAH' and table_name not like 'BIN$%' and validated = 'NOT VALIDATED') loop
      
         execute immediate 'ALTER TABLE ELMAH.' || rec.table_name || ' MODIFY CONSTRAINT ' || rec.constraint_name  || ' ENABLE VALIDATE';
      
   end loop;
   
   
   -- procedimento para permitir o drop da primeira parti��o quando esta for considerada obsoleta
   execute immediate 'alter table  elmah.elmah$error set interval ()';
   execute immediate '[alter table  elmah.elmah$error set interval(numtodsinterval(1, 'day'))]';
   
   -- Tag de monitoramento
   DBMS_APPLICATION_INFO.SET_MODULE ( module_name => 'GMUD 16532',  action_name => 'Coleta de estat�sticas'); 

   
   -- Atualiza��o das estat�sticas antes de finalizar a redefini��o   
   DBMS_STATS.GATHER_TABLE_STATS (ownname => 'ELMAH', tabname => 'ELMAH$ERROR_INTERIM', degree => 4, cascade => true, granularity => 'ALL' );

   
end;
