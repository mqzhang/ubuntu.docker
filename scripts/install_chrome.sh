set -x

# apt install curl software-properties-common apt-transport-https ca-certificates -y
# curl -fSsL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /usr/share/keyrings/google-chrome.gpg > /dev/null
# echo deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main | sudo tee /etc/apt/sources.list.d/google-chrome.list
# apt update
# apt install google-chrome-stable


# https://askubuntu.com/questions/250773/how-do-i-install-chromium-from-the-command-line
# download and install:
cd /tmp
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb; sudo apt-get -f install
cd - 