# .bashrc
# if [ -f ~/.my_bashrc ]; then
#   . ~/.my_bashrc
# fi

# .profile
export DENO_INSTALL="${HOME}/.deno"
export PATH="${DENO_INSTALL}/bin:${PATH}"
# export PATH="/usr/local/bin/nvim:${PATH}"

# .bash_aliases
alias pyvm='. ~/work/venv/myenv/bin/activate'
alias jl='jupyter-lab \
--ServerApp.use_redirect_file=False \
--ServerApp.open_browser=True \
--FileCheckpoints.checkpoint_dir=~/my_ipynb_checkpoints'
