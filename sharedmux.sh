#!/bin/bash

set -e

tmux -S /tmp/pair_socket new -ds shared
chown ubuntu:ubuntu /tmp/pair_socket

if [ -n $SSH_USERIDS ]
then
    sudo --user=ubuntu ssh-import-id $SSH_USERIDS
fi

/usr/sbin/sshd -D
