set -x

# docker run -it --entrypoint /bin/bash -d --name mqdev -p3001:3000 -p8001:8888 -v $HOME:/tmp/home -v $(pwd):/tmp/workdir quay.io/mqdev/ubuntu
docker run -it -d --name mqdev -p3001:3000 -p8001:8888 -v $HOME:/tmp/home -v $(pwd):/tmp/workdir quay.io/mqdev/ubuntu
docker exec -it mqdev bash
