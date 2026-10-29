 set linesize 100 
  alter session set NLS_DATE_FORMAT='DD-MON-YYYY HH24:MI:SS'; 
  select usn, state, undoblockstotal "Total", undoblocksdone "Done", undoblockstotal-undoblocksdone "ToDo",
         decode(cputime,0,'unknown',sysdate+(((undoblockstotal-undoblocksdone) / (undoblocksdone / cputime)) / 86400)) "Estimated time to complete" 
  from v$fast_start_transactions; 

Run the above query several times in a row, this will give you a good idea on how SMON is progressing. 

- In some versions the cputime does not work (always 0), hence the estimated completion time will not be displayed 
- In some cases the v$fast_start_transactions view will not work. If this is the case then you can query the internal data dictionary view x$ktuxe, the 'ktuxesiz' column represents the remaining number of undo blocks required for rollback: 


   select ktuxeusn, to_char(sysdate,'DD-MON-YYYY HH24:MI:SS') "Time", ktuxesiz, ktuxesta 
   from x$ktuxe 
   where ktuxecfl = 'DEAD'; 
   
   