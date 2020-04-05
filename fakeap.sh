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
echo -e $RED""
figlet AP-FL00D3R
echo ""
echo -e $BOLD""
if [[ $1 == "" ]]
then
	echo -e "${RED}[*] ${YELLOW}Please specify interface.
Example :${MAGENTA} ./fakeap.sh wlan0mon"
else
	sleep 1
	echo -ne "$BLUE[*] ${YELLOW}Do you want to create word by Yourself, Randomize or Skip?[Y/R/S] "
	read exc

	if [ -f $path/wordlist.txt ]
	then
		echo -e "${GREEN}[*] ${YELLOW}File exists."
	else
		echo -e "${RED}[!] ${YELLOW}File not exists, creating one for you..."
		sleep 1
		touch wordlist.txt
	fi

	case $exc in
		Y)
		echo -e "${BLUE}[*] ${YELLOW}I will open for you gedit, click ctrl+s if you are ready and then close it."
		sleep 1.5
		gedit $path/wordlist.txt
		;;
		R)
		echo -ne "${BLUE}[*] ${YELLOW}How many words do you want to generate?(default:2000): "
		read count
		shuf -n$count /usr/share/dict/american-english >> $path/wordlist.txt
		;;
		S)
		echo -e "${BLUE}[*] ${YELLOW}Skipped."
		;;
		*)
		echo -e "${RED}[!] Wrong command"
		echo -e "${RED}[!] ${YELLOW}Quitting."
		;;
	esac
	sleep 0.5
	echo -e "${BLUE}[*] ${YELLOW}Creating fake APs.."
	sleep 0.5
	echo -e "${BLUE}[*] ${YELLOW}Check your Phone..."
	mdk3 $1 b -f ./wordlist.txt -a -s 100
	read -p "[*] Press [Enter] to exit"
	rm wordlist.txt
	touch wordlist.txt
fi
