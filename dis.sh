#!/bin/bash

path=$(pwd)
c=$(ifconfig | grep mon | awk '{print $1}' | tr -d :)
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
RESTORE="\e[39"
BOLD="\e[1m"
NORMAL="\e[0m"

clear
figlet Disabling\ Monitor\ Mode
echo -e $BOLD""
sleep 1
echo -e "${BLUE}[*]${YELLOW} Currently running monitor mode: ${RED}$c"
sleep 1
echo -ne "${BLUE}[*] ${YELLOW}Enter your monitor mode[example: wlan0mon|wlan1mon]:${RED} "
read m 
sleep 0.5
echo -e "${RED}[!] ${MAGENTA}Starting..."
sleep 0.5
echo -e "${BLUE}[*] ${YELLOW}Restoring original mac..."
ifconfig $m down >/dev/null
macchanger -p $m >>/dev/null
ifconfig $m up >/dev/null
echo -e "${BLUE}[*] ${YELLOW}Disabling adapter mode.."
airmon-ng stop $m
if [ -f *.txt ]
then
	rm *.txt	
fi
service network-manager restart
exit
