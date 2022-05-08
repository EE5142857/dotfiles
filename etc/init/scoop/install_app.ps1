function global:Install-App ([bool]$do_full_install)
{
    # main
    # scoop install 7zip
    # scoop install git
    # scoop install dark
    # scoop install innounp

    # scoop install neovim
    # scoop install nodejs
    # scoop install postgresql
    # scoop install r
    # scoop install vim
    scoop install gcc
    scoop install ripgrep
    # if ($do_full_install -eq $true) {
    #     scoop install pandoc
    # }

    # extras
    scoop bucket add extras
    # scoop install anaconda3
    scoop install deno
    # scoop install everything
    # scoop install googlechrome
    scoop install plantuml
    # scoop install vscode
    # scoop install winmerge
    # if ($do_full_install -eq $true) {
    #     scoop install android-studio
    # }

    # versions
    # scoop bucket add versions
    # scoop install python39

    # java
    # scoop bucket add java
    # scoop install openjdk

    # reset
    # scoop reset python39

    # maintenance
    scoop update
    scoop update *
    scoop cache rm *
    scoop cleanup *
    scoop checkup

    pause
}
