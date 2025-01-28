eval "$(mise activate bash)"

pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
pip install -r requirements.txt

echo 'gem: --no-document' >> ~/.gemrc
gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/
bundle config mirror.https://rubygems.org https://gems.ruby-china.com
bundle install
iruby register --force


npm config set registry https://registry.npmmirror.com
npm install --global yarn
yarn config set registry https://registry.npmmirror.com

