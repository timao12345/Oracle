Uma vez os status dos recursos estavam em INTERMEDIATE, rodamos os comandos abaixo e resolveram

[grid@dbtb775anew ~]$ crsctl check resource ora.ORAFRA.dg
[grid@dbtb775anew ~]$ crsctl check resource ora.ORADATA.dg
[grid@dbtb775anew ~]$ crsctl status resource -t
--------------------------------------------------------------------------------
NAME           TARGET  STATE        SERVER                   STATE_DETAILS
--------------------------------------------------------------------------------
Local Resources
--------------------------------------------------------------------------------
ora.LISTENER.lsnr
               ONLINE  ONLINE       dbtb775anew
               ONLINE  ONLINE       dbtb775bnew
ora.ORADATA.dg
               ONLINE  ONLINE       dbtb775anew
               ONLINE  ONLINE       dbtb775bnew
ora.ORAFRA.dg
               ONLINE  ONLINE       dbtb775anew
               ONLINE  ONLINE       dbtb775bnew
ora.ORAVOTEOCR.dg
               ONLINE  ONLINE       dbtb775anew
               ONLINE  ONLINE       dbtb775bnew
