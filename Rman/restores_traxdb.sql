Restore de banco de dados - TRAXDB 10g
Classificação do chamado: Técnico
1. Banco de dados: ( ) SQL Server ( ) Mysql ( ) Postgres SQL ( X ) Oracle
2. Servidor: ORAFDBTB578A para o RESTORA1TB578H
ORAFDBTB578A
3. Nome do banco: TRAXDB
4. Nome do usuário: trax(servidor original) - oracle (destino)
5. Local do arquivo de backup a ser restaurado: /u01/app/oracle/oradata

OBS: O restore não deve ser realizado no mesmo servidor, deve ser direcionado para o servidor RESTORA1TB578H. Atualmente a base esta armazenada em uma estrutura ASM, o restore deverá ser realizado para filesystem no caminho informado. 
Restaurar o banco de dados na data de 14/10/2014 08:00hs.
O servidor RESTORA1TB578H é utilizado somente para restore, atualmente neste servidor existe uma base do SABRECC a mesma nao pode ser removida,
O motivo do restore é que o fornecedor identificou uma exclusao de registros neste dia e precisam ter acesso para correção da aplicação.


#INFO# : 20141202-22h01   : Script Started
#INFO# : Script Name      : /opt/ScriptsNBU/rman/DB_FULL_ALL_BKP.sh
#INFO# : Instances to Bkp : --->> PONTODB1 CARGODB1 CLMDB1 FISCALDB1 OSBPEL1 SABREMC1 SABRECC1 SABRELM1 ORADB1 SOADB1 TRXT4DB1  <<---
#INFO# : TEST MODE        : off
#INFO# : # ###################### START of Script Parameters ###################### #
#INFO# : RMAN_LOG_FILE    : /opt/ScriptsNBU/rman/Logs/Dly_DB_FULL_ALL_BKP-ORAFDBTB578A.servicos.20141202-22h01.19924.out
#INFO# : NB_ORA_SERV      : ipbtbms1
#INFO# : NB_ORA_FULL      : 1
#INFO# : NB_ORA_INCR      : 0
#INFO# : NB_ORA_CINC      : 0
#INFO# : NB_ORA_CLASS     : TB_AZL_D_OR_D_DIA_22_01
#INFO# : NB_ORA_POLICY    : TB_AZL_D_OR_D_DIA_22_01
#INFO# : NB_ORA_SCHED     :
#INFO# : NB_ORA_PC_SCHED  : FullDia
#INFO# : NB_ORA_CLIENT    : ORAFDBTB578A.servicos
#INFO# : Backup Type   : Full Backup Requested
#INFO# : Backup Level     : 0
#INFO# : # ###################### END   of Script Parameters ###################### #
#
#
#INFO# : 20141202-22h01   : Starting Bkp of  : -------->>>>> PONTODB1 <<<<<--------
#INFO# : Checking if LIBOBK is Linked to Netbackup Library for Oracle.
#INFO# : lrwxrwxrwx 1 ponto oinstall        36 Apr 27  2014 libobk.so -> /usr/openv/netbackup/bin/libobk.so64
#INFO# : Checking if Database Is Enterprise or Not:     [NotENT-vv]cat: -: Bad file descriptor


