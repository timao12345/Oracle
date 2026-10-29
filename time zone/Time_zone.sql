-- Time zone atual do BD
SELECT
  TZ_OFFSET( DBTIMEZONE )
FROM
  DUAL;

SELECT
  DBTIMEZONE
FROM
  dual;

TZ_OFFS
-------
-03:00

-- todas timezones do BD
SELECT * from V$TIMEZONE_NAMES where TZABBREV='-03';


-- Time zone atual
SELECT * FROM v$timezone_file;

-- Verificar se tem atualização para uma versão maior
SELECT DBMS_DST.get_latest_timezone_version
FROM   dual;

--1.Start the database in upgrade mode:
 SHUTDOWN IMMEDIATE;
 
 STARTUP UPGRADE;
 
--2. Prepare for the upgrade:
DECLARE
  l_tz_version PLS_INTEGER;
BEGIN
  l_tz_version := DBMS_DST.get_latest_timezone_version;
 
  DBMS_OUTPUT.put_line('l_tz_version=' || l_tz_version);
  DBMS_DST.begin_prepare(l_tz_version);
END;
/ 


--3. Check the upgrade status
COLUMN property_name FORMAT A30
COLUMN property_value FORMAT A20
 
SELECT property_name, property_value
FROM   database_properties
WHERE  property_name LIKE 'DST_%'
ORDER BY property_name;





SET SERVEROUTPUT ON
DECLARE
  l_tz_version PLS_INTEGER;
BEGIN
  SELECT DBMS_DST.get_latest_timezone_version
  INTO   l_tz_version
  FROM   dual;
 
  DBMS_OUTPUT.put_line('l_tz_version=' || l_tz_version);
  DBMS_DST.begin_upgrade(l_tz_version);
END;
/