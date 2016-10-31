#!/bin/bash

# Start mariadb basic container
docker run -d -p 3306:3306 --name mariadb aabbate/mariadb 

# Copy the init script, sql and schemas inside the container
docker cp ./init.sh mariadb:/init.sh 
docker cp ./install.sql mariadb:/install.sql 
docker cp ./schemas mariadb:/schemas

# Init morgue db
docker exec mariadb "/init.sh"

# Push the base container to aabbate/morguedb
if docker ps -a | grep -q mariadb ; then
	docker commit -p mariadb aabbate/morguedb
    docker push aabbate/morguedb
fi
