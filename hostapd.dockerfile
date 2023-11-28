# hostapd program running in a docker container
FROM alpine:edge

RUN apk --no-cache add hostapd=2.10-r6

CMD ["hostapd","/hostapd.conf"]
