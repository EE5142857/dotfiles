Set-ExecutionPolicy RemoteSigned -scope CurrentUser
if (!(Get-Command * | Where-object { $_.Name -match "scoop" })) {
    iwr -useb get.scoop.sh | iex
}

# main
scoop install 7zip
scoop install git
scoop install dark
scoop install innounp

scoop install gcc
scoop install neovim
scoop install nodejs
scoop install r
scoop install ripgrep

# extras
scoop bucket add extras
scoop install anaconda3
scoop install deno
scoop install everything
scoop install googlechrome
scoop install plantuml
scoop install vscode
scoop install winmerge

# versions
scoop bucket add versions
scoop install python39

# java
scoop bucket add java
scoop install openjdk

# reset
scoop reset python39

# maintenance
scoop update
scoop update *
scoop cache rm *
scoop cleanup *
scoop checkup

pause
