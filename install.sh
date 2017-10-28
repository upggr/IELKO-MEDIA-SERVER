#!/bin/bash
sudo apt-get install build-essential libpcre3 libpcre3-dev libssl-dev
mkdir ~/working
mkdir ~/working/IELKO
mkdir ~/working/nginx-rtmp-module
mkdir ~/working/ngx_devel_kit
mkdir ~/working/set-misc-nginx-module
mkdir ~/working/nginx
mkdir ~/working/nginx-hmac-secure-link
git clone https://github.com/upggr/IELKO-MEDIA-SERVER.git ~/working/IELKO
git clone https://github.com/sergey-dryabzhinsky/nginx-rtmp-module.git ~/working/nginx-rtmp-module
git clone https://github.com/openresty/set-misc-nginx-module.git ~/working/set-misc-nginx-module
git clone https://github.com/simpl/ngx_devel_kit.git ~/working/ngx_devel_kit
git clone https://github.com/nginx-modules/nginx-hmac-secure-link.git ~/working/nginx-hmac-secure-link
wget http://nginx.org/download/nginx-1.13.6.tar.gz -P ~/working
tar -xf ~/working/nginx-1.13.6.tar.gz -C ~/working/nginx --strip-components=1
rm ~/working/nginx-1.13.6.tar.gz
cd ~/working/nginx
#./configure --with-http_ssl_module --add-module=../nginx-rtmp-module --add-module=../ngx_devel_kit --add-module=../set-misc-nginx-module --add-module=../nginx-hmac-secure-link
./configure --with-http_ssl_module --add-module=../nginx-rtmp-module --add-module=../ngx_devel_kit --add-module=../set-misc-nginx-module 
make -j 1
sudo make install


sudo apt-get update -y
sudo apt-get install build-essential libpcre3 git libpcre3-dev libssl-dev software-properties-common php5-common php5-cli php5-fpm -y
iptables -I INPUT -p tcp --dport 22 -j ACCEPT
iptables -I INPUT -p tcp --dport 80 -j ACCEPT
iptables -I INPUT -p tcp --dport 1935 -j ACCEPT
mkdir /var/log/nginx/
touch /var/log/nginx/error.log
cd /etc/php5/cli
sudo mv php.ini php.ini.backup
sudo ln -s ../fpm/php.ini
sudo service php5-fpm start
sudo mkdir ~/working
cd ~/working
git clone git://github.com/upggr/nginx.git
git clone git://github.com/upggr/nginx-rtmp-module.git
git clone git://github.com/upggr/UPG.GR-MEDIA-SERVER.git
cp ~/working/UPG.GR-MEDIA-SERVER/conf/nginx.txt /etc/init.d/nginx
cp ~/working/UPG.GR-MEDIA-SERVER/conf/refresh.txt /etc/cron.daily/refreshwww
sudo chmod +x /etc/cron.daily/refreshwww
sudo chmod +x /etc/init.d/nginx
sudo /usr/sbin/update-rc.d -f nginx defaults
cd ~/working/nginx
sudo chmod +x configure
./configure --with-http_ssl_module --add-module=../nginx-rtmp-module
sudo make && make install
mkdir /usr/local/nginx/html/hls/
mkdir /usr/local/nginx/html/dash/
mkdir /usr/local/nginx/html/dash/tmp/
mkdir /usr/local/nginx/html/hls/tmp/
touch /usr/local/nginx/conf/nginx.conf
cp ~/working/UPG.GR-MEDIA-SERVER/conf/nginx.conf /usr/local/nginx/conf/nginx.conf
ip=$(curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//' )
#ip=$(ifconfig eth0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}')
cp -a ~/working/UPG.GR-MEDIA-SERVER/www/. /usr/local/nginx/html
sed -i -- 's/replaceip/'"$ip"'/g' /usr/local/nginx/conf/nginx.conf
sed -i -- 's/replaceip/'"$ip"'/g' /usr/local/nginx/html/vlc.m3u
sed -i -- 's/localhost/'"$ip"'/g' /usr/local/nginx/html/stream.xml
rm -f /usr/local/nginx/conf/nginx.conf.default
ln -s /usr/local/nginx/sbin/nginx nginx
sudo service nginx start
sudo rm -rf ~/working
shutdown -r now