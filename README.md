# ubuntu.docker

Ubuntu Dev enviroment on docker.

Base image: [ubuntu:24.04](https://hub.docker.com/_/ubuntu).


## Quay.io
https://quay.io/repository/mqdev/ubuntu


Pull this container with the following Docker command:
```bash
docker pull quay.io/mqdev/ubuntu
```

Buid this image in local with the following command:
```bash
sh docker/build.sh
```

Run this image with the following command, this command will expose port 3001 to 3000, and 8001 to 8888 (runs the jupyter service) :
```bash
sh docker/run.sh
```

Stop and delete the container with the following command:
```bash
sh docker/stop.sh
```


## Installed packages
### python, pip
Using `mise` with latest installed.
Changed default pip source to https://mirrors.tuna.tsinghua.edu.cn/help/pypi/ .
Installed pip packages listed here: https://github.com/mqzhang/ubuntu.docker/blob/main/scripts/requirements.txt

### ruby, gem
Using `mise` with 3.3 installed.
Changed default rubygem source to https://gems.ruby-china.com/ .
Installed gems listed here: https://github.com/mqzhang/ubuntu.docker/blob/main/scripts/Gemfile

### jupyter
Entrypoint will start the jupyter lab service by default. Exposed to port 8888. With iruby and pycall installed, which can be used to run ruby in jupyter and call python models.

### other packages
* node npm yarn
* git
* sqlite
* vim
* emacs


