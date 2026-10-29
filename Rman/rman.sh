rman target / catalog rman/OraC123456#@DBMON
rman CATALOG=rman/OraC123456@DBMON TARGET /

run
{
ALLOCATE CHANNEL t16 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, 
ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_EXA_CS_KIPREV,NB_ORA_SERV=lnxprd085.rootbrasil.intranet,NB_ORA_CLIENT=exacc01db01vmc01.rootbrasil.intranet)';
set archivelog destination to '/bkp_lnxprd075_manobra/DG_KIPREV_ARCHIVE/';
RESTORE ARCHIVELOG FROM TIME = "to_date('20/11/2024 12:00:00','DD/MM/YYYY HH24:MI:SS')"
UNTIL TIME = "to_date('20/11/2024 15:00:00','DD/MM/YYYY HH24:MI:SS')";
}


run {
 ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, 
 ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_EXA_CS_KIPREV,NB_ORA_SERV=lnxprd085.rootbrasil.intranet,NB_ORA_CLIENT=exacc01db01vmc01.rootbrasil.intranet)';
 set archivelog destination to '/bkp_lnxprd075_manobra/DG_KIPREV_ARCHIVE/';
 restore archivelog from logseq=102279 until logseq=102316 thread 1;
 restore archivelog from logseq=166212 until logseq=166260 thread 2;
release channel c1;
}



run {
    ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, 
    ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_EXA_CS_KIPREV,NB_ORA_SERV=lnxprd085.rootbrasil.intranet,NB_ORA_CLIENT=exacc01db01vmc01.rootbrasil.intranet)';
    set archivelog destination to '/bkp_lnxprd075_manobra/DG_KIPREV_ARCHIVE/';
    restore archivelog logseq=166171 thread 2;
    release channel c1;
}   











thred 2 166171 a 166260

temos em disco do thred 2 166172 a 166211 - 



thred 2 166171 não temos em disco.
precisamos do thred 2 166212 até o 166260

thred 1 102279 até 102316 