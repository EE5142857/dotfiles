Set-ExecutionPolicy RemoteSigned -scope CurrentUser
if (!(Get-Command * | Where-object {$_.Name -match "scoop"})) {
    iwr -useb get.scoop.sh | iex
}
pause