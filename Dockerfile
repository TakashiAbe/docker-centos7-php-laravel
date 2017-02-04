FROM takashiabe/centos7-apache-php

RUN yum clean all && yum -y update

RUN composer global require "laravel/installer=~1.1"
RUN composer global require "laravel-ja/comja5:~1"

RUN mkdir /var/www_tmp &&  cd /var/www_tmp && composer create-project laravel/laravel laravel "5.4.*" --prefer-dist && comja5

VOLUME /var/www

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 80
CMD ["/usr/sbin/init"]

