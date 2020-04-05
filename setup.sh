#!/bin/bash

# Configuration the Ennvironment
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
RESTORE="\e[39"
BOLD="\e[1m"
NORMAL="\e[0m"

path=$(pwd)
mac=$(macchanger -s $1 | grep Current |  awk '{print $3}')
chmac=$(sudo macchanger -a $1 | grep New | awk '{print $3}')
c=$(ifconfig | grep mon | awk '{print $1}' | tr -d :)


# Start Script
chmod +x main.sh
echo -e $CYAN""
clear
if [ -f error.log ]
then
	rm error.log
fi
echo -e $BOLD""
figlet AP-K1LL3R
echo -e ""
echo -e "${BLUE}[*] ${YELLOW}Interface detected: ${RED}$1"
echo ""
if [[ $1 == "" ]]
then
	echo -e "${RED}[*] ${YELLOW}Please specify interface.

Example :${MAGENTA} ./setup.sh wlan0"
elif [[ $1 == "$1mon" ]]
then
	echo -e "${BLUE}[*] ${RED}You are already in monitor mode1."
	sleep 2
	echo -e "${BLUE}[*] ${YELLOW}Starting the main tool..."
	sleep 1.5
	bash main.sh

else
	echo -ne "${BLUE}[*] ${YELLOW}Your current MAC is: ${RED}$mac"
	sleep 0.2
	echo ""
	echo ""
	echo -e "${BLUE}[*] ${YELLOW}Changing MAC now..."
	sleep 0.5
	ifconfig $1 down
	sudo macchanger -a $1 | grep New | awk '{print $3}' > new.txt
	newmac=$(cat new.txt)
	ifconfig $1 up
	echo ""
	echo -ne "${BLUE}[*] ${YELLOW}New MAC: ${GREEN}$newmac"
	rm new.txt
	echo ""
	sleep 3
	echo ""
	echo -e "${BLUE}[*] ${YELLOW}Enabling Wifi-Adapter..."
	airmon-ng check kill
	airmon-ng start $1 
	sleep 0.5
	echo -e "${BLUE}[*] ${GREEN}Your Wifi-Chipset's monitor mode has been enabled"
	export $1
	if [ -f error.log ]
	then
		echo -e "[!] You have some error, check errors in: error.log"
		airmon-ng stop $c
		service network-manager restart
	fi
	
	echo -ne "${BLUE}[*] ${YELLOW}Do you want to start main tool now?[Y/N](default: Y): "
	read to
	if [[ $to == "y" || $to == "Y" ]]
	then
		
		bash main.sh
	else
		sleep 0.5
		echo -ne "${BLUE}[*] ${YELLOW}Do you want to exit interface: ${RED}$c[Y/N]?: "
		read ei
		sleep 0.5
		if [[ $ex == "y" || $ei == "Y" ]]
		then
			airmon-ng stop $c
			service network-manager restart
			echo "${BLUE}[*] ${YELLOW}Successfully stopped wifi adapter mode..."
			sleep 1.5
		fi
	fi
fi
