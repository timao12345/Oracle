begin
  sys.DBMS_LOGMNR.START_LOGMNR(
                               
                               STARTTIME => to_date('22/07/2009 11:10:00',
                                                    'dd/mm/yyyy hh24:mi:ss'),
                               ENDTIME   => to_date('22/07/2009 11:15:00',
                                                    'dd/mm/yyyy hh24:mi:ss'),
                               OPTIONS   => sys.DBMS_LOGMNR.DICT_FROM_ONLINE_CATALOG +
                                            sys.DBMS_LOGMNR.CONTINUOUS_MINE);
end;