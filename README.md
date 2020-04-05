# ACCESS POINT KILLER


## Table of contents:
* [General Information](#general-info)
* [Changelog](#changelog)
* [Access Point Flooder](#access-point-flooder)
* [Installation](#installation)
* [Disclaimer](#disclaimer)
* [Credits](#credits)
* [Social Media](#social-media)
* [Bug Report](#bug-report)

## General Information

  Acces Point Killer was only for my personal help, i have not found a working tool that deauthenticate all access points(AP)
  out of network. After some researching i began to wrote this little script-tool. 
  The AP killer automatically changing your mac address at the setup, then it checks if you have enabled **wlan0mon** or not.
  You can enable it manually before you are starting the script. This tool is an linux CLI tool, which only works on **Linux**
  and not Termux or other phone platforms.

## Changelog


 # Coming soon:

  **Version 0.4**
 * Resetting spoofed mac
 * Access Point Flood script [see more here](#access-point-flooder)
 
 
  # Already leaked versions:
  
  **Version: 0.3**
  * Added to except to start main.sh
  * Added if option above is denied, asking to disable monitor mode
  * Added CTRL+C after starting deauthing 
  * Added disabling monitor mode after aborting attack
  
  **Version: 0.2:**
  * Added option to add interface
  * Added interface detection

  **[BETA] Version 0.1:**
  * Added 2 methods to attack
  * Added MAC changer

## Access Point Flooder
  This will be in next update a script to flood all channels in your range with access points.
  The script is more for trolling people, you can still use it if you can.
  

## Disclaimer
  Use this tool for purposes only .:-) 🕵️‍♂️
  If you do any illegal attacks, i am not responsible for your tasks.
  Use this tool correctly, and do not re-upload it on your github repository without permissions.

## Installation

  You can use any linux you want.
  
  ```git clone https://github.com/ViperZCrew/ap_killer.git```
  
  ```cd ap_killer && chmod +x *.sh```
  
  Using Tool at attack:
  

  ```./setup.sh <interface>```

**For example:**

  ```./setup.sh wlan1```

```main.sh``` is the main script but do not start it because then setup.sh enable the monitor mode and mac spoofer.
  Make sure you have killed all networking processes, and close firefox or any internet application.

## Credits

* Credits: ViperZCrew - MrBlackX

## Social Media
Telegram:
* @MrBlackX
* @On1c0n3
* @rebl0x3r

# Join us at telegram: https://t.me/rebl0x3r  

## Bug Report
  If you found any bug or issue, pless go [here](https://github.com/ViperZCrew/ap_killer/issues)
  You can also request an update.
