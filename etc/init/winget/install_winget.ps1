function global:Install-Winget ([bool]$do_full_install)
{
    winget install Anaconda.Anaconda3
    winget install Google.AndroidStudio
    winget install voidtools.Everything
    winget install Google.Chrome
    winget install Git.Git
    winget install Neovim.Neovim
    winget install vim.vim
    winget install OpenJS.NodeJS
    winget install ojdkbuild.openjdk.17.jdk
    winget install JohnMacFarlane.Pandoc
    winget install PostgreSQL.PostgreSQL
    if ($do_full_install -eq $true) {
    }
    # maintenance
    scoop update
    scoop update *
    scoop cache rm *
    scoop cleanup *
    scoop checkup

    pause
}
