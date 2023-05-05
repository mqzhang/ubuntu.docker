set -x

docker run -it --entrypoint /bin/bash -d --name mqdev -p 3001:3000 -v $HOME:/root/home quay.io/mqdev/ubuntu
docker exec -it mqdev bash
