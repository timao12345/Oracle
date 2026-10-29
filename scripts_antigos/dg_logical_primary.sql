-- Executar database primário
select to_char(scn_to_timestamp('&SCN_DO_STANDBY'),'DD/MM/YYYY HH24:MI:SS') from dual;
