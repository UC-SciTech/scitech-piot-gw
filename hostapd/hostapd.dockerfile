# hostapd program running in a docker container
FROM alpine:edge

# install hostapd
RUN apk --no-cache add hostapd iw iptables && rm -rf /var/cache/apk/*

ENV AP_IP_ADDRESS=10.100.107.1

# get the network and iptables config
# COPY interfaces /etc/network/interfaces # mount this instead
COPY iptables.sh /iptables.sh
COPY iptables_off.sh /iptables_off.sh

# entrypoint script
COPY entrypoint.sh /usr/sbin/hostapd-entrypoint.sh
RUN chmod +x /usr/sbin/hostapd-entrypoint.sh

ENTRYPOINT [ "/usr/sbin/hostapd-entrypoint.sh" ]

# CMD ["/usr/sbin/hostapd","-dd","/hostapd.conf"]
