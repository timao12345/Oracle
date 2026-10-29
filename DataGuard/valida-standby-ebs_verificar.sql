***standby
select to_char(COMPLETION_TIME, 'dd/mm/yyyy hh24:mi') COMPLETION_TIME, THREAD#, SEQUENCE#, ARCHIVED, APPLIED, DELETED
from v$archived_log

***scn primary / standby
[Standby] 
select to_char(current_scn) from v$database;

[Primary]
select to_char(scn_to_timestamp('&SCN_DO_STANDBY'),'DD/MM/YYYY HH24:MI:SS') from dual;

***dg broker no primary
dgmgrl
connect sys   -->> sX2n7uKfb2yl

DGMGRL> show database ebs

Database - ebs

  Role:            PRIMARY
  Intended State:  TRANSPORT-ON
  Instance(s):
    EBS1
    EBS2

Database Status:
SUCCESS

DGMGRL> show database ebs_ods

Database - ebs_ods

  Role:            PHYSICAL STANDBY
  Intended State:  APPLY-ON
  Transport Lag:   0 seconds (computed 1 second ago)
  Apply Lag:       0 seconds (computed 0 seconds ago)
  Apply Rate:      868.00 KByte/s
 Real Time Query: ON
  Instance(s):
    EBS_ODS

Database Status:
SUCCESS

DGMGRL> show configuration verbose;

Configuration - EBS

  Protection Mode: MaxPerformance
  Databases:
    ebs     - Primary database
    ebs_ods - Physical standby database

  Properties:
    FastStartFailoverThreshold      = '30'
    OperationTimeout                = '30'
    FastStartFailoverLagLimit       = '30'
    CommunicationTimeout            = '180'
    ObserverReconnect               = '0'
    FastStartFailoverAutoReinstate  = 'TRUE'
    FastStartFailoverPmyShutdown    = 'TRUE'
    BystandersFollowRoleChange      = 'ALL'
    ObserverOverride                = 'FALSE'
    ExternalDestination1            = ''
    ExternalDestination2            = ''
    PrimaryLostWriteAction          = 'CONTINUE'

Fast-Start Failover: DISABLED

Configuration Status:
