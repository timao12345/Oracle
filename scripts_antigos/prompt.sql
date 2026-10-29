set feed off term off
col b new_value base
col u new_value usuario
select decode (instr (global_name,'.'),
        0,global_name,
        upper (substr (global_name,1,instr (global_name,'.')-1))
        ) b
from global_name ;
select lower (user) u from dual ;
set feed on pause on term on pause ...
set sqlprompt '(&usuario@&base)> '
undef usuario 
undef base 
cle buff 
set feed on
rem set pages 40 lines 120 trimsp on
set lines 200
set pages 2000
-- set pause on pause ...
