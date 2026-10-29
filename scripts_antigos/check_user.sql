begin
  for lst in (select s.sid, s.serial#, s.username, s.osuser, s.machine, s.program,
                     i.instance_name, i.host_name, p.spid, s.sql_hash_value, s.status
              from v$session s, v$process p, v$instance i
              where s.sid = &v_sid
                and s.paddr = p.addr ) loop
    dbms_output.put_line('Sid..............: ' || lst.sid);
    dbms_output.put_line('Serial#..........: ' || lst.serial#);
    dbms_output.put_line('Status...........: ' || lst.status);
    dbms_output.put_line('Username.........: ' || lst.username);
    dbms_output.put_line('Maquina..........: ' || lst.machine);
    dbms_output.put_line('Programa.........: ' || lst.program);
    dbms_output.put_line('OS User..........: ' || lst.osuser);
    dbms_output.put_line('Host.............: ' || lst.host_name);
    dbms_output.put_line('Instance.........: ' || lst.instance_name);
    dbms_output.put_line('SQL Hash Value...: ' || lst.sql_hash_value);
    dbms_output.put_line('PID..............: ' || lst.spid);
  end loop;
end;
/