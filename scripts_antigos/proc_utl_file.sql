-- proc para importar arquivo CSV

CREATE OR REPLACE PROCEDURE DBSKYONE.CARGA_CSV
as
     l_file         utl_file.file_type;
     l_text         varchar2(32767);
     l_cnt          number;
   begin
     -- Open file.
     l_file := utl_file.fopen('DUMP', 'exportar.csv', 'R', 32767);
 
     loop
       utl_file.get_line(l_file, l_text, 32767);
 
       -- L_TEXT contains the whole row; split it (by commas) into 2 values and insert them into the TEST table
       insert into DBSKYONE.teste (nome, idade)
         values (regexp_substr(l_text, '[^,]+', 1, 1),
                 regexp_substr(l_text, '[^,]+', 1, 2)
                );
     end loop;
 
     utl_file.fclose(l_file);
   exception
     when no_data_found then
       null;
   end;
   /
   

CREATE OR REPLACE EDITIONABLE PROCEDURE "CONSINCO"."SP_ASUN_PLANOGRAMA_IMPORT_PROD"
AS
declare
     l_file         utl_file.file_type;
     l_text         varchar2(32767);
     l_cnt          number;
   begin
     -- Open file.
     l_file := utl_file.fopen('PLANASUN', 'ALTERA_PLANOGRAMA.csv', 'R', 32767);

     loop
       utl_file.get_line(l_file, l_text, 32767);

       -- L_TEXT contains the whole row; split it (by commas) into 3 values
       -- and insert them into the TEST2 table
       insert into ALTERA_PLANOGRAMA.csv (id, fname, lname)
         values (regexp_substr(l_text, '[^,]+', 1, 1),
                 regexp_substr(l_text, '[^,]+', 1, 2),
                 regexp_substr(l_text, '[^,]+', 1, 3)
                );
     end loop;

     utl_file.fclose(l_file);
   exception
     when no_data_found then
       null;
   end;
/


---- // ----

-- PRIMEIRO MODO
DECLARE
      F UTL_FILE.FILE_TYPE;
      V_LINE VARCHAR2 (1000);
      V_EMPNO NUMBER(4);
      V_ENAME VARCHAR2(10);
      V_SAL NUMBER(7,2);
      V_DNAME VARCHAR2(14);
    BEGIN
      F := UTL_FILE.FOPEN ('DIRECTORY', 'LIC_TESTE.csv', 'R');
    IF UTL_FILE.IS_OPEN(F) THEN
      LOOP
        BEGIN
          UTL_FILE.GET_LINE(F, V_LINE, 1000);
          IF V_LINE IS NULL THEN
            EXIT;
          END IF;
          V_EMPNO := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 1);
          V_ENAME := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 2);
          V_SAL := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 3);
          V_DNAME := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 4);
          INSERT INTO LIC_TESTE VALUES(V_EMPNO, V_ENAME, V_SAL, V_DNAME);
          COMMIT;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
          EXIT;
        END;
      END LOOP;
   END IF;
  UTL_FILE.FCLOSE(F);
 END;