-- Check process dataguard

Select Process, Status, Group#, thread#, Sequence#
From gv$managed_standby;
