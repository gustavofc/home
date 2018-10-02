#!/bin/bash

# Executar os comandos abaixo para iniciar o script de postinstall
#
# wget https://raw.githubusercontent.com/gustavofc/home/master/post_install.sh
#

function env_files(){
  mkdir ~/github
  git clone https://github.com/gustavofc/home.git ~/github/home
  ln -s -f github/home/bashrc ~/.bashrc
  ln -s -f github/home/bash_aliases ~/.bash_aliases
  ln -s -f github/home/vimrc ~/.vimrc
  ln -s -f github/home/vim ~/.vim
  ln -s -f github/home/toprc ~/.toprc
  ln -s -f github/home/gitconfig ~/.gitconfig
  source ~/github/home/bashrc
}

function install_packages(){
  su - root -c "dnf -y install cups-pdf wget rpm-build vim bind-utils iptraf\
    make gcc git kernel-headers kernel-devel"
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

function install_powerlines_fonts(){
  git clone https://github.com/powerline/fonts.git ~/github/fonts
  ./github/fonts/install.sh
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
install_powerlines_fonts
