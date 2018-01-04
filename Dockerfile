FROM node:latest

RUN npm install -g openvpn-config-splitter

WORKDIR /tmp
ADD client.ovpn /tmp/

RUN ovpnsplit /tmp/client.ovpn
