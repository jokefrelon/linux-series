#!/bin/sh
a=10
b=10
if[a==b]
	then
		ip a > ipadder.txt
		cat ipadder.txt
	else
		sleep 3600
	fi
cd /mnt/github/shell/
git add ipadder.txt
git commit -m "Robot auto update"
git push getip master
sleep 3600
cd /mnt/github/shell/
./getip.sh

