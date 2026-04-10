function Get-DotfilesRoot {
    return (Split-Path -Parent $PSScriptRoot)
}

function Get-DotfileLinkGroups {
    return [ordered]@{
        Home = @(
            @{ Source = ".gitmessage"; Target = Join-Path $env:USERPROFILE ".gitmessage"; Kind = "File" }
        )
        Config = @(
            # Neovim uses stdpath("config"), which maps to %LOCALAPPDATA%\nvim on Windows.
            @{ Source = "nvim"; Target = Join-Path $env:LOCALAPPDATA "nvim"; Kind = "Directory" },

            # WezTerm supports multi-file configs at $HOME\.config\wezterm\wezterm.lua.
            @{ Source = "wezterm"; Target = Join-Path $env:USERPROFILE ".config\wezterm"; Kind = "Directory" },

            # Keep the same tig config filename used by this repo and macOS.
            @{ Source = ".tigrc"; Target = Join-Path $env:USERPROFILE ".tigrc"; Kind = "File" },

            # Native Windows Vim uses _vimrc and vimfiles.
            @{ Source = ".vimrc"; Target = Join-Path $env:USERPROFILE "_vimrc"; Kind = "File" },
            @{ Source = ".vim"; Target = Join-Path $env:USERPROFILE "vimfiles"; Kind = "Directory" },

            # VSCodeVim requires vim.vimrc.path to be configured. Keep this stable path.
            @{ Source = ".vsvimrc"; Target = Join-Path $env:USERPROFILE ".vsvimrc"; Kind = "File" },

            # Existing .vsvimrc sources ~/.vim/shortcutmap.vim.
            @{ Source = ".vim"; Target = Join-Path $env:USERPROFILE ".vim"; Kind = "Directory" }
        )
        Windows = @(
            @{ Source = ".windows\.bashrc"; Target = Join-Path $env:USERPROFILE ".bashrc"; Kind = "File" },
            @{ Source = ".windows\git-prompt.bash"; Target = Join-Path $env:USERPROFILE "git-prompt.sh"; Kind = "File" },
            @{ Source = ".windows\git-plugin.bash"; Target = Join-Path $env:USERPROFILE "git-plugin.bash"; Kind = "File" },
            @{ Source = ".windows\git-completion.bash"; Target = Join-Path $env:USERPROFILE "git-completion.bash"; Kind = "File" }
        )
    }
}
