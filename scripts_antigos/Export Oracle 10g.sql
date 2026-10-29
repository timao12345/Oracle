-- Export Oracle 10g caso o disco não tenha espaço --

#!/bin/bash
cd /ARCHIVE2/bkp
# create a named pipe
mknod exp_disc_schema_SIACNFE.pipe p
# read the pipe - output to zip file in the background
gzip < exp_disc_schema_SIACNFE.pipe > SIACNFE.dmp.gz &
# feed the pipe
exp export/export file=exp_disc_schema_SIACNFE.pipe log=SIACNFE.dmp.log owner=SIACNFE
