set -x
curl -L https://fly.io/install.sh | sh
echo 'export FLYCTL_INSTALL="/root/.fly"' >> ~/.bashrc
echo 'export PATH="\$FLYCTL_INSTALL/bin:\$PATH"' >> ~/.bashrc