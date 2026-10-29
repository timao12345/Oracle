Which Files Are Part Of SHORTP_POLICY And LONGP_POLICY In ADR? (Doc ID 975448.1)


IM4281743
IM4298157
IM4298211
IM4300220
IM4300228
IM4300420
IM4303691
IM4303692




ADRID                SHORTP_POLICY        LONGP_POLICY         LAST_MOD_TIME                            LAST_AUTOPRG_TIME                        LAST_MANUPRG_TIME                        ADRDIR_VERSION       ADRSCHM_VERSION      ADRSCHMV_SUMMARY     ADRALERT_VERSION     CREATE_TIME
-------------------- -------------------- -------------------- ---------------------------------------- ---------------------------------------- ---------------------------------------- -------------------- -------------------- -------------------- -------------------- ----------------------------------------
1191613982           720                  8760                 2013-06-24 01:15:08.902627 -03:00        2015-02-18 00:20:01.629427 -02:00                                                 1                    2                    80                   1                    2013-06-24 01:15:08.902627 -03:00


ADRID                SHORTP_POLICY        LONGP_POLICY         LAST_MOD_TIME                            LAST_AUTOPRG_TIME                        LAST_MANUPRG_TIME                        ADRDIR_VERSION       ADRSCHM_VERSION      ADRSCHMV_SUMMARY     ADRALERT_VERSION     CREATE_TIME
-------------------- -------------------- -------------------- ---------------------------------------- ---------------------------------------- ---------------------------------------- -------------------- -------------------- -------------------- -------------------- ----------------------------------------
1191613982           360                  2190                 2015-02-24 19:37:45.131983 -03:00        2015-02-18 00:20:01.629427 -02:00                                                 1                    2                    80                   1                    2013-06-24 01:15:08.902627 -03:00


SHORTP_POLICY=360
LONGP_POLICY=

3 Meses Long policy
8760/12 x 3 = 2190/24

adrci> set home diag/rdbms/racprds/racprds1
adrci> show control

set control (SHORTP_POLICY = 168)
set control (LONGP_POLICY = 720)

