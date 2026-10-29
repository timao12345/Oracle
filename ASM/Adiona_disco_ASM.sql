Esta query mostra os discos candidatos a serem adicionados.

  SELECT
    NVL(a.name, '[CANDIDATE]')      disk_group_name
  , b.path                          disk_file_path
  , b.name                          disk_file_name
  , b.failgroup                     disk_file_fail_group
FROM
    v$asm_diskgroup a RIGHT OUTER JOIN v$asm_disk b USING (group_number)
ORDER BY
    a.name;




DISK_GROUP_NAME                DISK_FILE_PATH                                                                                                                                                                                                                                                   DISK_FILE_NAME                 DISK_FILE_FAIL_GROUP
------------------------------ ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ------------------------------ ------------------------------
ARCH                           /dev/rhdisk21                                                                                                                                                                                                                                                    ARCH_0002                      ARCH_0002
ARCH                           /dev/rhdisk20                                                                                                                                                                                                                                                    ARCH_0001                      ARCH_0001
ARCH                           /dev/rhdisk19                                                                                                                                                                                                                                                    ARCH_0000                      ARCH_0000
ARCH                           /dev/rhdisk22                                                                                                                                                                                                                                                    ARCH_0003                      ARCH_0003
DATA                           /dev/rhdisk14                                                                                                                                                                                                                                                    DATA_0005                      DATA_0005
DATA                           /dev/rhdisk15                                                                                                                                                                                                                                                    DATA_0006                      DATA_0006
DATA                           /dev/rhdisk16                                                                                                                                                                                                                                                    DATA_0007                      DATA_0007
DATA                           /dev/rhdisk17                                                                                                                                                                                                                                                    DATA_0008                      DATA_0008
DATA                           /dev/rhdisk18                                                                                                                                                                                                                                                    DATA_0009                      DATA_0009
DATA                           /dev/rhdisk13                                                                                                                                                                                                                                                    DATA_0004                      DATA_0004
DATA                           /dev/rhdisk12                                                                                                                                                                                                                                                    DATA_0003                      DATA_0003

DISK_GROUP_NAME                DISK_FILE_PATH                                                                                                                                                                                                                                                   DISK_FILE_NAME                 DISK_FILE_FAIL_GROUP
------------------------------ ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ------------------------------ ------------------------------
DATA                           /dev/rhdisk11                                                                                                                                                                                                                                                    DATA_0002                      DATA_0002
DATA                           /dev/rhdisk9                                                                                                                                                                                                                                                     DATA_0014                      DATA_0014
DATA                           /dev/rhdisk10                                                                                                                                                                                                                                                    DATA_0001                      DATA_0001
DATA                           /dev/rhdisk8                                                                                                                                                                                                                                                     DATA_0013                      DATA_0013
DATA                           /dev/rhdisk23                                                                                                                                                                                                                                                    DATA_0010                      DATA_0010
DATA                           /dev/rhdisk24                                                                                                                                                                                                                                                    DATA_0011                      DATA_0011
DATA                           /dev/rhdisk5                                                                                                                                                                                                                                                     DATA_0000                      DATA_0000
DATA                           /dev/rhdisk6                                                                                                                                                                                                                                                     DATA_0012                      DATA_0012
RECO                           /dev/rhdisk7                                                                                                                                                                                                                                                     RECO_0000                      RECO_0000
[CANDIDATE]                    /dev/rhdisk25   <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


Adiciona o disco	
ALTER DISKGROUP DATA ADD DISK '/dev/rhdisk25' REBALANCE POWER 11;
	