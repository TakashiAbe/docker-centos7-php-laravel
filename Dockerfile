FROM takashiabe/centos7-apache-php

RUN yum clean all && yum -y update

RUN composer global require "laravel/installer=~1.1"
RUN composer global require "laravel-ja/comja5:~1"

RUN mkdir /var/www_tmp &&  cd /var/www_tmp && /root/.composer/vendor/bin/laravel new laravel
RUN cd /var/www_tmp/laravel && /root/.composer/vendor/bin/comja5 -a

VOLUME /var/www

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 80
CMD ["/usr/sbin/init"]

