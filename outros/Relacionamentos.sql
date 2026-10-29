set serveroutput on size 1000000
set trimspool on;
ACCEPT arq PROMPT 'Entre com o nome do arquivo de spool:' 
spool &arq

DECLARE
--
--  pdrcons.sql
--  (padronização de constraints)
--
--  Gera constraints do usuario atual no seguinte padrão:
--       PRIMARY KEY : pk_{nome_da_tabela}
--       FOREIGN KEY : fk_{tabela_pai}_{tabela_filho}
--       CHECK       : ck_{coluna}_{nn}
--
--  Marcus Vinicius Ferreira
--  04/Out/2000
--
--  MODIFIED
--      marcus vinicius ferreira 04/out/2000 - usando DBMS_OUTPUT
----
--
   --
   --------------------------------------------
   -- Variáveis / Cursores
   --------------------------------------------
   --
   vc_tab  VARCHAR2(30);
   vc_count CHAR(10);
   n_fk_count NUMBER := 0;
   vc_reference VARCHAR2(100);
   vc_cols  VARCHAR2(100);
   --
   --- Primary Key da tabela
   --
   CURSOR c_cons_pk (civc_table_name IN VARCHAR2) IS
   SELECT table_name
        , constraint_name
        , constraint_type
        , r_owner
        , r_constraint_name
     FROM user_constraints
    WHERE table_name = CIVC_TABLE_NAME
    AND constraint_type = 'P'
    ORDER BY table_name;
   --
   --- Foreign Key da tabela
   --
   CURSOR c_cons_fk (civc_table_name IN VARCHAR2) IS
   SELECT table_name
        , constraint_name
        , constraint_type
        , r_owner
        , r_constraint_name
        , DECODE(status,'ENABLED','ENABLE','DISABLED','DISABLE',' ') status
     FROM user_constraints
    WHERE table_name = CIVC_TABLE_NAME
    AND constraint_type = 'R'
    ORDER BY table_name;
   --
   --- Check da tabela
   --
   CURSOR c_cons_ck (civc_table_name IN VARCHAR2) IS
   SELECT table_name
        , constraint_name
        , constraint_type
        , r_owner
        , r_constraint_name
     FROM user_constraints
    WHERE table_name = CIVC_TABLE_NAME
    AND constraint_type = 'C'
    ORDER BY table_name;
   --
   --- Tabela da constraint
   --
   CURSOR c_tab (civc_cons_name IN VARCHAR2) IS
   SELECT table_name
     FROM user_constraints
    WHERE constraint_name = CIVC_CONS_NAME;
   --
   --- Colunas da constraint
   --
   CURSOR c_col (civc_cons_name IN VARCHAR2) IS
   SELECT constraint_name
        , column_name
        , position
     FROM user_cons_columns
    WHERE constraint_name = CIVC_CONS_NAME
    ORDER BY position;
   --
   --
   --------------------------------------------
   -- Sub-Rotinas
   --------------------------------------------
   --
   PROCEDURE print (pivc_valor IN VARCHAR2) IS
   BEGIN
      DBMS_OUTPUT.PUT(pivc_valor);
   END print;
   --
   -----
   --
   PROCEDURE printl(pivc_valor IN VARCHAR2) IS
   BEGIN
      DBMS_OUTPUT.PUT_LINE(pivc_valor);
   END printl;
   --
   -----
   --
   FUNCTION  f_cols(pivc_cons_name IN VARCHAR2) RETURN VARCHAR2 IS
   -----
   -- Colunas da constraint
   --
      vc_sep  CHAR(2) := ''; -- separador
      vc_cols VARCHAR2(200);
   --
   BEGIN
      --
--    RETURN (pivc_cons_name);
      --
      FOR r_col IN c_col (pivc_cons_name)
      LOOP
         vc_cols := vc_cols || vc_sep || r_col.column_name  ;
         vc_sep  := ', ';
      END LOOP;
      --
      RETURN ( LOWER(vc_cols) );
      --
   END f_cols;
   --
   -----
   --
   FUNCTION  f_reference(pivc_cons_name IN VARCHAR2) RETURN VARCHAR2 IS
   -----
   -- Tabela Referenciada + colunas
   --
      vc_table  VARCHAR2(30) ;
   --
   BEGIN
      --
      FOR r_tab IN c_tab (pivc_cons_name)
      LOOP
         vc_table := LOWER(r_tab.table_name);
      END LOOP;
      --
      RETURN (vc_table  || '('||f_cols(pivc_cons_name)||')' );
      --
   END f_reference;
   --
   -----
   --
   FUNCTION  f_check(pivc_cons_name IN VARCHAR2) RETURN VARCHAR2 IS
   -----
   -- CHECK das colunas
   --
      vc_string  VARCHAR2(255) ;
   --
   BEGIN
      --
      FOR r_ck IN (SELECT search_condition sc
                     FROM user_constraints
                    WHERE constraint_name = pivc_cons_name)
      LOOP
         vc_string := r_ck.sc;
      END LOOP;
      --
      RETURN (vc_string );
      --
   END f_check;
   --
   --
   --------------------------------------------
   -- Bloco Principal
   --------------------------------------------
   --
BEGIN

 
   printl('--');
   printl('--         Foreign Keys       ---  ');
   printl('--   ----------------------------- ');
   printl('--');
   
   FOR r_sch IN (SELECT table_name FROM user_tables
                 ORDER BY 1)
   LOOP
      --
      vc_tab := LOWER(r_sch.table_name);
      --
      --- Para cada tabela, trata a constraint
      --
      FOR r_cons_fk IN c_cons_fk (r_sch.table_name)
      LOOP
         --
         --   n_fk_count := n_fk_count + 1;
         --   vc_count   := LTRIM( TO_CHAR( n_fk_count, '00') );
            vc_reference := f_reference(r_cons_fk.r_constraint_name) ;
            vc_cols := f_cols(r_cons_fk.constraint_name);
         --
         --   printl(' ALTER TABLE '       ||vc_tab );
         --   printl (' ADD CONSTRAINT fk_' ||vc_tab || '_' || vc_count );
         --   printl(' FOREIGN KEY ('||trim(vc_cols)||') REFERENCES ');
         --   printl ( vc_reference ||' '||r_cons_fk.status||';' );
            printl(rpad(r_cons_fk.table_name,30)||rpad(r_cons_fk.constraint_name,30)||rpad(r_cons_fk.constraint_type,30)
                      ||rpad(vc_reference,30)||rpad(vc_cols,30));
      END LOOP;
      n_fk_count := 0;
   END LOOP;


END;
/

spool off

