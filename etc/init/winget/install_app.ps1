function global:Install-App ([bool]$do_full_install)
{
    winget install --id Anaconda.Anaconda3
    winget install --id Git.Git
    winget install --id Google.Chrome
    winget install --id Microsoft.VisualStudioCode
    winget install --id OpenJS.NodeJS
    winget install --id PostgreSQL.PostgreSQL
    winget install --id Python.Python.3
    winget install --id RProject.R
    winget install --id WinMerge.WinMerge
    winget install --id ojdkbuild.openjdk.17.jdk
    winget install --id voidtools.Everything
    if ($do_full_install -eq $true) {
        winget install --id Google.AndroidStudio
        winget install --id JohnMacFarlane.Pandoc
        winget install --id Neovim.Neovim
        winget install --id vim.vim
    }

    pause
}
