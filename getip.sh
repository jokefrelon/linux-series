#!/bin/sh
while true
do
	cd /mnt/github/shell/
    	ifconfig > ipadder.txt
    	git add ipadder.txt getip.sh README.md
    	git commit -m "Robot auto update"
    	git push getip master
    	echo -e "\033[31m---------------------------------------\033[0m"
    	echo -e "\033[31m| This program will sleep six minutes |\033[0m"
    	echo -e "\033[31m---------------------------------------\033[0m"
	sleep 6m
done
