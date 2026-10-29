(acmsp4-acsxr1-PRD)/home/oracle/uol$ cat restore_acmsp4.sh
#!/bin/ksh
export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
rman target / msglog=/home/oracle/uol/restore_tape_acmsp4.log << EOF
run {
allocate channel ch1 type 'sbt_tape' ;
allocate channel ch2 type 'sbt_tape' ;
allocate channel ch3 type 'sbt_tape' ;
allocate channel ch4 type 'sbt_tape' ;
send 'NB_ORA_POLICY=TB_AMBEV_ORA_ACMSP4-ONLINE,BKUP_IMAGE_PERM=ANY';
restore database;
release channel ch1;
release channel ch2;
release channel ch3;
release channel ch4;
}
EOF
exit

(acmsp4-acsxr1-PRD)/home/oracle/uol$ cat recover_acmsp4.sh
#!/bin/ksh
export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
rman target / msglog=/home/oracle/uol/recover_tape_acmsp4.log << EOF
run {
allocate channel ch1 type 'sbt_tape' ;
allocate channel ch2 type 'sbt_tape' ;
allocate channel ch3 type 'sbt_tape' ;
allocate channel ch4 type 'sbt_tape' ;
send 'NB_ORA_POLICY=TB_AMBEV_ORA_ACMSP4-ONLINE,BKUP_IMAGE_PERM=ANY';
recover database until scn 10710620202819;
release channel ch1;
release channel ch2;
release channel ch3;
release channel ch4;
}
EOF
exit
