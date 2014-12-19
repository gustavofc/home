#!/bin/bash

function download_home_files(){
  mkdir ~/github
  git clone https://github.com/gustavofc/home.git ~/github/home
  ln -s github/home/.bashrc
  ln -s github/home/.bash_aliases
  ln -s github/home/.vimrc
  ln -s github/home/.vim
  ln -s github/home/.toprc
  source github/home/.bashrc
}

function install_packages(){
  yum -y install cups-pdf wget rpm-build vim bind-utils iptraf make gcc git
}

function terminal_colors(){
# Configuração Gnome-terminal
# http://www.if-not-true-then-false.com/2012/solarized-linux/
  git clone https://github.com/sigurdga/gnome-terminal-colors-solarized.git
  ./gnome-terminal-colors-solarized/install.sh -s dark
  rm -rfv gnome-terminal-colors-solarized
}

function install_cntlm(){
  yum -y install cntlm
  mv /etc/cntlm.conf{,.bkp}
  cat << EOF >> /etc/cntlm.conf
  Username        u013621
  PassLM          BB1031E9B546DE35552C4BCA4AEBFB11
  PassNT          CD1278424A023A1634577AB8C897E72B
  PassNTLMv2      8C7D08FE645BD07F755F8B2340AF3935    # Only for user 'u013621', domain ''
  Proxy           proxy3.tst.jus.br:3128
  Listen          3128
EOF
}

function printers(){
  yum -y install system-config-printer
}

function desktop_config(){
  yum -y install dconf-editor
  gsettings set org.gnome.desktop.interface clock-show-seconds true
  gsettings set org.gnome.desktop.interface clock-show-date true
  gsettings set org.gnome.desktop.session idle-delay 180
  gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down '<Alt>KP_Subtract'
  gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up '<Alt>KP_Add'
  gsettings set org.gnome.settings-daemon.plugins.media-keys pause '<Alt>KP_Divide'
  gsettings set org.gnome.settings-daemon.plugins.media-keys play '<Alt>KP_Multiply'
  gsettings set org.gnome.shell.window-switcher current-workspace-only false
  gsettings set org.gnome.shell.overrides dynamic-workspaces false
  gsettings set org.gnome.shell.overrides workspaces-only-on-primary false
}

function install_powerlines_fonts(){
  git clone https://github.com/powerline/fonts.git
  ./fonts/install.sh
}



# Main
download_home_files
install_powerlines_fonts
