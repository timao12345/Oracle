-- Create the user 
create user OPS$ORACLE
  identified externally
  default tablespace ???
  temporary tablespace ???
  profile DEFAULT;
-- Grant/Revoke role privileges 
grant dba to OPS$ORACLE;
-- Grant/Revoke system privileges 
grant unlimited tablespace to OPS$ORACLE;