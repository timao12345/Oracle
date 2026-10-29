select 'alter system kill session ' || '''' || sessoes.sid || ',' || sessoes.serial# || ''';'
from
     (SELECT s.SID, s.serial#, s.USERNAME, s.STATUS, s.OSUSER, s.TERMINAL, s.PROGRAM, s.LOGON_TIME,
              sysdate - (s.LAST_CALL_ET / 3600) last_call,
              s.FIXED_TABLE_SEQUENCE, p.spid, s.module, s.action,
              row_wait_obj#, row_wait_file#, row_wait_block#, row_wait_row#
      FROM   SYS.V_$SESSION s, sys.v_$process p
      WHERE  s.TYPE = 'USER'
      AND    s.USERNAME IS NOT NULL
      and s.paddr = p.addr ) sessoes
where  to_char(sysdate, 'dd' ) - to_char(sessoes.last_call, 'dd') >= 1
