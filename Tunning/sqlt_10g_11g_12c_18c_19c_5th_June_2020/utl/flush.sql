REM Flushes the shared pool. Just execute "@flush.sql" from sqlplus.

alter system flush shared_pool;
alter system flush buffer_cache;
