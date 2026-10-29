-- Adiciona datafile automaticamente no DG --

alter tablespace USER-TABLESPACE add datafile '+DATAGROUP' size 10G;

alter tablespace TEMP add tempfile '+DATA' size 8000M autoextend on next 1G maxsize 32767M;