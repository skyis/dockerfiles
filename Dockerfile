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
RUN yum install -y git
RUN yum install -y gcc
RUN yum install -y python-devel python27-devel python-setuptools
RUN yum install -y openssl-devel
RUN yum install -y libmcrypt-devel
RUN yum install -y libyaml-devel
RUN yum install -y sysstat
RUN yum install -y tcpdump
RUN yum install -y mysql


### Web(NGINX + PHP) Environment ###
RUN yum install -y nginx

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
RUN pip install supervisor
RUN pip install awscli

### PHP Environment Management Tool ###
# composer
RUN yum install -y composer --enablerepo=remi --enablerepo=remi-php55
RUN yum install -y php55-php-pecl-xdebug --enablerepo=remi --enablerepo=remi-php55
#RUN yum install -y php-phpunit-PHPUnit --enablerepo=remi --enablerepo=remi-php55
#RUN yum install -y php-phpunit-DbUnit --enablerepo=remi --enablerepo=remi-php55



CMD ["/bin/sh"]