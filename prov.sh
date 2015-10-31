#!/bin/sh

set -e

PATH="$HOME/usr/local/bin:$PATH"
export MAKE_PATH="$HOME/usr/local/gmtk/include"

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y git python-pip

tar -xzf files.tar.gz

(
  set -e

  cd setup
  make
)
(
  set -e

  cd setup
  make update
)

# Install Python packages
sudo pip install Pygments

# Install Perl packages
cpanm --sudo install HTML::TreeBuilder YAML::XS

# Install Node.js packages
npm install -g http-server
