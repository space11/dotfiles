#!/bin/bash

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb

sudo apt install /tmp/google-chrome-stable_current_amd64.deb

rm /tmp/google-chrome-stable_current_amd64.deb

