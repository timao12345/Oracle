rem The ASA_RECOMMENDATIONS procedure in the DBMS_SPACE package returns a nested table object that contains findings or recommendations for Automatic Segment Advisor runs and, optionally, 
rem manual Segment Advisor runs. Calling this procedure may be easier than working with the DBA_ADVISOR_* views, because the procedure performs all the required joins for you and
rem returns information in an easily consumable format.
rem The following query returns recommendations by the most recent run of the Auto Segment Advisor, with the suggested command to run to follow the recommendations:

col tablespace_name for a15
col segment_name for a20
col segment_type for a11
col partition_name for a10
col RECOMMENDATIONS for a55
col C1 for a60
select tablespace_name, segment_name, segment_type, partition_name,
recommendations, c1 from
table(dbms_space.asa_recommendations('FALSE', 'FALSE', 'FALSE'));
