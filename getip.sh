#!/bin/sh
ab=10
bc=10
if [$ab==$bc]
then
	echo " hello "
	cd /mnt/github/shell/
    	ifconfig | grep 172.17  > ipadder.txt
    	git add ipadder.txt getip.sh README.md
    	git commit -m "Robot auto update"
    	git push getip master
    	echo -e "\033[31m---------------------------------------\033[0m"
    	echo -e "\033[31m| This program will sleep six minutes |\033[0m"
    	echo -e "\033[31m---------------------------------------\033[0m"
	sleep 6m
fi
