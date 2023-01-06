#!/bin/bash

# Define color and text formatting codes
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
RESTORE="\e[39"
BOLD="\e[1m"
NORMAL="\e[0m"

# Set path and MAC address variables
path=$(pwd)
mac=$(macchanger -s wlan0 | grep Current |  awk '{print $3}')

# Make main.sh executable
chmod +x main.sh

# Print banner and current MAC address
echo -e $CYAN""
clear
echo -e $BOLD""
figlet AP-K1LL3R
echo -e ""
echo -ne "${BLUE}[*] ${YELLOW}Your current MAC is: ${RED}$mac"

# Change MAC address and store new MAC address in a variable
echo ""
echo ""
echo -e "${BLUE}[*] ${YELLOW}Changing MAC now..."
ifconfig wlan0 down
newmac=$(sudo macchanger -a wlan0 | grep New | awk '{print $3}')
ifconfig wlan0 up

# Print new MAC address
echo ""
echo -ne "${BLUE}[*] ${YELLOW}New MAC: ${GREEN}$newmac"

# Check if interface is in monitor mode
echo ""
sleep 3
echo ""
echo -e "${BLUE}[*] ${YELLOW}Checking if you are in monitor mode.."
sleep 2
if [[ $(ifconfig | grep wlan0mon | awk '{print $1}' | tr -d :) == "wlan0mon" ]]; then
    echo -e "[*] wlan0mon found."
else
    echo ""
    echo -e "${RED}[!] ${YELLOW}You are not in apdater mode."
    airmon-ng check kill
    echo -e "${RED}[!] Expecting error...${GREEN}Will fixing it...."
    airmon-ng start wlan0mon &>$path/error.log
    echo -e "${BLUE}[*] ${GREEN}Adapter mode started."
    if [ -f error.log ]; then
        airmon-ng check kill
        airmon-ng start wlan0 &>$path/error.log
        bash main.sh
    else
        echo -e "[!] You have some error, check errors in: error.log"
    fi
fi
