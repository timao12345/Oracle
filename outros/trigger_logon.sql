create or replace TRIGGER ignore_hint
AFTER LOGON ON database when (user='HR')
begin
execute immediate
'alter session set "_optimizer_ignore_hints"=TRUE';
end;