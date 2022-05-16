function global:Install-App ([bool]$do_full_install)
{
    # main
    scoop install 7zip
    scoop install grep

    # extras
    scoop bucket add extras
    scoop install deno
    if ($do_full_install -eq $true) {
        scoop install plantuml
    }

    # versions
    # scoop bucket add versions

    # java
    if ($do_full_install -eq $true) {
        scoop bucket add java
        scoop install openjdk
    }

    # maintenance
    scoop update
    scoop update *
    scoop cache rm *
    scoop cleanup *
    scoop checkup

    pause
}
