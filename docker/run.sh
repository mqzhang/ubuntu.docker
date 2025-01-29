set -x

# docker run -it --entrypoint /bin/bash -d --name mqdev -p3001:3000 -p8001:8888 -v $HOME:/root/home -v $(pwd):/root/workdir quay.io/mqdev/ubuntu
docker run -it -d --restart unless-stopped --name mqdev -p3001:3000 -p8001:8888 -v $HOME:/root/home -v $(pwd):/root/workdir quay.io/mqdev/ubuntu
docker exec -it mqdev bash
