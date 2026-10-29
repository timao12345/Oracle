col owner for a20
col mview_name for a30
col last_refresh for a20
col refresh_mode for a20
col refresh_method for a20
SELECT owner, mview_name, last_refresh_date, refresh_mode, refresh_method
  FROM dba_mviews
 WHERE mview_name = 'MVIEW_INVENTARY_PIVOTS';