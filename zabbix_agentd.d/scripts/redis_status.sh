#!/bin/bash
#
#Auth: Pengdongwen
#Blog: www.ywnds.com
#Email: 593265947@qq.com
#Desc: redis 3.2+ status monitoring 
#dependent:
#  1)python redis_discovery.py
#  2)yum install redis-cli dos2unix
#########################

CMD="/usr/local/bin/redis-cli"
REDIS_IP=127.0.0.1 
PORT="$1"
METRIC="$2"
PASSWD="12345"
 
if [ $# -lt 2 ];then
    echo "please set argument"
    exit 1
fi

if [ ! -n "$PASSWD" ];then
    STATUS=`$CMD -h $REDIS_IP -p $PORT info | grep -w "$METRIC" | awk -F':' '{print $2}'`
    BACK="$CMD -h $REDIS_IP -p $PORT info"
else
    STATUS=`$CMD -a $PASSWD -h $REDIS_IP -p $PORT info | grep -w "$METRIC" | awk -F':' '{print $2}'`
    BACK="$CMD -a $PASSWD -h $REDIS_IP -p $PORT info"
fi

case $METRIC in
    # master or slave
    'redis_version')
        echo $STATUS | sed s/[[:punct:]]//g | sed s/[[:alpha:]]//g 
        ;;
    'redis_mode')
        echo $STATUS
        ;;
    'uptime_in_days')
        echo $STATUS
        ;;
    'lru_clock')
        echo $STATUS
        ;;
    'connected_clients')
        echo $STATUS
        ;;
    'maxclients')
        if [ -n "$PASSWD" ];then
            STATUS=`$CMD -h $REDIS_IP -p $PORT -a $PASSWD CONFIG GET maxclients | tail -n1`
        else
            STATUS=`$CMD -h $REDIS_IP -p $PORT CONFIG GET maxclients | tail -n1`
        fi
        echo $STATUS
        ;;
    'blocked_clients')
        echo $STATUS
        ;;
    'used_memory')
        echo $STATUS
        ;;
    'used_memory_rss')
        echo $STATUS
        ;;
    'used_memory_peak')
        echo $STATUS
        ;;
    'total_system_memory')
        echo $STATUS
        ;;
    'maxmemory')
        echo $STATUS
        ;;
    'aof_enabled')
        echo $STATUS
        ;;
    'instantaneous_ops_per_sec')
        echo $STATUS
        ;;
    'instantaneous_input_kbps')
        echo $STATUS
        ;;
    'instantaneous_output_kbps')
        echo $STATUS
        ;;
    'rdb_last_save_time')
        echo $STATUS
        ;;
    'rdb_last_bgsave_time_sec')
        echo $STATUS
        ;;
    'aof_last_rewrite_time_sec')
        echo $STATUS
        ;;
    'expired_keys')
        echo $STATUS
        ;;
    'evicted_keys')
        echo $STATUS
        ;;
    'keyspace_hits')
        echo $STATUS
        ;;
    'keyspace_misses')
        echo $STATUS
        ;;
    'keys')
        if [ -n "$PASSWD" ];then
            STATUS=`$CMD -a $PASSWD -h $REDIS_IP -p $PORT dbsize | sed s/[[:punct:]]//g | sed s/[[:alpha:]]//g`
        else
            STATUS=`$CMD -h $REDIS_IP -p $PORT dbsize | sed s/[[:punct:]]//g | sed s/[[:alpha:]]//g`
        fi
        echo $STATUS
        ;;
    'role')
        STATUS=`echo $STATUS | dos2unix`
        if [ $STATUS == "master" ];then
          echo 1  # master
        elif [ $STATUS == "slave" ];then
          echo 2  # slave
        else
          echo 0  # other
        fi
        ;;
    'connected_slaves')
        echo $STATUS
        ;;
    'cluster_enabled')
        if [ -n "$STATUS" ];then
          echo $STATUS
        else
          echo 0
        fi
        ;;
    'use_memory_percent')
        used_memory=`$BACK | grep -w "used_memory" | awk -F':' '{print $2}' | dos2unix`
        maxmemory=`$BACK | grep -w "maxmemory" | awk -F':' '{print $2}' | dos2unix`
        #maxmemory=`$CMD -h $REDIS_IP -p $PORT CONFIG GET maxmemory | tail -n1 | dos2unix`
        if [ -n "$maxmemory" ];then
            python -c "print float(`echo $used_memory`)/float(`echo $maxmemory`)" | cut -c 1,2,3,4
        else
            echo 0
        fi
        ;;
    # slave
    'master_host')
        if [ -n "$STATUS" ];then
          echo $STATUS
        else
          echo 0
        fi
        ;;
    'master_port')
        if [ -n "$STATUS" ];then
          echo $STATUS
        else
          echo 0
        fi
        ;;
    'slave_read_only')
        if [ -n "$STATUS" ];then
          echo $STATUS
        else
          echo 0
        fi
        ;;
    'master_link_status')
        if [ -n "$STATUS" ];then
          if [ $STATUS == "up" ];then
            echo 1
          else
            echo 0  
          fi
        else
          echo 0
        fi
        ;;
    *)
        echo "Not selected metric"
        exit 0
        ;;
esac
