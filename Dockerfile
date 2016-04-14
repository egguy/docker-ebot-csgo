FROM phusion/baseimage:0.9.18
CMD ["/sbin/my_init"]

RUN apt-get update && apt-get -y upgrade && apt-get clean

ENV homedir /home/ebotv3
RUN apt-get -y install nodejs npm curl git php5-cli phpmyadmin unzip && apt-get clean

RUN /bin/ln -s /usr/bin/nodejs /usr/bin/node

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin

RUN mkdir ${homedir} && curl -L https://github.com/deStrO/eBot-CSGO/archive/master.zip >> ${homedir}/master.zip && unzip -d ${homedir} ${homedir}/master.zip && ln -s ${homedir}/eBot-CSGO-master ${homedir}/ebot-csgo && cd ${homedir}/ebot-csgo && /usr/bin/php /usr/bin/composer.phar install

RUN sed -i 's/MYSQL_IP = "127.0.0.1"/MYSQL_IP = "172.17.0.1"/g' /home/ebotv3/ebot-csgo/config/config.ini

RUN npm install socket.io formidable archiver

COPY Match.php /home/ebotv3/eBot-CSGO-master/src/eBot/Match/Match.php

RUN mkdir /etc/service/ebot
ADD run_ebot.sh /etc/service/ebot/run
RUN chmod +x /etc/service/ebot/run


RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
