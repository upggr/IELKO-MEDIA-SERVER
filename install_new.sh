#!/bin/bash
mkdir ~/working
cd ~/working
git clone git://github.com/upggr/UPG.GR-MEDIA-SERVER.git .
dpkg -i ~/working/deps/nginx-full_1.10.1-0ubuntu1.2_amd64.deb ~/working/deps/nginx-common_1.10.1-0ubuntu1.2_all.deb
apt-get install -f
ufw allow 1935
ufw allow 80
cat ~/working/conf/rtmp.conf >> /etc/nginx/nginx.conf
cp /etc/nginx/sites-enabled/dash.conf /etc/nginx/sites-enabled/dash.conf

cd /var/www && git clone https://github.com/arut/dash.js.git
cd dash.js && git checkout live
ip=$(curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//' )
sed -i -- 's/http://dash.edgesuite.net/envivio/dashpr/clear/Manifest.mpd/'"http://$ip/dash/live.mpd"'/g' baseline.html
systemctl restart nginx && systemctl status nginx