#!/bin/bash

# ZSH
sudo apt install -y zsh

# Switch the default shell for the user
chsh -s $(which zsh)

# Oh-My-ZSH
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

