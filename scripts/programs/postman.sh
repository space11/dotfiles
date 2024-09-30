# This script basically automates the official Postman installation guide for Linux:
# https://learning.postman.com/docs/getting-started/installation-and-updates/#installing-postman-on-linux

# 32 or 64-bit?
BIT=$(getconf LONG_BIT)

# Download the appropriate version
wget -O ~/postman.tar.gz "https://dl.pstmn.io/download/latest/linux${BIT}"

# Extract the archive in /opt
sudo tar xvf ~/postman.tar.gz -C /opt/

# Remove the downloaded archive
rm ~/postman.tar.gz

# Make the app accessible from a launcher icon 
echo "[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=/opt/Postman/app/Postman %U
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;" >> ~/.local/share/applications/Postman.desktop

