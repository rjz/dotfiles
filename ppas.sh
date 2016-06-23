# Google Chrome
# Ref: http://tecadmin.net/install-google-chrome-in-ubuntu/
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

# golang
sudo add-apt-repository ppa:ubuntu-lxc/lxd-stable
