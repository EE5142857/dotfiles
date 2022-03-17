Set-ExecutionPolicy RemoteSigned -scope CurrentUser
if (!(Get-Command * | Where-object { $_.Name -match "scoop" })) {
    iwr -useb get.scoop.sh | iex
}

# main
scoop install 7zip
scoop install git
scoop install neovim
scoop install vim
scoop install busybox
scoop install ctags
scoop install postgresql
scoop install r

# solve "scoop checkup" problems
scoop install innounp
scoop install dark

# extras
scoop bucket add extras
scoop install deno
scoop install everything
scoop install vscode
scoop install winmerge

# versions
scoop bucket add versions
scoop install python39

# jetbrains
scoop bucket add jetbrains

# maintenance
scoop update
scoop update *
scoop cleanup *
scoop checkup

pause
