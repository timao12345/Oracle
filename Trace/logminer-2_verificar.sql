begin
  sys.DBMS_LOGMNR_D.BUILD( OPTIONS=> sys.DBMS_LOGMNR_D.STORE_IN_REDO_LOGS);
  sys.dbms_logmnr.add_logfile('/tmkt/archive/log1_1870.arc') ;
  sys.dbms_logmnr.add_logfile('/tmkt/archive/log1_1871.arc') ;
  sys.dbms_logmnr.add_logfile('/tmkt/archive/log1_1872.arc') ;
  sys.dbms_logmnr.add_logfile('/tmkt/archive/log1_1873.arc') ;
    
  sys.DBMS_LOGMNR.START_LOGMNR ;
                               
                               
end;