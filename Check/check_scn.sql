[S] 
select to_char(current_scn) from v$database;


[P]
select to_char(scn_to_timestamp('&SCN_DO_STANDBY'),'DD/MM/YYYY HH24:MI:SS') from dual;
