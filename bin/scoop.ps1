Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iwr -useb get.scoop.sh | iex

scoop install git
scoop install neovim
scoop install vim

scoop bucket add extras
scoop install vscode
scoop install deno
