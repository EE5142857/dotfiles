Set-ExecutionPolicy RemoteSigned -scope CurrentUser
if (!(Get-Command * | Where-object { $_.Name -match "scoop" })) {
    iwr -useb get.scoop.sh | iex
}

# main
scoop install 7zip
scoop install git

scoop install neovim
scoop install ripgrep
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
scoop install googlechrome

# versions
scoop bucket add versions
scoop install python39

# java
scoop bucket add java
scoop install openjdk

# maintenance
scoop update
scoop update *
scoop cleanup *
scoop checkup

pause