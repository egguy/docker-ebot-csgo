#!/bin/sh

IP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
cat /home/ebotv3/ebot-csgo/config/config.ini
sed -i "s/127.0.0.1/$IP/g" /home/ebotv3/ebot-csgo/config/config.ini
cat /home/ebotv3/ebot-csgo/config/config.ini
sleep 30
/usr/bin/php ${homedir}/ebot-csgo/bootstrap.php
