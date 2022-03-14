


# Credits to https://askubuntu.com/a/1286743/1106531
# It should work unti 2023


cat <<EOF | sudo tee /etc/apt/sources.list.d/bionic-updates.list
# for deb-based chromium. Supported only 'til 2023
# see also /etc/apt/preferences.d/chromium-deb-bionic-updates
deb http://archive.ubuntu.com/ubuntu/ bionic-updates universe
EOF

cat <<EOF | sudo tee /etc/apt/preferences.d/chromium-deb-bionic-updates
Package: chromium-browser chromium-browser-l10n chromium-codecs-ffmpeg-extra chromium-codecs-ffmpeg
Pin: release a=bionic-updates
Pin-Priority: 900
EOF

sudo apt update
sudo apt install chromium-browser

