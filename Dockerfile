FROM centos:6.6

### yum update ###
RUN yum -y update

### Common ###
RUN yum install -y wget

### EPEL/REMI ###
RUN wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
RUN rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm

### Common ###
RUN yum install -y git gcc tar
RUN yum install -y python-devel python27-devel python-setuptools
RUN yum install -y openssl-devel
RUN yum install -y libmcrypt-devel
RUN yum install -y libyaml-devel
RUN yum install -y sysstat tcpdump zip rsyslog
RUN yum install -y mysql
# for nginx
RUN yum install -y pcre-devel perl-ExtUtils-Embed

### nkf ###
RUN wget http://mirror.centos.org/centos/6/os/x86_64/Packages/nkf-2.0.8b-6.2.el6.x86_64.rpm
RUN rpm -ivh nkf-2.0.8b-6.2.el6.x86_64.rpm


### Web(NGINX + PHP) Environment ###
#RUN yum install -y nginx
RUN wget http://nginx.org/download/nginx-1.6.2.tar.gz
RUN tar xvfz nginx-1.6.2.tar.gz && cd nginx-1.6.2 && ./configure --prefix=/usr/local/nginx --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf --pid-path=/usr/local/nginx/nginx.pid --with-http_perl_module --with-http_ssl_module --user=nginx --group=nginx --error-log-path=/var/log/app --error-log-path=/var/log/app && make && make install
RUN groupadd nginx && useradd -g nginx -m nginx
COPY configs/etc/init.d/nginx.sh /etc/init.d/nginx
RUN chmod +x /etc/init.d/nginx
RUN chkconfig --add nginx


RUN yum install -y php55 --enablerepo=remi --enablerepo=remi-php55
RUN yum install -y php55-php-mysqlnd --enablerepo=remi --enablerepo=remi-php55
RUN yum install -y php55-php-fpm --enablerepo=remi --enablerepo=remi-php55
RUN yum install -y php55-php-bcmath --enablerepo=remi --enablerepo=remi-php55
RUN yum install -y php55-php-devel --enablerepo=remi --enablerepo=remi-php55
RUN yum install -y php55-php-gd --enablerepo=remi --enablerepo=remi-php55
RUN yum install -y php55-php-mbstring --enablerepo=remi --enablerepo=remi-php55
RUN yum install -y php55-php-mcrypt --enablerepo=remi --enablerepo=remi-php55
RUN yum install -y php55-php-pdo --enablerepo=remi --enablerepo=remi-php55
RUN yum install -y php55-php-pecl-apc --enablerepo=remi --enablerepo=remi-php55
RUN yum install -y php55-php-pecl-xdebug --enablerepo=remi --enablerepo=remi-php55
RUN yum install -y php55-php-process --enablerepo=remi --enablerepo=remi-php55
RUN yum install -y php55-php-xmlrpc --enablerepo=remi --enablerepo=remi-php55
RUN yum install -y php55-php-pecl-memcache --enablerepo=remi --enablerepo=remi-php55
RUN yum install -y php55-php-pecl-apcu --enablerepo=remi --enablerepo=remi-php55
RUN yum install -y php55-php-opcache --enablerepo=remi --enablerepo=remi-php55

### Python | pip ###
RUN easy_install pip
#RUN pip install supervisor
RUN pip install awscli

### PHP Environment Management Tool ###
# composer
RUN yum install -y composer --enablerepo=remi --enablerepo=remi-php55
RUN yum install -y php55-php-pecl-xdebug --enablerepo=remi --enablerepo=remi-php55
#RUN yum install -y php-phpunit-PHPUnit --enablerepo=remi --enablerepo=remi-php55
#RUN yum install -y php-phpunit-DbUnit --enablerepo=remi --enablerepo=remi-php55

# time zone 設定
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

## supervisord
RUN yum install --enablerepo=epel supervisor -y

## --- config files --- ##
COPY ./configs/etc/nginx/nginx.conf /etc/nginx/nginx.conf
RUN mkdir /etc/nginx/conf.d/
COPY ./configs/etc/nginx/conf.d/nginx_default.conf /etc/nginx/conf.d/default.conf
COPY ./configs/etc/php-fpm.conf /opt/remi/php55/root/etc/php-fpm.conf
COPY ./configs/etc/php-fpm.d/www.conf /opt/remi/php55/root/etc/php-fpm.d/www.conf
#COPY ./configs/etc/php.ini /opt/remi/php55/root/etc/php.ini
COPY ./configs/etc/supervisord.conf /etc/supervisord.conf

## Authentication
RUN mkdir /var/log/app
RUN chown -R nginx:nginx /var/log/app


COPY ./scripts/init_docker.sh /root/init.sh
CMD ["/bin/sh", "/root/init.sh"]

EXPOSE 80

