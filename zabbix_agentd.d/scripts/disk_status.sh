#/bin/sh
device=$1
item=$2
case $item in
         rrqm)
            iostat -dxkt |grep "\b$device\b"|tail -1|awk '{print $2}'
            ;;
         wrqm)
            iostat -dxkt |grep "\b$device\b"|tail -1|awk '{print $3}'
            ;;
          rps)
            iostat -dxkt |grep "\b$device\b"|tail -1|awk '{print $4}'
            ;;
          wps)
            iostat -dxkt |grep "\b$device\b" |tail -1|awk '{print $5}'
            ;;
        rKBps)
            iostat -dxkt |grep "\b$device\b" |tail -1|awk '{print $6}'
            ;;
        wKBps)
            iostat -dxkt |grep "\b$device\b" |tail -1|awk '{print $7}'
            ;;
        avgrq-sz)
            iostat -dxkt |grep "\b$device\b" |tail -1|awk '{print $8}'
            ;;
        avgqu-sz)
            iostat -dxkt |grep "\b$device\b" |tail -1|awk '{print $9}'
            ;;
        await)
            iostat -dxkt |grep "\b$device\b" |tail -1|awk '{print $10}'
            ;;
        r_await)
            iostat -dxkt |grep "\b$device\b" |tail -1|awk '{print $11}'
            ;;
        w_await)
            iostat -dxkt |grep "\b$device\b" |tail -1|awk '{print $12}'
            ;;
        svctm)
            iostat -dxkt |grep "\b$device\b" |tail -1|awk '{print $13}'
            ;;
         util)
            iostat -dxkt |grep "\b$device\b" |tail -1|awk '{print $14}'
            ;;
esac
