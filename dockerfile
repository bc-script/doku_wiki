FROM almalinux:latest
RUN yum -y update
RUN yum -y install git 
RUN yum -y install wget unzip tar epel-release socat
RUN dnf install php php-gd php-xml php-json
RUN wget https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz
RUN mkdir -p /var/www/html
RUN tar xzf dokuwiki-stable.tgz --strip-components=1 -C /var/www/html
RUN chown -R apache:apache /var/www/html
COPY  dokuwiki.conf /etc/httpd/conf.d/dokuwiki.conf 
RUN cp /var/www/html/.htaccess{.dist,}
RUN systemctl start httpd
RUN systemctl enable httpd