FROM ubuntu
RUN apt update
RUN apt install apache2 -y
RUN apt install apache2-utils -y
RUN apt clean
CMD ["apache2ctl", "-D", "FOREGROUND"]

FROM ubuntu
RUN apt update \
    && apt install apache2 -y \
    && apt install apache2-utils -y \
    && apt clean
CMD ["apache2ctl", "-D", "FOREGROUND"]

FROM alpine
# Upgrade existing packages in the base image
RUN apk --no-cache upgrade
# Install apache from packages with out caching install files
RUN apk add --no-cache apache2
# Creat directory for apache2 to store PID file
# RUN mkdir /run/apache2
# Open port for httpd access
EXPOSE 80
# Run httpd in foreground so that the container does not quit
# soon after start
# To run this container in the back ground use the -d option
#
# $ sudo docker run -d broadtech/alpine-apache2
CMD ["-D","FOREGROUND"]
# Start httpd when container runs
ENTRYPOINT ["/usr/sbin/httpd"]

FROM centos:7
#MAINTAINER Ian Agpawa<agpawaji@gmail.com>
#RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
 #&& rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum update -y
RUN yum install httpd httpd-tools -y
#COPY index.html /var/www/html/
#ENTRYPOINT ["/usr/sbin/httpd","-D","FOREGROUND"]
ENTRYPOINT ["systemctl","start","httpd" ]

