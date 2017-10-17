#!/bin/bash
#
#Auth: Pengdongwen
#Blog: www.ywnds.com
#Email: 593265947@qq.com
#Desc: memcached status monitoring 
#dependent:
#  1)yum install nc
#  2)python memcached_discovery.py
#########################

IP=127.0.0.1 
PORT="$1"
METRIC="$2"
 
if [ $# -lt 2 ];then
    echo "please set argument"
    exit 1
fi

STATUS=`echo "stats" | nc $IP $PORT | grep -w "$METRIC" | awk '{print $3}'`
case $METRIC in
    'version')
        echo $STATUS
        ;;
    'uptime')
        echo $STATUS 
        ;;
    'curr_connections')
        echo $STATUS
        ;;
    'total_connections')
        echo $STATUS
        ;;
    'cmd_get')
        echo $STATUS
        ;;
    'cmd_set')
        echo $STATUS
        ;;
    'get_hits')
        echo $STATUS
        ;;
    'get_misses')
        echo $STATUS
        ;;
    'bytes_read')
        echo $STATUS
        ;;
    'bytes_written')
        echo $STATUS
        ;;
    'curr_items')
        echo $STATUS
        ;;
    'total_items')
        echo $STATUS
        ;;
    'expired_unfetched')
        echo $STATUS
        ;;
    'evicted_unfetched')
        echo $STATUS
        ;;
    *)
        echo "Not selected metric"
        exit 0
        ;;
esac
