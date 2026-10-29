select sid,username,opname,target,
       ltrim  (to_char(floor((elapsed_seconds+time_remaining)/3600  ), '000' ))    || ':' ||
       substr (to_char(mod  (floor ((elapsed_seconds+time_remaining)/60) ,60 ), '00'),2,2)  || ':' ||
       substr (to_char(mod  ((elapsed_seconds+time_remaining),60    ), '00'),2,2) "estimated time",
       ltrim  (to_char(floor(time_remaining/3600  ), '000' ))    || ':' ||
       substr (to_char(mod  (floor (time_remaining/60) ,60 ), '00'),2,2)  || ':' ||
       substr (to_char(mod  (time_remaining,60    ), '00'),2,2) "Remaining",
       trunc((elapsed_seconds/(elapsed_seconds+time_remaining))*100) "% exec"
 from v$session_longops where time_remaining > 0