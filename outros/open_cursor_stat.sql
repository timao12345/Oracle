select max(a.value) "highest_open_cur", p.value "max_open_cur"
  from v$sesstat a, v$statname b, v$parameter p
 where a.statistic#=b.statistic#
  and b.name='opened cursors current'
  and p.name='open_cursors'
group by p.value
/


SELECT s.sid, s.serial#, s.username, COUNT(o.saddr) AS qtd_cursores
FROM v$open_cursor o
JOIN v$session s ON o.saddr = s.saddr
GROUP BY s.sid, s.serial#, s.username
HAVING COUNT(o.saddr) > 50
ORDER BY qtd_cursores DESC;


SELECT s.sid, s.serial#, s.username, COUNT(o.saddr) AS qtd_cursores
FROM v$open_cursor o
JOIN v$session s ON o.saddr = s.saddr

GROUP BY s.sid, s.serial#, s.username
HAVING COUNT(o.saddr) > 50
ORDER BY qtd_cursores DESC;


SELECT sid, USER_NAME,ADDRESS,HASH_VALUE,SQL_ID, CURSOR_TYPE,CHILD_ADDRESS
FROM v$open_cursor
where SQL_ID='60g2txkgg33vp';


SELECT q.sql_text, o.sid, o.user_name
FROM v$open_cursor o
JOIN v$sql q ON o.address = q.address;