Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iwr -useb get.scoop.sh | iex

scoop install git

scoop bucket add extras

scoop install neovim
scoop install vim
scoop install vscode

# scoop uninstall scoop
# del .\scoop -Force