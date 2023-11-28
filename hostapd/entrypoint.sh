#!/bin/sh
# entrypoint script for hostapd docker container
# This script is called by the hostapd service when it starts up using the docker entrypoint system
# It is used to bring up the wlan0 interface and set the IP address

# colours for output
NOCOLOR='\033[0m'
RED='\033[0;31m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'

# function to handle SIGTERM/SIGINT signals
sigterm_handler () {
  echo -e "${CYAN}[*] Caught SIGTERM/SIGINT!${NOCOLOR}"
  pkill hostapd
  cleanup
  exit 0
}

# cleanup function to delete iptables rules and restart network interface
cleanup () {
  echo -e "${CYAN}[*] Deleting iptables rules...${NOCOLOR}"
  sh /iptables_off.sh || echo -e "${RED}[-] Error deleting iptables rules${NOCOLOR}"
  echo -e "${CYAN}[*] Restarting network interface...${NOCOLOR}"
  ifdown wlan0
  ifup wlan0
  echo -e "${GREEN}[+] Successfully exited, byebye! ${NOCOLOR}"
}

trap 'sigterm_handler' TERM INT
echo -e "${CYAN}[*] Creating iptables rules${NOCOLOR}"
sh /iptables.sh || echo -e "${RED}[-] Error creating iptables rules${NOCOLOR}"

echo -e "${CYAN}[*] Setting wlan0 settings${NOCOLOR}"
# ifdown wlan0
# ifup wlan0
ip link set wlan0 up
ip addr flush dev wlan0
ip addr add ${AP_IP_ADDRESS}/24 dev wlan0

echo -e "${CYAN}[+] Configuration successful! Services will start now${NOCOLOR}"

# release to script to the command script
exec "$@"

cleanup
