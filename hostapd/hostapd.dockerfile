# hostapd program running in a docker container
FROM alpine:edge

# install hostapd
RUN apk --no-cache add hostapd=2.10-r6

# get the network and iptables config
# COPY interfaces /etc/network/interfaces # mount this instead
COPY iptables.sh /iptables.sh
COPY iptables_off.sh /iptables_off.sh

# entrypoint script
COPY entrypoint.sh /bin/hostapd-entrypoint.sh
RUN chmod +x /bin/hostapd-entrypoint.sh

ENTRYPOINT [ "/bin/hostapd-entrypoint.sh" ]

CMD ["hostapd","/hostapd.conf"]
