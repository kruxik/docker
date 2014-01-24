FROM ORIGIN/debian_base:squeeze
MAINTAINER Petr Burian <petr.burian@livesport.eu>

# Add xTraDB data source
ADD _env/xtradb.list /etc/apt/sources.list.d/xtradb.list
RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A

# Make system most accurate
RUN apt-get update

# Get MariaDB
RUN apt-get -y install percona-server-server-5.6 percona-server-client-5.6

# Clean system
RUN apt-get autoclean -y
RUN apt-get autoremove -y

ADD _env/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD _env/my.cnf /etc/mysql/my.cnf
RUN mkdir -p /etc/mysql/conf.d

RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

RUN /usr/bin/mysqld_safe --user=mysql & sleep 10s \
	&& /usr/bin/mysql -e "GRANT ALL ON *.* to 'root'@'%' IDENTIFIED by 'heslo'; GRANT ALL ON *.* to 'root'@'localhost' IDENTIFIED by 'heslo'; FLUSH PRIVILEGES"

EXPOSE 22 3306

CMD ["/usr/bin/supervisord"]
