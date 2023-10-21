FROM ubuntu:22.04

# Set the timezone environment variable
ENV TZ=Asia/Shanghai

ENV DEBIAN_FRONTEND noninteractive

# Install the tzdata package and configure the timezone & ca-certificates
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata ca-certificates curl \
    && ln -fs /usr/share/zoneinfo/$TZ /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata

USER root
WORKDIR /tmp

COPY tsinghua.ubuntu.22.04.sources.list .
RUN cat tsinghua.ubuntu.22.04.sources.list > /etc/apt/sources.list

# fly.io
RUN <<EOT bash
    set -x
    curl -L https://fly.io/install.sh | sh
    echo 'export FLYCTL_INSTALL="/root/.fly"' >> ~/.bashrc
    echo 'export PATH="\$FLYCTL_INSTALL/bin:\$PATH"' >> ~/.bashrc
EOT

# apt install
RUN <<EOT bash
    set -x
    apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    apt-utils build-essential autoconf libtool libssl-dev libffi-dev libyaml-dev \
    zlib1g-dev libbz2-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev liblzma-dev libffi-dev libreadline-dev \
    nodejs npm \
    git curl \
    sqlite3 libsqlite3-dev \
    libpq-dev \
    cron sudo \
    screen less vim
EOT

# yarn
RUN npm install --global yarn

# ruby
# https://github.com/rbenv/rbenv
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
RUN git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
ENV PATH ~/.rbenv/bin:$PATH
# RUN ~/.rbenv/plugins/ruby-build/install.sh
RUN echo 'eval "$(~/.rbenv/bin/rbenv init - bash)"' >> ~/.bashrc
RUN ~/.rbenv/bin/rbenv install 3.2.1
RUN ~/.rbenv/bin/rbenv global 3.2.1

# python
RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv
RUN cd ~/.pyenv && src/configure && make -C src
ENV PATH ~/.pyenv/bin:$PATH
# RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
# RUN echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(~/.pyenv/bin/pyenv init -)"' >> ~/.bashrc
RUN ~/.pyenv/bin/pyenv install 3.11.6
RUN ~/.pyenv/bin/pyenv global 3.11.6

# 更换软件源
RUN <<EOT bash
    set -x 
    eval "$(~/.rbenv/bin/rbenv init - bash)"
    eval "$(~/.pyenv/bin/pyenv init -)"

    # pip 源
    # https://mirrors.tuna.tsinghua.edu.cn/help/pypi/
    # pip config set global.index-url https://pypi.python.org/simple
    pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

    # gem 源
    # https://mirrors.tuna.tsinghua.edu.cn/help/rubygems/
    # 添加镜像源并移除默认源
    gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/
    # 列出已有源
    gem sources -l
    # gem update --system -N >/dev/null 2>&1

    # disable gem document
    echo 'gem: --no-document' >> ~/.gemrc

    gem install bundler -N >/dev/null 2>&1
    bundle config mirror.https://rubygems.org https://gems.ruby-china.com
    # bundle install

EOT

# SHELL ["/bin/bash", "-c"]
# WORKDIR /tmp
# COPY . .
# RUN bash init.sh

RUN apt-get clean

EXPOSE 3000

# CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
# CMD ruby -run -ehttpd . -p3000
# ENTRYPOINT ["/bin/bash"]

# Set the entrypoint to a command that does nothing
ENTRYPOINT ["tail", "-f", "/dev/null"]
