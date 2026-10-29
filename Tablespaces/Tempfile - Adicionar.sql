
-- Adiciona datafile da TableSpace TEMP --

alter tablespace temp add tempfile '+DATA' size 24G reuse autoextend on maxsize unlimited;