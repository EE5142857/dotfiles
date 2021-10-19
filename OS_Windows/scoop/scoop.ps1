Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
iwr -useb get.scoop.sh | iex

scoop bucket add extras
scoop bucket add versions

# scoop install git
# scoop uninstall git
scoop install vscode
scoop install universal-ctags
scoop install everything
scoop install googlechrome
scoop install powertoys