-- criação de trigger para alterar a nivel de sessão de um determinado usuario optimizer_features_enable
CREATE OR REPLACE EDITIONABLE TRIGGER "SYS"."TRG_LOGON_1901"
  After Logon On database
   WHEN (User In ('POSEIDON')) Declare
Begin
    if  user = 'POSEIDON'  then
       execute immediate 'alter session set optimizer_features_enable = ''19.0.1''';
    end if;
End;
/