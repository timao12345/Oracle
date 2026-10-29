
SELECT originating_timestamp,
       message_text
FROM   v$diag_alert_ext
WHERE  message_text LIKE '%ORA-%'
ORDER BY originating_timestamp DESC;



SELECT originating_timestamp,
       message_text
FROM   v$diag_alert_ext
WHERE  originating_timestamp > SYSDATE - (1/24)
AND    message_text LIKE '%ORA-%'
ORDER BY originating_timestamp DESC;


SELECT 
    originating_timestamp,
    message_level,
    message_type,
    message_text
FROM 
    v$diag_alert_ext
WHERE 
    originating_timestamp > SYSDATE - (5/1440) 
    AND message_text LIKE '%ORA-%'
ORDER BY 
    originating_timestamp DESC;




-- pro zabbix
sqlplus -s / as sysdba <<EOF
set pages 0 feedback off heading off
SELECT count(*) 
FROM v\$diag_alert_ext
WHERE originating_timestamp > SYSDATE - (5/1440)
AND message_text LIKE '%ORA-%';
exit;
EOF