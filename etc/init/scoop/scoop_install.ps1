Set-ExecutionPolicy RemoteSigned -scope CurrentUser
if (!(Get-Command * | Where-object {$_.Name -match "scoop"})) {
    iwr -useb get.scoop.sh | iex
}

# main
scoop install 7zip
# scoop install deno
scoop install ripgrep

# extras
scoop bucket add extras
# scoop install plantuml

# maintenance
scoop update
scoop update *
scoop cache rm *
scoop cleanup *
scoop checkup

pause
