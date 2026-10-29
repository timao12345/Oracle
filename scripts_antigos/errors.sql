set lines 900
col name for a50
col MESSAGE_NUMBER for a90
select owner, name, type, sequence, line, position, text message_number from dba_errors;