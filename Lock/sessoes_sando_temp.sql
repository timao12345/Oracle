SELECT
  su.username,
  s.osuser,
  su.tablespace,
  TO_CHAR (s.logon_time, 'dd/mm/yyyy hh:mi:ss') logon,
  s.sid, s.serial#,
  s.machine,
  s.terminal,
  s.program
  FROM
  v$sort_usage su JOIN
  v$session s ON su.session_addr = s.saddr;
