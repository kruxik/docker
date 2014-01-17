FROM stackbrew/debian:squeeze
MAINTAINER Petr Burian <petr.burian@livesport.eu>

# Basic environtment
ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive

# Set UTF-8 locales
RUN apt-get install -y --force-yes locales ncurses-term apt-utils
RUN sed -ri 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen && locale-gen

# Update Debian system
RUN apt-get update
RUN apt-get -y dist-upgrade

# Install basic software
RUN apt-get install -y --force-yes psmisc openssh-server vim bash-completion supervisor git

# Clean system
RUN apt-get autoclean -y
RUN apt-get autoremove -y

# Add necessary files
ADD _env/.bashrc /root/.bashrc
ADD _env/.bash_aliases /root/.bash_aliases
ADD _env/.bash_functions /root/.bash_functions
ADD _env/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD _env/.vim /root/.vim
ADD _env/.vim-backup /root/.vim-backup
ADD _env/.vimrc /root/.vimrc

# Change root password
RUN echo "heslo\nheslo" | passwd root

# Create SSH separation directory
RUN mkdir -p /var/run/sshd
RUN mkdir -p /var/log/supervisor

# Update SSHD config
RUN sed -ri 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

# Expose the SSH port
EXPOSE 22

# RUN SSHD
CMD ["/usr/bin/supervisord"]
