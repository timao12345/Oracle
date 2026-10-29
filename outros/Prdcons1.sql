set serveroutput on size 1000000
spool pdr_cons.exec.sql

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
   n_fk_count NUMBER;
   --
   --- Constraint da tabela
   --
   CURSOR c_cons (civc_table_name IN VARCHAR2) IS
   SELECT table_name
        , constraint_name
        , constraint_type
        , r_owner
        , r_constraint_name
     FROM user_constraints
    WHERE table_name = CIVC_TABLE_NAME
    ORDER BY DECODE(constraint_type, 'P', 1
                                   , 'R', 2
                                   , 'C', 3
                                   ,      4);
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
      RETURN (vc_table || '('||f_cols(pivc_cons_name)||')' );
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
   --
   ----- Valida todas as tabelas do SCHEMA
   --
   FOR r_sch IN (SELECT table_name FROM user_tables
                 ORDER BY 1)
   LOOP
      --
      vc_tab := LOWER(r_sch.table_name);
      printl('--');
      printl('--');
      printl('--   Tabela: '||r_sch.table_name);
      printl('--   ----------------------------- ');
      --
      --- Para cada tabela, trata a constraint
      --
      FOR r_cons IN c_cons (r_sch.table_name)
      LOOP
         --
         IF r_cons.constraint_type = 'P'
         THEN
            printl('--   Primary Key');
            printl(' ALTER TABLE '       ||vc_tab );
            print (' ADD CONSTRAINT pk_' ||vc_tab );
            printl(' PRIMARY KEY (' || f_cols(r_cons.constraint_name) 
                 ||' );'
                 );
            printl('--');
            printl('--');
         END IF;
         --
         IF r_cons.constraint_type = 'R'
         THEN
            --
            n_fk_count := n_fk_count + 1;
            vc_count   := LTRIM( TO_CHAR( n_fk_count, '00') );
            --
            printl(' ALTER TABLE '       ||vc_tab );
            print (' ADD CONSTRAINT fk_' ||vc_tab || vc_count );
            printl(' FOREIGN KEY REFERENCES '
                 ||f_reference(r_cons.r_constraint_name) 
                 ||';'
                 );
            printl('--');
         END IF;
         --
         IF r_cons.constraint_type = 'C'
         THEN
            --
            printl(' ALTER TABLE '       ||vc_tab );
            print (' ADD CONSTRAINT ck_' ||TRIM(f_cols(r_cons.constraint_name)) ); 
            printl(' CHECK ('|| f_check(r_cons.constraint_name)
                 ||');'
                 );
            printl('--');
         END IF;
         --
      END LOOP;
      --
      printl('--');
      --
   END LOOP;
   --
END;
/

spool off

