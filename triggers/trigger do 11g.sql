create or replace package sys.DBM is
  procedure dbm_set_param;
end DBM;
/

create or replace package body sys.DBM is
  procedure dbm_set_param is
  begin
    execute immediate 'alter session set optimizer_features_enable = ''11.2.0.4''';
  end dbm_set_param;
end DBM;
/


create or replace trigger sys.TA_DBM_SET_PARAMCOMPAT10G after logon on database
begin
    if  user = 'CONSINCOMONITOR'  then
      sys.dbm.dbm_set_param;
    end if;
end;
/

CREATE OR REPLACE  TRIGGER "SYS"."TRG_LOGON_11204"
  After Logon On database
   WHEN (User In ('CONSINCO')) 
Declare
Begin
   if lower(Sys_Context('USERENV', 'MODULE')) = 'fiscal-guanabara-m.exe'   then
     execute immediate 'alter session set optimizer_features_enable = ''19.1.0''';
   end if;
End;
/