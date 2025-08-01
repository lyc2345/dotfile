
# for editor
[ -n gsed ] && alias vi=vim

# for better sed
[ -n gsed ] && alias sed=gsed

# rm always ask
alias rm -rf='rm -irf'
alias rm -r='rm -ir'

# easy stree . {{{

# need parentheses to keep the current folder
# http://superuser.com/questions/231881/push-pop-current-directory
alias st='stree $(git rev-parse --show-toplevel)'
# }}}
alias gsfp='git submodule foreach --recursive git fetch --prune'
alias gsp='git submodule foreach --recursive git pull'

# aria2
alias wget='aria2c -x 16 -s 16 --retry-wait=1'

# zsh
alias ee="vi ~/.zsh/.zshrc.local"
alias rr="source ~/.zshrc"
alias qq="clear"

# tmuxinator
alias mux="tmuxinator"

# vifm
alias vifm='./.config/vifm/scripts/vifmrun'

# git
alias gs="git status"
alias gfp="git fetch --prune"

alias sj="wine ~/.wine/dosdevices/c:/Program\ Files/Gaea/xianjian/Launcher.exe"

# ls
alias ll='ls -l'
alias lla='ls -al'
alias la='ls -a'
alias l='colorls'
alias lc='colorls -lA --sd'

# set filetype open source
alias egrep="egrep --color=always"

# docker-compose
alias dkc=docker-compose
alias dk=docker

# django
alias pym='(){ python manage.py ;}'

#alias -s gz='tar -xzvf' # automatically exarct file if file name after 'gz'

# Add shortcut for tig --all
alias ta='tig --all'
alias tg='tig'


# Open with Visual-Studio-Code if file's extension belows
alias -s py=code
alias -s txt=code
alias -s yml=code
alias -s rb=code
alias -s go=code
alias -s zsh=vim
alias -s local=vim
alias -s init=vim
alias -s path=vim
alias -s p10k=vim
alias -s sh=vim
alias -s h=vim
alias -s m=vim
alias -s swift=vim

alias du=ncdu

# bundle
alias lpod="bundle exec pod"
alias lfastlane="bundle exec fastlane"

alias pp="prettypath"

if [[ $OSTYPE == darwin* && $CPUTYPE == arm64 ]]; then
  # ARM
  alias brew=/opt/homebrew/bin/brew

  # INTEL
  alias ibrew="arch -x86_64 /usr/local/Homebrew/bin/brew"
  alias ipyenv="arch -x86_64 pyenv"

  # dircolors
  #alias dircolors="/opt/homebrew/Cellar/coreutils/*/libexec/gnubin/dircolors"
  alias dircolors=/opt/Homebrew/bin/gdircolors
else
  # INTEL
  #alias brew=/usr/local/homebrew/bin/brew # no need to alias to the same path
  
  # dircolors
  # use GNU
  #alias ls="/usr/local/opt/coreutils/libexec/gnubin/ls"
  alias dircolors=/usr/local/opt/coreutils/libexec/gnubin/dircolors
fi

alias kubectl="minikube kubectl --"

function homebrew_dump() {
  now=$(date +'%Y%m%d%H%M')
  eval $(brew bundle dump --file ~/.homebrew/Brewfile_"$now")
}
alias brew_bkup=homebrew_dump

