#!/bin/sh
# cleanup script for hostapd docker container
# This script is called by the hostapd service when it exits

# colours for output
NOCOLOR='\033[0m'
RED='\033[0;31m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'

# cleanup function to delete iptables rules and restart network interface
cleanup () {
  echo -e "${CYAN}[*] Deleting iptables rules...${NOCOLOR}"
  sh /iptables_off.sh || echo -e "${RED}[-] Error deleting iptables rules${NOCOLOR}"
  echo -e "${CYAN}[*] Restarting network interface...${NOCOLOR}"
  ip link set wlan0 down
  ip addr flush dev wlan0
  echo -e "${GREEN}[+] Successfully exited, byebye! ${NOCOLOR}"
}
