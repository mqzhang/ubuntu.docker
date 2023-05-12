set -x

apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    ca-certificates

# 使用清华源 for ubuntu 22.04 jammy 
# https://mirror.tuna.tsinghua.edu.cn/help/ubuntu/
cat > /etc/apt/sources.list << EOF
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse

# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-security main restricted universe multiverse
# # deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-security main restricted universe multiverse

deb http://security.ubuntu.com/ubuntu/ jammy-security main restricted universe multiverse
# deb-src http://security.ubuntu.com/ubuntu/ jammy-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-proposed main restricted universe multiverse
# # deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-proposed main restricted universe multiverse
EOF

apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    apt-utils build-essential autoconf libtool libssl-dev libffi-dev  \
    python3 python3-pip python3-dev \
    ruby-full \
    git curl \
    sqlite3 libsqlite3-dev \
    libpq-dev \
    cron \
    screen less # && \
    # apt-get clean && rm -rf /var/lib/apt/lists/*

    # nodejs npm \

# python pip
# https://mirrors.tuna.tsinghua.edu.cn/help/pypi/
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
ln -s /usr/bin/python3 /usr/local/bin/python 
pip3 --no-cache-dir install --upgrade pip 
# pip install -r requirements.txt

# Ruby gems 
# https://mirrors.tuna.tsinghua.edu.cn/help/rubygems/
# 添加镜像源并移除默认源
gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/
# 列出已有源
gem sources -l
# echo installing current RubyGems
# gem update --system -N >/dev/null 2>&1
gem install bundler -N >/dev/null 2>&1
bundle config mirror.https://rubygems.org https://gems.ruby-china.com
# bundle install

# # nodejs npm yarn
# npm install --global yarn
# yarn --version