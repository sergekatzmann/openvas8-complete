#!/bin/bash
cd /usr/local/sbin
./openvasmd --rebuild
./openvassd
echo -e "Open-VAS Scanner Started..."
./openvasmd
echo -e "Open-VAS Manager Started..."
./gsad
echo -e "Greenbone Security Assistant Started..."
echo -e "\nWelcome to OpenVAS 8"
cd /usr/local/bin
./redis-server /etc/redis.conf