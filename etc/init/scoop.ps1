Set-ExecutionPolicy RemoteSigned -scope CurrentUser
if (!(Get-Command * | Where-object { $_.Name -match "scoop" })) {
    iwr -useb get.scoop.sh | iex
}

# main
scoop install 7zip
if (!(Get-Command * | Where-object { $_.Name -match "git" })) {
    scoop install git
}

scoop install neovim
scoop install vim
scoop install ripgrep

scoop install postgresql
scoop install r
scoop install nodejs

# nvim-treesitter
scoop install gcc

# solve "scoop checkup" problems
scoop install innounp
scoop install dark

# extras
scoop bucket add extras
scoop install deno
scoop install everything
scoop install plantuml
scoop install vscode
scoop install winmerge

# versions
scoop bucket add versions
scoop install python39

# java
scoop bucket add java
scoop install openjdk

# jetbrains
scoop bucket add jetbrains

# maintenance
scoop update
scoop update *
scoop cleanup *
scoop checkup

pause
