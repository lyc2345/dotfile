
# p10k {{{

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh

# }}}

# fzf {{{

[ -f ~/.config/.fzf.zsh ] && source ~/.config/.fzf.zsh

# }}}

# initialization {{{

# PYENV {{{

if [ -x "$(command -v pyenv)" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# }}}

# RBENV {{{

if [ -x "$(command -v rbenv)" ]; then
  eval "$(rbenv init -)"
  eval "rbenv shell 3.0.3"
fi

# }}}

# NVM {{{
#
# Because now opt/homebrew/bin/nvm is a script, needs to run nvm.sh at the beginning.
# eval ". $(which nvm)"
#
# }}}

# Nodenv {{{

if [ -x "$(command -v nodenv)" ]; then
  eval "$(nodenv init -)"
  export NODEPATH="$HOME/.nodenv/shims/node"
fi


# }}}

# JENV {{{

if [ -x "$(command -v jenv)" ]; then
  eval "$(jenv init -)"
  eval "jenv shell 11"
fi

# }}}

# }}}

if [ -x "$(command -v thefuck)" ]; then
  eval "$(thefuck --alias)"
fi

# you-should-use
export YSU_MESSAGE_POSITION="after"

# load config {{{

# forgit {{{

#[ -f ~/.zsh/forgit/forgit.plugin.zsh ] && source ~/.zsh/forgit/forgit.plugin.zsh

# }}}
#
# command-not-found {{{

HB_CNF_HANDLER="$(brew --prefix)/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
if [ -f "$HB_CNF_HANDLER" ]; then
    source "$HB_CNF_HANDLER";
fi

# Homebrew env
export HOMEBREW_NO_ENV_HINTS=1


# }}}

# Powerline {{{

#function powerline_precmd() {
#    PS1="$(~/powerline-shell.py $? --shell zsh 2> /dev/null)"
#}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
  install_powerline_precmd
fi

# }}}

# DIR Colors {{{

# https://www.cyberciti.biz/faq/apple-mac-osx-terminal-color-ls-output-option/
#export CLICOLOR=1
#export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
# https://github.com/seebi/dircolors-solarized/issues/10
# export LSCOLORS=exfxfeaeBxxehehbadacea

# LS_COLOR
# https://qiita.com/naoyoshinori/items/68f65032dde46edf89fa
#
# How to fix dircolors command not found
# https://unix.stackexchange.com/questions/91937/mac-os-x-dircolors-not-found
#
# https://www.nordtheme.com/docs/ports/dircolors/installation
#

#if [ -n gdircolors ]; then
#  eval $(gdircolors -b $HOME/.config/nord-dircolors/src/dir_colors)
#fi

[ -x "$(command -v dircolors)" ] && eval $(dircolors "$HOME/.config/dircolors-solarized/dircolors.256dark")
#[ -x "$(command -v dircolors)" ] && eval $(dircolors "$HOME/.config/nord-dircolors/src/dir_colors")

[ -n "$LS_COLORS" ] && zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

#test -e ~/.dircolors && \
#   eval `dircolors -b ~/.dir_colors`
#if [ -n "$LS_COLORS" ]; then
#  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#fi

# }}}

# }}}

# Fig post block. Keep at the bottom of this file.
#. "$HOME/.fig/shell/zshrc.post.zsh"
