#!/bin/sh
# a=10
# b=10
# if [$a==$b]
# 	then
# 		ifconfig > /mnt/github/shell/ipadder.txt
# 		cat ipadder.txt
# 	else
# 		echo "Please checkout the shell"
# 	fi
while  true
do
    cd /mnt/github/shell/
    ifconfig | grep 172.17  > ipadder.txt
    cat ipadder.txt
    git add ipadder.txt getip.sh 
    git commit -m "Robot auto update"
    git push getip master
    sleep 3m
    cd /mnt/github/shell/
    ./getip.sh
done
