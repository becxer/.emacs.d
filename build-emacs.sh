#!/bin/bash

# Build latest version of Emacs, version management with stow
# OS: Ubuntu 14.04 LTS and newer
# version: 24.5
# Copy from : https://github.com/favadi/build-emacs/blob/master/build-emacs.sh
# Toolkit: lucid

set -eu

readonly version="24.5"

# install dependencies
sudo apt-get update
sudo apt-get install -y stow build-essential libx11-dev xaw3dg-dev \
     libjpeg-dev libpng12-dev libgif-dev libtiff5-dev libncurses5-dev \
     libxft-dev librsvg2-dev libmagickcore-dev libmagick++-dev \
     libxml2-dev libgpm-dev libotf-dev libm17n-dev \
     libgnutls-dev wget

# download source package
if [[ ! -d emacs-"$version" ]]; then
   wget http://ftp.gnu.org/gnu/emacs/emacs-"$version".tar.xz
   tar xvf emacs-"$version".tar.xz
fi

# build and install
sudo mkdir -p /usr/local/stow
cd emacs-"$version"
./configure \
    --with-xft \
    --with-x-toolkit=lucid

make
sudo make \
    install-arch-dep \
    install-arch-indep \
    prefix=/usr/local/stow/emacs-"$version"

cd /usr/local/stow
sudo stow emacs-"$version"
