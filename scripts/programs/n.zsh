#!/bin/bash

# Node manager n: https://github.com/tj/n


curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o n
sudo bash n lts
# Now node and npm are available
npm install -g n

