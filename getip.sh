#!/bin/sh
a=10
b=10
if [$a==$b]
	then
		ifconfig >/mnt/github/shell/ipadder.txt
		cat ipadder.txt
	else
		echo "Please checkout the shell"
	fi
cd /mnt/github/shell/
git add ipadder.txt 
git commit -m "Robot auto update"
git push getip master
sleep 3600
cd /mnt/github/shell/
./getip.sh

