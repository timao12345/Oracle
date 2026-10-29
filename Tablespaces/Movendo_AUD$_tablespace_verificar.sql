QL> CREATE TABLESPACE TBS_AUDIT datafile '+ORADATA3' SIZE 30G ;
Tablespace created.

SQL> CREATE TABLE BACKUP_AUD TABLESPACE TBS_AUDIT AS SELECT * FROM SYS.AUD$;
Table created.



>>> FAIL SQL Check Table AUD$[FGA_LOG$] should use Automatic Segment Space Management for CYBELAR All Databases View 
------------------------------------------------------------------------------------------------------------------------

BEGIN
DBMS_AUDIT_MGMT.set_audit_trail_location(audit_trail_type => DBMS_AUDIT_MGMT.AUDIT_TRAIL_AUD_STD,--this moves table AUD$ 
audit_trail_location_value => 'TBS_AUDIT');  
END;  
/
BEGIN
DBMS_AUDIT_MGMT.set_audit_trail_location(audit_trail_type => DBMS_AUDIT_MGMT.AUDIT_TRAIL_FGA_STD,--this moves table FGA_LOG$ 
audit_trail_location_value => 'TBS_AUDIT');
END;
/   
