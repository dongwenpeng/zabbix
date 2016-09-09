#!/bin/bash
#
MemTotal=`grep MemTotal /proc/meminfo | awk '{print $2}'`
Buffers=`grep Buffers /proc/meminfo | awk '{print $2}'`
Cached=`grep -w Cached /proc/meminfo | awk '{print $2}'`
MemUse=`echo $[$MemTotal-$Buffers-$Cached]`
python -c "print float(`echo $MemUse`)/float(`echo $MemTotal`)"
