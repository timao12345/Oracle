select username,account_status from dba_users where username='HP_DBSPI';

select NAME,PASSWORD from user$ where NAME='HP_DBSPI';

NAME                           PASSWORD
------------------------------ ------------------------------
HP_DBSPI                       968D6FCA030FC457

alter user HP_DBSPI identified by OrASP1TSyst3m5;
HP_DBSPI / OrASP1TSyst3m5