#!/bin/bash
echo `echo "scale=2; $(cat /sys/class/thermal/thermal_zone2/temp)/1000" | bc` °C