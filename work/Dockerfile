FROM centos:centos7
WORKDIR /var/www/html

RUN yum update -y

RUN yum install -y epel-release
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
RUN yum install -y --enablerepo=remi,remi-php72 php php-devel php-mbstring php-pdo php-pgsql php-gd php-xml php-mcrypt
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/tmp
RUN mv /tmp/composer.phar /usr/local/bin/composer
RUN curl -sL https://rpm.nodesource.com/setup_10.x | bash -
RUN yum install -y nodejs
