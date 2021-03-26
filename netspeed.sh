#!/bin/bash
ether=`ifconfig | grep -Ev "^[[:space:]]" | awk -F: '{print $1}' | grep -Ev "^$"`
logic=`ls /sys/devices/virtual/net/`
phica="x"
num=$(expr `echo $ether | awk '{print NF}'` - 1)

for er in $ether
do
    ie=0
    for rq in $logic
    do
        if [ $er != $rq ]
        then
                ie=`expr $ie + 1`
      fi
    done
    if [ $ie = $num ]
    then
        phica=$er
    fi
done
upsp=`cat /proc/net/dev | grep $phica | awk '{print $10}'`
dosp=`cat /proc/net/dev | grep $phica | awk '{print $2}'`

sleep 1

upsp1=`cat /proc/net/dev | grep $phica | awk '{print $10}'`
dosp1=`cat /proc/net/dev | grep $phica | awk '{print $2}'`

nupsp=$(printf "%.2f" `echo "scale=2;($upsp1 - $upsp)/1024/1024" | bc`)
ndosp=$(printf "%.2f" `echo "scale=2;($dosp1 - $dosp)/1024/1024" | bc`)
echo -e "Upload   speed :\033[49;33m $nupsp Mb/s \033[0m"
echo -e "Download speed :\033[49;33m $ndosp Mb/s \033[0m"