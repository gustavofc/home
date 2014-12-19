#!/bin/bash

function install_powerlines_fonts(){
  git clone https://github.com/powerline/fonts.git
  ./fonts/install.sh
}

# Main
install_powerlines_fonts
