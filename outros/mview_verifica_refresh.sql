
-- verifica ultimo refresh da materialized view
col owner for a20
col mview_name for a30
col last_refresh for a20
col refresh_mode for a20
col refresh_method for a20
SELECT owner, mview_name, last_refresh_date, refresh_mode, refresh_method
  FROM dba_mviews
 WHERE mview_name = 'FUNCIONARIOS';

-- opção de consulta 2
col owner for a20
col mview_name for a30
col last_refresh for a20
col refresh_mode for a20
col refresh_method for a20
SELECT owner, mview_name, to_char(last_refresh_date, 'DD-MON-YY HH24:MI:SS')as last_refresh_date, refresh_mode, refresh_method
  FROM dba_mviews
 WHERE mview_name like '%FUNCIONARIOS%';


-- opção 3
 SELECT * 
FROM (
      SELECT OWNER,
             MVIEW_NAME,
             CONTAINER_NAME,
             REFRESH_MODE,
             REFRESH_METHOD,
             LAST_REFRESH_TYPE,
             STALENESS,
             ROUND((LAST_REFRESH_END_TIME-LAST_REFRESH_DATE)*24*60,2) as REFRESH_TIME_MINS
       FROM ALL_MVIEWS
       WHERE LAST_REFRESH_TYPE IN ('FAST','COMPLETE')
      )
ORDER BY REFRESH_TIME_MINS DESC;

-- executa refresh
EXEC DBMS_MVIEW.refresh('ORARH.SN_RH_FUNCIONARIOS_PDIS');