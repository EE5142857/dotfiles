if (!(Get-Command * | Where-object {$_.Name -match "scoop"})) {
    Set-ExecutionPolicy RemoteSigned -scope CurrentUser
    iwr -useb get.scoop.sh | iex
}

# main
scoop install 7zip
scoop install git
scoop install innounp
scoop install dark

# extras
scoop bucket add extras

# maintenance
scoop update
scoop update *
scoop cache rm *
scoop cleanup *
scoop checkup
pause
