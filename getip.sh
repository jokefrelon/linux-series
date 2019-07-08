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
#    cat ipadder.txt
#    date >> ipadder.txt
    git add ipadder.txt getip.sh README.md
    git commit -m "Robot auto update"
    git push getip master
    echo -e "\033[31m---------------------------------------\033[0m"
    echo -e "\033[31m| This program will sleep six minutes |\033[0m"
    echo -e "\033[31m---------------------------------------\033[0m"
    sleep 6m
    cd /mnt/github/shell/
    ./getip.sh
done
