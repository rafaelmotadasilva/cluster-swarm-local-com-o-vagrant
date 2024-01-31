#!/bin/bash
sudo docker swarm init --advertise-addr=172.16.10.100
sudo docker swarm join-token worker | grep docker > /vagrant/worker.sh
sudo docker service create \
  --name=viz \
  --publish=5000:8080/tcp \
  --constraint=node.role==manager \
  --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
  dockersamples/visualizer
