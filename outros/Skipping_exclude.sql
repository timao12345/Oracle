HealthCheck ( Doc ID 1070954.1)


Criar o arquivo abaixo na pasta de exachk
vi excluded_check_ids.txt

Incluir o checkid no arquivo aciman 00267882D4030B08E05312C0E50A2E57





skipping Exadata database server rolling switch patching minimum GI software requirement(checkid:-00267882D4030B08E05312C0E50A2E57) because audit check execution was killed.
PASS =>  Exadata Database Server GI software version meets requirement for rolling switch patching

skipping Verify there are no griddisks configured on flash memory devices (checkid:-ADF21ECC6B52B547E040E50A1EC06588) on exapdceladm01 because c_cbc_cell_grid_disk_on_flash_192_168_10_3.out not found
skipping Verify there are no griddisks configured on flash memory devices (checkid:-ADF21ECC6B52B547E040E50A1EC06588) on exapdceladm02 because c_cbc_cell_grid_disk_on_flash_192_168_10_4.out not found
PASS =>  There are no griddisks configured on flash memory devices
AUDIT CHECK NAME = Verify there are no griddisks configured on flash memory devices

skipping Verify Software on Storage Servers (CheckSWProfile.sh) (checkid:-9F163DD00B11E98EE040E50A1EC012D0) on exapdceladm01 because c_cbc_CheckSWProfile_192_168_10_3.out not found
PASS =>  Software profile check is successful on all storage servers.
AUDIT CHECK NAME = Verify Software on Storage Servers (CheckSWProfile.sh)

skipping Verify InfiniBand Cable Connection Quality on storage servers (checkid:-AA92D5836CAEACE5E040E50A1EC06A0F) on exapdceladm01 because c_cbc_ib_network_cable_connections_192_168_10_3.out not found
PASS =>  All InfiniBand network cables are connected on all Storage Servers
AUDIT CHECK NAME = Verify InfiniBand Cable Connection Quality on storage servers


skipping Verify storage server metric CD_IO_ST_RQ (checkid:-AAD0870AA3E4436EE040E50A1EC03479) on exapdceladm01 because c_cbc_cell_metric_cd_io_st_rq_192_168_10_3.out not found
PASS =>  No Storage Server conventional or flash disks have a performance problem
AUDIT CHECK NAME = Verify storage server metric CD_IO_ST_RQ

skipping Verify average ping times to DNS nameserver [Storage Server] (checkid:-B8197381F9783BD7E0431EC0E50AD83A) on exapdceladm01 because c_cbc_dns_ping_time_192_168_10_3.out not found
PASS =>  Average ping times to DNS nameserver should not be negatively impacting SSH operations.
AUDIT CHECK NAME = Verify average ping times to DNS nameserver [Storage Server]

skipping Verify the percent of available celldisk space used by the griddisks (checkid:-B868BEE57CBB0727E0431EC0E50A6569) on exapdceladm01 because c_cbc_celldisk_griddisks_usage_192_168_10_3.out not found
PASS =>  The percent of available celldisk space used by the griddisks is as expected
AUDIT CHECK NAME = Verify the percent of available celldisk space used by the griddisks

skipping Verify celldisk configuration on disk drives (checkid:-B868E7E7D4851B61E0431EC0E50AE948) on exapdceladm01 because c_cbc_cell_disk_on_disk_192_168_10_3.out not found
PASS =>  The celldisk configuration on disk drives matches Oracle best practices
AUDIT CHECK NAME = Verify celldisk configuration on disk drives

skipping Verify griddisk ASM status (checkid:-B87BBEA5559A432FE0431EC0E50A8B49) on exapdceladm01 because c_cbc_asm_grid_disk_status_192_168_10_3.out not found
PASS =>  The griddisk ASM status matches specification
AUDIT CHECK NAME = Verify griddisk ASM status

skipping Verify total number of griddisks with a given prefix name is evenly divisible of celldisks (checkid:-B87C180644F65C1CE0431EC0E50AD99B) on exapdceladm01 because c_cbc_even_grid_disks_192_168_10_3.out not found
skipping Verify total number of griddisks with a given prefix name is evenly divisible of celldisks (checkid:-B87C180644F65C1CE0431EC0E50AD99B) on exapdceladm02 because c_cbc_even_grid_disks_192_168_10_4.out not found
PASS =>  The total number of griddisks with a given prefix name is evenly divisible by the number of celldisks
AUDIT CHECK NAME = Verify total number of griddisks with a given prefix name is evenly divisible of celldisks

skipping Verify griddisk count matches across all storage servers where a given prefix name exists (checkid:-B87C953BAEB62A14E0431EC0E50AD695) on exapdceladm01 because c_cbc_griddisk_devide_celldisk_192_168_10_3.out not found
PASS =>  The griddisk count matches across all storage servers where a given prefix name exists
AUDIT CHECK NAME = Verify griddisk count matches across all storage servers where a given prefix name exists

skipping Verify celldisk configuration on flash memory devices (checkid:-B87DE57786D55B9CE0431EC0E50A5DC6) on exapdceladm01 because c_cbc_cell_disk_on_flash_192_168_10_3.out not found
PASS =>  The celldisk configuration on flash memory devices matches Oracle best practices
AUDIT CHECK NAME = Verify celldisk configuration on flash memory devices


