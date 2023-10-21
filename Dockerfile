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
SHELL ["/bin/bash", "-c"]
WORKDIR /tmp

COPY scripts/tsinghua.ubuntu.22.04.sources.list .
RUN cat tsinghua.ubuntu.22.04.sources.list > /etc/apt/sources.list

# fly.io
RUN curl -L https://fly.io/install.sh | sh
RUN echo 'export FLYCTL_INSTALL="/root/.fly"' >> ~/.bashrc
RUN echo 'export PATH="\$FLYCTL_INSTALL/bin:\$PATH"' >> ~/.bashrc

# apt install
COPY scripts/basic_apt_install.sh .
RUN bash basic_apt_install.sh
# RUN <<EOT bash
#     set -x
#     apt-get update --yes && \
#     apt-get install --yes --no-install-recommends \
#     apt-utils build-essential autoconf libtool libssl-dev libffi-dev libyaml-dev \
#     zlib1g-dev libbz2-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev liblzma-dev libffi-dev libreadline-dev \
#     nodejs npm \
#     git curl \
#     sqlite3 libsqlite3-dev \
#     libpq-dev \
#     cron sudo \
#     screen less vim
# EOT

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

# python 和 ruby 基础环境配置
COPY scripts/requirements.txt .

COPY scripts/pyrb_setup.sh .
RUN bash pyrb_setup.sh
# RUN <<EOT bash
#     set -x 
#     eval "$(~/.rbenv/bin/rbenv init - bash)"
#     eval "$(~/.pyenv/bin/pyenv init -)"

#     # pip 源
#     # https://mirrors.tuna.tsinghua.edu.cn/help/pypi/
#     # pip config set global.index-url https://pypi.python.org/simple
#     pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

#     # https://jupyter.org/install
#     pip install -r requirements.txt

#     # gem 源
#     # https://mirrors.tuna.tsinghua.edu.cn/help/rubygems/
    
#     # disable gem document
#     echo 'gem: --no-document' >> ~/.gemrc

#     # 添加镜像源并移除默认源
#     gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/
#     # 列出已有源
#     gem sources -l
#     # gem update --system -N >/dev/null 2>&1

#     gem install bundler -N >/dev/null 2>&1
#     bundle config mirror.https://rubygems.org https://gems.ruby-china.com
#     # bundle install

#     # https://github.com/SciRuby/iruby
#     gem install iruby pry pycall pandas numpy matplotlib
#     iruby register --force

# EOT

# jupyter
RUN mkdir /root/.jupyter
COPY jupyter/jupyter_lab_config.py /root/.jupyter/

RUN apt-get clean

EXPOSE 3000
EXPOSE 8888

WORKDIR /root
# CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
# CMD ruby -run -ehttpd . -p3000
# ENTRYPOINT ["/bin/bash"]
# Set the entrypoint to a command that does nothing
# ENTRYPOINT ["tail", "-f", "/dev/null"]
COPY jupyter/start_jupyter.sh .
ENTRYPOINT ["bash", "/root/start_jupyter.sh"]
