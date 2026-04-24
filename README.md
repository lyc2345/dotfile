# dotfile

Stan's dotfiles for macOS development environment.

## New Machine Setup

### 1. Clone with submodules

```bash
git clone --recurse-submodules https://github.com/lyc2345/dotfile.git ~/.dotfile
```

If already cloned without submodules:

```bash
cd ~/.dotfile && git submodule update --init --recursive
```

### 2. Install packages

Installs Homebrew (if missing), all Brewfile packages, and zsh plugins:

```bash
~/.dotfile/package-installer/install.sh
```

### 3. Link dotfiles

Creates symlinks from `~/.dotfile` into `$HOME` and `~/.config`:

```bash
~/.dotfile/dotfile-installer/install.sh
```

### 4. Apply macOS settings

Sets keyboard repeat speed, trackpad speed, and other system preferences:

```bash
~/.dotfile/package-installer/setup-macos.sh
```

### 5. Set up local secrets

```bash
cp ~/.dotfile/.zsh/.ai.local.example ~/.zsh/.ai.local
# then fill in GITLAB_USER, GITLAB_TOKEN, AWS_ACCOUNT_ID_AP, etc.
```

## Structure

| Path | Purpose |
|------|---------|
| `dotfile-installer/` | Symlink manager for shell and editor configs |
| `package-installer/` | Homebrew bundle, zsh plugins, macOS settings |
| `.zsh/` | Zsh configuration and functions |
| `.vim/` | Vim configuration |
| `nvim/` | Neovim config (submodule) |
| `wezterm/` | Wezterm config (submodule) |
| `karabiner/` | Karabiner-Elements key mapping |
| `.hammerspoon/` | Hammerspoon automation scripts |
| `ohmyzsh/` | Oh My Zsh (submodule) |
| `powerlevel10k/` | Powerlevel10k theme (submodule) |
