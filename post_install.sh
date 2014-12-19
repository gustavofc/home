#!/bin/bash

function download_home_files(){
  mkdir ~/github
  git clone https://github.com/gustavofc/home.git ~/github/home
  ln -s github/home/.bashrc 
  ln -s github/home/.bash_aliases 
  ln -s github/home/.vimrc
  ln -s github/home/.vim
  ln -s github/home/.toprc
}

function install_powerlines_fonts(){
  git clone https://github.com/powerline/fonts.git
  ./fonts/install.sh
}



# Main
download_home_files
install_powerlines_fonts
