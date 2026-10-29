alpha-> vmstat
procs memory swap io system cpu
r b swpd free buff cache si so bi bo in cs us sy wa id
0 0 200560 88796 88612 179036 0 1 1 20 112 20 3 1 1 96
The relevant fields in the output are as follows
Field
Description

R
The amount of threads in the run queue. These are threads that are runnable, but the
CPU is not available to execute them.
B
This is the number of processes blocked and waiting on IO requests to finish.
In
This is the number of interrupts being processed.
Cs
This is the number of context switches
currently happening on the system.
Us
This is the percentage of user CPU utilization.
Sys
This is the percentage of kernel and interrupts utilization.
Wa
This is the percentage of id
le processor time due to the fact that ALL runnable threads
are blocked waiting on IO.
Id
This is the percentage of time that the CPU is completely idle. 