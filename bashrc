# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

if [ -f ~/.bash_aliases ]; then
      . ~/.bash_aliases
fi
if [ -f ~/.ps1_git ]; then
      . ~/.ps1_git
fi

export HISTCONTROL=ignoredups:erasedups # no duplicate entries
export HISTSIZE=100000                  # big big history
export HISTFILESIZE=100000              # big big history
shopt -s histappend                     # append to history, don't overwrite it

# New PS1
PS1="\W \$ "

# linux - git
#if [ -f ~/.ps1_git ]; then
#      . ~/.ps1_git
#fi
source /etc/bash_completion.d/git-prompt.sh
PS1='$(__git_ps1)'$PS1

# kube-ps1
source /etc/bash_completion.d/kube-ps1.sh
PS1='$(kube_ps1)'$PS1

# virtualenvwrapper
export WORKON_HOME=~/envs
source /usr/bin/virtualenvwrapper.sh


# Save and reload the history after each command finishes
#export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

#export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
