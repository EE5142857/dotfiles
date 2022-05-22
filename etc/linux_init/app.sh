#!/bin/bash
set -euo pipefail
cd `dirname $0`
sudo apt -y update
sudo apt -y upgrade

# PlantUML
# https://blog.katsubemakito.net/articles/install_plantuml_for_ubuntu
# sudo apt -y install default-jdk
# sudo apt -y install graphviz
# sudo apt -y install fonts-ipafont fonts-ipaexfont
sudo apt -y install plantuml

# mermaid
sudo apt -y install nodejs
sudo apt -y install npm
cd ~
npm install @mermaid.cli
# ./node_modules/.bin/mmdc -h
