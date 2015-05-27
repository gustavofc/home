# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

if [ -f ~/.bash_aliases ]; then
      . ~/.bash_aliases
fi

export HISTCONTROL=ignoredups:erasedups # no duplicate entries
export HISTSIZE=100000                  # big big history
export HISTFILESIZE=100000              # big big history
shopt -s histappend                     # append to history, don't overwrite it

# Save and reload the history after each command finishes
#export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

#export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# MongoDB bin directory
export PATH="~/treinamento/M101P_MongoDB_for_Developers/mongodb/bin:$PATH"
