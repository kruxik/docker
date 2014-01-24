#!/bin/bash

if [ $UID -ne 0 ]; then
	echo "Docker remover needs to be run as a root!"
	echo "Please run script as root or sudo."
	exit 1
fi

echo "Removing stopped containers ..."

docker ps -a | grep "ago[ ]*Exit" | awk '{print $1}' | xargs docker rm

echo "Done!"
