--
--
--  NOME
--    tb_redef.sql
--
--  DESCRICAO
--   Realiza o reorg das tabelas online
--  Requisitos
--  Pode ser executada como SYSDBA [sqlplus "/ as sysdba"]
--
--  UTILIZAÇÂO
--   Ex. @tb_redef.sql tb_orig tb_interim change_number
--   tb_orig - tabela d eorigem que será reorganizada.
--	 tb_interim - tabela espelho que será criada para fazer o reorg.
--   change_number - número da change, referência que será usada para consultar
--   o progresso do reorg.
--
--   Para consultar o progresso utilize a query abaixo:
--
--   SELECT sql_text, disk_reads, module, action
--     FROM v$sqlarea
--    WHERE module = '&Change_number';
--
--  Abortar a redefinição corrente, caso ainda esteja pendente
--  Em alguns casos quando não se quer esperar pelo final do reorg você pode
--  abortar a redefinição fazendo um abort.
--
--  exec   DBMS_REDEFINITION.ABORT_REDEF_TABLE (uname => p_uname, orig_table => 
--  p_orig_table, int_table => p_int_table);	
--
--  HISTORICO
--    16/04/2015 (Eramirton F. Crispim) - versão 1.0 - Alteração
--    Melhorias, substituído valores fixos por variáveis
--    Chamada a apartir do SQLPLUS passando como argumentos (Owner,Tabela de 
--    origem,Tabela interim e Número da change para controle)
-----------------------------------------------------------------------------
declare

p_uname  varchar2(60) 		:= '&1' ;
p_orig_table  varchar2(60) 	:= '&2' ;
p_int_table  varchar2(60) 	:= '&3' ;
p_module_name varchar2(60)	:= '&4'	;

begin

   -- Script para redefinição de tabelas
   -- Este script irá usar a redefinição online para implementar um novo layout físico para a tabela
   -- Ao final do script será mantida no banco a tabela original renomeada, para efeito de backup
   -- Esta tabela será excluída em outra mudança, após a certificação desta mudança
   
   -- Tag de monitoramento
   DBMS_APPLICATION_INFO.SET_MODULE ( module_name => p_module_name,  action_name => 'Início'); 

   -- Aguardar até 5 minutos a liberação de locks para os DDLs prosseguirem
   execute immediate 'ALTER SESSION SET ddl_lock_timeout=300';

   -- Abortar a redefinição corrente, caso ainda esteja pendente
   DBMS_REDEFINITION.ABORT_REDEF_TABLE (uname       => p_uname,  orig_table  =>  p_orig_table, int_table   => p_int_table);

   -- Caso a tabela interina esteja presente no ambiente, dropar
   declare
      v_contagem pls_integer := 0;
   begin

      -- identificar a presença da tabela interina no banco
      select count(1) 
       into v_contagem
      from dba_tables 
      where owner = p_uname and table_name = p_int_table;
      
                  -- se a tabela estiver presente, dropar
      if v_contagem = 1 then
      
                  
                               -- Tag de monitoramento
                               DBMS_APPLICATION_INFO.SET_MODULE ( module_name => p_module_name,  action_name => 'Drop da tabela interina'); 

         execute immediate 'drop table '||p_uname||'.'||p_int_table||' cascade constraints';
      
      end if;
      
   end;

   -- Verificar se a redefinição pode ser realizada, usando o critério da chave primária
   -- Caso não seja possível, esta procedure irá gerar uma EXCEPTION e abortará o script
   DBMS_REDEFINITION.CAN_REDEF_TABLE (uname => p_uname, tname => p_orig_table, options_flag  => dbms_redefinition.cons_use_rowid);


   
   -- Criar a tabela interina para uso na redefinição
   execute immediate 'create table '||p_uname||'.'||p_int_table||' AS SELECT * FROM '||p_uname||'.'||p_orig_table||'';
  
 
   -- Iniciar a redefinição, isto criará os objetos de apoio e copiará os dados para a tabela interina
   begin
   
                -- Tag de monitoramento
    DBMS_APPLICATION_INFO.SET_MODULE ( module_name => p_module_name,  action_name => 'START_REDEF_TABLE'); 

   
     -- O uso de parallel execution visa completar a operação em menos tempo, uma vez que os comandos irão movimentar uma grande quantidade de dados
     EXECUTE IMMEDIATE 'alter session force parallel dml parallel 8';
     EXECUTE IMMEDIATE 'alter session force parallel query parallel 8';
   
     DBMS_REDEFINITION.START_REDEF_TABLE ( uname => p_uname, orig_table => p_orig_table, int_table => p_int_table, options_flag   =>  dbms_redefinition.cons_use_rowid);
      
   end;

 
   -- Tag de monitoramento
   DBMS_APPLICATION_INFO.SET_MODULE ( module_name => p_module_name,  action_name => 'Sincronia intermediária'); 

   -- Sincronia de dados intermediária
   DBMS_REDEFINITION.SYNC_INTERIM_TABLE (uname => p_uname, orig_table => p_orig_table, int_table => p_int_table);
   
   -- Tag de monitoramento
   DBMS_APPLICATION_INFO.SET_MODULE ( module_name => p_module_name,  action_name => 'Copiando dependências'); 

   -- Copiar os objetos dependentes (Índices não modificados, constraints, triggers ,...)
   declare
  
     v_erros pls_integer;
     
   begin
   
   DBMS_REDEFINITION.COPY_TABLE_DEPENDENTS(
      uname             => p_uname,
      orig_table        => p_orig_table,
      int_table         => p_int_table,
      copy_indexes      => 1,
      copy_triggers     => TRUE,
      copy_constraints  => TRUE,
      copy_privileges   => TRUE,
      ignore_errors     => FALSE,
      num_errors        => v_erros,
      copy_statistics   => FALSE, 
      copy_mvlog        => FALSE); 
   
   
     if v_erros > 0 then
     
       raise_application_error(-20000, 'Ocorreram ' || v_erros || ' erros durante a cópia de dependências!');
     
     end if;
   
   end;
   
   -- Tag de monitoramento
   DBMS_APPLICATION_INFO.SET_MODULE ( module_name => p_module_name,  action_name => 'Finalização da redefinição'); 

   
   
   -- Finalização da redefinição, trocando de lugar a tabela nova com a original
   DBMS_REDEFINITION.FINISH_REDEF_TABLE (uname => p_uname, orig_table => p_orig_table, int_table => p_int_table);
   
   
   -- Atividades pós redefinição
   
   
   
   -- Tag de monitoramento
   DBMS_APPLICATION_INFO.SET_MODULE ( module_name => p_module_name,  action_name => 'Revalidação de objetos'); 

   -- recompilação dos triggers, caso algum tenha ficado inválido
   for rec in (select object_name from dba_OBJECTS where owner = p_uname AND OBJECT_TYPE = 'TRIGGER' AND STATUS = 'INVALID') loop
   
      execute immediate 'ALTER trigger '||p_uname||'.' || rec.object_name  || ' compile';
      
   end loop;
   
   -- revalidação dos triggers, caso algum esteja desativado
   for rec in (select trigger_name from dba_triggers where owner = p_uname and table_name not like 'BIN$%' and status = 'DISABLED') loop
      
      execute immediate 'ALTER trigger '||p_uname||'.' || rec.trigger_name  || ' ENABLE';
         
   end loop;
   
   -- revalidação de constraints, caso alguma não esteja validada
   for rec in (select table_name, constraint_name from dba_constraints where owner = p_uname and table_name not like 'BIN$%' and validated = 'NOT VALIDATED') loop
      
         execute immediate 'ALTER TABLE '||p_uname||'.' || rec.table_name || ' MODIFY CONSTRAINT ' || rec.constraint_name  || ' ENABLE VALIDATE';
      
   end loop;
   
   
   -- Tag de monitoramento
   DBMS_APPLICATION_INFO.SET_MODULE ( module_name => p_module_name,  action_name => 'Coleta de estatísticas'); 

   
   -- Atualização das estatísticas antes de finalizar a redefinição   
   DBMS_STATS.GATHER_TABLE_STATS (ownname => p_uname, tabname => p_orig_table, degree => 4, cascade => true, granularity => 'ALL' );

   
end;
/