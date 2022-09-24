#!/bin/bash

# https://github.com/chubin/cheat.sh
# Install globalky for all users
curl -s https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh && sudo chmod +x /usr/local/bin/cht.sh

# Enable auto-completition for cheat.sh
mkdir ~/.bash.d
curl https://cheat.sh/:bash_completion > ~/.bash.d/cht.sh
echo ". ~/.bash.d/cht.sh" >> ~/.bashrc
