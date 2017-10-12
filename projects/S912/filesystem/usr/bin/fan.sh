#!/bin/sh

echo 218 > /sys/class/gpio/export 
echo 219 > /sys/class/gpio/export 
echo out > /sys/class/gpio/gpio218/direction 
echo out > /sys/class/gpio/gpio219/direction 
echo 1 > /sys/class/gpio/gpio218/value 
echo 0 > /sys/class/gpio/gpio219/value 
