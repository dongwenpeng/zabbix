#!/bin/bash
#
MemTotal=`grep MemTotal /proc/meminfo | awk '{print $2}'`
Buffers=`grep Buffers /proc/meminfo | awk '{print $2}'`
Cached=`grep -w Cached /proc/meminfo | awk '{print $2}'`
Used=`free -k | grep -b1 used | awk '{print $3}' | tail -n1`
MemUse=`echo $[$Used-$Buffers-$Cached]`
python -c "print float(`echo $MemUse`)/float(`echo $MemTotal`)" | cut -c 1,2,3,4

