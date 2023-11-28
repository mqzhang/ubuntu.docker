    set -x 

    eval "$(~/.rbenv/bin/rbenv init - bash)"
    eval "$(~/.pyenv/bin/pyenv init -)"

    # pip 源
    # https://mirrors.tuna.tsinghua.edu.cn/help/pypi/
    # pip config set global.index-url https://pypi.python.org/simple
    pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

    # https://jupyter.org/install
    pip install -r requirements.txt
    pyenv rehash

    # gem 源
    # https://mirrors.tuna.tsinghua.edu.cn/help/rubygems/
    
    # disable gem document
    echo 'gem: --no-document' >> ~/.gemrc

    # 添加镜像源并移除默认源
    gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/
    # 列出已有源
    gem sources -l
    # gem update --system -N >/dev/null 2>&1

    gem install bundler -N >/dev/null 2>&1
    bundle config mirror.https://rubygems.org https://gems.ruby-china.com

    # https://github.com/SciRuby/iruby
    # gem install iruby pry pycall pandas numpy matplotlib
    bundle install
    rbenv rehash
    iruby register --force


    # npm 
    # https://npmmirror.com/
    npm config set registry https://registry.npmmirror.com
    yarn config set registry https://registry.npmmirror.com