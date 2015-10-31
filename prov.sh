#!/bin/sh

set -e

PATH="$HOME/usr/local/bin:$PATH"
export MAKE_PATH="$HOME/usr/local/gmtk/include"

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y git python-pip

# Install Python packages
sudo pip install Pygments

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
