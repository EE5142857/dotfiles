#!/bin/bash
# .bashrc
# if [ -f ~/.my_bashrc ]; then
#   . ~/.my_bashrc
# fi

# PATH
export DENO_INSTALL="${HOME}/.deno"
export PATH="${DENO_INSTALL}/bin:${PATH}"
# export PATH="/usr/local/bin/nvim:${PATH}"

# editor
export EDITOR=vim
set -o vi

# .bash_aliases
alias pyvm='. ~/work/venv/myenv/bin/activate'
alias jl='jupyter-lab --no-browser \
--ServerApp.use_redirect_file=False \
--FileCheckpoints.checkpoint_dir=~/my_ipynb_checkpoints'

# display git branch
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi
if [ -f /etc/bash_completion.d/git-prompt ]; then
  export PS1='\[\033[01;32m\]\u@\h\[\033[01;33m\] \w$(__git_ps1) \n\[\033[01;34m\]\$\[\033[00m\] '
else
  export PS1='\[\033[01;32m\]\u@\h\[\033[01;33m\] \w \n\[\033[01;34m\]\$\[\033[00m\] '
fi
