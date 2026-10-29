[root@exacc01db02vmc01 NetBackup_10.4.0.1_CLIENTS2]# ./install


Veritas Installation Script
Copyright (c) 2024 Veritas Technologies LLC. All rights reserved.


        Installing NetBackup Client Software


Please review the VERITAS SOFTWARE LICENSE AGREEMENT located on
the installation media before proceeding. The agreement includes
details on the NetBackup Product Improvement Program.

For NetBackup installation and upgrade information specific to your
platform and to find out if your installed EEBs or hot fixes are
contained in this release, check the Installation and Upgrade checklists
and the Hot Fix and EEB Release Auditor, both available on the Veritas
Services and Operations Readiness Tools (SORT) page:
https://sort.veritas.com/netbackup.

Do you wish to continue? [y,n] (y) y

File /tmp/NBInstallAnswer.conf does not exist. NB_FIPS_MODE is set to DISABLE.
The private_tmp value is /tmp/par_tmp.275022

Checking for critical system conditions...

ok certmapinfo_check: Inapplicable for new NetBackup installation.: skipping
ok ea_check: Inapplicable for new NetBackup installation: skipping
ok service_user_critical: Inapplicable on non-primary server when service user was not provided: skipping
ok be_nb_same_host: Inapplicable on Linux: skipping
ok unsupported_platform: Host is a supported platform: Linux 5.4.17-2136.322.6.5.el8uek.x86_64.
ok primary_server_name: Inapplicable for non-primary install: skipping
ok localhost_check_critical: Inapplicable for new NetBackup installation: skipping

Checking for non-critical system conditions...

ok minimum_memory_check: System meets minimum memory requirement.
ok nbac_eol_check: Inapplicable for new NetBackup installation: skipping
not ok ephemeral_port_range: The ephemeral port range include ports used by NetBackup services.
  The NetBackup Primary Servers may not start up correctly if the system
  is configured with an ephemeral port range that conflicts with
  the ports that are used by NetBackup services. This test checks whether the
  current ephemeral port range includes the ports used by NetBackup services.
  See https://www.veritas.com/support/en_US/article.100040677.htm for
  details.
ok acl_support_check: Filesystem that is mounted on /var supports ACL.
ok service_user_noncritical: Inapplicable on non-primary server when service user was not provided: skipping
not ok localhost_check_noncritical: loopback address [::1] does not exist in hosts file [/etc/hosts].
  This test checks for the existence of loopback addresses in the hosts file.
  Having the loopback addresses [127.0.0.1, ::1] in the hosts file ensures that they will
  resolve when DNS servers cannot resolve the hostname localhost.

  Refer to the following article for more details:
      https://www.veritas.com/support/en_US/article.100045507
ok hotfix_auditor: NetBackup is not installed or there is no hotfix or EEB data present. Skipping HF/EEB Auditor check.
ok webserver_tunnel_config: Inapplicable for new NetBackup installation: skipping
ok missing_binaries_noncritical: binaries [libncurses.so.5] or higher exist on the system.
ok port_availability_check: Ports (1556) are available for NetBackup services.

WARNING: One or more non-critical preinstall checks have failed.

Do you want to install the NetBackup client software for this client? [y,n] (y) y

This package will install Linux/RedHat3.10.0 client.

This package will install NetBackup client 10.4.0.1.

Enter the name of the NetBackup primary server : cvpnbuprimary01.adcorp.intranet


Would you like to use "exacc01db02vmc01" as the configured
name of the NetBackup client? [y,n] (y) n

Enter the name of this NetBackup client : exacc01db02vmc01.rootbrasil.intranet


Successfully unpacked /u02/netbackup/NetBackup_10.4.0.1_CLIENTS2/NBClients/anb/Clients/usr/openv/netbackup/client/Linux/RedHat3.10.0/certcmdTool_for_UNIX.tar.gz at /tmp/nbcertcmdtool.275022.

Checking connectivity to the primary server.
NOTE: Depending on the network, this action may take a few minutes.
      To continue without setting up secure communication, press Ctrl+C.
Connectivity established.

Getting CA certificate mode from primary server.
NOTE: Depending on the network, this action may take a few minutes.
      To continue without setting up secure communication, press Ctrl+C.

Primary server cvpnbuprimary01.adcorp.intranet is configured to use NBCA.

The primary server is configured to use only NetBackup CA for secure communication.

Checking for local NetBackup CA certificate
A CA certificate was found, so CA certificate deployment was skipped.
Checking for local NetBackup host certificate
Getting host certificate for hostname exacc01db02vmc01.rootbrasil.intranet.
NOTE: Depending on the network, this action may take a few minutes.
      To continue without setting up secure communication, press Ctrl+C.
nbcertcmdtool: The -getCertificate operation failed for server cvpnbuprimary01.adcorp.intranet.
EXIT STATUS 8504: The web service certificate is issued by an unknown Certificate Authority.

ERROR:   The attempt to get the host certificate failed.

Do you wish to proceed with installation even though NetBackup will not operate? [y,n] (n) y

WARNING: Proceeding with the installation.  Manual steps are required before backups
         and restores can occur.  For more information:
         https://www.veritas.com/support/en_US/article.000127129

The Java GUI and JRE packages are currently not installed on this host.
The Java GUI and JRE can be optionally included with NetBackup.
The Java GUI and JRE enable the Backup, Archive, and Restore (BAR) GUI.

Choose an option from the list below.
    1) Include the Java GUI and JRE.
    2) Exclude the Java GUI and JRE.


Java GUI and JRE option: [1,2] (2) :1
Including the installation of Java GUI and JRE packages.

Geting pddeu option from answerfile.
[/tmp/NBInstallAnswer.conf] does not exist, using default option [MATCH] for INCLUDE_VRTSPDDEU_CLIENT.

Client binaries are located in /u02/netbackup/NetBackup_10.4.0.1_CLIENTS2/NBClients/anb/Clients/usr/openv/netbackup/client/Linux/RedHat3.10.0.

Running pdinstall -precheck.
Starting NetBackup Deduplication installer
checking dir: /tmp/pdde_pkg_dir_330558
NetBackup Deduplication preinstall check passed
Installing VRTSnbpck ...
Installation of VRTSnbpck was successful. Check /tmp/install_VRTSnbpck.rpm_trace.330521 for details.
Installing VRTSpbx ...
Installation of VRTSpbx was successful. Check /tmp/install_VRTSpbx.rpm_trace.330521 for details.
Installing VRTSnbclt ...
Installation of VRTSnbclt was successful. Check /tmp/install_VRTSnbclt.rpm_trace.330521 for details.
Installing VRTSnbclibs ...
Installation of VRTSnbclibs was successful. Check /tmp/install_VRTSnbclibs.rpm_trace.330521 for details.

Terminating NetBackup and/or Media Manager processes.

Installing NB-Java.
Installing VRTSnbjre ...

Installation of VRTSnbjre was successful.
        More details regarding VRTSnbjre can be found in file
        /tmp/install_VRTSnbjre.rpm_trace.335808 on exacc01db02vmc01.
Installing VRTSnbjava ...

Installation of VRTSnbjava was successful.
        More details regarding VRTSnbjava can be found in file
        /tmp/install_VRTSnbjava.rpm_trace.335808 on exacc01db02vmc01.

Migrating log files in /usr/openv/logs
Migration of log files complete.

No [x]inetd process found.
Installing VRTSpddea.rpm ...
Installation of VRTSpddea.rpm was successful. Check /tmp/install_VRTSpddea.rpm_trace.330521 for details.
Installing VRTSnbcfg.rpm ...
Installation of VRTSnbcfg.rpm was successful. Check /tmp/install_VRTSnbcfg.rpm_trace.330521 for details.


File /usr/openv/tmp/install_trace.274344 contains a trace of this install.
That file can be deleted after you are sure the install was successful.
You have new mail in /var/spool/mail/root
[root@exacc01db02vmc01 NetBackup_10.4.0.1_CLIENTS2]#


[root@exacc01db02vmc01 bin]# ./nbcertcmd -getCACertificate
Authenticity of root certificate cannot be established.
The SHA-1 fingerprint of root certificate is A3:7F:FE:CA:EC:B2:F2:C5:73:8D:60:8F:C4:3C:AF:5F:17:82:5B:E8.
The SHA-256 fingerprint of root certificate is 5F:E0:D0:63:D1:1D:0F:85:6E:80:52:D8:66:91:4C:7A:83:B2:BC:76:71:2E:71:F0:12:72:6B:7E:07:CB:39:0E.
Are you sure you want to continue using this certificate ? (y/n): y
The validation of root certificate fingerprint is successful.
NetBackup CA certificate is successfully stored from the primary server cvpnbuprimary01.adcorp.intranet.
[root@exacc01db02vmc01 bin]# ./nbcertcmd -getCertificate
Host certificate and certificate revocation list received successfully from server cvpnbuprimary01.adcorp.intranet.
[root@exacc01db02vmc01 bin]#