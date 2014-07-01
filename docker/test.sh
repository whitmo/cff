sudo docker stop test_sshd && sudo docker rm test_sshd
set -e
sudo docker build --rm -t cfpbj ./
sudo docker run -d -P --name test_sshd cfpbj
sudo docker port test_sshd 22
