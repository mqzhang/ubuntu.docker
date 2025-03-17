
sudo apt-get update -qq

# 安装必要的依赖项
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

# 添加 Docker 的 APT 密钥
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# 添加 Docker 的 APT 源
sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# 更新 apt 软件包列表
sudo apt-get update -qq

# 安装 Docker 客户端
sudo apt-get install -y docker-ce-cli
