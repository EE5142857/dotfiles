@echo off

:main
    chcp 65001>nul
    cd /d %~dp0..\..\..

    @REM https://www.takigawa-memo.com/windows-neovim-install/#vim-devicons%E3%82%92%E4%BD%BF%E3%81%88%E3%82%8B%E3%82%88%E3%81%86%E3%81%AB%E3%81%99%E3%82%8B
    git clone --depth 1 https://github.com/ryanoasis/nerd-fonts
    cd nerd-fonts
    fontforge ./font-patcher RictyDiminishedDiscord-Bold.ttf --windows --complete
    fontforge ./font-patcher RictyDiminishedDiscord-BoldOblique.ttf --windows --complete
    fontforge ./font-patcher RictyDiminishedDiscord-Oblique.ttf --windows --complete
    fontforge ./font-patcher RictyDiminishedDiscord-Regular.ttf --windows --complete

    echo Done.
    pause
exit /b

