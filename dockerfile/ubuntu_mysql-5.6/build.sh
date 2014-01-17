#!/bin/bash

if [ $UID -ne 0 ]; then
	echo "Docker build needs to be run as a root!"
	echo "Please run script as root or sudo."
	exit 1
fi

if [ ! `which docker` ]; then
	echo "Error: No Docker installed! Please install Docker first."
	exit 1
fi

if [ ! -f ./Dockerfile ]; then
	echo "Error: No Dockerfile found!"
	exit 1
fi

if [ "$1" == "" ]; then
	echo "Error: No image name provided! Please provide image name first."
	exit 1
fi

BUILD_DIR="./build"
IMAGE_NAME=$1

if [ -d $BUILD_DIR ]; then
	rm -rf $BUILD_DIR
fi

if [ ! -d $BUILD_DIR ]; then
	mkdir $BUILD_DIR
fi

cp -a ./Dockerfile $BUILD_DIR/
cp -a ../_env $BUILD_DIR/

if [ -d ./_env ]; then
	shopt -s dotglob # consider dot files
	cp -a ./_env/* $BUILD_DIR/_env
fi

cd $BUILD_DIR \
	&& time docker build -t $IMAGE_NAME . \
	&& cd ../ \
	&& rm -rf $BUILD_DIR
