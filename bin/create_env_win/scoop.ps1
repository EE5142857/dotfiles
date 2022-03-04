Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iwr -useb get.scoop.sh | iex

Remove-item $env:USERPROFILE\.gitconfig
scoop install git
scoop install neovim
scoop install vim

mkdir C:\work -Force
cd C:\work
git clone https://github.com/EE5142857/dotfiles

scoop bucket add extras
scoop install vscode

Start-Process C:\work\dotfiles\bin\create_env_win\setup_vim.bat
Start-Process C:\work\dotfiles\bin\create_env_win\setup_vscode.bat

$host.UI.RawUI.ReadKey()
# scoop uninstall scoop
# del .\scoop -Force
