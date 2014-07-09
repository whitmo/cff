#!/bin/bash
sudo docker stop test_sshd && sudo docker rm test_sshd
set -e
sudo docker build --rm -t cfpbj ./
sudo docker run -d -P --name test_sshd -e "SSH_USERIDS='gh:whitmo'" cfpbj
sudo docker port test_sshd 22
