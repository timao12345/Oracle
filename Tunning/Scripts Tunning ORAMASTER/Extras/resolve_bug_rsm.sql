select 'execute dbms_scheduler.set_attribute(' || '''' || window_name || '''' || ','|| '''' || 'RESOURCE_PLAN' || '''' || ',' || '''' || '''' || ')'
from DBA_SCHEDULER_WINDOWS;
 
execute dbms_scheduler.set_attribute('MONDAY_WINDOW','RESOURCE_PLAN','');
execute dbms_scheduler.set_attribute('TUESDAY_WINDOW','RESOURCE_PLAN','');
execute dbms_scheduler.set_attribute('WEDNESDAY_WINDOW','RESOURCE_PLAN','');
execute dbms_scheduler.set_attribute('THURSDAY_WINDOW','RESOURCE_PLAN','');
execute dbms_scheduler.set_attribute('FRIDAY_WINDOW','RESOURCE_PLAN','');
execute dbms_scheduler.set_attribute('SATURDAY_WINDOW','RESOURCE_PLAN','');
execute dbms_scheduler.set_attribute('SUNDAY_WINDOW','RESOURCE_PLAN','');
execute dbms_scheduler.set_attribute('WEEKNIGHT_WINDOW','RESOURCE_PLAN','');
execute dbms_scheduler.set_attribute('WEEKEND_WINDOW','RESOURCE_PLAN','');


alter system set resource_manager_plan='' scope=both; -- 2 single '