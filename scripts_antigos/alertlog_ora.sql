-- See erro ORA on Alertlog.

undef days
set lines 100
set pages 1000
select to_char (ORIGINATING_TIMESTAMP, 'DD-MM-YYYY HH24:MI') data, 
 message_text
 from x$dbgalertext
 where ORIGINATING_TIMESTAMP > (SYSDATE -&&days)
 and message_text like '%ORA-%';