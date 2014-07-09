#!/bin/bash
sudo docker stop test_sshd && sudo docker rm test_sshd
set -e
sudo docker build --rm -t cfpbj ./
sudo docker run -dP --name test_sshd -e "SSH_USERIDS=gh:whitmo lp:johnsca" cfpbj

CMD=$(sudo docker port test_sshd 22 | sed "s/^[\.0]*:\([0-9]*\)/ssh ubuntu@localhost -p \1 -t tmux -S \/tmp\/pair_socket a -t shared/")
echo $CMD
