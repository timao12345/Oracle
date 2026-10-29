--LIMPAR OS OBJETOS like '%MG%' e like '%MEGA%'

select name from v$database;
 set echo on serveroutput on feed on head on
 declare
 vSQL long;
 vBaseDrop varchar2(10);
 vBaseAtual varchar2(10);
begin
  begin
    select name into vBaseAtual from v$database;
    exception
    when no_data_found then
    dbms_output.put_line('Erro ao encontrar o banco');
  end;
    if '&vBaseDrop' = 'mgteste' then
        begin
            for R_OBJ in (SELECT * FROM ALL_OBJECTS WHERE owner like '%MG%' ORDER BY OWNER)
        loop
            vSQL := 'DROP' || ' ' || R_OBJ.OBJECT_TYPE;
            vSQL := vSQL || ' ' || R_OBJ.OWNER;
            vSQL := vSQL || '.' || R_OBJ.OBJECT_NAME;
            if R_OBJ.OBJECT_TYPE = 'TABLE' then
                vSQL := vSQL || ' CASCADE CONSTRAINTS';
            end if;
            begin
                for j in (select object_name from dba_objects where object_name = R_OBJ.OBJECT_NAME) 
                loop
                    dbms_output.put_line('Dropando .. '||J.OBJECT_NAME);
                end loop;
            execute immediate vSQL;
            exception
            when OTHERS then NULL;
            end;
        end loop;
        end;
    else
      dbms_output.put_line('Erro ao encontrar o banco, o atual eh -> '|| vBaseAtual );
    end if;
end;
/


--Criar parfile  vi parfile.txt

directory=tmpdir
dumpfile=dpnoite%U.dmp
logfile=import.log
full=y
exclude=SCHEMA:"='OUTLN'"
exclude=SCHEMA:"='SYSTEM'"
exclude=SCHEMA:"='SYS'"
exclude=SCHEMA:"='SI_INFORMTN_SCHEMA'"
exclude=SCHEMA:"='OLAPSYS'"
exclude=SCHEMA:"='ORDPLUGINS'"
exclude=SCHEMA:"='CTXSYS'"
exclude=SCHEMA:"='ORDSYS'"
exclude=SCHEMA:"='XDB'"
exclude=SCHEMA:"='EXFSYS'"
exclude=SCHEMA:"='ANONYMOUS'"
exclude=SCHEMA:"='ORDDATA'"
exclude=SCHEMA:"='OWBSYS'"
exclude=SCHEMA:"='OWBSYS_AUDIT'"
exclude=SCHEMA:"='APEX_030200'"
exclude=SCHEMA:"='APPQOSSYS'"
exclude=SCHEMA:"='WMSYS'"
exclude=SCHEMA:"='MDSYS'"
exclude=SCHEMA:"='DMSYS'"
exclude=SCHEMA:"='FLOWS_FILES'"
exclude=SCHEMA:"='SYSMAN'"
exclude=SCHEMA:"='DBSNMP'"
exclude=SCHEMA:"='SPATIAL_WFS_ADMIN_USR'"
exclude=SCHEMA:"='SPATIAL_CSW_ADMIN_USR'"
exclude=SCHEMA:"='APEX_PUBLIC_USER'"
exclude=SCHEMA:"='DIP'"
exclude=SCHEMA:"='ORACLE_OCM'"
exclude=SCHEMA:"='MDDATA'"
exclude=SCHEMA:"='XS$NULL'"
exclude=SCHEMA:"='TSMSYS'"
exclude=SCHEMA:"='WKSYS'"
exclude=SCHEMA:"='APEX_050100'"
exclude=SCHEMA:"='APEX_LISTENER'"
exclude=SCHEMA:"='WG5CAD'"
exclude=SCHEMA:"='WG5CLI'"
exclude=SCHEMA:"='WG5CSC'"
exclude=SCHEMA:"='WG5SIS'"
exclude=SCHEMA:"='WG5EDW'"
exclude=SCHEMA:"='APEX_180100'"  
exclude=SCHEMA:"='TESTE'"         
exclude=SCHEMA:"='BACKUPDUMP'"        
exclude=SCHEMA:"='DBM'" 
exclude=SCHEMA:"='PERFSTAT'" 
exclude=SCHEMA:"='GSMADMIN_INTERNAL'"
exclude=SCHEMA:"='BACKUP'"
exclude=SCHEMA:"='OJVMSYS'"
exclude=SCHEMA:"='SOLWMS'"
exclude=SCHEMA:"='XBASESAC'" 
