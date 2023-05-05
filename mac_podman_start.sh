ln -s /usr/local/bin/podman /usr/local/bin/docker
podman machine init -v $HOME:$HOME
podman machine set --rootful
podman machine start