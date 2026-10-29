Changing a password hash (version dependent)

10g Release 2 (and previous versions)
ALTER USER username IDENTIFIED BY VALUES '<10g password hash>';

11g Release 1 (and later versions)
ALTER USER username IDENTIFIED BY VALUES '<11g password hash>';

    Note that by using the above IDENTIFIED BY VALUES clause in 11g, setting either the 10g or 11g password hash, will make the other
    hash value disappear. So if in 11g you specify a 10g password hash for a user, Oracle will remove the 11g hash value and vice versa.

It is possible to specify both the 10g and 11g password hash value in the same IDENTIFIED BY VALUES clause to be able to set both hashes
and thus without losing any one of them.
ALTER USER username IDENTIFIED BY VALUES '<11g password hash>;<10g password hash>';
Case-sensitive passwords as of 11g Release 1

Until Oracle database 11g Release 1, passwords within an oracle database where case-insensitive. As of 11g Release 1 the database uses case-sensitive passwords as a standard. It is possible however to disable this new functionality by changing an initialization parameter.

The initialization parameter to enable/disable the use of case-sensitive passwords is sec_case_sensitive_logon

The SQL statement for changing (in this example disable – not recommended) this initialization parameter:
ALTER SYSTEM SET sec_case_sensitive_logon=false;

SQL> select PASSWORD, NAME from user$ where name = 'SYSPERGAMUM';
 
PASSWORD                          NAME
------------------------------     ------------------------------
74766C8679AFE54B               FISCAL


PASSWORD                       NAME
------------------------------ ------------------------------
7DD66BBC28EDCCAE               RH_VISUM


ALTER USER RH_VISUM IDENTIFIED BY VALUES '7DD66BBC28EDCCAE';