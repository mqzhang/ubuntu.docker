set -x

# apt-get update --yes && \
#     apt-get install --yes --no-install-recommends \
#     ca-certificates

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
    apt-utils build-essential autoconf libtool libssl-dev libffi-dev libyaml-dev \
    zlib1g-dev libbz2-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev liblzma-dev libffi-dev libreadline-dev \
    nodejs npm \
    git curl \
    sqlite3 libsqlite3-dev \
    libpq-dev \
    cron \
    screen less vim # && \
    # apt-get clean && rm -rf /var/lib/apt/lists/*

    # nodejs npm \
    # ruby-full \
    # python3 python3-pip python3-dev \

# python pip

# pyenv
# https://github.com/pyenv/pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
cd ~/.pyenv && src/configure && make -C src
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
export PATH="~/.pyenv/bin:$PATH"
. ~/.bashrc
pyenv install 3.11.6
pyenv global 3.11.6

# https://mirrors.tuna.tsinghua.edu.cn/help/pypi/
# pip config set global.index-url https://pypi.python.org/simple
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
# ln -s /usr/bin/python3 /usr/local/bin/python 
# pip3 --no-cache-dir install --upgrade pip 
# pip install -r requirements.txt

# Ruby 
# rbenv
# https://github.com/rbenv/rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
# git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

export PATH="~/.rbenv/bin:$PATH"
# Run ruby-build install script
. ~/.rbenv/plugins/ruby-build/install.sh
# Set PATH environment variable


echo 'eval "$(~/.rbenv/bin/rbenv init - bash)"' >> ~/.bashrc
# cat >> ~/.bashrc << EOF
# eval "\$(rbenv init -)"
# EOF
. ~/.bashrc

rbenv install 3.2.1
rbenv global 3.2.1


# https://mirrors.tuna.tsinghua.edu.cn/help/rubygems/
# 添加镜像源并移除默认源
gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/
# 列出已有源
gem sources -l
# gem update --system -N >/dev/null 2>&1
gem install bundler -N >/dev/null 2>&1
bundle config mirror.https://rubygems.org https://gems.ruby-china.com
# bundle install


# nodejs npm yarn
npm install --global yarn
yarn --version


# # fly.io
# curl -L https://fly.io/install.sh | sh
# cat >> ~/.bashrc << EOF
# export FLYCTL_INSTALL="~/.fly"
# export PATH="\$FLYCTL_INSTALL/bin:\$PATH"
# EOF