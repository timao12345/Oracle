Rem
Rem $Header: dfltpasslt.sql 30-dec-2005.14:51:06 mfallon Exp $
Rem
Rem dfltpasslt.sql
Rem
Rem Copyright (c) 2005, Oracle. All rights reserved.  
Rem
Rem    NAME
Rem      dfltpasslt.sql - Check for default Database schema accounts and passwords
Rem
Rem    DESCRIPTION
Rem      Script to check for default database accounts and passwords. This scripts
Rem      is limited to database schema accounts
Rem
Rem    NOTES
Rem      Need select access to DBA_USERS
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    mfallon     12/30/05 - Check for default database schema accounts and 
Rem                           passwords 
Rem    mfallon     12/30/05 - Created
Rem

SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100
SET ESCAPE ON

TTITLE "Default Database Accounts With Default Passwords"

SELECT
username "Account Name", account_status "Account Status"
FROM dba_users
WHERE (username, password) IN (
('SYS',                         '5638228DAF52805F'),
('SYS',                         'D4C5016086B2DC6A'),
('SYSTEM',                      'D4DF7931AB130E37'),
('CTXSYS',                      '24ABAB8B06281B4C'),
('DBSNMP',                      'E066D214D5421CCC'),
('MDSYS',                       '72979A94BAD2AF80'),
('MDSYS',                       '9AAEB2214DCC9A31'),
('OUTLN',                       '4A3BA55E08595C81'),
('SCOTT',                       'F894844C34402B67'),
('ORDCOMMON',			'9B616F5489F90AD7'))
AND account_status <> 'EXPIRED \& LOCKED'
ORDER BY username;


select owner, object_name, object_type
from dba_objects
where object_name='AA';
