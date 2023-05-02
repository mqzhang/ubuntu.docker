docker run -d --name mqdev -p 3000:3000 -v $HOME:/root/home quay.io/mqdev/ubuntu
docker exec -it mqdev bash
