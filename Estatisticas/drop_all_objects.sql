SET SERVEROUTPUT ON SIZE 1000000
BEGIN
  FOR cur_rec IN (SELECT owner, object_name, object_type 
                  FROM   dba_objects
                  WHERE  owner in ( 'USUARIO1','USUARIO2' ) ) LOOP
    BEGIN
      IF cur_rec.object_type = 'TABLE' THEN
        EXECUTE IMMEDIATE 'DROP ' || cur_rec.object_type || ' ' || cur_rec.owner || '.' || cur_rec.object_name || ' CASCADE CONSTRAINTS';
      ELSE
        EXECUTE IMMEDIATE 'DROP ' || cur_rec.object_type || ' ' || cur_rec.owner || '.' || cur_rec.object_name ;
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.put_line('FAILED: DROP ' || cur_rec.object_type || '->' || cur_rec.owner || '.' || cur_rec.object_name );
    END;
  END LOOP;
END;
/