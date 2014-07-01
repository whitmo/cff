#!/bin/bash

set -e

tmux -S /tmp/pair_socket new -ds shared
chown ubuntu:ubuntu /tmp/pair_socket

/usr/sbin/sshd -D
