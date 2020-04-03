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
mac=$(macchanger -s wlan0 | grep Current |  awk '{print $3}')
chmac=$(sudo macchanger -a wlan0 | grep New | awk '{print $3}')
c=$(ifconfig | grep wlan0mon | awk '{print $1}' | tr -d :)

# Start Script
chmod +x main.sh
echo -e $CYAN""
clear
echo -e $BOLD""
figlet AP-K1LL3R
echo -e ""
echo -ne "${BLUE}[*] ${YELLOW}Your current MAC is: ${RED}$mac"
sleep 0.2
echo ""
echo ""
echo -e "${BLUE}[*] ${YELLOW}Changing MAC now..."
sleep 0.5
ifconfig wlan0 down
sudo macchanger -a wlan0 | grep New | awk '{print $3}' > new.txt
newmac=$(cat new.txt)
ifconfig wlan0 up
echo ""
echo -ne "${BLUE}[*] ${YELLOW}New MAC: ${GREEN}$newmac"
rm new.txt
echo ""
sleep 3
echo ""
echo -e "${BLUE}[*] ${YELLOW}Checking if your Wifi-Chipset is in monitor mode.."
sleep 2
if [[ $c == "wlan0mon" ]]; then
	echo -e "[*] wlan0mon found."
	echo -e "Your Wifi-Chipset is already running in monitor mode"
else
	
	echo ""
	echo -e "${RED}[!] ${YELLOW}Your Wifi-Chipset is not running in monitor mode"
	airmon-ng check kill
	echo -e "${RED}[!] Expecting error... 
	${GREEN}enable monitor mode for Wifi-Chipset..."
	airmon-ng start wlan0mon &>$path/error.log
	sleep 0.5
	echo -e "${BLUE}[*] ${GREEN}Your Wifi-Chipset's monitor mode has been enabled"
	if [ -f error.log ]
	then
		airmon-ng check kill
		airmon-ng start wlan0 &>$path/error.log
		bash main.sh
	else
		echo -e "[!] You have some error, check errors in: error.log"
	
	fi
fi

