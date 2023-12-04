#!/bin/sh
# set up script for hostapd docker container
# This script is called by the hostapd service when it starts up using the docker entrypoint system
# It is used to bring up the wlan0 interface and set the IP address

# colours for output
NOCOLOR='\033[0m'
RED='\033[0;31m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'

# setup function to set up wifi region, set ip address for wlan0 and iptables rules
setup () {
  echo -e "${CYAN}[*] Setting wifi region to AU${NOCOLOR}"
  iw --debug reg set AU

  echo -e "${CYAN}[*] Creating iptables rules${NOCOLOR}"
  sh /iptables.sh || echo -e "${RED}[-] Error creating iptables rules${NOCOLOR}"

  echo -e "${CYAN}[*] Setting wlan0 settings${NOCOLOR}"
  ip link set wlan0 up
  ip addr flush dev wlan0
  ip addr add ${AP_IP_ADDRESS}/24 dev wlan0
}
