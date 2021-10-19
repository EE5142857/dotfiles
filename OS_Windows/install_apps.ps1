# Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iwr -useb get.scoop.sh | iex

scoop install git

scoop bucket add extras
scoop bucket add versions

scoop install vim
scoop install universal-ctags
scoop install everything