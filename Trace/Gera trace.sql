Gerando Trace

select sid ||','|| serial# SID_SERIAL, username, osuser, machine, program from v$session GV$SESSION WHERE USERNAME='CHANGE' AND OSUSER NOT IN ('301871','244671','250071');

exec sys.dbms_system.set_sql_trace_in_session(3847,46594,true);
exec sys.dbms_system.set_sql_trace_in_session(3847,34325,false);


Depois v� at� a pasta ../admin/<ORACLE_SID>/udump  e localize o ultimo arquivo gerado com a data mais nova e rode o programa tkprf para formata-lo 

tkprof  <arquivo.trc> <arquivo.txt> 

O <arquivo.txt> sera o trace para analise.


-rw-r----- 1 oracle oinstall 2415168 Apr 25 16:13 dborabas2_ora_27692.trc

