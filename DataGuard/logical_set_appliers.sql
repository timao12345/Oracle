begin
  dbms_logstdby.apply_set('APPLY_SERVERS',20);
  dbms_logstdby.apply_set('PRESERVE_COMMIT_ORDER','FALSE');
end;
/
