
# git {{{

# don't use the gc (git commit -v) in git plugin
#unalias gc

# fbrr - checkout git branch (including remote branches)
#fbrr() {
#    local branches branch
#    branches=$(git branch --all | grep -v HEAD) &&
#    branch=$(echo "$branches" | fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
#    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
#}

# fbr - checkout git branch (including remote branches)
# fbr() {
  # local branches branch
  # branches=$(git branch --all | grep -v HEAD) &&
  # branch=$(echo "$branches" |
           # fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  # git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
# }

# fco - checkout git branch/tag
fco() {
    local tags branches target
    tags=$(
        git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
    branches=$(
        git branch --all | grep -v HEAD |
        sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
        sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
    target=$(
        (echo "$tags"; echo "$branches") |
        fzf-tmux -d 50% -- --no-hscroll --ansi +m -d "\t" -n 2) || return
    git checkout $(echo "$target" | awk '{print $2}')
    # -d 50% is for tmux split-pane or in a tmux popup window IF you're on a tmux session.
    # --ansi tells fzf to extract and parse ANSI color code in the input
}

# fcoc - checkout git commit
fcoc() {
    local commits commit
    commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
    commit=$(echo "$commits" | fzf --tac +s +m -e) &&
    git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow - git commit browser
fshow() {
    local out sha q
    while out=$(
        git log --decorate=short --graph --oneline --color=always |
        fzf --ansi --multi --no-sort --reverse --query="$q" --print-query); do
        q=$(head -1 <<< "$out")
        while read sha; do
            [ -n "$sha" ] && git show --color=always $sha | less -R
        done < <(sed '1d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
    done
}

# fcs - get git commit sha
# example usage: git rebase -i `fcs`
fcs() {
    color_highlight='\x1b[33;1m'
    color_default='\x1b[1;37m'
    local commits commit sha
    commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
    commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse) &&
    sha=$(echo "$commit" | awk '{print $1}')
    echo "$sha" | pbcopy
    echo "${color_highlight}$sha ${color_default}copied."
}

# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
# fzf show stash content
fstash() {
  local out q k sha

  while out=$(
      git stash list --pretty="%C(yellow)%gd %C(blue)%h %>(14)%Cgreen%cr %C(white)%gs" |
      fzf --ansi --no-sort --query="$q" --print-query \
          --expect=ctrl-d,ctrl-a
  );

  do
      IFS=$'\n'; set -f
      lines=($(<<< "$out"))
      unset IFS; set +f
      q="${lines[0]}"
      k="${lines[1]}"
      stash="${lines[-1]}"
      # stash = 'stash@{1} fc83d5f    3 hours ago On 2juvh5p_redemption_code_dapp2: local-config'
      selector="${stash%% *}" # 刪除從左數來第一個空白及右邊全部，得到 stash@{1}
      sha="${stash#* }" # 刪除從左邊開始至空白，得到 'fc83d5f    3 hours ago On 2juvh5p_redemption_code_dapp2: local-config'
      sha="${sha%% *}"  # 刪除從左數來第一個空白及右邊全部

      [[ -z "$sha" || -z "$selector" ]] && continue

      if [[ "$k" == 'ctrl-d' ]]; then
          if ask "Do you want to pop stash: ${stash}?\n${color_warning}Confirm" ; then
              git stash pop $selector;
              echo "$stash deleted."
              break;
          fi
          break;
      elif [[ "$k" == 'ctrl-a' ]]; then
          git stash apply $selector;
          break;
      else
          git -c color.ui=always stash show -p $sha | less -+F
      fi
  done
}

function gfix() {
    vi -p `git diff --name-only | sort | uniq`
}

function git-fixup () {
  git ll -n 20 | fzf | cut -f 1 | xargs git commit --no-verify --fixup
}

fadd() {
    local out q n addfiles
    while out=$(
        git status --short |
        awk '{if (substr($0,2,1) !~ / /) print $2}' |
        fzf --multi --color=dark --cycle --border --ansi --exit-0 --expect=ctrl-d --preview-window=up:70% --preview='git diff --color {+1}'); do
        q=$(head -1 <<< "$out")
        n=$[$(wc -l <<< "$out") - 1]
        addfiles=(`echo $(tail "-$n" <<< "$out")`)
        [[ -z "$addfiles" ]] && continue
        if [ "$q" = ctrl-d ]; then
            git diff --color=always $addfiles | less -R
        else
            git add $addfiles
        fi
    done
}

# To search branch or tag by using fzf and return a result
fzf-git-ref() {
    color_default='\x1b[1;37m';
    color_warning='\x1b[1;31m';
    color_tag='\x1b[33;1m';
    color_branch='\x1b[34;1m';
    color_command='\x1b[1;37m';

    local tags branches target type name final;
    branches=$(
        git branch --all | grep -v HEAD             |
        sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
        sort -u          | awk '{print "\x1b[34;1mBranch\x1b[m\t" $1}') || return;
    tags=$(
        git tag | awk '{print "\x1b[33;1mTag\x1b[m\t" $1}') || return;

    target=$(
        (echo "$tags"; echo "$branches") |
        fzf-tmux -d 50% -- --no-hscroll --ansi +m -d "\t" -n 2
        ) || return;

    type=$(echo "$target" | awk '{ print $1 }')
    name=$(echo "$target" | awk '{ print $2 }')
    final="$type|$name"
    echo "$final" # echo is used for returning value
    return 0      # return 0 means function executed successfully
}

# fdd = git delete force
fdd() {
    color_default='\x1b[1;37m'
    color_warning='\x1b[1;31m'
    color_tag='\x1b[33;1m'
    color_branch='\x1b[34;1m'
    color_command='\x1b[1;37m'

    target=`fzf-git-ref` # catch output from echo $final
    return_code="$?"

    if [ "$return_code" -ne 0 ]; then
        echo "aborted! ($return_code)"
        return "$return_code"
    fi

    target=$(print -r -- ${target//|/ }) # replace | with space

    type=$(echo "$target" | awk '{print $1}')
    name=$(echo "$target" | awk '{print $2}') || 

    if [ $(echo "$type" | awk '{print tolower($0)}') = 'branch' ]; then
        selected_color='\x1b[34;1m'
    fi
    if [ $(echo "$type" | awk '{print tolower($0)}') = 'tag' ]; then
        selected_color='\x1b[33;1m'
    fi

    if ask "${color_default}Do you want to delete local ${selected_color}${type} ${color_default}'${name}'?\n${color_warning}Confirm" ; then
        echo "${color_default}"
        if [ $(echo "$type" | awk '{print tolower($0)}') = 'branch' ]; then
            git branch -d -f $name
        fi
        if [ $(echo "$type" | awk '{print tolower($0)}') = 'tag' ]; then
            git tag -d $name
        fi
        ## status_code 0 is success
        #if [ $status_code -eq 0 ]; then
        #    echo "${color_default}Remote ${selected_color}${type} ${color_default}'${name}'${color_warning} is deleted."
        #else
        #    echo "${color_default}fail to delete ${selected_color}${type} ${color_default}'${name}'${color_warning}, reason: $result"
        #fi
    fi
}

# fddp = git delete remote ref
fddp() {
    color_default='\x1b[1;37m'
    color_warning='\x1b[1;31m'
    color_tag='\x1b[33;1m'
    color_branch='\x1b[34;1m'
    color_command='\x1b[1;37m'

    target=`fzf-git-ref` # catch output from echo $final
    return_code="$?"

    if [ "$return_code" -ne 0 ]; then
        echo "aborted! ($return_code)"
        return "$return_code"
    fi

    target=$(print -r -- ${target//|/ }) # replace | with space
    type=$(echo "$target" | awk '{print $1}')
    name=$(echo "$target" | awk '{print $2}')

    selected_color='\x1b[34;1m'
    if [ $(echo "$type" | awk '{print tolower($0)}') = 'branch' ]; then
        selected_color='\x1b[34;1m'
    fi
    if [ $(echo "$type" | awk '{print tolower($0)}') = 'tag' ]; then
        selected_color='\x1b[33;1m'
    fi

    if ask "${color_default}Do you want to delete remote ${selected_color}${type} ${color_default}'${name}'?\n${color_warning}Confirm" ; then
        echo "${color_default}"
        git push origin -d $name
        #result=$? # store command $(git push origin -d $target) as variable 'reulst'
    fi
}

# }}}


# Git version checking
autoload -Uz is-at-least
git_version="${${(As: :)$(git version 2>/dev/null)}[3]}"

#
# Functions Current
# (sorted alphabetically by function name)
# (order should follow README)
#

# Check for develop and similarly named branches
function git_develop_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local branch
  for branch in dev devel develop development; do
    if command git show-ref -q --verify refs/heads/$branch; then
      echo $branch
      return 0
    fi
  done

  echo develop
  return 1
}

# Get the default branch name from common branch names or fallback to remote HEAD
function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  
  local remote ref
  
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,stable,master}; do
    if command git show-ref -q --verify $ref; then
      echo ${ref:t}
      return 0
    fi
  done
  
  # Fallback: try to get the default branch from remote HEAD symbolic refs
  for remote in origin upstream; do
    ref=$(command git rev-parse --abbrev-ref $remote/HEAD 2>/dev/null)
    if [[ $ref == $remote/* ]]; then
      echo ${ref#"$remote/"}; return 0
    fi
  done

  # If no main branch was found, fall back to master but return error
  echo master
  return 1
}

function grename() {
  if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: $0 old_branch new_branch"
    return 1
  fi

  # Rename branch locally
  git branch -m "$1" "$2"
  # Rename branch in origin remote
  if git push origin :"$1"; then
    git push --set-upstream origin "$2"
  fi
}

#
# Functions Work in Progress (WIP)
# (sorted alphabetically by function name)
# (order should follow README)
#

# Similar to `gunwip` but recursive "Unwips" all recent `--wip--` commits not just the last one
function gunwipall() {
  local _commit=$(git log --grep='--wip--' --invert-grep --max-count=1 --format=format:%H)

  # Check if a commit without "--wip--" was found and it's not the same as HEAD
  if [[ "$_commit" != "$(git rev-parse HEAD)" ]]; then
    git reset $_commit || return 1
  fi
}

# Warn if the current branch is a WIP
function work_in_progress() {
  command git -c log.showSignature=false log -n 1 2>/dev/null | grep -q -- "--wip--" && echo "WIP!!"
}

#
# Aliases
# (sorted alphabetically by command)
# (order should follow README)
# (in some cases force the alias order to match README, like for example gke and gk)
#

alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'

function ggpnp() {
  if [[ $# == 0 ]]; then
    ggl && ggp
  else
    ggl "${*}" && ggp "${*}"
  fi
}
compdef _git ggpnp=git-checkout

alias ggpur='ggu'
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gau='git add --update'
alias gav='git add --verbose'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'
alias gam='git am'
alias gama='git am --abort'
alias gamc='git am --continue'
alias gamscp='git am --show-current-patch'
alias gams='git am --skip'
alias gap='git apply'
alias gapt='git apply --3way'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsn='git bisect new'
alias gbso='git bisect old'
alias gbsr='git bisect reset'
alias gbss='git bisect start'
alias gbl='git blame -w'
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbD='git branch --delete --force'

function gbda() {
  git branch --no-color --merged | command grep -vE "^([+*]|\s*($(git_main_branch)|$(git_develop_branch))\s*$)" | command xargs git branch --delete 2>/dev/null
}

# Copied and modified from James Roeder (jmaroeder) under MIT License
# https://github.com/jmaroeder/plugin-git/blob/216723ef4f9e8dde399661c39c80bdf73f4076c4/functions/gbda.fish
function gbds() {
  local default_branch=$(git_main_branch)
  (( ! $? )) || default_branch=$(git_develop_branch)

  git for-each-ref refs/heads/ "--format=%(refname:short)" | \
    while read branch; do
      local merge_base=$(git merge-base $default_branch $branch)
      if [[ $(git cherry $default_branch $(git commit-tree $(git rev-parse $branch\^{tree}) -p $merge_base -m _)) = -* ]]; then
        git branch -D $branch
      fi
    done
}

alias gbgd='LANG=C git branch --no-color -vv | grep ": gone\]" | cut -c 3- | awk '"'"'{print $1}'"'"' | xargs git branch -d'
alias gbgD='LANG=C git branch --no-color -vv | grep ": gone\]" | cut -c 3- | awk '"'"'{print $1}'"'"' | xargs git branch -D'
alias gbm='git branch --move'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'
alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
alias gbg='LANG=C git branch -vv | grep ": gone\]"'
alias gco='git checkout'
alias gcor='git checkout --recurse-submodules'
alias gcb='git checkout -b'
alias gcB='git checkout -B'
alias gcd='git checkout $(git_develop_branch)'
alias gcm='git checkout $(git_main_branch)'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gclean='git clean --interactive -d'
alias gcl='git clone --recurse-submodules'
alias gclf='git clone --recursive --shallow-submodules --filter=blob:none --also-filter-submodules'

function gccd() {
  setopt localoptions extendedglob

  # get repo URI from args based on valid formats: https://git-scm.com/docs/git-clone#URLS
  local repo="${${@[(r)(ssh://*|git://*|ftp(s)#://*|http(s)#://*|*@*)(.git/#)#]}:-$_}"

  # clone repository and exit if it fails
  command git clone --recurse-submodules "$@" || return

  # if last arg passed was a directory, that's where the repo was cloned
  # otherwise parse the repo URI and use the last part as the directory
  [[ -d "$_" ]] && cd "$_" || cd "${${repo:t}%.git/#}"
}
compdef _git gccd=git-clone

alias gcam='git commit --all --message'
alias gcas='git commit --all --signoff'
alias gcasm='git commit --all --signoff --message'
alias gcs='git commit --gpg-sign'
alias gcss='git commit --gpg-sign --signoff'
alias gcssm='git commit --gpg-sign --signoff --message'
alias gcmsg='git commit --message'
alias gcsm='git commit --signoff --message'
alias gc='git commit --verbose'
alias gca='git commit --verbose --all'
alias gca!='git commit --verbose --all --amend'
alias gcan!='git commit --verbose --all --no-edit --amend'
alias gcans!='git commit --verbose --all --signoff --no-edit --amend'
alias gcann!='git commit --verbose --all --date=now --no-edit --amend'
alias gc!='git commit --verbose --amend'
alias gcn='git commit --verbose --no-edit'
alias gcn!='git commit --verbose --no-edit --amend'
alias gcf='git config --list'
alias gcfu='git commit --fixup'
alias gdct='git describe --tags $(git rev-list --tags --max-count=1)'
alias gd='git diff'
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gds='git diff --staged'
alias gdw='git diff --word-diff'

function gdv() { git diff -w "$@" | view - }
compdef _git gdv=git-diff

alias gdup='git diff @{upstream}'

function gdnolock() {
  git diff "$@" ":(exclude)package-lock.json" ":(exclude)*.lock"
}
compdef _git gdnolock=git-diff

alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gf='git fetch'
# --jobs=<n> was added in git 2.8
is-at-least 2.8 "$git_version" \
  && alias gfa='git fetch --all --tags --prune --jobs=10' \
  || alias gfa='git fetch --all --tags --prune'
alias gfo='git fetch origin'
alias gg='git gui citool'
alias gga='git gui citool --amend'
alias ghh='git help'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glods='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --date=short'
alias glod='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"'
alias glola='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'
alias glols='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --stat'
alias glol='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'
alias glo='git log --oneline --decorate'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'

# Pretty log messages
function _git_log_prettily(){
  if ! [ -z $1 ]; then
    git log --pretty=$1
  fi
}
compdef _git _git_log_prettily=git-log

alias glp='_git_log_prettily'
alias glg='git log --stat'
alias glgp='git log --stat --patch'
alias gignored='git ls-files -v | grep "^[[:lower:]]"'
alias gfg='git ls-files | grep'
alias gm='git merge'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gms="git merge --squash"
alias gmff="git merge --ff-only"
alias gmom='git merge origin/$(git_main_branch)'
alias gmum='git merge upstream/$(git_main_branch)'
alias gmtl='git mergetool --no-prompt'
alias gmtlvim='git mergetool --no-prompt --tool=vimdiff'

alias gl='git pull'
alias gpr='git pull --rebase'
alias gprv='git pull --rebase -v'
alias gpra='git pull --rebase --autostash'
alias gprav='git pull --rebase --autostash -v'

function ggu() {
  local b
  [[ $# != 1 ]] && b="$(git_current_branch)"
  git pull --rebase origin "${b:-$1}"
}
compdef _git ggu=git-pull

alias gprom='git pull --rebase origin $(git_main_branch)'
alias gpromi='git pull --rebase=interactive origin $(git_main_branch)'
alias gprum='git pull --rebase upstream $(git_main_branch)'
alias gprumi='git pull --rebase=interactive upstream $(git_main_branch)'
alias ggpull='git pull origin "$(git_current_branch)"'

function ggl() {
  if [[ $# != 0 ]] && [[ $# != 1 ]]; then
    git pull origin "${*}"
  else
    local b
    [[ $# == 0 ]] && b="$(git_current_branch)"
    git pull origin "${b:-$1}"
  fi
}
compdef _git ggl=git-pull

alias gluc='git pull upstream $(git_current_branch)'
alias glum='git pull upstream $(git_main_branch)'
alias gp='git push'
alias gpd='git push --dry-run'

function ggf() {
  local b
  [[ $# != 1 ]] && b="$(git_current_branch)"
  git push --force origin "${b:-$1}"
}
compdef _git ggf=git-push

alias gpf!='git push --force'
is-at-least 2.30 "$git_version" \
  && alias gpf='git push --force-with-lease --force-if-includes' \
  || alias gpf='git push --force-with-lease'

function ggfl() {
  local b
  [[ $# != 1 ]] && b="$(git_current_branch)"
  git push --force-with-lease origin "${b:-$1}"
}
compdef _git ggfl=git-push

alias gpsup='git push --set-upstream origin $(git_current_branch)'
is-at-least 2.30 "$git_version" \
  && alias gpsupf='git push --set-upstream origin $(git_current_branch) --force-with-lease --force-if-includes' \
  || alias gpsupf='git push --set-upstream origin $(git_current_branch) --force-with-lease'
alias gpv='git push --verbose'
alias gpoat='git push origin --all && git push origin --tags'
alias gpod='git push origin --delete'
alias ggpush='git push origin "$(git_current_branch)"'

function ggp() {
  if [[ $# != 0 ]] && [[ $# != 1 ]]; then
    git push origin "${*}"
  else
    local b
    [[ $# == 0 ]] && b="$(git_current_branch)"
    git push origin "${b:-$1}"
  fi
}
compdef _git ggp=git-push

alias gpu='git push'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase --interactive'
alias grbo='git rebase --onto'
alias grbs='git rebase --skip'
alias grbd='git rebase $(git_develop_branch)'
alias grbm='git rebase $(git_main_branch)'
alias grbom='git rebase origin/$(git_main_branch)'
alias grbum='git rebase upstream/$(git_main_branch)'
alias grf='git reflog'
alias gr='git remote'
alias grv='git remote --verbose'
alias gra='git remote add'
alias grrm='git remote remove'
alias grmv='git remote rename'
alias grset='git remote set-url'
alias grup='git remote update'
alias grh='git reset'
alias gru='git reset --'
alias grhh='git reset --hard'
alias grhk='git reset --keep'
alias grhs='git reset --soft'
alias gpristine='git reset --hard && git clean --force -dfx'
alias gwipe='git reset --hard && git clean --force -df'
alias groh='git reset origin/$(git_current_branch) --hard'
alias grs='git restore'
alias grss='git restore --source'
alias grst='git restore --staged'
alias gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q "\--wip--" && git reset HEAD~1'
alias grev='git revert'
alias greva='git revert --abort'
alias grevc='git revert --continue'
alias grm='git rm'
alias grmc='git rm --cached'
alias gcount='git shortlog --summary --numbered'
alias gsh='git show'
alias gsps='git show --pretty=short --show-signature'
alias gstall='git stash --all'
alias gstaa='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
# use the default stash push on git 2.13 and newer
is-at-least 2.13 "$git_version" \
  && alias gsta='git stash push' \
  || alias gsta='git stash save'
alias gsts='git stash show --patch'
alias gst='git status'
alias gss='git status --short'
alias gsb='git status --short --branch'
alias gsi='git submodule init'
alias gsu='git submodule update'
alias gsd='git svn dcommit'
alias git-svn-dcommit-push='git svn dcommit && git push github $(git_main_branch):svntrunk'
alias gsr='git svn rebase'
alias gsw='git switch'
alias gswc='git switch --create'
alias gswd='git switch $(git_develop_branch)'
alias gswm='git switch $(git_main_branch)'
alias gta='git tag --annotate'
alias gts='git tag --sign'
alias gtv='git tag | sort -V'
alias gignore='git update-index --assume-unchanged'
alias gunignore='git update-index --no-assume-unchanged'
alias gwch='git log --patch --abbrev-commit --pretty=medium --raw'
alias gwt='git worktree'
alias gwta='git worktree add'
alias gwtls='git worktree list'
alias gwtmv='git worktree move'
alias gwtrm='git worktree remove'
alias gstu='gsta --include-untracked'
alias gtl='gtl(){ git tag --sort=-v:refname -n --list "${1}*" }; noglob gtl'
alias gk='\gitk --all --branches &!'
alias gke='\gitk --all $(git log --walk-reflogs --pretty=%h) &!'

unset git_version

# Logic for adding warnings on deprecated aliases or functions
local old_name new_name
for old_name new_name (
  current_branch  git_current_branch
); do
  aliases[$old_name]="
    print -Pu2 \"%F{yellow}[oh-my-zsh] '%F{red}${old_name}%F{yellow}' is deprecated, using '%F{green}${new_name}%F{yellow}' instead.%f\"
    $new_name"
done
unset old_name new_name
