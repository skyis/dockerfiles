FROM cents:6.6

### yum update ###
RUN yum -y update

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



