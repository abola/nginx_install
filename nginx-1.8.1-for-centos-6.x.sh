#!/bin/sh
###
# 安裝反向服務 nginx server
##

CURRENT_PATH=`pwd`

# required install 
yum -y groupinstall 'Development Tools'
yum -y install wget patch git
yum -y install pcre-devel zlib-devel openssl-devel

# nginx download
wget http://nginx.org/download/nginx-1.8.1.tar.gz
tar zxvf nginx-1.8.1.tar.gz
cd nginx-1.8.1

# third-party module download & patch
git clone https://github.com/yaoweibin/nginx_upstream_check_module.git
git clone https://bitbucket.org/nginx-goodies/nginx-sticky-module-ng.git
git clone https://github.com/gnosek/nginx-upstream-fair.git

patch -p1 < ./nginx_upstream_check_module/check_1.7.5+.patch
patch -p0 ./nginx-sticky-module-ng/ngx_http_sticky_module.c < ./nginx_upstream_check_module/nginx-sticky-module.patch
patch -p2 ./nginx-upstream-fair/ngx_http_upstream_fair_module.c < ./nginx_upstream_check_module/upstream_fair.patch

# build source
./configure \
--sbin-path=/usr/sbin/nginx \
--conf-path=/etc/nginx/nginx.conf \
--pid-path=/var/run/nginx.pid \
--error-log-path=/var/log/nginx/error.log \
--http-log-path=/var/log/nginx/access.log \
--add-module=./nginx_upstream_check_module \
--add-module=./nginx-upstream-fair \
--add-module=./nginx-sticky-module-ng 
make
make install 

# set Nginx as service 
cp $CURRENT_PATH/nginx_as_service /etc/init.d/nginx
chmod +x /etc/init.d/nginx
chkconfig nginx on
