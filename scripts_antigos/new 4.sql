SESSAO                                                              ID1        ID2      LMODE    REQUEST TY   INSTANCE
------------------------------------------------------------ ---------- ---------- ---------- ---------- -- ----------
BLOQUEADOR: 360                                                  589871    1596748          6          0 TX          1
BLOQUEADO: 343                                                   589871    1596748          0          6 TX          1
BLOQUEADOR: 343                                                  851992    1412786          6          0 TX          1
BLOQUEADO: 338                                                   851992    1412786          0          6 TX          1
BLOQUEADO: 336                                                   851992    1412786          0          6 TX          1
BLOQUEADO: 345                                                   851992    1412786          0          6 TX          1
BLOQUEADO: 341                                                   851992    1412786          0          6 TX          1

7 rows selected.


                                                               SQL             LOGON
USERNAME               SID    SERIAL# STATUS   OSUSER          ID              TIME                 SQL_TEXT
--------------- ---------- ---------- -------- --------------- --------------- -------------------- ----------------------------------------------------------------------
SAPSR3                 360        349 ACTIVE   SAPPIPRD01\SAPS 02mvdc1gk5uuw   14/09/17:12:50:30    INSERT INTO "SXMSCLUP" VALUES(:A0 ,:A1 ,:A2 ,:A3 ,:A4 ,:A5 ,:A6
                                               erviceXIP

                                                                                                    ,:A7 )

                                                                                                                      LOGON
USERNAME          SID    SERIAL# SPID       STATUS   OSUSER     MACHINE                        PROGRAM                        TIME                      L_C_I EVENT
---------- ---------- ---------- ---------- -------- ---------- ------------------------------ ------------------------------ -------------------- ---------- -------------------------
SAPSR3            360        349 5532       ACTIVE   SAPPIPRD01 ESTACIOCORP\SAPPIPRD01         disp+work.EXE                  14-09-17 12:50:30        500123 db file sequential read
                                                     \SAPServic
                                                     eXIP
													 
												
												
                                                               SQL             LOGON
USERNAME               SID    SERIAL# STATUS   OSUSER          ID              TIME                 SQL_TEXT
--------------- ---------- ---------- -------- --------------- --------------- -------------------- ------------------------------------------------------------------
SAPSR3                 338          7 ACTIVE   SAPPIPRD01\SAPS 20gksdhgzy5qm   14/09/17:12:50:47    DELETE FROM "SXMSPEMAS" WHERE "MANDT"=:A0 AND "MSGGUID"=:A1 AND
                                               erviceXIP

                                                                                                    "PID"=:A2

