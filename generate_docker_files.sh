#!/bin/bash -e  # exit immediately if a command exits with a non-zero status
set -x  # echo all executed commands

# this script is used to generate a basic Dockerfile and docker scripts including build/run/stop for a new project folder.
# parameters:
#     $1: path to project
#     $2: docker image name and container name
#     $3: port

project_path=$1
image_name=${2:-$(basename $project_path)}
#if $3 is not set, use default port 3000
port=${3:-3000}

cd $project_path

cat > Dockerfile <<EOF
# https://github.com/mqzhang/ubuntu.docker
FROM quay.io/mqdev/ubuntu

USER root
WORKDIR /tmp/$image_name
COPY . .
RUN ls
EXPOSE $port

ENTRYPOINT ["tail", "-f", "/dev/null"]
EOF

mkdir docker

cat > docker/build.sh <<EOF
set -x
docker build -t $image_name .
EOF

cat > docker/run.sh <<EOF
set -x
docker run -it -d --restart unless-stopped --name $image_name -p $port:$port -v \$HOME:/root/home $image_name
docker exec -it $image_name bash
EOF

cat > docker/stop.sh <<EOF
set -x
docker stop $image_name
docker rm $image_name
EOF