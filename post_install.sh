#!/bin/bash

# Executar os comandos abaixo para iniciar o script de postinstall
#
# sudo dnf -y install git && git clone https://github.com/gustavofc/home.git
# bash post_install.sh
#
#

function env_files(){
  mkdir ~/github
  cp -pa ~/home ~/github/
  rm -f ~/.bashrc && ln -s ~/github/home/bashrc ~/.bashrc
  rm -f ~/.bash_aliases &&  ln -s ~/github/home/bash_aliases ~/.bash_aliases
  rm -f ~/.vimrc && ln -s ~/github/home/vimrc ~/.vimrc
  rm -f ~/.vim && ln -s ~/github/home/vim ~/.vim
  rm -f ~/.toprc && ln -s ~/github/home/toprc ~/.toprc
  source ~/github/home/bashrc
}

function install_packages(){
  sudo dnf -y install cups-pdf wget rpm-build vim bind-utils iptraf make gcc \
    git kernel-headers kernel-devel
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall
}

function git_config(){
  git config --global push.default=simple
  git config --global credential.helper cache
}

function terminal_colors(){
# Configuração Gnome-terminal
# http://www.if-not-true-then-false.com/2012/solarized-linux/
  git clone https://github.com/sigurdga/gnome-terminal-colors-solarized.git
  ./gnome-terminal-colors-solarized/install.sh -s dark
  rm -rfv gnome-terminal-colors-solarized
}

function install_cntlm(){
  dnf -y install cntlm
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
  dnf -y install system-config-printer
}

function desktop_config(){
  dnf -y install dconf-editor
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

function install_tor(){
  dnf install tor
  sudo echo "\nHTTPProxy 127.0.0.1:3128
  HTTPSProxy 127.0.0.1:3128" >> /etc/tor/torrc
  sudo systemctl start tor
}

function install_python_pkgs(){
  dnf -y install python-pip python-ipython-console
}

# Main
install_packages
env_files
install_python_pkgs
