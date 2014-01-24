FROM ORIGIN/ubuntu_base:13.10
MAINTAINER Petr Burian <petr.burian@livesport.eu>

# Install necessary software
RUN apt-get -y install python-pip python-dev liblzma-dev libevent-dev libssl-dev

# Install Docker Registry from GIT
RUN mkdir -p /opt/docker-registry \
	&& git clone https://github.com/dotcloud/docker-registry.git /opt/docker-registry \
	&& cd /opt/docker-registry \
	&& cp -a config/config_sample.yml config/config.yml \
	&& mkdir -p /data/docker-registry

# Configure Docker Registry
RUN cd /opt/docker-registry \
	&& pip install -r requirements.txt

# Update Docker Registry config file
RUN sed -i -e"s/storage_path:.*/storage_path: \/data\/docker-registry/" /opt/docker-registry/config/config.yml

# Add necessary files
ADD _env/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose the SSH port
EXPOSE 5000

# RUN SSHD
CMD ["/usr/bin/supervisord"]
