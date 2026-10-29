Using username "tsystems173".
Last login: Thu Oct  5 14:03:59 2017 from 160.118.128.99
[tsystems173@prdst2dbn01 ~]$ sudo su - oracle
Last login: Thu Oct  5 15:35:04 BRT 2017
[15:37:02 oracle@prdst2dbn01 ~]$ cd /u01/app/grid/
[15:37:10 oracle@prdst2dbn01 grid]$ ll
total 4
drwxr-x---  4 grid oinstall   31 Apr 10  2015 admin
drwxr-x---  2 grid oinstall    6 Apr 10  2015 audit
drwxr-x---  6 grid oinstall   54 Apr 10  2015 cfgtoollogs
drwxr-xr-x  2 grid oinstall    6 Apr 10  2015 checkpoints
drwxrwxr-x  4 grid oinstall   38 Apr  9  2015 crsdata
drwxr-x--- 19 grid oinstall 4096 Apr  9  2015 diag
drwxr-xr-x  3 grid oinstall   17 Apr 15  2015 log
drwxr-xr-x  3 grid oinstall   24 Apr  9  2015 prdst2dbn01
drwxr-xr-x  3 grid oinstall   21 Jan 11  2017 script
drwxr-x--x  4 root root       67 Apr  9  2015 tfa
[15:37:11 oracle@prdst2dbn01 grid]$ cd prdst2dbn01
[15:37:17 oracle@prdst2dbn01 prdst2dbn01]$ ll
total 0
drwxr-xr-x 3 grid oinstall 22 Apr  9  2015 checkpoints
[15:37:18 oracle@prdst2dbn01 prdst2dbn01]$ cd ..
[15:37:20 oracle@prdst2dbn01 grid]$ cd tfa/
[15:37:22 oracle@prdst2dbn01 tfa]$
[15:37:51 oracle@prdst2dbn01 tfa]$
[15:37:52 oracle@prdst2dbn01 tfa]$
[15:37:53 oracle@prdst2dbn01 tfa]$ pwd
/u01/app/grid/tfa
[15:37:54 oracle@prdst2dbn01 tfa]$ sudo su -
Last login: Thu Oct  5 14:04:06 BRT 2017 on pts/5
[root@prdst2dbn01 ~]#
[root@prdst2dbn01 ~]#
[root@prdst2dbn01 ~]# cd /u01/app/12.1.0.2.0/grid/tfa/
[root@prdst2dbn01 tfa]# cd bin
[root@prdst2dbn01 bin]# pwd
/u01/app/12.1.0.2.0/grid/tfa/bin
[root@prdst2dbn01 bin]# ll
total 4
-rwxr-xr-x 1 root root 2259 May  9 20:01 tfactl
[root@prdst2dbn01 bin]# ./tfactl
                                                                                                                                                                     tfactl> toolstatus
.------------------------------------------.
|          External Support Tools          |
+-------------+--------------+-------------+
| Host        | Tool         | Status      |
+-------------+--------------+-------------+
| prdst2dbn01 | alertsummary | DEPLOYED    |
| prdst2dbn01 | exachk       | DEPLOYED    |
| prdst2dbn01 | ls           | DEPLOYED    |
| prdst2dbn01 | pstack       | DEPLOYED    |
| prdst2dbn01 | orachk       | DEPLOYED    |
| prdst2dbn01 | sqlt         | DEPLOYED    |
| prdst2dbn01 | grep         | DEPLOYED    |
| prdst2dbn01 | summary      | DEPLOYED    |
| prdst2dbn01 | prw          | NOT RUNNING |
| prdst2dbn01 | vi           | DEPLOYED    |
| prdst2dbn01 | tail         | DEPLOYED    |
| prdst2dbn01 | param        | DEPLOYED    |
| prdst2dbn01 | dbglevel     | DEPLOYED    |
| prdst2dbn01 | darda        | DEPLOYED    |
| prdst2dbn01 | history      | DEPLOYED    |
| prdst2dbn01 | oratop       | DEPLOYED    |
| prdst2dbn01 | oswbb        | RUNNING     |
| prdst2dbn01 | dbperf       | DEPLOYED    |
| prdst2dbn01 | changes      | DEPLOYED    |
| prdst2dbn01 | events       | DEPLOYED    |
| prdst2dbn01 | ps           | DEPLOYED    |
| prdst2dbn01 | srdc         | DEPLOYED    |
'-------------+--------------+-------------'
                                                                                                                                                                     tfactl> menu

Usage : /u01/app/12.1.0.2.0/grid/bin/tfactl <command> [options]
<command> =
          start        Starts TFA
          stop         Stops TFA
          enable       Enable TFA Auto restart
          disable      Disable TFA Auto restart
          print        Print requested details
          access       Add or Remove or List TFA Users
          purge        Delete collections from TFA repository
          directory    Add or Remove or Modify directory in TFA
          host         Add or Remove host in TFA
          diagcollect  Collect logs from across nodes in cluster
          collection   Manage TFA Collections
          analyze      List events summary and search strings in alert logs.
          set          Turn ON/OFF or Modify various TFA features
          toolstatus     Prints the status of TFA Support Tools
          run <tool>     Run the desired support tool
          start <tool>   Starts the desired support tool
          stop <tool>    Stops the desired support tool
          syncnodes      Generate/Copy TFA Certificates
          diagnosetfa    Collect TFA Diagnostics
          uninstall      Uninstall TFA from this node

For help with a command: /u01/app/12.1.0.2.0/grid/bin/tfactl <command> -help

                                                                                                                                                                     tfactl> help

Usage : /u01/app/12.1.0.2.0/grid/bin/tfactl <command> [options]
<command> =
          start        Starts TFA
          stop         Stops TFA
          enable       Enable TFA Auto restart
          disable      Disable TFA Auto restart
          print        Print requested details
          access       Add or Remove or List TFA Users
          purge        Delete collections from TFA repository
          directory    Add or Remove or Modify directory in TFA
          host         Add or Remove host in TFA
          diagcollect  Collect logs from across nodes in cluster
          collection   Manage TFA Collections
          analyze      List events summary and search strings in alert logs.
          set          Turn ON/OFF or Modify various TFA features
          toolstatus     Prints the status of TFA Support Tools
          run <tool>     Run the desired support tool
          start <tool>   Starts the desired support tool
          stop <tool>    Stops the desired support tool
          syncnodes      Generate/Copy TFA Certificates
          diagnosetfa    Collect TFA Diagnostics
          uninstall      Uninstall TFA from this node

For help with a command: /u01/app/12.1.0.2.0/grid/bin/tfactl <command> -help

                                                                                                                                                                     tfactl>
                                                                                                                                                                     tfactl>
                                                                                                                                                                     tfactl>
                                                                                                                                                                     tfactl> help

Usage : /u01/app/12.1.0.2.0/grid/bin/tfactl <command> [options]
<command> =
          start        Starts TFA
          stop         Stops TFA
          enable       Enable TFA Auto restart
          disable      Disable TFA Auto restart
          print        Print requested details
          access       Add or Remove or List TFA Users
          purge        Delete collections from TFA repository
          directory    Add or Remove or Modify directory in TFA
          host         Add or Remove host in TFA
          diagcollect  Collect logs from across nodes in cluster
          collection   Manage TFA Collections
          analyze      List events summary and search strings in alert logs.
          set          Turn ON/OFF or Modify various TFA features
          toolstatus     Prints the status of TFA Support Tools
          run <tool>     Run the desired support tool
          start <tool>   Starts the desired support tool
          stop <tool>    Stops the desired support tool
          syncnodes      Generate/Copy TFA Certificates
          diagnosetfa    Collect TFA Diagnostics
          uninstall      Uninstall TFA from this node

For help with a command: /u01/app/12.1.0.2.0/grid/bin/tfactl <command> -help

 tfactl> diagcollect -exemples
Unknown option: exemples

Usage: /u01/app/12.1.0.2.0/grid/bin/tfactl diagcollect [-all | -database <all|d1,d2..> | -asm | -dbwlm | -tns | -crs | -wls | -emagent | -oms | -ocm | -emplugins | -em | -acfs | -install | -cfgtools | -os | -ashhtml | -ashtext | -awrhtml | -awrtext | -chmos | -srdc <srdc_profile> ] [-node <all | local | n1,n2,..>] [-tag <tagname>] [-z <filename>] [-last <n><h|d>| -from <time> -to <time> | -for <time>] [-nocopy] [-notrim] [-silent] [-collectalldirs]

Options:
  -all       Collect all logs (If no time is given for collection then files
             for the last 4 hours will be collected)
  -asm       Collect ASM logs
  -dbwlm     Collect DBWLM logs
  -tns       Collect TNS logs
  -crs       Collect CRS logs
  -wls       Collect WLS logs
  -emagent   Collect EMAGENT logs
  -oms       Collect OMS logs
  -ocm       Collect OCM logs
  -emplugins  Collect EMPLUGINS logs
  -em        Collect EM logs
  -acfs      Collect ACFS logs
  -install   Collect Oracle Installation related files
  -cfgtools  Collect CFGTOOLS logs
  -os        Collect OS files such as /var/log/messages
  -ashhtml   Collect Generate ASH HTML Report
  -ashtext   Collect Generate ASH TEXT Report
  -awrhtml   Collect AWRHTML logs
  -awrtext   Collect AWRTEXT logs
  -srdc      Service Request Data Collection (SRDC).
  -database  Collect database logs from databases specified
  -chmos     Collect CHMOS files (Note that this data can be large for
             longer durations)
  -nocores   Do not collect Core files when it would normally have been
             collected
  -collectalldirs Collect all files from a directory marked "Collect All"
                  flag to true
  -node      Specify comma separated list of host names for collection
  -nocopy    Does not copy back the zip files to initiating node from all nodes
  -notrim    Does not trim the files collected
  -silent    This option is used to submit the diagcollection as a background
             process

  -last  <n><h|d>    Files from last 'n' [d]ays or 'n' [h]ours
  -since Same as -last. Kept for backward compatibility.
  -from "Mon/dd/yyyy hh:mm:ss"    From <time>
  -to   "Mon/dd/yyyy hh:mm:ss"    To <time>
  -for  "Mon/dd/yyyy"             For <date>.
  -tag <tagname> The files will be collected into tagname directory inside
                 repository

  -z <zipname> The files will be collected into tagname directory with the
               specified zipname
Examples:
  /u01/app/12.1.0.2.0/grid/bin/tfactl diagcollect
    Trim and Zip all files updated in the last 24 hours as well as chmos/osw data
    from across the cluster and collect at the initiating node

    Note: This collection could be larger than required but is there as the
    simplest way to capture diagnostics if an issue has recently occurred.

  /u01/app/12.1.0.2.0/grid/bin/tfactl diagcollect -all -last 8h
    Trim and Zip all files updated in the last 8 hours as well as chmos/osw data
    from across the cluster and collect at the initiating node

  /u01/app/12.1.0.2.0/grid/bin/tfactl diagcollect -database hrdb,fdb -last 1d -z foo
    Trim and Zip all files from databases hrdb & fdb in the last 1 day and
    collect at the initiating node

  /u01/app/12.1.0.2.0/grid/bin/tfactl diagcollect -crs -os -node node1,node2 -last 6h
    Trim and Zip all crs files, o/s logs and chmos/osw data from node1 & node2
    updated in the last 6 hours and collect at the initiating node

  /u01/app/12.1.0.2.0/grid/bin/tfactl diagcollect -asm -node node1 -from Mar/4/2013 -to "Mar/5/2013 21:00:00"
    Trim and Zip all ASM logs from node1 updated between from and to time and
    collect at the initiating node

  /u01/app/12.1.0.2.0/grid/bin/tfactl diagcollect -for "Mar/2/2013"
    Trim and Zip all log files updated on "Mar/2/2013" and collect at the
    initiating node

  /u01/app/12.1.0.2.0/grid/bin/tfactl diagcollect -for "Mar/2/2013 21:00:00"
    Trim and Zip all log files updated from 09:00 on March 2 to 09:00 on March 3
    (i.e. 12 hours before and after the time given) and collect at the initiating node


tfactl> diagcollect -all -last -10h
The time entered is invalid: -10h
Some examples of valid time entries for -since flag : 2h, 10d
tfactl> diagcollect -all -last 10h

Collecting data for all components using above parameters...
Collecting data for all nodes

Collection Id : 20171005154134prdst2dbn01

Repository Location in prdst2dbn01 : /u01/app/grid/tfa/repository

Collection monitor will wait up to 60 seconds for collections to start
2017/10/05 15:41:39 BRT : NOTE : Any file or directory name containing the string .com will be renamed to replace .com with dotcom
2017/10/05 15:41:39 BRT : Collection Name : tfa_Thu_Oct_5_15_41_34_BRT_2017.zip
2017/10/05 15:41:39 BRT : Sending diagcollect request to host : prdst2dbn02
2017/10/05 15:41:39 BRT : Scanning of files for Collection in progress...
2017/10/05 15:41:39 BRT : Collecting extra files...
2017/10/05 15:43:44 BRT : Completed collection of extra files...
2017/10/05 15:51:39 BRT : Getting list of files satisfying time range [10/05/2017 05:41:39 BRT, 10/05/2017 15:51:39 BRT]
2017/10/05 15:51:39 BRT : Starting Thread to identify stored files to collect
2017/10/05 15:51:39 BRT : Getting List of Files to Collect
2017/10/05 15:51:39 BRT : Trimming file : prdst2dbn01/u01/app/grid/crsdata/prdst2dbn01/cvu/cvutrc/cvuhelper.log.0 with original file size : 22MB
2017/10/05 15:51:43 BRT : Trimming file : prdst2dbn01/u01/app/grid/crsdata/prdst2dbn01/cvu/cvutrc/cvutrace.log.3 with original file size : 26MB
2017/10/05 15:51:43 BRT : Trimming file : prdst2dbn01/crs/prdst2dbn01/crs/trace/alert.log with original file size : 4.1MB
2017/10/05 15:51:43 BRT : Trimming file : prdst2dbn01/crs/prdst2dbn01/crs/trace/crsd_655.trc with original file size : 10MB
2017/10/05 15:51:43 BRT : Trimming file : prdst2dbn01/crs/prdst2dbn01/crs/trace/crsd_oraagent_grid.trc with original file size : 5.7MB
2017/10/05 15:51:44 BRT : Trimming file : prdst2dbn01/crs/prdst2dbn01/crs/trace/crsd_oraagent_oracle.trc with original file size : 2.4MB
2017/10/05 15:51:44 BRT : Trimming file : prdst2dbn01/crs/prdst2dbn01/crs/trace/crsd_orarootagent_root.trc with original file size : 1.8MB
2017/10/05 15:51:44 BRT : Trimming file : prdst2dbn01/crs/prdst2dbn01/crs/trace/evmd.trc with original file size : 7.2MB
2017/10/05 15:51:44 BRT : Trimming file : prdst2dbn01/crs/prdst2dbn01/crs/trace/gipcd.trc with original file size : 9.5MB
2017/10/05 15:51:44 BRT : prdst2dbn01: Zipped 100 Files so Far
2017/10/05 15:51:47 BRT : Trimming file : prdst2dbn01/crs/prdst2dbn01/crs/trace/ohasd_oraagent_grid.trc with original file size : 7.1MB
2017/10/05 15:51:47 BRT : Trimming file : prdst2dbn01/crs/prdst2dbn01/crs/trace/ohasd_orarootagent_root_701.trc with original file size : 10MB
2017/10/05 15:51:47 BRT : Finished Getting List of Files to Collect
2017/10/05 15:51:53 BRT : prdst2dbn01: Zipped 200 Files so Far
2017/10/05 15:51:55 BRT : Trimming file : prdst2dbn01/var/log/messages with original file size : 2.2MB
2017/10/05 15:51:55 BRT : Trimming file : prdst2dbn01/rdbms/_mgmtdb/-MGMTDB/trace/alert_-MGMTDB.log with original file size : 28MB
2017/10/05 15:51:55 BRT : Trimming file : prdst2dbn01/rdbms/corpdb/CORPDB1/trace/CORPDB1_dbrm_10946.trc with original file size : 3.9MB
2017/10/05 15:51:55 BRT : Trimming file : prdst2dbn01/rdbms/corpdb/CORPDB1/trace/CORPDB1_lmhb_11037.trc with original file size : 91MB
2017/10/05 15:51:55 BRT : Trimming file : prdst2dbn01/rdbms/corpdb/CORPDB1/trace/CORPDB1_mmon_11123.trc with original file size : 785kB
2017/10/05 15:51:55 BRT : Trimming file : prdst2dbn01/rdbms/corpdb/CORPDB1/trace/alert_CORPDB1.log with original file size : 564kB
2017/10/05 15:51:56 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_cjq0_63306.trc with original file size : 49MB
2017/10/05 15:51:56 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_dbrm_58016.trc with original file size : 1.3MB
2017/10/05 15:51:56 BRT : prdst2dbn01: Zipped 300 Files so Far
2017/10/05 15:51:56 BRT : prdst2dbn01: Zipped 400 Files so Far
2017/10/05 15:51:56 BRT : prdst2dbn01: Zipped 500 Files so Far
2017/10/05 15:51:56 BRT : prdst2dbn01: Zipped 600 Files so Far
2017/10/05 15:51:56 BRT : prdst2dbn01: Zipped 700 Files so Far
2017/10/05 15:51:56 BRT : prdst2dbn01: Zipped 800 Files so Far
2017/10/05 15:51:56 BRT : prdst2dbn01: Zipped 900 Files so Far
2017/10/05 15:51:56 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_lmhb_58133.trc with original file size : 27MB
2017/10/05 15:51:57 BRT : prdst2dbn01: Zipped 1000 Files so Far
2017/10/05 15:51:57 BRT : prdst2dbn01: Zipped 1100 Files so Far
2017/10/05 15:51:57 BRT : prdst2dbn01: Zipped 1200 Files so Far
2017/10/05 15:51:57 BRT : prdst2dbn01: Zipped 1300 Files so Far
2017/10/05 15:51:58 BRT : prdst2dbn01: Zipped 1400 Files so Far
2017/10/05 15:51:58 BRT : prdst2dbn01: Zipped 1500 Files so Far
2017/10/05 15:51:58 BRT : prdst2dbn01: Zipped 1600 Files so Far
2017/10/05 15:51:58 BRT : prdst2dbn01: Zipped 1700 Files so Far
2017/10/05 15:51:58 BRT : prdst2dbn01: Zipped 1800 Files so Far
2017/10/05 15:51:59 BRT : prdst2dbn01: Zipped 1900 Files so Far
2017/10/05 15:51:59 BRT : prdst2dbn01: Zipped 2000 Files so Far
2017/10/05 15:51:59 BRT : prdst2dbn01: Zipped 2100 Files so Far
2017/10/05 15:51:59 BRT : prdst2dbn01: Zipped 2200 Files so Far
2017/10/05 15:51:59 BRT : prdst2dbn01: Zipped 2300 Files so Far
2017/10/05 15:51:59 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_mmnl_58310.trc with original file size : 782kB
2017/10/05 15:51:59 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_mmon_58298.trc with original file size : 149MB
2017/10/05 15:52:00 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ora_16393.trc with original file size : 65MB
2017/10/05 15:52:00 BRT : prdst2dbn01: Zipped 2400 Files so Far
2017/10/05 15:52:00 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ora_17463.trc with original file size : 16MB
2017/10/05 15:52:00 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ora_21468.trc with original file size : 8.4MB
2017/10/05 15:52:02 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ora_26938.trc with original file size : 2.3MB
2017/10/05 15:52:02 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ora_2739.trc with original file size : 9.5MB
2017/10/05 15:52:02 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ora_28483.trc with original file size : 1.3MB
2017/10/05 15:52:03 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ora_28548.trc with original file size : 35MB
2017/10/05 15:52:03 BRT : prdst2dbn01: Zipped 2500 Files so Far
2017/10/05 15:52:03 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ora_2953.trc with original file size : 15MB
2017/10/05 15:52:03 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ora_30011.trc with original file size : 9.5MB
2017/10/05 15:52:04 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ora_34236.trc with original file size : 1.1MB
2017/10/05 15:52:05 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ora_34760.trc with original file size : 1.2MB
2017/10/05 15:52:05 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ora_35591.trc with original file size : 6.4MB
2017/10/05 15:52:05 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ora_38864.trc with original file size : 6.8MB
2017/10/05 15:52:05 BRT : prdst2dbn01: Zipped 2600 Files so Far
2017/10/05 15:52:06 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ora_42333.trc with original file size : 1.1MB
2017/10/05 15:52:06 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ora_43168.trc with original file size : 6.8MB
2017/10/05 15:52:07 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ora_49893.trc with original file size : 8.5MB
2017/10/05 15:52:07 BRT : prdst2dbn01: Zipped 2700 Files so Far
2017/10/05 15:52:07 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ora_52862.trc with original file size : 913kB
2017/10/05 15:52:09 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ora_5490.trc with original file size : 1.1MB
2017/10/05 15:52:11 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ora_55216.trc with original file size : 1.2MB
2017/10/05 15:52:13 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ora_55518.trc with original file size : 16MB
2017/10/05 15:52:13 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ora_55752.trc with original file size : 7MB
2017/10/05 15:52:13 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ora_55755.trc with original file size : 6.6MB
2017/10/05 15:52:13 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ora_55757.trc with original file size : 6.4MB
2017/10/05 15:52:14 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ora_60325.trc with original file size : 15MB
2017/10/05 15:52:14 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ora_60481.trc with original file size : 8.1MB
2017/10/05 15:52:14 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ora_62203.trc with original file size : 12MB
2017/10/05 15:52:14 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ora_63679.trc with original file size : 576kB
2017/10/05 15:52:14 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ora_63881.trc with original file size : 13MB
2017/10/05 15:52:14 BRT : prdst2dbn01: Zipped 2800 Files so Far
2017/10/05 15:52:15 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ppa6_50153.trc with original file size : 10MB
2017/10/05 15:52:16 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_ppa7_60009.trc with original file size : 552MB
2017/10/05 15:52:17 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_q001_65231.trc with original file size : 760kB
2017/10/05 15:52:17 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_qm03_65427.trc with original file size : 43MB
2017/10/05 15:52:17 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_smon_58224.trc with original file size : 2.3MB
2017/10/05 15:52:17 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_w000_21552.trc with original file size : 555kB
2017/10/05 15:52:17 BRT : Trimming file : prdst2dbn01/rdbms/dwdb/dwdb1/trace/dwdb1_w007_43320.trc with original file size : 535kB
2017/10/05 15:52:18 BRT : Trimming file : prdst2dbn01/rdbms/indb/indb1/trace/alert_indb1.log with original file size : 426MB
2017/10/05 15:52:25 BRT : Trimming file : prdst2dbn01/rdbms/indb/indb1/trace/alert_indb1.log_old with original file size : 88MB
2017/10/05 15:52:25 BRT : Trimming file : prdst2dbn01/rdbms/indb/indb1/trace/alert_indb1.log_old20170609 with original file size : 88MB
2017/10/05 15:52:25 BRT : Trimming file : prdst2dbn01/rdbms/indb/indb1/trace/indb1_dbrm_58587.trc with original file size : 1.5MB
2017/10/05 15:52:25 BRT : Trimming file : prdst2dbn01/rdbms/indb/indb1/trace/indb1_lmd0_58634.trc with original file size : 611kB
2017/10/05 15:52:25 BRT : Trimming file : prdst2dbn01/rdbms/indb/indb1/trace/indb1_lmhb_58677.trc with original file size : 32MB
2017/10/05 15:53:08 BRT : Trimming file : prdst2dbn01/rdbms/indb/indb1/trace/indb1_lms0_58646.trc with original file size : 46MB
2017/10/05 15:53:08 BRT : prdst2dbn01: Zipped 2900 Files so Far
2017/10/05 15:53:08 BRT : Trimming file : prdst2dbn01/rdbms/trdb/trdb1/trace/alert_trdb1.log with original file size : 149MB
2017/10/05 15:53:08 BRT : Trimming file : prdst2dbn01/rdbms/trdb/trdb1/trace/trdb1_dbrm_58176.trc with original file size : 1.5MB
2017/10/05 15:53:09 BRT : Trimming file : prdst2dbn01/rdbms/trdb/trdb1/trace/trdb1_lmhb_58293.trc with original file size : 43MB
2017/10/05 15:53:09 BRT : prdst2dbn01: Zipped 3000 Files so Far
2017/10/05 15:53:09 BRT : Trimming file : prdst2dbn01/tnslsnr/prdst2dbn01/listener/trace/listener.log with original file size : 96MB
2017/10/05 15:53:09 BRT : Trimming file : prdst2dbn01/asm/+asm/+ASM1/trace/+ASM1_lmhb_48934.trc with original file size : 1.7GB
2017/10/05 15:53:09 BRT : Trimming file : prdst2dbn01/asm/+asm/+ASM1/trace/+ASM1_lms0_48925.trc with original file size : 7MB
2017/10/05 15:53:09 BRT : prdst2dbn01: Zipped 3100 Files so Far
2017/10/05 15:53:09 BRT : prdst2dbn01: Zipped 3200 Files so Far
2017/10/05 15:53:09 BRT : Trimming file : prdst2dbn01/asm/+asm/+ASM1/trace/alert_+ASM1.log with original file size : 5.1MB
2017/10/05 15:53:09 BRT : prdst2dbn01: Zipped 3300 Files so Far
2017/10/05 15:53:11 BRT : Trimming file : prdst2dbn01/tnslsnr/prdst2dbn01/listener_scan2/trace/listener_scan2.log with original file size : 393MB
2017/10/05 15:53:12 BRT : Trimming file : prdst2dbn01/tnslsnr/prdst2dbn01/listener_scan3/trace/listener_scan3.log with original file size : 385MB
2017/10/05 15:53:30 BRT : Collecting ADR incident files...
2017/10/05 15:53:48 BRT : Completed Zipping of all files
2017/10/05 15:53:48 BRT : Cleaning up temporary files
2017/10/05 15:53:49 BRT : Finished Cleaning up temporary files
2017/10/05 15:53:49 BRT : Finalizing the Collection Zip File
2017/10/05 15:53:49 BRT : Finished Finalizing the Collection Zip File
2017/10/05 15:53:49 BRT : Total Number of Files checked : 80489
2017/10/05 15:53:49 BRT : Total Size of all Files Checked : 18GB
2017/10/05 15:53:49 BRT : Number of files containing required range : 3329
2017/10/05 15:53:49 BRT : Total Size of Files containing required range : 5.4GB
2017/10/05 15:53:49 BRT : Number of files trimmed : 73
2017/10/05 15:53:49 BRT : Total Size of data prior to zip : 2.3GB
2017/10/05 15:53:49 BRT : Saved 4.4GB by trimming files
2017/10/05 15:53:49 BRT : Zip file size : 198MB
2017/10/05 15:53:49 BRT : Total time taken : 730s
2017/10/05 15:53:49 BRT : Remote Collection in Progress...
tfactl> diagcollect -all -last 10h

