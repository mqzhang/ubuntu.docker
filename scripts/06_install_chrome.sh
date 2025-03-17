set -x


sudo apt-get update -qq

# 安装必要的依赖项
sudo apt-get install -y wget gnupg ca-certificates apt-transport-https

# 下载 Google Chrome 的 APT 密钥
sudo wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg

# 添加 Google Chrome 的 APT 源
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'

# 更新 APT 软件包列表
sudo apt-get update -qq

# 安装 Google Chrome 浏览器
sudo apt-get install -y google-chrome-stable

# 可选：安装 xvfb (用于无头模式)
sudo apt-get install -y xvfb
