#!/bin/bash
mkdir ~/working
mkdir ~/working/IELKO
git clone https://github.com/upggr/IELKO-MEDIA-SERVER.git ~/working/IELKO
rm -rf /usr/local/nginx/html/*
cp ~/working/IELKO/www/index.php /usr/local/nginx/html/index.php
cp ~/working/IELKO/www/ielko-media-server.css /usr/local/nginx/html/ielko-media-server.css
cp ~/working/IELKO/www/stream.xml /usr/local/nginx/html/stream.xml
cp ~/working/IELKO/www/testing.png /usr/local/nginx/html/testing.png
cp ~/working/IELKO/www/favicon.ico /usr/local/nginx/html/favicon.ico
git clone https://github.com/upggr/ielko-video-player /usr/local/nginx/html/player

ip=$(curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//' )
sed -i -- 's/replaceip/'"$ip"'/g' /usr/local/nginx/html/stream.xml
sed -i -- 's/replaceip/'"$ip"'/g' /usr/local/nginx/html/index.php
#sed -i -- 's/replaceip/'"$ip"'/g' /usr/local/nginx/conf/nginx.conf
sudo rm -rf ~/working