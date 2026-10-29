-- executar comando abaixo no terminal e ver resultados: qtde bytes entrada e saída + mbytes gravados por segundo
time dd if=/oradata/orcl/system01.dbf of=test.out 

-- executar bloco pl/sql abaixo para ver stats de IO por meio do calibrate io (a partir do 11g):
SET SERVEROUTPUT ON
DECLARE
   latc INTEGER;
   iops INTEGER;
   mbps INTEGER;
BEGIN
   DBMS_RESOURCE_MANAGER.CALIBRATE_IO (NUM_PHYSICAL_DISKS => 1, MAX_LATENCY => 10, MAX_IOPS => iops, MAX_MBPS => mbps, ACTUAL_LATENCY=> latc);
   DBMS_OUTPUT.PUT_LINE ('max_iops = ' || iops);
   DBMS_OUTPUT.PUT_LINE ('latency = ' || latc);
   dbms_output.put_line('max_mbps = ' || mbps);
END;
/
