FROM ORIGIN/debian_base:wheezy
MAINTAINER Petr Burian <petr.burian@livesport.eu>

# Make Ubuntu most accurate
RUN apt-get update

# Get MySQL 5.6
RUN apt-get -y --force-yes install libaio1 wget
RUN groupadd mysql && useradd -r -g mysql mysql
RUN wget http://cdn.mysql.com/Downloads/MySQL-5.6/mysql-5.6.15-debian6.0-x86_64.deb \
	&& dpkg -i mysql-*.deb
	&& chown -R mysql /opt/mysql/server-5.6
	&& chgrp -R mysql /opt/mysql/server-5.6
RUN /opt/mysql/server-5.6/scripts/mysql_install_db --user=mysql

# Clean system
RUN apt-get autoclean -y
RUN apt-get autoremove -y

ADD _env/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN ln -nfs /opt/mysql/server-5.6/my.cnf /etc/my.cnf

RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/my.cnf

RUN /opt/mysql/server-5.6/bin/mysqld_safe --user=mysql & sleep 10s \
	&& /opt/mysql/server-5.6/bin/mysql -e "GRANT ALL ON *.* to 'root'@'%' IDENTIFIED by 'heslo'; GRANT ALL ON *.* to 'root'@'localhost' IDENTIFIED by 'heslo'; FLUSH PRIVILEGES"

EXPOSE 22 3306

CMD ["/usr/bin/supervisord"]
