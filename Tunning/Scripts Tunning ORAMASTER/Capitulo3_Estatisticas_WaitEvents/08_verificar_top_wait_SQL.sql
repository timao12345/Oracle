-- p/ consultar a V$ACTIVE_SESSION_HISTORY precisa ter a licenca da option "Diagnostics Pack"

-- ver top SQL em tempo de espera nos ultimos 30 minutos
select      u.username,
            (sum(ash.wait_time + ash.time_waited) / 1000000) as ttl_wait_time_sec,
            ROUND( (sum(ash.wait_time + ash.time_waited) / 1000000) /60, 2) as ttl_wait_time_min,
            s.sql_text              
from        v$active_session_history ash
inner join  v$sqlarea s
    on      ash.sql_id = s.sql_id
inner join  dba_users u
    on      ASH.USER_ID = U.USER_ID
where       ash.sample_time > sysdate -1/24
group by    ash.user_id,s.sql_text, u.username
order by    ttl_wait_time_sec DESC;

