Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iwr -useb get.scoop.sh | iex

scoop install git
scoop install neovim
scoop install vim

scoop bucket add extras
scoop install vscode

Remove-item $env:USERPROFILE\.gitconfig
mkdir C:\work -Force
cd C:\work
git clone https://github.com/EE5142857/dotfiles

Start-Process C:\work\dotfiles\bin\setup.bat

# scoop uninstall scoop
# del .\scoop -Force
# $host.UI.RawUI.ReadKey()
