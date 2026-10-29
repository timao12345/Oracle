begin
  dbms_network_acl_admin.create_acl (
    acl         => 'daterraatacadoevarejo.com.br.xml',
    description => 'Null',
    principal   => 'CONSINCO',
    is_grant    => TRUE,
    privilege   => 'connect',
    start_date  => null,
    end_date    => null
  );
 
  dbms_network_acl_admin.add_privilege (
    acl        => 'daterraatacadoevarejo.com.br.xml',
    principal  => 'CONSINCO',
    is_grant   => TRUE,
    privilege  => 'resolve',
    start_date => null,
    end_date   => null
  );
 
  dbms_network_acl_admin.assign_acl (
    acl        => 'daterraatacadoevarejo.com.br.xml',
    host       => 'daterraatacadoevarejo.com.br',
    lower_port => null,
    upper_port => null
  );
  commit;
end;
/