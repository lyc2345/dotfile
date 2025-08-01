#
# https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html
#
# give us access to ^Q
stty -ixon

# vi mode
# Time in which two keys have to be pressed in order to be recognized as a
# single command (in centiseconds, set to 0.4 sec by default -- may be
# modified as needed).
export KEYTIMEOUT=20 # default is 40
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode  # bindkey -M viins 'jj' vi-cmd-mode

# handy keybindings
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^k" backward-kill-line
bindkey "^l" kill-line
bindkey "^r" history-incremental-search-backward
bindkey "^p" history-search-backward
bindkey "^y" accept-and-hold                     # Push the contents of the buffer on the buffer stack and execute it.
bindkey "^n" insert-last-word
bindkey "^q" push-line-or-edit
bindkey '^i' complete-word
bindkey -s "^t" "^[Isudo ^[A" # "t" for "toughguy"

# Option-S inserts "sudo " at the start of line:
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
insert_sudo_cmd () { zle beginning-of-line; zle -U "isudo " }
zle -N insert-sudo insert_sudo
zle -N insert-sudo_cmd insert_sudo_cmd
#bindkey -M vicmd "ß" insert-sudo_cmd
bindkey -M vicmd "^[s" insert-sudo_cmd
bindkey -M viins "^[s" insert-sudo

# ctrl j, k to auto-complete from history
#bindkey '^j' history-beginning-search-forward
#bindkey '^k' history-beginning-search-backward

# Incremental search is elite!
# Lono: commandF in iTerm 2 is better
#bindkey -M vicmd "/" history-incremental-search-backward
# Lono:iTerm find text
#sendCommandF () { osascript ~/Dropbox/MacSetting/osxc/iTerm/sendCommandF.applescript }
#zle -N sendCommandF
#bindkey -M vicmd '/'  sendCommandF

# dirhistory {{{
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/dirhistory/dirhistory.plugin.zsh
# }}}

ctrlp() {
  local selected
  if selected=$(find . -type f | grep -v .git | grep -v node_modules | fzf -q "$LBUFFER"); then;
    # put n in front of it to use neovim to open it
    LBUFFER="n $selected"
  fi  ;
  zle redisplay
}
# option-g to find files and put the result in command
zle -N ctrlp
bindkey "\eg" ctrlp

#conflict with ctrlp_line
#insert_n () { zle beginning-of-line; zle -U "n " }
#insert_n_cmd () { zle beginning-of-line; zle -U "in " }
#zle -N insert-n insert_n
#zle -N insert-n_cmd insert_n_cmd
#bindkey -M vicmd "^[f" insert-n_cmd
#bindkey -M viins "^[f" insert-n

# vi mode bindings for system clipboard {{{
# enter vi mode
# This will make ctrl+P, ctrl+N disable
# bindkey -v
# }}}

vi-yank-whole-line-clipboard() {
  zle vi-yank-whole-line
  print -rn -- $CUTBUFFER | pbcopy;
}
zle -N vi-yank-whole-line-clipboard
bindkey -M vicmd 'yy' vi-yank-whole-line-clipboard

vi-yank-end-of-line-clipboard() {
  zle vi-yank-eol
  print -rn -- $CUTBUFFER | pbcopy;
}
zle -N vi-yank-end-of-line-clipboard
bindkey -M vicmd 'Y' vi-yank-end-of-line-clipboard

vi-put-before-clipboard () {
  CUTBUFFER=$(pbpaste)
  zle vi-put-before
}
zle -N vi-put-before-clipboard
bindkey -M vicmd 'P' vi-put-before-clipboard

vi-put-after-clipboard () {
  CUTBUFFER=$(pbpaste)
  zle vi-put-after
}
zle -N vi-put-after-clipboard
bindkey -M vicmd 'p' vi-put-after-clipboard

vi-kill-eol-clipboard () {
  zle vi-kill-eol
  print -rn -- $CUTBUFFER | pbcopy;
}
zle -N vi-kill-eol-clipboard
bindkey -M vicmd 'D' vi-kill-eol-clipboard

vi-kill-line-clipboard () {
  zle vi-kill-line
  print -rn -- $CUTBUFFER | pbcopy;
}
zle -N vi-kill-line-clipboard
bindkey -M vicmd 'dd' vi-kill-line-clipboard

kill-word-clipboard () {
  zle kill-word
  print -rn -- $CUTBUFFER | pbcopy;
}
zle -N kill-word-clipboard
bindkey -M vicmd 'dw' kill-word-clipboard

# }}}


