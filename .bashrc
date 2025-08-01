# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/bashrc.pre.bash" ]] && builtin source "$HOME/.fig/shell/bashrc.pre.bash"
# ** Difference between .bashrc and .bash_profile? **
#
# .bash_profile is executed for login shells,
# while .bashrc is executed for interactive non-login shells.
#
# When you login (type username and password) via console, either sitting at the machine,
# or remotely via ssh: .bash_profile is executed to configure your shell before the initial command prompt.
#
# But, if you’ve already logged into your machine and open a new terminal window (xterm) then
# .bashrc is executed before the window command prompt.
# .bashrc is also run when you start a new bash instance by typing /bin/bash in a terminal.
#
# On OS X, Terminal by default runs a login shell every time,
# so this is a little different to most other systems, but you can configure that in the preferences.
#
# Basically, we can source .bashrc in .bash_profile so that we don't need to maintain
# both .bashrc and .bash_profile
#
# export PS1="\W\$ "

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# For powerline
#function _update_ps1() {
#    PS1="$(~/powerline-shell.py $? 2> /dev/null)"
#}

#if [ "$TERM" != "linux" ]; then
#    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
#fi

bind "set completion-ignore-case on"

# bash_completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

[ -f ~/.config/.fzf.bash ] && source ~/.config/.fzf.bash

export CLICOLOR=1
eval $(gdircolors -b $HOME/.config/.dircolors)

# git-flow alias
alias gf='git-flow'
alias g='git'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias xcl='rm -rf ~/Library/Developer/Xcode/DerivedData'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/stan/Downloads/google-cloud-sdk/path.bash.inc' ]; then
  source '/Users/stan/Downloads/google-cloud-sdk/path.bash.inc';
fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/stan/Downloads/google-cloud-sdk/completion.bash.inc' ]; then
  source '/Users/stan/Downloads/google-cloud-sdk/completion.bash.inc';
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

[[ -f "$HOMW/.bin/tmuxinator.bash" ]] && source "$HOMW/.bin/tmuxinator.bash"

# toggle shell to zsh
#zsh

# Environment initialization
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="$HOME/.config/ripgrep/rg.exe:$PATH"
export PATH="$HOME/.config/fd/fd.exe:$PATH"
eval "$(pyenv init -)"


# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/bashrc.post.bash" ]] && builtin source "$HOME/.fig/shell/bashrc.post.bash"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
