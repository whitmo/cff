# sshd
#
# VERSION               0.0.1

FROM     ubuntu:trusty
MAINTAINER whit morriss "whit.morriss@canonical.com"

# make sure the package repository is up to date
RUN apt-get update

RUN apt-get install -y openssh-server
RUN apt-get install -y emacs24 vim git bzr tmux python-dev virtualenvwrapper
RUN apt-get install -y htop
RUN apt-get install -y -q build-essential autotools-dev automake pkg-config

# # Disables password authentication
# RUN sed -i -e 's/^#PasswordAuthentication\syes/PasswordAuthentication no/' /etc/ssh/sshd_config

# pam_loginuid is disabled
RUN sed -i -e 's/^\(session\s\+required\s\+pam_loginuid.so$\)/#\1/' /etc/pam.d/sshd

# Install mosh server
RUN apt-get install -y -q mosh

RUN mkdir /var/run/sshd
RUN echo 'root:screencast' |chpasswd

EXPOSE 22 6000
CMD    ["/usr/sbin/sshd", "-D"]
