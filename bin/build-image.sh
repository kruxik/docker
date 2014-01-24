#!/bin/bash
# build-image.sh

# help usage
usage()
{
	cat << EOF
	usage: $0 [OPTIONS] IMAGE_NAME [DOCKER_SERVER]

	This script builds a Docker image from Dockerfile definition

	OPTIONS:
	  -h		Show help/usage
	  -u		User or Repo server (e.g. 'krux' for user or 'krux:5000' for repo server)
	  -l		List all available Dockerfiles
EOF
}

SCRIPT=$(readlink -nf "$0")
SCRIPT_DIR=`dirname $SCRIPT`
DOCKERFILE_ROOT="$SCRIPT_DIR/../dockerfile"
USER=""
LIST=0

# parse option arguments
while getopts "lu:" OPTION
do
	case $OPTION in
	l)
		LIST=1
		;;
	u)
		USER="$OPTARG"
		;;
	?)
		usage
		exit 1
		;;
	esac
done

# decrease argument pointer so it points to first non-option argument
shift $(($OPTIND - 1))

if [ ! -d $DOCKERFILE_ROOT ]; then
	echo "No dockerfile directory found! Please fetch/pull the whole repo from Github first."
	exit 1
fi

IMAGE=$1

# List all Dockerfile directories
if [ $LIST -eq 1 ]; then
	ls $DOCKERFILE_ROOT
	exit 0
fi

if [ $UID -ne 0 ]; then
	echo "Docker build needs to be run as a root!"
	echo "Please run script as root or sudo."
	exit 1
fi

if [ ! `which docker` ]; then
	echo "Error: No Docker installed! Please install Docker first."
	exit 1
fi

if [ ! -f $DOCKERFILE_ROOT/$IMAGE/Dockerfile ]; then
	echo "Error: Dockerfile '$DOCKERFILE_ROOT/$IMAGE/Dockerfile' not found!"
	exit 1
fi

IMAGE_DIR="$DOCKERFILE_ROOT/$IMAGE"
BUILD_DIR="$IMAGE_DIR/build"

if [ "$USER" == "" ]; then
	IMAGE_NAME="$IMAGE"
	ORIGIN=""
else
	IMAGE_NAME="$USER/$IMAGE"
	ORIGIN="$USER\/"
fi

if [ -d $BUILD_DIR ]; then
	rm -rf $BUILD_DIR
fi

if [ ! -d $BUILD_DIR ]; then
	mkdir $BUILD_DIR
fi

cp -a $IMAGE_DIR/Dockerfile $BUILD_DIR/
cp -a $SCRIPT_DIR/../_env $BUILD_DIR/

if [ -d $IMAGE_DIR/_env ]; then
	shopt -s dotglob # consider dot files
	cp -a $IMAGE_DIR/_env/* $BUILD_DIR/_env
fi

(cd $BUILD_DIR \
	&& echo "Building '$IMAGE_NAME' ..." \
	&& sed -i -e "s/FROM[ ]*ORIGIN\//FROM $ORIGIN/" Dockerfile \
	&& time docker build -t $IMAGE_NAME . \
	&& cd ../ \
	&& rm -rf $BUILD_DIR \
	&& echo "Building done sucessfully :-)") || echo "Building failed :-("
