select tablespace_name, username, bytes, max_bytes
    from dba_ts_quotas
    where tablespace_name = 'WCSCST_TS_WCSITES'
      and username = 'WCSCST_WCSITES';

ALTER USER usr_1 QUOTA 20M ON tbs_1;