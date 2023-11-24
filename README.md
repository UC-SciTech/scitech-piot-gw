# scitech-piot-gw

Raspberry Pi based IoT gateway with Waveshare SX130x 868M/915M LoRaWAN Gateway Module.

## Hardware

1. raspberry pi 4 4GB RAM
1. 16GB microSD card
1. USB-C power supply 3A
1. Waveshare SX130x 868M/915M LoRaWAN Gateway Module [bought here](<https://www.waveshare.com/product/iot-communication/long-range-wireless/nb-iot-lora/sx1302-868m-lorawan-gateway-b.htm>)
1. XBee pro 900HP 250mW RPSMA [bought here](<https://www.digikey.com/en/products/detail/digi/XBP9B-XCST-001/4974970>)
1. 915MHz 3dBi RP-SMA Antenna [bought here](<https://www.digikey.com/en/products/detail/laird-connectivity-inc/ANT-916-CW-RCS/1057770>)
1. XBee USB Adapter [bought here](<https://www.digikey.com/en/products/detail/digi/XBIB-U-DEV/4974971>)

## Waveshare SX130x 868M/915M LoRaWAN Gateway Module Documentation

The Waveshare product wiki can be found [here](<https://www.waveshare.com/wiki/SX1302_LoRaWAN_Gateway_HAT>)

## Software

1. ubuntu server 22.04 LTS 64bit (arm64) - OS for the gateway
1. docker & docker-compose - to run main network services
1. ansible (for setup) - to install and configure the gateway remotely
1. pi-hole ad blocker and DHCP server
1. emqx mqtt broker
1. influxdb & telegraph - time series database and ingress from mqtt
1. homeassistant - home automation platform
1. node-red - flow based programming for IoT automation
1. basicstation - lora-gateway-bridge
1. homer - dashboard for services

## Password SSH

```bash
# install sshpass

sudo apt install sshpass

# use the ask pass option in ansible commands

ansible gateways --ask-pass -m ping
```

## Installation

```bash
#Install a virtual python environment (make sure that python3 venv is installed)

python3 -m venv .venv

source .venv/bin/activate

pip install -r requirements.txt
```

```bash
# create a env/env.yaml file from the example

mkdir env
cp env.example.yaml env/env.yaml

# edit the env/env.yaml file and change credentials

# Run ansible setup playbook

ansible-playbook -k -K install.ansible.yaml

# start services
ansible-playbook -k -K start.ansible.yaml
```

```bash
# login to the gateway

ssh scitech@piot-gw-001 # replace 001 with the number of your gateway
```

```bash
# run the docker compose file

cd /home/scitech/ws/scitech-piot-gw

docker-compose up -d
```

## Administation

There is an access-point, dhcp/dns server, mqtt broker, time series db, node-red, and lora gateway running on the device. Some of these are accessible via the web interfaces.

### Access Point (hostapd)

The SSID is: `piot-gw-00x`
The password is configured in the `.env` when created.

### pi-hole

Go to: <http://piot-gw-001/admin> (change 001 to the number of your gateway)

The password is configured in the `.env` when created.

### emqx

Go to: <http://piot-gw-001:18083> (change 001 to the number of your gateway)

### influxdb

Go to: <http://piot-gw-001:8086> (change 001 to the number of your gateway)

### home assistant

Go to: <http://piot-gw-001:8123> (change 001 to the number of your gateway)

### node-red

Go to: <http://piot-gw-001:1880> (change 001 to the number of your gateway)

### heimdall

Go to: <https://piot-gw-001:8443> (change 001 to the number of your gateway)
