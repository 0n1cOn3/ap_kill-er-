# AP Kill(er)
## Table of content:
* [General Information](#general-info)
* [Changelog](#changelog)
* [Installation](#installation)
* [Disclaimer](#disclaimer)
* [Credits](#credits)
* [Social Media](#social-media)
* [Bug Report](#bug-report)

## General Information

AP Kill(er) was a personal help back in 2019 for a member of TheViperZCrew group, and they had not found a working tool that could deauthenticate all access points (AP) from the network. 
After some research, the member started writing this small script tool. 

The AP killer automatically changes the MAC address during setup and checks if wlan0mon is enabled. You can enable this manually before running the script.

**WARNING:**
This script was written explicitly for Linux.

There are for other systems like Windows WSL, FreeBSD, *nix or applications for smartphones like Termux for Android or iSH for iOS are not supported.

## Changelog

  **[Upda] v0.1.1:**
  * Refactored code
  
  **[BETA] v0.1:**
  * Added 2 methods to attack
  * Added MAC changer

## Disclaimer
  > * Use this script only for school and learning purposes!
  > * If you make any illegal attacks pointing to this script, the author and currently maintainer of this project disclaims any liability.  
  > * Use the tool properly and according to the national regulations.  

## Installation
  
  ```git clone https://github.com/0n1cOn3/ap_killer.git```
  
  ```cd ap_killer && chmod +x *.sh```
  
  
## Using Tool at attack:
  

```bash setup.sh```


```main.sh``` is the main script but do not start it because then setup.sh enable the monitor mode and mac spoofer.
  Make sure you have killed all networking processes, and close firefox or any internet application.

## Credits

* Credits: ViperZCrew - MrBlackX

## Social Media
Telegram:
* @h_2_o0

## Bug Report
  If you found any bug or issue, pless go [here](https://github.com/0n1cOn3/ap_killer/issues)
  You can also request an update.
