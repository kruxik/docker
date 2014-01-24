FROM ORIGIN/ubuntu_base:13.10
MAINTAINER Petr Burian <petr.burian@livesport.eu>

# Add sources of Node.js
RUN add-apt-repository ppa:chris-lea/node.js

# Install latest Node.js 
RUN apt-get install -y --force-yes nodejs npm libfreetype6 libfontconfig1 \
	&& ln -nfs /usr/bin/nodejs /usr/bin/node

# Install base Node.js packages
RUN npm -g install assert coffee-script express mocha phantomjs should socket.io

# Clean system
RUN apt-get autoclean -y
RUN apt-get autoremove -y

# Expose port for node.js (example)
# EXPOSE 80

# RUN SSHD
CMD ["/usr/bin/supervisord"]
