#!/bin/bash

set -e

tmux -S /tmp/pair_socket new -ds shared
chown ubuntu:ubuntu /tmp/pair_socket

/usr/sbin/sshd -D

echo "$SSH_USERIDS" >> /home/ubuntu/wat.txt
if [ -n "$SSH_USERIDS" ]; then
    sudo --user=ubuntu ssh-import-id "$SSH_USERIDS"
fi
