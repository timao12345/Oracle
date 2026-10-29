@base
-- Create the user 
create user &&username identified by &&username

  default tablespace users
  temporary tablespace temp
  profile special;
-- Grant/Revoke role privileges 
grant connect, dba to &&username;
-- Grant/Revoke system privileges 
grant unlimited tablespace to &&username;
