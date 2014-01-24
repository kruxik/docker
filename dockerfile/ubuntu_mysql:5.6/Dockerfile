FROM krux:5000/ubuntu_base:13.10
MAINTAINER Petr Burian <petr.burian@livesport.eu>

# Add Launchpad MySQL 5.6 to sources list
# PPA link: https://launchpad.net/~ondrej/+archive/mysql-5.6
RUN echo "deb http://ppa.launchpad.net/ondrej/mysql-5.6/ubuntu saucy main" >> /etc/apt/sources.list
RUN echo "deb-src http://ppa.launchpad.net/ondrej/mysql-5.6/ubuntu saucy main" >> /etc/apt/sources.list
RUN add-apt-repository ppa:ondrej/mysql-5.6

# Make Ubuntu most accurate
RUN apt-get update

# Install MySQL 5.6
RUN apt-get install -y mysql-server

# Clean system
RUN apt-get autoclean -y
RUN apt-get autoremove -y

ADD _env/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

RUN /usr/bin/mysqld_safe & sleep 10s && mysql -e "GRANT ALL ON *.* to 'root'@'%' IDENTIFIED by 'heslo'; GRANT ALL ON *.* to 'root'@'localhost' IDENTIFIED by 'heslo'; FLUSH PRIVILEGES"

EXPOSE 3306

CMD ["/usr/bin/supervisord"]
