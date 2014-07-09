#!/bin/bash
set -e

tmux -S /tmp/pair_socket new -ds shared
chown ubuntu:ubuntu /tmp/pair_socket

if [ -n "$SSH_USERIDS" ]; then
    CMD="ssh-import-id -o /home/ubuntu/.ssh/authorized_keys $SSH_USERIDS"
    $CMD
fi

/usr/sbin/sshd -D
