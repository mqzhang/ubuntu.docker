mise use --global ruby@3.3
mise x ruby -- gem install rails --no-document
echo 'gem: --no-document' >> ~/.gemrc
gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/
bundle config mirror.https://rubygems.org https://gems.ruby-china.com

mise use --global node@lts
npm config set registry https://registry.npmmirror.com
npm install --global yarn
yarn config set registry https://registry.npmmirror.com

mise use --global python@latest
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
pip install -r requirements.txt