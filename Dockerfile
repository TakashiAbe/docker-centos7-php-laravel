FROM takashiabe/centos7-apache-php

RUN yum clean all && yum -y update

RUN mkdir /var/www_tmp &&  cd /var/www_tmp && composer create-project laravel/laravel laravel

VOLUME /var/www

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 80
CMD ["/usr/sbin/init"]



