#!/bin/bash

set -e

/usr/sbin/sshd -D &
tmux -S /tmp/pair_socket new -s shared &
chown ubuntu:ubuntu /tmp/pair_socket
jobs
echo "<<--- starwipe and out --->>"
