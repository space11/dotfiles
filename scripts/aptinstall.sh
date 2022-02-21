#!/bin/bash

sudo apt update

function install  {
	which $1 &> /dev/null

	if [ $? -ne 0 ]; then
		echo "Installing ${1}..."
		sudo apt install -y $1
	else
		echo "Alredy installed: ${1}"
	fi
}

# Basics
install curl
install git
install htop
install vim
isttall build-essential
install blueman
install pavucontrol
install terminator
install fzf # zsh history
install gnome-tweaks
install gnome-shell-extension-draw-on-your-screen
install fd-find  # find replacement
instrall gromit-mpx # Draw on Screen

echo "Bye."
