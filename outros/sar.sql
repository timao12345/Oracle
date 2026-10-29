nohup sar -r  10 8640 > /u01/stage/sar/sar_memoria.txt &
nohup sar -P ALL 10 8640 > /u01/stage/sar/sar_cpu.txt &
nohup sar -q 10 8640 > /u01/stage/sar/sar_cpu_fila.txt &


