Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iwr -useb get.scoop.sh | iex

scoop bucket add extras

scoop install git
scoop install neovim
scoop install vim
scoop install vscode

# scoop uninstall scoop
# del .\scoop -Force