# Dotfile Installer

This folder installs dotfile links only. It does not install packages.

## macOS

Run from the dotfile repo root:

```bash
./dotfile-installer/install.sh
```

Uninstall managed symlinks:

```bash
./dotfile-installer/uninstall.sh
```

If you still have the old legacy symlink `~/.config -> ~/.dotfile/.config`, re-running `install.sh` will replace that symlink with a real `~/.config` directory before linking managed app configs like `nvim` and `wezterm`.

## Windows

PowerShell does not automatically run scripts from the current directory. Use `.\script.ps1`, or call PowerShell with `-File`.

Install managed links:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\dotfile-installer\install-windows.ps1
```

Uninstall managed links:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\dotfile-installer\uninstall-windows.ps1
```

If `%USERPROFILE%\.config` is still a legacy link to the repo `.config` folder, re-running `install-windows.ps1` will replace that legacy link with a real `%USERPROFILE%\.config` directory before linking managed app configs.

If you are in `dotfile-installer`, use:

```powershell
.\install-windows.ps1
.\uninstall-windows.ps1
```

From Git Bash, either call PowerShell explicitly:

```bash
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./dotfile-installer/install-windows.ps1
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./dotfile-installer/uninstall-windows.ps1
```

or use the cmd wrappers:

```bash
cmd.exe /c dotfile-installer\\install-windows.cmd
cmd.exe /c dotfile-installer\\uninstall-windows.cmd
```

## Windows Link Targets

The Windows mappings are defined in `windows-links.ps1`.

- `nvim` -> `%LOCALAPPDATA%\nvim`
- `wezterm` -> `%USERPROFILE%\.config\wezterm`
- `.tigrc` -> `%USERPROFILE%\.tigrc`
- `.vimrc` -> `%USERPROFILE%\_vimrc`
- `.vim` -> `%USERPROFILE%\vimfiles`
- `.vsvimrc` -> `%USERPROFILE%\.vsvimrc`
- `.windows\.bashrc` -> `%USERPROFILE%\.bashrc`

The default mode uses directory junctions and file hard links. Use `-LinkMode Copy` if you want copied files instead of links.
