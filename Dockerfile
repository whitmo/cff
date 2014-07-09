# pairssh
#
# VERSION               0.0.1

FROM ubuntu:trusty
MAINTAINER whit morriss "whit.morriss@canonical.com"

RUN apt-get update

RUN apt-get install -y openssh-server
RUN apt-get install -y emacs24 vim git bzr tmux python-dev virtualenvwrapper
RUN apt-get install -y htop
RUN apt-get install -y juju
RUN apt-get install -y -q build-essential autotools-dev automake pkg-config

# # Disables password authentication
RUN sed -i -e 's/^#PasswordAuthentication\syes/PasswordAuthentication no/' /etc/ssh/sshd_config

# pam_loginuid is disabled
RUN sed -i -e 's/^\(session\s\+required\s\+pam_loginuid.so$\)/#\1/' /etc/pam.d/sshd

RUN mkdir -p /opt
RUN mkdir -p /opt/bin


# Install mosh server
RUN apt-get install -y -q mosh

RUN useradd -d /home/ubuntu -m -s /bin/bash -G sudo ubuntu

RUN mkdir -p /home/ubuntu/.ssh
ADD ./keys/whit.pub /home/ubuntu/.ssh/whit.pub
RUN cat /home/ubuntu/.ssh/whit.pub >> /home/ubuntu/.ssh/authorized_keys
RUN chown -R ubuntu:ubuntu /home/ubuntu/.ssh/


RUN mkdir /var/run/sshd
#RUN echo 'ubuntu:screencast' |chpasswd
RUN echo "alias pairup='tmux -S /tmp/pair_socket a -t shared'" >> /home/ubuntu/.bashrc

ADD ./sharedmux.sh /opt/bin/sharedmux.sh

EXPOSE 22 6000
CMD ["bash", "/opt/bin/sharedmux.sh"]
