# .bashrc
# if [ -f ~/.my_bashrc ]; then
#   . ~/.my_bashrc
# fi

# .profile
export DENO_INSTALL="${HOME}/.deno"
export PATH="${DENO_INSTALL}/bin:${PATH}"
export PATH="/usr/local/neovim/bin:${PATH}"

# .bash_aliases
alias jupyter-lab='jupyter-lab --NotebookApp.use_redirect_file=False'
