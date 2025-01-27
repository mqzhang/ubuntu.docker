cat tsinghua.ubuntu.24.04.sources.list > /etc/apt/sources.list.d/ubuntu.sources

export TZ=Asia/Shanghai
export DEBIAN_FRONTEND noninteractive

# Install the tzdata package and configure the timezone & ca-certificates
apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt install -y tzdata ca-certificates curl sudo \
    && ln -fs /usr/share/zoneinfo/$TZ /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata