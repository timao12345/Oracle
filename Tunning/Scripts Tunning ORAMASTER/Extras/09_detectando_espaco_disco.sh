#!/bin/bash
mntlist="/ora00 ora01 ora02"
for ml in $mntlist
do 
  echo $ml
  usedSpc=$(df -h $ml | awk '{print $5}' | grep -v capacity | cut -d "%" -f1 -)
  BOX=$(uname -a | awk '{print $2}')
  #
  case $usedSpc in
	[0-9])
	arcStat="relax, lots of disk space: $usedSpc"
	;;
	[1-7][0-9])
	arcStat="disk space OK: $usedSpc"
	;;
	[8][0-9])
	arcStat="space getting low: $usedSpc"
	;;
	[9][0-9])
	arcStat="warning, running out of space: $usedSpc"
	;;
	[1][0][0])
	arcStat="no space left: $usedSpc"
	echo $arcStat $ml | mailx -s "space on: $BOX" scbd@tre-sp.jus.br
	;;
	*)
	arcStat="huh?: $usedSpc"
  esac
  #
  BOX=$(uname -a | awk '{print $2}')
  echo arcStat#
  done
  #
  exit 0
  
 
#----------------------------------------------------------------- 
 7 * * * * /ora_disk.sh 1>/ora_disk.log 2>&1
#-----------------------------------------------------------------