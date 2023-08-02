FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Kathmandu

RUN apt-get update &&\
 apt-get install apache2 -y apache2 mariadb-server php php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap libapache2-mod-php php-mysql -y wget

WORKDIR /tmp

RUN wget http://wordpress.org/latest.tar.gz &&\
 tar xzvf latest.tar.gz &&\
 cp -r /tmp/wordpress/* /var/www/html &&\
 rm -f /var/www/html/index.html

WORKDIR /var/www/html

COPY ./wp-config.php /var/www/html


RUN chown -R www-data:www-data /var/www/html/* &&\
 chmod -R 775 /var/www/html/*

EXPOSE 80

CMD ["apache2ctl", "-D", "FOREGROUND"]






