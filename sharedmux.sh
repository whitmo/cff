#!/bin/bash

set -e

tmux -S /tmp/pair_socket new -ds shared
chown ubuntu:ubuntu /tmp/pair_socket

echo "$SSH_USERIDS" >> /home/ubuntu/wat.txt
if [ -n "$SSH_USERIDS" ]; then
    ssh-import-id -o /home/ubuntu/.ssh/authorized_keys "$SSH_USERIDS"
fi

/usr/sbin/sshd -D
