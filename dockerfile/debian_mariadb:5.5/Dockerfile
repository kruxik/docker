FROM ORIGIN/debian_base:squeeze
MAINTAINER Petr Burian <petr.burian@livesport.eu>

# Add MariaDB data source
ADD _env/mariadb.list /etc/apt/sources.list.d/mariadb.list
RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db

# Make system most accurate
RUN apt-get update

# Get MariaDB
RUN apt-get -y install mariadb-server

# Clean system
RUN apt-get autoclean -y
RUN apt-get autoremove -y

ADD _env/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

RUN /usr/bin/mysqld_safe --user=mysql & sleep 10s \
	&& /usr/bin/mysql -e "GRANT ALL ON *.* to 'root'@'%' IDENTIFIED by 'heslo'; GRANT ALL ON *.* to 'root'@'localhost' IDENTIFIED by 'heslo'; FLUSH PRIVILEGES"

EXPOSE 22 3306

CMD ["/usr/bin/supervisord"]
