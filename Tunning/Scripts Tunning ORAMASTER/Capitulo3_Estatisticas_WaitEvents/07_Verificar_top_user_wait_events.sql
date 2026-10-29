-- p/ consultar a V$ACTIVE_SESSION_HISTORY precisa ter a licenca da option "Diagnostics Pack"

-- ver top events nos ultimos 30 minutos (linha com valor NULL eh o tempo que a sessao nao teve wait time)
-- p/ consultar a V$ACTIVE_SESSION_HISTORY precisa ter a licenca da option "Diagnostics Pack"
SELECT    EVENT,
          COUNT(1)
FROM      V$ACTIVE_SESSION_HISTORY
WHERE     SAMPLE_TIME > to_timestamp(sysdate - 30/60/24)
GROUP BY  EVENT
order by  COUNT(1) desc;

-- A CONSULTA RETORNOU ALGO?

-- habilite os packs diagnostics e tuning pack e depois consulte novamente a view do ASH:
ALTER SESSION SET CONTAINER = CDB$ROOT;
alter SYSTEM SET control_management_pack_access = 'DIAGNOSTIC+TUNING';
ALTER SESSION SET CONTAINER = pdbxe;

-- para ver lista de sessoes e usuarios com mais waits dos ultimos 30 minutos
select      s.sid, s.username,
            COUNT(1)
from        v$active_session_history a
inner join  v$session s
    on      a.session_id=s.sid
where       a.sample_time > to_timestamp(sysdate - 30/60/24)
and         s.username is not null
GROUP BY    S.SID, S.USERNAME
order by    COUNT(1) desc;