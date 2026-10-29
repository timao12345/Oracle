set serveroutput on size 1000000 line 100;

UNDEFINE AOWNER ;
UNDEFINE ATBS;
UNDEFINE ANEXT;

ACCEPT AOWNER   CHAR PROMPT 'Nome Owner dos Objetos............:  '
ACCEPT ATBS     CHAR PROMPT 'Nome da TBS ......................:  '
ACCEPT ANEXT    CHAR PROMPT 'Valor do Next(Mb) para os objetos.:  '


--
-- pct.sql
--
-- Seta os objetos pertencentes ao OWNER  e a TBS para 0 
-- Informar  valor para NEXT 
-- Rodar o script TBS_FRAG antes e encontrar o melhor valor para o NEXT, pois as TBS estao fragmentadas.
--
 
DECLARE
 
CURSOR tlist IS
        select
            SEGMENT_NAME,
            SEGMENT_TYPE,
            round((NEXT_EXTENT*BLOCKS)/(EXTENTS*BYTES))*(BYTES/BLOCKS),
            PCT_INCREASE
        from
            DBA_SEGMENTS
        where
            OWNER='&&AOWNER'
        and
            SEGMENT_TYPE in ('INDEX',
                            'INDEX PARTITION',
                            'LOBSEGMENT',
                            'TABLE',
                            'TABLE PARTITION')
        and
            (PCT_INCREASE > 0 or max_extents = 121);
 
CURSOR iplist (iname IN VARCHAR2) IS
        select
            PARTITION_NAME
        from
            DBA_IND_PARTITIONS
        where
            INDEX_NAME=iname;
 
CURSOR tplist (tname IN VARCHAR2) IS
        select
            PARTITION_NAME
        from
            DBA_TAB_PARTITIONS
        where
            TABLE_NAME=tname;
 
CURSOR lobtplist (lname IN VARCHAR2) IS
        select
            TABLE_NAME,
            COLUMN_NAME
        from
            DBA_LOBS
        where
            SEGMENT_NAME=lname;
 
sname DBA_SEGMENTS.SEGMENT_NAME%TYPE;
stype DBA_SEGMENTS.SEGMENT_TYPE%TYPE;
avg_next_extent DBA_SEGMENTS.INITIAL_EXTENT%TYPE;
pctinc DBA_SEGMENTS.PCT_INCREASE%TYPE;
 
ipname DBA_IND_PARTITIONS.PARTITION_NAME%TYPE;
tpname DBA_TAB_PARTITIONS.PARTITION_NAME%TYPE;
 
lobtname DBA_LOBS.TABLE_NAME%TYPE;
lobcname DBA_LOBS.COLUMN_NAME%TYPE;
 
ddlstmt VARCHAR2(200);
storageclause VARCHAR2(100);
 
emesg VARCHAR2(250);
 
BEGIN
 
OPEN tlist;
 
LOOP
        FETCH tlist INTO  sname, stype, avg_next_extent, pctinc;
        EXIT WHEN tlist%NOTFOUND;
 
        storageclause := ' STORAGE (next  &&ANEXT m pctincrease 0 maxextents unlimited)';

  BEGIN
        IF stype='INDEX' THEN
                ddlstmt := 'ALTER INDEX &&AOWNER . ' || sname  || storageclause;
                DBMS_OUTPUT.PUT_LINE(ddlstmt);
                EXECUTE IMMEDIATE ddlstmt;
                DBMS_OUTPUT.PUT_LINE('Successfully completed');
        ELSIF stype='INDEX PARTITION' THEN
                OPEN iplist (sname);
                LOOP
                        FETCH iplist INTO  ipname;
                        EXIT WHEN iplist%NOTFOUND;
 
                        ddlstmt := 'ALTER INDEX &&AOWNER . ' ||
                                  sname  || ' MODIFY PARTITION ' ||
                                  ipname || storageclause;
 
                        DBMS_OUTPUT.PUT_LINE(ddlstmt);
                        EXECUTE IMMEDIATE ddlstmt;
                        DBMS_OUTPUT.PUT_LINE('Successfully completed');
                END LOOP;
                CLOSE iplist;
        ELSIF stype='LOBSEGMENT' THEN
                OPEN lobtplist (sname);
                LOOP
                        FETCH lobtplist INTO  lobtname, lobcname;
                        EXIT WHEN lobtplist%NOTFOUND;
                        ddlstmt := 'ALTER TABLE &&AOWNER . ' || lobtname ||
                                  ' MODIFY LOB ( ' || lobcname ||
                                  ')(' || storageclause || ')';
                        DBMS_OUTPUT.PUT_LINE(ddlstmt);
                        EXECUTE IMMEDIATE ddlstmt;
                        DBMS_OUTPUT.PUT_LINE('Successfully completed');
                END LOOP;
                CLOSE lobtplist;
        ELSIF stype='TABLE' THEN
                ddlstmt := 'ALTER TABLE &&AOWNER . ' || sname  || storageclause;
                DBMS_OUTPUT.PUT_LINE(ddlstmt);
                EXECUTE IMMEDIATE ddlstmt;
                DBMS_OUTPUT.PUT_LINE('Successfully completed');
        ELSIF stype='TABLE PARTITION' THEN
                OPEN tplist (sname);
                LOOP
                        FETCH tplist INTO  tpname;
                        EXIT WHEN tplist%NOTFOUND;
 
                        ddlstmt := 'ALTER TABLE &&AOWNER . ' || sname  ||
                                  ' MODIFY PARTITION ' || tpname || storageclause;
 
                        DBMS_OUTPUT.PUT_LINE(ddlstmt);
                        EXECUTE IMMEDIATE ddlstmt;
                        DBMS_OUTPUT.PUT_LINE('Successfully completed');
 
                END LOOP;
                CLOSE tplist;
        END IF;
 
        EXCEPTION
        WHEN OTHERS THEN
                emesg := SQLERRM;
                DBMS_OUTPUT.PUT_LINE('Failed to Run.' || emesg);
  END;
END LOOP;
 
CLOSE tlist;
 
ddlstmt := 'ALTER TABLESPACE &&ATBS DEFAULT STORAGE (PCTINCREASE 0 MAXEXTENTS UNLIMITED)';
DBMS_OUTPUT.PUT_LINE(ddlstmt);
EXECUTE IMMEDIATE ddlstmt;
DBMS_OUTPUT.PUT_LINE('Successfully completed');

 
END;
/
 

 
