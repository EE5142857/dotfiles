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
